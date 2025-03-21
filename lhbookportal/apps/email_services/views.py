from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse
from django.core.mail import send_mail
from django.contrib.auth import get_user_model
from django.conf import settings
from .models import BookingRequestPreConfirmation
from .forms import BookingRequestForm, AuthorityResponseForm

User = get_user_model()

def booking_request_create_view(request):
    if request.method == "POST":
        form = BookingRequestForm(request.POST)
        if form.is_valid():
            booking_request = form.save()
            # Send confirmation email
            # TODO : Send random email token as confirmation_link
            confirmation_link = request.build_absolute_uri(f"/authority_response/?id={booking_request.id}")

            send_mail(
                f"Lecture Hall Booking Request by {User.username}",
                f"Hi, please review the booking request: {confirmation_link}",
                settings.DEFAULT_FROM_EMAIL,
                User.AUTHORITY_EMAILS, 
                # TODO : add the authority emails field in User.
                fail_silently=False,
            )
            # after sending email, display the status.html page itself.
    else:
        form = BookingRequestForm()
    return render(request, "status.html", {"form": form})

def respond_email(request):
    booking_request_id = request.GET.get('id')
    booking_request = get_object_or_404(BookingRequestPreConfirmation, id=booking_request_id)
    
    if request.method == "POST":
        form = AuthorityResponseForm(request.POST)
        if form.is_valid():
            booking_request.status = form.cleaned_data['status']
            booking_request.remark = form.cleaned_data['remark']
            booking_request.save()
            return HttpResponse("Registered your response successfully.")
    else:
        form = AuthorityResponseForm()
    return render(request, "authority_response_page.html", {"form": form, "booking_request": booking_request})