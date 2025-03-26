import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.jsx'
import { BrowserRouter } from 'react-router-dom'

// TODO: Backend Integration Comments:

// 1. Global API Configuration:
// - Create src/api/apiClient.js with axios instance
// - Configure base URL from environment variables
// - Set up global request/response interceptors

// 2. Auth Provider:
// - Wrap app with AuthProvider context
// - Initialize authentication state on app load
// - Check for existing tokens and validate them

// 3. Error Boundary:
// - Add global error boundary component
// - Implement error logging to backend
// - Create fallback UI for crashed components

// 4. Environment Configuration:
// - Use .env files for environment-specific settings
// - Configure API URLs for development/production
// - Set up feature flags if needed

// 5. Performance Monitoring:
// - Initialize performance monitoring tools
// - Set up API call timing metrics
// - Configure error tracking service

createRoot(document.getElementById('root')).render(
  <BrowserRouter>
    <App />
  </BrowserRouter>,
)
