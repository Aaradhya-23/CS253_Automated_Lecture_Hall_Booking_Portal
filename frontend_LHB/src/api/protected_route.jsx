import { useEffect, useState } from "react";
import { Navigate } from "react-router-dom";
import { ACCESS_TOKEN, REFRESH_TOKEN } from "./constants";
import { jwtDecode } from "jwt-decode";
import api from "./api";

function ProtectedRoute({ children, role }) {
  const [isAuthorized, setIsAuthorized] = useState(null);

  useEffect(() => {
    auth().catch(() => setIsAuthorized(false));
  }, []);

  const refreshToken = async () => {
    const token = localStorage.getItem(REFRESH_TOKEN);
    try {
      const res = await api.post(import.meta.env.VITE_REFRESH_TOKEN_URL, {
        refresh: token,
      });
      if (res.status === 200) {
        localStorage.setItem(ACCESS_TOKEN, res.data.access);
        setIsAuthorized(true);
      }
    } catch (error) {
      console.log(error);
      setIsAuthorized(false);
    }
  };

  const auth = async () => {
    const token = localStorage.getItem(ACCESS_TOKEN);
    if (!token) {
      setIsAuthorized(false);
      return;
    }
    const decodedToken = jwtDecode(token);
    if (decodedToken.exp < Date.now() / 1000) {
      await refreshToken();
    } else {
        
      if (role && decodedToken.role !== role) {
        setIsAuthorized(false);
      } else {
        setIsAuthorized(true);
      }
    }
  };

  if (isAuthorized === null) {
    // show loading part here.
    return <div>Loading...</div>;
  }

  return isAuthorized ? children : <Navigate to={import.meta.env.VITE_LOGIN_URL} />;
}

export default ProtectedRoute;