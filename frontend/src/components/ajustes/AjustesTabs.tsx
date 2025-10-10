"use client";
import { useEffect, useState } from "react";
import { Ajustes } from "@/types";
import { api } from "@/lib/api";

export default function AjustesTabs() {
  const [active, setActive] = useState("general");
  const [a, setA] = useState<Ajustes|null>(null);
  useEffect(()=>{ api<Ajustes>("/api/ajustes").then(setA); },[]);
  const save = async (e:any) => {
    e.preventDefault();
    const entries = Object.fromEntries(new FormData(e.currentTarget).entries());
    const payload:any = { ...entries };
    payload.Modo_Nocturno = String(payload.Modo_Nocturno) === "true";
    payload.Precio_Automatico = String(payload.Precio_Automatico) === "true";
    payload.Stock_Minimo = Number(payload.Stock_Minimo);
    payload.Porcentaje_Ganancia = Number(payload.Porcentaje_Ganancia);
    await api<Ajustes>("/api/ajustes", { method: "PUT", body: JSON.stringify(payload) });
    setA(await api<Ajustes>("/api/ajustes"));
  };
  if(!a) return null;
  return (
    <div className="ajustes">
      <div className="ajuste-items">
        <div className={`ajuste-item ${active==="general"?"active":""}`} data-tab="general" onClick={()=>setActive("general")}>General</div>
        <div className={`ajuste-item ${active==="empresa"?"active":""}`} data-tab="empresa" onClick={()=>setActive("empresa")}>Empresa</div>
      </div>
      <form className="content-ajuste active" id={active} onSubmit={save}>
        {active==="general" && (
          <>
            <div className="form-group">
              <label>Modo Nocturno</label>
              <select name="Modo_Nocturno" className="form-control" defaultValue={String(a.Modo_Nocturno)}>
                <option value="false">No</option><option value="true">Sí</option>
              </select>
            </div>
            <div className="form-group">
              <label>Stock Mínimo</label>
              <input name="Stock_Minimo" type="number" className="form-control" defaultValue={a.Stock_Minimo}/>
            </div>
            <div className="form-group">
              <label>% Ganancia</label>
              <input name="Porcentaje_Ganancia" type="number" step="0.01" className="form-control" defaultValue={a.Porcentaje_Ganancia}/>
            </div>
            <div className="form-group">
              <label>Precio Automático</label>
              <select name="Precio_Automatico" className="form-control" defaultValue={String(a.Precio_Automatico)}>
                <option value="false">No</option><option value="true">Sí</option>
              </select>
            </div>
          </>
        )}
        {active==="empresa" && (
          <>
            <div className="form-group"><label>Nombre</label><input name="Nombre_Empresa" className="form-control" defaultValue={a.Nombre_Empresa}/></div>
            <div className="form-group"><label>Ciudad</label><input name="Ciudad" className="form-control" defaultValue={a.Ciudad}/></div>
            <div className="form-group"><label>Dirección</label><input name="Direccion_Empresa" className="form-control" defaultValue={a.Direccion_Empresa}/></div>
          </>
        )}
        <button className="btn-primary mt-3">Guardar</button>
      </form>
    </div>
  );
}
