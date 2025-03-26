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
        ('projector', 'Projector'),
        ('microphone', 'Microphone'),
        ('whiteboard', 'Whiteboard'),
        ('computer', 'Computer'),
        ('speaker_system', 'Speaker System'),
    ]

    name = models.CharField(max_length=20, unique=True)
    capacity = models.IntegerField()
    room_type = models.CharField(max_length=20, choices=ROOM_TYPES)  # Stores whether it's a tutorial room or a lecture room
    accessories = models.JSONField(default=dict)  # Store accessories as a dictionary (e.g., {"projector": True, "microphone": False})
    price_per_hour = models.IntegerField()

    def __str__(self):
        return f"{self.name} ({self.get_room_type_display()})"

class Booking(models.Model):
    #DONT DELETE BOOKINGS WHEN USER DELETED
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled'), #delete instead 
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
    approval_token = models.CharField(max_length=36, unique=True, default=uuid.uuid4, editable=False)
    token_expiry = models.DateTimeField(default=timezone.now() + timedelta(days=2))

    def __str__(self):
        return f"{self.creator.username} - {self.room.name} ({self.status})"
    