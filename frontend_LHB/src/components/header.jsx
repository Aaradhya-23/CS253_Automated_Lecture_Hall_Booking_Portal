import React from 'react';
import './Header.css';
// Option 1: If your image is in the public folder
// import iitk_logo from '../../public/assets/iitk_logo.png';
// Option 2: If your image is in the assets folder inside src
import iitk_logo from '../assets/iitk_logo.png';
import FRONTEND_ROUTES from '../frontend_urls';

// TODO: Backend Integration Comments:

// 1. Logout Functionality:
// - Replace window.location redirect with proper API call
// - Create logout function in src/api/auth.js
// - Call POST /api/auth/logout to invalidate token on server
// - Clear local storage/cookies of authentication tokens
// - Use React Router's navigate instead of window.location for better UX

// 2. User Information:
// - Get user data from AuthContext instead of hardcoding
// - Display user name/email in the header
// - Consider adding a user dropdown menu with profile options

// 3. Notifications:
// - Fetch notifications from backend API
// - Add notification bell icon with counter
// - Implement real-time notifications with WebSockets if needed

// 4. Session Management:
// - Add session timeout warning
// - Implement idle timeout detection
// - Add option to extend session


import { useNavigate, useLocation } from 'react-router-dom';

const Header = ({ isLoggedIn, userRole, handleLogout }) => {
  const navigate = useNavigate();
  const location = useLocation();

  return (
    <div className="header">
      <div className="logo-container">
        <img src={iitk_logo} alt="IIT-K Logo" className="logo" />
        <h1 className="title">IITK Lecture Hall Booking</h1>
      </div>

      <div>
        {/* Show Timetable if on login page */}
        {location.pathname === "/login" ? (
          <button className="button" onClick={() => navigate(FRONTEND_ROUTES.home)}>Timetable</button>
        ) : isLoggedIn ? (
          <>
            {/* Show Register for Admins */}
            {userRole === "admin" && (
              <button className="button" onClick={() => navigate(FRONTEND_ROUTES.register)}>Register a New User</button>
            )}
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
