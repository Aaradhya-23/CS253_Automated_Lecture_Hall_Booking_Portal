import React, { useState, useEffect } from "react";
import "./CreateUser.css";
import { motion, AnimatePresence } from "framer-motion"; // Import Framer Motion
import api from "../api/api";
import { ACCESS_TOKEN } from "../api/constants";

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
  const [errorMessage, setErrorMessage] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    const fetchAuthorities = async () => {
      const token = localStorage.getItem(ACCESS_TOKEN);
      if (!token) {
        console.error("No ACCESS_TOKEN found in localStorage.");
        setErrorMessage("User not authenticated. Please log in.");
        return;
      }

      setLoading(true);
      setErrorMessage("");

      try {
        const response = await api.get(
          import.meta.env.VITE_AUTHORITY_LIST_URL,
          {
            headers: {
              Authorization: `Bearer ${token}`,
              "Content-Type": "application/json",
            },
          }
        );

        console.log("Fetched Authorities:", response.data);
        setExistingAuthorities(response.data);
      } catch (err) {
        console.error(
          "Error fetching Authorities:",
          err.response?.data || err.message
        );
        setErrorMessage("Failed to load Authorities.");
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
      const exists = existingList.some(
        (auth) => auth.id === selectedAuthority.id
      );

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
        [newAuthorities[index], newAuthorities[swapIndex]] = [
          newAuthorities[swapIndex],
          newAuthorities[index],
        ];
      }
      return { ...prev, authorities: newAuthorities };
    });
  };

  const validateForm = () => {
    if (
      !formData.username ||
      !formData.password ||
      !formData.email ||
      !formData.role
    ) {
      setErrorMessage("Please fill in all required fields");
      return false;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(formData.email)) {
      setErrorMessage("Please enter a valid email address");
      return false;
    }

    return true;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    setErrorMessage("");
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
      console.error(
        "Error creating user:",
        error.response?.data || error.message
      );
      setErrorMessage("Error creating user. Please try again.");
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <motion.div
      className="main-content-wrapper"
      initial={{ opacity: 0, y: 20 }} // Page load animation
      animate={{ opacity: 1, y: 0 }}
      // exit={{ opacity: 0, y: 20 }}
      transition={{ duration: 0.6 }}
    >
      <div
        className="create-user-container"
        // initial={{ opacity: 0, scale: 0.95 }}
        // animate={{ opacity: 1, scale: 1 }}
        // transition={{ duration: 0.5 }}
      >
        <div className="create-user-header">
          <h2>CREATE NEW USER </h2>
        </div>
        <form onSubmit={handleSubmit} className="create-user-form">
          <div className="form-row">
            <div className="form-column">
              <label htmlFor="username">User ID :</label>
              <input
                type="text"
                className="form-control"
                id="username"
                name="username"
                value={formData.username}
                onChange={handleChange}
                required
                autoComplete="name"
              />
            </div>

            <div className="form-column">
              <label htmlFor="password">Password :</label>
              <input
                type="password"
                className="form-control"
                id="password"
                name="password"
                value={formData.password}
                onChange={handleChange}
                required
                autoComplete="new-password"
              />
            </div>
          </div>

          <div className="form-row">
            <div className="form-column">
              <label htmlFor="email">E-mail :</label>
              <input
                type="email"
                id="email"
                className="form-control"
                name="email"
                value={formData.email}
                onChange={handleChange}
                required
                autoComplete="email"
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
                    checked={formData.role === "admin"}
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
                    checked={formData.role === "faculty"}
                    onChange={handleChange}
                  />
                  <label htmlFor="faculty">Faculty</label>
                </div>
                <div className="radio-option">
                  <input
                    type="radio"
                    id="student"
                    name="role"
                    value="Student"
                    checked={formData.role === "Student"}
                    onChange={handleChange}
                  />
                  <label htmlFor="student">Student</label>
                </div>
              </div>
            </div>
          </div>
          <AnimatePresence>
            {formData.role === "Student" && (
              <motion.div
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: 10 }}
                transition={{ duration: 0.4 }}
              >
                <div className="create-user-header">
                  <h3>SELECT AUTHORITIES</h3>
                </div>
                <div className="authority-selection">
                  {loading ? (
                    <p className="loading-text">Loading authorities...</p>
                  ) : existingAuthorities && existingAuthorities.length > 0 ? (
                    existingAuthorities.map((authority) => (
                      <div key={authority.id} className="authority-item">
                        <input
                          type="checkbox"
                          id={`authority-${authority.id}`}
                          value={authority.id}
                          checked={formData.authorities.some(
                            (auth) => auth.id === authority.id
                          )}
                          onChange={(e) => {
                            if (e.target.checked) {
                              handleExistingAuthorityChange(authority); // Add authority if checked
                            } else {
                              const index = formData.authorities.findIndex(
                                (auth) => auth.id === authority.id
                              );
                              handleRemoveAuthority(index); // Remove authority if unchecked
                            }
                          }}
                          className="authority-checkbox"
                        />
                        <label
                          htmlFor={`authority-${authority.id}`}
                          className="authority-label"
                        >
                          {authority.name} ({authority.email})
                        </label>
                      </div>
                    ))
                  ) : (
                    <p className="no-authorities-text">
                      No authorities available.
                    </p>
                  )}
                </div>

                <div className="create-user-header">
                  <h3>AUTHORITY PRIORITY ORDER</h3>
                </div>
                {formData.authorities.length > 0 ? (
                  <ul className="authority-priority-list">
                    {formData.authorities.map((auth, index) => (
                      <li key={auth.id} className="authority-priority-item">
                        <span className="authority-name">
                          {auth.name} ({auth.email})
                        </span>
                        <div className="priority-actions">
                          <button
                            type="button"
                            onClick={() => moveAuthority(index, -1)}
                            className="priority-btn"
                          >
                            Up
                          </button>
                          <button
                            type="button"
                            onClick={() => moveAuthority(index, 1)}
                            className="priority-btn"
                          >
                            Down
                          </button>
                          <button
                            type="button"
                            onClick={() => handleRemoveAuthority(index)}
                            className="priority-btn remove-btn"
                          >
                            Remove
                          </button>
                        </div>
                      </li>
                    ))}
                  </ul>
                ) : (
                  <p className="no-authorities-selected-text">
                    No authorities selected.
                  </p>
                )}
              </motion.div>
            )}
          </AnimatePresence>
          <div className="form-actions">
            <button
              type="submit"
              className="submit-btn"
              disabled={isSubmitting}
            >
              {isSubmitting ? "Creating..." : "CREATE USER"}
            </button>
          </div>
        </form>
      </div>
    </motion.div>
  );
};
export default CreateUser;
