import React, { useState } from 'react';
import './CreateUser.css';

const CreateUser = ({ onLogout }) => {
  const [userData, setUserData] = useState({
    userId: '',
    password: '',
    email: '',
    remarks: '',
    category: 'Academic',
    verifyingAuthority: 'DOSA'
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setUserData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('User creation submitted:', userData);
    // Here you would typically send the data to your backend
  };

  const handleNavigate = (page) => {
    // Handle navigation to different pages
    console.log(`Navigating to ${page}`);
  };

  return (
    <div className="create-user">
      <header className="header">
        <div className="logo-container">
          <img src="/iit-logo.png" alt="IIT-K Logo" className="logo" />
          <h1>IIT-K Lecture Hall Booking</h1>
        </div>
        <button className="logout-button" onClick={onLogout}>Logout</button>
      </header>
      
      <div className="main-content">
        <aside className="sidebar">
          <button className="sidebar-button" onClick={() => handleNavigate('new')}>
            New <span className="icon">⊕</span>
          </button>
          <button className="sidebar-button" onClick={() => handleNavigate('schedule')}>
            Live Schedule
          </button>
          <button className="sidebar-button" onClick={() => handleNavigate('history')}>
            History
          </button>
          <button className="sidebar-button" onClick={() => handleNavigate('viewPending')}>
            View Pending
          </button>
          <button className="sidebar-button active" onClick={() => handleNavigate('createUser')}>
            Create New User
          </button>
        </aside>
        
        <main className="content-area">
          <div className="create-user-form-container">
            <div className="form-header">
              <div className="form-title">Create New User</div>
              <div className="user-icon-container">
                <div className="user-tab">User</div>
                <div className="user-icon">👤</div>
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
                    value={userData.userId}
                    onChange={handleInputChange}
                    required
                  />
                </div>
                
                <div className="form-group">
                  <label htmlFor="remarks">Remarks :</label>
                  <input
                    type="text"
                    id="remarks"
                    name="remarks"
                    value={userData.remarks}
                    onChange={handleInputChange}
                  />
                </div>
              </div>
              
              <div className="form-group">
                <label htmlFor="password">Password :</label>
                <input
                  type="password"
                  id="password"
                  name="password"
                  value={userData.password}
                  onChange={handleInputChange}
                  required
                />
              </div>
              
              <div className="form-group">
                <label htmlFor="email">E-mail :</label>
                <input
                  type="email"
                  id="email"
                  name="email"
                  value={userData.email}
                  onChange={handleInputChange}
                  required
                />
              </div>
              
              <div className="form-row">
                <div className="form-group">
                  <label htmlFor="category" className="required-label">Category *</label>
                  <div className="radio-group">
                    <label>
                      <input
                        type="radio"
                        name="category"
                        value="Academic"
                        checked={userData.category === "Academic"}
                        onChange={handleInputChange}
                      />
                      Academic
                    </label>
                    <label>
                      <input
                        type="radio"
                        name="category"
                        value="Non-Academic"
                        checked={userData.category === "Non-Academic"}
                        onChange={handleInputChange}
                      />
                      Non-Academic
                    </label>
                  </div>
                </div>
                
                <div className="form-group">
                  <label htmlFor="verifyingAuthority" className="required-label">Verifying Authority *</label>
                  <div className="radio-group">
                    <label>
                      <input
                        type="radio"
                        name="verifyingAuthority"
                        value="DOSA"
                        checked={userData.verifyingAuthority === "DOSA"}
                        onChange={handleInputChange}
                      />
                      DOSA
                    </label>
                    <label>
                      <input
                        type="radio"
                        name="verifyingAuthority"
                        value="DOAA"
                        checked={userData.verifyingAuthority === "DOAA"}
                        onChange={handleInputChange}
                      />
                      DOAA
                    </label>
                    <label>
                      <input
                        type="radio"
                        name="verifyingAuthority"
                        value="General Sec(SnT)"
                        checked={userData.verifyingAuthority === "General Sec(SnT)"}
                        onChange={handleInputChange}
                      />
                      General Sec(SnT)
                    </label>
                    <label>
                      <input
                        type="radio"
                        name="verifyingAuthority"
                        value="None"
                        checked={userData.verifyingAuthority === "None"}
                        onChange={handleInputChange}
                      />
                      None
                    </label>
                  </div>
                </div>
              </div>
              
              <div className="form-actions">
                <div className="add-button-container">
                  <button type="button" className="add-button">
                    Add <span className="add-icon">⊕</span>
                  </button>
                </div>
                <button type="submit" className="confirm-button">Confirm</button>
              </div>
            </form>
          </div>
        </main>
      </div>
    </div>
  );
};

export default CreateUser;