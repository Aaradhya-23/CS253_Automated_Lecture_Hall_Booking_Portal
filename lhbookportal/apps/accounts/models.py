from django.db import models
from django.contrib.auth.models import AbstractUser



#TODO : add this custom user model to settings.py app_name.User
#TODO : make this better or use groups 
class User(AbstractUser):
    ROLE_CHOICES = [
        ('admin', 'Admin'),
        ('faculty', 'Faculty'),
        ('Student', 'Student'),
    ]
    #student general role for student bodies like clubs socities, general secerataries, snt council etc.
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default='viewer')
    


# Create your models here.
