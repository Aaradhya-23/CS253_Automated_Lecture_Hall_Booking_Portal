import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './ForgotPassword.css';
import * as assets from '../assets/assets';

const ForgotPassword = () => {
  const [username, setUsername] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState('');
  const [isSuccess, setIsSuccess] = useState(false);
  const navigate = useNavigate();

  const handleResetPassword = async (e) => {
    e.preventDefault();

    if (newPassword !== confirmPassword) {
      setMessage('Passwords do not match.');
      return;
    }

    setLoading(true);

    try {
      // TODO: Replace with actual API call
      const response = await api.auth.resetPassword(username, newPassword);

      // Simulating API call
      await new Promise(resolve => setTimeout(resolve, 1500));

      setIsSuccess(true);
      setMessage('Your password has been reset successfully.');
    } catch (error) {
      setIsSuccess(false);
      const errorMsg = error?.response?.data?.detail || error.message || 'Unable to reset password. Please try again later.';
      setMessage(errorMsg);
    } finally {
      setLoading(false);
    }
  };

  const handleBackToLogin = () => {
    navigate('/login');
  };

  return (
    <div className="fp-page">
      <div className="fp-container">
        {/* Background Image Container */}
        <div
          className="fp-image-container"
          style={{
            backgroundImage: `linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(${assets.assets.loginpageiitk})`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        ></div>

        {/* Form Container */}
        <div className="fp-form-container">
          <div className="fp-header">
            <div className="fp-logo-container">
              <img src={assets.assets.iitk_logo} alt="IIT Kanpur Logo" className="fp-iit-logo" />
              <span>IIT Kanpur</span>
            </div>
          </div>

          <div className="fp-form-content">
            <h2>Reset your password</h2>
            <h1>Forgot Password</h1>

            {isSuccess ? (
              <div className="fp-success-message">
                <p>{message}</p>
                <button onClick={handleBackToLogin} className="fp-back-to-login-button">
                  Back to Login
                </button>
              </div>
            ) : (
              <>
                <p className="fp-description">Enter your username and new password to reset your account.</p>

                <form onSubmit={handleResetPassword} className="fp-form">
                  {/* Username Field */}
                  <div className="fp-form-group">
                    <label htmlFor="username">Username</label>
                    <div className="fp-input-container">
                      <input
                        type="text"
                        id="username"
                        value={username}
                        onChange={(e) => setUsername(e.target.value)}
                        placeholder="Enter your username"
                        required
                      />
                      <span className="fp-input-icon">👤</span>
                    </div>
                  </div>

                  {/* New Password Field */}
                  <div className="fp-form-group">
                    <label htmlFor="newPassword">New Password</label>
                    <div className="fp-input-container">
                      <input
                        type={showNewPassword ? 'text' : 'password'}
                        id="newPassword"
                        value={newPassword}
                        onChange={(e) => setNewPassword(e.target.value)}
                        placeholder="Enter new password"
                        required
                      />
                      <button
                        type="button"
                        className="fp-input-icon clickable"
                        onClick={() => setShowNewPassword(!showNewPassword)}
                      >
                        {showNewPassword ? '👁️' : '👁️‍🗨️'}
                      </button>
                    </div>
                  </div>

                  {/* Confirm Password Field */}
                  <div className="fp-form-group">
                    <label htmlFor="confirmPassword">Confirm Password</label>
                    <div className="fp-input-container">
                      <input
                        type={showConfirmPassword ? 'text' : 'password'}
                        id="confirmPassword"
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                        placeholder="Confirm new password"
                        required
                      />
                      <button
                        type="button"
                        className="fp-input-icon clickable"
                        onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                      >
                        {showConfirmPassword ? '👁️' : '👁️‍🗨️'}
                      </button>
                    </div>
                  </div>

                  {/* Error Message */}
                  {message && <p className="fp-error-message">{message}</p>}

                  {/* Reset Password Button */}
                  <button type="submit" className="fp-reset-button" disabled={loading}>
                    {loading ? 'Resetting...' : 'Reset Password'}
                  </button>

                  {/* Back to Login Button */}
                  <button type="button" className="fp-back-button" onClick={handleBackToLogin}>
                    Back to Login
                  </button>
                </form>
              </>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default ForgotPassword;
