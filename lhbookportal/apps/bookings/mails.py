from django.conf import settings
import threading
from django.core.mail import EmailMultiAlternatives

class EmailThread(threading.Thread):
    def __init__(self, subject, message, from_email, recipient_list, html_message=None, *args, **kwargs):
        self.subject = subject
        self.message = message
        self.from_email = from_email
        self.recipient_list = recipient_list
        self.html_message = html_message
        super().__init__(*args, **kwargs)

    def run(self):
        email = EmailMultiAlternatives(
            self.subject,
            self.message,  # Plain text fallback
            self.from_email,
            self.recipient_list,
        )
        if self.html_message:
            email.attach_alternative(self.html_message, "text/html")
        email.send(fail_silently=False)

# def send_email_in_background(subject, message, from_email, recipient_list):
#     EmailThread(subject, message, from_email, recipient_list).start()
def send_email_in_background(subject, message, from_email, recipient_list, html_message=None):
    EmailThread(subject, message, from_email, recipient_list, html_message).start()

def send_booking_details_to_admin(booking):
    html_message = f"""
    <html>
    <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
        <div style="max-width: 600px; margin: auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);">
        <h2 style="color: #2c3e50;">New Booking Request</h2>
        
        <p>A new booking request has been submitted by <strong>{booking.creator.username}</strong>.</p>

        <table style="width: 100%; margin-top: 15px; border-collapse: collapse;">
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Title:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.title}</td>
            </tr>
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Room:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.room.name}</td>
            </tr>
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Date:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.booking_date}</td>
            </tr>
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Time:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.start_time} - {booking.end_time}</td>
            </tr>
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Remarks:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.remarks}</td>
            </tr>
            <tr>
            <td style="padding: 10px;"><strong>Total Cost:</strong></td>
            <td style="padding: 10px;">₹{booking.cost}</td>
            </tr>
        </table>

        <p style="margin-top: 30px; font-size: 13px; color: #777;">Please review the booking request and take the necessary action.</p>
        </div>
    </body>
    </html>
    """
    
    send_email_in_background(
        subject="[LHC OFFICE] New Booking Request",
        message=f"""
        A new booking request has been submitted by {booking.creator.username}.
        Title: {booking.title}
        Room: {booking.room.name}
        Date: {booking.booking_date}
        Time: {booking.start_time} - {booking.end_time}
        Remarks: {booking.remarks}
        Total Cost: ₹{booking.cost}
        """,
        from_email=settings.DEFAULT_FROM_EMAIL,
        recipient_list=["admin@example.com"],  # Replace with admin email
        html_message=html_message
    )
    
    
    
def send_rejection_mail_to_user(booking, remarks):
    html_message = f"""
    <html>
    <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
        <div style="max-width: 600px; margin: auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);">
        <h2 style="color: #c0392b;">Booking Rejected ❌</h2>
        
        <p>Dear <strong>{booking.creator.username}</strong>,</p>

        <p>We regret to inform you that your booking request has been <strong style="color: #c0392b;">rejected</strong>.</p>

        <table style="width: 100%; margin-top: 15px; border-collapse: collapse;">
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Title:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.title}</td>
            </tr>
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Room:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.room.name}</td>
            </tr>
            <tr>    
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Date:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.booking_date}</td>
            </tr>
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Remarks:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{remarks}</td>
            </tr>
        </table>

        <p style="margin-top: 30px; font-size: 13px; color: #777;">If you have any questions or concerns, please contact the LHC Office.</p>
        </div>
    </body>
    </html>
    """

    send_email_in_background(
        subject='Booking Rejected',
        message=f"""
        Sorry, your booking request titled "{booking.title}" at {booking.room.name} for date {booking.booking_date} has been rejected.
        Remarks: {remarks}
        """,
        from_email=settings.DEFAULT_FROM_EMAIL,
        recipient_list=[booking.creator.email],
        html_message=html_message
    )

