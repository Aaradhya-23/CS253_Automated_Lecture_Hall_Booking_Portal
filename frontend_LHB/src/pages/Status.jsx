import React, { useState, useEffect } from 'react';
import { Check, Clock, X, AlertCircle, UserCheck, UserCog, BookUser } from 'lucide-react';
import './Status.css';
import api from '../api/api';
// Status icon component
const StatusIcon = ({ status }) => {
  const iconMap = {
    'approved': <Check className="st-status-icon st-approved" />,
    'pending': <Clock className="st-status-icon st-pending" />,
    'rejected': <X className="st-status-icon st-rejected" />,
    'notsubmitted': <AlertCircle className="st-status-icon st-not-submitted" />
  };

  return iconMap[status] || null;
};

function Status() {
  const [bookingData, setBookingData] = useState(null);
  const [loading, setLoading] = useState(true);
  // const [authorities, setAuthorities] = useState([
  //   {
  //     name: 'Faculty Advisor',
  //     role: 'Academic Approval',
  //     icon: <BookUser />,
  //     status: 'Approved'
  //   },
  //   {
  //     name: 'DOAA',
  //     role: 'Department Approval',
  //     icon: <UserCog />,
  //     status: 'Pending'
  //   },
  //   {
  //     name: 'Gen Sec',
  //     role: 'Administrative Approval',
  //     icon: <UserCheck />,
  //     status: 'Not Submitted'
  //   }
  // ]);
  const [authorities, setAuthorities] = useState([
    {
      name: 'Current Authority',
      role: "Primary Authority Verifier",
    }
  ])

  const convertTo12HourFormat = (time) => {
    const [hours, minutes] = time.split(':').map(Number);
    const period = hours >= 12 ? 'PM' : 'AM';
    const hour12 = hours % 12 || 12;
    return `${hour12}:${String(minutes).padStart(2, '0')} ${period}`;
  };

  useEffect(() => {
    // Simulated data fetch

    const fetchBooking = async () => {
      const token = localStorage.getItem('ACCESS_TOKEN');
      const username = localStorage.getItem('USERNAME')
      if (!token) {
        console.error("No ACCESS_TOKEN found in localStorage.");
        setError("User not authenticated. Please log in.");
        setLoading(false);
        return;
      }
      try {
        const url = `${import.meta.env.VITE_BOOKING_SEARCH_URL}?creator__username=${username}&status=pending`;       
         const response = await api.get(url, {
          headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json',
            Accept: 'application/json',
          },
        });

        console.log("Fetched Bookings:", response.data[0]);
        const latestBooking = response.data[0];
        setBookingData({
          id: latestBooking.id,
          title: latestBooking.title,
          room: latestBooking.room_details.name,
          date: latestBooking.booking_date, // change for easy readability
          time: `${convertTo12HourFormat(latestBooking.start_time)} - ${convertTo12HourFormat(latestBooking.end_time)}`, 
          duration: `${latestBooking.duration} hour`,
          type: latestBooking.Type,
          createdBy: latestBooking.creator.username,
          overallStatus: latestBooking.status
        }); // Assuming the response is an array
        console.log("booking data: ", bookingData)
      } catch (err) {
        console.log(err)
      } finally {
        setLoading(false);
      }
    };

    fetchBooking();
  }, []);


  //   const mockData = {
  //     id: 'ECO111-2025',
  //     title: 'Economics 101 Lecture',
  //     room: 'LHC - L101',
  //     date: 'Wednesday, 05 February 2025',
  //     time: '12:00 PM - 01:00 PM',
  //     duration: '1 hour',
  //     type: 'Academic',
  //     createdBy: 'Prof. Smith',
  //     overallStatus: 'Partially Approved'
  //   };

  //   setBookingData(mockData);
  //   setLoading(false);
  // }, []);

  return (
    <div className="st-booking-details-container">
      {loading ? (
      <div className="st-loading-message">Loading...</div>
    ) : !bookingData ? (
      <div className="st-no-data-message">
        <h2>No active pending requests</h2>
        <p>Please request some bookings to view their status.</p>
      </div>
    ) : (
      <>
      <div className="st-booking-header">
        <h1 className="st-booking-title">Booking Details</h1>
        <div className="st-booking-status-badge">
          {bookingData.overallStatus}
        </div>
      </div>

      <div className="st-booking-details-grid">
        <div className="st-booking-detail-card">
          <h2 className="st-card-title">Booking Information</h2>
          <div className="st-detail-grid">
            <div className="st-detail-item">
              <span className="st-detail-label">Booking ID</span>
              <span className="st-detail-value">{bookingData.id}</span>
            </div>
            <div className="st-detail-item">
              <span className="st-detail-label">Course</span>
              <span className="st-detail-value">{bookingData.title}</span>
            </div>
            <div className="st-detail-item">
              <span className="st-detail-label">Room</span>
              <span className="st-detail-value">{bookingData.room}</span>
            </div>
            <div className="st-detail-item">
              <span className="st-detail-label">Date</span>
              <span className="st-detail-value">{bookingData.date}</span>
            </div>
            <div className="st-detail-item">
              <span className="st-detail-label">Time</span>
              <span className="st-detail-value">{bookingData.time}</span>
            </div>
            <div className="st-detail-item">
              <span className="st-detail-label">Duration</span>
              <span className="st-detail-value">{bookingData.duration}</span>
            </div>
          </div>
        </div>

        <div className="st-approval-workflow-card">
          <h2 className="st-card-title">Approval Workflow</h2>
          <div className="st-authorities-list">
            {authorities.map((authority, index) => (
              <div key={authority.name} className="st-authority-item">
                <div className="st-authority-info">
                  <div className="st-authority-icon">{authority.icon}</div>
                  <div className="st-authority-details">
                    <span className="st-authority-name">{authority.name}</span>
                    <span className="st-authority-role">{authority.role}</span>
                  </div>
                </div>
                <div className="st-authority-status">
                  <StatusIcon status={bookingData.overallStatus} />
                  <span className={`st-status-text st-${bookingData.overallStatus}`}>
                    {bookingData.overallStatus}
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="st-booking-actions">
        <button className="st-action-button st-edit-button">Edit Booking</button>
        <button className="st-action-button st-cancel-button">Cancel Booking</button>
      </div>
      </>
    )}
    </div>
  );
}

export default Status;  