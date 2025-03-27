// TODO: Backend Integration Comments:

// 1. State Management:
// - Add useState hooks to manage form state for all booking details
// - Example: const [formData, setFormData] = useState({ hall: '', date: '', startTime: '', endTime: '', purpose: '', additionalEquipment: '' })

// 2. API Integration Points:
// - Import axios: import axios from 'axios'
// - Create API service file at: src/services/api.js with all endpoint definitions
// - Base API URL should be configurable via environment variable

// 3. Required API Endpoints:
// - GET /api/halls - Fetch available lecture halls
// - GET /api/halls/{hallId}/availability?date={date} - Check hall availability for specific date
// - POST /api/bookings - Submit a new booking request
// - GET /api/user/profile - Get user details for pre-filling the form

// 4. Form Submission:
// - Create handleSubmit function to:
//   a) Validate all required fields
//   b) Format data in the structure expected by backend
//   c) Make POST request to /api/bookings
//   d) Handle success/error responses
//   e) Show appropriate user feedback

// 5. Form Validation:
// - Add client-side validation before submission
// - Check for required fields, date/time format, conflicts
// - Show validation errors next to respective fields

// 6. Loading States:
// - Add loading states for initial data fetch
// - Show spinner during form submission
// - Disable submit button while processing

// 7. Error Handling:
// - Try/catch blocks around all API calls
// - Display user-friendly error messages
// - Log detailed errors for debugging

// 8. Success Handling:
// - Redirect to status page after successful booking
// - Or show success message with booking ID
// - Provide option to create another booking

// 9. Authentication:
// - Include authentication headers in all API requests
// - Check user permissions before allowing submission
// - Redirect to login if auth token is expired

// import React, { useState } from 'react';
// import './Request_Booking.css';

// const Request_Booking = () => {
//   // State for form fields
//   const [purpose, setPurpose] = useState('');
//   const [startDate, setStartDate] = useState('');
//   const [startTime, setStartTime] = useState('8:00 AM');
//   const [endDate, setEndDate] = useState('');
//   const [endTime, setEndTime] = useState('8:30 AM');
//   const [repeatOption, setRepeatOption] = useState('Does Not Repeat');
//   const [selectedHall, setSelectedHall] = useState('LH18');
//   const [capacity, setCapacity] = useState('');
//   const [accessories, setAccessories] = useState([]);
  
//   // Time options for dropdowns
//   const timeOptions = [
//     '8:00 AM', '8:30 AM', '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM',
//     '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM',
//     '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM',
//     '5:00 PM', '5:30 PM', '6:00 PM'
//   ];

//   // Repeat options
//   const repeatOptions = [
//     'Does Not Repeat', 'Daily', 'Weekly', 'Monthly'
//   ];

//   // Hall options
//   const hallOptions = ['LH18', 'LH19', 'LH20', 'LH21'];

//   // Capacity options
//   const capacityOptions = [
//     '30', '50', '100', '150', '200'
//   ];

//   // Accessories options
//   const accessoryOptions = [
//     'Projector', 'Microphone', 'Whiteboard', 'Computer', 'Speaker System'
//   ];

//   // Calculate duration between start and end time
//   const calculateDuration = () => {
//     if (!startTime || !endTime) return '';
    
//     // Simple calculation for demo purposes
//     return '30 minutes';
//   };

//   // Handle form submission
//   const handleSubmit = (e) => {
//     e.preventDefault();
//     alert('Booking submitted!');
//     // In a real application, you would send this data to your backend
//   };

//   // Handle add hall
//   const handleAddHall = () => {
//     alert('Feature to add another hall would be implemented here');
//   };

//   // Handle add accessory
//   const handleAddAccessory = () => {
//     alert('Feature to add accessories would be implemented here');
//   };

//   return (
//     <div className="main-content-wrapper">
//       <div className="booking-form-container">
//         <form className="booking-form" onSubmit={handleSubmit}>
//           <div className="form-group">
//             <label htmlFor="purpose">Purpose</label>
//             <input 
//               type="text" 
//               id="purpose" 
//               value={purpose} 
//               onChange={(e) => setPurpose(e.target.value)} 
//               placeholder="Linux Session Y-24"
//               className="form-control"
//             />
//           </div>

//           <div className="form-group">
//             <label htmlFor="user">user</label>
//             <input 
//               type="text" 
//               id="user" 
//               value="Pclub IITK" 
//               readOnly 
//               className="form-control"
//             />
//           </div>

//           <div className="form-row">
//             <div className="form-column">
//               <label>Begin</label>
//               <div className="date-time-controls">
//                 <input 
//                   type="date" 
//                   value={startDate} 
//                   onChange={(e) => setStartDate(e.target.value)} 
//                   className="date-input"
//                   placeholder="dd-mm-yyyy"
//                 />
//                 <select 
//                   value={startTime} 
//                   onChange={(e) => setStartTime(e.target.value)}
//                   className="time-select"
//                 >
//                   {timeOptions.map(time => (
//                     <option key={`start-${time}`} value={time}>{time}</option>
//                   ))}
//                 </select>
//               </div>
//             </div>

