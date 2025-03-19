import React, { useState } from 'react';
import './UserViewBooking.css';

const UserViewBooking = ({ onLogout }) => {
  const [selectedMonth, setSelectedMonth] = useState('January 2025');
  
  // Sample booking data
  const [bookings, setBookings] = useState([
    {
      id: 1,
      purpose: 'Intro Session ML',
      date: '12-01-25',
      time: '9:00 AM - 11:00 AM',
      hall: 'LH07',
      amount: 6000
    },
    {
      id: 2,
      purpose: 'Contest',
      date: '03-01-25',
      time: '5:00 PM - 7:00 PM',
      hall: 'LH03',
      amount: 6000
    },
    {
      id: 3,
      purpose: 'Workshop Wed-dev',
      date: '07-01-25',
      time: '6:00 PM - 7:00 PM',
      hall: 'LH07',
      amount: 3500
    }
  ]);

  const getTotalAmount = () => {
    return bookings.reduce((total, booking) => total + booking.amount, 0);
  };

  const handleNavigate = (page) => {
    // Handle navigation to different pages
    console.log(`Navigating to ${page}`);
  };

  return (
    <div className="user-view-booking">
      <header className="header">
        <div className="logo-container">
          <img src="/iit-logo.png" alt="IIT-K Logo" className="logo" />
          <h1>IIT-K Lecture Hall Booking</h1>
        </div>
        <button className="logout-button" onClick={onLogout}>Logout</button>
      </header>
      
      <div className="main-content">
        <aside className="sidebar">
          <button className="sidebar-button" onClick={() => handleNavigate('new')}>
            New <span className="icon">⊕</span>
          </button>
          <button className="sidebar-button" onClick={() => handleNavigate('schedule')}>
            Live Schedule
          </button>
          <button className="sidebar-button active" onClick={() => handleNavigate('history')}>
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
          <div className="month-selector">
            <button className="arrow-button">←</button>
            <div className="month-dropdown">
              <span>{selectedMonth}</span>
              <span className="dropdown-arrow">▼</span>
            </div>
            <button className="arrow-button">→</button>
          </div>
          
          <div className="bookings-container">
            <h2>Bookings for the Month of January 2025</h2>
            
            <table className="bookings-table">
              <thead>
                <tr>
                  <th>Purpose</th>
                  <th>Date</th>
                  <th>Time</th>
                  <th>Lecture Hall</th>
                  <th>Amount</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                {bookings.map(booking => (
                  <tr key={booking.id}>
                    <td>{booking.purpose}</td>
                    <td>{booking.date}</td>
                    <td>{booking.time}</td>
                    <td>{booking.hall}</td>
                    <td>{booking.amount}</td>
                    <td>
                      <button className="download-button">↓</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
            
            <div className="total-amount">
              Total: {getTotalAmount()}
            </div>
          </div>
        </main>
      </div>
    </div>
  );
};

export default UserViewBooking;