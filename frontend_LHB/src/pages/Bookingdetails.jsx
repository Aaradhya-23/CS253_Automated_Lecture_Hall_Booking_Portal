import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../api/api'; // Replace with your actual api import
import './Bookingdetails.css';
import FRONTEND_ROUTES from '../frontend_urls';
// Transformation function (same as described previously)
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
      approvalStatus: booking.status === 'approved' ? 'Approved' : 'Pending',
      room: `LHC - ${booking.room_details.name}`,
      Time: `${convertTo12HourFormat(booking.start_time)}-“${convertTo12HourFormat(booking.end_time)}`,
      date: `${booking.booking_date}`,
      duration: `${booking.duration} hour`,
      type: booking.Type,
      createdBy: booking.creator.username,
      lastUpdated: booking.requested_on,
      audioVideo: booking.need_projector ? 'YES' : 'NO',
      imageUrl: '/images/lecture-hall.jpg', // Static image URL for now
    };
  });
};

function Bookingdetails() {
  const { id } = useParams(); // Get the booking ID from URL
  const navigate = useNavigate();
  const [bookingData, setBookingData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // Example: fetch booking data by ID (if using a route param or a fixed ID)
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

        // Transform the data before setting it to state
        const transformedBookingData = transformBookingData([response.data]);

        setBookingData(transformedBookingData[0]); // Assuming the response is an array
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


  const handleRemoveBooking = async (id) => {
    console.log(`Removing booking with ID: ${id}`);
    const token = localStorage.getItem('ACCESS_TOKEN');
    try {
        await api.post(
            `${import.meta.env.VITE_API_BASE_URL}bookings/send-rejected-mail/${id}/`,
            { remark: "Your booking was removed by admin" },  // Fixed remark
            {
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                    Accept: "application/json",
                },
            }
        );
        console.log(`Rejection email sent for booking ${id}.`);
        alert("Booking removed, email sent to user.");
        window.location.href = FRONTEND_ROUTES.adminViewBooking;
        setOpenDropdownId(null);
    } catch (error) {
        console.error("Error removing booking:", error);
        alert("Error removing booking. Please try again.");
    }
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div style={{ color: 'red' }}>{error}</div>;

  return (
    <div className="bd-container">
      <button
        onClick={handleBack}
        className="bd-back-button"
      >
        ← Back to Bookings
      </button>
     
      <h1 className="bd-title">Booking Details</h1>
     
      {bookingData ? (
        <div className="bd-card">
          <div className="bd-grid">
            <div className="bd-detail-item">
              <h3 className="bd-label">Booking ID</h3>
              <p className="bd-value">{bookingData.id}</p>
            </div>
            <div className="bd-detail-item">
              <h3 className="bd-label">Date</h3>
              <p className="bd-value">{bookingData.date}</p>
            </div>
            <div className="bd-detail-item">
              <h3 className="bd-label">Time</h3>
              <p className="bd-value">{bookingData.Time}</p>
            </div>
            <div className="bd-detail-item">
              <h3 className="bd-label">Duration</h3>
              <p className="bd-value">{bookingData.duration}</p>
            </div>
            <div className="bd-detail-item">
              <h3 className="bd-label">Room</h3>
              <p className="bd-value">{bookingData.room}</p>
            </div>
            <div className="bd-detail-item">
              <h3 className="bd-label">Username</h3>
              <p className="bd-value">{bookingData.createdBy}</p>
            </div>
            <div className="bd-detail-item">
              <h3 className="bd-label">Title</h3>
              <p className="bd-value">{bookingData.title}</p>
            </div>
            <div className="bd-detail-item">
              <h3 className="bd-label">Status</h3>
              <p className="bd-value bd-status">{bookingData.approvalStatus}</p>
            </div>
          </div>
         
          <div className="bd-actions">
            {/* <button onClick={handleEdit} className="bd-edit-button">
              Edit Booking
            </button> */}
            <button onClick={()=>handleRemoveBooking(bookingData.id)} className="bd-delete-button">
              Cancel Booking
            </button>
          </div>
        </div>
      ) : (
        <div className="bd-loading">
          <p className="bd-loading-text">Loading booking details...</p>
        </div>
      )}
    </div>
  );
}
  
export default Bookingdetails;