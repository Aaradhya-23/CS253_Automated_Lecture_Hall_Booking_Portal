
import React, { useEffect, useState } from 'react';
import api from '../api/api';
import { motion } from 'framer-motion';
import { FaStar, FaRegStar, FaUserCircle, FaCalendarAlt, FaComment, FaThumbsUp } from 'react-icons/fa';
import './adminfeedback.css';
const AdminFeedbackView = () => {
  const [feedbacks, setFeedbacks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [sortBy, setSortBy] = useState('newest');
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
  // Filter feedbacks based on search term
  const filteredFeedbacks = feedbacks.filter(fb =>
    fb.user.username.toLowerCase().includes(searchTerm.toLowerCase()) ||
    fb.comment.toLowerCase().includes(searchTerm.toLowerCase())
  );
  // Sort feedbacks
  const sortedFeedbacks = [...filteredFeedbacks].sort((a, b) => {
    if (sortBy === 'newest') {
      return new Date(b.created_at) - new Date(a.created_at);
    } else if (sortBy === 'highest') {
      return b.rating - a.rating;
    } else if (sortBy === 'lowest') {
      return a.rating - b.rating;
    }
    return 0;
  });
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1
      }
    }
  };
  const itemVariants = {
    hidden: { y: 20, opacity: 0 },
    visible: {
      y: 0,
      opacity: 1,
      transition: {
        type: "spring",
        stiffness: 100
      }
    }
  };
  const renderStars = (rating) => {
    const stars = [];
    for (let i = 1; i <= 5; i++) {
      stars.push(
        i <= rating ?
          <FaStar key={i} className="star star-filled star-animation" /> :
          <FaRegStar key={i} className="star star-empty star-animation" />
      );
    }
    return <div className="star-rating">{stars}</div>;
  };
  return (
    <div className="admin-feedback-container">
      <div className="feedback-wrapper">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
          className="feedback-header"
        >
          <h1 className="page-title">User Feedbacks</h1>
          <div className="header-controls">
            <div className="search-container">
              <input
                type="text"
                placeholder="Search feedbacks..."
                className="search-input"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
              <span className="search-icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                  <path fillRule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clipRule="evenodd" />
                </svg>
              </span>
            </div>
            <select
              className="sort-select"
              value={sortBy}
              onChange={(e) => setSortBy(e.target.value)}
            >
              <option value="newest">Newest First</option>
              <option value="highest">Highest Rating</option>
              <option value="lowest">Lowest Rating</option>
            </select>
          </div>
        </motion.div>
        {loading ? (
          <div className="loading-container">
            <motion.div
              animate={{ rotate: 360 }}
              transition={{ duration: 1, repeat: Infinity, ease: "linear" }}
              className="loading-spinner"
            />
          </div>
        ) : sortedFeedbacks.length === 0 ? (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="empty-state"
          >
            <svg xmlns="http://www.w3.org/2000/svg" className="empty-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
            </svg>
            <h3 className="empty-title">No Feedbacks Available</h3>
            <p className="empty-description">No feedback records were found in the system.</p>
          </motion.div>
        ) : (
          <motion.div
            variants={containerVariants}
            initial="hidden"
            animate="visible"
            className="feedback-grid"
          >
            {sortedFeedbacks.map((fb) => (
              <motion.div
                key={fb.id}
                variants={itemVariants}
                whileHover={{ scale: 1.02, boxShadow: "0 10px 25px -5px rgba(0, 0, 0, 0.1)" }}
                className="feedback-card"
              >
                <div className="card-content">
                  <div className="card-header">
                    <div className="user-info">
                      <div className="user-icon-container">
                        <FaUserCircle className="user-icon" />
                      </div>
                      <div>
                        <h3 className="username">{fb.user.username}</h3>
                        <div className="date-info">
                          <FaCalendarAlt className="date-icon" />
                          <span>{new Date(fb.created_at).toLocaleDateString()}</span>
                        </div>
                      </div>
                    </div>
                    <div className="rating-container">
                      {renderStars(fb.rating)}
                    </div>
                  </div>

                  <div className="feedback-details">
                    <div className="feedback-item">
                      <div className="icon-container icon-green">
                        <FaThumbsUp className="feedback-icon" />
                      </div>
                      <div className="item-content">
                        <p className="item-label">Booking Experience</p>
                        <p className="item-value">{fb.booking_experience}</p>
                      </div>
                    </div>

                    <div className="feedback-item">
                      <div className="icon-container icon-purple">
                        <svg xmlns="http://www.w3.org/2000/svg" className="feedback-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                      </div>
                      <div className="item-content">
                        <p className="item-label">Overall Satisfaction</p>
                        <p className="item-value">{fb.overall_satisfaction}</p>
                      </div>
                    </div>

                    <div className="feedback-item">
                      <div className="icon-container icon-yellow">
                        <FaComment className="feedback-icon" />
                      </div>
                      <div className="item-content">
                        <p className="item-label">Comment</p>
                        <p className="item-value">{fb.comment}</p>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="card-footer">
                  <p className="timestamp">
                    Submitted on {new Date(fb.created_at).toLocaleString()}
                  </p>
                </div>
              </motion.div>
            ))}
          </motion.div>
        )}
      </div>
    </div>
  );
};
export default AdminFeedbackView;   