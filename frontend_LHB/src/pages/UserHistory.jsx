import React, { useState, useEffect } from "react";
import { Check, Clock, X, AlertCircle, Pen } from "lucide-react"; // Import icons
import "./UserHistory.css";
import api from "../api/api";
import { motion, AnimatePresence } from "framer-motion"; // Import Framer Motion
import { useNavigate } from "react-router-dom";

// Reusable StatusIcon Component
const StatusIcon = ({ status }) => {
  const iconMap = {
    Approved: <Check className="user-status-icon user-approved" />,
    approved: <Check className="user-status-icon user-approved" />,
    Pending: <Clock className="user-status-icon user-pending" />,
    pending: <Clock className="user-status-icon user-pending" />,
    Rejected: <X className="user-status-icon user-rejected" />,
    rejected: <X className="user-status-icon user-rejected" />,
    not_sent: <AlertCircle className="user-status-icon user-not-sent" />,
  };

  return iconMap[status] || null;
};

// Helper Functions
const getStatusColor = (status) => {
  const colorMap = {
    Approved: "#28a745", // Green
    approved: "#28a745", // Green
    Pending: "#ffc107", // Yellow
    pending: "#ffc107", // Yellow
    Rejected: "#dc3545", // Red
    rejected: "#dc3545", // Red
    not_sent: "#6c757d", // Grey
  };
  return colorMap[status] || "#6c757d";
};

const formatStatusText = (status) => {
  const statusMap = {
    approved: "Approved",
    pending: "Pending",
    rejected: "Rejected",
    not_sent: "Not Sent",
  };
  return statusMap[status] || status;
};

const convertTo12HourFormat = (time) => {
  const [hours, minutes] = time.split(":").map(Number);
  const period = hours >= 12 ? "PM" : "AM";
  const hour12 = hours % 12 || 12;
  return `${hour12}:${String(minutes).padStart(2, "0")} ${period}`;
};

const transformBookings = (fetchedBookings) => {
  return fetchedBookings.map((booking) => ({
    id: booking.id,
    date: booking.booking_date, // Added for filtering
    time: `${convertTo12HourFormat(booking.start_time)}–${convertTo12HourFormat(
      booking.end_time
    )}`,
    duration: `(${booking.duration}h)`,
    room: booking.room_details.name,
    professor: booking.creator.username,
    purpose: booking.title,
    status: booking.status,
    cost: booking.cost,
  }));
};

