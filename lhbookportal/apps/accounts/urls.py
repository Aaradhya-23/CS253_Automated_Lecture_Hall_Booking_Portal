from django.urls import path
from .views import *

from .views import *
from rest_framework.routers import DefaultRouter


app_name = 'accounts'

#  Helps with namespacing URLs using {% url 'accounts:login' %}
router = DefaultRouter()
router.register(r'authorities', AuthorityViewSet, basename='authority')

urlpatterns = [
    path('users/', UserListCreateView.as_view(), name='user-list-create'),
    path('users/<int:pk>/', UserRetrieveUpdateDestroyView.as_view(), name='user-detail'),
    path('users/generate_otp/',   SendOTP.as_view(), name = 'generate_otp'),
    path('request_reset/', request_reset_otp, name='request-reset'),
    path('verify_reset/', verify_and_reset_password, name='verify-reset'),
    path('users/change_password/', ChangePasswordView.as_view(), name = 'change_password'  ),
    path('authorities/create/', AuthorityCreateView.as_view(), name='authority-create'),
]
urlpatterns += router.urls