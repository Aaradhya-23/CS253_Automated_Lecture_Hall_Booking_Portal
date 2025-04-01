from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import ArrayField
from datetime import datetime, timedelta
from django.utils import timezone

#TODO : make this better or use groups 
class User(AbstractUser):
    ROLE_CHOICES = [
        ('admin', 'Admin'),
        ('faculty', 'Faculty'),
        ('Student', 'Student'),
    ]
    #student general role for student bodies like clubs socities, general secerataries, snt council etc.
    role = models.CharField(max_length=10, choices=ROLE_CHOICES)
    email = models.EmailField(unique=True)
    otp = models.CharField(max_length=6, blank=True, null=True)
    otp_created_at = models.DateTimeField(blank=True, null=True)
    
    # in abstract user, email is not unique by default
    total_bill = models.IntegerField(default= 0 )
    authority_email = models.EmailField(null = True, blank =  True)
    # only works with postgresql

    # latest_booking_request = models.ForeignKey('email_services.BookingRequestPreConfirmation', on_delete=models.SET_NULL, null=True, blank=True)
    def is_otp_valid(self):
        """ Check if OTP is valid (expires after 10 minutes). """
        # now = timezone.now()

# Ensure self.otp_created_at is also aware (if it's not, you can make it aware as shown above)
        # otp_created_at = timezone.make_aware(self.otp_created_at, timezone.get_current_timezone())
        if self.otp_created_at:
            return self.otp_created_at >= timezone.now() - timedelta(minutes=10)
        return False
    
    def __str__(self):
        return self.username


# Create your models here.
