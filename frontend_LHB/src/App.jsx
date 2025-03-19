import React from 'react';
import { Routes, Route } from 'react-router-dom';
import LoginPage from './pages/Login';
import CreateUser from './pages/create_user';
import RequestBooking from './pages/request_booking';
import ViewBookings from './pages/view_bookings';

function App() {
  return (
    <Routes>
      <Route path="/" element={<LoginPage onLogin={(email) => console.log('Logged in:', email)} />} />
      <Route path="/create-user" element={<CreateUser />} />
      <Route path="/request-booking" element={<RequestBooking />} />
      <Route path="/view-bookings" element={<ViewBookings />} />
    </Routes>
  );
}

export default App;