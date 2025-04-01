from django.urls import path
from .views import *


app_name = 'accounts'

#  Helps with namespacing URLs using {% url 'accounts:login' %}

urlpatterns = [
    path('users/', UserListCreateView.as_view(), name='user-list-create'),
    path('users/<int:pk>/', UserRetrieveUpdateDestroyView.as_view(), name='user-detail'),
    path('users/generate_otp/',   SendOTP.as_view(), name = 'generate_otp'),
    path('users/change_password/', ChangePasswordView.as_view(), name = 'change_password')
]
