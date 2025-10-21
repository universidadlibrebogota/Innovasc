import { useEffect } from "react";
export default function Logout() {
  useEffect(() => {
    // golpea un endpoint del gateway que limpie cookies
    fetch(`${process.env.NEXT_PUBLIC_API}/api/auth/logout`, { method: "POST", credentials: "include" })
      .finally(() => { sessionStorage.clear(); localStorage.removeItem("some-cache"); window.location.href = "/login"; });
  }, []);
  return null;
}
