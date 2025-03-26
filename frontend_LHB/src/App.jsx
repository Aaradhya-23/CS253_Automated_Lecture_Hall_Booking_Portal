import axios from 'axios';
import React, { useState, useEffect } from "react";
import {
  Route,
  Routes,
  useLocation,
  useNavigate,
  Navigate,
  Link,
} from "react-router-dom";
import Login from "./pages/Login";
import CreateUser from "./pages/CreateUser";
import LiveSchedule from "./pages/LiveSchedule";
import Feedback from "./pages/Feedback";
import Request_Booking from "./pages/Request_Booking";
import Help from "./pages/Help";
import Status from "./pages/Status";
import UserHistory from "./pages/UserHistory";
import Adminviewbooking from "./pages/Adminviewbooking";

// Import navbar components
import UserNavbar from "./components/UserNavbar";
import AdminNavbar from "./components/AdminNavbar";
import Header from "./components/Header";
import FRONTEND_ROUTES from './frontend_urls';
import ProtectedRoute from "./api/protected_route";
import api from "./api/api";
import { ACCESS_TOKEN, REFRESH_TOKEN } from "./api/constants";


const App = () => {
  const [userRole, setUserRole] = useState("");
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const location = useLocation();
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem(ACCESS_TOKEN);
    if (token) {
      setIsLoggedIn(true);
      const role = localStorage.getItem('ROLE');
      if (role) {
        setUserRole(role);
      }
    }
  }, []);

  // Show navbar only if logged in and not on login or register pages
  const showNavbar =
    isLoggedIn &&
    location.pathname !== FRONTEND_ROUTES.login &&
    location.pathname !== FRONTEND_ROUTES.register;

  // Function to handle login using the backend API endpoint
  const handleLogin = async (username, password) => {
    try {
      console.log('Attempting login...');
      console.log(import.meta.env.VITE_API_URL); // Should print "http://127.0.0.1:8000/"
      console.log(import.meta.env.VITE_LOGIN_URL); // Should print "auth/login/"

      const response = await axios.post(
        `${import.meta.env.VITE_API_URL}${import.meta.env.VITE_LOGIN_URL}`,
        {
          username,
          password,
        });
  
      const { access, refresh, role } = response.data;
      console.log('Login successful:', role);
      console.log('Access Token:', access)
      console.log('Refresh Token:', refresh)
  
      localStorage.setItem('ACCESS_TOKEN', access);
      localStorage.setItem('REFRESH_TOKEN', refresh);
      localStorage.setItem('ROLE', role);
      setUserRole(role);
      setIsLoggedIn(true);
      navigate(FRONTEND_ROUTES.home)
    } catch (error) {
      console.error('Login failed:', error.response?.data?.detail || error.message);
      throw error; // Throw error to handle it in the Login component
    }
  };
  

  // Function to handle registration via the backend API
  const handleRegister = async (email, password) => {
    try {
      await api.post(import.meta.env.VITE_REGISTER_URL, { email, password });
      navigate(FRONTEND_ROUTES.login);
    } catch (error) {
      console.error("Registration failed", error);
    }
  };

  // Function for navigation (for navbars, etc.)
  const handleNavigation = (path) => {
    navigate(path);
  };

  const handleLogout = () => {
    localStorage.clear(); // Clear local storage
    setIsLoggedIn(false); // Update state to reflect logged-out status
    setUserRole(""); // Clear the user role
    navigate(FRONTEND_ROUTES.home); // Navigate to the home page
  };

  return (
    <div className="flex flex-col min-h-screen">
      <Header
        isLoggedIn={isLoggedIn}
        userRole={userRole}
        handleLogout={handleLogout}
      />


      <div className="flex flex-grow">
        {showNavbar &&
          (userRole === "admin" ? (
            <AdminNavbar
              onNavigate={handleNavigation}
              currentPath={location.pathname}
            />
          ) : (
            <UserNavbar
              onNavigate={handleNavigation}
              currentPath={location.pathname}
            />
          ))}
        <div className={`flex-grow ${showNavbar ? "p-4 bg-gray-50" : ""}`}>
          <Routes>
            {/* When at the root, redirect to the home/timetable page */}
            <Route path={FRONTEND_ROUTES.home} element={<LiveSchedule />} />

            {/* Public route for login */}
            <Route
              path={FRONTEND_ROUTES.login}
              element={
                isLoggedIn ? (
                  <Navigate to={FRONTEND_ROUTES.home} />
                ) : (
                  <Login onLogin={handleLogin} />
                )
              }
            />

            {/* Protected route for registration (admin only) */}
            <Route
              path={FRONTEND_ROUTES.register}
              element={
                <ProtectedRoute role="admin">
                  <CreateUser onRegister={handleRegister} />
                </ProtectedRoute>
              }
            />

            {/* Public routes */}
            <Route path={FRONTEND_ROUTES.feedback} element={<Feedback />} />
            <Route path={FRONTEND_ROUTES.home} element={<LiveSchedule />} />

            {/* Protected routes for regular users */}
            <Route
              path={FRONTEND_ROUTES.history}
              element={
                <ProtectedRoute role="user">
                  <UserHistory />
                </ProtectedRoute>
              }
            />
            <Route
              path={FRONTEND_ROUTES.requestBooking}
              element={
                <ProtectedRoute role="user">
                  <Request_Booking />
                </ProtectedRoute>
              }
            />
            <Route
              path={FRONTEND_ROUTES.help}
              element={
                <ProtectedRoute role="user">
                  <Help />
                </ProtectedRoute>
              }
            />
            <Route
              path={FRONTEND_ROUTES.status}
              element={
                <ProtectedRoute role="user">
                  <Status />
                </ProtectedRoute>
              }
            />

            {/* Protected route for admin users */}
            <Route
              path={FRONTEND_ROUTES.adminViewBooking}
              element={
                <ProtectedRoute role="admin">
                  <Adminviewbooking />
                </ProtectedRoute>
              }
            />
          </Routes>
        </div>
      </div>
    </div>
  );
};

export default App;
