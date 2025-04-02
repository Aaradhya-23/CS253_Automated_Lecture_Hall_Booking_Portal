from django.urls import path
from .views import UserListCreateView, UserRetrieveUpdateDestroyView,AuthorityCreateView,AuthorityViewSet
from rest_framework.routers import DefaultRouter

app_name = 'accounts'

#  Helps with namespacing URLs using {% url 'accounts:login' %}
router = DefaultRouter()
router.register(r'authorities', AuthorityViewSet, basename='authority')

urlpatterns = [
    path('users/', UserListCreateView.as_view(), name='user-list-create'),
    path('users/<int:pk>/', UserRetrieveUpdateDestroyView.as_view(), name='user-detail'),
    # ✅ Authority creation route (only for admins)
    path('authorities/create/', AuthorityCreateView.as_view(), name='authority-create'),
]
urlpatterns += router.urls