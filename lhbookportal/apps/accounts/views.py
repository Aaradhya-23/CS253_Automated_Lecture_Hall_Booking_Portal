from .models import User
from .serializers import *
from ..bookings.permissions import IsAdmin, Issameuser
import datetime
from rest_framework import generics
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import viewsets, status
from django.conf import settings
from django.core.mail import send_mail
from django.contrib.auth.hashers import make_password, check_password
from django.utils.crypto import get_random_string
import random
from django.utils.timezone import now
from .models import User,Authority, UserAuthority, OTPReset
from rest_framework.viewsets import ReadOnlyModelViewSet
from .serializers import UserSerializer,AuthoritySerializer
from ..bookings.permissions import IsAdmin
from rest_framework.response import Response
from rest_framework import generics
from rest_framework.permissions import AllowAny
from rest_framework.decorators import api_view, permission_classes
from django.utils import timezone
from rest_framework import status
from django.db import models
from rest_framework.generics import CreateAPIView
from rest_framework.permissions import IsAuthenticated
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


class UserListCreateView(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAdmin] 
        
        
    # permission_classes = [IsAdmin]

    def create(self, request, *args, **kwargs):
        """Extract authority IDs from frontend request and pass correct format."""
        data = request.data.copy()  # Ensure it's mutable
        print(data)
        
        if 'authorities' in data:
            # Get the authority IDs in the order provided
            authority_ids = data['authorities']
            
            # Fetch authorities based on the provided IDs and maintain the order
            authorities = Authority.objects.filter(id__in=authority_ids).order_by(
                models.Case(*[models.When(id=id, then=index) for index, id in enumerate(authority_ids)])
            )
            print("........................................")
            print(data['authorities'])
            print("........................................")

            # Assign only the authority IDs (not the instances) to the authorities field
            data['authorities'] = [authority.id for authority in authorities]
            print("........................................")

            print(data['authorities'])
            print("........................................")

        # Validate and save user data
        serializer = self.get_serializer(data=data)
        try:
            serializer.is_valid(raise_exception=True)
        except serializers.ValidationError as e:
            print("Validation Error:", e.detail)
            raise

        self.perform_create(serializer)

        return Response(serializer.data, status=status.HTTP_201_CREATED)


# admin only can update and delete users. 
class UserRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    permission_classes = [IsAdmin] 
    serializer_class = UserSerializer
    
        
    
class SendOTP(APIView):
    permission_classes = [Issameuser]

    def post(self, request, *args, **kwargs):
        email = request.data.get('email')
        otp_code = str(random.randint(100000, 999999))

        # Update user model with new OTP
        user = User.objects.get(email = email)
        user.otp = otp_code
        user.otp_created_at = now()
        user.save()

        # Compose email
        subject = '[LHC Office] OTP for password reset'
        message = f"""
Your OTP to reset your account password is:
{otp_code}
Please do not share this with anyone.
Valid for 10 minutes.
"""

        # Send email in background
        send_email_in_background(
            subject,
            message,
            settings.DEFAULT_FROM_EMAIL,
            [user.email],
        )

        return Response({"message": "OTP sent successfully"}, status=status.HTTP_200_OK)    

class AuthorityViewSet(ReadOnlyModelViewSet):  
    """
    View for listing existing authorities.
    Only accessible by admins.
    """
    queryset = Authority.objects.all() 
    serializer_class = AuthoritySerializer
    permission_classes = [IsAdmin]  

#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class AuthorityViewSet(ReadOnlyModelViewSet):  
    """
    View for listing existing authorities.
    Only accessible by admins.
    """
    queryset = Authority.objects.all() 
    serializer_class = AuthoritySerializer
    permission_classes = [IsAdmin]  

class AuthorityCreateView(CreateAPIView):  
    """
    View for creating a new authority.
    Only admins can create authorities.
    """
    queryset = Authority.objects.all()
    serializer_class = AuthoritySerializer
    permission_classes = [IsAdmin]  # Ensure only admins can create    


@api_view(['POST'])
@permission_classes([AllowAny])
def request_reset_otp(request):
    email = request.data.get('email')
    username = request.data.get('username')

    if not email or not username:
        return Response({'error': 'Email and username are required'}, status=400)

    try:
        user = User.objects.get(email=email)
        user2 = User.objects.get(username=username)
        if user != user2:
            return Response({'error': 'User and registered email do not match'}, status=404)
        otp_code = str(random.randint(100000, 999999))
        hashed_otp = make_password(otp_code)
        OTPReset.objects.create(user=user, otp=hashed_otp)

        send_email_in_background(
    '[LHC Office] OTP for password reset',
    f"""Your OTP to reset your account password is :
    {otp_code}
    Please do not share this with anyone. 
    Valid for 10 minutes.
    """,
    settings.DEFAULT_FROM_EMAIL,
    [user.email],
)
        return Response({'message': 'OTP sent successfully', 'user_id': user.id})
    except User.DoesNotExist:
        return Response({'error': 'User not found'}, status=404)
    

@api_view(['POST'])
@permission_classes([AllowAny])
def verify_and_reset_password(request):
    user_id = request.data.get('user_id')
    otp = request.data.get('otp')
    password = request.data.get('new_password')

    if not all([user_id, otp, password]):
        return Response({'error': 'Missing fields'}, status=400)

    try:
        user = User.objects.get(id=user_id)
        otp_record = OTPReset.objects.filter(user=user).order_by('-created_at').first()

        if otp_record and check_password(otp, otp_record.otp) and (timezone.now() < otp_record.created_at + datetime.timedelta(minutes=10)):
            user.set_password(password)
            user.save()
            send_email_in_background(
    '[LHC Office] Password Updated Successfully',
    f"""If you did not request this, someone else might be using your account. Contact LHC Office Immediately.""",
    settings.DEFAULT_FROM_EMAIL,
    [user.email],
)
            return Response({'message': 'Password reset successful'})
        else:
            return Response({'error': 'Invalid or expired OTP'}, status=400)

    except User.DoesNotExist:
        return Response({'error': 'Invalid user'}, status=404)