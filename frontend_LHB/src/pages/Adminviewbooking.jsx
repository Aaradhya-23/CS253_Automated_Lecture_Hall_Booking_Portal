import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
// import axios from 'axios';
import api from '../api/api';
import './Adminviewbooking.css';

const HISTORY_URL = import.meta.env.VITE_API_BASE_URL; // API Endpoint

const convertTo12HourFormat = (time) => {
  const [hours, minutes] = time.split(':').map(Number);
  const period = hours >= 12 ? 'PM' : 'AM';
  const hour12 = hours % 12 || 12;
  return `${hour12}:${String(minutes).padStart(2, '0')} ${period}`;
};

const transformBookings = (fetchedBookings) => {
  return fetchedBookings.map(booking => ({
    id: booking.id,
    date: booking.booking_date, // Added for filtering
    time: `${convertTo12HourFormat(booking.start_time)}–${convertTo12HourFormat(booking.end_time)}`,
    duration: `(${booking.duration}h)`,
    room: booking.room_details.name,
    professor: booking.creator.username,
    course: booking.title
  }));
};

function Adminviewbooking() {
  const [bookings, setBookings] = useState([]);
  const [filteredBookings, setFilteredBookings] = useState([]); // New state for filtered bookings
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [dateRange, setDateRange] = useState({
    start: new Date(new Date().setMonth(new Date().getMonth() - 1)).toISOString().split("T")[0],
    end: new Date().toISOString().split("T")[0]
  });
  const [editingDate, setEditingDate] = useState(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [filterUsername, setFilterUsername] = useState(''); // **Changed**: Added state for username filter
  const [filterLectureHall, setFilterLectureHall] = useState(''); // **Changed**: Added state for lecture hall filter
  const [openDropdownId, setOpenDropdownId] = useState(null);

  const navigate = useNavigate();

  useEffect(() => {
    const fetchBookings = async () => {
      setLoading(true);
      setError(null);

      const token = localStorage.getItem('ACCESS_TOKEN');

      if (!token) {
        console.error("No ACCESS_TOKEN found in localStorage.");
        setError("User not authenticated. Please log in.");
        setLoading(false);
        return;
      }

      try {
        const response = await api.get(`${HISTORY_URL}?status=approved/`, {
          headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
        });

        console.log("Fetched Bookings:", response.data);

        const transformedData = transformBookings(response.data);
        setBookings(transformedData);
      } catch (err) {
        console.error("Error fetching bookings:", err.response?.data || err.message);
        setError("Failed to load bookings.");
      } finally {
        setLoading(false);
      }
    };

    fetchBookings();
  }, []);

  // **Date Range Filtering**
  // filtering the booking based on date 
  useEffect(() => {
    const startDate = new Date(dateRange.start);
    const endDate = new Date(dateRange.end);

    const filtered = bookings.filter((booking) => {
      const bookingDate = new Date(booking.date);
      const matchesDate = bookingDate >= startDate && bookingDate <= endDate;
      const matchesSearchQuery = booking.professor.toLowerCase().includes(searchQuery.toLowerCase()) ||
        booking.course.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesUsernameFilter = booking.professor.toLowerCase().includes(filterUsername.toLowerCase()); // **Changed**: Added username filter
      const matchesLectureHallFilter = booking.room.toLowerCase().includes(filterLectureHall.toLowerCase()); // **Changed**: Added lecture hall filter

      return matchesDate && matchesSearchQuery && matchesUsernameFilter && matchesLectureHallFilter;
    });

    setFilteredBookings(filtered);
  }, [dateRange, bookings, searchQuery, filterUsername, filterLectureHall]); // **Changed**: Added `filterUsername` and `filterLectureHall` dependencies

  // changing start-end date date based on date picker
  const handleDateChange = (event, type) => {
    setDateRange(prev => ({
      ...prev,
      [type]: event.target.value
    }));
    setEditingDate(null);
  };

  const toggleDropdown = (id) => {
    setOpenDropdownId(openDropdownId === id ? null : id);
  };

  const handleSearch = (e) => {
    setSearchQuery(e.target.value);
  };

  const handleViewDetails = (id) => {
    console.log(`View/edit details for booking ${id}`);
    navigate(`/booking/${id}`);
    setOpenDropdownId(null);
  };

  const handleRemoveBooking = async (id) => {
    console.log(`Removing booking with ID: ${id}`);
    const token = localStorage.getItem('ACCESS_TOKEN');
    try {
        await api.post(
            `${import.meta.env.VITE_API_BASE_URL}bookings/send-rejected-mail/${id}/`,
            { remark: "Your booking was removed by admin" },  // Fixed remark
            {
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                    Accept: "application/json",
                },
            }
        );

        console.log(`Rejection email sent for booking ${id}.`);
        alert("Booking removed, email sent to user.");

        // Close dropdown after successful removal
        setOpenDropdownId(null);
    } catch (error) {
        console.error("Error removing booking:", error);
        alert("Error removing booking. Please try again.");
    }
};


  React.useEffect(() => {
    const handleClickOutside = (event) => {
      if (openDropdownId && !event.target.closest('.admin-booking-actions')) {
        setOpenDropdownId(null);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [openDropdownId]);

  return (
    <div className="admin-booking-main">
      <div className="admin-date-range-section">
        <div className="admin-date-selector" onClick={() => setEditingDate('start')}>
          {editingDate === 'start' ? (
            <input
              type="date"
              value={dateRange.start}
              onChange={(e) => handleDateChange(e, 'start')}
              onBlur={() => setEditingDate(null)}
              autoFocus
            />
          ) : (
            <span>{new Date(dateRange.start).toDateString()}</span>
          )}
          <span className="admin-dropdown-arrow">▼</span>
        </div>
        <span className="admin-date-separator">–</span>

        <div className="admin-date-selector" onClick={() => setEditingDate('end')}>
          {editingDate === 'end' ? (
            <input
              type="date"
              value={dateRange.end}
              onChange={(e) => handleDateChange(e, 'end')}
              onBlur={() => setEditingDate(null)}
              autoFocus
            />
          ) : (
            <span>{new Date(dateRange.end).toDateString()}</span>
          )}
          <span className="admin-dropdown-arrow">▼</span>
        </div>
      </div>

      <div className="admin-filter-section">
        <div className="admin-filter-dropdown">
          <span>Filter</span>
          <span className="admin-dropdown-arrow">▼</span>
        </div>

        {/* **Changed**: Added input for filtering by username */}
        <div className="admin-filter-dropdown">
          <span>Username</span>
          <input
            type="text"
            placeholder="Filter by username"
            className="admin-search-input"
            value={filterUsername}
            onChange={(e) => setFilterUsername(e.target.value)} // **Changed**: Set state for username filter
          />
        </div>

        {/* **Changed**: Added input for filtering by lecture hall */}
        <div className="admin-filter-dropdown">
          <span>Lecture Hall</span>
          <input
            type="text"
            placeholder="Filter by lecture hall"
            className="admin-search-input"
            value={filterLectureHall}
            onChange={(e) => setFilterLectureHall(e.target.value)} // **Changed**: Set state for lecture hall filter
          />
        </div>

        <input
          type="text"
          placeholder="Search..."
          className="admin-search-input"
          value={searchQuery}
          onChange={handleSearch}
        />
      </div>

      <div className="admin-bookings-list">
        <h2 className="admin-date-header">{new Date(dateRange.start).toDateString()}</h2>
        <div className="admin-booking-item highlighted">
          <div className="admin-time-indicator">
            <div className="admin-blue-dot"></div>
            <div className="admin-time-text">
              <span>Time <slot></slot></span>
              <span className="admin-duration">duration</span>
            </div>
          </div>

          <div className="admin-booking-info">
            <div className="admin-room-info">BookingDate</div>
            <div className="admin-room-info">LectureHall</div>
            <div className="admin-professor-info">UserName</div>
            <div className="admin-course-info">Purpose</div>
            {/* <div className="admin-booking-date">📅 2025-03-28</div> */}
          </div>

          <div className="admin-booking-actions">
            <button className="admin-manage-btn">Action <span className="admin-dropdown-arrow">▼</span></button>
          </div>
        </div>

        {filteredBookings.map((booking) => (

          <div key={booking.id} className={`admin-booking-item `}>
            <div className="admin-time-indicator">
              <div className="admin-blue-dot"></div>
              <div className="admin-time-text">
                <span>{booking.time}</span>
                <span className="admin-duration">{booking.duration}</span>
              </div>
            </div>

            <div className="admin-booking-info">
              <div className="admin-room-info">{booking.date}</div>
              <div className="admin-room-info">{booking.room}</div>
              <div className="admin-professor-info">{booking.professor}</div>
              <div className="admin-course-info">{booking.course}</div>
            </div>

            <div className="admin-booking-actions">
              <button
                className="admin-manage-btn"
                onClick={() => toggleDropdown(booking.id)}
              >
                Manage <span className="admin-dropdown-arrow">▼</span>
              </button>

              {openDropdownId === booking.id && (
                <div className="admin-dropdown-menu">
                  <button onClick={() => handleViewDetails(booking.id)} className="admin-dropdown-item">
                    <span className="admin-icon">✎</span> View/edit details
                  </button>
                  <button onClick={() => handleRemoveBooking(booking.id)} className="admin-dropdown-item">
                    <span className="admin-icon admin-trash">🗑</span> Remove booking
                  </button>
                </div>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default Adminviewbooking;
