"use client";
import Sidebar from "@/components/layout/Sidebar";
import Header from "@/components/layout/Header";
import IngresosChart from "@/components/charts/IngresosChart";
import { useEffect, useState } from "react";
import { api } from "@/lib/api";
import { MetricsResumen } from "@/types";

export default function Dashboard() {
  const [m, setM] = useState<MetricsResumen | null>(null);
  useEffect(()=>{ api<MetricsResumen>("/api/metrics/resumen").then(setM); },[]);
  return (
    <div className="container">
      <Sidebar/>
      <main className="main-content">
        <Header title="Dashboard" />
        <div className="card p-3 mb-3">
          <div>Productos totales: <b>{m?.totalProductos ?? 0}</b> | Stock bajo: <b>{m?.stockBajo ?? 0}</b></div>
        </div>
        <div className="card p-3">
          <IngresosChart data={[0.1,0.3,0.5,0.7,0.9,1.0]} />
        </div>
      </main>
    </div>
  );
}
