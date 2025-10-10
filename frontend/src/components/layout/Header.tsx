export default function Header({ title }: { title: string }) {
  return (
    <header className="header">
      <h1>{title}</h1>
      <div className="user-info">Usuario</div>
    </header>
  );
}
