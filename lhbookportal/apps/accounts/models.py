from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import ArrayField



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
    # in abstract user, email is not unique by default
    total_bill = models.IntegerField(default= 0 )
    authority_email = models.EmailField(null = True, blank =  True)
    # only works with postgresql

    # latest_booking_request = models.ForeignKey('email_services.BookingRequestPreConfirmation', on_delete=models.SET_NULL, null=True, blank=True)

    def __str__(self):
        return self.username


# Create your models here.
