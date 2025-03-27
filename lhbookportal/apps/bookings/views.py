import os
from django.contrib.auth import get_user_model
from rest_framework import generics, mixins, filters, status
from django_filters.rest_framework import DjangoFilterBackend
from .models import *
from django.http import JsonResponse
from rest_framework.permissions import IsAuthenticated
from .serializers import *
from .permissions import *
from django.utils.timezone import now
from rest_framework.throttling import UserRateThrottle
User = get_user_model()
from django.core.mail import send_mail
from django.urls import reverse
from django.conf import settings
from django.shortcuts import get_object_or_404
from django.http import HttpResponse
from rest_framework.views import APIView

# <<<<<<< HEAD

from datetime import time, datetime, timedelta
from .models import Holiday

# from datetime import timedelta, datetime
# from django.utils import timezone
from rest_framework.response import Response
# from rest_framework import generics, status
# from .models import Booking, Room
# from .serializers import BookingSerializer

class AvailableBookingSlotsView(generics.GenericAPIView):
    def post(self, request, *args, **kwargs):
        booking_date = request.data.get("booking_date")  # YYYY-MM-DD
        start_time = request.data.get("start_time")  # HH:MM
        end_time = request.data.get("end_time")  # HH:MM
        duration = int(request.data.get("duration", 1))  # Duration in hours

        # Room preferences
        room_id = request.data.get("room")  # Optional
        capacity = int(request.data.get("capacity", 1))  # Minimum capacity
        need_projector = request.data.get("need_projector", False)
        need_blackboard = request.data.get("need_blackboard", False)
        need_ac = request.data.get("need_ac", False)

        # Validate input
        if not booking_date or not start_time or not end_time:
            return Response({"error": "booking_date, start_time, and end_time are required."}, status=status.HTTP_400_BAD_REQUEST)

        # Convert times to datetime objects
        start_time = datetime.strptime(start_time, "%H:%M").time()
        end_time = datetime.strptime(end_time, "%H:%M").time()
        booking_date = datetime.strptime(booking_date,"%Y-%m-%d" )

        if start_time >= end_time:
            return Response({"error": "end_time must be later than start_time."}, status=status.HTTP_400_BAD_REQUEST)

        # Ensure booking is not on a holiday (every Sunday)
        holidays = Holiday.objects.filter(date=booking_date)
        if booking_date.weekday() == 6 or (holidays.exists()):  # Sunday
            return Response({"error": "Bookings cannot be made on Holidays"}, status=status.HTTP_400_BAD_REQUEST)

        # Get all available rooms that match the criteria
        if room_id:
            rooms = Room.objects.filter(id=room_id)
        else:
            rooms = Room.objects.filter(
                capacity__gte=capacity,
                has_projector=need_projector,
                has_board=need_blackboard,
                has_ac=need_ac,
            )

        if not rooms.exists():
            return Response({"error": "No rooms match the given criteria."}, status=status.HTTP_400_BAD_REQUEST)

        available_slots = []

        # Loop through each matching room to find available slots
        slot_id = 1
        for room in rooms:
            current_time = timezone.datetime.strptime(request.data.get("start_time"), "%H:%M")
            end_time_limit = timezone.datetime.strptime(request.data.get("end_time"), "%H:%M")

            while current_time + timedelta(hours=duration) <= end_time_limit:
                overlapping_bookings = Booking.objects.filter(
                    room=room,
                    booking_date=booking_date,
                    start_time__lt=current_time + timedelta(hours=duration),
                    end_time__gt=current_time
                ).exists()
                
                

                if not overlapping_bookings:
                    available_slots.append({
                        "slot_id" : slot_id,
                        "room_id": room.id,
                        "room_name": room.name,
                        "room.price" : room.price_per_hour,
                        "start_time": current_time.strftime("%H:%M"),
                        "end_time": (current_time + timedelta(hours=duration)).strftime("%H:%M")
                    })
                    slot_id = slot_id + 1

                # Move in 30-minute intervals to find more slots
                current_time += timedelta(minutes=30)

        if not available_slots:
            return Response({"error": "No available slots found."}, status=status.HTTP_400_BAD_REQUEST)

        return Response({"available_slots": available_slots}, status=status.HTTP_200_OK)





# =======
# class DownloadBillPDF(APIView):
#     permission_classes = [BookingPermissions]
#     def get(self, request, booking_id):
#         # Get booking data (replace with your actual query)
#         booking = get_object_or_404(Booking, id=booking_id)
        
        
#         # Create PDF buffer
#         data = {
#             "booking_ref" : str(booking.id),
#             "event_name": booking.title,
#             "date": str(booking.booking_date),
#             "time": str(booking.start_time),
#             "hall_name": booking.room.name,
#             "booked_by": booking.creator.username,
#             "charges": str(booking.cost),
#         }
#         buffer = generate_bill(data)
#         response = HttpResponse(buffer, content_type='application/pdf')
#         response['Content-Disposition'] = f'attachment; filename="bill_booking_{booking.id}.pdf"'
#         return response
    
