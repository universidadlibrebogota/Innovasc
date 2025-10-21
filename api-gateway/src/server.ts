import express from "express";
import cookieParser from "cookie-parser";
import helmet from "helmet";
import rateLimit from "express-rate-limit";
import jwt from "jsonwebtoken";
import proxy from "express-http-proxy";

const { JWT_SECRET, BACKEND_URL, NODE_ENV } = process.env;
if (!JWT_SECRET) { throw new Error("Falta JWT_SECRET"); }
if (!BACKEND_URL) { throw new Error("Falta BACKEND_URL"); }

const app = express();
app.use(helmet());
app.use(cookieParser());
app.use(express.json());

// Rate limit login y auth
const authLimiter = rateLimit({ windowMs: 15*60*1000, max: 20, standardHeaders: true, legacyHeaders: false });
app.use("/api/auth/login", authLimiter);

// Guard genérico (lista blanca explícita)
const whitelist = new Set<string>([
  "/api/auth/login", "/api/auth/refresh", "/health"
]);

app.use((req, res, next) => {
  if (whitelist.has(req.path)) return next();
  const token = req.cookies?.token;
  if (!token) return res.status(401).json({ error: "No token" });
  try {
    // Valida sin exponer claims extra
    const payload: any = jwt.verify(token, JWT_SECRET!);
    // Reenvía Authorization al backend para que sea la fuente de verdad
    (req as any)._forwardAuth = `Bearer ${token}`;
    (req as any)._user = { sub: payload.sub, role: payload.role };
    return next();
  } catch {
    return res.status(401).json({ error: "Invalid/expired token" });
  }
});

// Proxy: añade Authorization al backend
app.use("/api", proxy(BACKEND_URL!, {
  proxyReqOptDecorator: (proxyReqOpts, srcReq: any) => {
    if (srcReq._forwardAuth) proxyReqOpts.headers!["Authorization"] = srcReq._forwardAuth;
    return proxyReqOpts;
  }
}));

app.set("trust proxy", 1);
app.listen(4000, () => console.log("Gateway on :4000"));
