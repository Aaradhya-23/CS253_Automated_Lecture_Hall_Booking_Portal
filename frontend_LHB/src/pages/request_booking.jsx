// TODO: Backend Integration Comments:

// 1. State Management:
// - Add useState hooks to manage form state for all booking details
// - Example: const [formData, setFormData] = useState({ hall: '', date: '', startTime: '', endTime: '', purpose: '', additionalEquipment: '' })

// 2. API Integration Points:
// - Import axios: import axios from 'axios'
// - Create API service file at: src/services/api.js with all endpoint definitions
// - Base API URL should be configurable via environment variable

// 3. Required API Endpoints:
// - GET /api/halls - Fetch available lecture halls
// - GET /api/halls/{hallId}/availability?date={date} - Check hall availability for specific date
// - POST /api/bookings - Submit a new booking request
// - GET /api/user/profile - Get user details for pre-filling the form

// 4. Form Submission:
// - Create handleSubmit function to:
//   a) Validate all required fields
//   b) Format data in the structure expected by backend
//   c) Make POST request to /api/bookings
//   d) Handle success/error responses
//   e) Show appropriate user feedback

// 5. Form Validation:
// - Add client-side validation before submission
// - Check for required fields, date/time format, conflicts
// - Show validation errors next to respective fields

// 6. Loading States:
// - Add loading states for initial data fetch
// - Show spinner during form submission
// - Disable submit button while processing

// 7. Error Handling:
// - Try/catch blocks around all API calls
// - Display user-friendly error messages
// - Log detailed errors for debugging

// 8. Success Handling:
// - Redirect to status page after successful booking
// - Or show success message with booking ID
// - Provide option to create another booking

// 9. Authentication:
// - Include authentication headers in all API requests
// - Check user permissions before allowing submission
// - Redirect to login if auth token is expired

import React, { useState } from 'react';
import './Request_Booking.css';

const Request_Booking = () => {
  // State for form fields
  const [purpose, setPurpose] = useState('');
  const [startDate, setStartDate] = useState('');
  const [startTime, setStartTime] = useState('8:00 AM');
  const [endDate, setEndDate] = useState('');
  const [endTime, setEndTime] = useState('8:30 AM');
  const [repeatOption, setRepeatOption] = useState('Does Not Repeat');
  const [selectedHall, setSelectedHall] = useState('LH18');
  const [capacity, setCapacity] = useState('');
  const [accessories, setAccessories] = useState([]);
  
  // Time options for dropdowns
  const timeOptions = [
    '8:00 AM', '8:30 AM', '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM',
    '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM',
    '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM',
    '5:00 PM', '5:30 PM', '6:00 PM'
  ];

  // Repeat options
  const repeatOptions = [
    'Does Not Repeat', 'Daily', 'Weekly', 'Monthly'
  ];

  // Hall options
  const hallOptions = ['LH18', 'LH19', 'LH20', 'LH21'];

  // Capacity options
  const capacityOptions = [
    '30', '50', '100', '150', '200'
  ];

  // Accessories options
  const accessoryOptions = [
    'Projector', 'Microphone', 'Whiteboard', 'Computer', 'Speaker System'
  ];

  // Calculate duration between start and end time
  const calculateDuration = () => {
    if (!startTime || !endTime) return '';
    
    // Simple calculation for demo purposes
    return '30 minutes';
  };

  // Handle form submission
  const handleSubmit = (e) => {
    e.preventDefault();
    alert('Booking submitted!');
    // In a real application, you would send this data to your backend
  };

  // Handle add hall
  const handleAddHall = () => {
    alert('Feature to add another hall would be implemented here');
  };

  // Handle add accessory
  const handleAddAccessory = () => {
    alert('Feature to add accessories would be implemented here');
  };

  return (
    <div className="main-content-wrapper">
      <div className="booking-form-container">
        <form className="booking-form" onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="purpose">Purpose</label>
            <input 
              type="text" 
              id="purpose" 
              value={purpose} 
              onChange={(e) => setPurpose(e.target.value)} 
              placeholder="Linux Session Y-24"
              className="form-control"
            />
          </div>

          <div className="form-group">
            <label htmlFor="user">user</label>
            <input 
              type="text" 
              id="user" 
              value="Pclub IITK" 
              readOnly 
              className="form-control"
            />
          </div>

          <div className="form-row">
            <div className="form-column">
              <label>Begin</label>
              <div className="date-time-controls">
                <input 
                  type="date" 
                  value={startDate} 
                  onChange={(e) => setStartDate(e.target.value)} 
                  className="date-input"
                  placeholder="dd-mm-yyyy"
                />
                <select 
                  value={startTime} 
                  onChange={(e) => setStartTime(e.target.value)}
                  className="time-select"
                >
                  {timeOptions.map(time => (
                    <option key={`start-${time}`} value={time}>{time}</option>
                  ))}
                </select>
              </div>
            </div>

            <div className="form-column">
              <label>End</label>
              <div className="date-time-controls">
                <input 
                  type="date" 
                  value={endDate} 
                  onChange={(e) => setEndDate(e.target.value)} 
                  className="date-input"
                  placeholder="dd-mm-yyyy"
                />
                <select 
                  value={endTime} 
                  onChange={(e) => setEndTime(e.target.value)}
                  className="time-select"
                >
                  {timeOptions.map(time => (
                    <option key={`end-${time}`} value={time}>{time}</option>
                  ))}
                </select>
              </div>
            </div>

            <div className="duration-indicator">
              {calculateDuration()}
            </div>

            <div className="availability-indicator">
              Available
            </div>
          </div>

          <div className="form-group">
            <label>Repeat</label>
            <select 
              value={repeatOption} 
              onChange={(e) => setRepeatOption(e.target.value)}
              className="form-control"
            >
              {repeatOptions.map(option => (
                <option key={option} value={option}>{option}</option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <div className="section-header">
              <label>Lecture Hall</label>
              <span className="badge">1</span>
              <button 
                type="button" 
                className="add-btn"
                onClick={handleAddHall}
              >
                Add <span className="circle-icon">⊕</span>
              </button>
            </div>
            <div className="hall-selection">
              <div className="selected-hall">
                {selectedHall} <span className="info-icon">ⓘ</span>
              </div>
            </div>
          </div>

          <div className="form-group">
            <div className="section-header">
              <label>Capacity</label>
              <span className="badge">0</span>
            </div>
            <select 
              value={capacity} 
              onChange={(e) => setCapacity(e.target.value)}
              className="form-control"
            >
              <option value="">Select capacity</option>
              {capacityOptions.map(option => (
                <option key={option} value={option}>{option}</option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <div className="section-header">
              <label>Accessories</label>
              <span className="badge">0</span>
              <button 
                type="button" 
                className="add-btn"
                onClick={handleAddAccessory}
              >
                Add <span className="circle-icon">⊕</span>
              </button>
            </div>
          </div>

          <div className="form-actions">
            <button type="submit" className="submit-btn">SUBMIT</button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Request_Booking;