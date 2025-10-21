from fastapi import APIRouter, UploadFile, File, HTTPException, Depends
from app.core.security import require_role
import os, uuid
from pathlib import Path

router = APIRouter(prefix="/uploads", tags=["uploads"],
                   dependencies=[Depends(require_role("admin"))])

ALLOWED_MIME = {"image/png","image/jpeg","image/svg+xml"}
MAX_BYTES = 2 * 1024 * 1024
UPLOAD_DIR = Path("/var/app_data/uploads")  # fuera del árbol ejecutable

@router.post("/logo")
async def upload_logo(file: UploadFile = File(...)):
    if file.content_type not in ALLOWED_MIME:
        raise HTTPException(400, "Tipo de archivo no permitido")
    data = await file.read()
    if len(data) > MAX_BYTES:
        raise HTTPException(400, "Archivo demasiado grande (<=2MB)")
    # (Opcional) verificar magic bytes si instalas python-magic
    UPLOAD_DIR.mkdir(parents=True, exist_ok=True)
    name = f"logo-{uuid.uuid4().hex}"
    ext = ".png" if file.content_type=="image/png" else ".jpg" if file.content_type=="image/jpeg" else ".svg"
    path = UPLOAD_DIR / (name+ext)
    with open(path, "wb") as f:
        f.write(data)
    return {"path": f"/media/{path.name}"}
