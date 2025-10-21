from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from app.core.jwt import create_access_token, create_refresh_token
from app.core.settings import settings
from app.db import get_user_by_email, verify_password  # supón implementados

router = APIRouter(prefix="/auth", tags=["auth"])

class LoginIn(BaseModel):
    email: str
    password: str

@router.post("/login")
async def login(data: LoginIn):
    user = await get_user_by_email(data.email)
    if not user or not verify_password(data.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Credenciales inválidas")
    # Filtra claims explícitamente
    access = create_access_token(sub=str(user.id), extra={"email": user.email, "role": user.role})
    refresh = create_refresh_token(sub=str(user.id))
    return {"access_token": access, "refresh_token": refresh}  # el gateway pondrá cookies
