import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";

export function authGuard(req: Request, res: Response, next: NextFunction) {
  if (req.path.startsWith("/auth") || req.path.startsWith("/health")) return next();
  const token = (req as any).cookies?.token || (req.headers?.cookie || "").split("token=")[1];
  if (!token) return res.status(401).json({ error: "No autenticado" });
  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET || "dev-secret");
    (req as any).user = payload;
    return next();
  } catch {
    return res.status(401).json({ error: "Token inválido" });
  }
}
