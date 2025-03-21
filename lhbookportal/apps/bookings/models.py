from django.contrib.auth import get_user_model
from django.db import models

User = get_user_model()
class Room(models.Model):
    TUTORIAL = 'tutorial'
    LECTURE = 'lecture_hall'

    ROOM_TYPES = [
        (TUTORIAL, 'Tutorial Block Room'),
        (LECTURE, 'Lecture Hall Room'),
    ]

    number = models.PositiveSmallIntegerField(unique=True)
    capacity = models.IntegerField()
    room_type = models.CharField(max_length=20, choices=ROOM_TYPES)  # Stores whether it's a tutorial room or a lecture room
    has_ac = models.BooleanField(default= False)
    has_board = models.BooleanField(default= False)
    has_projector = models.BooleanField(default= False)
    price_per_hour = models.IntegerField()

    def __str__(self):
        return f"{self.number} ({self.get_room_type_display()})"


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
    room = models.ForeignKey(Room, on_delete=models.CASCADE, related_name='bookings')
    booking_date = models.DateField()
    start_time = models.PositiveSmallIntegerField()
    end_time = models.PositiveIntegerField()
    requested_on = models.DateTimeField()
    duration = models.PositiveSmallIntegerField()
    cost = models.PositiveBigIntegerField()
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')

    def __str__(self):
        return f"{self.creator.username} - {self.room.number} ({self.status})"
    
    




