"use client";
import { useState } from "react";
import { Categoria } from "@/types";

export default function ProductForm({ categorias, onSubmit }: { categorias: Categoria[]; onSubmit: (f: FormData)=>void }) {
  const [open, setOpen] = useState(false);
  return (
    <div className="form-container">
      <button id="btn-agregar" className="btn-primary mb-3" onClick={()=>setOpen(true)}>Agregar</button>
      {open && (
        <form id="form-agregar" onSubmit={(e:any)=>{e.preventDefault(); onSubmit(new FormData(e.currentTarget)); setOpen(false);}}>
          <div className="form-group">
            <label>Producto</label>
            <input name="Producto" className="form-control" required/>
          </div>
          <div className="form-group">
            <label>Categoría</label>
            <select name="ID_Categoria" className="form-control" required>
              {categorias.map(c=> <option key={c.ID} value={c.ID}>{c.Nombre}</option>)}
            </select>
          </div>
          <div className="form-group">
            <label>Precio Caja</label>
            <input name="Precio_Caja" type="number" step="0.01" className="form-control" required/>
          </div>
          <div className="form-group">
            <label>Cantidad</label>
            <input name="Cantidad" type="number" className="form-control" required/>
          </div>
          <button className="btn-primary">Guardar</button>
          <button type="button" className="btn-secondary ms-2" onClick={()=>setOpen(false)}>Cancelar</button>
        </form>
      )}
    </div>
  );
}
