"""
URL configuration for lhbookportal project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from apps.bookings.views import BookingCRUDView
from .views import CustomTokenObtainPairView

urlpatterns = [
    path('', BookingCRUDView.as_view(), name='home'),  # Default view at '/'
    path('auth/login/', CustomTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('auth/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('admin/', admin.site.urls),  # Admin Panel
    path('accounts/', include('apps.accounts.urls')),  # Accounts App
    path('bookings/', include('apps.bookings.urls')),  # Bookings App
    path('email/', include('apps.email_services.urls')),  # Email Services App
    path('reports/', include('apps.reports.urls')),  # Reports App
]