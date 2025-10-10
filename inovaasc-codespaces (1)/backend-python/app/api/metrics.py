from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from ..db import get_db
from ..models import Producto, Ajustes
from ..schemas import MetricsResumen

router = APIRouter(prefix="/metrics", tags=["metrics"])

@router.get("/resumen", response_model=MetricsResumen)
def resumen(db: Session = Depends(get_db)):
    total = db.query(Producto).count()
    a = db.query(Ajustes).first()
    stock_min = a.Stock_Minimo if a else 10
    stock_bajo = db.query(Producto).filter(Producto.Cantidad <= stock_min).count()
    return MetricsResumen(totalProductos=total, stockBajo=stock_bajo)
