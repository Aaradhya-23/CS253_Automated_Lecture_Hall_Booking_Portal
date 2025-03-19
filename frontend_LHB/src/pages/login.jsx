import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './LoginPage.css';
import { assets } from '../assets/assets';

const LoginPage = ({ onLogin }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    // Test credentials
    if (email === 'admin@iitk.ac.in' && password === 'admin123') {
      console.log('Login successful');
      if (onLogin) {
        onLogin(email);
      }
      // Redirect to request-booking page after successful login
      navigate('/request-booking');
    } else {
      alert('Invalid credentials. Please try again.');
    }
  };

  return (
    <div className="login-page">
      <div className="login-container">
        <div className="login-image-container">
          {/* Removed the nested campus-image div as it's not needed */}
        </div>
        
        <div className="login-form-container">
          <div className="login-header">
            <div className="logo-container">
              <img 
                src={assets.iitk_logo} 
                alt="IIT Kanpur Logo" 
                className="iit-logo"
              />
              <span>IIT Kanpur</span>
            </div>
          </div>
          
          <div className="login-form-content">
            <h2>Book lecture hall</h2>
            <h1>Sign In to LHB Portal</h1>
            
            <form onSubmit={handleSubmit} className="login-form">
              <div className="form-group">
                <label htmlFor="email">E-mail</label>
                <div className="input-container">
                  <input
                    type="email"
                    id="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="example@iitk.ac.in"
                    required
                  />
                  <span className="input-icon">📧</span>
                </div>
              </div>
              
              <div className="form-group">
                <label htmlFor="password">Password</label>
                <div className="input-container">
                  <input
                    type={showPassword ? "text" : "password"}
                    id="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="••••••••"
                    required
                  />
                  <button 
                    type="button"
                    className="input-icon clickable"
                    onClick={() => setShowPassword(!showPassword)}
                  >
                    {showPassword ? "👁️" : "👁️‍🗨️"}
                  </button>
                </div>
              </div>
              
              <button type="submit" className="sign-in-button">
                Sign In
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};

export default LoginPage;