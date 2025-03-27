// import React, { useState } from 'react';
// import './Adminviewbooking.css';

// // TODO: Backend Integration Comments:

// // 1. Admin Data Fetching:
// // - Replace mock data with admin API endpoints
// // - Create src/api/admin.js for admin-specific functions
// // - Call GET /api/admin/bookings with date range parameters
// // - Implement proper pagination and filtering

// // 2. Booking Management:
// // - Implement view/edit functionality:
// //   a) GET /api/admin/bookings/{id} for detailed view
// //   b) PUT /api/admin/bookings/{id} for updates
// // - Implement deletion with DELETE /api/admin/bookings/{id}
// // - Add confirmation dialogs for destructive actions

// // 3. Date Range Selection:
// // - Send selected date range to backend
// // - Format dates according to API requirements
// // - Implement calendar UI for date selection

// // 4. Search and Filtering:
// // - Implement server-side search via query parameters
// // - Add filters for status, hall, user, etc.
// // - Make filtering options dynamic based on available data

// // 5. Bulk Actions:
// // - Add functionality for bulk approve/reject/delete
// // - Implement POST /api/admin/bookings/bulk with action and IDs

// // 6. Access Control:
// // - Verify admin permissions before rendering component
// // - Disable actions based on user permissions
// // - Handle unauthorized access attempts

// // 7. Audit Logging:
// // - Log all admin actions for accountability
// // - Display who made changes and when


import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Adminviewbooking.css';

function Adminviewbooking (){
  const [dateRange, setDateRange] = useState({
    start: 'TUESDAY, JANUARY 21, 2025',
    end: 'FRIDAY, MARCH 14, 2025'
  });
  
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState('');
  const [openDropdownId, setOpenDropdownId] = useState(null);
  
  // Sample booking data
  const bookings = [
    { 
      id: 1, 
      time: '9:30 AM–11:00 AM', 
      duration: '(1h 30m)', 
      room: 'L-20',
      professor: 'Pclub',
      course: 'Intro to English Language'
    },
    { 
      id: 2, 
      time: '9:30 AM–10:15 AM', 
      duration: '(45m)', 
      room: 'LH3',
      professor: '(Prof A)',
      course: 'CS202'
    },
    { 
      id: 3, 
      time: '11:00 AM–12:00 PM', 
      duration: '(1h)', 
      room: 'LH8',
      professor: '(Prof B)',
      course: 'CS771'
    },
    { 
      id: 4, 
      time: '11:00 AM–12:00 PM', 
      duration: '(1h)', 
      room: 'LH2',
      professor: '(Prof C)',
      course: 'MTH112 QUIZ'
    },
    { 
      id: 5, 
      time: '11:45 AM–12:45 PM', 
      duration: '(1h)', 
      room: 'LH1',
      professor: '(Prof D)',
      course: 'CS253'
    }
  ];

  const toggleDropdown = (id) => {
    setOpenDropdownId(openDropdownId === id ? null : id);
  };

  const handleSearch = (e) => {
    setSearchQuery(e.target.value);
  };

  const handleViewDetails = (id) => {
    console.log(`View/edit details for booking ${id}`);
    // Navigate to booking details page with the ID parameter
    navigate(`/booking/${id}`);
    setOpenDropdownId(null);
  };

  const handleRemoveBooking = (id) => {
    console.log(`Remove booking ${id}`);
    setOpenDropdownId(null);
  };

  // Close dropdown when clicking outside
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
        <div className="admin-date-selector">
          <span>{dateRange.start}</span>
          <span className="admin-dropdown-arrow">▼</span>
        </div>
        <span className="admin-date-separator">–</span>
        <div className="admin-date-selector">
          <span>{dateRange.end}</span>
          <span className="admin-dropdown-arrow">▼</span>
        </div>
      </div>

      <div className="admin-filter-section">
        <div className="admin-filter-dropdown">
          <span>Filter</span>
          <span className="admin-dropdown-arrow">▼</span>
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
        <h2 className="admin-date-header">{dateRange.start}</h2>
        
        {bookings.map((booking) => (
          <div key={booking.id} className={`admin-booking-item ${booking.id === 1 ? 'highlighted' : ''}`}>
            <div className="admin-time-indicator">
              <div className="admin-blue-dot"></div>
              <div className="admin-time-text">
                <span>{booking.time}</span>
                <span className="admin-duration">{booking.duration}</span>
              </div>
            </div>
            
            <div className="admin-booking-info">
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
};

export default Adminviewbooking;
