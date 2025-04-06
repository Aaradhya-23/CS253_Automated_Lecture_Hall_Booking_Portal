import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../api/api';
import './Bookingdetails.css';
import FRONTEND_ROUTES from '../frontend_urls';
import { motion } from 'framer-motion';
// Transformation function
const convertTo12HourFormat = (time) => {
  const [hours, minutes] = time.split(':').map(Number);
  const period = hours >= 12 ? 'PM' : 'AM';
  const hour12 = hours % 12 || 12;
  return `${hour12}:${String(minutes).padStart(2, '0')} ${period}`;
};
const transformBookingData = (backendBookingData) => {
  return backendBookingData.map(booking => {
    return {
      id: booking.id,
      title: booking.title,
      approvalStatus: booking.status === 'Approved' || booking.status === 'approved'  ? 'Approved' : 'Pending',
      room: `LHC - ${booking.room_details.name}`,
      Time: `${convertTo12HourFormat(booking.start_time)}-${convertTo12HourFormat(booking.end_time)}`,
      date: `${booking.booking_date}`,
      duration: `${booking.duration} hour`,
      type: booking.Type,
      createdBy: booking.creator.username,
      lastUpdated: booking.requested_on,
      audioVideo: booking.need_projector ? 'YES' : 'NO',
      imageUrl: '/images/lecture-hall.jpg',
    };
  });
};
function BookingDetails() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [bookingData, setBookingData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [showConfirmation, setShowConfirmation] = useState(false);
  useEffect(() => {
    const fetchBooking = async () => {
      setLoading(true);
      setError(null);
      const token = localStorage.getItem('ACCESS_TOKEN');
      if (!token) {
        console.error("No ACCESS_TOKEN found in localStorage.");
        setError("User not authenticated. Please log in.");
        setLoading(false);
        return;
      }
      try {
        const url = `${import.meta.env.VITE_BOOKING_DETAIL_URL.replace('<int:pk>', id)}`;
        const response = await api.get(url, {
          headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json',
            Accept: 'application/json',
          },
        });
        console.log("Fetched Bookings:", response.data);
        const transformedBookingData = transformBookingData([response.data]);
        setBookingData(transformedBookingData[0]);
      } catch (err) {
        setError('Failed to fetch booking details.');
      } finally {
        setLoading(false);
      }
    };
    fetchBooking();
  }, [id]);
  const handleBack = () => {
    navigate('/admin-view-booking');
  };
  const toggleConfirmation = () => {
    setShowConfirmation(!showConfirmation);
  };
  const handleRemoveBooking = async (id) => {
    console.log(`Removing booking with ID: ${id}`);
    const token = localStorage.getItem('ACCESS_TOKEN');
    try {
      await api.post(
        `${import.meta.env.VITE_API_BASE_URL}bookings/send-rejected-mail/${id}/`,
        { remark: "Your booking was removed by admin" },
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        }
      );
      console.log(`Rejection email sent for booking ${id}.`);

      // Show success notification
      const notification = document.createElement('div');
      notification.className = 'bd-notification bd-success';
      notification.textContent = 'Booking successfully removed!';
      document.body.appendChild(notification);

      setTimeout(() => {
        notification.remove();
        window.location.href = FRONTEND_ROUTES.adminViewBooking;
      }, 3000);
    } catch (error) {
      console.error("Error removing booking:", error);

      // Show error notification
      const notification = document.createElement('div');
      notification.className = 'bd-notification bd-error';
      notification.textContent = 'Error removing booking. Please try again.';
      document.body.appendChild(notification);

      setTimeout(() => notification.remove(), 3000);
    }
  };
  if (loading) return (
    <div className="bd-loading-container">
      <div className="bd-loader">
        <div className="bd-loader-circle"></div>
        <div className="bd-loader-circle"></div>
        <div className="bd-loader-circle"></div>
      </div>
      <p className="bd-loading-text">Loading booking details...</p>
    </div>
  );

  if (error) return (
    <div className="bd-error-container">
      <div className="bd-error-icon">!</div>
      <p className="bd-error-text">{error}</p>
      <button onClick={() => navigate('/admin-view-booking')} className="bd-error-button">
        Return to Bookings
      </button>
    </div>
  );
  return (
    <div className="bd-container">
      <motion.button
        onClick={handleBack}
        className="bd-back-button"
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
        initial={{ x: -20, opacity: 0 }}
        animate={{ x: 0, opacity: 1 }}
      >
        <span className="bd-back-icon">←</span> Back to Bookings
      </motion.button>

      <motion.h1
        className="bd-title"
        initial={{ y: -20, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ delay: 0.1 }}
      >
        Booking Details
      </motion.h1>

      {bookingData && (
        <motion.div
          className="bd-card"
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ delay: 0.2 }}
        >
          <div className="bd-header">
            <div className="bd-header-content">
              <h2 className="bd-booking-title">{bookingData.title}</h2>
              <span className={`bd-status-badge ${bookingData.approvalStatus.toLowerCase()}`}>
                {bookingData.approvalStatus}
              </span>
            </div>
            <div className="bd-booking-id">
              <span className="bd-id-label">ID:</span> {bookingData.id}
            </div>
          </div>

          <div className="bd-main-info">
            <div className="bd-info-section">
              <div className="bd-info-icon">📅</div>
              <div className="bd-info-content">
                <h3 className="bd-info-label">Date & Time</h3>
                <p className="bd-info-value">{bookingData.date}</p>
                <p className="bd-info-value">{bookingData.Time}</p>
                <p className="bd-info-secondary">{bookingData.duration}</p>
              </div>
            </div>

            <div className="bd-info-section">
              <div className="bd-info-icon">🏢</div>
              <div className="bd-info-content">
                <h3 className="bd-info-label">Location</h3>
                <p className="bd-info-value">{bookingData.room}</p>
              </div>
            </div>

            <div className="bd-info-section">
              <div className="bd-info-icon">👤</div>
              <div className="bd-info-content">
                <h3 className="bd-info-label">Created By</h3>
                <p className="bd-info-value">{bookingData.createdBy}</p>
              </div>
            </div>
          </div>

          <div className="bd-actions">
            <motion.button
              onClick={toggleConfirmation}
              className="bd-delete-button"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <span className="bd-button-icon">✕</span> Cancel Booking
            </motion.button>
          </div>

          {showConfirmation && (
            <motion.div
              className="bd-confirmation-overlay"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
            >
              <motion.div
                className="bd-confirmation-modal"
                initial={{ scale: 0.8, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
              >
                <h3 className="bd-confirmation-title">Confirm Cancellation</h3>
                <p className="bd-confirmation-text">
                  Are you sure you want to cancel this booking?
                  This action cannot be undone.
                </p>
                <div className="bd-confirmation-buttons">
                  <motion.button
                    onClick={toggleConfirmation}
                    className="bd-confirm-cancel"
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                  >
                    No, Keep Booking
                  </motion.button>
                  <motion.button
                    onClick={() => handleRemoveBooking(bookingData.id)}
                    className="bd-confirm-proceed"
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                  >
                    Yes, Cancel Booking
                  </motion.button>
                </div>
              </motion.div>
            </motion.div>
          )}
        </motion.div>
      )}
    </div>
  );
}

export default BookingDetails;