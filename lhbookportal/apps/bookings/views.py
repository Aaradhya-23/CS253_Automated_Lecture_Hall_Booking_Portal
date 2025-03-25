import os
from django.contrib.auth import get_user_model
from rest_framework import generics, authentication, permissions, mixins, filters
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
from reportlab.pdfgen import canvas
from io import BytesIO
from rest_framework.views import APIView
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from reportlab.lib import colors
import csv
from datetime import time, datetime, timedelta

class DownloadBillPDF(APIView):
    permission_classes = [BookingPermissions]
    def get(self, request, booking_id):
        # Get booking data (replace with your actual query)
        booking = get_object_or_404(Booking, id=booking_id)
        
        
        # Create PDF buffer
        data = {
            "booking_ref" : str(booking.id),
            "event_name": booking.title,
            "date": str(booking.booking_date),
            "time": str(booking.start_time),
            "hall_name": booking.room.name,
            "booked_by": booking.creator.username,
            "charges": str(booking.cost),
        }
        buffer = generate_bill(data)
        response = HttpResponse(buffer, content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="bill_booking_{booking.id}.pdf"'
        return response
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
        return Booking.objects.filter(user=self.request.user).order_by('-requested_on')


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
    permission_classes = [IsAdmin]  # Restrict access to authenticated users
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
# Create your views here.




class RoomSearchView(generics.ListAPIView):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]

    # Exact field filters
    filterset_fields = [
        'room_type',  # Filter by room type (tutorial or lecture_hall)
        'has_ac',     # Filter by AC availability
        'has_board',  # Filter by board availability
        'has_projector',  # Filter by projector availability
        'capacity',   # Filter by capacity
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
            (Q(start_time__lt=booking.end_time)&Q(start_time__gt=booking.start_time)) | 
            (Q(end_time__gt=booking.start_time)&Q(end_time__lt=booking.end_time))
    ).exclude(status='cancelled')  # Exclude cancelled bookings

    if(pending_bookings_same_slot.exists()):
        for pending in pending_bookings_same_slot:
            pending.status = 'rejected'
            pending.save()
            send_mail(
            'Booking Rejected',
            f'Sorry, your booking request titled "{pending.title}" at {pending.room.name} for date {pending.booking_date} has been rejected.',
            settings.DEFAULT_FROM_EMAIL,
            [ pending.creator.email ],
        )  
        
    
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
    booking.save()

    # if not booking.is_token_valid() or booking.token_expiry < timezone.now():
    #     return JsonResponse({"error": "Token expired or invalid"}, status=400)
    # Send email to user
    send_mail(
        'Booking Rejected',
        f'Sorry, your booking request titled "{booking.title}" at {booking.room.name} for date {booking.booking_date} has been rejected.',
        settings.DEFAULT_FROM_EMAIL,
        [ booking.creator.email ],
    )

    return HttpResponse("Booking rejected successfully!, You may close this page now")




