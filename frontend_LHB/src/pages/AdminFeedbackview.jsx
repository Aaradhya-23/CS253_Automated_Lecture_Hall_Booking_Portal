import React, { useEffect, useState } from 'react';
// import Header from '../components/Header';
// import Navbar from '../components/AdminNavbar';
// import api from '../api'; // your axios instance
import { ACCESS_TOKEN } from '../api/constants';
// import React, { useState, useEffect } from 'react';
import api from '../api/api';
// import './adminfeedback.css'; // optional: for custom styling

const AdminFeedbackView = () => {
  const [feedbacks, setFeedbacks] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchFeedbacks = async () => {
      try {
        const token = localStorage.getItem('ACCESS_TOKEN');
        const response = await api.get(import.meta.env.VITE_FEEDBACK_URL, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        setFeedbacks(response.data);
      } catch (error) {
        console.error("Error fetching feedbacks:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchFeedbacks();
  }, []);

  return (
    <div>
      <div className="p-6">
        <h1 className="text-2xl font-bold mb-4">User Feedbacks</h1>
        {loading ? (
          <p>Loading feedbacks...</p>
        ) : feedbacks.length === 0 ? (
          <p>No feedbacks available.</p>
        ) : (
          <div className="space-y-4">
            {feedbacks.map((fb) => (
              <div key={fb.id} className="p-4 rounded-lg shadow-md border">
                <p><strong>User:</strong> {fb.user.username}</p>
                <p><strong>Rating:</strong> {fb.rating}</p>
                <p><strong>Booking Experience:</strong> {fb.booking_experience}</p>
                <p><strong>Overall Satisfaction:</strong> {fb.overall_satisfaction}</p>
                <p><strong>Comment:</strong> {fb.comment}</p>
                <p className="text-sm text-gray-500"><strong>Date:</strong> {new Date(fb.created_at).toLocaleString()}</p>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default AdminFeedbackView;