//             <div className="form-column">
//               <label>End</label>
//               <div className="date-time-controls">
//                 <input 
//                   type="date" 
//                   value={endDate} 
//                   onChange={(e) => setEndDate(e.target.value)} 
//                   className="date-input"
//                   placeholder="dd-mm-yyyy"
//                 />
//                 <select 
//                   value={endTime} 
//                   onChange={(e) => setEndTime(e.target.value)}
//                   className="time-select"
//                 >
//                   {timeOptions.map(time => (
//                     <option key={`end-${time}`} value={time}>{time}</option>
//                   ))}
//                 </select>
//               </div>
//             </div>

//             <div className="duration-indicator">
//               {calculateDuration()}
//             </div>

//             <div className="availability-indicator">
//               Available
//             </div>
//           </div>

//           <div className="form-group">
//             <label>Repeat</label>
//             <select 
//               value={repeatOption} 
//               onChange={(e) => setRepeatOption(e.target.value)}
//               className="form-control"
//             >
//               {repeatOptions.map(option => (
//                 <option key={option} value={option}>{option}</option>
//               ))}
//             </select>
//           </div>

//           <div className="form-group">
//             <div className="section-header">
//               <label>Lecture Hall</label>
//               <span className="badge">1</span>
//               <button 
//                 type="button" 
//                 className="add-btn"
//                 onClick={handleAddHall}
//               >
//                 Add <span className="circle-icon">⊕</span>
//               </button>
//             </div>
//             <div className="hall-selection">
//               <div className="selected-hall">
//                 {selectedHall} <span className="info-icon">ⓘ</span>
//               </div>
//             </div>
//           </div>

//           <div className="form-group">
//             <div className="section-header">
//               <label>Capacity</label>
//               <span className="badge">0</span>
//             </div>
//             <select 
//               value={capacity} 
//               onChange={(e) => setCapacity(e.target.value)}
//               className="form-control"
//             >
//               <option value="">Select capacity</option>
//               {capacityOptions.map(option => (
//                 <option key={option} value={option}>{option}</option>
//               ))}
//             </select>
//           </div>

//           <div className="form-group">
//             <div className="section-header">
//               <label>Accessories</label>
//               <span className="badge">0</span>
//               <button 
//                 type="button" 
//                 className="add-btn"
//                 onClick={handleAddAccessory}
//               >
//                 Add <span className="circle-icon">⊕</span>
//               </button>
//             </div>
//           </div>

//           <div className="form-actions">
//             <button type="submit" className="submit-btn">SUBMIT</button>
//           </div>
//         </form>
//       </div>
//     </div>
//   );
// };

// export default Request_Booking;



import React, { useState, useEffect } from 'react';
import './AdminCreateBooking.css';

