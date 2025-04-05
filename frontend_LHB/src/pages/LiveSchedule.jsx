// import React, { useState, useEffect, useRef, useMemo } from "react";
// import FullCalendar from "@fullcalendar/react";
// import timeGridPlugin from "@fullcalendar/timegrid";
// import dayGridPlugin from "@fullcalendar/daygrid";
// import listPlugin from "@fullcalendar/list";
// import interactionPlugin from "@fullcalendar/interaction"; // Import for hover interactions
// import "./LiveSchedule.css"; // Import the new CSS file
// import DatePicker from "react-datepicker";
// import "react-datepicker/dist/react-datepicker.css";
// import api from "../api/api";
// import { AnimatePresence, motion } from "framer-motion";

// const LiveSchedule = () => {
//   const [bookings, setBookings] = useState([]);
//   const [lectureHalls, setRoomOptions] = useState([]);
//   const [selectedLectureHall, setSelectedLectureHall] = useState(null);
//   const [tooltip, setTooltip] = useState({
//     visible: false,
//     x: 0,
//     y: 0,
//     content: {},
//   });
//   const [selectedDate, setSelectedDate] = useState(new Date()); // State for the selected date
//   const calendarRef = useRef(null);
//   const [isDatePickerOpen, setIsDatePickerOpen] = useState(false); // State to control DatePicker visibility
//   const datePickerRef = useRef(null);
//   const [currentView, setCurrentView] = useState("timeGridWeek"); // Track the current view


//   // Fetch rooms on component mount
//   useEffect(() => {
//     const fetchRooms = async () => {
//       try {
//         const response = await api.get(
//           import.meta.env.VITE_ROOM_LIST_CREATE_URL,
//           {}
//         );
//         console.log(response.data);
//         const rooms = Array.isArray(response.data)
//           ? response.data
//           : response.data.rooms;
//         setRoomOptions(rooms);
//         console.log(rooms);
//       } catch (error) {
//         console.error("Error fetching rooms:", error);
//       }
//     };
//     fetchRooms();
//   }, []);
//   // Fetch bookings when selected lecture hall changes
//   useEffect(() => {
//     if (selectedLectureHall) {
//       fetchBookings(selectedLectureHall);
//     }
//   }, [selectedLectureHall]);
//   // Backend API calls for fetching rooms
//   // Backend API calls for fetching bookings
//   const fetchBookings = async (hall_name) => {
//     console.log(
//       `${import.meta.env.VITE_BOOKING_SEARCH_URL}?search=${hall_name}`
//     );
//     try {
//       const response = await api.get(
//         `${import.meta.env.VITE_BOOKING_SEARCH_URL}?search=${hall_name}`,
//         {
//           headers: {
//             "Content-Type": "application/json", // Specify the content type as JSON
//             Accept: "application/json", // Specify that the response should be in JSON format
//           },
//         }
//       );
//       const data = response.data; // Access the data directly
//       console.log("bookings = ", data);
//       setBookings(data);
//     } catch (err) {
//       console.error("Error fetching bookings:", err.message || err);
//     }
//   };
//   // Format bookings for FullCalendar
//   const events = bookings.map((event) => ({
//     title: event.title,
//     start: `${event.booking_date}T${event.start_time}`,
//     end: `${event.booking_date}T${event.end_time}`,
//     extendedProps: {
//       username: event.creator?.username || "Unknown",
//       roomName: event.room_details?.name || selectedLectureHall,
//       capacity: event.room_details?.capacity || "N/A",
//       description: event.remarks || "No description provided",
//     },
//   }));
//   // Show tooltip when hovering over an event
//   const handleEventClick = (info) => {
//     const { event, jsEvent } = info;
//     const props = event.extendedProps;
//     jsEvent.stopPropagation();
//     setTooltip((prev) => ({
//       ...prev,
//       visible: true,
//       x: jsEvent.pageX + 10,
//       y: jsEvent.pageY + 10,
//       content: {
//         title: event.title,
//         username: props.username,
//         room: props.roomName,
//         capacity: props.capacity,
//         description: props.description,
//         start: event.start?.toLocaleTimeString([], {
//           hour: "2-digit",
//           minute: "2-digit",
//         }),
//         end: event.end?.toLocaleTimeString([], {
//           hour: "2-digit",
//           minute: "2-digit",
//         }),
//         date: event.start?.toLocaleDateString(),
//       },
//     }));
//   };
//   // Hide tooltip when mouse leaves an event
//   const handleCloseTooltip = () => {
//     setTooltip({ visible: false, x: 0, y: 0, content: {} });
//   };
//   // Format dates in a nicer way for event rendering
//   const eventContent = (info) => {
//     return (
//       <>
//         <div className="fc-event-time">{info.timeText}</div>
//         <div className="fc-event-title">{info.event.title}</div>
//       </>
//     );
//   };

