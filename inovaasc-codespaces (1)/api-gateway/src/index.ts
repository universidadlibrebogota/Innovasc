import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import dotenv from "dotenv";
import authRoutes from "./routes/auth";
import health from "./routes/health";
import { createProxyMiddleware } from "http-proxy-middleware";
import { authGuard } from "./middleware/auth";

dotenv.config();
const app = express();

const allow = (process.env.CORS_ORIGIN || "").split(",").map(s => s.trim()).filter(Boolean);
const regexEnv = process.env.CORS_REGEX ? new RegExp(process.env.CORS_REGEX) : null;

app.use(cors({
  origin: (origin, cb) => {
    if (!origin) return cb(null, true);
    if (allow.includes(origin)) return cb(null, true);
    if (regexEnv && regexEnv.test(origin)) return cb(null, true);
    return cb(new Error("CORS blocked"));
  },
  credentials: true
}));

app.use(express.json());
app.use(cookieParser());

app.use("/api/health", health);
app.use("/api/auth", authRoutes);

const backendUrl = process.env.BACKEND_URL || "http://127.0.0.1:8000";
app.use("/api", authGuard, createProxyMiddleware({
  target: backendUrl,
  changeOrigin: true,
  pathRewrite: { "^/api": "" }
}));

const port = Number(process.env.GW_PORT || 4000);
app.listen(port, () => console.log(`Gateway en http://localhost:${port}`));
