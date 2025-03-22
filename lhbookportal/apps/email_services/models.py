from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

class BookingRequestPreConfirmation(models.Model):
    booking = models.ForeignKey('bookings.Booking', on_delete=models.CASCADE)
    remark = models.TextField(blank=True, null=True)
