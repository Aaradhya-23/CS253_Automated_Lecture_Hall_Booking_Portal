// export default Login;
import React, { useState } from 'react';
import { motion, AnimatePresence } from "framer-motion";
import { useNavigate } from 'react-router-dom';
import './Login.css';
import * as assets from '../assets/assets';
import FRONTEND_ROUTES from '../frontend_urls';
import {FaEye, FaEyeSlash, FaUser} from 'react-icons/fa';
import {toast,ToastContainer} from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css' // Importing icons for show/hide password
// Backend Integration Comments remain unchanged

const Login = ({ onLogin }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [showSuccess, setShowSuccess] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null); // Reset error on new submission
    
    try {
      await onLogin(username, password);
      setShowSuccess(true);
      setTimeout(() => setShowSuccess(false), 3000); // Show success message for 2 seconds
    } catch (error) {
      toast.error(error?.response?.data?.detail || 'Invalid credentials. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleForgotPassword = () => {
    navigate(FRONTEND_ROUTES.requestOTP);
  };

  return (
    <div className="login-page">
      <ToastContainer position="top-right" autoClose={3000} hideProgressBar={false} newestOnTop={false} closeOnClick rtl={false} pauseOnFocusLoss draggable pauseOnHover />
      <div className="login-container">
        <div
          className="login-image-container"
          style={{
            backgroundImage: `linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(${assets.assets.loginpageiitk})`,
            backgroundSize: "cover",
            backgroundPosition: "center",
          }}
        ></div>
        
        <div className="login-form-container">
          <div className="login-header">
            <div className="logo-container">
              <img
                src={assets.assets.iitk_logo}
                alt="IIT Kanpur Logo"
                className="iit-logo"
              />
              <span>IIT Kanpur</span>
            </div>
          </div>

          <div className="login-form-content">
            <h2>Lecture Hall Booking System</h2>
            <h1>Welcome Back</h1>
            <p className="login-subtitle">Sign in to access your account</p>

            {/* Animated Messages Container */}
            <div className="messages-container">
              <AnimatePresence>
                {error && (
                  <motion.div
                    key="error"
                    initial={{ opacity: 0, y: -20 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, y: -20 }}
                    transition={{ duration: 0.3 }}
                    className="error-message"
                  >
                    <i className="fas fa-exclamation-circle"></i> {error}
                  </motion.div>
                )}
              </AnimatePresence>

              <AnimatePresence>
                {showSuccess && (
                  <motion.div
                    key="success"
                    initial={{ opacity: 0, y: -20 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, y: -20 }}
                    transition={{ duration: 0.3 }}
                    className="success-message"
                  >
                    <i className="fas fa-check-circle"></i> Login successful!
                  </motion.div>
                )}
              </AnimatePresence>
            </div>

            <form onSubmit={handleSubmit} className="login-form">
              {/* ... rest of your form fields remain unchanged ... */}
              <div className="form-group">
                <label htmlFor="username">Username</label>
                <div className="input-container">
                  <input
                    type="text"
                    id="username"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    placeholder="Enter your username"
                    required
                  />
                  <span className="input-icon">
                    <FaUser />
                  </span>
                </div>
              </div>

              <div className="form-group">
                <label htmlFor="password">Password</label>
                <div className="input-container">
                  <input
                    type={showPassword ? 'text' : 'password'}
                    id="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="••••••••"
                    autoComplete="current-password"
                    required
                  />
                  <button
                    type="button"
                    className="absolute right-2 top-1/2 transform -translate-y-1/2"
                    onClick={() => setShowPassword(!showPassword)}
                    aria-label={showPassword ? 'Hide password' : 'Show password'}
                  >
                    {showPassword ? <FaEyeSlash /> : <FaEye />}
                  </button>
                </div>
              </div>

              <div className="forgot-password-container">
                <button 
                  type="button" 
                  className="forgot-password-link"
                  onClick={handleForgotPassword}
                >
                  Forgot Password?
                </button>
              </div>

              <button
                type="submit"
                className="sign-in-button"
                disabled={loading}
              >
                {loading ? (
                  <span className="loading-spinner">
                    <i className="fas fa-circle-notch fa-spin"></i> Signing In
                  </span>
                ) : (
                  'Login'
                )}
              </button>
            </form>

            <div className="login-footer">
              <p>© {new Date().getFullYear()} IIT Kanpur. All rights reserved.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Login;