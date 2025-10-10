from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..db import get_db
from ..models import Producto
from ..schemas import ProductoBase, ProductoOut
from typing import List

router = APIRouter(prefix="/productos", tags=["productos"])

@router.get("/", response_model=List[ProductoOut])
def listar(db: Session = Depends(get_db)):
    return db.query(Producto).order_by(Producto.ID.desc()).all()

@router.post("/", response_model=ProductoOut)
def crear(body: ProductoBase, db: Session = Depends(get_db)):
    p = Producto(**body.dict())
    db.add(p); db.commit(); db.refresh(p)
    return p

@router.put("/{id}", response_model=ProductoOut)
def editar(id: int, body: ProductoBase, db: Session = Depends(get_db)):
    p = db.get(Producto, id)
    if not p:
        raise HTTPException(404, "No existe")
    for k,v in body.dict().items():
        setattr(p, k, v)
    db.commit(); db.refresh(p)
    return p

@router.delete("/{id}")
def borrar(id: int, db: Session = Depends(get_db)):
    p = db.get(Producto, id)
    if not p:
        raise HTTPException(404, "No existe")
    db.delete(p); db.commit()
    return {"ok": True}
