from pydantic import BaseSettings, AnyUrl, validator
from typing import Optional
import secrets

class Settings(BaseSettings):
    ENV: str = "dev"
    SECRET_KEY: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 15
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7
    ALGORITHM: str = "HS256" 

    DB_URL: AnyUrl
    INSTALL_TOKEN: Optional[str] = None  # Para registro inicial

    @validator("SECRET_KEY")
    def ensure_strong_secret(cls, v):
        if len(v) < 32:
            raise ValueError("SECRET_KEY demasiado corto (>=32 chars).")
        return v

settings = Settings()  # levanta desde variables de entorno
