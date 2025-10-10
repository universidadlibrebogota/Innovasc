"use client";
import { Line } from "react-chartjs-2";
import { Chart as ChartJS, LineElement, PointElement, LinearScale, CategoryScale } from "chart.js";
ChartJS.register(LineElement, PointElement, LinearScale, CategoryScale);

export default function IngresosChart({ data }: { data: number[] }) {
  const cfg = {
    labels: ["Domingo","Lunes","Martes","Miércoles","Jueves","Sábado"],
    datasets: [{
      label: "Ingresos",
      data,
      borderColor: "#e67e22",
      backgroundColor: "rgba(230, 126, 34, 0.1)",
      tension: 0.4,
      fill: true
    }]
  };
  return <Line data={cfg as any} />;
}
