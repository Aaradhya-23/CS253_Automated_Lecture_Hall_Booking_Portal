from django import forms
from .models import BookingRequestPreConfirmation

class BookingRequestForm(forms.ModelForm):
    class Meta:
        model = BookingRequestPreConfirmation
        fields = ['booking']

class AuthorityResponseForm(forms.Form):
    status = forms.ChoiceField(choices=[('confirmed', 'Confirmed'), ('rejected', 'Rejected')])
    remark = forms.CharField(widget=forms.Textarea, required=False)