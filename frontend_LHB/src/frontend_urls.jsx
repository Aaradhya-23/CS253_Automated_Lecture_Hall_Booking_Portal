import ForgotPassword from "./pages/ForgotPassword";

const FRONTEND_ROUTES = {
    home: "/", // This is your landing page (timetable or available rooms)
    login: "/login",
    register: "/register",
    feedback: "/feedback",
    history: "/history",
    requestBooking: "/request-booking",
    help: "/help",
    status: "/status",
    ForgotPassword: "/forgot-password",
    adminViewBooking: "/admin-view-booking",
    viewPending: "/admin-view-pending",
    roomDetails: "/room-details",
    bookingDetails: "/booking/:id",
    userhelp: "/help-user",
    adminhelp: "/help-admin",
    adminfeedbackview: "/view_feedback",
  };

export default FRONTEND_ROUTES