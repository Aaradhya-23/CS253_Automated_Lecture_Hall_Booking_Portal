import React, { useState } from 'react';
import './LiveSchedule.css';

// TODO: Backend Integration Comments:

// 1. Data Fetching:
// - Replace mock data with API calls
// - Create src/api/schedule.js for schedule-related endpoints
// - Call GET /api/schedule?date=YYYY-MM-DD to get bookings for a specific date
// - Add useEffect hook to fetch data when component mounts or date changes

// 2. Loading States:
// - Add loading indicators while fetching data
// - Implement error handling for failed API calls
// - Add empty state UI for days with no bookings

// 3. Booking Details:
// - Add modal/popup for viewing booking details
// - Fetch detailed information via GET /api/bookings/{bookingId}
// - Consider caching frequently accessed data

// 4. Real-time Updates:
// - Implement WebSocket connection for live schedule updates
// - Update UI when new bookings are made or existing ones are changed
// - Consider a polling fallback if WebSockets aren't available

// 5. Filtering and Search:
// - Add backend-driven filters (by hall, time, department)
// - Implement search functionality via GET /api/schedule/search?query=...

// 6. Date Navigation:
// - Keep selected date in URL for shareable links
// - Optimize API calls to avoid unnecessary data fetching

const LiveSchedule = () => {
  const [selectedDate, setSelectedDate] = useState(new Date());

  // Format date to display as "TUESDAY, JANUARY 21, 2025"
  const formatDate = (date) => {
    return date.toLocaleString('en-US', { 
      weekday: 'long', 
      month: 'long', 
      day: 'numeric', 
      year: 'numeric' 
    }).toUpperCase();
  };

  // Navigate to previous day
  const previousDay = () => {
    const newDate = new Date(selectedDate);
    newDate.setDate(selectedDate.getDate() - 1);
    setSelectedDate(newDate);
  };

  // Navigate to next day
  const nextDay = () => {
    const newDate = new Date(selectedDate);
    newDate.setDate(selectedDate.getDate() + 1);
    setSelectedDate(newDate);
  };

  // Mock data for lecture halls
  const lectureHalls = ['LH1', 'LH2', 'LH3', 'LH5', 'LH6', 'LH7', 'LH8', 'LH9'];
  
  // Mock data for time slots
  const timeSlots = [
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM'
  ];

  // Mock data for bookings
  const bookings = [
    { hall: 'LH1', time: '10:00 AM', course: 'CS202', dropdown: true },
    { hall: 'LH2', time: '10:00 AM', course: 'CS202', dropdown: true },
    { hall: 'LH3', time: '11:00 AM', course: 'MTH112 QUIZ', dropdown: true },
    { hall: 'LH5', time: '9:00 AM', course: 'PCLUB SESSION', dropdown: true },
    { hall: 'LH7', time: '11:00 AM', course: 'CS771', dropdown: true },
    { hall: 'LH1', time: '12:00 PM', course: 'CS253', dropdown: true },
  ];

  // Get booking for a specific hall and time
  const getBooking = (hall, time) => {
    return bookings.find(booking => booking.hall === hall && booking.time === time);
  };

  return (
    <div className="live-schedule-container">
      <div className="date-navigator">
        <button onClick={previousDay} className="nav-button">&lt;</button>
        <div className="current-date">{formatDate(selectedDate)}</div>
        <button onClick={nextDay} className="nav-button">&gt;</button>
      </div>
      
      <div className="timetable-container">
        <div className="timetable">
          <div className="time-column">
            {timeSlots.map((time, index) => (
              <div key={index} className="time-slot">{time}</div>
            ))}
          </div>
          
          <div className="halls-grid">
            <div className="hall-headers">
              {lectureHalls.map((hall, index) => (
                <div key={index} className="hall-header">{hall}</div>
              ))}
            </div>
            
            <div className="bookings-grid">
              {timeSlots.map((time, timeIndex) => (
                <div key={timeIndex} className="time-row">
                  {lectureHalls.map((hall, hallIndex) => {
                    const booking = getBooking(hall, time);
                    return (
                      <div key={hallIndex} className="booking-cell">
                        {booking && (
                          <div className="booking-item">
                            <div className="booking-indicator"></div>
                            <div className="course-code">{booking.course}</div>
                            {booking.dropdown && (
                              <button className="dropdown-button">▼</button>
                            )}
                          </div>
                        )}
                      </div>
                    );
                  })}
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default LiveSchedule;