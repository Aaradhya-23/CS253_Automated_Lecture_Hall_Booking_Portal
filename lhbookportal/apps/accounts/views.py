from .models import User
from .serializers import UserSerializer
from ..bookings.permissions import IsAdmin
from rest_framework import generics

#TODO : ACCOUNT CRUD only admin --> DONE

# Create your views here.
 # admin only can list and create users
class UserListCreateView(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAdmin] 

# admin only can update and delete users. 
class UserRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    permission_classes = [IsAdmin] 
    serializer_class = UserSerializer
    