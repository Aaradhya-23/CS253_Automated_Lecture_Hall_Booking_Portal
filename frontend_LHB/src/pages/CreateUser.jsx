import React from 'react';
import axios from 'axios';
import './CreateUser.css';
import api from '../api/api';
import { useEffect, useState } from 'react';
// const CreateUser = () => {
//   const [formData, setFormData] = useState({
//     username: '',
//     password: '',
//     email: '',
//     // remarks: '',
//     // category: '',
//     role: '',
//     authority_email: '', // Updated to store a single verifying authority
//   });
//   const [newAuthorityEmail, setNewAuthorityEmail] = useState('');

//   const handleChange = (e) => {
//     const { name, value } = e.target;
//     setFormData((prevState) => ({
//       ...prevState,
//       [name]: value,
//     }));
//   };

//   // const handleAddAuthorityEmail = () => {
//   //   if (newAuthorityEmail && validateEmail(newAuthorityEmail)) {
//   //     setFormData((prevState) => ({
//   //       ...prevState,
//   //       authority_email: newAuthorityEmail, // Update authority_email instead of authorities
//   //     }));
//   //     setNewAuthorityEmail(''); // Clear the input field after adding the email
//   //   } else {
//   //     alert('Please enter a valid email address.');
//   //   }
//   // };

//   const handleSubmit = (e) => {
//     e.preventDefault();

//     const token = localStorage.getItem('ACCESS_TOKEN'); // Retrieve the token from localStorage
//     console.log(token)
//     console.log(formData)
//     api
//       .post(
//         import.meta.env.VITE_USER_LIST_CREATE_URL,
//         formData,
//         {
//           headers: {
//             Authorization: `Bearer ${token}`, // Include the token in the Authorization header
//             'Content-Type': 'application/json', // Specify the content type as JSON
//             Accept: 'application/json', // Specify that the response should be in JSON format
//           },
//         }
//       )
//       .then((response) => {
//         console.log('User created successfully:', response.data);
//         alert('User created successfully!');
//         // Clear the form after successful submission
//         setFormData({
//           username: '',
//           password: '',
//           email: '',
//           remarks: '',
//           category: '',
//           authority_email: '',
//         });
//       })
//       .catch((error) => {
//         console.error('Error creating user:', error);
//         alert('Error creating user. Please try again.');
//       });
//   };
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
    // <div className="create-user-container">
    //   <div className="create-user-header">
    //     <h2>Create New User</h2>
    //   </div>

    //   <form onSubmit={handleSubmit} className="create-user-form">
    //     <div className="form-row">
    //       <div className="form-group">
    //         <label htmlFor="username">User ID :</label>
    //         <input
    //           type="text"
    //           id="username"
    //           name="username"
    //           value={formData.username}
    //           onChange={handleChange}
    //           required
    //         />
    //       </div>
    //       <div className="form-group remarks">
    //         <label htmlFor="remarks">Remarks :</label>
    //         <input
    //           type="text"
    //           id="remarks"
    //           name="remarks"
    //           value={formData.remarks}
    //           onChange={handleChange}
    //         />
    //       </div>
    //     </div>

    //     <div className="form-group">
    //       <label htmlFor="password">Password :</label>
    //       <input
    //         type="password"
    //         id="password"
    //         name="password"
    //         value={formData.password}
    //         onChange={handleChange}
    //         required
    //       />
    //     </div>

    //     <div className="form-group">
    //       <label htmlFor="email">E-mail :</label>
    //       <input
    //         type="email"
    //         id="email"
    //         name="email"
    //         value={formData.email}
    //         onChange={handleChange}
    //         required
    //       />
    //     </div>

    //     <div className="form-row categories-row">
    //       <div className="form-group category-group">
    //         <label className="required-label"> User Type </label>
    //         <div className="radio-options">
    //           <div className="radio-option">
    //             <input
    //               type="radio"
    //               id="admin"
    //               name="role"
    //               value="admin"
    //               checked={formData.role === 'admin'} // Compare with lowercase 'admin'
    //               onChange={handleChange}
    //               required
    //             />
    //             <label htmlFor="admin">Admin</label>
    //           </div>

    //           <div className="radio-option">
    //             <input
    //               type="radio"
    //               id="faculty"
    //               name="role"
    //               value="faculty"
    //               checked={formData.role === 'faculty'} // Compare with lowercase 'faculty'
    //               onChange={handleChange}
    //             />
    //             <label htmlFor="faculty">Faculty</label>
    //           </div>

    //           <div className="radio-option">
    //             <input
    //               type="radio"
    //               id="Student"
    //               name="role"
    //               value="Student"
    //               checked={formData.role === 'Student'} // Compare with lowercase 'Student'
    //               onChange={handleChange}
    //             />
    //             <label htmlFor="Student">Student</label>
    //           </div>
    //         </div>
    //       </div>
    //     </div>

    //     <div className="form-group">
    //       <label htmlFor="newAuthorityEmail">Verifying Authority Email:</label>
    //       <input
    //         type="email"
    //         id="authority_email"
    //         name="authority_email"
    //         value={formData.authority_email}
    //         onChange={handleChange}  // Handle the change in state
    //         placeholder="Enter authority email"
    //       />
    //       {/* <button
    //         type="button"
    //         className="add-authority-button"
    //         onClick={handleAddAuthorityEmail}
    //       >
    //         Add Verifying Authority
    //       </button> */}
    //     </div>

    //     <div className="form-actions">
    //       <button type="submit" className="confirm-button">
    //         Confirm
    //       </button>
    //     </div>
    //   </form>
    // </div>
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
