import iitk_logo from './iitk_logo.png';
import L_18 from './L_18.jpg';
import L_19 from './L_19.jpg';
import L_20 from './L_20.jpg';


export const assets = {
  iitk_logo: iitk_logo
    , L_18: L_18
    , L_19: L_19
    , L_20: L_20
};

// assets.js

export const lectureHalls = [
    {
      id: 1,
      hallNumber: "L_20",      // Fixed lecture hall identifier
      occupancy: 600,          // Fixed occupancy capacity
      audioVideo: true,        // Fixed audio/video availability
      image: L_20,             // Image for L-20
      course: {
        name: "",              // Variable: update with course name as needed
        description: "",       // Variable: update with course description
      },
      timing: {
        startTime: "",         // Variable: update with start time
        endTime: "",           // Variable: update with end time
        duration: "",          // Variable: update with duration
      },
      bookingDetails: {
        bookingDate: "",       // Variable: update with booking date
        approvedDate: "",      // Variable: update with approved date
        approvalStatus: "",    // Variable: update with approval status (e.g., "Approved", "Pending")
      },
    },
    {
      id: 2,
      hallNumber: "L_19",
      occupancy: 300,
      audioVideo: true,
      image: L_19,
      course: {
        name: "",
        description: "",
      },
      timing: {
        startTime: "",
        endTime: "",
        duration: "",
      },
      bookingDetails: {
        bookingDate: "",
        approvedDate: "",
        approvalStatus: "",
      },
    },
    {
      id: 3,
      hallNumber: "L_18",
      occupancy: 300,
      audioVideo: true,
      image: L_18,
      course: {
        name: "",
        description: "",
      },
      timing: {
        startTime: "",
        endTime: "",
        duration: "",
      },
      bookingDetails: {
        bookingDate: "",
        approvedDate: "",
        approvalStatus: "",
      },
    },
  ];
  