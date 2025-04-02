from .models import User,Authority, UserAuthority
from rest_framework.viewsets import ReadOnlyModelViewSet
from .serializers import UserSerializer,AuthoritySerializer
from ..bookings.permissions import IsAdmin
from rest_framework.response import Response
from rest_framework import generics
from rest_framework import status
from django.db import models
from rest_framework.generics import CreateAPIView
from rest_framework.permissions import IsAuthenticated
#TODO : ACCOUNT CRUD only admin --> DONE

# Create your views here.
 # admin only can list and create users
class UserListCreateView(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAdmin]

    def create(self, request, *args, **kwargs):
        """Extract authority IDs from frontend request and pass correct format."""
        data = request.data.copy()  # Ensure it's mutable

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
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)

        return Response(serializer.data, status=status.HTTP_201_CREATED)

# admin only can update and delete users. 
class UserRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    permission_classes = [IsAdmin] 
    serializer_class = UserSerializer

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