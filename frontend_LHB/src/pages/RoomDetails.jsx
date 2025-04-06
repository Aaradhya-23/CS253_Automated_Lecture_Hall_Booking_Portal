import React, { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion"; // Import Framer Motion
import {
  Projector,
  Computer,
  Speaker,
  Presentation,
  Mic,
  HelpCircle,
  Wind,
} from "lucide-react";
import "./RoomDetails.css";
import { assets } from "../assets/assets";
import { ACCESS_TOKEN } from "../api/constants";
import api from "../api/api";

const accessoryIcons = {
  AC: Wind,
  Projector: Projector,
  Computer: Computer,
  Microphone: Mic,
  Speaker_system: Speaker,
  Whiteboard: Presentation,
  default: HelpCircle,
};

const accessoryDisplayNames = {
  projector: "Projector",
  computer: "Computer",
  microphone: "Microphone",
  speaker_system: "Speaker System",
  whiteboard: "Whiteboard",
};

const RoomDetails = () => {
  const [lectureHallData, setLectureHallData] = useState([]);
  const [tutorialBlockData, setTutorialBlockData] = useState([]);
  const [activeTab, setActiveTab] = useState("Lecture Halls");
  const [selectedItem, setSelectedItem] = useState(null);
  const token = localStorage.getItem(ACCESS_TOKEN);

  const transformRoomData = (room) => {
    return {
      id: room.room_type === "lecture_hall" ? `L${room.id}` : `TB${room.id}`,
      name:
        room.room_type === "lecture_hall"
          ? `Lecture Hall ${room.name}`
          : `Tutorial Block ${room.name}`,
      capacity: room.capacity,
      price_per_hour: room.price_per_hour,
      image:
        assets[room.room_type === "lecture_hall" ? `L${room.id}` : `TB${room.id}`] ||
        assets.defaultImage,
      accessories: Object.entries(room.accessories)
        .filter(([key, value]) => value === true)
        .map(([key]) => key),
    };
  };

  useEffect(() => {
    const fetchRooms = async () => {
      if (!token) {
        console.error("No token found. User is not authenticated.");
        return;
      }
      try {
        const response = await api.get(import.meta.env.VITE_ROOM_LIST_CREATE_URL, {
          headers: { Authorization: `Bearer ${token}` },
        });
        const rooms = response.data.map(transformRoomData);
        setLectureHallData(rooms.filter((room) => room.id.startsWith("L")));
        setTutorialBlockData(rooms.filter((room) => room.id.startsWith("TB")));
      } catch (error) {
        console.error("Error fetching rooms:", error.response?.data?.detail || error.message);
      }
    };
    fetchRooms();
  }, []);

  const currentData = activeTab === "Lecture Halls" ? lectureHallData : tutorialBlockData;

  return (
    <motion.div
      className="container"
      initial={{ opacity: 0, y: 20 }} // Page load animation
      animate={{ opacity: 1, y: 0 }}
      // exit={{ opacity: 0, y: 20 }}
      transition={{ duration: 0.6 }}
    >
      {/* Tabs */}
      <div className="tab-navigation">
        <button
          className={`tab-button ${activeTab === "Lecture Halls" ? "active" : ""}`}
          onClick={() => setActiveTab("Lecture Halls")}
        >
          Lecture Halls
        </button>
        <button
          className={`tab-button ${activeTab === "Tutorial Blocks" ? "active" : ""}`}
          onClick={() => setActiveTab("Tutorial Blocks")}
        >
          Tutorial Blocks
        </button>
      </div>

        <div
          key={activeTab} // Trigger animation when tab changes
          className="room-grid"
        >
          {currentData.map((item) => (
            <div
              key={item.id}
              className="room-card"
              onClick={() => setSelectedItem(item)}
            >
              <div className="room-card-image-container">
                <img
                  src={item.image}
                  alt={item.name}
                  className="room-card-image"
                />
              </div>
              <div className="room-card-content">
                <h3 className="room-card-title">{item.name}</h3>
                <div className="room-card-accessories">
                  {item.accessories.slice(0, 3).map((accessory) => {
                    const AccessoryIcon = accessoryIcons[accessory] || accessoryIcons.default;
                    return (
                      <AccessoryIcon
                        key={accessory}
                        className="room-card-accessory-icon"
                        size={20}
                        title={accessoryDisplayNames[accessory] || accessory}
                      />
                    );
                  })}
                </div>
              </div>
            </div>
          ))}
        </div>
      {/* </AnimatePresence> */}

      {/* Modal for Item Details */}
        {selectedItem && (
          <div
            className="modal-overlay"
            // initial={{ opacity: 0 }}
            // animate={{ opacity: 1 }}
            // exit={{ opacity: 0 }}
            // transition={{ duration: 0.3 }}
          >
            <div
              className="modal-content"
              // initial={{ scale: 0.8 }}
              // animate={{ scale: 1 }}
              // exit={{ scale: 0.8 }}
              // transition={{ duration: 0.3 }}
            >
              <img
                src={selectedItem.image}
                alt={selectedItem.name}
                className="modal-image"
              />
              <div className="modal-details">
                <h2 className="modal-title">{selectedItem.name}</h2>
                <div className="modal-info">
                  <div className="modal-capacity">
                    <span className="modal-label">Capacity</span>
                    <span>{selectedItem.capacity} seats</span>
                  </div>
                  <div className="modal-capacity">
                    <span className="modal-label">Room price per hour</span>
                    <span>{selectedItem.price_per_hour} Rs</span>
                  </div>
                  <div className="modal-accessories">
                    <h3 className="modal-accessories-title">Accessories</h3>
                    <div className="modal-accessories-grid">
                      {selectedItem.accessories.map((accessory) => {
                        const AccessoryIcon = accessoryIcons[accessory] || accessoryIcons.default;
                        return (
                          <div key={accessory} className="modal-accessory-item">
                            <AccessoryIcon
                              className="modal-accessory-icon"
                              size={30}
                              title={accessoryDisplayNames[accessory] || accessory}
                            />
                            <span className="modal-accessory-label">
                              {accessoryDisplayNames[accessory] || accessory}
                            </span>
                          </div>
                        );
                      })}
                    </div>
                  </div>
                  {/* <button
                    className="modal-book-button"
                    onClick={() => alert(`Booking for ${selectedItem.name}`)}
                  >
                    Book Now
                  </button> */}
                </div>
              </div>
              <button
                onClick={() => setSelectedItem(null)}
                className="modal-close-button"
              >
                ✕
              </button>
            </div>
          </div>
        )}
    </motion.div>
  );
};

export default RoomDetails;