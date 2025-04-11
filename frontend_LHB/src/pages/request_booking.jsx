import React, { useState, useEffect } from "react";
import api from "../api/api";
import { ACCESS_TOKEN } from "../api/constants";
import "./Request_Booking.css";
import { motion, AnimatePresence } from "framer-motion";
const Request_Booking = () => {
  const role = localStorage.getItem("ROLE");
  const token = localStorage.getItem(ACCESS_TOKEN);
  const loggedInUsername = localStorage.getItem("USERNAME"); // Assuming the username is stored in localStorage
  console.log(role);
  const [showSuccess, setShowSuccess] = useState(false);
  const [showError, setShowError] = useState(false);
  const [roomOptions, setRoomOptions] = useState([]);
  const [filteredRoomOptions, setFilteredRoomOptions] = useState([]);
  const [capacityOptions, setCapacityOptions] = useState([]);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [purpose, setPurpose] = useState("");
  const [remark, setRemark] = useState("");
  const [startDate, setStartDate] = useState("");
  const [startTime, setStartTime] = useState("");
  const [endDate, setEndDate] = useState("");
  const [endTime, setEndTime] = useState("");
  const [repeatOption, setRepeatOption] = useState("Does Not Repeat");
  const [selectedHall, setSelectedHall] = useState("");
  const [capacity, setCapacity] = useState("");
  const [accessoryOptions, setAccessoryOptions] = useState([]);
  const [selectedAccessories, setSelectedAccessories] = useState([]);
  const [message, setMessage] = useState("")

  const [users, setUsers] = useState([]);
  const [selectedUser, setSelectedUser] = useState(
    role === "admin" ? "" : loggedInUsername
  ); // Default to logged-in user if not admin
  const VITE_USER_LIST_CREATE_URL = `${
    import.meta.env.VITE_API_BASE_URL
  }accounts/users/`;

  function convertTo24HourFormat(time12h) {
    const [time, modifier] = time12h.split(" "); // ["8:30", "AM"]
    let [hours, minutes] = time.split(":").map(Number);

    if (modifier === "PM" && hours !== 12) {
      hours += 12;
    }
    if (modifier === "AM" && hours === 12) {
      hours = 0;
    }

    const hoursStr = String(hours).padStart(2, "0");
    const minutesStr = String(minutes).padStart(2, "0");

    return `${hoursStr}:${minutesStr}:00`; // Add seconds
  }

  useEffect(() => {
    if (role === "admin") {
      const fetchUsers = async () => {
        try {
          const response = await api.get(VITE_USER_LIST_CREATE_URL, {
            headers: {
              Authorization: `Bearer ${token}`,
              "Content-Type": "application/json",
            },
          });

          console.log("API Response:", response.data); // Debugging step

          // Ensure the API response is an array before setting state
          if (Array.isArray(response.data)) {
            setUsers(response.data);
          } else {
            console.error("Unexpected API response format:", response.data);
            setUsers([]); // Prevent crash
          }
        } catch (error) {
          console.error("Error fetching users:", error);
          setUsers([]);
        }
      };

      fetchUsers();
    }
  }, [role, token]);

  // Time options for dropdowns
  const timeOptions = [
    "8:00 AM",
    "8:30 AM",
    "9:00 AM",
    "9:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "1:00 PM",
    "1:30 PM",
    "2:00 PM",
    "2:30 PM",
    "3:00 PM",
    "3:30 PM",
    "4:00 PM",
    "4:30 PM",
    "5:00 PM",
    "5:30 PM",
    "6:00 PM",
    "6:30 PM",
    "7:00 PM",
    "7:30 PM",
    "8:00 PM",
    "8:30 PM",
    "9:00 PM",
  ];

  // Repeat options
  // const repeatOptions = [
  //   'Does Not Repeat', 'Daily', 'Weekly', 'Monthly'
  // ];

  // fetch rooms from the database
  useEffect(() => {
    console.log("here");
    if (startDate == "" || startTime == "" || endTime == "") return;

    // console.log(startTime)

    const fetchRooms = async () => {
      console.log("100");
      if (!token) {
        console.log("here");
        console.error("No token found. User is not authenticated.");
        return;
      }
      console.log(token);
      try {
        const start = convertTo24HourFormat(startTime);
        const end = convertTo24HourFormat(endTime);
        console.log(start);
        const response = await api.post(
          import.meta.env.VITE_AVAILABLE_SLOTS_URL,
          {
            start_time: start,
            booking_date: startDate,
            end_time: end,
          },
          {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          }
        );
        console.log("here");
        console.log(response.data);
        const rooms = Array.isArray(response.data)
          ? response.data
          : response.data.rooms;
        setRoomOptions(rooms);
        setFilteredRoomOptions(rooms);
        console.log(rooms);
        // Continue with the rest of your code
        // try {
        // Extract unique capacities
        const uniqueCapacities = [];
        for (let i = 0; i < rooms.length; i++) {
          const capacity = rooms[i].capacity;
          if (!uniqueCapacities.includes(capacity)) {
            uniqueCapacities.push(capacity);
          }
        }
        setCapacityOptions(uniqueCapacities.sort((a, b) => a - b));

        // Extract all accessories
        const allAccessories = [];
        for (let i = 0; i < rooms.length; i++) {
          const accessories = rooms[i].accessories;
          for (const accessory in accessories) {
            if (accessories[accessory]) {
              allAccessories.push(accessory);
            }
          }
        }

        // Filter unique accessories
        const uniqueAccessories = [];
        for (let i = 0; i < allAccessories.length; i++) {
          const accessory = allAccessories[i];
          if (!uniqueAccessories.includes(accessory)) {
            uniqueAccessories.push(accessory);
          }
        }

        setAccessoryOptions(uniqueAccessories);
      } catch (error) {
        console.error("Error fetching rooms:", error);
      }
    };

    fetchRooms();
  }, [endTime, startDate, startTime, token]);

  // Filter room options based on selected capacity and accessories
  useEffect(() => {
    const filterRooms = () => {
      let filtered = roomOptions;

      // Filter by capacity
      if (capacity) {
        filtered = filtered.filter(
          (room) => room.capacity >= parseInt(capacity)
        );
      }

      // Filter by selected accessories
      if (selectedAccessories.length > 0) {
        filtered = filtered.filter((room) =>
          selectedAccessories.every((accessory) => room.accessories[accessory])
        );
      }

      setFilteredRoomOptions(filtered);
    };
    setSelectedHall("");
    filterRooms();
  }, [capacity, selectedAccessories, roomOptions]);

  // Calculate duration between start and end time
  const calculateDuration = () => {
    if (!startTime || !endTime) return "";

    // Parse the time strings into Date objects
    const parseTime = (time) => {
      const [hours, minutes, period] = time
        .match(/(\d+):(\d+)\s(AM|PM)/)
        .slice(1);
      let totalMinutes = (parseInt(hours) % 12) * 60 + parseInt(minutes); // Convert hours and minutes to total minutes
      if (period === "PM") totalMinutes += 12 * 60; // Add 12 hours for PM times
      return totalMinutes;
    };

    const startMinutes = parseTime(startTime);
    const endMinutes = parseTime(endTime);

    // Calculate the duration in minutes
    const duration = endMinutes - startMinutes;

    // Handle cases where endTime is earlier than startTime (e.g., overnight bookings)
    if (duration < 0) return "Invalid time range";

    return `${duration} minutes`;
  };

const [showConfirmation, setShowConfirmation] = useState(false);
const [tempBookingData, setTempBookingData] = useState(null);

const handleSubmitInit = async (e) => {
  e.preventDefault();
  
  // Prepare the booking data first
  const formatTime = (time) => {
    const [hour, minute, period] = time.match(/(\d+):(\d+)\s(AM|PM)/).slice(1);
    let hours = parseInt(hour);
    let minutes = parseInt(minute);

    if (period === "PM" && hours !== 12) hours += 12;
    if (period === "AM" && hours === 12) hours = 0;

    return `${hours.toString().padStart(2, "0")}:${minutes
      .toString()
      .padStart(2, "0")}:00`;
  };

  const formattedStartTime = formatTime(startTime);
  const formattedEndTime = formatTime(endTime);
  
  const bookingData = {
    user: selectedUser,
    title: purpose,
    booking_date: startDate,
    start_time: formattedStartTime,
    end_time: formattedEndTime,
    room: selectedHall,
    duration: Math.abs(
      new Date(`${startDate}T${formattedEndTime}`) - 
      new Date(`${startDate}T${formattedStartTime}`)
    ) / (1000 * 60 * 60),
    Type: "academic",
    remarks: remark,
    accessories: selectedAccessories.reduce((acc, accessory) => {
      acc[accessory] = true;
      return acc;
    }, {}),
  };

  // Store the prepared data and show confirmation
  setTempBookingData(bookingData);
  setShowConfirmation(true);
};

const handleConfirmSubmit = async () => {
  setShowConfirmation(false);
  setIsSubmitting(true);

  try {
    const token = localStorage.getItem(ACCESS_TOKEN);
    if (!token) {
      console.error("No token found. User is not authenticated.");
      return;
    }

    const response = await api.post(
      import.meta.env.VITE_REQUEST_BOOKING_URL,
      tempBookingData,
      {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
          Accept: "application/json",
        },
      }
    );

    if (response.status === 201 || response.status === 200) {
      setShowError(false);
      setShowSuccess(true);
      setTimeout(() => setShowSuccess(false), 6000);
      
      // Clear the form
      setPurpose("");
      setRemark("");
      setStartDate("");
      setStartTime("");
      setEndDate("");
      setEndTime("");
      setSelectedHall("");
      setCapacity("");
      setAccessoryOptions([]);
    } else {
      
      setShowError(true);
      setShowSuccess(false);
      setTimeout(() => setShowError(false), 5000);
    }
  } catch (error) {
    const errorData = error.response?.data;
      // console.log(errorData['detail'])

      if (errorData && typeof errorData === 'object') {
        const firstField = Object.keys(errorData)[0];
        const firstErrorMessage = Array.isArray(errorData[firstField]) 
        ? errorData[firstField][0] 
        : errorData[firstField];
        setMessage(firstErrorMessage || 'Login failed. Please try again.');
      
      } else {
        // Fallback for non-field error like {"detail": "Invalid credentials"}
        const fallbackError = error.response?.data?.detail || 'Login failed. Please try again.';
        setMessage(fallbackError);
        console.log(fallbackError)
      }
    // console.error("Error submitting booking:", error);
    setShowError(true);
    setShowSuccess(false);
    setTimeout(() => setShowError(false), 5000);
  } finally {
    setIsSubmitting(false);
    setTempBookingData(null);
  }
};

