import React from 'react'

import './AdminHelp.css';
import { 
  BookOpenIcon, 
  CalendarIcon, 
  UserPlusIcon, 
  FilterIcon, 
  MailIcon, 
  CheckCircleIcon, 
  XCircleIcon 
} from 'lucide-react';

const AdminHelp = () => {
  return (
    <div className="help-page">
      <div className="help-container">
        {/* Header */}
        <div className="help-header">
          <h2 className="help-title">
            <BookOpenIcon className="header-icon" /> Admin Help Guide
          </h2>
          <p className="help-subtitle">Your comprehensive guide to managing bookings and users</p>
        </div>

        {/* Help Sections */}
        <div className="help-sections">
          {/* 1. Adding a New Booking */}
          <div className="help-section booking-section">
            <h3 className="section-title">
              <CalendarIcon className="section-icon" /> Adding a New Booking
            </h3>
            <ol className="section-list">
              <li>Select the user for booking</li>
              <li>Choose booking date</li>
              <li>Set start and end times</li>
              <li>Enter booking purpose</li>
              <li>Use capacity/accessories filter</li>
              <li>Click Submit</li>
              <li>Booking is auto-approved</li>
            </ol>
          </div>

          {/* 2. Viewing Live Schedule */}
          <div className="help-section schedule-section">
            <h3 className="section-title">
              <FilterIcon className="section-icon" /> Viewing Live Schedule
            </h3>
            <p>The Live Schedule allows admins to see:</p>
            <ul className="section-list">
              <li>Fixed lectures</li>
              <li>Approved bookings</li>
            </ul>
          </div>

          {/* 3. Managing Approved Bookings */}
          <div className="help-section management-section">
            <h3 className="section-title">
              <UserPlusIcon className="section-icon" /> Managing Approved Bookings
            </h3>
            <div className="section-content">
              <p>Filter bookings by:</p>
              <ul className="section-list">
                <li>Date range</li>
                <li>Lecture hall</li>
                <li>Username</li>
                <li>Purpose</li>
              </ul>
              <p>Remove a booking with the Delete button</p>
            </div>
          </div>

          {/* 4. Handling Pending Approvals */}
          <div className="help-section approvals-section">
            <h3 className="section-title">
              <CheckCircleIcon className="section-icon" /> Handling Pending Approvals
            </h3>
            <ul className="section-list">
              <li>Pending bookings appear in Pending Approvals section</li>
              <li>Click "X" to reject a booking</li>
              <li>Email notification sent upon rejection</li>
            </ul>
          </div>

          {/* Further Assistance */}
          <div className="help-section contact-section">
            <h3 className="section-title">Need Further Assistance?</h3>
            <p>Don't hesitate to reach out to our support team</p>
            <a 
              href="mailto:admin-support@example.com" 
              className="contact-button"
            >
              <MailIcon /> Contact Support
            </a>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AdminHelp;



