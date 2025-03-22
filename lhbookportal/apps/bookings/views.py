
from django.contrib.auth import get_user_model
from rest_framework.parsers import JSONParser
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics, authentication, permissions, mixins, filters
from django_filters.rest_framework import DjangoFilterBackend
from .models import *
from rest_framework.permissions import IsAuthenticated
from .serializers import *
from rest_framework.permissions import IsAdminUser
from .permissions import *
from django.utils.timezone import now
from rest_framework.throttling import UserRateThrottle
User = get_user_model()




class BookingCRUDView(
    generics.GenericAPIView, 
    mixins.ListModelMixin, 
    mixins.CreateModelMixin, 
    mixins.RetrieveModelMixin, 
    mixins.UpdateModelMixin, 
    mixins.DestroyModelMixin
):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer
    authentication_classes = []
    permission_classes = [BookingPermissions]  # Restrict access to authenticated users
    throttle_classes  = [UserRateThrottle]
    
    
    # Set `creator` and `status` dynamically
    def perform_create(self, serializer):
        user = self.request.user
        
        if user.role != 'admin': 
            Type = 'academic' if user.role == 'faculty' else 'nonacademic'
        
        status = 'approved' if user.role == 'admin' else 'pending'
        
        if Type == 'academic': 
            status = 'approved'
        
        start_time = self.request.POST.get('start_time')
        end_time = self.request.POST.get('end_time')
        duration = end_time - start_time
        Ty = self.request.POST.get('room')
        room = Room.objects.filter(pk = Ty)
        cost = room.price_get_hour*duration
        requested_on = timezone.now()
        
        
        
        serializer.save(creator=user, status=status, Type = Type, requested_on = requested_on, cost = cost, duration = duration)

    # def perform_update(self, serializer):
    #     user = self.request.user
    #     if user.role == 'admin':
    #         status = 'approved'
    #     elif user.role == 'faculty':
    #         status = 'under_review'
    #     else:
    #         status = 'pending'
        
    #     serializer.save(status=status, Type = Type, requested_on )  # `creator` remains unchanged

    # GET: List all bookings or retrieve a specific booking
    def get(self, request, *args, **kwargs):
        if "pk" in kwargs:
            return self.retrieve(request, *args, **kwargs)
        return self.list(request, *args, **kwargs)

    # POST: Create a new booking
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)

    # PUT/PATCH: Update an existing booking
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def patch(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)

    
    # DELETE: Delete a booking
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)


#example
# Search by title	/api/bookings/search/?search=math
# Filter by status	/api/bookings/search/?status=approved
# Filter by room	/api/bookings/search/?room=2
# Sort by start time	/api/bookings/search/?ordering=start_time
# Reverse sort by start time	/api/bookings/search/?ordering=-start_time
class BookingSearchView(generics.ListAPIView):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]

    # Exact field filters
    filterset_fields = ['status', 'type', 'room', 'creator']

    # Full-text search fields
    search_fields = ['title', 'room__number', 'creator__username']

    # Sorting options
    ordering_fields = ['start_time', 'end_time', 'requested_on']
    ordering = ['-start_time']  # Default sorting (latest bookings first)

class UserBookingHistoryView(generics.ListAPIView):
    serializer_class = BookingSerializer
    permission_classes = [IsAuthenticated]  # Only authenticated users can see their history

    def get_queryset(self):
        """Return only the bookings of the logged-in user"""
        return Booking.objects.filter(user=self.request.user).order_by('-requested_on')


class RoomCRUDView(
    generics.GenericAPIView, 
    mixins.ListModelMixin, 
    mixins.CreateModelMixin, 
    mixins.RetrieveModelMixin, 
    mixins.UpdateModelMixin, 
    mixins.DestroyModelMixin
):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer
    permission_classes = [IsAdmin]  # Restrict access to authenticated users
    throttle_classes  = [UserRateThrottle]

    def perform_create(self, serializer):
        """Set custom behavior before saving a new Room."""
        serializer.save()

    def perform_update(self, serializer):
        """Custom logic before updating an existing Room."""
        serializer.save()

    # GET: List all rooms or retrieve a specific room
    def get(self, request, *args, **kwargs):
        if "pk" in kwargs:
            return self.retrieve(request, *args, **kwargs)
        return self.list(request, *args, **kwargs)

    # POST: Create a new room
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)

    # PUT/PATCH: Update an existing room
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def patch(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)

    # DELETE: Delete a room
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)
# Create your views here.