import React from 'react';
import './UserNavbar.css';
import FRONTEND_ROUTES from '../frontend_urls';


const UserNavbar = ({ onNavigate, currentPath }) => {
  // Map of navigation items to their respective routes
  const navItems = [
    { name: 'New', path: FRONTEND_ROUTES.requestBooking},
    { name: 'Live Schedule', path: '/live_schedule' },
    { name: 'History', path: '/history' }, // Changed from '/' to '/history'
    { name: 'Status', path: '/status' },
    { name: 'RoomDetails', path: FRONTEND_ROUTES.roomDetails },
    { name: 'Feedback', path: '/feedback' },
    { name: 'Help', path: '/help' },
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
          {item.name === 'New' && <span className="info-icon">ⓘ</span>}
        </button>
      ))}
    </div>
  );
};

export default UserNavbar;
