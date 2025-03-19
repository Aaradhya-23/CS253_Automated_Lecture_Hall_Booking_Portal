import React, { useState } from 'react';
import './RequestBooking.css';

const RequestBooking = ({ onLogout }) => {
  const [bookingData, setBookingData] = useState({
    purpose: 'Linux Session Y-24',
    user: 'Pclub IITK',
    startDate: '1/21/2025',
    startTime: '8:00 AM',
    endDate: '1/21/2025',
    endTime: '8:30 AM',
    duration: '30 minutes',
    repeat: 'Does Not Repeat',
    lectureHall: 'LH18',
    accessories: [],
    capacity: ''
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setBookingData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Booking request submitted:', bookingData);
    // Here you would typically send the data to your backend
  };

  const handleNavigate = (page) => {
    // Handle navigation to different pages
    console.log(`Navigating to ${page}`);
  };

  return (
    <div className="request-booking">
      <header className="header">
        <div className="logo-container">
          <img src="/iit-logo.png" alt="IIT-K Logo" className="logo" />
          <h1>IIT-K Lecture Hall Booking</h1>
        </div>
        <button className="logout-button" onClick={onLogout}>Logout</button>
      </header>
      
      <div className="main-content">
        <aside className="sidebar">
          <button className="sidebar-button active" onClick={() => handleNavigate('new')}>
            New <span className="icon">⊕</span>
          </button>
          <button className="sidebar-button" onClick={() => handleNavigate('schedule')}>
            Live Schedule
          </button>
          <button className="sidebar-button" onClick={() => handleNavigate('history')}>
            History
          </button>
          <button className="sidebar-button" onClick={() => handleNavigate('status')}>
            Status
          </button>
          <button className="sidebar-button" onClick={() => handleNavigate('feedback')}>
            Feedback
          </button>
          <button className="sidebar-button" onClick={() => handleNavigate('help')}>
            Help
          </button>
        </aside>
        
        <main className="content-area">
          <div className="booking-form-container">
            <form onSubmit={handleSubmit} className="booking-form">
              <div className="form-group full-width">
                <label htmlFor="purpose">Purpose</label>
                <input
                  type="text"
                  id="purpose"
                  name="purpose"
                  value={bookingData.purpose}
                  onChange={handleInputChange}
                />
              </div>
              
              <div className="form-group full-width">
                <label htmlFor="user">User</label>
                <input
                  type="text"
                  id="user"
                  name="user"
                  value={bookingData.user}
                  onChange={handleInputChange}
                />
              </div>
              
              <div className="form-row">
                <div className="form-group">
                  <label>Begin</label>
                  <div className="input-group">
                    <input
                      type="text"
                      name="startDate"
                      value={bookingData.startDate}
                      onChange={handleInputChange}
                      placeholder="MM/DD/YYYY"
                    />
                    <select
                      name="startTime"
                      value={bookingData.startTime}
                      onChange={handleInputChange}
                    >
                      <option value="8:00 AM">8:00 AM</option>
                      <option value="8:30 AM">8:30 AM</option>
                      <option value="9:00 AM">9:00 AM</option>
                      {/* Add more time options as needed */}
                    </select>
                  </div>
                </div>
                
                <div className="form-group">
                  <label>End</label>
                  <div className="input-group">
                    <input
                      type="text"
                      name="endDate"
                      value={bookingData.endDate}
                      onChange={handleInputChange}
                      placeholder="MM/DD/YYYY"
                    />
                    <select
                      name="endTime"
                      value={bookingData.endTime}
                      onChange={handleInputChange}
                    >
                      <option value="8:30 AM">8:30 AM</option>
                      <option value="9:00 AM">9:00 AM</option>
                      <option value="9:30 AM">9:30 AM</option>
                      {/* Add more time options as needed */}
                    </select>
                  </div>
                </div>
                
                <div className="form-group duration">
                  <label>Duration</label>
                  <div className="status-badge available">
                    {bookingData.duration}
                  </div>
                </div>
              </div>
              
              <div className="form-group">
                <label>Repeat</label>
                <select
                  name="repeat"
                  value={bookingData.repeat}
                  onChange={handleInputChange}
                >
                  <option value="Does Not Repeat">Does Not Repeat</option>
                  <option value="Daily">Daily</option>
                  <option value="Weekly">Weekly</option>
                  <option value="Monthly">Monthly</option>
                </select>
              </div>
              
              <div className="form-row">
                <div className="form-group">
                  <label>Lecture Hall <span className="badge">1</span></label>
                  <div className="tag-container">
                    <div className="tag">
                      {bookingData.lectureHall}
                      <span className="info-icon">ⓘ</span>
                    </div>
                    <button type="button" className="add-button">Add ⊕</button>
                  </div>
                </div>
                
                <div className="form-group">
                  <label>Accessories <span className="badge">0</span></label>
                  <button type="button" className="add-button full-width">Add ⊕</button>
                </div>
              </div>
              
              <div className="form-group">
                <label>Capacity <span className="badge">0</span></label>
                <select
                  name="capacity"
                  value={bookingData.capacity}
                  onChange={handleInputChange}
                >
                  <option value="">Select capacity</option>
                  <option value="50">50</option>
                  <option value="100">100</option>
                  <option value="150">150</option>
                  <option value="200">200</option>
                </select>
              </div>
              
              <div className="form-actions">
                <button type="submit" className="submit-button">SUBMIT</button>
              </div>
            </form>
          </div>
        </main>
      </div>
    </div>
  );
};

export default RequestBooking;