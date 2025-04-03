import React, { useState } from 'react';
import {
  ThumbsUp,
  ThumbsDown,
  Smile,
  Meh,
  Star,
  Send,
  MessageCircle,
  CheckCircle
} from 'lucide-react';
import { motion } from 'framer-motion';
import './Feedback.css';
const Feedback = () => {
  const [overallSatisfaction, setOverallSatisfaction] = useState(null);
  const [facilitySatisfaction, setFacilitySatisfaction] = useState(null);
  const [bookingExperience, setBookingExperience] = useState(null);
  const [additionalComments, setAdditionalComments] = useState('');
  const [isSubmitted, setIsSubmitted] = useState(false);
  const handleSubmit = async (e) => {
    e.preventDefault();
    const formData = {
      overallSatisfaction: overallSatisfaction,
      facilitySatisfaction: facilitySatisfaction,
      bookingExperience: bookingExperience,
      additionalComments: additionalComments
    };
    console.log({
      overallSatisfaction,
      facilitySatisfaction,
      bookingExperience,
      additionalComments
    });
    try {
      // Make a POST request to the backend
      const token = localStorage.getItem(ACCESS_TOKEN);
      if (!token) {
        console.log("here")
        console.error("No token found. User is not authenticated.");
        return;
      }
      const response = await api.post(import.meta.env.VITE_FEEDBACK_URL, formData, {
        headers: {
          Authorization: `Bearer ${token}`, // Add token in the header
          'Content-Type': 'application/json', // Ensure the server knows you're sending JSON data
          'Accept': 'application/json', // Optional: to specify that you expect JSON in response
        }
      });

      if(response.status === 200 || response.status === 201){
        console.log('Feedback submitted successfully!');
        setIsSubmitted(true);
      } else {
        console.error('Failed to submit feedback');
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };
  const renderSatisfactionIcons = (currentValue, setValue) => (
    <div className="satisfaction-icons">
      <ThumbsDown
        className={`satisfaction-icon ${currentValue === 'negative' ? 'selected negative' : ''}`}
        onClick={() => setValue('negative')}
      />
      <Meh
        className={`satisfaction-icon ${currentValue === 'neutral' ? 'selected neutral' : ''}`}
        onClick={() => setValue('neutral')}
      />
      <ThumbsUp
        className={`satisfaction-icon ${currentValue === 'positive' ? 'selected positive' : ''}`}
        onClick={() => setValue('positive')}
      />
    </div>
  );
  const renderStarRating = (currentValue, setValue) => (
    <div className="star-rating">
      {[1, 2, 3, 4, 5].map((star) => (
        <Star
          key={star}
          className={`star-icon ${currentValue >= star ? 'filled' : ''}`}
          onClick={() => setValue(star)}
        />
      ))}
    </div>
  );
  if (isSubmitted) {
    return (
      <motion.div
        className="feedback-submission-success"
        initial={{ opacity: 0, scale: 0.8 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.5 }}
      >
        <CheckCircle className="success-icon" />
        <h2>Thank You for Your Feedback!</h2>
        <p>Your input helps us improve our services.</p>
        <motion.button
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          onClick={() => setIsSubmitted(false)}
          className="reset-button"
        >
          Submit Another Feedback
        </motion.button>
      </motion.div>
    );
  }
  return (
    <motion.div
      className="feedback-container"
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6 }}
    >
      <motion.div className="feedback-form" layout>
        <motion.div className="feedback-header" initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.3 }}>
          <Smile size={36} />
          <h1>Help us make the lecture hall booking experience even better!</h1>
        </motion.div>
        <div className="feedback-section">
          <div className="feedback-label"><Smile className="label-icon" /> Overall Satisfaction</div>
          {renderSatisfactionIcons(overallSatisfaction, setOverallSatisfaction)}
        </div>
        <div className="feedback-section">
          <div className="feedback-label"><Star className="label-icon" /> Facility Rating</div>
          {renderStarRating(facilitySatisfaction, setFacilitySatisfaction)}
        </div>
        <div className="feedback-section">
          <div className="feedback-label"><MessageCircle className="label-icon" /> Booking Experience</div>
          {renderSatisfactionIcons(bookingExperience, setBookingExperience)}
        </div>
        <div className="feedback-section">
          <div className="feedback-label"><MessageCircle className="label-icon" /> Additional Comments</div>
          <textarea
            value={additionalComments}
            onChange={(e) => setAdditionalComments(e.target.value)}
            placeholder="Share your thoughts..."
            className="feedback-textarea"
            rows={4}
          />
        </div>
        <motion.button
          type="submit"
          className="submit-button"
          onClick={handleSubmit}
          disabled={!overallSatisfaction || !facilitySatisfaction || !bookingExperience}
          whileHover={{ scale: 1.02 }}
          whileTap={{ scale: 0.98 }}
        >
          <Send className="send-icon" /> Submit Feedback
        </motion.button>
      </motion.div>
    </motion.div>
  );
};
export default Feedback;
