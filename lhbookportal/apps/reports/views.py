from rest_framework.decorators import api_view, permission_classes
from apps.accounts.models import *
from rest_framework.permissions import AllowAny
from apps.bookings.models import *
import os
from django.contrib.auth import get_user_model
User = get_user_model()
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
from .permissions import DownloadPermissions
from datetime import time, datetime, timedelta
from apps.bookings.permissions import BookingPermissions

# from datetime import timedelta, datetime
# from django.utils import timezone

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status, permissions
from .models import Feedback
from .serializers import FeedbackSerializer

class CreateFeedbackView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        # print(request.data.get('rating'))
        serializer = FeedbackSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user) 
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class DownloadBillPDF(APIView):
    queryset = Booking.objects.all()
    permission_classes = [DownloadPermissions]
    def get(self, request, booking_id):
        # Get booking data (replace with your actual query)
        booking = get_object_or_404(Booking, id=booking_id)
        self.check_object_permissions(request, booking)
        
        # Create PDF buffer
        data = {
            "booking_ref" : str(booking.id),
            "event_name": booking.title,
            "date": str(booking.booking_date),
            "time": str(booking.start_time),
            "hall_name": booking.room.name,
            "booked_by": booking.creator.username,
            "charges": str(booking.cost),
            "duration" : str(booking.duration),
            "remarks" : (booking.remarks)
        }
        buffer = generate_bill(data)
        response = HttpResponse(buffer, content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="bill_booking_{booking.id}.pdf"'
        return response
# Create your models here.

def generate_bill(data):
    buffer = BytesIO()
    c = canvas.Canvas(buffer, pagesize=letter)
    width, height = letter
    
    # --- HEADER WITH LOGO ---
    # Add IIT-Kanpur logo (you'll need to have the image file)
    logo_path = "apps/reports/images.png"  # Replace with actual path or ensure file exists
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
    c.drawString(100, y_position, "Duration:")
    c.setFont("Helvetica", 12)
    c.drawString(220, y_position, data['duration'])
    y_position -= 25
    
    c.setFont("Helvetica-Bold", 12)
    c.drawString(100, y_position, "Hall:")
    c.setFont("Helvetica", 12)
    c.drawString(220, y_position, data['hall_name'])
    y_position -= 25
    
    # c.setFont("Helvetica-Bold", 12)
    # c.drawString(100, y_position, "Remarks:")
    # c.setFont("Helvetica", 12)
    # c.drawString(220, y_position, data['remarks'])
    # y_position -= 25
    
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




@permission_classes([AllowAny])
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
# Create your views here.
