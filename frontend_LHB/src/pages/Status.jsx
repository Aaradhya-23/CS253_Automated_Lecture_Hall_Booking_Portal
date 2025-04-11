import React, { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion"; // Import Framer Motion
import { Check, Clock, X, AlertCircle } from "lucide-react";
import "./Status.css";
import api from "../api/api";

// Status icon component
const StatusIcon = ({ status }) => {
  const iconMap = {
    accepted: <Check className="st-status-icon st-approved" />,
    pending: <Clock className="st-status-icon st-pending" />,
    rejected: <X className="st-status-icon st-rejected" />,
    not_sent: <AlertCircle className="st-status-icon st-not-submitted" />,
  };

  return iconMap[status] || null;
};

// Helper function to format status text
const formatStatusText = (status) => {
  const statusMap = {
    not_sent: "Not Sent",
    pending: "Pending",
    accepted: "Accepted",
    approved: "Accepted",
    rejected: "Rejected",
  };
  return statusMap[status] || status;
};

function Status() {
  const [bookingData, setBookingData] = useState(null);
  const [loading, setLoading] = useState(true);

  const convertTo12HourFormat = (time) => {
    const [hours, minutes] = time.split(":").map(Number);
    const period = hours >= 12 ? "PM" : "AM";
    const hour12 = hours % 12 || 12;
    return `${hour12}:${String(minutes).padStart(2, "0")} ${period}`;
  };

  useEffect(() => {
    const fetchBookings = async () => {
      const token = localStorage.getItem("ACCESS_TOKEN");
      const username = localStorage.getItem("USERNAME");
      if (!token) {
        console.error("No ACCESS_TOKEN found in localStorage.");
        setLoading(false);
        return;
      }
      try {
        const url = import.meta.env.VITE_HISTORY_URL;
        const response = await api.get(url, {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        });

        const bookings = response.data
          .map((booking) => ({
            id: booking.id,
            title: booking.title,
            room: booking.room_details.name,
            date: booking.booking_date,
            time: `${convertTo12HourFormat(booking.start_time)} - ${convertTo12HourFormat(
              booking.end_time
            )}`,
            duration: `${booking.duration} hour`,
            type: booking.Type,
            createdBy: booking.creator.username,
            overallStatus: booking.status,
            approvals_pending: booking.approvals_pending,
          }))
          .reverse();
        console.log(bookings);  
        setBookingData(bookings);
      } catch (err) {
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchBookings();
  }, []);

  const getStatusColor = (status) => {
    const colorMap = {
      not_sent: "#6c757d", // grey
      pending: "#ffc107", // yellow
      accepted: "#28a745", // green
      rejected: "#dc3545", // red
    };
    return colorMap[status] || "#6c757d";
  };

  const transformApprovalStatus = (accepted, boolPendingCovered, overallStatus) => {
    console.log(accepted, boolPendingCovered, overallStatus);
    if (accepted) {
      return "accepted";
    }
    if (overallStatus === "rejected") {
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

  return (
    <motion.div
      className="st-booking-details-container"
      initial={{ opacity: 0, y: 20 }} // Page load animation
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: 20 }}
      transition={{ duration: 0.6 }}
    >
      {loading ? (
        <motion.div
          className="st-loading-message"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.4 }}
        >
          Loading...
        </motion.div>
      ) : !bookingData || bookingData.length === 0 ? (
        <motion.div
          className="st-no-data-message"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.4 }}
        >
          <h2>No active pending requests</h2>
          <p>Please request some bookings to view their status.</p>
        </motion.div>
      ) : (
        <AnimatePresence>
          {bookingData.map((booking, index) => (
            <motion.div
              key={booking.id}
              className="st-booking-card"
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: 10 }}
              transition={{ duration: 0.4, delay: index * 0.1 }} // Staggered animation
            >
              <div className="st-booking-header">
                <h1 className="st-booking-title">{booking.title}</h1>
                <div className="st-booking-status-badge">
                  {formatStatusText(booking.overallStatus)}
                </div>
              </div>

              <div className="st-booking-details-grid">
                <motion.div
                  className="st-booking-detail-card"
                  initial={{ opacity: 0, scale: 0.95 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ duration: 0.4 }}
                >
                  <h2 className="st-card-title">Booking Information</h2>
                  <div className="st-detail-grid">
                    <div className="st-detail-item">
                      <span className="st-detail-label">Booking ID</span>
                      <span className="st-detail-value">{booking.id}</span>
                    </div>
                    <div className="st-detail-item">
                      <span className="st-detail-label">Room</span>
                      <span className="st-detail-value">{booking.room}</span>
                    </div>
                    <div className="st-detail-item">
                      <span className="st-detail-label">Date</span>
                      <span className="st-detail-value">{booking.date}</span>
                    </div>
                    <div className="st-detail-item">
                      <span className="st-detail-label">Time</span>
                      <span className="st-detail-value">{booking.time}</span>
                    </div>
                    <div className="st-detail-item">
                      <span className="st-detail-label">Duration</span>
                      <span className="st-detail-value">{booking.duration}</span>
                    </div>
                  </div>
                </motion.div>

                <motion.div
                  className="st-approval-workflow-card"
                  initial={{ opacity: 0, scale: 0.95 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ duration: 0.4 }}
                >
                  <h2 className="st-card-title">Approval Workflow</h2>
                  <div className="st-authorities-list">
                    {(() => {
                      let boolPendingCovered = false;
                      return Object.entries(booking.approvals_pending).map(
                        ([authority, boolValue]) => {
                          const status = transformApprovalStatus(
                            boolValue,
                            boolPendingCovered,
                            booking.overallStatus
                          );
                          if (boolValue === false && !boolPendingCovered) {
                            boolPendingCovered = true;
                          }

                          return (
                            <motion.div
                              key={authority}
                              className="st-authority-item"
                              initial={{ opacity: 0, x: -10 }}
                              animate={{ opacity: 1, x: 0 }}
                              exit={{ opacity: 0, x: -10 }}
                              transition={{ duration: 0.3 }}
                            >
                              <div className="st-authority-info">
                                <StatusIcon status={status} />
                                <div className="st-authority-details">
                                  <span className="st-authority-name">
                                    {authority}
                                  </span>
                                  <span className="st-authority-role">
                                    Approving Authority
                                  </span>
                                </div>
                              </div>
                              <div className="st-authority-status">
                                <span
                                  className={`st-status-text st-${status}`}
                                  style={{ color: getStatusColor(status) }}
                                >
                                  {formatStatusText(status)}
                                </span>
                              </div>
                            </motion.div>
                          );
                        }
                      );
                    })()}
                  </div>
                </motion.div>
              </div>
            </motion.div>
          ))}
        </AnimatePresence>
      )}
    </motion.div>
  );
}

export default Status;