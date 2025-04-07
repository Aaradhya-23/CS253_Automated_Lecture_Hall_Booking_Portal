import React, { useState, useEffect } from 'react';
import './Viewpending.css';
import api from '../api/api';
import { toast } from 'react-toastify';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { ACCESS_TOKEN } from '../api/constants';
import { AnimatePresence, motion } from "framer-motion";
// Import Lucide icons instead of FontAwesome for consistency with Status component
import { Check, Clock, X, AlertCircle } from "lucide-react";

// Status icon component from Status.jsx
const StatusIcon = ({ status }) => {
  const iconMap = {
    accepted: <Check className="vp-status-icon vp-approved" />,
    pending: <Clock className="vp-status-icon vp-pending" />,
    rejected: <X className="vp-status-icon vp-rejected" />,
    not_sent: <AlertCircle className="vp-status-icon vp-not-submitted" />,
  };

  return iconMap[status] || null;
};

// Helper function to format status text
const formatStatusText = (status) => {
  const statusMap = {
    not_sent: "Not Sent  ",
    pending: "Pending  ",
    accepted: "Accepted  ",
    rejected: "Rejected  ",
  };
  return statusMap[status] || status;
};

const Viewpending = () => {
    const [pendingBookings, setPendingBookings] = useState([]);
    const [rejectionRemarksVisible, setRejectionRemarksVisible] = useState({});
    const [rejectionRemarksContent, setRejectionRemarksContent] = useState({});
    const token = localStorage.getItem(ACCESS_TOKEN);
    
    const transformBookings = (bookings) => {
        return bookings.map((booking) => ({
            id: booking.id,
            time: `${booking.start_time}-${booking.end_time}`,
            duration: `(${booking.duration}h)`,
            room: booking.room_details.name,
            user: booking.creator.username,
            course: booking.title,
            date: booking.booking_date,
            requestedDay: new Date(booking.requested_on).toLocaleDateString("en-US", { weekday: "long" }),
            requestedDate: new Date(booking.requested_on).toLocaleDateString("en-US"),
            requestedTime: booking.requested_on.split("T")[1].split("+")[0],
            authorities: booking.approvals_pending || {}, // ADDED: Authority status
            overallStatus: booking.status || "pending",
        }));
    };
    
    // Logic from Status.jsx for transforming approval status
    const transformApprovalStatus = (accepted, boolPendingCovered, overallStatus) => {
        if (accepted) {
            return "accepted";
        }
        if (overallStatus === "cancelled") {
            if (!boolPendingCovered) {
                return "rejected";
            }
            return "not_sent";
        }
        if (overallStatus === "accepted") {
            return "accepted";
        }
        if (!boolPendingCovered) {
            return "pending";
        }
        return "not_sent";
    };
    
    // Color mapping for different statuses
    const getStatusColor = (status) => {
        const colorMap = {
            not_sent: "#6c757d", // grey
            pending: "#ffc107", // yellow
            accepted: "#28a745", // green
            rejected: "#dc3545", // red
        };
        return colorMap[status] || "#6c757d";
    };
    
    useEffect(() => {
        const requestBooking = async () => {
            try {
                const response = await api.get(
                    `${import.meta.env.VITE_BOOKING_SEARCH_URL}?status=pending`,
                    {
                        headers: {
                            Authorization: `Bearer ${token}`,
                            "Content-Type": "application/json",
                            Accept: "application/json",
                        },
                    }
                );
                const transformedData = transformBookings(response.data);
                setPendingBookings(transformedData);
            } catch (error) {
                console.error("Error fetching booking data:", error);
            }
        };
        
        if (token) {
            requestBooking();
        }
    }, [token]);
    
    const handleReject = (bookingId) => {
        setRejectionRemarksVisible(prev => ({
            ...prev,
            [bookingId]: true
        }));
    };
    
    const handleCancelRejection = (bookingId) => {
        setRejectionRemarksVisible(prev => ({
            ...prev,
            [bookingId]: false
        }));
        setRejectionRemarksContent(prev => ({
            ...prev,
            [bookingId]: ''
        }));
    };
    
    const handleSubmitRejection = async (bookingId) => {
        const remarks = rejectionRemarksContent[bookingId] || '';
        if (!(remarks ?? "").trim()) {
            toast.error("Please enter rejection remarks.");
            return;
        }
        
        try {
            await api.post(
                `${import.meta.env.VITE_API_BASE_URL}bookings/send-rejected-mail/${bookingId}/`,
                { remark: remarks },
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                        "Content-Type": "application/json",
                        Accept: "application/json",
                    },
                }
            );
            toast.success("Booking rejected, email sent.");
            
            setRejectionRemarksVisible(prev => ({
                ...prev,
                [bookingId]: false
            }));
            
            setRejectionRemarksContent(prev => ({
                ...prev,
                [bookingId]: ''
            }));
        } catch (error) {
            console.error("Error processing rejection:", error);
            alert("Error rejecting booking. Please try again.");
        }
    };

    return (
        <motion.div
            className="pending-bookings-main"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
        >
            <ToastContainer
                    position="top-right"
                    autoClose={5000}
                    hideProgressBar={false}
                    newestOnTop={false}
                    closeOnClick
                    rtl={false}
                    pauseOnFocusLoss
                    draggable
                    pauseOnHover
                    theme="colored"
                  />
            <h2>Pending Bookings</h2>
            
            <AnimatePresence>
                {pendingBookings.map((booking) => (
                    <motion.div
                        key={booking.id}
                        className="pending-booking-item"
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: 10 }}
                        transition={{ duration: 0.3 }}
                    >
                        <div className="pending-booking-content">
                            <div className="pending-booking-details">
                                <div className="pending-booking-course">{booking.course}</div>
                                <div className="pending-booking-grid">
                                    <div className="pending-booking-header">User</div>
                                    <div className="pending-booking-header">Room</div>
                                    <div className="pending-booking-header">Date of booking</div>
                                    <div className="pending-booking-header">Time</div>
                                    
                                    <div className="pending-booking-value">{booking.user}</div>
                                    <div className="pending-booking-value">{booking.room}</div>
                                    <div className="pending-booking-value">{booking.date}</div>
                                    <div className="pending-booking-value">
                                        {booking.time} {booking.duration}
                                    </div>
                                </div>
                                <div className="pending-booking-requested">
                                    Requested on: {booking.requestedDay}, {booking.requestedDate} at {booking.requestedTime}
                                </div>
                                
                                {/* Updated Authority Status Row with Status.jsx logic */}
                                <div className="authority-status-row">
                                    {booking.authorities && Object.entries(booking.authorities).map(([authority, boolValue], index) => {
                                        let boolPendingCovered = false;
                                        Object.entries(booking.authorities).slice(0, index).forEach(([, prevValue]) => {
                                            if (prevValue === false && !boolPendingCovered) {
                                                boolPendingCovered = true;
                                            }
                                        });
                                        
                                        const status = transformApprovalStatus(
                                            boolValue, 
                                            boolPendingCovered,
                                            booking.overallStatus
                                        );
                                        
                                        return (
                                            <div key={authority} className="authority-status-item">
                                                <span className="authority-name">{authority}</span>
                                                <div className="authority-status">
                                                    
                                                    <span 
                                                        className={`vp-status-text vp-${status}`}
                                                        style={{ color: getStatusColor(status) }}
                                                    >
                                                        {formatStatusText(status)}
                                                    </span>
                                                    <StatusIcon status={status} />
                                                </div>
                                            </div>
                                        );
                                    })}
                                </div>
                            </div>
                            <div className="pending-booking-actions">
                                <motion.button
                                    onClick={() => handleReject(booking.id)}
                                    className="pending-action-btn pending-reject-btn"
                                    whileTap={{ scale: 0.95 }}
                                >
                                    Reject Booking
                                </motion.button>
                            </div>
                        </div>
                        
                        <AnimatePresence>
                            {rejectionRemarksVisible[booking.id] && (
                                <motion.div
                                    className="pending-rejection-section"
                                    initial={{ opacity: 0, scale: 0.9 }}
                                    animate={{ opacity: 1, scale: 1 }}
                                    exit={{ opacity: 0, scale: 0.9 }}
                                    transition={{ duration: 0.3 }}
                                >
                                    <input
                                        type="text"
                                        placeholder="Enter rejection remarks"
                                        className="pending-rejection-input"
                                        value={rejectionRemarksContent[booking.id] || ""}
                                        onChange={(e) =>
                                            setRejectionRemarksContent((prev) => ({
                                                ...prev,
                                                [booking.id]: e.target.value,
                                            }))
                                        }
                                    />
                                    <div className="pending-rejection-buttons">
                                        <motion.button
                                            onClick={() => handleSubmitRejection(booking.id)}
                                            className="pending-rejection-submit"
                                            whileHover={{ scale: 1.05 }}
                                            whileTap={{ scale: 0.95 }}
                                        >
                                            Submit Remarks
                                        </motion.button>
                                        <motion.button
                                            onClick={() => handleCancelRejection(booking.id)}
                                            className="pending-rejection-cancel"
                                            whileHover={{ scale: 1.05 }}
                                            whileTap={{ scale: 0.95 }}
                                        >
                                            Cancel
                                        </motion.button>
                                    </div>
                                </motion.div>
                            )}
                        </AnimatePresence>
                    </motion.div>
                ))}
            </AnimatePresence>
        </motion.div>
    );
};

export default Viewpending;