def generate_bill(data):
    buffer = BytesIO()
    c = canvas.Canvas(buffer, pagesize=letter)
    width, height = letter
    
    # --- HEADER WITH LOGO ---
    # Add IIT-Kanpur logo (you'll need to have the image file)
    logo_path = ".resources/images.png"  # Replace with actual path or ensure file exists
    if os.path.exists(logo_path):
        c.drawImage(logo_path, 265, height - 90, width=1.1*inch, height=1.1*inch, preserveAspectRatio=True)
    
    # Add "Lecture Hall Office" text beside logo
    c.setFont("Helvetica-Bold", 14)
    c.drawCentredString(width/2, height - 110, "Lecture Hall Office")
    c.setFont("Helvetica", 10)
    # c.drawString(100 + 1.6*inch, height - 110, "Indian Institute of Technology Kanpur")
    
    # Centered main heading
    c.setFont("Helvetica-Bold", 16)
    c.drawCentredString(width/2, height - 130, "BOOKING DETAILS")
    
    # Horizontal line below heading
    c.setStrokeColor(colors.black)
    c.line(100, height - 140, width - 100, height - 140)
    
    # --- BODY CONTENT ---
    y_position = height - 170
    
    # Booking Information
    c.setFont("Helvetica-Bold", 12)
    c.drawString(100, y_position, "Booking Reference:")
    c.setFont("Helvetica", 12)
    c.drawString(220, y_position, data['booking_ref'])
    y_position -= 25
    
    c.setFont("Helvetica-Bold", 12)
    c.drawString(100, y_position, "Event Name:")
    c.setFont("Helvetica", 12)
    c.drawString(220, y_position, data['event_name'])
    y_position -= 25
    
    c.setFont("Helvetica-Bold", 12)
    c.drawString(100, y_position, "Date:")
    c.setFont("Helvetica", 12)
    c.drawString(220, y_position, data['date'])
    y_position -= 25
    
    c.setFont("Helvetica-Bold", 12)
    c.drawString(100, y_position, "Time:")
    c.setFont("Helvetica", 12)
    c.drawString(220, y_position, data['time'])
    y_position -= 25
    
    c.setFont("Helvetica-Bold", 12)
    c.drawString(100, y_position, "Hall:")
    c.setFont("Helvetica", 12)
    c.drawString(220, y_position, data['hall_name'])
    y_position -= 25
    
    c.setFont("Helvetica-Bold", 12)
    c.drawString(100, y_position, "Booked By:")
    c.setFont("Helvetica", 12)
    c.drawString(220, y_position, data['booked_by'])
    y_position -= 40
    
    # Charges table
    c.setFont("Helvetica-Bold", 12)
    c.drawString(100, y_position, "Charges:")
    c.setFont("Helvetica", 12)
    c.drawString(220, y_position, data["charges"])
    y_position -= 20
    
    
    
    
    # --- FOOTER ---
    footer_y = 50
    c.setStrokeColor(colors.black)
    c.line(100, footer_y + 20, width - 100, footer_y + 20)
    
    c.setFont("Helvetica", 10)
    c.drawCentredString(width/2, footer_y, "Lecture Hall Office, IIT Kanpur - Tel: 0512-259XXXX")
    
    c.save()
    buffer.seek(0)
    return buffer





def download_daily_schedule_csv(request, date):
    # Get date from query parameters (default to today)
    # date_str = request.GET.get('date')
    date_str = date
    try:
        if date_str:
            schedule_date = datetime.strptime(date_str, '%Y-%m-%d').date()
        else:
            schedule_date = datetime.now().date()
    except ValueError:
        return HttpResponse("Invalid date format. Use YYYY-MM-DD", status=400)

    # Create the HTTP response with CSV header
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = f'attachment; filename="room_schedule_{schedule_date}.csv"'

    writer = csv.writer(response)
    
    # Generate time slots from 8:00 AM to 8:00 PM in 30-minute intervals
    start_time = time(8, 0)
    end_time = time(20, 0)
    time_slots = []
    current_time = datetime.combine(schedule_date, start_time)
    end_datetime = datetime.combine(schedule_date, end_time)
    
    while current_time <= end_datetime:
        time_slots.append(current_time.time())
        current_time += timedelta(minutes=30)

    # Get all rooms and active bookings for the day
    rooms = Room.objects.all().order_by('name')
    bookings = Booking.objects.filter(
        booking_date=schedule_date,
        status__in=['approved', 'completed']
    )

    # Write header row
    header = ['Time Slot'] + [room.name for room in rooms]
    writer.writerow(header)

    # For each time slot, check room availability
    for slot_start in time_slots:
        slot_end = (datetime.combine(schedule_date, slot_start) + timedelta(minutes=30)).time()
        row = [f"{slot_start.strftime('%H:%M')}-{slot_end.strftime('%H:%M')}"]
        
        for room in rooms:
            # Check if room is booked during this time slot
            booking = bookings.filter(
                room=room,
                start_time__lt=slot_end,
                end_time__gt=slot_start
            ).first()
            
            if booking:
                row.append(f"{booking.title}")
            else:
                row.append("")
        
        writer.writerow(row)
    # response.content = b"download will start........"
    return response