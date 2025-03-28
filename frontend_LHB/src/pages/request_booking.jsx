// TODO: Backend Integration Comments:

// 1. State Management:
// - Add useState hooks to manage form state for all booking details
// - Example: const [formData, setFormData] = useState({ hall: '', date: '', startTime: '', endTime: '', purpose: '', additionalEquipment: '' })

// 2. API Integration Points:
// - Import api: import axios from 'axios'
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

import React, { useState, useEffect } from 'react';
import api from '../api/api';
import { ACCESS_TOKEN } from '../api/constants';
// import { ROLE } from '../api/constants';
import './Request_Booking.css';

const Request_Booking = () => {
  const role = localStorage.getItem('ROLE');
  const token = localStorage.getItem(ACCESS_TOKEN);
  console.log(role);
  const [roomOptions, setRoomOptions] = useState([]);
  const [filteredRoomOptions, setFilteredRoomOptions] = useState([]);
  const [capacityOptions, setCapacityOptions] = useState([]);
  const [purpose, setPurpose] = useState('');
  const [startDate, setStartDate] = useState('');
  const [startTime, setStartTime] = useState('8:00 AM');
  const [endDate, setEndDate] = useState('');
  const [endTime, setEndTime] = useState('8:30 AM');
  const [repeatOption, setRepeatOption] = useState('Does Not Repeat');
  const [selectedHall, setSelectedHall] = useState('');
  const [capacity, setCapacity] = useState('');
  const [accessoryOptions, setAccessoryOptions] = useState([]);
  const [selectedAccessories, setSelectedAccessories] = useState([]);

  const [users, setUsers] = useState([]); 
  const [selectedUser, setSelectedUser] = useState(""); 
  const VITE_USER_LIST_CREATE_URL = `${import.meta.env.VITE_API_BASE_URL}accounts/users/`;

  useEffect(() => {
    if (role !== 'admin') {
      setSelectedUser('INVALID'); // Set user to null if the role is not admin
    }
  }, [role]);
  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await api.get(VITE_USER_LIST_CREATE_URL, {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
        });
  
        console.log("API Response:", response.data); // Debugging step
  
        // Ensure the API response is an array before setting state
        if (Array.isArray(response.data)) {
          setUsers(response.data);
        } else {
          console.error("Unexpected API response format:", response.data);
          setUsers([]); // Prevent crash
        }
      } catch (error) {
        console.error("Error fetching users:", error);
        setUsers([]);
      }
    };
  
    if (role === "admin") {
      fetchUsers();
    }
  }, [role]);
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

