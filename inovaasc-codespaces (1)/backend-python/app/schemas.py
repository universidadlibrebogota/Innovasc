from pydantic import BaseModel
from typing import Optional, List

class UsuarioCreate(BaseModel):
    Usuario: str
    Password: str

class MeResponse(BaseModel):
    ID: int
    Usuario: str
    ID_Permission: Optional[int] = None

class CategoriaBase(BaseModel):
    Nombre: str
class CategoriaOut(CategoriaBase):
    ID: int
    class Config:
        from_attributes = True

class ProductoBase(BaseModel):
    Producto: str
    ID_Categoria: int
    Precio_Caja: float
    Cantidad: int
class ProductoOut(ProductoBase):
    ID: int
    class Config:
        from_attributes = True

class AjustesBase(BaseModel):
    Modo_Nocturno: bool
    Stock_Minimo: int
    Porcentaje_Ganancia: float
    Precio_Automatico: bool
    Nombre_Empresa: str
    Ciudad: str
    Direccion_Empresa: str
    Logo_Empresa: str
class AjustesOut(AjustesBase):
    ID: int
    class Config:
        from_attributes = True

class MetricsResumen(BaseModel):
    totalProductos: int
    stockBajo: int
