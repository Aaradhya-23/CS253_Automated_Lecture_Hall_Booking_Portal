from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from .models import Holiday
from .models import *
from apps.accounts.serializers import UserSerializer
from django.utils import timezone
from django.core.mail import send_mail
import threading
import datetime
from django.db.models import Q
User = get_user_model()

#TODO MAKE this more secure better password handling not exposing passwords, hashing passwords


class HolidaySerializer(serializers.ModelSerializer):
    class Meta:
        model = Holiday
        fields ='__all__'
        
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
    
    def validate_accessories(self, value):
        if not isinstance(value, dict):
            raise serializers.ValidationError("Accessories must be a dictionary.")
        for accessory, available in value.items():
            if accessory not in dict(Room.ACCESSORY_OPTIONS):
                raise serializers.ValidationError(f"Invalid accessory: {accessory}")
            if not isinstance(available, bool):
                raise serializers.ValidationError(f"Accessory availability for {accessory} must be a boolean.")
        return value


class BookingSerializer(serializers.ModelSerializer):
    # room = serializers.PrimaryKeyRelatedField(queryset=Room.objects.all())
    
    booking_date = serializers.DateField()
    accessories = serializers.JSONField() # Allow accessories data to be handled
    
    room = serializers.PrimaryKeyRelatedField(
        queryset=Room.objects.all(), write_only=True  # For POST requests (accepts ID)
    )
    
    # Custom room field for GET requests
    room_details = RoomSerializer(read_only=True, source="room")
    # room_obj = RoomSerializer(read_only=True)

    creator = serializers.HiddenField(default=serializers.CurrentUserDefault())
    creator = UserSerializer(read_only=True)
    
    class Meta:
        model = Booking
        exclude = ['booking_token', 'token_expiry']  # Exclude sensitive fields
        read_only_fields = ['status', 'requested_on', 'cost']  # Fields not set by the user
        depth = 1 

    def validate(self, data):
        # Extract relevant fields
        start_time = data.get('start_time')
        end_time = data.get('end_time')
        booking_date = data.get('booking_date')
        room = data.get('room')
        title = data.get('title')
        Type = data.get('Type', 'nonacademic')  # Default to 'nonacademic' if not provided
        remarks = data.get('remarks', '')
        accessories = data.get('accessories', {})
        duration_hrs = data.get('duration', 0)  # Ensure duration is passed or default to 0
        # cost = data.get('cost', 0)  # If cost is passed, we can check or calculate it
        # Validate room
        # try:
        #     room = Room.objects.get(name=room_name)
        #     data['room'] = room  # Assign the Room object to the data
        # except Room.DoesNotExist:
        #     raise serializers.ValidationError(f"Room with name '{room_name}' does not exist.")

        # Ensure accessories are valid for the room
        for accessory, value in accessories.items():
            if accessory not in room.accessories or not room.accessories[accessory]:
                raise serializers.ValidationError(f"{accessory} is not available in {room.name}.")

        # print(Holiday)
        holidays = Holiday.objects.filter(date=booking_date)
        if holidays.exists() or booking_date.weekday() == 6:
            raise serializers.ValidationError("Bookings cannot be made on holidays.")

        # # Convert to time objects if they are strings
        if isinstance(start_time, str):
            start_time = datetime.datetime.strptime(start_time, '%H:%M:%S').time()
        if isinstance(end_time, str):
            end_time = datetime.datetime.strptime(end_time, '%H:%M:%S').time()

        # Combine booking_date and start_time/end_time into datetime objects
        booking_start_datetime = timezone.make_aware(
            datetime.datetime.combine(booking_date, start_time)
        )
        booking_end_datetime = timezone.make_aware(
            datetime.datetime.combine(booking_date, end_time)
        )

        # # 1. Ensure start time is before end time
        if booking_start_datetime >= booking_end_datetime:
            raise serializers.ValidationError("Start time must be before end time.")

        # 2. Ensure the booking is not in the past
        if booking_start_datetime < timezone.now():
            raise serializers.ValidationError("Booking cannot be in the past.")

        # 3. Ensure the room is available during the requested time slot
        conflicting_bookings = Booking.objects.filter(
            Q(room=room)&
            Q(booking_date=booking_date)&
            Q(start_time__lt=end_time, end_time__gt=start_time) 
        ).exclude(status='cancelled')  # Exclude cancelled bookings
        
        

        if conflicting_bookings.exists():
            raise serializers.ValidationError("The room is already booked during this time.")

        # Additional validations based on 'Type' (academic/nonacademic)
        if Type not in ['academic', 'nonacademic']:
            raise serializers.ValidationError(f"Invalid Type '{Type}'. Valid options are 'academic' or 'nonacademic'.")

        # Additional logic for `remarks` can go here if needed, e.g., length validation.

        # Return the validated data
        return data

    def create(self, validated_data):
        validated_data['creator'] = self.context['request'].user
        validated_data['duration'] = (datetime.datetime.combine(validated_data['booking_date'], validated_data['end_time']) -
                                       datetime.datetime.combine(validated_data['booking_date'], validated_data['start_time'])).seconds / 3600
        validated_data['cost'] = validated_data['room'].price_per_hour * validated_data['duration']
        return super().create(validated_data)

    def update(self, instance, validated_data):
        if 'status' in validated_data and instance.status != 'pending':
            raise serializers.ValidationError("Only pending bookings can be updated.")
        return super().update(instance, validated_data)