# >>>>>>> 98fb2e50128397a925b7dd759eaafdfdcb8d3d1b
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
    permission_classes = [BookingPermissions]  # Restrict access to authenticated users
    throttle_classes  = [UserRateThrottle]
    
    def perform_create(self, serializer):
        print(self.request.data)
        user = self.request.user
        # Access validated data from the serializer
        validated_data = serializer.validated_data
        room = validated_data['room']  # Access the room object directly
        duration = validated_data['duration']
        

        # Determine Type and status based on user role
        Type = validated_data.get('Type')
        status = 'pending'

        if user.role != 'admin':
            Type = 'academic' if user.role == 'faculty' else 'nonacademic'

        status = 'approved' if user.role == 'admin' else 'pending'

        if Type == 'academic':
            status = 'approved'

        # Calculate cost
        cost = room.price_per_hour * duration
        user.total_bill = user.total_bill + cost
        user.save()
        requested_on = timezone.now()
        
        booking = serializer.save(
            creator=user,
            status=status,
            Type=Type,
            requested_on=requested_on,
            cost=cost
        )
        if(user.role == 'faculty'):return 
        
        #send mails only for students 
        # approve_url = f"{settings.SITE_URL}{reverse('approve_booking', kwargs={'token': booking.approval_token})}"
        # reject_url = f"{settings.SITE_URL}{reverse('reject_booking', kwargs={'token': booking.approval_token})}"
        approve_url = self.request.build_absolute_uri(reverse('approve-booking', args=[booking.approval_token]))
        reject_url = self.request.build_absolute_uri(reverse('reject-booking', args=[booking.approval_token]))

        # Send email to the authority
        subject = "[LHC OFFICE]Booking Request Approval Needed"
        message = f"""
        A new booking request has been submitted by {user.username}.

        Purpose :     {booking.title}
        Remarks :     {booking.remarks}
        Room:         {room.name}
        Requested On: {requested_on}
        
        
        Approve: {approve_url}
        Reject: {reject_url}
        
        Note : un-approved bookings will be auto-rejected in 2 days or less
        """
        #add more mails in the list if needed
        #right now only one is supported 
        send_mail(subject, message, settings.DEFAULT_FROM_EMAIL, ['567rahulm567@gmail.com'])
        # Save the booking
    # GET: List all bookings or retrieve a specific booking
    def get(self, request, *args, **kwargs):
        if "pk" in kwargs:
            return self.retrieve(request, *args, **kwargs)
        return self.list(request, *args, **kwargs)

    # POST: Create a new booking
    def post(self, request, *args, **kwargs):
        # print(*args)
        return self.create(request, *args, **kwargs)

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
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]

    # Exact field filters
    filterset_fields = ['status', 'Type', 'room', 'creator']

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
        serializer.save()

    def perform_update(self, serializer):
        """Custom logic before updating an existing Room."""
        serializer.save()

    # GET: List all rooms or retrieve a specific room
    def get(self, request, *args, **kwargs):
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
    
def approve_booking(request, token):
    booking = get_object_or_404(Booking, approval_token=token)
    if not booking or booking.token_expiry < timezone.now():return JsonResponse({"error": "Token expired or invalid"}, status=400)
    if booking.status != 'pending': return JsonResponse({"error": "This booking is not available for approval"}, status=400)
    booking.status = 'approved'
    booking.save()
    
    #if a pending requets is there for the same slot rooom. reject that booking
    pending_bookings_same_slot = Booking.objects.filter(
            Q(room=booking.room.id)&
            Q(booking_date=booking.booking_date)&
            Q(start_time__lt=booking.end_time, end_time__gt=booking.start_time) 
    )  # Exclude cancelled bookings

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
        
    
    # if booking.creator.role == 'student':
    x = f'Your bill amount is : {booking.cost}'
    # print(type([booking.creator.email]))
    # Send email to user
    send_mail(
        'Booking Approved',
        f"""
        Your booking request titled {booking.title} at {booking.room.name} for date {booking.booking_date} has been approved.
        {x}
        """
        ,
        settings.DEFAULT_FROM_EMAIL,
        [booking.creator.email]
    )

    return HttpResponse("Booking approved successfully!, You many close this page now")

def reject_booking(request, token):
    booking = get_object_or_404(Booking, approval_token = token)
    if booking.status != 'pending': return JsonResponse({"error": "Token expired or invalid"}, status=400)

    if not booking or booking.token_expiry < timezone.now():return JsonResponse({"error": "Token expired or invalid"}, status=400)

    booking.status = 'rejected'

    # if not booking.is_token_valid() or booking.token_expiry < timezone.now():
    #     return JsonResponse({"error": "Token expired or invalid"}, status=400)
    # Send email to user
    send_mail(
        'Booking Rejected',
        f'Sorry, your booking request titled "{booking.title}" at {booking.room.name} for date {booking.booking_date} has been rejected.',
        settings.DEFAULT_FROM_EMAIL,
        [ booking.creator.email ],
    )

    booking.delete()
    return HttpResponse("Booking rejected successfully!, You may close this page now")




