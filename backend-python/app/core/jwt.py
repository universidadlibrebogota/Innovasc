from datetime import datetime, timedelta
from typing import Optional, Dict
import jwt
from .settings import settings

def _encode(payload: Dict, expires_delta: timedelta) -> str:
    to_encode = payload.copy()
    to_encode["exp"] = datetime.utcnow() + expires_delta
    to_encode["iat"] = datetime.utcnow()
    return jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)

def create_access_token(sub: str, extra: Optional[Dict]=None) -> str:
    payload = {"sub": sub, "typ": "access"}
    if extra: payload.update(extra)
    return _encode(payload, timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES))

def create_refresh_token(sub: str) -> str:
    return _encode({"sub": sub, "typ": "refresh"}, timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS))

def decode_token(token: str) -> Dict:
    return jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
