"use client";
import { useState } from "react";
import { login } from "@/lib/auth";
import { useRouter } from "next/navigation";

export default function LoginPage() {
  const [Usuario, setU] = useState(""); const [Password, setP] = useState("");
  const [err, setErr] = useState(""); const router = useRouter();
  const onSubmit = async (e: any) => {
    e.preventDefault();
    try { await login(Usuario, Password); router.push("/dashboard"); }
    catch (e: any) { setErr("Credenciales inválidas"); }
  };
  return (
    <main className="container d-flex align-items-center justify-content-center" style={{minHeight:"100vh"}}>
      <form className="p-4 border rounded bg-white" onSubmit={onSubmit} style={{minWidth: 320}}>
        <h1 className="h4 mb-3 text-center">Iniciar sesión</h1>
        {err && <div className="alert alert-danger py-2">{err}</div>}
        <div className="mb-3"><label className="form-label">Usuario</label><input className="form-control" value={Usuario} onChange={e=>setU(e.target.value)} required/></div>
        <div className="mb-3"><label className="form-label">Contraseña</label><input type="password" className="form-control" value={Password} onChange={e=>setP(e.target.value)} required/></div>
        <button className="btn btn-primary w-100">Entrar</button>
      </form>
    </main>
  );
}