const AdminCreateBooking = () => {
  // State for form fields
  const [purpose, setPurpose] = useState('');
  const [startDate, setStartDate] = useState('');
  const [startTime, setStartTime] = useState('8:00 AM');
  const [endDate, setEndDate] = useState('');
  const [endTime, setEndTime] = useState('8:30 AM');
  const [repeatOption, setRepeatOption] = useState('Does Not Repeat');
  const [capacity, setCapacity] = useState('');
  const [accessories, setAccessories] = useState([]);
  
  // New state for available halls
  const [availableHalls, setAvailableHalls] = useState([]);
  const [selectedHall, setSelectedHall] = useState('');

  // Sample halls data
  const sampleHalls = [
    { 
      id: 'LH18', 
      capacity: 30, 
      accessories: ['Projector', 'Whiteboard'],
      description: 'Small lecture hall with basic equipment'
    },
    { 
      id: 'LH19', 
      capacity: 50, 
      accessories: ['Computer', 'Microphone'],
      description: 'Medium-sized hall with advanced audio setup'
    },
    { 
      id: 'LH20', 
      capacity: 100, 
      accessories: ['Projector', 'Speaker System', 'Computer'],
      description: 'Large lecture hall with comprehensive equipment'
    },
    { 
      id: 'LH21', 
      capacity: 200, 
      accessories: ['Projector', 'Microphone', 'Computer', 'Whiteboard'],
      description: 'Auditorium-style hall with full multimedia support'
    }
  ];

  // Time options for dropdowns
  const timeOptions = [
    '8:00 AM', '8:30 AM', '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM',
    '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM',
    '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM',
    '5:00 PM', '5:30 PM', '6:00 PM'
  ];

  // Repeat options
  const repeatOptions = [
    'Does Not Repeat', 'Daily', 'Weekly', 'Monthly'
  ];

  // Capacity options
  const capacityOptions = ['30', '50', '100', '150', '200'];

  // Accessories options
  const accessoryOptions = [
    'Projector', 'Microphone', 'Whiteboard', 'Computer', 'Speaker System'
  ];

  // Check hall availability based on user criteria
  useEffect(() => {
    // Only check availability if all key criteria are filled
    if (capacity && startDate && startTime && endTime) {
      const filteredHalls = sampleHalls.filter(hall => {
        // Check capacity requirement
        const meetsCapacity = parseInt(capacity) <= hall.capacity;

        // Check if selected accessories are available
        const hasRequiredAccessories = accessories.every(acc => 
          hall.accessories.includes(acc)
        );

        return meetsCapacity && hasRequiredAccessories;
      });

      setAvailableHalls(filteredHalls);
      
      // Reset selected hall if it's no longer available
      if (selectedHall && !filteredHalls.some(hall => hall.id === selectedHall)) {
        setSelectedHall('');
      }
    } else {
      setAvailableHalls([]);
    }
  }, [capacity, startDate, startTime, endTime, accessories]);

  // Handle accessory selection
  const toggleAccessory = (accessory) => {
    setAccessories(prev => 
      prev.includes(accessory)
        ? prev.filter(a => a !== accessory)
        : [...prev, accessory]
    );
  };

  // Handle form submission
  const handleSubmit = (e) => {
    e.preventDefault();
    
    // Validate that a hall is selected
    if (!selectedHall) {
      alert('Please select a lecture hall');
      return;
    }

    // Collect all booking details
    const bookingDetails = {
      purpose,
      startDate,
      startTime,
      endDate,
      endTime,
      repeatOption,
      hall: selectedHall,
      capacity,
      accessories
    };

    console.log('Booking Details:', bookingDetails);
    alert('Booking submitted!');
  };

  return (
    <div className="main-content-wrapper">
      <div className="booking-form-container">
        <form className="booking-form" onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="purpose">Purpose</label>
            <input 
              type="text" 
              id="purpose" 
              value={purpose} 
              onChange={(e) => setPurpose(e.target.value)} 
              placeholder="Linux Session Y-24"
              className="form-control"
            />
          </div>

          <div className="form-row">
            <div className="form-column">
              <label>Begin</label>
              <div className="date-time-controls">
                <input 
                  type="date" 
                  value={startDate} 
                  onChange={(e) => setStartDate(e.target.value)} 
                  className="date-input"
                  placeholder="dd-mm-yyyy"
                />
                <select 
                  value={startTime} 
                  onChange={(e) => setStartTime(e.target.value)}
                  className="time-select"
                >
                  {timeOptions.map(time => (
                    <option key={`start-${time}`} value={time}>{time}</option>
                  ))}
                </select>
              </div>
            </div>

            <div className="form-column">
              <label>End</label>
              <div className="date-time-controls">
                <input 
                  type="date" 
                  value={endDate} 
                  onChange={(e) => setEndDate(e.target.value)} 
                  className="date-input"
                  placeholder="dd-mm-yyyy"
                />
                <select 
                  value={endTime} 
                  onChange={(e) => setEndTime(e.target.value)}
                  className="time-select"
                >
                  {timeOptions.map(time => (
                    <option key={`end-${time}`} value={time}>{time}</option>
                  ))}
                </select>
              </div>
            </div>
          </div>

          <div className="form-group">
            <label>Repeat</label>
            <select 
              value={repeatOption} 
              onChange={(e) => setRepeatOption(e.target.value)}
              className="form-control"
            >
              {repeatOptions.map(option => (
                <option key={option} value={option}>{option}</option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <label>Capacity</label>
            <select 
              value={capacity} 
              onChange={(e) => setCapacity(e.target.value)}
              className="form-control"
            >
              <option value="">Select capacity</option>
              {capacityOptions.map(option => (
                <option key={option} value={option}>{option}</option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <label>Accessories</label>
            <div className="accessories-grid">
              {accessoryOptions.map(accessory => (
                <button
                  key={accessory}
                  type="button"
                  className={`accessory-btn ${accessories.includes(accessory) ? 'selected' : ''}`}
                  onClick={() => toggleAccessory(accessory)}
                >
                  {accessory}
                </button>
              ))}
            </div>
          </div>

          {/* Available Halls Section */}
          {capacity && (
            <div className="form-group">
              <label>Available Lecture Halls</label>
              {availableHalls.length > 0 ? (
                <div className="halls-grid">
                  {availableHalls.map(hall => (
                    <div 
                      key={hall.id} 
                      className={`hall-card ${selectedHall === hall.id ? 'selected' : ''}`}
                      onClick={() => setSelectedHall(hall.id)}
                    >
                      <div className="hall-header">{hall.id}</div>
                      <div className="hall-details">
                        <p>Capacity: {hall.capacity}</p>
                        <p>Accessories: {hall.accessories.join(', ')}</p>
                        <p className="hall-description">{hall.description}</p>
                      </div>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="no-halls-available">
                  No lecture halls available matching your criteria.
                </div>
              )}
            </div>
          )}

          <div className="form-actions">
            <button 
              type="submit" 
              className="submit-btn"
              disabled={!selectedHall}
            >
              SUBMIT
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AdminCreateBooking;





//this has to be edited later we'll give admin some extra features and direct booking