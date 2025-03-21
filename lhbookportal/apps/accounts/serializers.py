from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from .models import *
from django.utils import timezone

User = get_user_model()

# class UserSerializer(serializers.ModelSerializer):
#     password = serializers.CharField(write_only=True, required=True, validators=[validate_password])

#     class Meta:
#         model = User
#         fields = ['id', 'username', 'email', 'password', 'role']
#         extra_kwargs = {
#             'password': {'write_only': True},
#             'role': {'read_only': True},  # Role should not be set directly by the user
#         }

#     def create(self, validated_data):
#         """Create a new user with the validated data."""
#         # Create the user
#         user = User.objects.create_user(**validated_data)
#         return user

#     def update(self, instance, validat    ed_data):
#         """Update an existing user."""
#         # Update the user
#         instance.username = validated_data.get('username', instance.username)
#         instance.email = validated_data.get('email', instance.email)
#         if 'password' in validated_data:
#             instance.set_password(validated_data['password'])
#         instance.save()
#         return instance
    

class UserSerializer(serializers.ModelSerializer):
    """
    Secure User Serializer for creating and updating users.
    Handles password hashing and ensures sensitive fields are not exposed.
    """
    email = serializers.EmailField(
        required=True,
        validators=[UniqueValidator(queryset=User.objects.all())]
    )
    username = serializers.CharField(
        required=True,
        validators=[UniqueValidator(queryset=User.objects.all())]
    )
    password = serializers.CharField(
        write_only=True,  # Password is never returned in the response
        required=True,
        validators=[validate_password]  # Enforce strong password validation
    )

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password', 'first_name', 'last_name']
        extra_kwargs = {
            'password': {'write_only': True},  # Ensure password is never returned
            'id': {'read_only': True},  # ID is auto-generated and should not be editable
        }

    def create(self, validated_data):
        """
        Create and return a new user instance with a hashed password.
        """
        user = User(
            username=validated_data['username'],
            email=validated_data['email'],

        )
        user.set_password(validated_data['password'])  # Hash the password
        user.save()
        return user

    def update(self, instance, validated_data):
        """
        Update and return an existing user instance.
        Handles password hashing if the password is provided.
        """
        instance.username = validated_data.get('username', instance.username)
        instance.email = validated_data.get('email', instance.email)
        instance.first_name = validated_data.get('first_name', instance.first_name)
        instance.last_name = validated_data.get('last_name', instance.last_name)

        # Handle password update
        password = validated_data.get('password')
        if password:
            instance.set_password(password)  # Hash the new password

        instance.save()
        return instance

