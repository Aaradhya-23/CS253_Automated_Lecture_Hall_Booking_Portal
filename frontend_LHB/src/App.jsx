import React, { useState, useEffect } from "react";
import {
  Route,
  Routes,
  useLocation,
  useNavigate,
  Navigate,
  Link,
} from "react-router-dom";
import Login from "./pages/login";
import CreateUser from "./pages/CreateUser";
import LiveSchedule from "./pages/LiveSchedule";
import Feedback from "./pages/Feedback";
import Request_Booking from "./pages/request_booking";
import AdminHelp from "./pages/AdminHelp"
import UserHelp from "./pages/UserHelp"
import Status from "./pages/Status";
import ForgotPassword from "./pages/ForgotPassword";
import UserHistory from "./pages/UserHistory"
import Adminviewbooking from "./pages/Adminviewbooking";
import Viewpending from "./pages/Viewpending";
import RoomDetails from "./pages/RoomDetails";
import Bookingdetails from "./pages/Bookingdetails";
import RequestOTP from "./pages/RequestOTP";
import AdminFeedbackview from "./pages/AdminFeedbackview";
// Import navbar components
import UserNavbar from "./components/UserNavbar";
import AdminNavbar from "./components/AdminNavbar";
import Header from "./components/Header";
import FRONTEND_ROUTES from './frontend_urls';
import ProtectedRoute from "./api/protected_route";
import api from "./api/api";
import { ACCESS_TOKEN, REFRESH_TOKEN } from "./api/constants";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css"; // Importing CSS for toast notifications
// import ForgotPassword from "./pages/ForgotPassword";


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
      api.defaults.headers['Authorization'] = `Bearer ${token}`;
      if (role) {
        setUserRole(role);
      }
    }
  }, []);

  // Show navbar only if logged in and not on login or register pages
  const showNavbar =
    isLoggedIn &&
    location.pathname !== FRONTEND_ROUTES.login;

  // Function to handle login using the backend API endpoint
  const handleLogin = async (username, password) => {
    try {
      console.log('Attempting login...');
      console.log(import.meta.env.VITE_API_URL); // Should print "http://127.0.0.1:8000/"
      console.log(import.meta.env.VITE_LOGIN_URL); // Should print "auth/login/"

      const response = await api.post(
        import.meta.env.VITE_LOGIN_URL,
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
      localStorage.setItem('USERNAME', username);
      setUserRole(role);
      setIsLoggedIn(true);
      toast.success("Login successful!",{
        position: "top-right",
        autoClose: 2000,
      });
      navigate(FRONTEND_ROUTES.home, {
        state: { showLoginToast: true }
      });
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

  // const handleForgotPassword = () => {
  //   navigate(FRONTEND_ROUTES.ForgotPassword); // Navigate to the forgot password page
  // }

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
            <Route path="/forgot-password" element={<ForgotPassword />} />
            <Route path="/request-otp" element={<RequestOTP />} />
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

            {/* Protected routes for regular users */}
            <Route
              path={FRONTEND_ROUTES.history}
              element={
                <ProtectedRoute role={["student", "Student", "faculty", "admin"]}>
                  <UserHistory />
                </ProtectedRoute>
              }
            />
            <Route
              path={FRONTEND_ROUTES.requestBooking}
              element={
                <ProtectedRoute role={["student", "Student", "faculty", "admin"]}>
                  <Request_Booking />
                </ProtectedRoute>
              }
            />
            <Route
              path={FRONTEND_ROUTES.status}
              element={
                <ProtectedRoute role={["student", "Student", "faculty"]}>
                  <Status />
                </ProtectedRoute>
              }
            />

            <Route
              path={FRONTEND_ROUTES.history}
              element={
                <ProtectedRoute role={["student", "Student", "faculty"]}>
                  <UserHistory />
                </ProtectedRoute>
              }
            />
            <Route path={FRONTEND_ROUTES.adminViewBooking}
             element={
              <ProtectedRoute role="admin">
                <Adminviewbooking />
              </ProtectedRoute>
            }
            />
            <Route path={FRONTEND_ROUTES.adminfeedbackview}
             element={
              <ProtectedRoute role="admin">
                <AdminFeedbackview />
              </ProtectedRoute>
            }
            />
            <Route path={FRONTEND_ROUTES.viewPending} element={
              <ProtectedRoute role="admin">
                <Viewpending />
              </ProtectedRoute>
            }
            />
            <Route path={FRONTEND_ROUTES.roomDetails} element={
              <ProtectedRoute role={["student", "Student", "faculty", "admin"]}>
                <RoomDetails />
              </ProtectedRoute>
            }
            />
            
            {/* This route expects a booking ID parameter - ensure navigation uses the correct format: `/booking/${bookingId}` */}
            <Route path={FRONTEND_ROUTES.bookingDetails} element={
              <ProtectedRoute role={["student", "Student", "faculty", "admin"]}>
                <Bookingdetails />
              </ProtectedRoute>
            }
            />

            <Route path={FRONTEND_ROUTES.userhelp} element={
              <ProtectedRoute role={["student", "Student", "faculty"]}>
                <UserHelp />
              </ProtectedRoute>
            }
            />

            <Route path={FRONTEND_ROUTES.adminhelp} element={
              <ProtectedRoute role={["admin"]}>
                <AdminHelp />
              </ProtectedRoute>
            }
            />

          </Routes>
        </div>
        {/* <ToastContainer/> */}
      </div>
    </div>
  );
};

export default App;
