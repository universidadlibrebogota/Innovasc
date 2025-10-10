from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..db import get_db
from ..models import Usuario
from ..security import verify_password, hash_password
from ..schemas import UsuarioCreate, MeResponse

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/login", response_model=MeResponse)
def login(data: UsuarioCreate, db: Session = Depends(get_db)):
    user = db.query(Usuario).filter(Usuario.Usuario == data.Usuario).first()
    if not user or not verify_password(data.Password, user.Password):
        raise HTTPException(status_code=401, detail="Credenciales inválidas")
    return MeResponse(ID=user.ID, Usuario=user.Usuario, ID_Permission=user.ID_Permission)

@router.post("/register-admin", response_model=MeResponse)
def register_admin(data: UsuarioCreate, db: Session = Depends(get_db)):
    exists = db.query(Usuario).count()
    if exists > 0:
        raise HTTPException(400, "Ya existe un usuario. Registro de admin sólo si no hay usuarios.")
    u = Usuario(Usuario=data.Usuario, Password=hash_password(data.Password))
    db.add(u); db.commit(); db.refresh(u)
    return MeResponse(ID=u.ID, Usuario=u.Usuario, ID_Permission=u.ID_Permission)
