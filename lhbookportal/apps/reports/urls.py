from django.urls import path
from .views import *
urlpatterns = [
    path('download/bill/<int:booking_id>/', DownloadBillPDF.as_view(), name='download bill'),
    path('download/schedule/<str:date>/', download_daily_schedule_csv, name = 'download_csv'),
    path('feedback/', CreateFeedbackView.as_view(), name='create-feedback'),
]
