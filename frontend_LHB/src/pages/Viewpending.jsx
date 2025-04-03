import React, { useState, useEffect } from 'react';
import './Viewpending.css'; // Import the CSS file
import api from '../api/api';
import { ACCESS_TOKEN } from '../api/constants';
const Viewpending = () => {
    const [pendingBookings, setPendingBookings] = useState([]);
    const [rejectionRemarksVisible, setRejectionRemarksVisible] = useState({});
    const [rejectionRemarksContent, setRejectionRemarksContent] = useState({});
    const token = localStorage.getItem(ACCESS_TOKEN);
    const transformBookings = (bookings) => {
        return bookings.map((booking) => ({
            id: booking.id,
            time: `${booking.start_time}-${booking.end_time}`,
            duration: `(${booking.duration}h)`,
            room: booking.room_details.name,
            user: booking.creator.username,
            course: booking.title,
            date: booking.booking_date,
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
    const handleReject = (bookingId) => {
        setRejectionRemarksVisible(prev => ({
            ...prev,
            [bookingId]: true
        }));
    };
    const handleSubmitRejection = async (bookingId) => {
        const remarks = rejectionRemarksContent[bookingId] || '';
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
            setRejectionRemarksVisible(prev => ({
                ...prev,
                [bookingId]: false
            }));

            setRejectionRemarksContent(prev => ({
                ...prev,
                [bookingId]: ''
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

                        <div className="pending-booking-grid">
                            <div className="pending-booking-header">User</div>
                            <div className="pending-booking-header">Room</div>
                            <div className="pending-booking-header">Date of booking</div>
                            <div className="pending-booking-header">Time</div>

                            <div className="pending-booking-value">{booking.user}</div>
                            <div className="pending-booking-value">{booking.room}</div>
                            <div className="pending-booking-value">{booking.date}</div>
                            <div className="pending-booking-value">{booking.time} {booking.duration}</div>
                        </div>

                        <div className="pending-booking-requested">
                            Requested on: {booking.requestedDay}, {booking.requestedDate} at {booking.requestedTime}
                        </div>
                    </div>
                            <div className="pending-booking-actions">
                                <button
                                    onClick={() => handleReject(booking.id)}
                                    className="pending-action-btn pending-reject-btn"
                                    title="Reject"
                                >
                                    ✗
                                </button>
                            </div>
                        </div>
                        {/* Rejection Remarks Input - Changed to use rejectionRemarksVisible */}
                        {rejectionRemarksVisible[booking.id] && (
                            <div className="pending-rejection-section">
                                <input
                                    type="text"
                                    placeholder="Enter rejection remarks"
                                    className="pending-rejection-input"
                                    value={rejectionRemarksContent[booking.id] || ''}
                                    onChange={(e) => setRejectionRemarksContent(prev => ({
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