const handleCancelSubmit = () => {
  setShowConfirmation(false);
  setTempBookingData(null);
};

  const handleDateChange = (e) => {
    const value = e.target.value;
    setStartDate(value);
    setEndDate(value);
    setStartTime("");
    setEndTime("");
    setEndDate("");
  };
  const handleAccessoryChange = (accessory) => {
    setSelectedAccessories(
      (prev) =>
        prev.includes(accessory)
          ? prev.filter((item) => item !== accessory) // Remove if already selected
          : [...prev, accessory] // Add if not selected
    );
  };
  // return
  return (

  <div className="main-content-wrapper">
    <AnimatePresence>
      {showSuccess && (
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: 20 }}
          transition={{ duration: 0.4 }}
          className="success-message"
        >
          ✅ Booking successful! You will receive a confirmation mail shortly
        </motion.div>
      )}
    </AnimatePresence>

    <AnimatePresence>
      {showError && (
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: 20 }}
          transition={{ duration: 0.4 }}
          className="bg-red-100 text-red-800 p-4 rounded-lg shadow-md my-2"
        >
         <i className="fas fa-exclamation-circle"></i> {message}
        </motion.div>
      )}
    </AnimatePresence>

    {showConfirmation && (
      <div className="confirmation-modal">
        <div className="confirmation-content">
          <h3>Confirm Booking</h3>
          <p>Are you sure you want to submit this booking?</p>
          <div className="confirmation-buttons">
            <button onClick={handleConfirmSubmit} className="confirm-btn">
              Yes, Book Now
            </button>
            <button onClick={handleCancelSubmit} className="cancel-btn">
              Cancel
            </button>
          </div>
        </div>
      </div>
    )}

    <div className="booking-form-container">
      <form className="booking-form" onSubmit={handleSubmitInit}>
        <div className="form-row">
          {role === "admin" ? (
            <div className="form-column">
              <label htmlFor="user">User</label>
              <select
                id="user"
                value={selectedUser}
                onChange={(e) => setSelectedUser(e.target.value)}
                className="form-control"
              >
                <option value="">Select User</option>
                {users.length > 0 ? (
                  users.map((u) => (
                    <option key={u.email} value={u.username}>
                      {u.username}
                    </option>
                  ))
                ) : (
                  <option disabled>Loading users...</option>
                )}
              </select>
            </div>
          ) : (
            <div className="form-column">
              <label htmlFor="user">User</label>
              <input
                type="text"
                id="user"
                value={selectedUser}
                readOnly
                className="form-control"
                style={{ userSelect: "none", cursor: "not-allowed" }}
              />
            </div>
          )}
          <div className="form-column">
            <label htmlFor="purpose">Purpose</label>
            <input
              type="text"
              id="purpose"
              value={purpose}
              onChange={(e) => setPurpose(e.target.value)}
              required
              placeholder="Type your Purpose Here..."
              className="form-control"
            />
          </div>
        </div>
        {/* <div className="card booking-date-time-card"> */}
        {/* <h3>Enter Booking Date and Time</h3> */}
        <div className="form-row">
          <div className="form-column">
            <label>Date</label>
            <div className="date-time-controls">
              <input
                type="date"
                value={startDate}
                onChange={handleDateChange}
                className="date-input"
                placeholder="dd-mm-yyyy"
                min={new Date(new Date().setDate(new Date().getDate() + 2))
                  .toISOString()
                  .split("T")[0]}
                  max={new Date(new Date().setMonth(new Date().getMonth() + 3))
                    .toISOString()
                    .split("T")[0]}
              />
            </div>
          </div>
          <></>
          <div className="form-column">
            <label>Start</label>
            <div className="date-time-controls">
              <select
                value={startTime}
                onChange={(e) => {
                  setStartTime(e.target.value)
                  setEndTime("")
                }}
                className="time-select"
              >
                <option value="" disabled>
                  -- Select start time --
                </option>
                {timeOptions.slice(0, timeOptions.length - 1).map((time) => (
                  <option key={`start-${time}`} value={time}>
                    {time}
                  </option>
                ))}
              </select>
            </div>
          </div>
          <div className="form-column">
            <label>End</label>
            <div className="date-time-controls">
              <select
                value={endTime}
                onChange={(e) => setEndTime(e.target.value)}
                className="time-select"
              >
                <option value="" disabled>
                  -- Select end time --
                </option>
                {timeOptions
                  .slice(
                    timeOptions.indexOf(startTime) + 1, 
                    Math.min(timeOptions.indexOf(startTime) + 7, timeOptions.length)
                  )
                  .map((time) => (
                    <option key={`end-${time}`} value={time}>
                      {time}
                    </option>
                  ))}
              </select>
            </div>
          </div>
        </div>
        {/* </div> */}

        <div className="form-row">
          <div className="form-column">
            <label htmlFor="roomSelect">Select Available Rooms</label>
            <select
              id="roomSelect"
              value={selectedHall}
              onChange={(e) => setSelectedHall(e.target.value)}
              className="form-control"
              required
            >
              <option value="" disabled>
                -- Select a Room --
              </option>
              {filteredRoomOptions.map((room) => (
                <option key={room.id} value={room.id}>
                  {room.name} (Capacity: {room.capacity})
                </option>
              ))}
            </select>
          </div>
        </div>

        {startDate && startTime && endTime && (
            <>
        <div className="optional-filters-box">
          
              <h3>Filter Available Rooms</h3>
              <p>
                Enter filters to let the system find the best available room for
                you.
              </p>
              <div className="form-row">
                <div className="form-column">
                  <label>Capacity</label>
                  <select
                    value={capacity}
                    onChange={(e) => setCapacity(e.target.value)}
                    className="form-control"
                  >
                    <option value="">Select capacity</option>
                    {capacityOptions.map((option) => (
                      <option key={option} value={option}>
                        {option}
                      </option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="form-row">
                <div className="form-column">
                  <label>Accessories</label>
                  <div className="accessories-grid">
                    {accessoryOptions.map((accessory) => (
                      <motion.button
                        key={accessory}
                        type="button"
                        className={`accessory-btn ${
                          selectedAccessories.includes(accessory)
                            ? "selected"
                            : ""
                        }`}
                        onClick={() => handleAccessoryChange(accessory)}
                        initial={{ opacity: 0, scale: 0.8 }}
                        animate={{ opacity: 1, scale: 1 }}
                        transition={{ duration: 0.3 }}
                      >
                        {accessory}
                      </motion.button>
                    ))}
                  </div>
                </div>
              </div>
            
          

          {capacity && (
            <motion.div
              className="halls-grid"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.5 }}
            >
              <AnimatePresence>
                {filteredRoomOptions.map((hall) => (
                  <motion.div
                    key={hall.id}
                    className={`hall-card ${
                      selectedHall === hall.id ? "selected" : ""
                    }`}
                    onClick={() => setSelectedHall(hall.id)}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    initial={{ opacity: 0, scale: 0.9 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 0.9 }}
                    transition={{ duration: 0.3 }}
                  >
                    <div className="hall-header">{hall.name}</div>
                    <div className="hall-details">
                      <p>Capacity: {hall.capacity}</p>
                      <p>
                        Accessories:{" "}
                        {Object.keys(hall.accessories).join(", ")}
                      </p>
                    </div>
                  </motion.div>
                ))}
              </AnimatePresence>
            </motion.div>
          )}
        </div>
        </>
        )}

        <div className="form-row" style={{ marginTop: "20px" }}>
          <div className="form-column">
            <label htmlFor="remark">Remark</label>
            <textarea
              id="remark"
              value={remark}
              onChange={(e) => setRemark(e.target.value)}
              className="form-control"
              placeholder="Any additional comments or remarks..."
              rows={3}
            />
          </div>
        </div>

        {selectedHall && (
          <button type="submit" className="submit-btn" disabled={isSubmitting}>
            {isSubmitting ? "Submitting..." : "SUBMIT"}
          </button>
        )}
      </form>
    </div>
  </div>
);

};

export default Request_Booking;


