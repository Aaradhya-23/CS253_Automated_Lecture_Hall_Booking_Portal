// import React, { useState } from 'react';
// import { useNavigate } from 'react-router-dom';
// import './Login.css';
// import * as assets from '../assets/assets';

// // TODO: Backend Integration Comments:

// // 1. Authentication API:
// // - Replace hardcoded login with real backend authentication
// // - Create API service in src/api/auth.js with login endpoint
// // - Send credentials to POST /api/auth/login 
// // - Expected response: { user: {...}, token: "jwt_token", refreshToken: "refresh_token" }

// // 2. Error Handling:
// // - Handle various authentication errors:
// //   a) Invalid credentials (401)
// //   b) Account locked (403)
// //   c) Server errors (500)
// //   d) Network issues
// // - Display appropriate error messages to the user

// // 3. Form Validation:
// // - Add client-side validation for email format
// // - Consider rate limiting login attempts on frontend

// // 4. Token Storage:
// // - Store JWT token securely (HttpOnly cookies preferred)
// // - Save user data in AuthContext or global state
// // - Implement token refresh mechanism

// // 5. Remember Me Functionality:
// // - Add a "Remember Me" checkbox if needed
// // - Store persistent login state only if explicitly requested

// // 6. Security Enhancements:
// // - Consider implementing CAPTCHA for multiple failed attempts
// // - Add loading state during authentication
// // - Disable form submission while request is in progress

// const Login = ({ onLogin }) => {
//   const [username, setUsername] = useState(''); // Changed from email to username
//   const [password, setPassword] = useState('');
//   const [showPassword, setShowPassword] = useState(false);
//   const [loading, setLoading] = useState(false); // Added loading state
//   const navigate = useNavigate();

//   const handleSubmit = async (e) => {
//     e.preventDefault();
//     setLoading(true);
//     try {
//       await onLogin(username, password); 
//     } catch (error) {
//       alert(error?.response?.data?.detail || 'Invalid credentials. Please try again.');
//     } finally {
//       setLoading(false);
//     }
//   };

//   return (
//     <div className="login-page">
//       <div className="login-container">
//         <div
//           className="login-image-container"
//           style={{
//             background: `linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(${assets.assets.loginpageiitk})`,
//             backgroundSize: 'cover',
//             backgroundPosition: 'center',
//           }}
//         >
//           {/* The background image is set via inline style now */}
//         </div>
//         <div className="login-form-container">
//           <div className="login-header">
//             <div className="logo-container">
//               <img
//                 src={assets.assets.iitk_logo}
//                 alt="IIT Kanpur Logo"
//                 className="iit-logo"
//               />
//               <span>IIT Kanpur</span>
//             </div>
//           </div>

//           <div className="login-form-content">
//             <h2>Book lecture hall</h2>
//             <h1>Sign In to LHB Portal</h1>

//             <form onSubmit={handleSubmit} className="login-form">
//               <div className="form-group">
//                 <label htmlFor="username">Username</label> {/* Updated label */}
//                 <div className="input-container">
//                   <input
//                     type="text"
//                     id="username"
//                     value={username}
//                     onChange={(e) => setUsername(e.target.value)}
//                     placeholder="Enter your username"
//                     required
//                   />
//                   <span className="input-icon">👤</span>
//                 </div>
//               </div>

//               <div className="form-group">
//                 <label htmlFor="password">Password</label>
//                 <div className="input-container">
//                   <input
//                     type={showPassword ? 'text' : 'password'}
//                     id="password"
//                     value={password}
//                     onChange={(e) => setPassword(e.target.value)}
//                     placeholder="••••••••"
//                     autoComplete="current-password"
//                     required
//                   />
//                   <button
//                     type="button"
//                     className="input-icon clickable"
//                     onClick={() => setShowPassword(!showPassword)}
//                   >
//                     {showPassword ? '👁️' : '👁️‍🗨️'}
//                   </button>
//                 </div>
//               </div>

//               <button
//                 type="submit"
//                 className="sign-in-button"
//                 disabled={loading} // Disable button while loading
//               >
//                 {loading ? 'Signing In...' : 'Sign In'}
//               </button>
//             </form>
//           </div>
//         </div>
//       </div>
//     </div>
//   );
// };

// export default Login;
import React, { useState } from 'react';
import { motion, AnimatePresence } from "framer-motion";
import { useNavigate } from 'react-router-dom';
import './Login.css';
import * as assets from '../assets/assets';
import FRONTEND_ROUTES from '../frontend_urls';

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
      setTimeout(() => setShowSuccess(false), 3000);
    } catch (err) {
      setError(err?.response?.data?.detail || 'Invalid credentials. Please try again.');
      setUsername('');
    setPassword('');
    setShowPassword(false);
    } finally {
      setLoading(false);
    }
  };

  const handleForgotPassword = () => {
    navigate(FRONTEND_ROUTES.requestOTP);
  };

  return (
    <div className="login-page">
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
                    <i className="fas fa-user"></i>
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
                    className="input-icon clickable"
                    onClick={() => setShowPassword(!showPassword)}
                    aria-label={showPassword ? 'Hide password' : 'Show password'}
                  >
                    {showPassword ? <i className="fas fa-eye-slash"></i> : <i className="fas fa-eye"></i>}
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