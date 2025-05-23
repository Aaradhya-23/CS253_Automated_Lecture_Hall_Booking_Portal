import React, { useState, useEffect } from 'react';
import './CreateUser.css';
import api from '../api/api';
import { ACCESS_TOKEN } from '../api/constants';

const CreateUser = () => {
  const [formData, setFormData] = useState({
    username: '',
    password: '',
    email: '',
    role: '',
    authorities: [], // Unified list of existing and new authorities
  });

  const [newAuthority, setNewAuthority] = useState({ name: '', email: '' });
  const [existingAuthorities, setExistingAuthorities] = useState(null);
  const [loading, setLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    const fetchAuthorities = async () => {
      const token = localStorage.getItem(ACCESS_TOKEN);
      if (!token) {
        console.error('No ACCESS_TOKEN found in localStorage.');
        setErrorMessage('User not authenticated. Please log in.');
        return;
      }

      setLoading(true);
      setErrorMessage('');

      try {
        const response = await api.get(import.meta.env.VITE_AUTHORITY_LIST_URL, {
          headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
        });

        console.log('Fetched Authorities:', response.data);
        setExistingAuthorities(response.data);
      } catch (err) {
        console.error('Error fetching Authorities:', err.response?.data || err.message);
        setErrorMessage('Failed to load Authorities.');
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

  const validateForm = () => {
    if (!formData.username || !formData.password || !formData.email || !formData.role) {
      setErrorMessage('Please fill in all required fields');
      return false;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(formData.email)) {
      setErrorMessage('Please enter a valid email address');
      return false;
    }

    return true;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    setErrorMessage('');
    if (!validateForm()) return;

    setIsSubmitting(true);

    const token = localStorage.getItem(ACCESS_TOKEN);
    const payload = {
      username: formData.username,
      email: formData.email,
      role: formData.role,
      password: formData.password,
      authorities: formData.authorities.map((auth) => auth.id),
    };

    try {
      await api.post(import.meta.env.VITE_USER_LIST_CREATE_URL, payload, {
        headers: {
          Authorization: `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      });
      alert('User created successfully!');
      setFormData({
        username: '',
        password: '',
        email: '',
        role: '',
        authorities: [],
      });
    } catch (error) {
      console.error('Error creating user:', error.response?.data || error.message);
      setErrorMessage('Error creating user. Please try again.');
    } finally {
      setIsSubmitting(false);
    }
  };

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
        </div>

        <div className="form-row">
          <div className="form-group">
            <label htmlFor="password">Password :</label>
            <input
              type="password"
              id="password"
              name="password"
              value={formData.password}
              onChange={handleChange}
              required
              autoComplete="new-password"
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
              autoComplete="email"
            />
          </div>
        </div>

        <div className="form-row">
          <div className="form-group">
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

        <div className="form-row">
          <div className="form-group">
            <label htmlFor="authority_email">Verifying Authority Email</label>
            <input
              type="email"
              id="authority_email"
              name="authority_email"
              value={formData.authority_email}
              onChange={handleChange}
              className="form-control"
              placeholder="Enter authority email"
            />
          </div>
        </div>

        <div className="form-actions">
          <button type="submit" className="submit-btn" disabled={isSubmitting}>
            {isSubmitting ? 'Creating...' : 'CREATE USER'}
          </button>
        </div>
      </form>
    </div>
  );
};

export default CreateUser;