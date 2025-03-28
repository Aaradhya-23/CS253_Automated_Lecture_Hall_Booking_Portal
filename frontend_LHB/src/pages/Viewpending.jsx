import React, { useState, useEffect } from 'react';
import './Viewpending.css'; // Import the CSS file
import api from '../api/api';
import { ACCESS_TOKEN } from '../api/constants';

const Viewpending = () => {
    const [pendingBookings, setPendingBookings] = useState([]);
    const [rejectionRemarks, setRejectionRemarks] = useState({});
    const token = localStorage.getItem(ACCESS_TOKEN); 

    const transformBookings = (bookings) => {
        return bookings.map((booking) => ({
            id: booking.id,
            time: `${booking.start_time}–${booking.end_time}`,
            duration: `(${booking.duration}h)`,
            room: booking.room_details.name,
            user: booking.creator.username,
            course: booking.title,
            requestedDay: new Date(booking.requested_on).toLocaleDateString("en-US", { weekday: "long" }),
            requestedDate: new Date(booking.requested_on).toLocaleDateString("en-US"),
            requestedTime: booking.requested_on.split("T")[1].split("+")[0],
        }));
    };

    useEffect(() => {
        const requestBooking = async () => {
            try {
                const response = await api.get(
                    `${import.meta.env.VITE_BOOKING_SEARCH_URL}?status=pending`,
                    {
                        headers: {
                            Authorization: `Bearer ${token}`,
                            "Content-Type": "application/json",
                            Accept: "application/json",
                        },
                    }
                );
                const transformedData = transformBookings(response.data);
                setPendingBookings(transformedData);
                console.log("Transformed Booking Data:", transformedData);
            } catch (error) {
                console.error("Error fetching booking data:", error);
            }
        };

        if (token) {
            requestBooking();
        }
    }, [token]);

    // Handler for rejecting a booking
    const handleReject = (bookingId) => {
        setRejectionRemarks(prev => ({
            ...prev,
            [bookingId]: true
        }));
    };

    // Handler for submitting rejection remarks
    const handleSubmitRejection = async (bookingId) => {
        const remarks = rejectionRemarks[bookingId] || '';

        if (!remarks.trim()) {
            alert("Please enter rejection remarks.");
            return;
        }

        try {
            await api.post(
                `${import.meta.env.VITE_API_BASE_URL}bookings/send-rejected-mail/${bookingId}/`,
                { remark: remarks },
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                        "Content-Type": "application/json",
                        Accept: "application/json",
                    },
                }
            );
            console.log(`Rejection email sent for booking ${bookingId}.`);

            alert("Booking rejected, email sent.");

            // Hide input field after successful submission
            setRejectionRemarks(prev => ({
                ...prev,
                [bookingId]: false
            }));

        } catch (error) {
            console.error("Error processing rejection:", error);
            alert("Error rejecting booking. Please try again.");
        }
    };

    return (
        <div className="pending-bookings-main">
            <h2>Pending Bookings</h2>
            <div>
                {pendingBookings.map((booking) => (
                    <div key={booking.id} className="pending-booking-item">
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
