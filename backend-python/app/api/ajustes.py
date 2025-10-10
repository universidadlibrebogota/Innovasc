from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from ..db import get_db
from ..models import Ajustes
from ..schemas import AjustesOut, AjustesBase

router = APIRouter(prefix="/ajustes", tags=["ajustes"])

@router.get("/", response_model=AjustesOut)
def get_ajustes(db: Session = Depends(get_db)):
    a = db.query(Ajustes).first()
    if not a:
        a = Ajustes()
        db.add(a); db.commit(); db.refresh(a)
    return a

@router.put("/", response_model=AjustesOut)
def update_ajustes(body: AjustesBase, db: Session = Depends(get_db)):
    a = db.query(Ajustes).first()
    if not a:
        a = Ajustes(); db.add(a)
    for k,v in body.dict().items():
        setattr(a, k, v)
    db.commit(); db.refresh(a)
    return a