function UserHistory() {
  const [bookings, setBookings] = useState([]);
  const [filteredBookings, setFilteredBookings] = useState([]); // New state for filtered bookings
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [dateRange, setDateRange] = useState({
    start: new Date(new Date().setMonth(new Date().getMonth() - 1)).toISOString().split("T")[0],
    end: new Date(new Date().setMonth(new Date().getMonth() + 1)).toISOString().split("T")[0],
  });
  const [editingDate, setEditingDate] = useState(null);
  const [searchQuery, setSearchQuery] = useState("");
  const [filterUsername, setFilterUsername] = useState(""); // **Changed**: Added state for username filter
  const [filterLectureHall, setFilterLectureHall] = useState(""); // **Changed**: Added state for lecture hall filter
  const [openDropdownId, setOpenDropdownId] = useState(null);

  const navigate = useNavigate();

  useEffect(() => {
    const fetchBookings = async () => {
      setLoading(true);
      setError(null);

      const token = localStorage.getItem("ACCESS_TOKEN");
      const username = localStorage.getItem("USERNAME");
      if (!token) {
        console.error("No ACCESS_TOKEN found in localStorage.");
        setError("User not authenticated. Please log in.");
        setLoading(false);
        return;
      }

      try {
        const response = await api.get(`${import.meta.env.VITE_HISTORY_URL}`, {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
        });

        console.log("Fetched Bookings:", response.data);

        const transformedData = transformBookings(response.data);
        setBookings(transformedData);
      } catch (err) {
        console.error(
          "Error fetching bookings:",
          err.response?.data || err.message
        );
        setError("Failed to load bookings.");
      } finally {
        setLoading(false);
      }
    };

    fetchBookings();
  }, []);

  // **Date Range Filtering**
  // filtering the booking based on date
  useEffect(() => {
    const startDate = new Date(dateRange.start);
    const endDate = new Date(dateRange.end);

    const filtered = bookings.filter((booking) => {
      const bookingDate = new Date(booking.date);
      const matchesDate = bookingDate >= startDate && bookingDate <= endDate;
      const matchesSearchQuery =
        booking.professor.toLowerCase().includes(searchQuery.toLowerCase()) ||
        booking.purpose.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesUsernameFilter = booking.professor
        .toLowerCase()
        .includes(filterUsername.toLowerCase()); // **Changed**: Added username filter
      const matchesLectureHallFilter = booking.room
        .toLowerCase()
        .includes(filterLectureHall.toLowerCase()); // **Changed**: Added lecture hall filter

      return (
        matchesDate &&
        matchesSearchQuery &&
        matchesUsernameFilter &&
        matchesLectureHallFilter
      );
    });

    setFilteredBookings(filtered);
  }, [dateRange, bookings, searchQuery, filterUsername, filterLectureHall]); // **Changed**: Added `filterUsername` and `filterLectureHall` dependencies

  // changing start-end date date based on date picker
  const handleDateChange = (event, type) => {
    setDateRange((prev) => ({
      ...prev,
      [type]: event.target.value,
    }));
    setEditingDate(null);
  };

  const toggleDropdown = (id) => {
    setOpenDropdownId(openDropdownId === id ? null : id);
  };

  const handleSearch = (e) => {
    setSearchQuery(e.target.value);
  };

  const handleViewDetails = (id) => {
    console.log(`View/edit details for booking ${id}`);
    navigate(`/booking/${id}`);
    setOpenDropdownId(null);
  };

  const handleRemoveBooking = async (id) => {
    console.log(`Removing booking with ID: ${id}`);
    const token = localStorage.getItem("ACCESS_TOKEN");
    try {
      await api.post(
        `${
          import.meta.env.VITE_API_BASE_URL
        }bookings/send-rejected-mail/${id}/`,
        { remark: "Your booking was removed by admin" }, // Fixed remark
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        }
      );

      console.log(`Rejection email sent for booking ${id}.`);
      alert("Booking removed, email sent to user.");

      // Close dropdown after successful removal
      setOpenDropdownId(null);
    } catch (error) {
      console.error("Error removing booking:", error);
      alert("Error removing booking. Please try again.");
    }
  };
  const handleGeneratebill = async (id) => {
    console.log(`Generating bill for booking ${id}`);
    //navigate(`http://127.0.0.1:8000/reports/download/bill/${id}/`);
    setLoading(true);
    setError(null);

    const token = localStorage.getItem("ACCESS_TOKEN");

    if (!token) {
      console.error("No ACCESS_TOKEN found in localStorage.");
      setError("User not authenticated. Please log in.");
      setLoading(false);
      return;
    }

    try {
      const response = await api.get(
        `${import.meta.env.VITE_API_BASE_URL}reports/download/bill/${id}/`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          responseType: "blob",
        }
      );

      const blob = new Blob([response.data], { type: "application/pdf" });
      const link = document.createElement("a");
      link.href = URL.createObjectURL(blob);
      link.download = `bill_${id}.pdf`; // You can customize the file name
      link.click(); // Trigger the download
    } catch (err) {
      console.error("Error generate bill:", err.response?.data || err.message);
      setError("Failed to load bookings.");
    } finally {
      setLoading(false);
    }
    setOpenDropdownId(null);
  };

  React.useEffect(() => {
    const handleClickOutside = (event) => {
      if (openDropdownId && !event.target.closest(".admin-booking-actions")) {
        setOpenDropdownId(null);
      }
    };

    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [openDropdownId]);

  return (
    <motion.div
      className="user-booking-main"
      initial={{ opacity: 0, y: 20 }} // Page load animation
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: 20 }}
      transition={{ duration: 0.6 }}
    >
      <div className="user-date-range-section">
        <div
          className="user-date-selector"
          onClick={() => setEditingDate("start")}
        >
          {editingDate === "start" ? (
            <input
              type="date"
              value={dateRange.start}
              onChange={(e) => handleDateChange(e, "start")}
              onBlur={() => setEditingDate(null)}
              autoFocus
            />
          ) : (
            <span>{new Date(dateRange.start).toDateString()}</span>
          )}
          <span className="user-dropdown-arrow">▼</span>
        </div>
        <span className="user-date-separator">-</span>
        <div
          className="user-date-selector"
          onClick={() => setEditingDate("end")}
        >
          {editingDate === "end" ? (
            <input
              type="date"
              value={dateRange.end}
              onChange={(e) => handleDateChange(e, "end")}
              onBlur={() => setEditingDate(null)}
              autoFocus
            />
          ) : (
            <span>{new Date(dateRange.end).toDateString()}</span>
          )}
          <span className="user-dropdown-arrow">▼</span>
        </div>
      </div>
      <div className="user-filter-section">
        <div className="user-filter-row">
          <span className="user-filter-column">
            <span className="user-filter-label">Lecture Hall</span>
            <input
              type="text"
              placeholder="Filter by lecture hall"
              className="user-search-input"
              value={filterLectureHall}
              onChange={(e) => setFilterLectureHall(e.target.value)}
            />
          </span>
          <span className="user-filter-column">
            <span className="user-filter-label">Search by keyword...</span>
            <input
              type="text"
              placeholder="Search..."
              className="user-search-input"
              value={searchQuery}
              onChange={handleSearch}
            />
          </span>
        </div>
      </div>
      <div className="user-bookings-list">
        <h2 className="user-date-header">
          Booking History
        </h2>
        <div className="user-booking-item highlighted">
          <div className="user-time-indicator">
            {/* <div className="user-blue-dot"></div> */}
            <div className="user-time-text">
              <span>Time</span>
              <span className="user-duration">Duration</span>
            </div>
          </div>
          <div className="user-booking-info">
            <div className="user-room-info">Date</div>
            <div className="user-room-info">Hall</div>
            <div className="user-course-info">Purpose</div>
            <div className="user-professor-info">Status</div>
            <div className="user-professor-info">Amount</div>
          </div>
          <div className="user-booking-actions">
            <div className="user-professor-info">Actions</div>
          </div>
        </div>
        {loading ? (
          <motion.div
            className="user-loading-message"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.4 }}
          >
            Loading...
          </motion.div>
        ) : filteredBookings.length === 0 ? (
          <motion.div
            className="user-no-data-message"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.4 }}
          >
            <h2>No bookings found</h2>
            <p>Please try adjusting your filters.</p>
          </motion.div>
        ) : (
          <AnimatePresence>
            {filteredBookings.map((booking, index) => (
              <motion.div
                key={booking.id}
                className="user-booking-item"
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: 10 }}
                transition={{ duration: 0.4, delay: index * 0.1 }} // Staggered animation
              >
                <div className="user-time-indicator">
                  <div className="user-blue-dot"></div>
                  <div className="user-time-text">
                    <span>{booking.time}</span>
                    <span className="user-duration">{booking.duration}</span>
                  </div>
                </div>
                <div className="user-booking-info">
                  <div className="user-room-info">{booking.date}</div>
                  <div className="user-room-info">{booking.room}</div>
                  <div className="user-course-info">{booking.purpose}</div>
                  <div className="user-professor-info">
                    {/* Status Field with Icon and Color */}
                    <div className="user-status-field">
                      <StatusIcon status={booking.status} />
                      <span
                        className="user-status-text"
                        style={{ color: getStatusColor(booking.status) }}
                      >
                        {formatStatusText(booking.status)}
                      </span>
                    </div>
                  </div>
                  <div className="user-professor-info">{booking.cost}</div>
                </div>
                <div className="user-booking-actions">
                  <button
                    onClick={() => handleGeneratebill(booking.id)}
                    className={`user-dropdown-item ${
                      booking.status !== "Approved" && booking.status!=="approved" ? "disabled" : ""
                    }`}
                    disabled={booking.status !== "Approved" && booking.status!=="approved"} // Explicitly disable the button
                  >
                    <span className="user-icon user-download">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="2"
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      >
                        <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4" />
                        <polyline points="7 10 12 15 17 10" />
                        <line x1="12" y1="15" x2="12" y2="3" />
                      </svg>
                    </span>
                    Download Bill
                  </button>
                </div>
              </motion.div>
            ))}
          </AnimatePresence>
        )}
      </div>
    </motion.div>
  );
}
export default UserHistory;
