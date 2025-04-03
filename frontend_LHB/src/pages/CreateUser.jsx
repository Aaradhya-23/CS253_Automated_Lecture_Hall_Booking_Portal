// import React, { useState } from 'react';
// import axios from 'axios';
// import './CreateUser.css';
// import api from '../api/api';

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

//   return (
//     <div className="create-user-container">
//       <div className="create-user-header">
//         <h2>Create New User</h2>
//       </div>

//       <form onSubmit={handleSubmit} className="create-user-form">
//         <div className="form-row">
//           <div className="form-group">
//             <label htmlFor="username">User ID :</label>
//             <input
//               type="text"
//               id="username"
//               name="username"
//               value={formData.username}
//               onChange={handleChange}
//               required
//             />
//           </div>
//           <div className="form-group remarks">
//             <label htmlFor="remarks">Remarks :</label>
//             <input
//               type="text"
//               id="remarks"
//               name="remarks"
//               value={formData.remarks}
//               onChange={handleChange}
//             />
//           </div>
//         </div>

//         <div className="form-group">
//           <label htmlFor="password">Password :</label>
//           <input
//             type="password"
//             id="password"
//             name="password"
//             value={formData.password}
//             onChange={handleChange}
//             required
//           />
//         </div>

//         <div className="form-group">
//           <label htmlFor="email">E-mail :</label>
//           <input
//             type="email"
//             id="email"
//             name="email"
//             value={formData.email}
//             onChange={handleChange}
//             required
//           />
//         </div>

//         <div className="form-row categories-row">
//           <div className="form-group category-group">
//             <label className="required-label"> User Type </label>
//             <div className="radio-options">
//               <div className="radio-option">
//                 <input
//                   type="radio"
//                   id="admin"
//                   name="role"
//                   value="admin"
//                   checked={formData.role === 'admin'} // Compare with lowercase 'admin'
//                   onChange={handleChange}
//                   required
//                 />
//                 <label htmlFor="admin">Admin</label>
//               </div>

//               <div className="radio-option">
//                 <input
//                   type="radio"
//                   id="faculty"
//                   name="role"
//                   value="faculty"
//                   checked={formData.role === 'faculty'} // Compare with lowercase 'faculty'
//                   onChange={handleChange}
//                 />
//                 <label htmlFor="faculty">Faculty</label>
//               </div>

//               <div className="radio-option">
//                 <input
//                   type="radio"
//                   id="Student"
//                   name="role"
//                   value="Student"
//                   checked={formData.role === 'Student'} // Compare with lowercase 'Student'
//                   onChange={handleChange}
//                 />
//                 <label htmlFor="Student">Student</label>
//               </div>
//             </div>
//           </div>
//         </div>

//         <div className="form-group">
//           <label htmlFor="newAuthorityEmail">Verifying Authority Email:</label>
//           <input
//             type="email"
//             id="authority_email"
//             name="authority_email"
//             value={formData.authority_email}
//             onChange={handleChange}  // Handle the change in state
//             placeholder="Enter authority email"
//           />
//           {/* <button
//             type="button"
//             className="add-authority-button"
//             onClick={handleAddAuthorityEmail}
//           >
//             Add Verifying Authority
//           </button> */}
//         </div>

//         <div className="form-actions">
//           <button type="submit" className="confirm-button">
//             Confirm
//           </button>
//         </div>
//       </form>
//     </div>
//   );
// };

// export default CreateUser;




import React, { useState, useEffect } from 'react';
import './CreateUser.css';
import api from '../api/api';
import { ACCESS_TOKEN } from '../api/constants';

const CreateUser = () => {
  const [formData, setFormData] = useState({
    username: '',
    password: '',
    email: '',
    remarks: '',
    role: '',
    authority_email: '',
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [successMessage, setSuccessMessage] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevState) => ({
      ...prevState,
      [name]: value,
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

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    // Clear previous messages
    setSuccessMessage('');
    setErrorMessage('');
    
    // Validate form
    if (!validateForm()) return;
    
    setIsSubmitting(true);
    
    const token = localStorage.getItem(ACCESS_TOKEN);
    
    try {
      const response = await api.post(
        import.meta.env.VITE_USER_LIST_CREATE_URL,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json',
            Accept: 'application/json',
          },
        }
      );
      
      console.log('User created successfully:', response.data);
      setSuccessMessage('User created successfully!');
      resetForm();
    } catch (error) {
      console.error('Error creating user:', error);
      setErrorMessage(error.response?.data?.message || 'Error creating user. Please try again.');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="main-content-wrapper">
      <div className="create-user-container">
        <div className="create-user-header">
          <h2>Create New User</h2>
        </div>

        {successMessage && (
          <div className="success-message">
            {successMessage}
          </div>
        )}
        
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

          <div className="form-row">
            <div className="form-column">
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
            <button 
              type="submit" 
              className="submit-btn"
              disabled={isSubmitting}
            >
              {isSubmitting ? 'Creating...' : 'CREATE USER'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default CreateUser;