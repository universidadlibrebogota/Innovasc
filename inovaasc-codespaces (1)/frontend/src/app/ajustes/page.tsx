import Sidebar from "@/components/layout/Sidebar";
import Header from "@/components/layout/Header";
import AjustesTabs from "@/components/ajustes/AjustesTabs";

export default function AjustesPage() {
  return (
    <div className="container">
      <Sidebar/>
      <main className="main-content">
        <Header title="Ajustes" />
        <AjustesTabs/>
      </main>
    </div>
  );
}