//   useEffect(() => {
//     const handleClickOutside = (e) => {
//       if (
//         isDatePickerOpen &&
//         datePickerRef.current &&
//         !datePickerRef.current.contains(e.target)
//       ) {
//         setIsDatePickerOpen(false);
//       }
//     };

//     document.addEventListener("mousedown", handleClickOutside);
//     return () => {
//       document.removeEventListener("mousedown", handleClickOutside);
//     };
//   }, [isDatePickerOpen]);

//   useEffect(() => {
//     const handleClickOutside = (e) => {
//       // If tooltip is visible and click target is not inside tooltip
//       if (
//         tooltip.visible &&
//         !e.target.closest(".booking-tooltip") &&
//         !e.target.closest(".fc-event")
//       ) {
//         handleCloseTooltip();
//       }
//     };
//     document.addEventListener("click", handleClickOutside);
//     return () => {
//       document.removeEventListener("click", handleClickOutside);
//     };
//   }, [tooltip.visible]);
//   // Handle date selection from the date picker
//   const handleDateChange = (date) => {
//     setSelectedDate(date);
//     const calendarApi = calendarRef.current.getApi();
//     calendarApi.gotoDate(date); // Navigate FullCalendar to the selected date
//     setIsDatePickerOpen(false); // Close the DatePicker after selecting a date
//   };
//   const customButtons = useMemo(
//     () => ({
//       customDatePicker: {
//         text: "📅",
//         click: () => {
//           console.log("print");
//           setIsDatePickerOpen(true);
//         },
//       },
//     }),
//     []
//   );
//   const handleDatesSet = (arg) => {
//     console.log("here")
//     setCurrentView(arg.view.type); // this ensures state tracks current view
//   };
//   return (
//     <motion.div
//       className="calendar-container"
//       initial={{ opacity: 0, y: 20 }}
//       animate={{ opacity: 1, y: 0 }}
//       transition={{ duration: 0.6 }}
//     >
//       <motion.div
//         className="dropdown-container"
//         initial={{ opacity: 0, y: -10 }}
//         animate={{ opacity: 1, y: 0 }}
//         exit={{ opacity: 0, y: -10 }} // Animate out when removed
//         transition={{ duration: 0.5 }}
//       >
//         <label htmlFor="lectureHallDropdown" className="dropdown-label">
//           Select Lecture Hall:
//         </label>
//         <motion.select
//           id="lectureHallDropdown"
//           className="dropdown"
//           value={selectedLectureHall || ""}
//           onChange={(e) => setSelectedLectureHall(e.target.value)}
//           initial={{ opacity: 0, scale: 0.9 }}
//           animate={{ opacity: 1, scale: 1 }}
//           exit={{ opacity: 0, scale: 0.9 }}
//           transition={{ duration: 0.3 }}
//         >
//           <AnimatePresence>
//             <motion.option
//               key="default"
//               value=""
//               initial={{ opacity: 0 }}
//               animate={{ opacity: 1 }}
//               exit={{ opacity: 0 }}
//               transition={{ duration: 0.3 }}
//             >
//               Select a hall
//             </motion.option>
//             {lectureHalls.map((hall) => (
//               <motion.option
//                 key={hall.id}
//                 value={hall.name}
//                 initial={{ opacity: 0 }}
//                 animate={{ opacity: 1 }}
//                 exit={{ opacity: 0 }}
//                 transition={{ duration: 0.3 }}
//               >
//                 {hall.name}
//               </motion.option>
//             ))}
//           </AnimatePresence>
//         </motion.select>
//       </motion.div>
//       <AnimatePresence mode="wait">
//         <motion.div
//           key={currentView} // Use the current view as the key to trigger re-render
//           initial={{ opacity: 0, scale: 0.9 }}
//           animate={{ opacity: 1, scale: 1 }}
//           exit={{ opacity: 0, scale: 0.9 }}
//           transition={{ duration: 0.07 }}
//         >
//       <FullCalendar
//         key={currentView}
//         ref={calendarRef}
//         plugins={[timeGridPlugin, dayGridPlugin, listPlugin, interactionPlugin]}
//         initialView={currentView}
//         slotDuration="01:00:00"
//         slotMinTime="08:00:00"
//         slotMaxTime="20:00:00"
//         expandRows={true}
//         height="85vh"
//         headerToolbar={{
//           left: "prev,next today customDatePicker",
//           center: "title",
//           right: "dayGridMonth,timeGridWeek,listWeek",
//         }}
//         customButtons={customButtons}
//         events={events}
//         allDaySlot={false}
//         eventContent={eventContent}
//         eventClick={handleEventClick}
//         datesSet={handleDatesSet}
//         // viewDidMount={(view) => handleViewChange(view)} // Detect view changes
//         eventTimeFormat={{
//           hour: "2-digit",
//           minute: "2-digit",
//           hour12: true,
//         }}
//       />
//       </motion.div>
//       </AnimatePresence>
//       <AnimatePresence>
//         {isDatePickerOpen && (
//           <motion.div
//             ref={datePickerRef}
//             className="date-picker-container"
//             initial={{ opacity: 0, y: -10 }}
//             animate={{ opacity: 1, y: 0 }}
//             exit={{ opacity: 0, y: -10 }}
//             transition={{ duration: 0.3 }}
//           >
//             <DatePicker
//               selected={selectedDate}
//               onChange={handleDateChange}
//               inline
//             />
//           </motion.div>
//         )}
//       </AnimatePresence>
//       <AnimatePresence>
//         {tooltip.visible && (
//           <motion.div
//             className="booking-tooltip visible"
//             initial={{ opacity: 0, scale: 0.8 }}
//             animate={{ opacity: 1, scale: 1 }}
//             exit={{ opacity: 0, scale: 0.8 }}
//             transition={{ duration: 0.3 }}
//             style={{
//               top: tooltip.y,
//               left: tooltip.x,
//             }}
//           >
//             <div className="booking-tooltip-header">
//               <div className="booking-tooltip-title">
//                 {tooltip.content.title}
//               </div>
//             </div>
//             <div className="booking-tooltip-details">
//               <div className="booking-tooltip-detail">
//                 <strong>Username:</strong> {tooltip.content.username}
//               </div>
//               <div className="booking-tooltip-detail">
//                 <strong>Room:</strong> {tooltip.content.room}
//               </div>
//               <div className="booking-tooltip-detail">
//                 <strong>Date:</strong> {tooltip.content.date}
//               </div>
//               <div className="booking-tooltip-detail">
//                 <strong>Time:</strong> {tooltip.content.start} -{" "}
//                 {tooltip.content.end}
//               </div>
//               {tooltip.content.description && (
//                 <div className="booking-tooltip-detail">
//                   <strong>Description:</strong> {tooltip.content.description}
//                 </div>
//               )}
//             </div>
//           </motion.div>
//         )}
//       </AnimatePresence>
//     </motion.div>
//   );
// };
// export default LiveSchedule;





