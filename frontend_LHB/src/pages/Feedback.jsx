import React from 'react'

// TODO: Backend Integration Comments:

// 1. Feedback Submission:
// - Replace placeholder with actual feedback form
// - Create src/api/feedback.js for feedback endpoints
// - Implement POST /api/feedback with proper validation
// - Include booking reference if feedback is related to specific booking

// 2. Form Implementation:
// - Add form fields:
//   a) Feedback category/type dropdown
//   b) Rating system (stars, numeric)
//   c) Detailed comments text area
//   d) Optional: attachments for screenshots/evidence

// 3. Validation:
// - Require minimum length for meaningful feedback
// - Validate all fields before submission
// - Prevent spam submissions (rate limiting)

// 4. Success Handling:
// - Show success message after submission
// - Clear form or provide option to submit another feedback
// - Optionally redirect to dashboard

// 5. Previous Feedback:
// - Fetch and display user's previous feedback submissions
// - Allow viewing responses to past feedback
// - Implement GET /api/feedback/history

// 6. Admin Response:
// - For admin users, show interface to respond to feedback
// - Implement POST /api/admin/feedback/{id}/respond
// - Add status indicators for responded/unresponded feedback

import { useState } from 'react';
import './Feedback.css';

const Feedback = () => {
  const [rating, setRating] = useState(0);
  const [feedback, setFeedback] = useState('');
  const [wordCount, setWordCount] = useState(0);

  const handleStarClick = (star) => {
    setRating(star);
  };

  const handleFeedbackChange = (event) => {
    const text = event.target.value;
    setFeedback(text);
    setWordCount(text.split(/\s+/).filter(Boolean).length);
  };

  const handleSubmit = () => {
    if (wordCount > 100) {
      alert('Feedback must be under 100 words.');
      return;
    }
    alert(`Thank you for your feedback!\nRating: ${rating} stars\nFeedback: ${feedback}`);
  };

  return (
    <div className="feedback-container">
      <h2>Rate Your Experience</h2>
      <div className="stars">
        {[1, 2, 3, 4, 5].map((star) => (
          <span
            key={star}
            className={`star ${star <= rating ? 'active' : ''}`}
            onClick={() => handleStarClick(star)}
          >
            ★
          </span>
        ))}
      </div>
      <h2>Your Feedback</h2>
      <textarea
        placeholder="Enter your feedback (max 100 words)"
        value={feedback}
        onChange={handleFeedbackChange}
      />
      <p>{wordCount} / 100 words</p>
      <button onClick={handleSubmit}>Submit Feedback</button>
    </div>
  );
};

export default Feedback;
