import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './CreateUser.css';

// TODO: Backend Integration Comments:

// 1. User Creation API:
// - Replace console.log with actual API call
// - Create src/api/users.js for user management
// - Implement POST /api/admin/users with proper validation
// - Handle various response statuses (success, validation error, etc.)

// 2. Authority Management:
// - Already partially implemented with axios
// - Update endpoints to match your backend structure
// - Add proper error handling for authority API calls
// - Implement optimistic updates for better UX

// 3. Form Validation:
// - Add server-side validation error display
// - Implement client-side validation for all fields
// - Check for existing users before submission (debounced)

// 4. Security Considerations:
// - Ensure password complexity requirements are enforced
// - Don't send plaintext passwords in logs/console
// - Consider implementing password strength meter

// 5. Success Handling:
// - Show success message after user creation
// - Provide options to:
//   a) Create another user
//   b) View the created user
//   c) Return to admin dashboard

// 6. Permission Checks:
// - Verify admin has permission to create users
// - Disable fields based on admin permission level
// - Handle unauthorized actions gracefully

// 7. Role-Based Options:
// - Fetch available roles from backend
// - Dynamically adjust form fields based on selected role
// - Show/hide certain options based on user type

const CreateUser = () => {
  const [formData, setFormData] = useState({
    userId: '',
    password: '',
    email: '',
    remarks: '',
    category: '',
    verifyingAuthority: '',
    authorities: [] // New field to store selected authority IDs
  });

  // New state for authority management
  const [availableAuthorities, setAvailableAuthorities] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedAuthorities, setSelectedAuthorities] = useState([]);
  const [showDropdown, setShowDropdown] = useState(false);
  const [newAuthority, setNewAuthority] = useState({ name: '', email: '' });
  const [showAuthorityForm, setShowAuthorityForm] = useState(false);

  // Fetch available authorities on component mount
  useEffect(() => {
    // Replace with your actual API endpoint
    axios.get("http://127.0.0.1:8000/api/user/authorities/")
      .then(response => setAvailableAuthorities(response.data))
      .catch(error => console.error("Error fetching authorities:", error));
  }, []);

  // Update formData when selectedAuthorities changes
  useEffect(() => {
    setFormData(prevState => ({
      ...prevState,
      authorities: selectedAuthorities.map(auth => auth.id)
    }));
  }, [selectedAuthorities]);

  // Filter authorities based on search term
  const filteredAuthorities = availableAuthorities.filter(auth => 
    auth.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prevState => ({
      ...prevState,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Form submitted:', formData);
    // Here you would typically send the data to your backend
  };

  // Handle authority selection
  const handleSelectAuthority = (authority) => {
    if (!selectedAuthorities.some(auth => auth.id === authority.id)) {
      setSelectedAuthorities([...selectedAuthorities, authority]);
    }
    setSearchTerm('');
    setShowDropdown(false);
  };

  // Handle authority removal
  const handleRemoveAuthority = (authorityId) => {
    setSelectedAuthorities(selectedAuthorities.filter(auth => auth.id !== authorityId));
  };

  // Handle adding new authority
  const handleAddAuthority = async () => {
    if (!newAuthority.name || !newAuthority.email) {
      alert("Both name and email are required for a new authority!");
      return;
    }

    try {
      // Replace with your actual API endpoint
      const response = await axios.post("http://127.0.0.1:8000/api/user/createauthorities/", newAuthority);
      const createdAuthority = response.data;
      
      setAvailableAuthorities([...availableAuthorities, createdAuthority]);
      setSelectedAuthorities([...selectedAuthorities, createdAuthority]);
      setNewAuthority({ name: "", email: "" });
      setShowAuthorityForm(false);
      
    } catch (err) {
      console.error("Error adding authority:", err);
      alert("Failed to add authority.");
    }
  };

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (!event.target.closest('.authority-selector')) {
        setShowDropdown(false);
      }
    };
    
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  return (
    <div className="create-user-container">
      <div className="create-user-header">
        <h2>Create New User</h2>
        <div className="user-type-indicator">
          <span>User</span>
          <div className="user-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
              <circle cx="12" cy="7" r="4"></circle>
            </svg>
          </div>
        </div>
      </div>

      <form onSubmit={handleSubmit} className="create-user-form">
        <div className="form-row">
          <div className="form-group">
            <label htmlFor="userId">User ID :</label>
            <input
              type="text"
              id="userId"
              name="userId"
              value={formData.userId}
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
            <label className="required-label">Category *</label>
            <div className="radio-options">
              <div className="radio-option">
                <input
                  type="radio"
                  id="academic"
                  name="category"
                  value="Academic"
                  checked={formData.category === "Academic"}
                  onChange={handleChange}
                  required
                />
                <label htmlFor="academic">Academic</label>
              </div>
              
              <div className="radio-option">
                <input
                  type="radio"
                  id="nonAcademic"
                  name="category"
                  value="Non-Academic"
                  checked={formData.category === "Non-Academic"}
                  onChange={handleChange}
                />
                <label htmlFor="nonAcademic">Non-Academic</label>
              </div>
            </div>
          </div>

          <div className="form-group authority-group">
            <div className="authority-header">
              <label className="required-label">Verifying Authority *</label>
              <button 
                type="button" 
                className="add-button"
                onClick={() => setShowAuthorityForm(!showAuthorityForm)}
              >
                {showAuthorityForm ? 'Cancel' : 'Add'}
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  {showAuthorityForm ? (
                    <g>
                      <circle cx="12" cy="12" r="10"></circle>
                      <line x1="8" y1="12" x2="16" y2="12"></line>
                    </g>
                  ) : (
                    <g>
                      <circle cx="12" cy="12" r="10"></circle>
                      <line x1="12" y1="8" x2="12" y2="16"></line>
                      <line x1="8" y1="12" x2="16" y2="12"></line>
                    </g>
                  )}
                </svg>
              </button>
            </div>
            <div className="radio-options">
              <div className="radio-option">
                <input
                  type="radio"
                  id="dosa"
                  name="verifyingAuthority"
                  value="DOSA"
                  checked={formData.verifyingAuthority === "DOSA"}
                  onChange={handleChange}
                  required
                />
                <label htmlFor="dosa">DOSA</label>
              </div>
              
              <div className="radio-option">
                <input
                  type="radio"
                  id="doaa"
                  name="verifyingAuthority"
                  value="DOAA"
                  checked={formData.verifyingAuthority === "DOAA"}
                  onChange={handleChange}
                />
                <label htmlFor="doaa">DOAA</label>
              </div>
              
              <div className="radio-option">
                <input
                  type="radio"
                  id="general"
                  name="verifyingAuthority"
                  value="General Sec(SnT)"
                  checked={formData.verifyingAuthority === "General Sec(SnT)"}
                  onChange={handleChange}
                />
                <label htmlFor="general">General Sec(SnT)</label>
              </div>
              
              <div className="radio-option">
                <input
                  type="radio"
                  id="none"
                  name="verifyingAuthority"
                  value="None"
                  checked={formData.verifyingAuthority === "None"}
                  onChange={handleChange}
                />
                <label htmlFor="none">None</label>
              </div>
            </div>
          </div>
        </div>

        {/* New Authority Form */}
        {showAuthorityForm && (
          <div className="new-authority-form">
            <h4>Add New Authority</h4>
            <div className="form-row">
              <div className="form-group">
                <label htmlFor="authorityName">Authority Name:</label>
                <input
                  type="text"
                  id="authorityName"
                  value={newAuthority.name}
                  onChange={(e) => setNewAuthority({...newAuthority, name: e.target.value})}
                />
              </div>
              <div className="form-group">
                <label htmlFor="authorityEmail">Authority Email:</label>
                <input
                  type="email"
                  id="authorityEmail"
                  value={newAuthority.email}
                  onChange={(e) => setNewAuthority({...newAuthority, email: e.target.value})}
                />
              </div>
            </div>
            <button 
              type="button" 
              className="add-authority-button"
              onClick={handleAddAuthority}
            >
              Add Authority
            </button>
          </div>
        )}

        {/* Multiple Authorities Selector */}
        <div className="form-group">
          <label>Additional Authorities:</label>
          <div className="authority-selector">
            {/* Selected Authorities Display */}
            <div className="selected-authorities">
              {selectedAuthorities.map(auth => (
                <div key={auth.id} className="selected-authority">
                  <span>{auth.name}</span>
                  <button 
                    type="button"
                    onClick={() => handleRemoveAuthority(auth.id)}
                    className="remove-authority"
                  >
                    ×
                  </button>
                </div>
              ))}
            </div>
            
            {/* Authority Search Input */}
            <div className="authority-search">
              <input
                type="text"
                placeholder="Search for authorities..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                onFocus={() => setShowDropdown(true)}
                onClick={() => setShowDropdown(true)}
              />
              
              {/* Dropdown for authority selection */}
              {showDropdown && (
                <div className="authority-dropdown">
                  {filteredAuthorities.length > 0 ? (
                    filteredAuthorities.map(auth => (
                      <div 
                        key={auth.id} 
                        className="authority-option"
                        onClick={() => handleSelectAuthority(auth)}
                      >
                        {auth.name}
                      </div>
                    ))
                  ) : (
                    <div className="no-results">No authorities found</div>
                  )}
                </div>
              )}
            </div>
          </div>
        </div>

        <div className="form-actions">
          <button type="submit" className="confirm-button">Confirm</button>
        </div>
      </form>
    </div>
  );
};

export default CreateUser;