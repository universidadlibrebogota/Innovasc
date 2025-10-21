
from fastapi import Depends, HTTPException, status, Request
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from .jwt import decode_token
from typing import Dict

bearer_scheme = HTTPBearer(auto_error=False)

def _extract_token(req: Request, creds: HTTPAuthorizationCredentials):
    # 1) Authorization: Bearer <token> (preferido)
    if creds and creds.scheme.lower() == "bearer":
        return creds.credentials
    # 2) Cookie httpOnly "token" (opcional si gateway no lo reenvía)
    token = req.cookies.get("token")
    return token

async def get_current_user(req: Request, creds: HTTPAuthorizationCredentials = Depends(bearer_scheme)) -> Dict:
    token = _extract_token(req, creds)
    if not token:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="No auth token")
    try:
        payload = decode_token(token)
        if payload.get("typ") != "access":
            raise ValueError("not access token")
        return payload  # incluye sub y claims
    except Exception:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid/expired token")

def require_role(*roles: str):
    async def _inner(user = Depends(get_current_user)):
        if roles:
            if user.get("role") not in roles:
                raise HTTPException(status_code=403, detail="Forbidden")
        return user
    return _inner
