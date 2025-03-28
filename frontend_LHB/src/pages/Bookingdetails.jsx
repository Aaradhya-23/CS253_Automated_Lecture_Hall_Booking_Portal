import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../api/api'; // Replace with your actual api import
import './Bookingdetails.css';
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
      room: `LHC - ${booking.room.name}`,
      Time: `${convertTo12HourFormat(booking.start_time)}–${convertTo12HourFormat(booking.end_time)}`,
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

  const handleEdit = () => {
    // Implement your edit logic
    console.log(`Editing booking ${bookingData?.id}`);
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

        // Close dropdown after successful removal
        setOpenDropdownId(null);
    } catch (error) {
        console.error("Error removing booking:", error);
        alert("Error removing booking. Please try again.");
    }
};

  if (loading) return <div>Loading...</div>;
  if (error) return <div style={{ color: 'red' }}>{error}</div>;

  return (
    <div className="booking-details-container p-4">
      <button 
        onClick={handleBack} 
        className="back-button mb-4 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
      >
        ← Back to Bookings
      </button>
      
      <h1 className="text-2xl font-bold mb-6">Booking Details</h1>
      
      {bookingData ? (
        <div className="booking-details-card bg-white p-6 rounded-lg shadow-md">
          <div className="grid grid-cols-2 gap-4">
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">Booking ID</h3>
              <p className="font-semibold">{bookingData.id}</p>
            </div>
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">Date</h3>
              <p className="font-semibold">{bookingData.date}</p>
            </div>
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">Time</h3>
              <p className="font-semibold">{bookingData.Time}</p>
            </div>
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">Duration</h3>
              <p className="font-semibold">{bookingData.duration}</p>
            </div>
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">Room</h3>
              <p className="font-semibold">{bookingData.room}</p>
            </div>
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">username</h3>
              <p className="font-semibold">{bookingData.createdBy}</p>
            </div>
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">Purpose</h3>
              <p className="font-semibold">{bookingData.title}</p>
            </div>
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">Status</h3>
              <p className="font-semibold text-green-600">{bookingData.approvalStatus}</p>
            </div>
          </div>
          
          <div className="mt-6 flex space-x-4">
            <button onClick={handleEdit} className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
              Edit Booking
            </button>
            <button onClick={() => handleRemoveBooking(bookingData.id)} className="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600">
              Cancel Booking
            </button>
          </div>
        </div>
      ) : (
        <div className="loading-indicator p-6 text-center">
          <p className="text-gray-600">Loading booking details...</p>
        </div>
      )}
    </div>
  );
}

export default Bookingdetails;
