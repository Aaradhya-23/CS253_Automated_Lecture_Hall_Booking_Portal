import React, { useState } from 'react'
import './Viewpending.css' // Import the CSS file

const Viewpending = () => {
    // Combine bookings with requested dates
    const pendingBookings = [
        { 
            id: 1, 
            time: '9:30 AM–11:00 AM', 
            duration: '(1h 30m)', 
            room: 'L-20',
            user: 'Eclub',
            course: 'Intro to Signal Processing',
            requestedDay: 'Monday', 
            requestedDate: '12/07/2021', 
            requestedTime: '10:00 AM'
        },
        { 
            id: 2, 
            time: '7:00 PM–8:00 PM', 
            duration: '(1h)', 
            room: 'L-7',
            user: 'Prof. Sandeep Shukla',
            course: 'CS202',
            requestedDay: 'Tuesday', 
            requestedDate: '13/07/2021', 
            requestedTime: '11:00 AM'
        },
        { 
            id: 3, 
            time: '2:00 AM–4:00 AM', 
            duration: '(2 h)', 
            room: 'L-18',
            user: 'Prof. DB Roy',
            course: 'Computer Hardware',
            requestedDay: 'Wednesday', 
            requestedDate: '14/07/2021', 
            requestedTime: '12:00 PM'
        },
    ];

    // State to manage rejection remarks
    const [rejectionRemarks, setRejectionRemarks] = useState({});

    // Handler for approving a booking
    const handleApprove = (bookingId) => {
        // TODO: Implement backend approval logic
        console.log(`Booking ${bookingId} approved`);
    };

    // Handler for rejecting a booking
    const handleReject = (bookingId) => {
        // Open remarks input for this specific booking
        setRejectionRemarks(prev => ({
            ...prev,
            [bookingId]: true
        }));
    };

    // Handler for submitting rejection remarks
    const handleSubmitRejection = (bookingId) => {
        const remarks = rejectionRemarks[bookingId] || '';
        
        // TODO: Send rejection to backend with remarks
        console.log(`Booking ${bookingId} rejected with remarks: ${remarks}`);

        // Close the remarks input
        setRejectionRemarks(prev => ({
            ...prev,
            [bookingId]: false
        }));
    };

    return (
        <div className="pending-bookings-main">
            <h2>Pending Bookings</h2>
            <div>
                {pendingBookings.map((booking) => (
                    <div 
                        key={booking.id} 
                        className="pending-booking-item"
                    >
                        <div className="pending-booking-content">
                            <div className="pending-booking-details">
                                <div className="pending-booking-course">{booking.course}</div>
                                <div className="pending-booking-info">User: {booking.user}</div>
                                <div className="pending-booking-info">Room: {booking.room}</div>
                                <div className="pending-booking-info">Time: {booking.time} {booking.duration}</div>
                                <div className="pending-booking-requested">
                                    Requested on: {booking.requestedDay}, {booking.requestedDate} at {booking.requestedTime}
                                </div>
                            </div>
                            <div className="pending-booking-actions">
                                <button 
                                    onClick={() => handleApprove(booking.id)}
                                    className="pending-action-btn pending-approve-btn"
                                    title="Approve"
                                >
                                    ✓
                                </button>
                                <button 
                                    onClick={() => handleReject(booking.id)}
                                    className="pending-action-btn pending-reject-btn"
                                    title="Reject"
                                >
                                    ✗
                                </button>
                            </div>
                        </div>

                        {/* Rejection Remarks Input */}
                        {rejectionRemarks[booking.id] && (
                            <div className="pending-rejection-section">
                                <input 
                                    type="text"
                                    placeholder="Enter rejection remarks"
                                    className="pending-rejection-input"
                                    value={rejectionRemarks[booking.id] || ''}
                                    onChange={(e) => setRejectionRemarks(prev => ({
                                        ...prev,
                                        [booking.id]: e.target.value
                                    }))}
                                />
                                <button 
                                    onClick={() => handleSubmitRejection(booking.id)}
                                    className="pending-rejection-submit"
                                >
                                    Submit Remarks
                                </button>
                            </div>
                        )}
                    </div>
                ))}
            </div>
        </div>
    );
};

export default Viewpending;