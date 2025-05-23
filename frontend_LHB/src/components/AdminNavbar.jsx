import React, { useState } from 'react';
import './AdminNavbar.css';
import FRONTEND_ROUTES from '../frontend_urls';
import { motion } from 'framer-motion';
import { useNavigate, useLocation } from 'react-router-dom';
const AdminNavbar = () => {
  const [isVisible, setIsVisible] = useState(true);
  const navigate = useNavigate();
  const location = useLocation(); // for currentPath comparison
  const navItems = [
    { name: 'New Booking', path: FRONTEND_ROUTES.requestBooking },
    { name: 'Live Schedule', path: FRONTEND_ROUTES.home },
    { name: 'History', path: FRONTEND_ROUTES.adminViewBooking },
    { name: 'View Pending', path: FRONTEND_ROUTES.viewPending },
    { name: 'Room Details', path: FRONTEND_ROUTES.roomDetails },
    { name: 'Create New User', path: FRONTEND_ROUTES.register }, // You'll need to add this route
    { name: 'Feedback', path: FRONTEND_ROUTES.adminfeedbackview },
    { name: 'Help', path: FRONTEND_ROUTES.adminhelp },
  ];
  return (
    <>
      <div
        className="navbar-trigger-area"
        onMouseEnter={() => setIsVisible(true)}
      ></div>
      <motion.div
        className="admin-navbar"
        initial={{ x: -220, opacity: 0 }}
        animate={isVisible ? { x: 0, opacity: 1 } : { x: -220, opacity: 0 }}
        transition={{ duration: 0.5, ease: "easeInOut" }}
        onMouseEnter={() => setIsVisible(true)}
        onMouseLeave={() => setIsVisible(false)}
      >
        {navItems.map((item, index) => (
          <motion.button
            key={item.name}
            onClick={() => {
              console.log(item);
              navigate(item.path);
            }}
            whileTap={{ scale: 0.95 }}
            initial={{ opacity: 0, y: 20 }}
            animate={isVisible ? { opacity: 1, y: 0 } : { opacity: 0, y: 20 }}
            transition={{ duration: 0.4, delay: index * 0.1 }}
            className={`admin-nav-item ${
              location.pathname === item.path ? 'active' : ''
            }`}
          >
            {item.name}
          </motion.button>
        ))}
      </motion.div>
    </>
  );
};
export default AdminNavbar;