from django.urls import path

from .views import *

urlpatterns = [
    path('booking/', BookingCRUDView.as_view()),  # List bookings shifted to '/'
    # removed 'booking' keyword as it was becoming redundant --> bookings/booking/new_booking --> bookings/new_bookings
    path('new_booking/', BookingCRUDView.as_view(), name='new_booking'), # create bookings 
    path('<int:pk>/', BookingCRUDView.as_view()),  # Retrieve, update, delete a specific booking
    path('approve/', approve_booking, name='approve-booking'),
    path('reject/', reject_booking, name='reject-booking'),
    path('rooms/', RoomCRUDView.as_view()),  # List and create rooms
    path('rooms/<int:pk>/', RoomCRUDView.as_view()),  # Retrieve, update, delete a specific room
    path('search/', BookingSearchView.as_view(), name='booking-search'),
    path('history/', UserBookingHistoryView.as_view(), name='booking-history'),
    path('rooms/search/', RoomSearchView.as_view(), name = 'room-search'),
    path('slots/', AvailableBookingSlotsView.as_view(), name='view_available_booking_slot'),
    path('send-rejected-mail/<int:booking_id>/', send_rejection_mail, name = "delete_and_reject")
]

