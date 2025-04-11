
import React, { useState, useRef, useEffect } from 'react';
import './Header.css';
import { assets } from '../assets/assets';
import FRONTEND_ROUTES from '../frontend_urls';
import { useNavigate, useLocation } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
const Header = ({ isLoggedIn, userRole, handleLogout }) => {
  const navigate = useNavigate();
  const location = useLocation();
  const [showProfileMenu, setShowProfileMenu] = useState(false);
  const profileRef = useRef(null);

  const username = localStorage.getItem("USERNAME");
  const email = localStorage.getItem("EMAIL");
  const role = localStorage.getItem("ROLE");
  // Handle click outside to close dropdown
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (profileRef.current && !profileRef.current.contains(event.target)) {
        setShowProfileMenu(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);
  const handleForgotPassword = () => {
    navigate(FRONTEND_ROUTES.requestOTP);
    setShowProfileMenu(false);
  };
  return (
    <div className="header">
      <div className="logo-container">
        <img src={assets.iitk_logo} alt="IIT-K Logo" className="logo" />
        <h1 className="title" onClick={() => navigate(FRONTEND_ROUTES.home)} style={{ cursor: 'pointer' }}>
          IITK Lecture Hall Booking
        </h1>
      </div>
      <div className="header-right">
        {location.pathname === "/login" ? (
          <button className="button" onClick={() => navigate(FRONTEND_ROUTES.home)}>
            Timetable
          </button>
        ) : isLoggedIn ? (
          <div className="profile-section" ref={profileRef}>
            <button
              className="profile-button"
              onClick={() => setShowProfileMenu(!showProfileMenu)}
            >
              <div className="profile-avatar">
                {username?.charAt(0).toUpperCase()}
              </div>
            </button>
            <AnimatePresence>
              {showProfileMenu && (
                <motion.div
                  className="profile-dropdown"
                  initial={{ opacity: 0, y: -20 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0, y: -20 }}
                  transition={{ duration: 0.2 }}
                >
                  <div className="profile-header">
                    <div className="profile-avatar large">
                      {username?.charAt(0).toUpperCase()}
                    </div>
                    <div className="profile-info">
                      <h3 className="profile-name">{username}</h3>
                      <p className="profile-email">{email}</p>
                      <span className="profile-role">{role}</span>
                    </div>
                  </div>
                  <div className="profile-menu">
                    <button
                      className="menu-item"
                      onClick={handleForgotPassword}
                    >
                      <span className="menu-icon">🔑</span>
                      Change Password
                    </button>
                    <div className="menu-divider"></div>
                    <button
                      className="menu-item logout"
                      onClick={() => {
                        handleLogout();
                        setShowProfileMenu(false);
                      }}
                    >
                      <span className="menu-icon">↪️</span>
                      Logout
                    </button>
                  </div>
                </motion.div>
              )}
            </AnimatePresence>
          </div>
        ) : (
          <button className="button" onClick={() => navigate(FRONTEND_ROUTES.login)}>
            Login
          </button>
        )}
      </div>
    </div>
  );
};
export default Header;     