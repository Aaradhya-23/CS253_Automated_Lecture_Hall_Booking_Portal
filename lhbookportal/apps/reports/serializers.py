
from rest_framework import serializers

from .models import *




class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        read_only_fields = ['user', 'created_at']  # Fields not set by the user
        fields = '__all__'
        depth = 1
    def validate(self, data):
        rating = data.get('rating')
        print(rating, data)
        booking_experiece = data.get('booking_experience')
        overall_satisfaction = data.get('overall_satisfaction')
        
        if rating > 5 or rating < 1: raise serializers.ValidationError("Invalid Rating")
        if booking_experiece not in [1, 2 , 3]: raise serializers.ValidationError("Invalid Input")
        if overall_satisfaction not in [1, 2 , 3]: raise serializers.ValidationError("Invalid Input")
        return data
        
         
         
    

