import React from 'react';
import './Header.css';
import { assets } from '../assets/assets';
import FRONTEND_ROUTES from '../frontend_urls';

import { useNavigate, useLocation } from 'react-router-dom';

const Header = ({ isLoggedIn, userRole, handleLogout }) => {
  const navigate = useNavigate();
  const location = useLocation();

  return (
    <div className="header">
      <div className="logo-container">
        <img src={assets.iitk_logo} alt="IIT-K Logo" className="logo" />
        <h1 className="title" onClick={() => navigate(FRONTEND_ROUTES.home)} style={{ cursor: 'pointer' }}>
          IITK Lecture Hall Booking
        </h1>
      </div>

      <div>
        {/* Show Timetable if on login page */}
        {location.pathname === "/login" ? (
          <button className="button" onClick={() => navigate(FRONTEND_ROUTES.home)}>Timetable</button>
        ) : isLoggedIn ? (
          <>
            {/* Logout Button */}
            <button className="button" onClick={handleLogout}>Logout</button>
          </>
        ) : (
          // Show Login for Non-Logged In Users
          <button className="button" onClick={() => navigate(FRONTEND_ROUTES.login)}>Login</button>
        )}
      </div>
    </div>
  );
};

export default Header;