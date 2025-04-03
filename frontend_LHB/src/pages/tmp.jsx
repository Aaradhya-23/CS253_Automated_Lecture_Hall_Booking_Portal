// // DONT TOUCH THIS FILE - ATHARV
import api from '../api/api';
import React, { useState, useEffect } from "react";
import FullCalendar from "@fullcalendar/react";
import timeGridPlugin from "@fullcalendar/timegrid";
import dayGridPlugin from "@fullcalendar/daygrid";
import listPlugin from "@fullcalendar/list";
import "./tmp.css";

const LiveSchedule = () => {
  const [bookings, setBookings] = useState([]);
  const [lectureHalls, setRoomOptions] = useState([]);
  const [selectedLectureHall, setSelectedLectureHall] = useState(null); // Stores the selected lecture hall ID


  useEffect(() => {
    const fetchRooms = async () => {
      try {
        const response = await api.get(import.meta.env.VITE_ROOM_LIST_CREATE_URL, {
        });
        console.log(response.data);
        const rooms = Array.isArray(response.data) ? response.data : response.data.rooms;
        setRoomOptions(rooms); 
        console.log(rooms)
        } catch (error) {
          console.error("Error fetching rooms:", error);
        }
    };
  
    fetchRooms();
  }, []);

  const fetchBookings = async (hall_name) => {

    console.log(`${import.meta.env.VITE_BOOKING_SEARCH_URL}?search=${hall_name}`)
    try {
      const response = await api.get(`${import.meta.env.VITE_BOOKING_SEARCH_URL}?search=${hall_name}`, {
        headers: {
          'Content-Type': 'application/json', // Specify the content type as JSON
          Accept: 'application/json', // Specify that the response should be in JSON format
        },
      });
      const data = response.data; // Access the data directly
      console.log("bookings = ", data)
      setBookings(data);
    } catch (err) {
      console.error('Error fetching bookings:', err.message || err);    
    }
  };

  useEffect(() => {
    fetchBookings(selectedLectureHall);
  }, [selectedLectureHall]);

    const events = bookings.map((event) => ({
        title: `${event.title} - ${event.creator.username}`,
        start: `${event.booking_date}T${event.start_time}`, // Combine booking_date and start_time
        end: `${event.booking_date}T${event.end_time}`,     // Combine booking_date and end_time
        extendedProps: {
            professor: event.creator.username,
        },
    }));

    return (
        <div className="calendar-container">
            <div className="dropdown-container">
                <label htmlFor="lectureHallDropdown" className="dropdown-label">
                    Select Lecture Hall:
                </label>
                <select
                    id="lectureHallDropdown"
                    className="dropdown"
                    value={selectedLectureHall || ""}
                    onChange={(e) => setSelectedLectureHall(e.target.value)}
                >
                    {lectureHalls.map((hall) => (
                        <option key={hall.id} value={hall.name}>
                            {hall.name}
                        </option>
                    ))}
                </select>
            </div>
            <FullCalendar
                plugins={[timeGridPlugin, dayGridPlugin, listPlugin]}
                initialView="timeGridWeek"
                slotDuration="01:00:00"
                slotMinTime="08:00:00"
                slotMaxTime="20:00:00"
                expandRows={true}
                height="90vh"
                headerToolbar={{
                    left: "prev,next today",
                    center: "title",
                    right: "dayGridMonth,timeGridWeek,listWeek",
                }}
                events={events}
                allDaySlot={false} 
            />
        </div>
    );
};

export default LiveSchedule;
