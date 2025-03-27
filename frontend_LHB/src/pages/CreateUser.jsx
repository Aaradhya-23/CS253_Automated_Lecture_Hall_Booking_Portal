import React, { useState } from 'react';
import axios from 'axios';
import './CreateUser.css';
import api from '../api/api';

const CreateUser = () => {
  const [formData, setFormData] = useState({
    username: '',
    password: '',
    email: '',
    // remarks: '',
    // category: '',
    role: '',
    authority_email: '', // Updated to store a single verifying authority
  });
  const [newAuthorityEmail, setNewAuthorityEmail] = useState('');

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  // const handleAddAuthorityEmail = () => {
  //   if (newAuthorityEmail && validateEmail(newAuthorityEmail)) {
  //     setFormData((prevState) => ({
  //       ...prevState,
  //       authority_email: newAuthorityEmail, // Update authority_email instead of authorities
  //     }));
  //     setNewAuthorityEmail(''); // Clear the input field after adding the email
  //   } else {
  //     alert('Please enter a valid email address.');
  //   }
  // };

  const handleSubmit = (e) => {
    e.preventDefault();

    const token = localStorage.getItem('ACCESS_TOKEN'); // Retrieve the token from localStorage
    console.log(token)
    console.log(formData)
    api
      .post(
        import.meta.env.VITE_USER_LIST_CREATE_URL,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`, // Include the token in the Authorization header
            'Content-Type': 'application/json', // Specify the content type as JSON
            Accept: 'application/json', // Specify that the response should be in JSON format
          },
        }
      )
      .then((response) => {
        console.log('User created successfully:', response.data);
        alert('User created successfully!');
        // Clear the form after successful submission
        setFormData({
          username: '',
          password: '',
          email: '',
          remarks: '',
          category: '',
          authority_email: '',
        });
      })
      .catch((error) => {
        console.error('Error creating user:', error);
        alert('Error creating user. Please try again.');
      });
  };

  return (
    <div className="create-user-container">
      <div className="create-user-header">
        <h2>Create New User</h2>
      </div>

      <form onSubmit={handleSubmit} className="create-user-form">
        <div className="form-row">
          <div className="form-group">
            <label htmlFor="username">User ID :</label>
            <input
              type="text"
              id="username"
              name="username"
              value={formData.username}
              onChange={handleChange}
              required
            />
          </div>

          <div className="form-group remarks">
            <label htmlFor="remarks">Remarks :</label>
            <input
              type="text"
              id="remarks"
              name="remarks"
              value={formData.remarks}
              onChange={handleChange}
            />
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="password">Password :</label>
          <input
            type="password"
            id="password"
            name="password"
            value={formData.password}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="email">E-mail :</label>
          <input
            type="email"
            id="email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-row categories-row">
          <div className="form-group category-group">
            <label className="required-label"> User Type </label>
            <div className="radio-options">
              <div className="radio-option">
                <input
                  type="radio"
                  id="admin"
                  name="role"
                  value="admin"
                  checked={formData.role === 'admin'} // Compare with lowercase 'admin'
                  onChange={handleChange}
                  required
                />
                <label htmlFor="admin">Admin</label>
              </div>

              <div className="radio-option">
                <input
                  type="radio"
                  id="faculty"
                  name="role"
                  value="faculty"
                  checked={formData.role === 'faculty'} // Compare with lowercase 'faculty'
                  onChange={handleChange}
                />
                <label htmlFor="faculty">Faculty</label>
              </div>

              <div className="radio-option">
                <input
                  type="radio"
                  id="Student"
                  name="role"
                  value="Student"
                  checked={formData.role === 'Student'} // Compare with lowercase 'Student'
                  onChange={handleChange}
                />
                <label htmlFor="Student">Student</label>
              </div>
            </div>
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="newAuthorityEmail">Verifying Authority Email:</label>
          <input
            type="email"
            id="authority_email"
            name="authority_email"
            value={formData.authority_email}
            onChange={handleChange}  // Handle the change in state
            placeholder="Enter authority email"
          />
          {/* <button
            type="button"
            className="add-authority-button"
            onClick={handleAddAuthorityEmail}
          >
            Add Verifying Authority
          </button> */}
        </div>

        <div className="form-actions">
          <button type="submit" className="confirm-button">
            Confirm
          </button>
        </div>
      </form>
    </div>
  );
};

export default CreateUser;