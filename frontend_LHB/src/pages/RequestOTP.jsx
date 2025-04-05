import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../api/api';
import FRONTEND_ROUTES from '../frontend_urls';
import { FaEnvelope, FaUser, FaLock } from 'react-icons/fa';
import { toast, ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import './RequestOTP.css';

const OTPRequest = () => {
  const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleRequestOtp = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const response = await api.post(`${import.meta.env.VITE_API_BASE_URL}accounts/request_reset/`, {
        email,
        username,
      });
      const userId = response.data.user_id;
      localStorage.setItem('userId', userId);

      toast.success('OTP sent successfully!', {
        autoClose: 3000,
      });
      setTimeout(() => {
        navigate(FRONTEND_ROUTES.forgotPassword, { state: { userId, email } });
      }, 2000);
    } catch (err) {
      toast.error(err.response?.data?.error || 'Something went wrong', {
        autoClose: 3000,
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="otp-request-container">
      <ToastContainer />
      <div className="otp-request-card">
        <h2 className="otp-request-title">
          <FaLock className="otp-request-title-icon" />
          Forgot Password?
        </h2>
        <p className="otp-request-description">
          Enter your username and email to receive a password reset OTP.
        </p>
        <form onSubmit={handleRequestOtp} className="otp-request-form">
          <div className="otp-request-input-group">
            <FaUser className="otp-request-input-icon" />
            <input
              type="text"
              placeholder="Username"
              required
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              className="otp-request-input-field"
            />
          </div>
          <div className="otp-request-input-group">
            <FaEnvelope className="otp-request-input-icon" />
            <input
              type="email"
              placeholder="Email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="otp-request-input-field"
            />
          </div>
          <button
            type="submit"
            disabled={loading}
            className={`otp-request-submit-button ${loading ? 'loading' : ''}`}
          >
            {loading ? (
              <>
                <div className="otp-request-spinner"></div>
                Sending OTP...
              </>
            ) : (
              'Send OTP'
            )}
          </button>
        </form>
      </div>
    </div>
  );
};

export default OTPRequest;
