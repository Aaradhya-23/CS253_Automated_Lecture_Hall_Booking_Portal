# Automated Lecture Hall Booking Portal

A web-based system for managing lecture hall bookings at IIT Kanpur, developed by Group 12 (Aviators) as a course project for the course CS253.

## Overview

This portal provides a streamlined solution for booking lecture halls and tutorial rooms at IIT Kanpur. It features separate interfaces for students, faculty, and administrators with different permission levels, automated email notifications, booking approval workflows, and comprehensive reporting. This web-app is aimed to automate and improve the current process of booking Lecture Halls at IITK by Professors and student bodies like clubs, socities etc.

## Features

- **Role-based Authentication System**
  - Student: Can request bookings (requires approval) from authorities
  - Faculty: Can create confirmed bookings directly
  - Admin: Full access to all operations

- **Room Management**
  - View detailed information about lecture halls and tutorial blocks
  - Filter rooms by capacity, available facilities, and type

- **Booking System**
  - Easy-to-use booking interface
  - Real-time availability checking
  - Request accessories (projector, AC, board)
  - Automated cost calculation

- **Live Schedule**
  - View current and upcoming bookings
  - Search and filter 

- **Approval Workflow**
  - Automated email notifications to authorities
  - One-click approval/rejection through email links

- **Reporting**
  - PDF bill generation
  - Daily schedule downloads in CSV format

## Tech Stack

### Backend
- **Framework**: Django with Django REST Framework
- **Database**: PostgreSQL
- **Authentication**: JWT (JSON Web Tokens)
- **Email Service**: Django's built-in email functionality
- **Report Generation**: ReportLab (PDF), CSV exports

### Frontend
- **Framework**: React
- **Build Tool**: Vite
- **Styling**: CSS

## Installation and Setup

### Prerequisites
- Python 3.8+
- Node.js 14+
- npm or yarn
- PostgreSQL (optional, SQLite works for development)

### Backend Setup

1. Clone the repository
   ```bash
   git clone https://github.com/chaitanyavb-502/CS253_Automated_Lecture_Hall_Booking_Portal.git
   cd CS253_Automated_Lecture_Hall_Booking_Portal
   ```

2. Set up Python virtual environment
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install backend dependencies
   ```bash
   pip install -r requirements.txt
   ```

4. Configure environment variables
   Create a `.env` file in the project root with the following variables:
   ```
   SECRET_KEY=your_secret_key
   DEBUG=True
   DATABASE_URL=postgres://user:password@localhost:5432/dbname  # Optional
   EMAIL_HOST=smtp.example.com
   EMAIL_PORT=587
   EMAIL_HOST_USER=your_email@example.com
   EMAIL_HOST_PASSWORD=your_email_password
   EMAIL_USE_TLS=True
   ```

5. Apply database migrations
   ```bash
   python manage.py migrate
   ```

6. Create a superuser (admin)
   ```bash
   python manage.py createsuperuser
   ```

7. Run the development server
   ```bash
   python manage.py runserver
   ```

### Frontend Setup

1. Navigate to the frontend directory
   ```bash
   cd frontend
   ```

2. Install dependencies
   ```bash
   npm install
   # or
   yarn install
   ```

3. Start the development server
   ```bash
   npm run dev
   # or
   yarn dev
   ```

4. The application should now be running at:
   - Backend: http://localhost:8000/
   - Frontend: http://localhost:5173/

## Project Team

### Developers
- Chaitanya Bramhapurikar (230305) - bcvishwas23@iitk.ac.in
- Rahul Meena (230832) - rahulkcm23@iitk.ac.in
- Bhavya Chauhan (230294) - bhavyach23@iitk.ac.in
- Atharv Phirke (230238) - atharvp23@iitk.ac.in
- Aaradhya Rohi (230011) - aaradhya23@iitk.ac.in
- Chaudhari Divyesh (230325) - divyesh23@iitk.ac.in
- Devansh A Dhok (230354) - devanshad23@iitk.ac.in
- Areen Mahich (230188) - areenm23@iitk.ac.in
- Daksh Dua (220321) - dakshdua22@iitk.ac.in
- Avantika Rohite (230245) - avantikar23@iitk.ac.in

### Course
CS253 - Software Development and Operations

### Mentor TA
Souvik Mukherjee
### Professor
Indranil Saha
## License

This project is licensed under the MIT License - see the LICENSE file for details.
