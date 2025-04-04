import os
import sys
import django
from datetime import datetime

# Set path and environment
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "lhbookportal.settings")
django.setup()

from apps.bookings.models import Holiday  # Adjust if needed

# Holiday data: (Name, Date in 'Month Day')
holiday_data = [
    ("Republic Day", "January 26"),
    ("Maha Shivaratri", "March 08"),
    ("Holi", "March 25"),
    ("Good Friday", "March 29"),
    ("Id-ul-Fitr", "April 11"),
    ("Mahavir Jayanti", "April 21"),
    ("Budha Purnirna", "May 23"),
    ("Id-ul-Zuha (Bakrid)", "June 17"),
    ("Muharram", "July 17"),
    ("Independence Day", "August 15"),
    ("Janmashtami (Vaishnva)", "August 26"),
    ("Milad-un-Nabi or Id-e-Milad (Birthday of Prophet Mohammad)", "September 16"),
    ("Mahatma Gandhi's Birthday", "October 02"),
    ("Dussehra", "October 12"),
    ("Diwali (Deepavali)", "October 31"),
    ("Guru Nanak's Birthday", "November 15"),
    ("Christmas Day", "December 25"),
]

def create_fixed_holidays(year=2025):
    for name, date_str in holiday_data:
        # Convert "Month Day" to datetime.date
        full_date_str = f"{date_str} {year}"
        date_obj = datetime.strptime(full_date_str, "%B %d %Y").date()

        holiday, created = Holiday.objects.get_or_create(date=date_obj, defaults={"name": name})
        if created:
            print(f"✅ Created: {holiday.name} on {holiday.date}")
        else:
            print(f"⚠️ Already exists: {holiday.name} on {holiday.date}")

if __name__ == "__main__":
    create_fixed_holidays()
