import React, { useState } from 'react';
import './HelpPage.css';
const HelpPage = () => {
  const [isLoading, setIsLoading] = useState(true);

  return (
    <div className="help-container">
      <h1>Help Center</h1>
      <div className="help-content">
        <p>Below is a PDF guide containing answers to common questions about the IIT-K Lecture Hall Booking system:</p>
        
        <div className="pdf-container">
          {isLoading && <div className="loading">Loading PDF...</div>}
          <iframe 
            src="/path-to-your-help-document.pdf"
            title="IIT-K Lecture Hall Booking Help Guide"
            width="100%" 
            height="600px"
            onLoad={() => setIsLoading(false)}
            style={{border: '1px solid #ccc', borderRadius: '4px'}}
          />
        </div>
        
        <div className="additional-help">
          <h2>Quick Support</h2>
          <p>If you can't find what you're looking for in the guide, please contact:</p>
          <ul>
            <li>Email: support_lhc@iitk.ac.in</li>
            <li>Phone: (123) 456-7890</li>
            <li>Office: Academic Building, Room 105</li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default HelpPage;