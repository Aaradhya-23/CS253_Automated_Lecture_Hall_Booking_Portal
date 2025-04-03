import React, { useState, useEffect, useRef } from "react";
import FullCalendar from "@fullcalendar/react";
import timeGridPlugin from "@fullcalendar/timegrid";
import dayGridPlugin from "@fullcalendar/daygrid";
import listPlugin from "@fullcalendar/list";
import interactionPlugin from "@fullcalendar/interaction"; // Import for hover interactions
import "./LiveSchedule.css"; // Import the new CSS file
import api from '../api/api';

const LiveSchedule = () => {
  const [bookings, setBookings] = useState([]);
  const [lectureHalls, setRoomOptions] = useState([]);
  const [selectedLectureHall, setSelectedLectureHall] = useState(null);
  const [tooltip, setTooltip] = useState({ visible: false, x: 0, y: 0, content: {} });
  const calendarRef = useRef(null);
  // Fetch rooms on component mount
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
  // Fetch bookings when selected lecture hall changes
  useEffect(() => {
    if (selectedLectureHall) {
      fetchBookings(selectedLectureHall);
    }
  }, [selectedLectureHall]);
  // Backend API calls for fetching rooms
  // Backend API calls for fetching bookings
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
  // Format bookings for FullCalendar
  const events = bookings.map((event) => ({
    title: event.title,
    start: `${event.booking_date}T${event.start_time}`,
    end: `${event.booking_date}T${event.end_time}`,
    extendedProps: {
      username: event.creator?.username || "Unknown",
      roomName: event.room_details?.name || selectedLectureHall,
      capacity: event.room_details?.capacity || "N/A",
      description: event.remarks || "No description provided",
    },
  }));
  // Show tooltip when hovering over an event
  const handleEventClick = (info) => {
    const { event, jsEvent } = info;
    const props = event.extendedProps;
    jsEvent.stopPropagation();
    setTooltip(prev => ({
      ...prev,
      visible: true,
      x: jsEvent.pageX + 10,
      y: jsEvent.pageY + 10,
      content: {
        title: event.title,
        username: props.username,
        room: props.roomName,
        capacity: props.capacity,
        description: props.description,
        start: event.start?.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        end: event.end?.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        date: event.start?.toLocaleDateString()
      }
    }));
  };
  // Hide tooltip when mouse leaves an event
  const handleCloseTooltip = () => {
    setTooltip({ visible: false, x: 0, y: 0, content: {} });
  };
  // Format dates in a nicer way for event rendering
  const eventContent = (info) => {
    return (
      <>
        <div className="fc-event-time">{info.timeText}</div>
        <div className="fc-event-title">{info.event.title}</div>
      </>
    );
  };
  useEffect(() => {
    const handleClickOutside = (e) => {
      // If tooltip is visible and click target is not inside tooltip
      if (tooltip.visible && !e.target.closest('.booking-tooltip') &&
          !e.target.closest('.fc-event')) {
        handleCloseTooltip();
      }
    };

    document.addEventListener('click', handleClickOutside);
    return () => {
      document.removeEventListener('click', handleClickOutside);
    };
  }, [tooltip.visible]);
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
          <option value="">Select a hall</option>
          {lectureHalls.map((hall) => (
            <option key={hall.id} value={hall.name}>
              {hall.name}
            </option>
          ))}
        </select>
      </div>
      <FullCalendar
        ref={calendarRef}
        plugins={[timeGridPlugin, dayGridPlugin, listPlugin, interactionPlugin]}
        initialView="timeGridWeek"
        slotDuration="01:00:00"
        slotMinTime="08:00:00"
        slotMaxTime="20:00:00"
        expandRows={true}
        height="85vh"
        headerToolbar={{
          left: "prev,next today",
          center: "title",
          right: "dayGridMonth,timeGridWeek,listWeek",
        }}
        events={events}
        allDaySlot={false}
        eventContent={eventContent}
        eventClick={handleEventClick}
        eventTimeFormat={{
          hour: '2-digit',
          minute: '2-digit',
          hour12: true
        }}
      />
            {tooltip.visible && (
        <div
          className="booking-tooltip visible"
          style={{
            top: tooltip.y,
            left: tooltip.x
          }}
        >
          <div className="booking-tooltip-header">
            <div className="booking-tooltip-title">{tooltip.content.title}</div>
          </div>
          <div className="booking-tooltip-details">
            <div className="booking-tooltip-detail"><strong>Username:</strong> {tooltip.content.username}</div>
            <div className="booking-tooltip-detail"><strong>Room:</strong> {tooltip.content.room}</div>
            <div className="booking-tooltip-detail"><strong>Date:</strong> {tooltip.content.date}</div>
            <div className="booking-tooltip-detail"><strong>Time:</strong> {tooltip.content.start} - {tooltip.content.end}</div>
            {tooltip.content.description && (
              <div className="booking-tooltip-detail"><strong>Description:</strong> {tooltip.content.description}</div>
            )}
          </div>
        </div>
      )}
    </div>
  );
};
export default LiveSchedule;