def send_confirmation_mail(booking):
    accessories_list = [
            name.replace('_', ' ').title()
            for name, selected in booking.accessories.items() if selected
        ]
    accessories_str = ', '.join(accessories_list) if accessories_list else 'None'
    user = booking.creator
    subject = "[LHC OFFICE] Booking Request Recorded"

    html_message = f"""
    <html>
    <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
        <div style="max-width: 600px; margin: auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);">
            <h2 style="color: #2c3e50;">Booking Request Recorded ✅</h2>
            
            <p>Dear <strong>{user.username}</strong>,</p>

            <p>Your booking request has been recorded and sent to the respective authorities for confirmation.</p>
            <p>You will receive a confirmation email once it is approved.</p>

            <table style="width: 100%; margin-top: 15px; border-collapse: collapse;">
                <tr>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Purpose:</strong></td>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.title}</td>
                </tr>
                <tr>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Remarks:</strong></td>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.remarks}</td>
                </tr>
                <tr>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Room:</strong></td>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.room.name}</td>
                </tr>
                <tr>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Date:</strong></td>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.booking_date}</td>
                </tr>
                <tr>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Time:</strong></td>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.start_time} - {booking.end_time}</td>
                </tr>
                <tr>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Requested On:</strong></td>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.requested_on}</td>
                </tr>
                <tr>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Accessories:</strong></td>
                    <td style="padding: 10px; border-bottom: 1px solid #eee;">{accessories_str}</td>
                </tr>
                <tr>
                    <td style="padding: 10px;"><strong>Total Cost:</strong></td>
                    <td style="padding: 10px;">₹{booking.cost}</td>
                </tr>
            </table>

            <div style="margin-top: 25px;">
                <a href="http://172.27.16.252:5174/login" style="display: inline-block; padding: 12px 20px; background-color: #4285F4; color: white; text-decoration: none; border-radius: 6px; font-weight: bold;">
                    👉 Track Your Booking Status
                </a>
            </div>

            <p style="margin-top: 30px; font-size: 13px; color: #777;">Note: Unapproved bookings will be auto-rejected in 2 days or less.</p>
        </div>
    </body>
    </html>
    """

    send_email_in_background(
        subject=subject,
        message=f"""
    Your({user.username}) booking request has been recorded and sent to the respective authorities for confirmation.
    You will receive a confirmation email once it is approved.

    👉 To track your booking status, visit:
    http://172.27.16.252:5174/login

    Purpose    : {booking.title}
    Remarks    : {booking.remarks}
    Room       : {booking.room.name}
    Date       : {booking.booking_date}
    Time       : {booking.start_time} - {booking.end_time}
    Requested On: {booking.requested_on}
    Accessories: {accessories_str}
    Total Cost : ₹{booking.cost}
    Note: Unapproved bookings will be auto-rejected in 2 days or less.
        """,  # Plain text fallback
        from_email=settings.DEFAULT_FROM_EMAIL,
        recipient_list=[user.email],
        html_message=html_message
    )

def send_approval_email(authority_email, booking):
    authority_token = booking.authority_tokens.get(authority_email)
    if not authority_token:
        return  # Safety check
    print("please be triggered bc")
    print(authority_email)
    accessories_list = [
        name.replace('_', ' ').title()
        for name, selected in booking.accessories.items() if selected
    ]
    accessories_str = ', '.join(accessories_list) if accessories_list else 'None'

    approval_link = (
        f"http://172.27.16.252:8000/bookings/approve/?booking_token={booking.booking_token}"
        f"&authority_token={authority_token}"
    )
    rejection_link = (
        f"http://172.27.16.252:8000/bookings/reject/?booking_token={booking.booking_token}"
        f"&authority_token={authority_token}"
    )

    user = booking.creator
    subject = "[LHC OFFICE] Booking Request Approval Needed"

    html_message = f"""
    <html>
    <body style="font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 20px;">
        <div style="max-width: 600px; margin: auto; background-color: #fff; border-radius: 10px; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
        <h2 style="color: #2c3e50;">Booking Request Submitted</h2>
        <p>A new booking request has been submitted by <strong>{user.username}</strong>.</p>
        
        <table style="width: 100%; border-collapse: collapse; margin-top: 10px;">
            <tr>
            <td style="padding: 8px; border-bottom: 1px solid #eee;"><strong>Purpose:</strong></td>
            <td style="padding: 8px; border-bottom: 1px solid #eee;">{booking.title}</td>
            </tr>
            <tr>
            <td style="padding: 8px; border-bottom: 1px solid #eee;"><strong>Remarks:</strong></td>
            <td style="padding: 8px; border-bottom: 1px solid #eee;">{booking.remarks}</td>
            </tr>
            <tr>
            <td style="padding: 8px; border-bottom: 1px solid #eee;"><strong>Room:</strong></td>
            <td style="padding: 8px; border-bottom: 1px solid #eee;">{booking.room.name}</td>
            </tr>
            <tr>
            <td style="padding: 8px; border-bottom: 1px solid #eee;"><strong>Date:</strong></td>
            <td style="padding: 8px; border-bottom: 1px solid #eee;">{booking.booking_date}</td>
            </tr>
            <tr>
            <td style="padding: 8px; border-bottom: 1px solid #eee;"><strong>Time:</strong></td>
            <td style="padding: 8px; border-bottom: 1px solid #eee;">{booking.start_time} - {booking.end_time}</td>
            </tr>
            <tr>
            <td style="padding: 8px; border-bottom: 1px solid #eee;"><strong>Requested On:</strong></td>
            <td style="padding: 8px; border-bottom: 1px solid #eee;">{booking.requested_on}</td>
            </tr>
            <tr>
            <td style="padding: 8px; border-bottom: 1px solid #eee;"><strong>Accessories:</strong></td>
            <td style="padding: 8px; border-bottom: 1px solid #eee;">{accessories_str}</td>
            </tr>
            <tr>
            <td style="padding: 8px;"><strong>Total Cost:</strong></td>
            <td style="padding: 8px;">₹{booking.cost}</td>
            </tr>
        </table>

        <div style="margin-top: 20px;">
            <a href="{approval_link}" style="background-color: #27ae60; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; margin-right: 10px;">Approve</a>
            <a href="{rejection_link}" style="background-color: #c0392b; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Reject</a>
        </div>

        <p style="margin-top: 30px; font-size: 13px; color: #888;">Note: Unapproved bookings will be auto-rejected in 2 days or less.</p>
        </div>
    </body>
    </html>
"""

    subject = "[LHC OFFICE] Booking Request Approval Needed"
    message = f"""
A new booking request has been submitted by {user.username}.

Purpose    : {booking.title}
Remarks    : {booking.remarks}
Room       : {booking.room.name}
Date       : {booking.booking_date}
Time       : {booking.start_time} - {booking.end_time}
Requested On: {booking.requested_on}
Accessories: {accessories_str}
Total Cost : ₹{booking.cost}

Approve: {approval_link}
Reject:  {rejection_link}

Note: Unapproved bookings will be auto-rejected in 2 days or less.
    """

    send_email_in_background(
        subject,
        message,
        from_email=settings.DEFAULT_FROM_EMAIL,
        recipient_list=[authority_email],
        html_message=html_message
    )

