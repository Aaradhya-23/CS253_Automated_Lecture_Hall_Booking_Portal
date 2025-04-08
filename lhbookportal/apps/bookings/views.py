import os
from django.contrib.auth import get_user_model
from rest_framework import generics, mixins, filters, status
from django_filters.rest_framework import DjangoFilterBackend
from .models import *
from django.shortcuts import render
import json
from django.http import JsonResponse
from rest_framework.permissions import IsAuthenticated
from .serializers import *
from .permissions import *
from django.utils.timezone import now
from rest_framework.throttling import UserRateThrottle
User = get_user_model()
from django.core.mail import send_mail
from django.urls import reverse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
from django.shortcuts import get_object_or_404
from django.http import HttpResponse
from rest_framework.views import APIView
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from reportlab.lib import colors
import csv
from rest_framework.response import Response
from rest_framework import status
from datetime import time, datetime, timedelta
from rest_framework.permissions import AllowAny
import threading




class EmailThread(threading.Thread):
    def __init__(self, subject, message, from_email, recipient_list, *args, **kwargs):
        self.subject = subject
        self.message = message
        self.from_email = from_email
        self.recipient_list = recipient_list
        super().__init__(*args, **kwargs)

    def run(self):
        send_mail(
            self.subject,
            self.message,
            self.from_email,
            self.recipient_list,
            fail_silently=False,
        )
def send_email_in_background(subject, message, from_email, recipient_list):
    EmailThread(subject, message, from_email, recipient_list).start()

@csrf_exempt
def send_rejection_mail(request, booking_id):
    if request.method != "POST":
        return JsonResponse({"error": "Invalid request method"}, status=405)
    
    try:
        data = json.loads(request.body)
        remarks = data.get("remark", "")

        if not remarks:
            return JsonResponse({"error": "Remarks are required"}, status=400)

        # Get the booking object
        booking = get_object_or_404(Booking, id=booking_id)
        booking.status = 'rejected'

        # Compose the email content
        subject = 'Booking Rejected'
        message = (
            f'Sorry, your booking request titled "{booking.title}" at {booking.room.name} '
            f'for date {booking.booking_date} has been rejected by LECTURE HALL ADMINISTRATION.\n'
            f'Remarks: {remarks}'
        )
        from_email = settings.DEFAULT_FROM_EMAIL
        recipient_list = [booking.creator.email]

        # Send the email in the background
        send_email_in_background(subject, message, from_email, recipient_list)

        # Delete the booking
        booking.delete()
        return JsonResponse({"message": "Deleted successfully"}, status=204)

    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON format"}, status=400)
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)


