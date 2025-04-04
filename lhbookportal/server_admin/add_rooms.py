import django
import random
from django.utils import timezone
import os
import sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "lhbookportal.settings")
django.setup()

from apps.bookings.models import Room

accessory_keys = ["AC", "MIC", "BIOMETRIC", "BLACKBOARD", "PROJECTOR"]

def generate_random_accessories():
    return {key: random.choice([True, False]) for key in accessory_keys}

def create_room_entries(n=10):
    for j in range(5):
        room = Room(
            name="TB-" + str(j + 1),
            capacity=5 * (j + 1),
            room_type="tutorial",
            accessories=generate_random_accessories(),
            price_per_hour=15 * (j + 2)
        )
        room.save()
        print(f"Created Room ID: {room.id}, Name: {room.name}")

if __name__ == "__main__":
    create_room_entries(20)  # Create 20 room entries
