from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import ArrayField

from datetime import datetime, timedelta
from django.utils import timezone


#added by divyesh 
class Authority(models.Model):
    name = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    # address = models.TextField()

    def __str__(self):
        return f"{self.name} ({self.email})"



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
    # authority_email = models.EmailField(null = True, blank =  True)
    #added by divyesh     
    # Many-to-Many relationship with Authority
    authorities = models.ManyToManyField('Authority',through="UserAuthority", blank=True)
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
    def get_ordered_authorities(self):
        return self.userauthority_set.order_by("order")

    
    def __str__(self):
        # Get authorities related to this user
        authorities = self.authorities.all()
        authorities_list = ", ".join([authority.name for authority in authorities]) if authorities.exists() else "No authorities assigned"

        return f"User: {self.username}, Email: {self.email}, Role: {self.role}, Total Bill: {self.total_bill}, Authorities: {authorities_list}"

class UserAuthority(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    authority = models.ForeignKey(Authority, on_delete=models.CASCADE)
    order = models.PositiveIntegerField(default=0)  # Order of authority

    class Meta:
        unique_together = ("user", "authority")  # Prevent duplicate authorities
        ordering = ["order"]  # Ensures authorities are retrieved in order

    def _str_(self):
        return f"{self.user.username} → {self.authority.name} (Order: {self.order})"
# Create your models here.
