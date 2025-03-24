
from django.urls import path

from .views import *

urlpatterns = [
    path('booking/', BookingCRUDView.as_view()),  # List and create rooms
    path('booking/<int:pk>/', BookingCRUDView.as_view()),  # Retrieve, update, delete a specific room
    path('rooms/', RoomCRUDView.as_view()),  # List and create rooms
    path('rooms/<int:pk>/', RoomCRUDView.as_view()),  # Retrieve, update, delete a specific room
    path('booking/search/', BookingSearchView.as_view(), name='booking-search'),
    path('booking/history/', UserBookingHistoryView.as_view(), name='booking-history'),
    path('rooms/search/', RoomSearchView.as_view(), name = 'room-search'),
    path('booking/approve/<str:token>/', approve_booking, name='approve-booking'),
    path('booking/reject/<str:token>/', reject_booking, name='reject-booking'),
    path('download/bill/<int:booking_id>/', DownloadBillPDF.as_view(), name='download bill'),
]