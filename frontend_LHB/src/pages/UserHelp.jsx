import React from 'react';
import './UserHelp.css';
import { 
  BookOpenIcon, 
  CalendarIcon, 
  HistoryIcon, 
  FileTextIcon, 
  MailIcon,
  BuildingIcon,
  AlertCircleIcon
} from 'lucide-react';

const UserHelp = () => {
  return (
    <div className="user-help-page">
      <div className="user-help-container">
        <div className="user-help-header">
          <h2 className="user-help-title">
            <BookOpenIcon className="header-icon" /> User Help Guide
          </h2>
        </div>

        <div className="user-help-sections">
          {/* 1. Adding a New Booking */}
          <div className="user-help-section booking-section">
            <h3 className="section-title">
              <CalendarIcon className="section-icon" /> Adding a Booking
            </h3>
            <ul className="section-list">
              <li>Select date and time</li>
              <li>Choose room and accessories</li>
              <li>Email sent to authority for approval</li>
            </ul>
          </div>

          {/* 2. Live Schedule */}
          <div className="user-help-section schedule-section">
            <h3 className="section-title">
              <CalendarIcon className="section-icon" /> Live Schedule
            </h3>
            <ul className="section-list">
              <li>View current bookings</li>
              <li>Check room availability</li>
              <li>See upcoming reservations</li>
            </ul>
          </div>

          {/* 3. Booking History */}
          <div className="user-help-section history-section">
            <h3 className="section-title">
              <HistoryIcon className="section-icon" /> Booking History
            </h3>
            <ul className="section-list">
              <li>View past bookings</li>
              <li>Generate PDF bills</li>
              <li>Track booking details</li>
            </ul>
          </div>

          {/* 4. Booking Status */}
          <div className="user-help-section status-section">
            <h3 className="section-title">
              <AlertCircleIcon className="section-icon" /> Booking Status
            </h3>
            <ul className="section-list">
              <li>Check pending bookings</li>
              <li>Track approval progress</li>
              <li>See authority approvals</li>
            </ul>
          </div>

          {/* 5. Room Details */}
          <div className="user-help-section room-section">
            <h3 className="section-title">
              <BuildingIcon className="section-icon" /> Room Details
            </h3>
            <ul className="section-list">
              <li>View room capacity</li>
              <li>Check available equipment</li>
              <li>See room specifications</li>
            </ul>
          </div>
        </div>

        {/* Contact Support */}
        <div className="contact-section">
          <a 
            href="mailto:user-support@example.com" 
            className="contact-button"
          >
            <MailIcon /> Contact Support
          </a>
        </div>
      </div>
    </div>
  );
};

export default UserHelp;
