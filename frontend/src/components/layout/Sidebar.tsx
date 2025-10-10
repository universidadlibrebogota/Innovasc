import Link from "next/link";

export default function Sidebar() {
  return (
    <aside className="sidebar">
      <div className="logo">
        <img src="/uploads/logo.png" alt="Logo" />
        <h2>InovaASC</h2>
      </div>
      <nav className="menu">
        <ul>
          <li><Link href="/dashboard">Dashboard</Link></li>
          <li><Link href="/productos">Productos</Link></li>
          <li><Link href="/ajustes">Ajustes</Link></li>
        </ul>
      </nav>
    </aside>
  );
}
