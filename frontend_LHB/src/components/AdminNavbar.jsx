import React from 'react';
import './AdminNavbar.css';
import FRONTEND_ROUTES from '../frontend_urls';

const AdminNavbar = ({ onNavigate, currentPath }) => {
  // Map of navigation items to their respective routes
  const navItems = [
    { name: 'New', path: FRONTEND_ROUTES.requestBooking },
    { name: 'Live Schedule', path: FRONTEND_ROUTES.home },
    { name: 'History', path: FRONTEND_ROUTES.adminViewBooking }, // Assuming Home page has history
    { name: 'View Pending', path: FRONTEND_ROUTES.viewPending }, // You'll need to add this route
    { name: 'Create New User', path: FRONTEND_ROUTES.register }, // You'll need to add this route
    { name: 'Help', path: '/help' },
  ];

  return (
    <div className="admin-navbar">
      {navItems.map((item) => (
        <button
          key={item.name}
          onClick={() => onNavigate(item.path)}
          className={`admin-nav-item ${currentPath === item.path ? 'active' : ''}`}
        >
          {item.name}
          {item.name === 'New' && <span className="admin-info-icon">ⓘ</span>}
        </button>
      ))}
    </div>
  );
};

export default AdminNavbar;