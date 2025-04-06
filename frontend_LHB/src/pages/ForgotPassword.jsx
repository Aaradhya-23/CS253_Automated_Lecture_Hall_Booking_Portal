import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './ForgotPassword.css';
import * as assets from '../assets/assets';
import api from '../api/api';

const ForgotPassword = () => {
  const [username, setUsername] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [otp, setOtp] = useState('');
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [message, setMessage] = useState('');
  const [isSuccess, setIsSuccess] = useState(false);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleResetPassword = async (e) => {
    e.preventDefault();

    if (newPassword !== confirmPassword) {
      setMessage('Passwords do not match.');
      return;
    }

    const userId = localStorage.getItem('userId');
    if (!userId) {
      setMessage('User ID not found. Please restart the process.');
      return;
    }

    setLoading(true);
    try {
      await api.post(`${import.meta.env.VITE_API_BASE_URL}accounts/users/change_password/`, {
        username,
        otp,
        new_password: newPassword,
      });

      setIsSuccess(true);
      setMessage('Password reset successful!');
    } catch (err) {
      // console.log(err.response.data['otp'])
      const errorData = err.response?.data;
      const firstField = Object.keys(errorData)[0];
      const firstErrorMessage = errorData[firstField][0]; // "OTP expired or wrong"
      setMessage(firstErrorMessage);
      // setMessage(err.response?.data?.error || 'Error resetting password');
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
        <div
          className="fp-image-container"
          style={{
            backgroundImage: `linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(${assets.assets.loginpageiitk})`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        ></div>

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

                  <div className="fp-form-group">
                    <label htmlFor="otp">OTP</label>
                    <div className="fp-input-container">
                      <input
                        type="text"
                        id="otp"
                        value={otp}
                        onChange={(e) => setOtp(e.target.value)}
                        placeholder="Enter OTP"
                        required
                      />
                      <span className="fp-input-icon">🔑</span>
                    </div>
                  </div>

                  {message && <p className="fp-error-message">{message}</p>}

                  <button type="submit" className="fp-reset-button" disabled={loading}>
                    {loading ? 'Resetting...' : 'Reset Password'}
                  </button>

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
