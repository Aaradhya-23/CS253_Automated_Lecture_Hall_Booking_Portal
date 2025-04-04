import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../api/api';
import FRONTEND_ROUTES from '../frontend_urls';

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
        email, username,
      });
      const userId = response.data.user_id;
      localStorage.setItem('userId', userId); // Store userId in local storage for later use
    //   console.log('User ID:', userId); // Debugging line to check userId
    //   console.log('Email:', email); // Debugging line to check email

      // redirect and pass userId + email to the reset page
      navigate(FRONTEND_ROUTES.forgotPassword, { state: { userId, email } });
    } catch (err) {
      alert(err.response?.data?.error || 'Something went wrong');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fp-container">  
      <form onSubmit={handleRequestOtp}>
      <h2>Username</h2>
        <input
          type="text"
          placeholder="Enter your username"
          required
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
        <h2>Forgot Password</h2>
        <input
          type="email"
          placeholder="Enter your email"
          required
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <button type="submit" disabled={loading}>
          {loading ? 'Sending OTP...' : 'Send OTP'}
        </button>
      </form>
    </div>
  );
};

export default OTPRequest;

