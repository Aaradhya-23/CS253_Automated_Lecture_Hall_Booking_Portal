import React, { useState, useEffect } from 'react';
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
  const [bookings, setBookings] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const formatDate = (date) => {
    return date.toLocaleString('en-US', { 
      weekday: 'long', 
      month: 'long', 
      day: 'numeric', 
      year: 'numeric' 
    }).toUpperCase();
  };

  const fetchBookings = async (date) => {
    setLoading(true);
    setError(null);
    try {
      const response = await api.get(`${import.meta.env.VITE_BOOKING_SEARCH_URL}?date=${date.toISOString().split('T')[0]}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        }
      });
      const data = response.data; // Access the data directly
      console.log("bookings = ", data)
      setBookings(data);
    } catch (err) {
      setError(err.message || 'Failed to fetch bookings');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchBookings(selectedDate);
  }, [selectedDate]);

  const previousDay = () => {
    const newDate = new Date(selectedDate);
    newDate.setDate(selectedDate.getDate() - 1);
    setSelectedDate(newDate);
  };

  const nextDay = () => {
    const newDate = new Date(selectedDate);
    newDate.setDate(selectedDate.getDate() + 1);
    setSelectedDate(newDate);
  };

  const lectureHalls = ['L-1', 'LH2', 'LH3', 'LH5', 'LH6', 'LH7', 'LH8', 'LH9'];
  const timeSlots = ['8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM', '2:00 PM'];

  const getBooking = (hall, time) => {
    return bookings.find(booking => 
      booking.room.name === hall && 
      booking.start_time === time
    );
  };

  return (
    <div className="ls-container">
      <div className="ls-date-navigator">
        <button onClick={previousDay} className="ls-nav-button">&lt;</button>
        <div className="ls-current-date">{formatDate(selectedDate)}</div>
        <button onClick={nextDay} className="ls-nav-button">&gt;</button>
      </div>

      {loading && <p>Loading...</p>}
      {error && <p className="error">{error}</p>}

      <div className="ls-timetable-container">
        <div className="ls-timetable">
          <div className="ls-time-column">
            {timeSlots.map((time, index) => (
              <div key={index} className="ls-time-slot">{time}</div>
            ))}
          </div>
          
          <div className="ls-halls-grid">
            <div className="ls-hall-headers">
              {lectureHalls.map((hall, index) => (
                <div key={index} className="ls-hall-header">{hall}</div>
              ))}
            </div>
            
            <div className="ls-bookings-grid">
              {timeSlots.map((time, timeIndex) => (
                <div key={timeIndex} className="ls-time-row">
                  {lectureHalls.map((hall, hallIndex) => {
                    const booking = getBooking(hall, time);
                    return (
                      <div key={hallIndex} className="ls-booking-cell">
                        {booking && (
                          <div className="ls-booking-item">
                            <div className="ls-booking-indicator"></div>
                            <div className="ls-course-code">{booking.title}</div>
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
