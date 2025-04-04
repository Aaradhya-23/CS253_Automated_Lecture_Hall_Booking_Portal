import React from 'react';
import './UserNavbar.css';
import FRONTEND_ROUTES from '../frontend_urls';

const UserNavbar = ({ onNavigate, currentPath }) => {
  // Map of navigation items to their respective routes
  const navItems = [
    { name: 'New Booking', path: FRONTEND_ROUTES.requestBooking },
    { name: 'Live Schedule', path: FRONTEND_ROUTES.home },
    { name: 'History', path: FRONTEND_ROUTES.history }, // Changed from '/' to '/history'
    { name: 'Status', path: FRONTEND_ROUTES.status },
    { name: 'Room Details', path: FRONTEND_ROUTES.roomDetails },
    { name: 'Feedback', path: FRONTEND_ROUTES.feedback },
    { name: 'Help', path: FRONTEND_ROUTES.userhelp },
  ];

  return (
    <div className="user-navbar">
      {navItems.map((item) => (
        <button
          key={item.name}
          onClick={() => onNavigate(item.path)}
          className={`nav-item ${currentPath === item.path ? 'active' : ''}`}
        >
          {item.name}
          {item.name === 'New'}
        </button>
      ))}
    </div>
  );
};

export default UserNavbar;
