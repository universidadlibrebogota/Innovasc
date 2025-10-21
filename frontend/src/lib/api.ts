export async function apiFetch(input: RequestInfo, init?: RequestInit) {
  const res = await fetch(`${process.env.NEXT_PUBLIC_API}${input}`, {
    credentials: "include",
    headers: { "content-type": "application/json", ...(init?.headers || {}) },
    ...init
  });
  if (res.status === 401) {
    // Intento de refresh silencioso
    const r = await fetch(`${process.env.NEXT_PUBLIC_API}/api/auth/refresh`, { credentials: "include", method: "POST" });
    if (r.ok) {
      // reintenta una vez
      const retry = await fetch(`${process.env.NEXT_PUBLIC_API}${input}`, { credentials: "include", ...init });
      if (retry.status === 401) { window.location.href = "/login"; return retry; }
      return retry;
    } else {
      window.location.href = "/login";
    }
  }
  return res;
}
