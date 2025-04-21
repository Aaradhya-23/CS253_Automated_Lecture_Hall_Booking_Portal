from django.contrib.auth import get_user_model
from django.db import models
import uuid
from django.utils import timezone
from datetime import timedelta

User = get_user_model()
class Room(models.Model):
    ROOM_TYPES = [
        ('tutorial', 'Tutorial Block Room'),
        ('lecture_hall', 'Lecture Hall Room'),
    ]

    ACCESSORY_OPTIONS = [
        4,
    ]

    name = models.CharField(max_length=20, unique=True)
    capacity = models.IntegerField()
    room_type = models.CharField(max_length=20, choices=ROOM_TYPES)  # Stores whether it's a tutorial room or a lecture room
    accessories = models.JSONField(default=dict)  # Store accessories as a dictionary (e.g., {"projector": True, "microphone": False})
    price_per_hour = models.IntegerField()

    def __str__(self):
        return f"{self.name} ({self.get_room_type_display()})"



from django.utils import timezone
from urllib.parse import quote



class Booking(models.Model):
    #DONT DELETE BOOKINGS WHEN USER DELETED
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('completed', 'Completed'),
        ('rejected', 'Rejected')
    ]
    TYPE_CHOICES = [
        ('academic', 'Academic'),
        ('nonacademic', 'Nonacademic')
    ]

    creator = models.ForeignKey(User, on_delete=models.DO_NOTHING, related_name='bookings')
    title = models.CharField(max_length=100)
    Type = models.CharField(max_length = 20, choices = TYPE_CHOICES, default = 'nonacademic')
    room = models.ForeignKey(Room, on_delete=models.DO_NOTHING)
    start_time = models.TimeField()
    end_time = models.TimeField()
    booking_date = models.DateField()
    requested_on = models.DateTimeField(auto_now_add=True)
    duration = models.FloatField(default= 0.0)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    accessories = models.JSONField(default=dict, blank=True)
    cost = models.PositiveBigIntegerField(default=0)
    remarks = models.CharField(max_length= 150, null = True, blank = True)
    booking_token = models.CharField(max_length=36, unique=True, default=uuid.uuid4, editable=False)
    token_expiry = models.DateTimeField(default=timezone.now() + timedelta(days=2))

    #for mulitple authorities
    approvals_pending = models.JSONField(default=dict)
    authority_tokens = models.JSONField(default=dict)

    def __str__(self):
        return f"{self.creator.username} - {self.room.name} ({self.status})"
    
    def get_google_calendar_link(self):
        # Combine event_date + start_time into a full datetime
        start_datetime = timezone.make_aware(
            timezone.datetime.combine(self.booking_date, self.start_time)
        ).strftime("%Y%m%dT%H%M%SZ")

        end_datetime = timezone.make_aware(
            timezone.datetime.combine(self.booking_date, self.end_time)
        ).strftime("%Y%m%dT%H%M%SZ")

        # URL-encode fields
        event_title = quote(self.title)
        location = f'IIT-Kanpur, Lecture Hall Complex, {self.room.name}'
        event_location = location
        event_description = quote("")

        # Generate Google Calendar URL
        return (
             f"https://www.google.com/calendar/render?action=TEMPLATE"
        f"&text={quote(event_title)}"
        f"&dates={start_datetime}/{end_datetime}"
        f"&details={quote(event_description)}"
        f"&location={quote(event_location)}"
        f"&sprop=name:{quote('IIT-Kanpur, LHC Office')}"
        )
    
class Holiday(models.Model):
    date = models.DateField(unique=True)
    name = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.name} ({self.date})"