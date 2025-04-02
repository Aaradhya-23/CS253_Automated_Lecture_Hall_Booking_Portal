from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from .models import User
from django.utils import timezone

# User = get_user_model()
# from rest_framework import serializers
# from .models import User  # Adjust the import according to your app structure

# class UserSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = User
#         fields = ['username', 'email', 'role', 'authority_email', 'password']
#         extra_kwargs = {
#             'password': {'write_only': True}  # Ensure password is write-only
#         }
#         read_only_fields = ['total_bill']

#     def create(self, validated_data):
#         password = validated_data.pop('password', None)  # Remove password from validated_data
#         user = User.objects.create(**validated_data)  # Create user without password
#         if password:
#             user.set_password(password)  # Hash password manually
#             user.save()  # Save the hashed password
#         return user

#     def update(self, instance, validated_data):
#         password = validated_data.pop('password', None)  # Extract password
#         for attr, value in validated_data.items():
#             setattr(instance, attr, value)
#         if password:
#             instance.set_password(password)  # Hash password manually
#         instance.save()
#         return instance

from rest_framework import serializers
from .models import User, Authority, UserAuthority
from django.db import models
from django.core.mail import send_mail
from django.conf import settings
from django.db.models import Case, When
from django.db import transaction

class AuthoritySerializer(serializers.ModelSerializer):
    """Serializer for Authority Model."""
    class Meta:
        model = Authority
        fields = ['id', 'name', 'email']

class UserAuthoritySerializer(serializers.ModelSerializer):
    authority = AuthoritySerializer()  # Nested representation

    class Meta:
        model = UserAuthority
        fields = ['authority', 'order']

class UserSerializer(serializers.ModelSerializer):
    # Expect input as a list of authority IDs.
    authorities = serializers.ListField(
        child=serializers.IntegerField(), write_only=True, required=False
    )
    # For output, return the ordered authorities in a nested representation.
    ordered_authorities = serializers.SerializerMethodField(read_only=True)

    email = serializers.EmailField(required=True)

    class Meta:
        model = User
        fields = ['username', 'email', 'role', 'authorities', 'password',"ordered_authorities"]
        extra_kwargs = {'password': {'write_only': True}}
        read_only_fields = ['total_bill']

    def get_ordered_authorities(self, obj):
        user_auths = obj.get_ordered_authorities()
        return UserAuthoritySerializer(user_auths, many=True).data

    def create(self, validated_data):
        authorities_ids = validated_data.pop('authorities', [])
        password = validated_data.pop('password', None)

        with transaction.atomic():  # Ensures rollback if anything fails
            user = User.objects.create(**validated_data)
            if password:
                user.set_password(password)
            user.save()

            for order, authority_id in enumerate(authorities_ids):
                try:
                    authority_instance = Authority.objects.get(id=authority_id)
                except Authority.DoesNotExist:
                    raise serializers.ValidationError(f"Authority with id {authority_id} does not exist.")
                UserAuthority.objects.create(user=user, authority=authority_instance, order=order)

            # Prepare a comma-separated string of authority names for the email.
            user_auths = user.get_ordered_authorities()
            authority_names = ", ".join([ua.authority.name for ua in user_auths])

            send_mail(
                'Your New Account Details',
                (
                    f'Hello {user.username},\n\nYour account has been created successfully!\n'
                    f'Your login credentials:\n'
                    f'Username: {user.username}\n'
                    f'Password: {user.password}\n'
                    f'Your clearance authorities (in order): {authority_names}'
                ),
                settings.EMAIL_HOST_USER,  # Sender email
                [user.email],  # Recipient email
                fail_silently=False,
            )
            return user


    def update(self, instance, validated_data):
        """Update user with ordered authorities."""
        password = validated_data.pop('password', None)
        authorities_data = validated_data.pop('authorities', [])

        for attr, value in validated_data.items():
            setattr(instance, attr, value)

        if password:
            instance.set_password(password)

        instance.save()

        # Process ordered authorities
        authority_instances = []
        for auth_data in authorities_data:
            if "id" in auth_data:
                authority = Authority.objects.get(id=auth_data["id"])
            else:
                authority, created = Authority.objects.get_or_create(**auth_data)
            authority_instances.append(authority)

        instance.authorities.set(authority_instances)  # Maintain order
        return instance

class UserAuthorityCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserAuthority
        fields = ['user', 'authority', 'order']

    def create(self, validated_data):
        return UserAuthority.objects.create(**validated_data)

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

