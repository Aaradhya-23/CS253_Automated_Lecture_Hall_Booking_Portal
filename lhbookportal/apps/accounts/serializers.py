from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from .models import User
from django.conf import settings
from django.utils.crypto import get_random_string
from django.core.mail import send_mail
import threading

class EmailThread(threading.Thread):
    def __init__(self, subject, message, from_email, recipient_list):
        self.subject = subject
        self.message = message
        self.from_email = from_email
        self.recipient_list = recipient_list
        super().__init__()

    def run(self):
        send_mail(
            subject=self.subject,
            message=self.message,
            from_email=self.from_email,
            recipient_list=self.recipient_list,
            fail_silently=False,
        )

def send_email_in_background(subject, message, from_email, recipient_list):
    EmailThread(subject, message, from_email, recipient_list).start()


class ChangePasswordSerializer(serializers.Serializer):
    """ Serializer for changing password. """
    """either provide old password or otp"""
    # old_password = serializers.CharField(write_only=True, required=False)
    new_password = serializers.CharField(write_only=True, required=True)
    otp = serializers.CharField(max_length=6)

    def validate_otp(self, value):
        """ Ensure the old password is correct. """
        user = self.context['user']

        if user.otp != value  or not user.is_otp_valid():
            raise serializers.ValidationError("OTP expired or wrong")
            # else: raise serializers.ValidationError("Old password is incorrect.")
        return value
    def validate_new_password(self, value):
        if(len(value) < 4):
            raise serializers.ValidationError("Password Length must be greater than 4")
        return value

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
        # exclude = ['otp', 'otp_created_at']
        fields = ['username', 'email', 'role', 'authorities', 'password',"ordered_authorities"]
        extra_kwargs = {'password': {'write_only': True, 'required' : False, 'allow_blank' : True},
            'otp' : {'required' : 'False'},
            'otp_created_at' : { 'required' : 'False'}
          }
        read_only_fields = ['total_bill']

    def validate(self, data):
        if not data.get('password') or data['password'].strip() == "":
            data['password'] = get_random_string(8)
        return data

    def get_ordered_authorities(self, obj):
        user_auths = obj.get_ordered_authorities()
        return UserAuthoritySerializer(user_auths, many=True).data

    def create(self, validated_data):
        # if validated_data.get('password'):
        password = get_random_string(8)  # Default password if not provided
        authorities_ids = validated_data.pop('authorities', [])
        with transaction.atomic():  # Ensures rollback if anything fails
            user = User.objects.create(**validated_data)
            user.set_password(password)
            user.save()  # Save the user first to get the ID

        for order, authority_id in enumerate(authorities_ids):
                try:
                    authority_instance = Authority.objects.get(id=authority_id)
                except Authority.DoesNotExist:
                    raise serializers.ValidationError(f"Authority with id {authority_id} does not exist.")
                UserAuthority.objects.create(user=user, authority=authority_instance, order=order)

        # Prepare a comma-separated string of authority names for the email.
        user_auths = user.get_ordered_authorities()
        authority_names = ", ".join([ua.authority.name for ua in user_auths])

        send_email_in_background(
    subject='Your New Account Details',
    message=(
        f"Hello {user.username},\n\n"
        "Your account has been created successfully!\n"
        "Your login credentials:\n"
        f"Username: {user.username}\n"
        f"Password: {password}\n"
        f"Your clearance authorities (in order): {authority_names}"
    ),
    from_email=settings.EMAIL_HOST_USER,
    recipient_list=[user.email],
)

            
        # user.set_password(pswd)
        
        user.save()  # Save the hashed password
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