class AvailableBookingSlotsView(generics.GenericAPIView):
    permission_classes = [AllowAny]
    def post(self, request, *args, **kwargs):
        # Extract data from request
        booking_date = request.data.get("booking_date")  # YYYY-MM-DD
        start_time = request.data.get("start_time")  # HH:MM:SS
        end_time = request.data.get("end_time")  # HH:MM:SS
        # duration = int(request.data.get("duration", 1))  # Default: 1 hour

        # Validate input
        if not booking_date or not start_time or not end_time:
            return JsonResponse(
                {"error": "booking_date, start_time, and end_time are required."},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Convert string to date/time objects
        try:
            booking_date = datetime.strptime(booking_date, "%Y-%m-%d").date()
            start_time = datetime.strptime(start_time, "%H:%M:%S").time()
            end_time = datetime.strptime(end_time, "%H:%M:%S").time()
        except ValueError:
            return JsonResponse(
                {"error": "Invalid date/time format."},
                status=status.HTTP_400_BAD_REQUEST
            )

        if start_time >= end_time:
            return JsonResponse(
                {"error": "end_time must be later than start_time."},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Ensure booking is not on a holiday (every Sunday)
        if booking_date.weekday() == 6 or Holiday.objects.filter(date=booking_date).exists():
            return JsonResponse(
                {"error": "Bookings cannot be made on Holidays"},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Find booked room IDs that overlap with the requested slot
        booked_room_ids = Booking.objects.filter(
            booking_date=booking_date,
            start_time__lt=end_time,
            end_time__gt=start_time
        ).values_list("room_id", flat=True)  # Get booked room IDs

        # Get available rooms
        available_rooms = Room.objects.exclude(id__in=booked_room_ids)

        if not available_rooms.exists():
            return JsonResponse(
                {"error": "No available rooms for this slot found."},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Serialize and return response
        serializer = RoomSerializer(available_rooms, many=True)
        return Response({"rooms": serializer.data}, status=status.HTTP_200_OK)
    
def send_approval_email(authority_email, booking):
    authority_token = booking.authority_tokens.get(authority_email)
    if not authority_token:
        return  # Safety check

    accessories_list = [
        name.replace('_', ' ').title()
        for name, selected in booking.accessories.items() if selected
    ]
    accessories_str = ', '.join(accessories_list) if accessories_list else 'None'

    approval_link = (
        f"http://127.0.0.1:8000/bookings/approve/?booking_token={booking.booking_token}"
        f"&authority_token={authority_token}"
    )
    rejection_link = (
        f"http://127.0.0.1:8000/bookings/reject/?booking_token={booking.booking_token}"
        f"&authority_token={authority_token}"
    )

    user = booking.creator
    subject = "[LHC OFFICE] Booking Request Approval Needed"
    message = f"""
A new booking request has been submitted by {user.username}.

Purpose    : {booking.title}
Remarks    : {booking.remarks}
Room       : {booking.room.name}
Date       : {booking.booking_date}
Time       : {booking.start_time} - {booking.end_time}
Requested On: {booking.requested_on}
Accessories: {accessories_str}
Total Cost : ₹{booking.cost}

Approve: {approval_link}
Reject:  {rejection_link}

Note: Unapproved bookings will be auto-rejected in 2 days or less.
    """

    send_email_in_background(
        subject,
        message,
        from_email="no-reply@yourdomain.com",
        recipient_list=[authority_email]
    )

class BookingCRUDView(
    generics.GenericAPIView, 
    mixins.ListModelMixin, 
    mixins.CreateModelMixin, 

    mixins.RetrieveModelMixin, 
    mixins.UpdateModelMixin, 
    mixins.DestroyModelMixin
):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer
    # authentication_classes = []
    permission_classes = [IsAuthenticated]  # Restrict access to authenticated users
    throttle_classes  = [UserRateThrottle]
    
    
    def post(self, request, *args, **kwargs):
        print("this is post", self.request.data)
        serializer = self.get_serializer(data=request.data)
        
        if serializer.is_valid():
            self.perform_create(serializer)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        print("data", serializer.data)
        print("Validation failed with errors:", serializer.errors)  # Add this line to debug errors
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def perform_create(self, serializer):
        print("this is creation", self.request.data)
        validated_data = serializer.validated_data  
        print("Validated Data:", validated_data)  # Debugging step
        user = self.request.user  # Default to the logged-in user


        # Determine Type and status based on user role
        Type = validated_data.get('Type', 'nonacademic')
        status = 'pending'

        if user.role != 'admin':
            Type = 'academic' if user.role == 'faculty' else 'nonacademic'
        status = 'approved' if user.role == 'admin' else 'pending'

        admin_is_booking = False;
        if self.request.user.role == 'admin': admin_is_booking = True 
        
        user = get_object_or_404(User, username=self.request.data['user'])

        print("Validated Data:after changing user", validated_data)    
        print(user)  
        serializer.save(creator=user)  # Ensure user is saved
        title = validated_data['title']
        room = validated_data['room']
        duration = validated_data['duration']
        start_time = validated_data['start_time']
        end_time = validated_data['end_time']
        booking_date = validated_data['booking_date']
        accessories = validated_data.get('accessories', {})
        remarks = validated_data.get('remarks', '')
        # creator =

        # Validate accessories availability
        unavailable_accessories = [
            accessory for accessory, selected in accessories.items()
            if selected and not room.accessories.get(accessory, False)
        ]

        if unavailable_accessories:
            raise serializers.ValidationError(
                f"The following accessories are not available in {room.name}: {', '.join(unavailable_accessories)}"
            )

        if Type == 'academic':
            status = 'approved'

        # Calculate cost
        base_cost = room.price_per_hour * duration
        accessory_cost = sum(
            (room.accessories.get(accessory, 0) and 100) for accessory in accessories if accessories[accessory]
        )
        # price is fixed 100 for each accessory
        total_cost = base_cost + accessory_cost

        # Update user's total bill
        user.total_bill += total_cost
        user.save()

        requested_on = timezone.now()
        # booking_token = {auth.email: str(uuid.uuid4())}
        # Save the booking
        if user.role == 'faculty' or admin_is_booking:
            booking = serializer.save(
                creator=user,
                title=title,  # Ensure title is saved
                room=room,
                start_time=start_time,
                end_time=end_time,
                booking_date=booking_date,
                booking_token = str(uuid.uuid4()),
                status=status,
                Type=Type,
                requested_on=requested_on,
                cost=total_cost,
                accessories=accessories,
                remarks=remarks,
            )  
            #send mail
            calender_link = booking.get_google_calendar_link()
            send_email_in_background(
            'Booking Approved',
            f"""
            Your booking request titled {booking.title} at {booking.room.name} for date {booking.booking_date} has been approved.
            Your bill amount is : ₹{booking.cost}
            
            
            Add This Event to your Calender: {calender_link}
            """,
            settings.DEFAULT_FROM_EMAIL,
            [booking.creator.email]
            )
            send_email_in_background(
        subject="[LHC OFFICE] Booking Details",
        message=f"""

User       : {booking.creator.username}
Purpose    : {booking.title}
Remarks    : {booking.remarks}
Room       : {booking.room.name}
Date       : {booking.booking_date}
Time       : {booking.start_time} - {booking.end_time}
Requested On: {booking.requested_on}
Total Cost : ₹{booking.cost}

""",
        from_email="no-reply@yourdomain.com",
        recipient_list=["bhavya0525@gmail.com"], #accounts email to be addeded
    )
            return  # Skip email for faculty
        
        
        authorities = user.authorities.order_by('userauthority__order')
        approvals_pending = {auth.email: False for auth in authorities}
        authority_tokens = {auth.email: str(uuid.uuid4()) for auth in authorities}
        
        print(user)
        print(authorities)
        print(approvals_pending)
        print(authority_tokens)
        booking = serializer.save(
            creator=user,
            title=title,  # Ensure title is saved
            room=room,
            start_time=start_time,
            end_time=end_time,
            booking_date=booking_date,
            status=status,
            Type=Type,
            booking_token = str(uuid.uuid4()),
            authority_tokens = authority_tokens,
            requested_on=requested_on,
            cost=total_cost,
            accessories=accessories,
            approvals_pending=approvals_pending,
            remarks=remarks,
        )
        first_authority_email = next(iter(booking.approvals_pending.keys()), None)
        
        
        if first_authority_email:
            send_approval_email(first_authority_email, booking)

            # return render(request, "bookings/Confirmed.html", status=200)

    def get(self, request, *args, **kwargs):
        if "pk" in kwargs:
            return self.retrieve(request, *args, **kwargs)
        return self.list(request, *args, **kwargs)

    # PUT/PATCH: Update an existing booking
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def patch(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)

    # DELETE: Delete a booking
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)


#example
# Search by title	/api/bookings/search/?search=math
# Filter by status	/api/bookings/search/?status=approved
# Filter by room	/api/bookings/search/?room=2
# Sort by start time	/api/bookings/search/?ordering=start_time
# Reverse sort by start time	/api/bookings/search/?ordering=-start_time
class BookingSearchView(generics.ListAPIView):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer
    permission_classes = [AllowAny]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]

    # Exact field filters
    filterset_fields = ['status', 'Type', 'room', 'creator', 'booking_date']

    # Full-text search fields
    search_fields = ['title', 'room__name', 'creator__username']

    # Sorting options
    ordering_fields = ['start_time', 'end_time', 'requested_on']
    ordering = ['-start_time']  # Default sorting (latest bookings first)

class UserBookingHistoryView(generics.ListAPIView):
    serializer_class = BookingSerializer
    permission_classes = [IsAuthenticated]  # Only authenticated users can see their history

    def get_queryset(self):
        """Return only the bookings of the logged-in user"""
        return Booking.objects.filter(creator=self.request.user).order_by('-requested_on')


class RoomCRUDView(
    generics.GenericAPIView, 
    mixins.ListModelMixin, 
    mixins.CreateModelMixin, 
    mixins.RetrieveModelMixin, 
    mixins.UpdateModelMixin, 
    mixins.DestroyModelMixin
):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer
    permission_classes = [BookingPermissions]  # Restrict access to authenticated users
    throttle_classes  = [UserRateThrottle]

    def perform_create(self, serializer):
        """Set custom behavior before saving a new Room."""
        accessories_data = self.request.data.get('accessories', {})
        validated_accessories = self.validate_accessories(accessories_data)
        serializer.save(accessories=validated_accessories)

    def perform_update(self, serializer):
        """Custom logic before updating an existing Room."""
        accessories_data = self.request.data.get('accessories', {})
        validated_accessories = self.validate_accessories(accessories_data)
        serializer.save(accessories=validated_accessories)

    def validate_accessories(self, accessories_data):
        """Validate accessories to ensure correct input."""
        valid_accessories = {key: value for key, value in accessories_data.items() if key in dict(Room.ACCESSORY_OPTIONS)}
        return valid_accessories

    # GET: List all rooms or retrieve a specific room
    def get(self, request, *args, **kwargs):
        print("this is the get part in room views ", request.headers.get('Authorization'))
        if "pk" in kwargs:
            return self.retrieve(request, *args, **kwargs)
        return self.list(request, *args, **kwargs)

    # POST: Create a new room
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)

    # PUT/PATCH: Update an existing room
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def patch(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)

    # DELETE: Delete a room
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)


