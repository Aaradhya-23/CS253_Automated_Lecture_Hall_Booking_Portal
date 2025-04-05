import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { AnimatePresence, motion } from "framer-motion"; // Import Framer Motion
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
    end: new Date(new Date().setMonth(new Date().getMonth() + 1)).toISOString().split("T")[0]
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
    <motion.div
     className="admin-booking-main"
     initial={{ opacity: 0, y: 20 }} // Initial state for animation
      animate={{ opacity: 1, y: 0 }} // Final state for animation
      transition={{ duration: 0.6 }}
      >
      {/* Date Range Section */}
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
    <div className="admin-filter-info">
    </div>
    <div className="admin-filter-row">
      <span className="admin-filter-column">
        <span className="admin-filter-label">Username</span>
        <input
          type="text"
          placeholder="Filter by username"
          className="admin-search-input"
          value={filterUsername}
          onChange={(e) => setFilterUsername(e.target.value)}
        />
      </span>

    <span className="admin-filter-column">
      <span className="admin-filter-label">Lecture Hall</span>
      <input
        type="text"
        placeholder="Filter by lecture hall"
        className="admin-search-input"
        value={filterLectureHall}
        onChange={(e) => setFilterLectureHall(e.target.value)}
      />
    </span>

    <span className="admin-filter-column">
    <span className="admin-filter-label">Search by keyword...</span>
      <input
          type="text"
          placeholder="Search..."
          className="admin-search-input"
          value={searchQuery}
          onChange={handleSearch}
        />
    </span>
  </div>
</div>
      <div className="admin-bookings-list">
        <div className="admin-booking-item highlighted">
          {/* Header Row */}
          <div className="admin-time-indicator">
            <div className="admin-time-text">
              <span>Time</span>
              <span className="admin-duration">(duration)</span>
            </div>
          </div>
          <div className="admin-booking-info">
            <div className="admin-room-info">Booking Date</div>
            <div className="admin-room-info">Lecture Hall</div>
            <div className="admin-professor-info">Username</div>
            <div className="admin-course-info">Purpose</div>
          </div>
          <div className="admin-booking-actions">
            <div className="admin-course-info">Action</div>
          </div>
        </div>

        {/* Animated Booking Items */}
        <AnimatePresence>
          {filteredBookings.map((booking) => (
            <div
              key={booking.id}
              className="admin-booking-item"
            >
              <div className="admin-time-indicator">
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

                {/* Animated Dropdown Menu */}
                <AnimatePresence>
                  {openDropdownId === booking.id && (
                    <motion.div
                      className="admin-dropdown-menu"
                      initial={{ opacity: 0, scale: 0.9 }}
                      animate={{ opacity: 1, scale: 1 }}
                      exit={{ opacity: 0, scale: 0.9 }}
                      transition={{ duration: 0.3 }}
                    >
                      <button
                        onClick={() => handleViewDetails(booking.id)}
                        className="admin-dropdown-item"
                      >
                        <span className="admin-icon">✎</span> View
                      </button>
                      <button
                        onClick={() => handleRemoveBooking(booking.id)}
                        className="admin-dropdown-item"
                      >
                        <span className="admin-icon admin-trash">🗑</span> Remove booking
                      </button>
                    </motion.div>
                  )}
                </AnimatePresence>
              </div>
            </div>
          ))}
        </AnimatePresence>
      </div>
    </motion.div>
  );
}

export default Adminviewbooking;
