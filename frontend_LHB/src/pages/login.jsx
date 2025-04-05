import React, { useState } from 'react';
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
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      await onLogin(username, password);
      toast.success('Login successful!'); // Show success message
      // navigate(FRONTEND_ROUTES.home); // Redirect to the home page after successful login
      setTimeout(() => {
        // If navigation happens in parent, this won't help
        navigate(FRONTEND_ROUTES.home);
      }, 1500);
    } catch (error) {
      toast.error(error?.response?.data?.detail || 'Invalid credentials. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleForgotPassword = () => {
    navigate(FRONTEND_ROUTES.requestOTP); // Navigate to the Forgot Password page
  };

  return (
    <div className="login-page">
      <ToastContainer position="top-right" autoClose={3000} hideProgressBar={false} newestOnTop={false} closeOnClick rtl={false} pauseOnFocusLoss draggable pauseOnHover />
      <div className="login-container">
        {/* <div
          className="login-image-container"
          style={{
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(${assets.assets.loginpageiitk}),
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        > */}
        <div
          className="login-image-container"
          style={{
            backgroundImage: `linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(${assets.assets.loginpageiitk})`,
            backgroundSize: "cover",
            backgroundPosition: "center",
          }}
        >
        </div>
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

            <form onSubmit={handleSubmit} className="login-form">
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
                  'Sign In'
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