class RoomSearchView(generics.ListAPIView):
    # queryset = Room.objects.all()
    serializer_class = RoomSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    
    # Exact field filters
    filterset_fields = [
        'room_type',  # Filter by room type (tutorial or lecture_hall)
        'has_ac',     # Filter by AC availability
        'has_board',  # Filter by board availability
        'has_projector',  # Filter by projector availability
   # Filter by capacity
        'price_per_hour',  # Filter by price per hour
    ]

    # Full-text search fields
    search_fields = [
        'name',  # Search by room name
    ]

    # Dynamic filtering for accessories
    def get_queryset(self):
        queryset = Room.objects.all()
        for accessory in dict(Room.ACCESSORY_OPTIONS):
            if self.request.query_params.get(accessory) == 'true':
                queryset = queryset.filter(**{f'accessories__{accessory}': True})
        return queryset

    # Sorting options
    ordering_fields = [
        'name',           # Sort by room name
        'capacity',       # Sort by capacity
        'price_per_hour', # Sort by price per hour
    ]
    ordering = ['name']  # Default sorting (alphabetical by room name)
    
    def get_queryset(self):
        queryset = Room.objects.all()
        capacity = self.request.query_params.get('capacity', None)
        if capacity is not None:
            try:
                capacity = int(capacity)
                queryset = queryset.filter(capacity__gte=capacity)
            except ValueError:
                pass  # Ignore invalid capacity values
        return queryset
    

