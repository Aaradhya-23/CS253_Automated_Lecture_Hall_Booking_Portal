import React from 'react';
import './AdminNavbar.css';

const AdminNavbar = ({ onNavigate, currentPath }) => {
  // Map of navigation items to their respective routes
  const navItems = [
    { name: 'New', path: '/request_booking' },
    { name: 'Live Schedule', path: '/live_schedule' },
    { name: 'History', path: '/admin_view_booking' }, // Assuming Home page has history
    { name: 'View Pending', path: '/pending' }, // You'll need to add this route
    { name: 'Create New User', path: '/create_user' }, // You'll need to add this route
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