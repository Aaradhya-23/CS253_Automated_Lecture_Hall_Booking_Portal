import axios from "axios";
import { ACCESS_TOKEN, REFRESH_TOKEN } from "./constants";


const api = axios.create({
    baseURL: import.meta.env.VITE_API_URL,
    timeout: 10000,
});
// Response interceptor
api.interceptors.response.use(
    (response) => {
      return response;
    },
    async (error) => {
      const originalRequest = error.config;
      
      // Handle token expiration
      if (error.response?.status === 401 && !originalRequest._retry) {
        originalRequest._retry = true;
        
        try {
          // Attempt to refresh token
          const refreshToken = localStorage.getItem(REFRESH_TOKEN);
          if (!refreshToken) {
            throw new Error('No refresh token available');
          }
          
          const response = await axios.post(
            VITE_REFRESH_TOKEN_URL, 
            { refreshToken }
          );
          
          const { token } = response.data;
          localStorage.setItem(ACCESS_TOKEN, token);
          
          // Retry the original request with new token
          originalRequest.headers.Authorization = `Bearer ${token}`;
          return api(originalRequest);
        } catch (refreshError) {
          // Redirect to login on refresh failure
          localStorage.clear();
          window.location.href = import.meta.env.VITE_LOGIN_URL;
          return Promise.reject(refreshError);
        }
      }
      
      // Handle other errors
      return Promise.reject(error);
    }
  );  

export default api

// can be added in axios.create
// headers: {
//   'Content-Type': 'application/json',
// },