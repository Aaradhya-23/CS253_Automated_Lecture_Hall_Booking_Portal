import React, { useState } from 'react';
import { useEffect } from 'react';
// import { useNavigate } from 'react-router-dom';
import { Projector, Computer, Speaker, Presentation, Mic } from 'lucide-react';
import './RoomDetails.css';
import { assets } from '../assets/assets';
import { ACCESS_TOKEN } from '../api/constants';
import api from '../api/api';

// const transformRoomData = (room) => ({
//   id: `L${room.id}`,  // Prefix 'L' before the ID
//   name: `Lecture Hall ${room.name}`, // Add 'Lecture Hall' prefix
//   capacity: room.capacity, // Keep capacity as it is
//   image: assets[`L${room.id}`], // Map image dynamically
//   accessories: Object.keys(room.accessories).filter(acc => room.accessories[acc]), // Extract only true accessories
// });

// useEffect(() => {
//   const fetchRooms = async () => {
//     console.log("here")
//     if (!token) {
//       console.log("here")
//       console.error("No token found. User is not authenticated.");
//       return;
//     }
//     console.log(token)
//     try {
//       console.log("here")
//       const response = await api.get(import.meta.env.VITE_ROOM_LIST_CREATE_URL, {
//         headers: {
//           Authorization: `Bearer ${token}`,
//         }
//       });
//       console.log("here")
//       const rooms = response.data.rooms.map(transformRoomData);
//       console.log("here")
//       setLectureHallData(rooms.filter(room => room.type === 'Lecture Hall'));
//       setTutorialBlockData(rooms.filter(room => room.type === 'Tutorial Block'));
//     } catch (error) { 
//       console.error("Error fetching rooms:", error.response?.data?.detail || error.message);
//     }
//   };

const accessoryIcons = {
  'Projector': Projector,
  'Computer': Computer,
  'Microphone': Mic,
  'Speaker System': Speaker,
  'Whiteboard': Presentation
};

// const lectureHallData = [
//   {
//     id: 'L1',
//     name: 'Lecture Hall L1',
//     capacity: 250,
//     image: assets.L1,
//     accessories: ['Projector', 'Microphone', 'Whiteboard']
//   },
//   {
//     id: 'L2',
//     name: 'Lecture Hall L2',
//     capacity: 100,
//     image: assets.L2,
//     accessories: ['Computer', 'Speaker System']
//   },
//   {
//     id: 'L3',
//     name: 'Lecture Hall L3',
//     capacity: 100,
//     image: assets.L3,
//     accessories: ['Projector', 'Whiteboard']
//   },
//   {
//     id: 'L4',
//     name: 'Lecture Hall L4',
//     capacity: 100,
//     image: assets.L4,
//     accessories: ['Microphone', 'Computer']
//   },
//   {
//     id: 'L5',
//     name: 'Lecture Hall L5',
//     capacity: 100,
//     image: assets.L5,
//     accessories: ['Speaker System', 'Projector']
//   },
//   {
//     id: 'L6',
//     name: 'Lecture Hall L6',
//     capacity: 400,
//     image: assets.L6,
//     accessories: ['Projector', 'Microphone', 'Computer']
//   },
//   {
//     id: 'L7',
//     name: 'Lecture Hall L7',
//     capacity: 400,
//     image: assets.L7,
//     accessories: ['Whiteboard', 'Speaker System']
//   },
//   {
//     id: 'L8',
//     name: 'Lecture Hall L8',
//     capacity: 400,
//     image: assets.L8,
//     accessories: ['Projector', 'Computer']
//   },
//   {
//     id: 'L9',
//     name: 'Lecture Hall L9',
//     capacity: 400,
//     image: assets.L9,
//     accessories: ['Microphone', 'Whiteboard']
//   }
// ];

// const tutorialBlockData = [
//   {
//     id: 'T1',
//     name: 'Tutorial Block 1',
//     capacity: 50,
//     image: assets.TB1,
//     accessories: ['Whiteboard']
//   },
//   {
//     id: 'T2',
//     name: 'Tutorial Block 2',
//     capacity: 50,
//     image: assets.TB2,
//     accessories: ['Computer']
//   },
//   {
//     id: 'T3',
//     name: 'Tutorial Block 3',
//     capacity: 50,
//     image: assets.TB3,
//     accessories: ['Projector']
//   },
//   {
//     id: 'T4',
//     name: 'Tutorial Block 4',
//     capacity: 50,
//     image: assets.TB4,
//     accessories: ['Microphone']
//   },
//   {
//     id: 'T5',
//     name: 'Tutorial Block 5',
//     capacity: 50,
//     image: assets.TB5,
//     accessories: ['Speaker System']
//   }
// ];

const RoomDetails = () => {
  const [lectureHallData, setLectureHallData] = useState([]);
  const [tutorialBlockData, setTutorialBlockData] = useState([]);
  const [activeTab, setActiveTab] = useState("Lecture Halls");
  const [selectedItem, setSelectedItem] = useState(null);

  const token = localStorage.getItem(ACCESS_TOKEN); // Get token once

  const transformRoomData = (room) => ({
    id: room.room_type === "lecture_hall" ? `L${room.id}` : `TB${room.id}`,
    name: room.room_type === "lecture_hall" ? `Lecture Hall ${room.name}` : `Tutorial Block ${room.name}`,
    capacity: room.capacity,
    image: assets[room.room_type === "lecture_hall" ? `L${room.id}` : `TB${room.id}`] || assets.defaultImage,
    accessories: Object.keys(room.accessories).filter(acc => room.accessories[acc]),
  });

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
                  const AccessoryIcon = accessoryIcons[accessory];
                  return (
                    <AccessoryIcon 
                      key={accessory}
                      className="room-card-accessory-icon"
                      size={20}
                      title={accessory}
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
                      const AccessoryIcon = accessoryIcons[accessory];
                      return (
                        <div 
                          key={accessory} 
                          className="modal-accessory-item"
                        >
                          <AccessoryIcon 
                            className="modal-accessory-icon" 
                            size={30} 
                            title={accessory}
                          />
                          <span className="modal-accessory-label">
                            {accessory}
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