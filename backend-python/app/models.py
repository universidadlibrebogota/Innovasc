from sqlalchemy import Column, Integer, String, DECIMAL, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from .db import Base

class Usuario(Base):
    __tablename__ = "usuarios"
    ID = Column(Integer, primary_key=True, index=True)
    Usuario = Column(String(255), nullable=False, unique=True)
    Password = Column(String(255), nullable=False)
    ID_Permission = Column(Integer, ForeignKey("permisos.ID"), nullable=True)
    permiso = relationship("Permiso", back_populates="usuarios")

class Permiso(Base):
    __tablename__ = "permisos"
    ID = Column(Integer, primary_key=True, index=True)
    Editar = Column(Boolean, default=False)
    Agregar = Column(Boolean, default=False)
    Entrada = Column(Boolean, default=False)
    Salida = Column(Boolean, default=False)
    Reportes = Column(Boolean, default=False)
    usuarios = relationship("Usuario", back_populates="permiso")

class Categoria(Base):
    __tablename__ = "categoria"
    ID = Column(Integer, primary_key=True, index=True)
    Nombre = Column(String(255), nullable=False)

class Producto(Base):
    __tablename__ = "productos"
    ID = Column(Integer, primary_key=True, index=True)
    Producto = Column(String(255), nullable=False)
    ID_Categoria = Column(Integer, ForeignKey("categoria.ID"))
    Precio_Caja = Column(DECIMAL(10,2))
    Cantidad = Column(Integer, default=0)

class Ajustes(Base):
    __tablename__ = "ajustes"
    ID = Column(Integer, primary_key=True, index=True)
    Modo_Nocturno = Column(Boolean, default=False)
    Stock_Minimo = Column(Integer, default=10)
    Porcentaje_Ganancia = Column(DECIMAL(5,2), default=10.00)
    Precio_Automatico = Column(Boolean, default=False)
    Nombre_Empresa = Column(String(255), default="")
    Ciudad = Column(String(255), default="")
    Direccion_Empresa = Column(String(255), default="")
    Logo_Empresa = Column(String(255), default="logo.png")