from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
@api_view(['GET'])
@permission_classes([AllowAny])
def approve_booking(request):
    
    booking_token = request.GET.get("booking_token")
    authority_token = request.GET.get("authority_token")

    if not booking_token or not authority_token:
        return JsonResponse({"error": "Invalid or missing approval token."}, status=400)

    booking = get_object_or_404(Booking, booking_token=booking_token)
    #added 
    if not booking or booking.token_expiry < timezone.now():return JsonResponse({"error": "Token expired or invalid"}, status=400)
    if booking.status != 'pending': return JsonResponse({"error": "This booking is not available for approval"}, status=400)


    #if a pending requets is there for the same slot rooom. reject that booking
    pending_bookings_same_slot = Booking.objects.filter(
            Q(room=booking.room.id)&
            Q(booking_date=booking.booking_date)&
            Q(start_time__lt=booking.end_time, end_time__gt=booking.start_time) 
    )  # Exclude cancelled bookings


    authority_email = next(
        (email for email, token in booking.authority_tokens.items() if token == authority_token),
        None
    )

    if not authority_email or booking.status in ["Approved", "Rejected"]:
        return render(request, "bookings/Booking Processed.html", context={"status" : booking.status}, status=200)

    if booking.approvals_pending.get(authority_email, False):
        return render(request, "bookings/AlreadyApproved.html", context={}, status=200)

    # Mark the approval
    booking.approvals_pending[authority_email] = True
    booking.save()

    if all(booking.approvals_pending.values()):
        # All authorities have approved the booking
        booking.status = "Approved"
        booking.decision_time = timezone.now()
        booking.save()

        x = f'Your bill amount is : {booking.cost}'
        # print(type([booking.creator.email]))
        # Send email to user
        calender_link = booking.get_google_calendar_link()
        send_email_in_background(
    'Booking Approved',
    f"""
    Your booking request titled {booking.title} at {booking.room.name} for date {booking.booking_date} has been approved.
    Your bill amount is : ₹{booking.cost}
    
    Add this Booking to your calender
    {calender_link}
    """,
    settings.DEFAULT_FROM_EMAIL,
    [booking.creator.email]
)
        send_email_in_background(
        subject="[LHC OFFICE] Booking Details",
        message=f"""

User       : {booking.creator.username}
Purpose    : {booking.title}
Remarks    : {booking.remarks}
Room       : {booking.room.name}
Date       : {booking.booking_date}
Time       : {booking.start_time} - {booking.end_time}
Requested On: {booking.requested_on}
Total Cost : ₹{booking.cost}

""",
        from_email="no-reply@yourdomain.com",
        recipient_list=["bhavya0525@gmail.com"], #accounts email to be addeded
    )
        if(pending_bookings_same_slot.exists()):
            for pending in pending_bookings_same_slot:
                if pending.status == 'pending':
                    pending.status = 'rejected'
                    send_mail(
                    'Booking Rejected',
                    f'Sorry, your booking request titled "{pending.title}" at {pending.room.name} for date {pending.booking_date} has been rejected.',
                    settings.DEFAULT_FROM_EMAIL,
                    [ pending.creator.email ],
                )  
                    pending.delete()


        return render(request, "bookings/Confirmed.html", context={}, status=200)

    next_approver_email = next((email for email, approved in booking.approvals_pending.items() if not approved), None)
    if next_approver_email:
        send_approval_email(next_approver_email, booking)

    return render(request, "bookings/Approved.html", context={}, status=200)


def reject_booking(request):
    booking_token = request.GET.get("booking_token")
    authority_token = request.GET.get("authority_token")

    if not booking_token or not authority_token:
        return JsonResponse({"error" : "Invalid or missing rejection token."}, status=400)

    booking = get_object_or_404(Booking, booking_token=booking_token)
    if booking.status != 'pending': return JsonResponse({"error": "Token expired or invalid"}, status=400)
    if not booking or booking.token_expiry < timezone.now():return JsonResponse({"error": "Token expired or invalid"}, status=400)

    authority_name = next(
        (name for name, token in booking.authority_tokens.items() if token == authority_token),
        None
    )

    if booking.status in ["Approved", "Rejected"]:
        return render(request, "bookings/Booking Processed.html", context={"status":booking.status}, status=200)

    booking.status = "Rejected"
    booking.approvals_pending = {}
    booking.save()

    send_email_in_background(
    'Booking Rejected',
    f'Sorry, your booking request titled "{booking.title}" at {booking.room.name} for date {booking.booking_date} has been rejected.',
    settings.DEFAULT_FROM_EMAIL,
    [booking.creator.email],
)

    booking.delete()
    return render(request, "bookings/Rejected.html", context={}, status=200);

