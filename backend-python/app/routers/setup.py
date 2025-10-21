from fastapi import APIRouter, Header, HTTPException
from app.core.settings import settings
from app.db import any_users_exist, create_admin_user

router = APIRouter(prefix="/setup", tags=["setup"])

@router.post("/register-admin")
async def register_admin(email: str, password: str, x_install_token: str = Header(None)):
    if await any_users_exist():
        raise HTTPException(409, "Ya existe un usuario, usa flujo normal")
    if not settings.INSTALL_TOKEN or x_install_token != settings.INSTALL_TOKEN:
        raise HTTPException(403, "Token de instalación inválido")
    await create_admin_user(email, password)
    return {"ok": True}