def send_rejected_mail_to_user(booking):
    html_message = f"""
<html>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
    <div style="max-width: 600px; margin: auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);">
        <h2 style="color: #c0392b;">Booking Rejected ❌</h2>
        
        <p>Dear <strong>{booking.creator.username}</strong>,</p>

        <p>We regret to inform you that your booking request has been <strong style="color: #c0392b;">rejected</strong>.</p>

        <table style="width: 100%; margin-top: 15px; border-collapse: collapse;">
            <tr>
                <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Title:</strong></td>
                <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.title}</td>
            </tr>
            <tr>
                <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Room:</strong></td>
                <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.room.name}</td>
            </tr>
            <tr>
                <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Date:</strong></td>
                <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.booking_date}</td>
            </tr>
            <tr>
                <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Time:</strong></td>
                <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.start_time} - {booking.end_time}</td>
            </tr>
        </table>

        <p style="margin-top: 30px; font-size: 13px; color: #777;">If you have any questions or concerns, please contact the LHC Office.</p>
    </div>
</body>
</html>
"""

    send_email_in_background(
        subject='Booking Rejected',
        message=f"""
    Sorry, your booking request titled "{booking.title}" at {booking.room.name} for date {booking.booking_date} has been rejected.
        """,  # Plain text fallback
        from_email=settings.DEFAULT_FROM_EMAIL,
        recipient_list=[booking.creator.email],
        html_message=html_message
    )
def send_approved_mail_to_user(booking):
    calender_link = booking.get_google_calendar_link()
    html_message = f"""
    <html>
    <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
        <div style="max-width: 600px; margin: auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);">
        <h2 style="color: #2c3e50;">Booking Approved ✅</h2>
        
        <p>Dear <strong>{booking.creator.username}</strong>,</p>

        <p>Your booking request has been <strong style="color: #27ae60;">approved</strong>.</p>

        <table style="width: 100%; margin-top: 15px; border-collapse: collapse;">
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Title:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.title}</td>
            </tr>
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Room:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.room.name}</td>
            </tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Start Time:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.start_time}</td>
            </tr>
            </tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Duration:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.duration}</td>
            </tr>
            <tr>
            <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>Date:</strong></td>
            <td style="padding: 10px; border-bottom: 1px solid #eee;">{booking.booking_date}</td>
            </tr>
            <tr>
            <td style="padding: 10px;"><strong>Bill Amount:</strong></td>
            <td style="padding: 10px;">₹{booking.cost}</td>
            </tr>
        </table>
        <p>Please provide feedback to improve the LHC service</p>
        <a href="http://172.27.16.252:5174/feedback" style="display: inline-block; padding: 12px 20px; background-color: #27ae60; color: white; text-decoration: none; border-radius: 6px; font-weight: bold;">
        Feedback
        </a>
        <div style="margin-top: 25px;">
            <a href="{calender_link}" style="display: inline-block; padding: 12px 20px; background-color: #4285F4; color: white; text-decoration: none; border-radius: 6px; font-weight: bold;">
            ➕ Add to Google Calendar
            </a>
        </div>

        <p style="margin-top: 30px; font-size: 13px; color: #777;">If you have any questions or concerns, please contact the LHC Office.</p>
        </div>
    </body>
    </html>
    """

    send_email_in_background(
    subject = 'Booking Approved',
    message = f"""
    Your booking request titled {booking.title} at {booking.room.name} for date {booking.booking_date} has been approved.
    Your bill amount is : ₹{booking.cost}
    
    
    Add This Event to your Calender: {calender_link}
    """,
    from_email= settings.DEFAULT_FROM_EMAIL,
    recipient_list= [booking.creator.email],
    html_message= html_message
    )
    
