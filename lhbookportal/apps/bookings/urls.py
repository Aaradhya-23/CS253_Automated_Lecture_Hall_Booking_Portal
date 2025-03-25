
from django.urls import path

from .views import *

urlpatterns = [
    path('', BookingCRUDView.as_view()),  # List and create rooms
    path('<int:pk>/', BookingCRUDView.as_view()),  # Retrieve, update, delete a specific room
    path('rooms/', RoomCRUDView.as_view()),  # List and create rooms
    path('rooms/<int:pk>/', RoomCRUDView.as_view()),  # Retrieve, update, delete a specific room
    path('search/', BookingSearchView.as_view(), name='booking-search'),
    path('history/', UserBookingHistoryView.as_view(), name='booking-history'),
    path('rooms/search/', RoomSearchView.as_view(), name = 'room-search'),
    path('approve/<str:token>/', approve_booking, name='approve-booking'),
    path('reject/<str:token>/', reject_booking, name='reject-booking'),
    path('download/bill/<int:booking_id>/', DownloadBillPDF.as_view(), name='download bill'),
    path('download/bookings/<str:date>/', download_daily_schedule_csv, name = 'download_csv'),
    path('slots/', AvailableBookingSlotsView.as_view(), name='view_available_booking_slot'),
]