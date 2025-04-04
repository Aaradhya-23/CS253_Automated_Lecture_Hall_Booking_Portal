from django.contrib.auth import get_user_model
from django.db import models
import uuid
from django.utils import timezone
from datetime import timedelta
from apps.bookings.models import Booking

User = get_user_model()



class Feedback(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=False, blank = False)
    booking = models.ForeignKey(Booking, on_delete= models.CASCADE, null = True , blank = True )
    comment = models.TextField()
    rating = models.PositiveSmallIntegerField(null = True, blank  = True, default= 0)
    booking_experience = models.PositiveSmallIntegerField(null = True, blank  = True)
    overall_satisfaction = models.PositiveSmallIntegerField( null = True, blank  = True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"Feedback from {self.user.username}"
    
    
