"use client";
import Sidebar from "@/components/layout/Sidebar";
import Header from "@/components/layout/Header";
import ProductTable from "@/components/productos/ProductTable";
import ProductForm from "@/components/productos/ProductForm";
import { useEffect, useState } from "react";
import { api } from "@/lib/api";
import { Producto, Categoria } from "@/types";

export default function ProductosPage() {
  const [productos, setProductos] = useState<Producto[]>([]);
  const [categorias, setCategorias] = useState<Categoria[]>([]);
  const load = async () => {
    setProductos(await api<Producto[]>("/api/productos"));
    setCategorias(await api<Categoria[]>("/api/categorias"));
  };
  useEffect(()=>{ load(); },[]);
  const create = async (fd: FormData) => {
    const body = Object.fromEntries(fd.entries());
    await api<Producto>("/api/productos", { method: "POST", body: JSON.stringify(body) });
    await load();
  };
  return (
    <div className="container">
      <Sidebar/>
      <main className="main-content">
        <Header title="Productos" />
        <ProductForm categorias={categorias} onSubmit={create}/>
        <ProductTable productos={productos} categorias={categorias}/>
      </main>
    </div>
  );
}