import React, { useState, useEffect, useRef, useMemo } from "react";
import FullCalendar from "@fullcalendar/react";
import timeGridPlugin from "@fullcalendar/timegrid";
import dayGridPlugin from "@fullcalendar/daygrid";
import listPlugin from "@fullcalendar/list";
import interactionPlugin from "@fullcalendar/interaction"; // Import for hover interactions
import "./LiveSchedule.css"; // Import the new CSS file
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import api from "../api/api";
import { AnimatePresence, motion } from "framer-motion";

const LiveSchedule = () => {
  const [bookings, setBookings] = useState([]);
  const [lectureHalls, setRoomOptions] = useState([]);
  const [selectedLectureHall, setSelectedLectureHall] = useState(null);
  const [tooltip, setTooltip] = useState({
    visible: false,
    x: 0,
    y: 0,
    content: {},
  });
  const [selectedDate, setSelectedDate] = useState(new Date()); // State for the selected date
  const calendarRef = useRef(null);
  const [isDatePickerOpen, setIsDatePickerOpen] = useState(false); // State to control DatePicker visibility
  const datePickerRef = useRef(null);
  const [currentView, setCurrentView] = useState("timeGridWeek"); // Track the current view


  // Fetch rooms on component mount
  useEffect(() => {
    const fetchRooms = async () => {
      try {
        const response = await api.get(
          import.meta.env.VITE_ROOM_LIST_CREATE_URL,
          {}
        );
        console.log(response.data);
        const rooms = Array.isArray(response.data)
          ? response.data
          : response.data.rooms;
        setRoomOptions(rooms);
        console.log(rooms);
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
    console.log(
      `${import.meta.env.VITE_BOOKING_SEARCH_URL}?search=${hall_name}&status=approved`
    );
    try {
      const response = await api.get(
        `${import.meta.env.VITE_BOOKING_SEARCH_URL}?search=${hall_name}&status=approved`,
        {
          headers: {
            "Content-Type": "application/json", // Specify the content type as JSON
            Accept: "application/json", // Specify that the response should be in JSON format
          },
        }
      );
      const data = response.data; // Access the data directly
      console.log("bookings = ", data);
      setBookings(data);
    } catch (err) {
      console.error("Error fetching bookings:", err.message || err);
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
    setTooltip((prev) => ({
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
        start: event.start?.toLocaleTimeString([], {
          hour: "2-digit",
          minute: "2-digit",
        }),
        end: event.end?.toLocaleTimeString([], {
          hour: "2-digit",
          minute: "2-digit",
        }),
        date: event.start?.toLocaleDateString(),
      },
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
      if (
        isDatePickerOpen &&
        datePickerRef.current &&
        !datePickerRef.current.contains(e.target)
      ) {
        setIsDatePickerOpen(false);
      }
    };

    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [isDatePickerOpen]);

  useEffect(() => {
    const handleClickOutside = (e) => {
      // If tooltip is visible and click target is not inside tooltip
      if (
        tooltip.visible &&
        !e.target.closest(".booking-tooltip") &&
        !e.target.closest(".fc-event")
      ) {
        handleCloseTooltip();
      }
    };
    document.addEventListener("click", handleClickOutside);
    return () => {
      document.removeEventListener("click", handleClickOutside);
    };
  }, [tooltip.visible]);
  // Handle date selection from the date picker
  const handleDateChange = (date) => {
    setSelectedDate(date);
    const calendarApi = calendarRef.current.getApi();
    calendarApi.gotoDate(date); // Navigate FullCalendar to the selected date
    setIsDatePickerOpen(false); // Close the DatePicker after selecting a date
  };
  const customButtons = useMemo(
    () => ({
      customDatePicker: {
        text: "📅",
        click: () => {
          console.log("print");
          setIsDatePickerOpen(true);
        },
      },
    }),
    []
  );
  const handleDatesSet = (arg) => {
    console.log("here")
    setCurrentView(arg.view.type); // this ensures state tracks current view
  };
  return (
    <motion.div
      className="calendar-container"
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6 }}
    >
      <motion.div
        className="dropdown-container"
        initial={{ opacity: 0, y: -10 }}
        animate={{ opacity: 1, y: 0 }}
        exit={{ opacity: 0, y: -10 }} // Animate out when removed
        transition={{ duration: 0.5 }}
      >
        <label htmlFor="lectureHallDropdown" className="dropdown-label">
          Select Lecture Hall:
        </label>
        <motion.select
          id="lectureHallDropdown"
          className="dropdown"
          value={selectedLectureHall || ""}
          onChange={(e) => setSelectedLectureHall(e.target.value)}
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          exit={{ opacity: 0, scale: 0.9 }}
          transition={{ duration: 0.3 }}
        >
          <AnimatePresence>
            <motion.option
              key="default"
              value=""
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.3 }}
            >
              Select a hall
            </motion.option>
            {lectureHalls.map((hall) => (
              <motion.option
                key={hall.id}
                value={hall.name}
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                transition={{ duration: 0.3 }}
              >
                {hall.name}
              </motion.option>
            ))}
          </AnimatePresence>
        </motion.select>
      </motion.div>
      
      {/* Removed AnimatePresence and key prop */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 0.3 }}
      >
        <FullCalendar
          ref={calendarRef}
          plugins={[timeGridPlugin, dayGridPlugin, listPlugin, interactionPlugin]}
          initialView={currentView}
          slotDuration="01:00:00"
          slotMinTime="08:00:00"
          slotMaxTime="20:00:00"
          expandRows={true}
          height="85vh"
          headerToolbar={{
            left: "prev,next today customDatePicker",
            center: "title",
            right: "dayGridMonth,timeGridWeek,listWeek",
          }}
          customButtons={customButtons}
          events={events}
          allDaySlot={false}
          eventContent={eventContent}
          eventClick={handleEventClick}
          datesSet={handleDatesSet}
          eventTimeFormat={{
            hour: "2-digit",
            minute: "2-digit",
            hour12: true,
          }}
        />
      </motion.div>
      
      <AnimatePresence>
        {isDatePickerOpen && (
          <motion.div
            ref={datePickerRef}
            className="date-picker-container"
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -10 }}
            transition={{ duration: 0.3 }}
          >
            <DatePicker
              selected={selectedDate}
              onChange={handleDateChange}
              inline
            />
          </motion.div>
        )}
      </AnimatePresence>
      <AnimatePresence>
        {tooltip.visible && (
          <motion.div
            className="booking-tooltip visible"
            initial={{ opacity: 0, scale: 0.8 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.8 }}
            transition={{ duration: 0.3 }}
            style={{
              top: tooltip.y,
              left: tooltip.x,
            }}
          >
            <div className="booking-tooltip-header">
              <div className="booking-tooltip-title">
                {tooltip.content.title}
              </div>
            </div>
            <div className="booking-tooltip-details">
              <div className="booking-tooltip-detail">
                <strong>Username:</strong> {tooltip.content.username}
              </div>
              <div className="booking-tooltip-detail">
                <strong>Room:</strong> {tooltip.content.room}
              </div>
              <div className="booking-tooltip-detail">
                <strong>Date:</strong> {tooltip.content.date}
              </div>
              <div className="booking-tooltip-detail">
                <strong>Time:</strong> {tooltip.content.start} -{" "}
                {tooltip.content.end}
              </div>
              {tooltip.content.description && (
                <div className="booking-tooltip-detail">
                  <strong>Description:</strong> {tooltip.content.description}
                </div>
              )}
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </motion.div>
  );
};
export default LiveSchedule;