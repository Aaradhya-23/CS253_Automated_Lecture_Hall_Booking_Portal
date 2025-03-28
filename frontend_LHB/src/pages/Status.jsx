import React, { useState, useEffect } from 'react';
import { Check, Clock, X, AlertCircle, UserCheck, UserCog, BookUser } from 'lucide-react';
import './Status.css';

// Status icon component
const StatusIcon = ({ status }) => {
  const iconMap = {
    'Approved': <Check className="st-status-icon st-approved" />,
    'Pending': <Clock className="st-status-icon st-pending" />,
    'Rejected': <X className="st-status-icon st-rejected" />,
    'Not Submitted': <AlertCircle className="st-status-icon st-not-submitted" />
  };

  return iconMap[status] || null;
};

function Status() {
  const [bookingData, setBookingData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [authorities, setAuthorities] = useState([
    {
      name: 'Faculty Advisor',
      role: 'Academic Approval',
      icon: <BookUser />,
      status: 'Approved'
    },
    {
      name: 'DOAA',
      role: 'Department Approval',
      icon: <UserCog />,
      status: 'Pending'
    },
    {
      name: 'Gen Sec',
      role: 'Administrative Approval',
      icon: <UserCheck />,
      status: 'Not Submitted'
    }
  ]);

  useEffect(() => {
    // Simulated data fetch
    const mockData = {
      id: 'ECO111-2025',
      title: 'Economics 101 Lecture',
      room: 'LHC - L101',
      date: 'Wednesday, 05 February 2025',
      time: '12:00 PM - 01:00 PM',
      duration: '1 hour',
      type: 'Academic',
      createdBy: 'Prof. Smith',
      overallStatus: 'Partially Approved'
    };

    setBookingData(mockData);
    setLoading(false);
  }, []);

  if (loading) {
    return <div className="st-loading-container">Loading...</div>;
  }

  return (
    <div className="st-booking-details-container">
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
                  <StatusIcon status={authority.status} />
                  <span className={`st-status-text st-${authority.status.toLowerCase().replace(' ', '-')}`}>
                    {authority.status}
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
    </div>
  );
}

export default Status;  