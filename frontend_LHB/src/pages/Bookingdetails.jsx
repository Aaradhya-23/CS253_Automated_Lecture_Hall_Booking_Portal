import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import axios from 'axios'; // or your preferred HTTP client
import './Bookingdetails.css'; // Import the CSS file

function Bookingdetails() {
  const { id } = useParams(); // Get the booking ID from URL
  const navigate = useNavigate();
  const [bookingData, setBookingData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

// Example: fetch booking data by ID (if using a route param or a fixed ID)
  useEffect(() => {
    const fetchBooking = async () => {
      try {
        // Replace with your actual API endpoint, e.g.:
        // const { data } = await axios.get(`/api/bookings/${id}`);
        const data = {
          // Sample data to demonstrate the layout
          id: id,
          title: 'ECO111',
          approvalStatus: 'Approved',
          room: `LHC - L${id}`,
          startTime: '12:00 PM - Wednesday, 05 February 2025',
          endTime: '01:00 PM - Wednesday, 05 February 2025',
          duration: '1 hour',
          type: 'Academic',
          createdBy: 'lhc',
          lastUpdated: '10:15:00 AM - Saturday, 23 November 2024',
          audioVideo: 'YES',
          modifiedBy: 'prof',
          repeatDay: 'Weekly',
          repeatWeekday: 'Monday Tuesday Wednesday Thursday',
          repeatEndDate: 'Wednesday, 23 April 2025',
          // URL or path to the image of the lecture hall
          imageUrl: '/images/lecture-hall.jpg',
        };
        setBookingData(data);
      } catch (err) {
        setError('Failed to fetch booking details.');
      } finally {
        setLoading(false);
      }
    };

    fetchBooking();
  }, [id]);

  const handleBack = () => {
    navigate('/admin_view_booking');
  };

  const handleEdit = () => {
    // Implement your edit logic
    console.log(`Editing booking ${bookingData?.id}`);
  };

  const handleDelete = () => {
    // Implement your delete logic
    console.log(`Deleting booking ${bookingData?.id}`);
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
              <p className="font-semibold">{bookingData.startTime}</p>
            </div>
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">Time</h3>
              <p className="font-semibold">{bookingData.startTime}</p>
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
              <h3 className="text-gray-600">Professor</h3>
              <p className="font-semibold">{bookingData.modifiedBy}</p>
            </div>
            <div className="detail-item mb-4">
              <h3 className="text-gray-600">Course</h3>
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
            <button onClick={handleDelete} className="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600">
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
