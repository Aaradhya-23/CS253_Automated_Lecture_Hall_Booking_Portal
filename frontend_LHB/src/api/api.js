import axios from "axios";
import { ACCESS_TOKEN, REFRESH_TOKEN } from "./constants";
import FRONTEND_ROUTES from "../frontend_urls";

const api = axios.create({
    baseURL: import.meta.env.VITE_API_URL,
    timeout: 10000,
    headers: {
      'Content-Type': 'application/json',  // Ensure Content-Type is set
      'Accept': 'application/json',       // Ensure server knows that you expect JSON responses
    },
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
          const refresh = localStorage.getItem(REFRESH_TOKEN);
          if (!refresh) {
            throw new Error('No refresh token available');
          }

          const response = await axios.post(
            import.meta.env.VITE_REFRESH_TOKEN_URL,
            { refresh }
          );

          const { access, newrefresh } = response.data;
          localStorage.setItem(ACCESS_TOKEN, access);
          localStorage.setItem(REFRESH_TOKEN, newrefresh);
          console.log("Again new refresh and access token set");

          // Retry the original request with new token
          originalRequest.headers.Authorization = `Bearer ${access}`;
          return api(originalRequest);
        } catch (refreshError) {
          const e = refreshError;
          // Redirect to login on refresh failure
          localStorage.clear();
          window.location.href = FRONTEND_ROUTES.login;
          console.log(e);
          return Promise.reject(refreshError);
        }
      }

      // Handle other errors
      return Promise.reject(error);
    }
  );
export default api