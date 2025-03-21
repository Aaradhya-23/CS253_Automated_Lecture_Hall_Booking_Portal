from django.urls import path
from . import views

urlpatterns = [
    path('', views.booking_request_create_view, name='booking_request_create_view'), 
    # if get, render status.html with a context model containing the form recieved by post value, if needed create a model representing the same.
    # if post, send confirmation mail which contains 2 buttons accept reject and a text box containing remark (optional if accepted, mandatory if rejected)
    
    path('authority_response/', views.respond_email, name='respond_email'),
    # if post, send the form used for accept/reject booking. also should contain message.
    # if get, show the form present on authority_response.html
]

# for now, we send emails to all the authorities simultaneously. will make it sequential later.