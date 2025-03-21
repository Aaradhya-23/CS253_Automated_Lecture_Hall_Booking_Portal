from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from .models import *
from django.utils import timezone
import datetime

User = get_user_model()

#TODO MAKE this more secure better password handling not exposing passwords, hashing passwords

class RoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = '__all__'

    def validate_capacity(self, value):
        """Ensure capacity is a positive integer."""
        if value <= 0:
            raise serializers.ValidationError("Capacity must be a positive integer.")
        return value

    def validate_price_per_hour(self, value):
        """Ensure price_per_hour is a non-negative integer."""
        if value < 0:
            raise serializers.ValidationError("Price per hour cannot be negative.")
        return value

    def validate_room_type(self, value):
        """Ensure room_type is one of the valid choices."""
        valid_room_types = [choice[0] for choice in Room.ROOM_TYPES]
        if value not in valid_room_types:
            raise serializers.ValidationError(f"Invalid room type. Must be one of: {valid_room_types}")
        return value


class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = '__all__'
        read_only_fields = ['status', 'creator', 'requested_on', 'cost']  # Status should not be set directly by the user
        depth = 1

    def validate(self, data):
        """
        Perform additional validation for the booking:
        1. Ensure the start time is before the end time.
        2. Ensure the booking is not in the past.
        3. Ensure the room is available during the requested time slot.
        """
        start_time = data.get('start_time')
        end_time = data.get('end_time')
        booking_date = data.get('booking_date')
        room = data.get('room')
        

        # 1. Ensure start time is before end time
        if (start_time > 24 or end_time > 24):
            raise serializers.ValidationError("Start time must not be greater than 24")
        if start_time >= end_time:
            raise serializers.ValidationError("Start time must be before end time.")
        
        booking_datetime = datetime.datetime.combine(booking_date, start_time)
        # 2. Ensure the booking is not in the past
        if booking_datetime < timezone.now():
            raise serializers.ValidationError("Booking cannot be in the past.")

        # 3. Ensure the room is available during the requested time slot
        conflicting_bookings = Booking.objects.filter(
            room=room,
            booking_date = booking_date,
            start_time__lt=end_time,
            end_time__gt=start_time,
        ).exclude(status='cancelled')  # Exclude cancelled bookings

        if conflicting_bookings.exists():
            raise serializers.ValidationError("The room is already booked during this time.")

        return data

    def validate_status(self, value):
        """Ensure status is one of the valid choices."""
        valid_statuses = [choice[0] for choice in Booking.STATUS_CHOICES]
        if value not in valid_statuses:
            raise serializers.ValidationError(f"Invalid status. Must be one of: {valid_statuses}")
        return value

    def validate_type(self, value):
        valid_type = [choice[0] for choice in Booking.TYPE_CHOICES]
        if value not in valid_type:
            raise serializers.ValidationError(f"Invalid Type. Must be one of: {valid_type}")
    def create(self, validated_data):
        """
        Override the create method to set the creator automatically.
        """

        validated_data['creator'] = self.context['request'].user
        return super().create(validated_data)

    def update(self, instance, validated_data):
        """
        Override the update method to handle status changes.
        Only allow status updates for pending bookings.
        """
        if 'status' in validated_data:
            if instance.status != 'pending':
                raise serializers.ValidationError("Only pending bookings can be updated.")
        return super().update(instance, validated_data)   

