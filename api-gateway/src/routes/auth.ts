import { Router } from "express";
import jwt from "jsonwebtoken";
import fetch from "node-fetch";

const router = Router();
const { JWT_SECRET, BACKEND_URL, COOKIE_SECURE="true", NODE_ENV } = process.env;

router.post("/login", async (req, res) => {
  const r = await fetch(`${BACKEND_URL}/auth/login`, {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify(req.body)
  });
  if (!r.ok) return res.status(r.status).json(await r.json());

  const { access_token, refresh_token } = await r.json();
  // Validar/filtrar claims si necesitas, pero no re-firmes; usa el que emite FastAPI

  const isProd = NODE_ENV === "production";
  const secure = COOKIE_SECURE === "true" || isProd;

  res.cookie("token", access_token, {
    httpOnly: true,
    secure,
    sameSite: "strict",   // si no hay necesidad de terceros
    maxAge: 1000 * 60 * 15,
    path: "/"
  });
  res.cookie("rtk", refresh_token, {
    httpOnly: true,
    secure,
    sameSite: "strict",
    maxAge: 1000 * 60 * 60 * 24 * 7,
    path: "/api/auth/refresh"
  });
  return res.json({ ok: true });
});

export default router;
