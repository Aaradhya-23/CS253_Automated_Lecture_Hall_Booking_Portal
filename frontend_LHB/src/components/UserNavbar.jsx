import React, { useState } from 'react';
import './UserNavbar.css';
import FRONTEND_ROUTES from '../frontend_urls';
import { motion } from 'framer-motion';

const UserNavbar = ({ onNavigate, currentPath }) => {
  const [isVisible, setIsVisible] = useState(true);

  const navItems = [
    { name: 'New Booking', path: FRONTEND_ROUTES.requestBooking },
    { name: 'Live Schedule', path: FRONTEND_ROUTES.home },
    { name: 'History', path: FRONTEND_ROUTES.history },
    { name: 'Status', path: FRONTEND_ROUTES.status },
    { name: 'Room Details', path: FRONTEND_ROUTES.roomDetails },
    { name: 'Feedback', path: FRONTEND_ROUTES.feedback },
    { name: 'Help', path: FRONTEND_ROUTES.userhelp },
  ];

  return (
    <>
      <div
        className="navbar-trigger-area"
        onMouseEnter={() => setIsVisible(true)}
      ></div>

      <motion.div
        className="user-navbar"
        initial={{ x: -220, opacity: 0 }}
        animate={isVisible ? { x: 0, opacity: 1 } : { x: -220, opacity: 0 }}
        transition={{ duration: 0.5, ease: 'easeInOut' }}
        onMouseEnter={() => setIsVisible(true)}
        onMouseLeave={() => setIsVisible(false)}
      >
        {navItems.map((item, index) => (
          <motion.button
            key={item.name}
            onClick={() => onNavigate(item.path)}
            whileTap={{ scale: 0.95 }}
            initial={{ opacity: 0, y: 20 }}
            animate={isVisible ?{ opacity: 1, y: 0 } : { opacity: 0, y: 20 }}
            transition={{ duration: 0.4, delay: index * 0.1 }}
            className={`nav-item ${currentPath === item.path ? 'active' : ''}`}
          >
            {item.name}
          </motion.button>
        ))}
      </motion.div>
    </>
  );
};

export default UserNavbar;
