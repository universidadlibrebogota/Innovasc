import { Router } from "express";
import axios from "axios";
import jwt from "jsonwebtoken";

const router = Router();
const backend = process.env.BACKEND_URL || "http://127.0.0.1:8000";
const jwtSecret = process.env.JWT_SECRET || "dev-secret";

router.post("/login", async (req, res) => {
  try {
    const { data } = await axios.post(`${backend}/auth/login`, req.body);
    const token = jwt.sign(data, jwtSecret, { expiresIn: "8h" });
    const isProd = process.env.NODE_ENV === "production";
    res.cookie("token", token, {
      httpOnly: true,
      sameSite: isProd ? "none" : "lax",
      secure: isProd ? true : false
    });
    res.json(data);
  } catch (e: any) {
    res.status(e?.response?.status || 500).json({ error: e?.response?.data?.detail || "Error" });
  }
});

router.get("/me", (req, res) => {
  const token = (req as any).cookies?.token || (req.headers?.cookie || "").split("token=")[1];
  if (!token) return res.status(401).json({ error: "No autenticado" });
  try {
    const payload = jwt.verify(token, jwtSecret);
    return res.json(payload);
  } catch {
    return res.status(401).json({ error: "Token inválido" });
  }
});

router.post("/logout", (_req, res) => {
  res.clearCookie("token");
  res.json({ ok: true });
});

export default router;
