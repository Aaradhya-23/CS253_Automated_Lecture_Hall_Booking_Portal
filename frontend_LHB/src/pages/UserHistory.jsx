import React, { useState, useEffect } from 'react';
import './History.css';

// TODO: Backend Integration Comments:

// 1. History Data Fetching:
// - Replace sample data with API calls
// - Create src/api/bookings.js with history endpoints
// - Call GET /api/bookings/history?month={month}&year={year} 
// - Add pagination if the number of bookings is large

// 2. Data Structure:
// - Adapt component to match backend data structure
// - Expected response: { bookings: [...], totalAmount: number }
// - Handle empty response gracefully

// 3. Download Functionality:
// - Implement booking receipt/invoice download
// - Call GET /api/bookings/{id}/receipt with proper authorization
// - Support multiple formats (PDF, CSV) if needed

// 4. Cancellation/Modification:
// - Add ability to cancel bookings if status allows
// - Implement POST /api/bookings/{id}/cancel
// - Add modification functionality where applicable

// 5. Date Navigation:
// - Send month/year parameters to backend when navigation changes
// - Optimize to prevent unnecessary API calls
// - Add loading states during data fetching

// 6. Error Handling:
// - Display user-friendly error messages
// - Implement retry mechanism for failed requests
// - Log errors to monitoring service

const UserHistory = () => {
  // Sample booking history data organized by month 
  // Just to check and show the working of the navigation button
  const allBookings = {
    // January data
    '0-2025': [
      {
        id: 1,
        purpose: 'Intro Session ML',
        date: '12-01-25',
        time: '9:00 AM - 11:00 AM',
        lectureHall: 'LH07',
        amount: 6000
      },
      {
        id: 2,
        purpose: 'Contest',
        date: '03-01-25',
        time: '5:00 PM - 7:00 PM',
        lectureHall: 'LH03',
        amount: 6000
      },
      {
        id: 3,
        purpose: 'Workshop Web-development',
        date: '07-01-25',
        time: '6:00 PM - 7:00 PM',
        lectureHall: 'LH07',
        amount: 3500
      }
    ],
    // February data
    '1-2025': [
      {
        id: 4,
        purpose: 'AI Workshop',
        date: '05-02-25',
        time: '2:00 PM - 4:00 PM',
        lectureHall: 'LH01',
        amount: 4500
      },
      {
        id: 5,
        purpose: 'Hackathon Intro',
        date: '14-02-25',
        time: '10:00 AM - 12:00 PM',
        lectureHall: 'LH05',
        amount: 5000
      }
    ],
    // March data
    '2-2025': [
      {
        id: 6,
        purpose: 'Project Showcase',
        date: '10-03-25',
        time: '3:00 PM - 5:00 PM',
        lectureHall: 'LH02',
        amount: 7000
      },
      {
        id: 7,
        purpose: 'Guest Lecture',
        date: '22-03-25',
        time: '1:00 PM - 3:00 PM',
        lectureHall: 'LH08',
        amount: 8500
      }
    ],
    // April data
    '3-2025': [
      {
        id: 8,
        purpose: 'Web3 Workshop',
        date: '08-04-25',
        time: '4:00 PM - 6:00 PM',
        lectureHall: 'LH06',
        amount: 5500
      }
    ]
  };

  // State for current month and year (starting with January 2025)
  const [currentMonth, setCurrentMonth] = useState(0); // 0 = January, 1 = February, etc.
  const [currentYear, setCurrentYear] = useState(2025);
  const [bookings, setBookings] = useState([]);
  
  // Month names array
  const monthNames = [
    'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 
    'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'
  ];

  // Update bookings when month/year changes
  useEffect(() => {
    const key = `${currentMonth}-${currentYear}`;
    setBookings(allBookings[key] || []);
  }, [currentMonth, currentYear]);
  
  // Calculate total amount
  const totalAmount = bookings.reduce((sum, booking) => sum + booking.amount, 0);

  // Function to handle month navigation
  const navigateMonth = (direction) => {
    //Here we typically do console.log() to send the data to the backend
    //console.log(`Navigating to ${direction} month`);
    if (direction === 'next') {
      if (currentMonth === 11) {
        setCurrentMonth(0);
        setCurrentYear(currentYear + 1);
      } else {
        setCurrentMonth(currentMonth + 1);
      }
    } else if (direction === 'prev') {
      if (currentMonth === 0) {
        setCurrentMonth(11);
        setCurrentYear(currentYear - 1);
      } else {
        setCurrentMonth(currentMonth - 1);
      }
    }
  };

  return (
    <div className="history-container">
      <h2 className="history-title">
        <div className="month-navigation">
          <button onClick={() => navigateMonth('prev')} className="nav-button">&lt;</button>
          <span>{monthNames[currentMonth]} {currentYear}</span>
          <button onClick={() => navigateMonth('next')} className="nav-button">&gt;</button>
        </div>
      </h2>
      
      <div className="bookings-section">
        <h3>Bookings for the Month of {monthNames[currentMonth]} {currentYear}</h3>
        
        {bookings.length > 0 ? (
          <>
            <div className="bookings-table">
              <div className="table-header">
                <div className="header-cell purpose">Purpose</div>
                <div className="header-cell date">Date</div>
                <div className="header-cell time">Time</div>
                <div className="header-cell hall">Lecture Hall</div>
                <div className="header-cell amount">Amount</div>
                <div className="header-cell download"></div>
              </div>
              
              {bookings.map(booking => (
                <div key={booking.id} className="table-row">
                  <div className="cell purpose">{booking.purpose}</div>
                  <div className="cell date">{booking.date}</div>
                  <div className="cell time">{booking.time}</div>
                  <div className="cell hall">{booking.lectureHall}</div>
                  <div className="cell amount">{booking.amount}</div>
                  <div className="cell download">
                    <button className="download-button">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4"></path>
                        <polyline points="7 10 12 15 17 10"></polyline>
                        <line x1="12" y1="15" x2="12" y2="3"></line>
                      </svg>
                    </button>
                  </div>
                </div>
              ))}
            </div>
            
            <div className="total-section">
              <span>Total: {totalAmount}</span>
            </div>
          </>
        ) : (
          <div className="no-bookings">
            <p>No bookings found for this month.</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default UserHistory;