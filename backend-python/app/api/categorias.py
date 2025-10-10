from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..db import get_db
from ..models import Categoria
from ..schemas import CategoriaBase, CategoriaOut
from typing import List

router = APIRouter(prefix="/categorias", tags=["categorias"])

@router.get("/", response_model=List[CategoriaOut])
def listar(db: Session = Depends(get_db)):
    return db.query(Categoria).order_by(Categoria.ID.desc()).all()

@router.post("/", response_model=CategoriaOut)
def crear(body: CategoriaBase, db: Session = Depends(get_db)):
    c = Categoria(Nombre=body.Nombre)
    db.add(c); db.commit(); db.refresh(c)
    return c

@router.put("/{id}", response_model=CategoriaOut)
def editar(id: int, body: CategoriaBase, db: Session = Depends(get_db)):
    c = db.get(Categoria, id)
    if not c:
        raise HTTPException(404, "No existe")
    c.Nombre = body.Nombre
    db.commit(); db.refresh(c)
    return c

@router.delete("/{id}")
def borrar(id: int, db: Session = Depends(get_db)):
    c = db.get(Categoria, id)
    if not c:
        raise HTTPException(404, "No existe")
    db.delete(c); db.commit()
    return {"ok": True}
