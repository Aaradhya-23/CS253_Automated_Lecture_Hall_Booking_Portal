from .models import User
from .serializers import *
from ..bookings.permissions import IsAdmin, Issameuser
from rest_framework import generics
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import viewsets, status
from django.conf import settings
from django.core.mail import send_mail
from django.utils.crypto import get_random_string
import random
from django.utils.timezone import now
#TODO : ACCOUNT CRUD only admin --> DONE

class UserListCreateView(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAdmin] 
        
        

# admin only can update and delete users. 
class UserRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    permission_classes = [IsAdmin] 
    serializer_class = UserSerializer
    
# class UserProfile(APIView):
#     permission_classes = [Issameuser]
#     def post(self, request, *args, **kwargs):
#         r
        
    

class SendOTP(APIView):
    permission_classes = [Issameuser]
    def post(self, request, *args, **kwargs):
        user = request.user
        otp_code = str(random.randint(100000, 999999))

        # Update user model with new OTP
        user.otp = otp_code
        user.otp_created_at = now()
        user.save()
        send_mail(
                '[LHC Office] OTP for password reset',
                f"""Your OTP to reset your account password is :
                {otp_code}
                Please do not share this with anyone. 
                Valid for 10 minutes.
                
            """,
            settings.DEFAULT_FROM_EMAIL,
            [user.email],
            
        )
        return Response({"message": "OPT send successfully"}, status=status.HTTP_200_OK)
        # return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class ChangePasswordView(APIView):
    """ Allow users to change their password. """
    permission_classes = [Issameuser]

    def post(self, request, *args, **kwargs):
        serializer = ChangePasswordSerializer(data=request.data, context={'request': request})
        
        if serializer.is_valid():
            user = request.user
            user.set_password(serializer.validated_data['newpassword'])
            user.save()
            send_mail(
                '[LHC Office] Password Change Request',
                f"""If you did not requested this, someone else might be using your account. Contact LHC Office Immediately.
                
            """,
            settings.DEFAULT_FROM_EMAIL,
            [user.email],
            
            )
            return Response({"message": "Password updated successfully."}, status=status.HTTP_200_OK)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)