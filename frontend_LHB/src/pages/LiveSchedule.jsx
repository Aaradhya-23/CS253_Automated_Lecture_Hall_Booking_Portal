import React, { useState, useEffect } from 'react';
import './LiveSchedule.css';
import api from '../api/api';
import axios from 'axios';

const LiveSchedule = () => {
  const [selectedDate, setSelectedDate] = useState(new Date());
  const [bookings, setBookings] = useState([]);
  const [loading, setLoading] = useState(false);
  const [lectureHalls, setRoomOptions] = useState([]);
  

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
    const formattedDate = date.toISOString().split('T')[0];
    console.log(formattedDate)
    console.log(`${import.meta.env.VITE_BOOKING_SEARCH_URL}?booking_date=${formattedDate}`)
    try {
      const response = await axios.get(`${import.meta.env.VITE_BOOKING_SEARCH_URL}?booking_date=${formattedDate}`, {
        headers: {
          'Content-Type': 'application/json', // Specify the content type as JSON
          Accept: 'application/json', // Specify that the response should be in JSON format
        },
      });
      const data = response.data; // Access the data directly
      console.log("bookings = ", data)
      setBookings(data);
    } catch (err) {
      console.error('Error fetching bookings:', err.message || err);    
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

  // const lectureHalls = ['L-1', 'LH2', 'LH3', 'LH5', 'LH6', 'LH7', 'LH8', 'LH9'];
  const timeSlots = ['8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM', '2:00 PM'];

  const convertTo24Hour = (time) => {
    const [hourMinute, period] = time.split(" ");
    let [hours, minutes] = hourMinute.split(":").map(Number);
  
    if (period === "PM" && hours !== 12) hours += 12;
    if (period === "AM" && hours === 12) hours = 0;
  
    // Convert to HH:MM:SS format
    return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:00`;
  };

  useEffect(() => {
    const fetchRooms = async () => {
      try {
        const response = await api.get(import.meta.env.VITE_ROOM_LIST_CREATE_URL, {
        });
        console.log(response.data);
        const rooms = Array.isArray(response.data) ? response.data : response.data.rooms;
        setRoomOptions(rooms); 
        console.log(rooms)
        } catch (error) {
          console.error("Error fetching rooms:", error);
        }
    };
  
    fetchRooms();
  }, []);

  const getBooking = (hall, time) => {
    const formattedTime = convertTo24Hour(time);
    return bookings.find(booking => 
      booking.room_details.name === hall.name && 
      booking.start_time === formattedTime
    );
  };

  const timeToMinutes = (timeStr) => {
    const [hours, minutes] = timeStr.split(':').map(Number);
    return hours * 60 + minutes;
  };
  
  // Calculate n as number of 30-minute intervals
  const calculateIntervals = (start_time, end_time) => {
    const startMinutes = timeToMinutes(start_time);
    const endMinutes = timeToMinutes(end_time);
    return Math.max(1, Math.ceil((endMinutes - startMinutes) / 30)); // Ensure at least one interval
  };

  return (
    <div className="ls-container">
      <div className="ls-date-navigator">
        <button onClick={previousDay} className="ls-nav-button">&lt;</button>
        <div className="ls-current-date">{formatDate(selectedDate)}</div>
        <button onClick={nextDay} className="ls-nav-button">&gt;</button>
      </div>

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
                <div key={index} className="ls-hall-header">{hall.name}</div>
              ))}
            </div>
            
            {/* <div className="ls-bookings-grid">
              {timeSlots.map((time, timeIndex) => {
                <div key={timeIndex} className="ls-time-row">
                  {lectureHalls.map((hall, hallIndex) => {
                    const booking = getBooking(hall, time);
                    console.log(booking)
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
              })}
            </div> */}
            {/* <div className="ls-bookings-grid">
              {lectureHalls.map((hall, hallIndex) => (
                <div key={hallIndex} className="ls-time-column">
                  <div className="ls-hall-header">{hall.name}</div>
                  {timeSlots.map((time, timeIndex) => {
                    const booking = getBooking(hall, time);
                    console.log(booking)
                    return (
                      <div key={timeIndex} className="ls-time-row">
                        {booking && (
                          <>
                            {Array.from({ length: calculateIntervals(booking.start_time, booking.end_time) }).map((_, loopIndex) => {
                              const adjustedTimeIndex = timeIndex + loopIndex;
                              <div key={loopIndex} className="ls-booking-item">
                                <div className="ls-booking-indicator"></div>
                                <div className="ls-course-code">{booking.title}</div>
                              </div>
                              timeIndex = timeIndex + 1;
                            })}
                          </>
                        )}
                      </div>
                    );
                  })}
                </div>
              ))}
            </div> */}
            <div className="ls-bookings-grid">
              {lectureHalls.map((hall, hallIndex) => (
                <div key={hallIndex} className="ls-time-column">
                  {/* <div className="ls-hall-header">{hall.name}</div> */}
                  {timeSlots.map((time, timeIndex) => {
                    const booking = getBooking(hall, time);
                    console.log(booking);

                    return (
                      <div key={timeIndex} className="ls-time-row">
                        {booking &&
                          Array.from({ length: calculateIntervals(booking.start_time, booking.end_time) }).map((_, loopIndex) => {
                            const adjustedTimeIndex = timeIndex + loopIndex;
                            return (
                              <div key={loopIndex} className="ls-booking-item">
                                <div className="ls-booking-indicator"></div>
                                <div className="ls-course-code">{booking.title}</div>
                              </div>
                            );
                          })}
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
