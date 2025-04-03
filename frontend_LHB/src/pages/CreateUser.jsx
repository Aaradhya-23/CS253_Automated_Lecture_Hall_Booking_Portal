import React, { useState, useEffect } from 'react';
import './CreateUser.css';
import api from '../api/api';
import { ACCESS_TOKEN } from '../api/constants';

const CreateUser = () => {
  const [formData, setFormData] = useState({
    username: "",
    password: "",
    email: "",
    role: "",
    authorities: [], // Unified list of existing and new authorities
  });

  const [newAuthority, setNewAuthority] = useState({ name: "", email: "" });
  const [existingAuthorities, setExistingAuthorities] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchAuthorities = async () => {
      const token = localStorage.getItem("ACCESS_TOKEN");
      if (!token) {
        console.error("No ACCESS_TOKEN found in localStorage.");
        setError("User not authenticated. Please log in.");
        return;
      }

      setLoading(true);
      setError(null);

      try {
        const response = await api.get(import.meta.env.VITE_AUTHORITY_LIST_URL, {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
        });

        console.log("Fetched Authorities:", response.data);
        setExistingAuthorities(response.data);
      } catch (err) {
        console.error("Error fetching Authorities:", err.response?.data || err.message);
        setError("Failed to load Authorities.");
      } finally {
        setLoading(false);
      }
    };

    fetchAuthorities();
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleExistingAuthorityChange = (selectedAuthority) => {
    setFormData((prev) => {
      const existingList = prev.authorities || [];
      const exists = existingList.some((auth) => auth.id === selectedAuthority.id);

      if (!exists) {
        return {
          ...prev,
          authorities: [...existingList, selectedAuthority],
        };
      }
      return prev;
    });
  };

  const handleRemoveAuthority = (index) => {
    setFormData((prev) => ({
      ...prev,
      authorities: prev.authorities.filter((_, i) => i !== index),
    }));
  };

  const resetForm = () => {
    setFormData({
      username: '',
      password: '',
      email: '',
      remarks: '',
      role: '',
      authority_email: '',
    });
  };

  const validateForm = () => {
    // Basic validation
    if (!formData.username || !formData.password || !formData.email || !formData.role) {
      setErrorMessage('Please fill in all required fields');
      return false;
    }
    
    // Email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(formData.email)) {
      setErrorMessage('Please enter a valid email address');
      return false;
    }
    
    // If authority email is provided, validate it too
    if (formData.authority_email && !emailRegex.test(formData.authority_email)) {
      setErrorMessage('Please enter a valid authority email address');
      return false;
    }
    
    return true;
  };

  // const handleSubmit = async (e) => {
  //   e.preventDefault();
    
  //   // Clear previous messages
  //   setSuccessMessage('');
  //   setErrorMessage('');
    
  //   // Validate form
  //   if (!validateForm()) return;
    
  //   setIsSubmitting(true);
    
  //   const token = localStorage.getItem(ACCESS_TOKEN);
    
  //   try {
  //     const response = await api.post(
  //       import.meta.env.VITE_USER_LIST_CREATE_URL,
  //       formData,
  //       {
  //         headers: {
  //           Authorization: `Bearer ${token}`,
  //           'Content-Type': 'application/json',
  //           Accept: 'application/json',
  //         },
  //       }
  //     );
      
  //     console.log('User created successfully:', response.data);
  //     setSuccessMessage('User created successfully!');
  //     resetForm();
  //   } catch (error) {
  //     console.error('Error creating user:', error);
  //     setErrorMessage(error.response?.data?.message || 'Error creating user. Please try again.');
  //   } finally {
  //     setIsSubmitting(false);
  //   }
  // }
  const moveAuthority = (index, direction) => {
    setFormData((prev) => {
      const newAuthorities = [...prev.authorities];
      const swapIndex = index + direction;
      if (swapIndex >= 0 && swapIndex < newAuthorities.length) {
        [newAuthorities[index], newAuthorities[swapIndex]] = [newAuthorities[swapIndex], newAuthorities[index]];
      }
      return { ...prev, authorities: newAuthorities };
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const token = localStorage.getItem("ACCESS_TOKEN");
    if (!token) {
      alert("User not authenticated. Please log in.");
      return;
    }
  
    const payload = {
      username: formData.username,
      email: formData.email,
      role: formData.role,
      password: formData.password,
      authorities: formData.authorities.map((auth) => auth.id), // Extract only IDs
    };
  
    try {
      await api.post(import.meta.env.VITE_USER_LIST_CREATE_URL, payload, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      });
      alert("User created successfully!");
      setFormData({
        username: "",
        password: "",
        email: "",
        role: "",
        authorities: [],
      });
    } catch (error) {
      console.error("Error creating user:", error.response?.data || error.message);
      alert("Error creating user: " + JSON.stringify(error.response?.data));
    }
    console.log("Updated payload:", payload);
  };
  useEffect(() => {
    console.log("Updated Form Data:", formData);
  }, [formData]);

  return (
    <div className="create-user-container">
      <div className="create-user-header">
        <h2>Create New User</h2>
      </div>
      <form onSubmit={handleSubmit}>
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
              autoComplete="name"
            />
          </div>
        
        
        {errorMessage && (
          <div className="error-message">
            {errorMessage}
          </div>
        )}

        <form onSubmit={handleSubmit} className="create-user-form">
          <div className="form-row">
            <div className="form-column">
              <label htmlFor="username">User ID</label>
              <input
                type="text"
                id="username"
                name="username"
                value={formData.username}
                onChange={handleChange}
                className="form-control"
                required
              />
            </div>
            <div className="form-column">
              <label htmlFor="remarks">Remarks</label>
              <input
                type="text"
                id="remarks"
                name="remarks"
                value={formData.remarks}
                onChange={handleChange}
                className="form-control"
              />
            </div>
          </div>

          <div className="form-row">
            <div className="form-column">
              <label htmlFor="password">Password</label>
              <input
                type="password"
                id="password"
                name="password"
                value={formData.password}
                onChange={handleChange}
                className="form-control"
                required
              />
            </div>
            <div className="form-column">
              <label htmlFor="email">E-mail</label>
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                className="form-control"
                required
              />
            </div>
          </div>

          <div className="form-row">
            <div className="form-column">
              <label className="required-label">User Type</label>
              <div className="radio-options">
                <div className="radio-option">
                  <input
                    type="radio"
                    id="admin"
                    name="role"
                    value="admin"
                    checked={formData.role === 'admin'}
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
                    checked={formData.role === 'faculty'}
                    onChange={handleChange}
                  />
                  <label htmlFor="faculty">Faculty</label>
                </div>

                <div className="radio-option">
                  <input
                    type="radio"
                    id="student"
                    name="role"
                    value="student"
                    checked={formData.role === 'student'}
                    onChange={handleChange}
                  />
                  <label htmlFor="student">Student</label>
                </div>
              </div>
            </div>
          </div>
          </form>
        </div>
        {/* ✅ Select Existing Authorities in Priority Order */}
        <h3>Select Authorities</h3>
        {loading ? (
          <p>Loading authorities...</p>
        ) : existingAuthorities && existingAuthorities.length > 0 ? (
          existingAuthorities.map((authority) => (
            <div key={authority.id}>
              <input
                type="checkbox"
                value={authority.id}
                checked={formData.authorities.some((auth) => auth.id === authority.id)}
                onChange={() => handleExistingAuthorityChange(authority)}
              />
              {authority.name} ({authority.email})
            </div>
          ))
        ) : (
          <p>No authorities available.</p>
        )}

        <h3>Authority Priority Order</h3>
        {formData.authorities.length > 0 ? (
          <ul>
            {formData.authorities.map((auth, index) => (
              <li key={auth.id}>
                {auth.name} ({auth.email})
                <button type="button" onClick={() => moveAuthority(index, -1)}>Up</button>
                <button type="button" onClick={() => moveAuthority(index, 1)}>Down</button>
                <button type="button" onClick={() => handleRemoveAuthority(index)}>Remove</button>
              </li>
            ))}
          </ul>
        ) : (
          <p>No authorities selected.</p>
        )}
        <button type="submit">Create User</button>

      </form>
    </div>
  );
};

export default CreateUser;