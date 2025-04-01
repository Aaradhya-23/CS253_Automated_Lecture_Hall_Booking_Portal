from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from .models import User
from django.conf import settings

# from django.utils import timezone
from django.utils.crypto import get_random_string
from django.core.mail import send_mail
# User = get_user_model()
# from rest_framework import serializers
# from .models import User  # Adjust the import according to your app structure

class ChangePasswordSerializer(serializers.Serializer):
    """ Serializer for changing password. """
    """either provide old password or otp"""
    # old_password = serializers.CharField(write_only=True, required=False)
    newpassword = serializers.CharField(write_only=True, required=True)
    otp = serializers.CharField(max_length=6)

    def validate_otp(self, value):
        """ Ensure the old password is correct. """
        user = self.context['request'].user
        if user.otp != value  or not user.is_otp_valid():
            raise serializers.ValidationError("OTP expired or wrong")
            # else: raise serializers.ValidationError("Old password is incorrect.")
        return value
    def validate_newpassword(self, value):
        if(len(value) < 4):
            raise serializers.ValidationError("Password Length must be greater than 4")
        return value


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        # exclude = ['otp', 'otp_created_at']
        fields = ['username', 'email', 'role', 'authority_email', 'password']
        extra_kwargs = {
            'password': {'write_only': True, 'required' : False},
            'otp' : {'required' : 'False'},
            'otp_created_at' : { 'required' : 'False'}
            # Ensure password is write-only
        }
        read_only_fields = ['total_bill']

    def create(self, validated_data):
        password = validated_data.pop('password', None)  # Remove password from validated_data
        user = User.objects.create(**validated_data)  # Create user without password
        #If password provided then ok else generate a random one
        if password:
            pswd = password
            # Hash password manually
        else:
            pswd = get_random_string(5) 
            # Generate a 12-character password
        
        send_mail(
            'LHC booking portal Account Created!',
            f"""An Account with your email has been created by the IITK LHC Office. 
            Use these details to access the Online Booking portal.
            username : {user.username}
            password : {pswd}
            email : {user.email}
            role : {user.role}
            
            Happy Booking!
            
            
            LHC Office.
            IIT-K 
            
            """,
            settings.DEFAULT_FROM_EMAIL,
            [user.email],
        )
            
        user.set_password(pswd)
        
        user.save()  # Save the hashed password
        return user

    def update(self, instance, validated_data):
        password = validated_data.pop('password', None)  # Extract password
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        if password:
            instance.set_password(password)  # Hash password manually
        instance.save()
        return instance

# class UserSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = User
#         fields = ['id', 'username', 'email', 'role', 'authority_email', 'password']
#         extra_kwargs = {
#             'password': {'write_only': True}  # Ensure password is write-only
#         }

#     def create(self, validated_data):
#         user = User.objects.create_user(
#             username=validated_data['username'],
#             email=validated_data['email'],
#             password=validated_data['password'],
#             role=validated_data.get('role', 'Student'),  # Default role is 'Student'
#             authority_email=validated_data.get('authority_email', None)
#         )
#         # user.set_password()
#         return user

#     def update(self, instance, validated_data):
#         instance.username = validated_data.get('username', instance.username)
#         instance.email = validated_data.get('email', instance.email)
#         instance.role = validated_data.get('role', instance.role)
#         instance.authority_email = validated_data.get('authority_email', instance.authority_email)
#         if 'password' in validated_data:
#             instance.set_password(validated_data['password'])
#         instance.save()
#         return instance

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

#     def update(self, instance, validated_data):
#         """Update an existing user."""
#         # Update the user
#         instance.username = validated_data.get('username', instance.username)
#         instance.email = validated_data.get('email', instance.email)
#         if 'password' in validated_data:
#             instance.set_password(validated_data['password'])
#         instance.save()
#         return instance
    

# class UserSerializer(serializers.ModelSerializer):
#     """
#     Secure User Serializer for creating and updating users.
#     Handles password hashing and ensures sensitive fields are not exposed.
#     """
#     email = serializers.EmailField(
#         required=True,
#         validators=[UniqueValidator(queryset=User.objects.all())]
#     )
#     username = serializers.CharField(
#         required=True,
#         validators=[UniqueValidator(queryset=User.objects.all())]
#     )
#     password = serializers.CharField(
#         write_only=True,  # Password is never returned in the response
#         required=True,
#         validators=[validate_password]  # Enforce strong password validation
#     )
#     role = serializers.ChoiceField(choices=User.ROLE_CHOICES, required=True)

#     class Meta:
#         model = User
#         fields = ['id', 'username', 'email', 'password', 'first_name', 'last_name', 'role']
#         extra_kwargs = {
#             'password': {'write_only': True},  # Ensure password is never returned
#             'id': {'read_only': True},  # ID is auto-generated and should not be editable
#         }

#     def create(self, validated_data):
#         """
#         Create and return a new user instance with a hashed password.
#         """
#         user = User(
#             username=validated_data['username'],
#             email=validated_data['email'],
#             first_name=validated_data.get('first_name', ''),
#             last_name=validated_data.get('last_name', ''),
#             role=validated_data['role'],
#         )
#         user.set_password(validated_data['password'])  # Hash the password
#         user.save()
#         return user

#     def update(self, instance, validated_data):
#         """
#         Update and return an existing user instance.
#         Handles password hashing if the password is provided.
#         """
#         instance.username = validated_data.get('username', instance.username)
#         instance.email = validated_data.get('email', instance.email)
#         instance.first_name = validated_data.get('first_name', instance.first_name)
#         instance.last_name = validated_data.get('last_name', instance.last_name)
#         instance.role = validated_data.get('role', instance.role)

#         # Handle password update
#         password = validated_data.get('password')
#         if password:
#             instance.set_password(password)  # Hash the new password

#         instance.save()
#         return instance