// fetch rooms from the database
useEffect(() => {
  const fetchRooms = async () => {
    console.log("here")
    if (!token) {
      console.log("here")
      console.error("No token found. User is not authenticated.");
      return;
    }
    console.log(token)
    try {
      console.log("here")
      const response = await api.get(import.meta.env.VITE_ROOM_LIST_CREATE_URL, {
        headers: {
          Authorization: `Bearer ${token}`,
        }
      });
      console.log("here");
      console.log(response.data);
      const rooms = Array.isArray(response.data) ? response.data : response.data.rooms;
      setRoomOptions(rooms); 
      setFilteredRoomOptions(rooms);
      console.log(rooms)
      // Continue with the rest of your code
      // try {
        // Extract unique capacities
        const uniqueCapacities = [];
        for (let i = 0; i < rooms.length; i++) {
          const capacity = rooms[i].capacity;
          if (!uniqueCapacities.includes(capacity)) {
            uniqueCapacities.push(capacity);
          }
        }
        setCapacityOptions(uniqueCapacities.sort((a, b) => a - b));
      
        // Extract all accessories
        const allAccessories = [];
        for (let i = 0; i < rooms.length; i++) {
          const accessories = rooms[i].accessories;
          for (const accessory in accessories) {
            if (accessories[accessory]) {
              allAccessories.push(accessory);
            }
          }
        }
      
        // Filter unique accessories
        const uniqueAccessories = [];
        for (let i = 0; i < allAccessories.length; i++) {
          const accessory = allAccessories[i];
          if (!uniqueAccessories.includes(accessory)) {
            uniqueAccessories.push(accessory);
          }
        }
      
        setAccessoryOptions(uniqueAccessories);
      } catch (error) {
        console.error("Error fetching rooms:", error);
      }
  };

  fetchRooms();
}, []);

  // Filter room options based on selected capacity and accessories
  useEffect(() => {
    const filterRooms = () => {
      let filtered = roomOptions;

      // Filter by capacity
      if (capacity) {
        filtered = filtered.filter((room) => room.capacity >= parseInt(capacity));
      }

      // Filter by selected accessories
      if (selectedAccessories.length > 0) {
        filtered = filtered.filter((room) =>
          selectedAccessories.every((accessory) => room.accessories[accessory])
        );
      }

      setFilteredRoomOptions(filtered);
    };

    filterRooms();
  }, [capacity, selectedAccessories, roomOptions]);

  // Calculate duration between start and end time
  const calculateDuration = () => {
    if (!startTime || !endTime) return '';
  
    // Parse the time strings into Date objects
    const parseTime = (time) => {
      const [hours, minutes, period] = time.match(/(\d+):(\d+)\s(AM|PM)/).slice(1);
      let totalMinutes = parseInt(hours) % 12 * 60 + parseInt(minutes); // Convert hours and minutes to total minutes
      if (period === 'PM') totalMinutes += 12 * 60; // Add 12 hours for PM times
      return totalMinutes;
    };
  
    const startMinutes = parseTime(startTime);
    const endMinutes = parseTime(endTime);
  
    // Calculate the duration in minutes
    const duration = endMinutes - startMinutes;
  
    // Handle cases where endTime is earlier than startTime (e.g., overnight bookings)
    if (duration < 0) return 'Invalid time range';
  
    return `${duration} minutes`;
  };

  // Handle form submission
  const handleSubmit = async (e) => {
    e.preventDefault();
    const formatTime = (time) => {
      // Match time in the format of 'hh:mm AM/PM'
      const [hour, minute, period] = time.match(/(\d+):(\d+)\s(AM|PM)/).slice(1);
      let hours = parseInt(hour);
      let minutes = parseInt(minute);
    
      // Convert 12-hour format to 24-hour format
      if (period === 'PM' && hours !== 12) hours += 12;
      if (period === 'AM' && hours === 12) hours = 0;
    
      // Return time in 24-hour format with seconds always set to '00'
      return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:00`;
    };
  
    // Format start and end times
    const formattedStartTime = formatTime(startTime);
    const formattedEndTime = formatTime(endTime);
    // Prepare the data to be sent to the backend
    const bookingData = {
      user: selectedUser,
      title: purpose,
      booking_date: startDate,
      start_time: formattedStartTime,
      end_time: formattedEndTime,
      room: selectedHall,
      duration: Math.abs(new Date(`${endDate}T${formattedEndTime}`) - new Date(`${startDate}T${formattedStartTime}`)) / (1000 * 60 * 60),
      Type:'academic',
      remarks: purpose,
      accessories: selectedAccessories.reduce((acc, accessory) => {
        acc[accessory] = true;
        return acc;
      }, {}),
    };
    console.log("here");
  
    try {
      // Make a POST request to the backend
      const token = localStorage.getItem(ACCESS_TOKEN);
      if (!token) {
        console.log("here")
        console.error("No token found. User is not authenticated.");
        return;
      }
      const response = await api.post(import.meta.env.VITE_REQUEST_BOOKING_URL, bookingData, {
        headers: {
          Authorization: `Bearer ${token}`, // Add token in the header
          'Content-Type': 'application/json', // Ensure the server knows you're sending JSON data
          'Accept': 'application/json', // Optional: to specify that you expect JSON in response
        },
      });

      if (response.status === 201 || response.status === 200) {
        // Show success notification
        alert('Booking successful!');
  
        // Clear the form
        setPurpose('');
        setStartDate('');
        setStartTime('8:00 AM');
        setEndDate('');
        setEndTime('8:30 AM');
        setRepeatOption('Does Not Repeat');
        setSelectedHall('');
        setCapacity('');
        setSelectedAccessories([]);
      } else {
        // Show error notification
        alert('Booking unsuccessful. Please try again.');
      }
    } catch (error) {
      console.error('Error submitting booking:', error);
      // Show error notification
      alert('Booking unsuccessful. Please try again.');
    }
  };

  const handleAccessoryChange = (accessory) => {
    setSelectedAccessories((prev) =>
      prev.includes(accessory)
        ? prev.filter((item) => item !== accessory) // Remove if already selected
        : [...prev, accessory] // Add if not selected
    );
  };

  return (
    <div className="main-content-wrapper">
      <div className="booking-form-container">
        <form className="booking-form" onSubmit={handleSubmit}>
        <div className="form-group">
          {role === "admin" && (
          <>
            <label htmlFor="user">User</label>
            <select
              id="user"
              value={selectedUser}
              onChange={(e) => setSelectedUser(e.target.value)}
              className="form-control"
            >
              <option value="">Select User</option>
              {users.length > 0 ? (
                users.map((u) => (
                  <option key={u.email} value={u.username}>
                    {u.username}
                  </option>
                ))
              ) : (
                <option disabled>Loading users...</option>
              )}
            </select>
          </>
        )}
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
              <label>Capacity</label>
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
            </div>
            <div className="accessories-grid">
              {accessoryOptions.map((accessory) => (
                <button
                  key={accessory}
                  type="button"
                  className={`accessory-btn ${selectedAccessories.includes(accessory) ? 'selected' : ''}`}
                  onClick={() => handleAccessoryChange(accessory)}
                >
                  {accessory}
                </button>
              ))}
            </div>
          </div>

          {capacity && (
          <div className="form-group">
            <div className="section-header">
              <label>Lecture Hall</label>
            </div>
            {filteredRoomOptions.length > 0 ? (
           <div className="halls-grid">
            {filteredRoomOptions.map(hall => (
              <div 
                key={hall.id} 
                className={`hall-card ${selectedHall === hall.id ? 'selected' : ''}`}
                onClick={() => setSelectedHall(hall.id)}
              >
                <div className="hall-header">{hall.id}</div>
                <div className="hall-details">
                  <p>Capacity: {hall.capacity}</p>
                  <p>Accessories: {Object.keys(hall.accessories).join(', ')}</p>
                  <p className="hall-description">{hall.description}</p>
                </div>
              </div>
            ))}
          </div>
            ) : (
              <div className="no-halls-available">
                No lecture halls available matching your criteria.
              </div>
            )}
          </div>
          )}

          <div className="form-actions">
            <button 
              type="submit" 
              className="submit-btn"
              disabled={!selectedHall}
            >
              SUBMIT
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Request_Booking;