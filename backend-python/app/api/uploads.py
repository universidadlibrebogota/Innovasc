from fastapi import APIRouter, Depends, UploadFile, File
from sqlalchemy.orm import Session
from ..db import get_db
from ..models import Ajustes
import os

router = APIRouter(prefix="/uploads", tags=["uploads"])
UPLOAD_DIR = os.getenv("UPLOAD_DIR", "uploads")

@router.post("/logo")
def subir_logo(file: UploadFile = File(...), db: Session = Depends(get_db)):
    os.makedirs(UPLOAD_DIR, exist_ok=True)
    dest = os.path.join(UPLOAD_DIR, file.filename)
    with open(dest, "wb") as f:
        f.write(file.file.read())
    a = db.query(Ajustes).first()
    if not a:
        from ..models import Ajustes as Aj
        a = Aj(); db.add(a)
    a.Logo_Empresa = file.filename
    db.commit()
    return {"ok": True, "filename": file.filename}
