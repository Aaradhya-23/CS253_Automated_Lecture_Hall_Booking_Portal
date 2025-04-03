import React, { useState } from 'react';
import { useEffect } from 'react';
// import { useNavigate } from 'react-router-dom';
import { Projector, Computer, Speaker, Presentation, Mic, HelpCircle } from 'lucide-react';
import './RoomDetails.css';
import { assets } from '../assets/assets';
import { ACCESS_TOKEN } from '../api/constants';
import api from '../api/api';
// Update to use lowercase keys to match API data
const accessoryIcons = {
  'projector': Projector,
  'computer': Computer,
  'microphone': Mic,
  'speaker_system': Speaker,
  'whiteboard': Presentation,
  'default': HelpCircle,
};
// Mapping between API keys and display names
const accessoryDisplayNames = {
  'projector': 'Projector',
  'computer': 'Computer',
  'microphone': 'Microphone',
  'speaker_system': 'Speaker System',
  'whiteboard': 'Whiteboard'
};
const RoomDetails = () => {
  const [lectureHallData, setLectureHallData] = useState([]);
  const [tutorialBlockData, setTutorialBlockData] = useState([]);
  const [activeTab, setActiveTab] = useState("Lecture Halls");
  const [selectedItem, setSelectedItem] = useState(null);
  const token = localStorage.getItem(ACCESS_TOKEN); // Get token once
  // Modified transform function to correctly handle accessories
  const transformRoomData = (room) => {
    // Log the raw accessories object for debugging
    console.log(`Room ${room.id} accessories:`, room.accessories);

    return {
      id: room.room_type === "lecture_hall" ? `L${room.id}` : `TB${room.id}`,
      name: room.room_type === "lecture_hall" ? `Lecture Hall ${room.name}` : `Tutorial Block ${room.name}`,
      capacity: room.capacity,
      image: assets[room.room_type === "lecture_hall" ? `L${room.id}` : `TB${room.id}`] || assets.defaultImage,
      // Get only the accessory keys that have true values
      accessories: Object.entries(room.accessories)
        .filter(([key, value]) => value === true)
        .map(([key]) => key)
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
        console.log("API Response:", response.data);  // Debugging
        if (!Array.isArray(response.data)) {
          console.error("Invalid API response format:", response.data);
          return;
        }
        const rooms = response.data.map(transformRoomData);
        setLectureHallData(rooms.filter(room => room.id.startsWith("L")));
        setTutorialBlockData(rooms.filter(room => room.id.startsWith("TB")));
      } catch (error) {
        console.error("Error fetching rooms:", error.response?.data?.detail || error.message);
      }
    };
    fetchRooms();
  }, []); // Removed `token` from dependencies
  useEffect(() => {
    console.log("Updated Lecture Halls:", lectureHallData);
    console.log("Updated Tutorial Blocks:", tutorialBlockData);
  }, [lectureHallData, tutorialBlockData]);
  const currentData = activeTab === "Lecture Halls" ? lectureHallData : tutorialBlockData;
  return (
    <div className="container">
      {/* Tabs */}
      <div className="tab-navigation">
        <button
          className={`tab-button ${activeTab === 'Lecture Halls' ? 'active' : ''}`}
          onClick={() => setActiveTab('Lecture Halls')}
        >
          Lecture Halls
        </button>
        <button
          className={`tab-button ${activeTab === 'Tutorial Blocks' ? 'active' : ''}`}
          onClick={() => setActiveTab('Tutorial Blocks')}
        >
          Tutorial Blocks
        </button>
      </div>
      {/* Grid of Items */}
      <div className="room-grid">
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
              <h3 className="room-card-title">
                {item.name}
              </h3>
              <div className="room-card-accessories">
                {item.accessories.slice(0, 3).map((accessory) => {
                  const AccessoryIcon = accessoryIcons[accessory] || accessoryIcons['default'];
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
      {/* Modal for Item Details */}
      {selectedItem && (
        <div className="modal-overlay">
          <div className="modal-content">
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

                <div className="modal-accessories">
                  <h3 className="modal-accessories-title">Accessories</h3>
                  <div className="modal-accessories-grid">
                    {selectedItem.accessories.map((accessory) => {
                      const AccessoryIcon = accessoryIcons[accessory] || accessoryIcons['default'];
                      return (
                        <div
                          key={accessory}
                          className="modal-accessory-item"
                        >
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

                <button
                  className="modal-book-button"
                  onClick={() => {
                    alert(`Booking for ${selectedItem.name}`);
                  }}
                >
                  Book Now
                </button>
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
    </div>
  );
};
export default RoomDetails;