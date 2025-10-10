import { api } from "./api";
export type Me = { ID: number; Usuario: string; ID_Permission?: number | null };
export const login = (Usuario: string, Password: string) => api<Me>("/api/auth/login", { method: "POST", body: JSON.stringify({ Usuario, Password }) });
export const me = () => api<Me>("/api/auth/me");
export const logout = () => api<{ ok: boolean }>("/api/auth/logout", { method: "POST" });
