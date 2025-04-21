import django
import random
from django.utils import timezone
import os
import sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "lhbookportal.settings")
django.setup()

from apps.bookings.models import Room

accessory_keys = ["AC", "microphone", "blackboard", "projector"]

def generate_random_accessories():
    return {key: random.choice([True, False]) for key in accessory_keys}

def create_room_entries(n=10):
    for j in range(5):
        room = Room(
            name="L-" + str(j + 3),
            capacity=50 * (j + 1),
            room_type="lecture_hall",
            accessories=generate_random_accessories(),
            price_per_hour=800 * (j + 2)
        )
        # print(f"Created Room ID: {room.id}, Name: {room.name}")
        room.save()

if __name__ == "__main__":
    create_room_entries(20)  # Create 20 room entries
