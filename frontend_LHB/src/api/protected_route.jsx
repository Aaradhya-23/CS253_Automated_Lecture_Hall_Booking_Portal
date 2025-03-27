import { useEffect, useState } from "react";
import { Navigate } from "react-router-dom";
import { ACCESS_TOKEN, REFRESH_TOKEN } from "./constants";
import { jwtDecode } from "jwt-decode";
import api from "./api";
import FRONTEND_ROUTES from "../frontend_urls";

function ProtectedRoute({ children, role }) {
  const [isAuthorized, setIsAuthorized] = useState(null);

  useEffect(() => {
    auth().catch((err) => {
      console.error("Auth error:", err);
      setIsAuthorized(false);
    });
  }, []);

  const refreshToken = async () => {
    const refresh = localStorage.getItem(REFRESH_TOKEN);
    console.debug("Attempting to refresh token:", refresh);
    try {
      const res = await api.post(import.meta.env.VITE_REFRESH_TOKEN_URL, {
        refresh,
      });
      console.debug("Refresh token response:", res.data);
      if (res.status === 200) {
        localStorage.setItem(ACCESS_TOKEN, res.data.access);
        setIsAuthorized(true);
        return true;
      }
    } catch (error) {
      console.error("Error refreshing token:", error);
      setIsAuthorized(false);
      return false;
    }
  };

  const auth = async () => {
    const token = localStorage.getItem(ACCESS_TOKEN);
    const stored_role = localStorage.getItem("ROLE")
    console.log("Existing access token:", token);
    if (!token) {
      console.log("No access token found.");
      setIsAuthorized(false);
      return;
    }
    let decodedToken;
    try {
      decodedToken = token;
      console.log("Decoded token:", decodedToken);
    } catch (error) {
      console.log("Error decoding token:", error);
      setIsAuthorized(false);
      return;
    }

    const now = Date.now() / 1000;
    if (decodedToken.exp < now) {
      console.warn("Access token expired. Now:", now, "Token exp:", decodedToken.exp);
      const success = await refreshToken();
      if (!success) {
        console.error("Token refresh failed.");
        return;
      }
      // Re-decode the new token
      const newToken = localStorage.getItem(ACCESS_TOKEN);
      try {
        // decodedToken = jwtDecode(newToken);
        decodedToken = newToken
        console.debug("New decoded token:", decodedToken);
      } catch (error) {
        console.error("Error decoding new token:", error);
        setIsAuthorized(false);
        return;
      }
    }
    console.log("token = ", decodedToken)
    if (role) {
      const requiredRoles = Array.isArray(role) ? role : [role];
      console.log("Required roles:", requiredRoles, "User role:", stored_role);
      if (!requiredRoles.includes(stored_role)) {
        console.warn("User role not authorized. Expected one of:", requiredRoles);
        setIsAuthorized(false);
        return;
      }
    }

    console.debug("User authorized.");
    setIsAuthorized(true);
  };

  if (isAuthorized === null) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="loader">Loading...</div>
      </div>
    );
  }
  if (isAuthorized) {
    return children;
  } else {
    console.warn("User not authorized. Clearing local storage and redirecting to login.");
    localStorage.clear();
    return <Navigate to={FRONTEND_ROUTES.login} />;
  }
}

export default ProtectedRoute;