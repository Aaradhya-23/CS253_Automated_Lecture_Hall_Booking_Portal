
from django.urls import path

from .views import *

urlpatterns = [
    path('booking/', BookingCRUDView.as_view()),  # List and create rooms
    path('booking/<int:pk>/', BookingCRUDView.as_view()),  # Retrieve, update, delete a specific room
    path('rooms/', RoomCRUDView.as_view()),  # List and create rooms
    path('rooms/<int:pk>/', RoomCRUDView.as_view()),  # Retrieve, update, delete a specific room
]