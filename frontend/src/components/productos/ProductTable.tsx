import { Producto, Categoria } from "@/types";

export default function ProductTable({ productos, categorias }: { productos: Producto[]; categorias: Categoria[] }) {
  const catName = (id: number) => categorias.find(c => c.ID === id)?.Nombre || "-";
  return (
    <div className="products-list">
      <table>
        <thead>
          <tr><th>Producto</th><th>Categoría</th><th>Precio Caja</th><th>Cantidad</th><th>Acciones</th></tr>
        </thead>
        <tbody>
          {productos.map(p=>(
            <tr key={p.ID}>
              <td>{p.Producto}</td>
              <td>{catName(p.ID_Categoria)}</td>
              <td>${p.Precio_Caja}</td>
              <td>{p.Cantidad}</td>
              <td>
                <button className="btn-edit">Editar</button>
                <button className="btn-delete ms-2">Eliminar</button>
              </td>
            </tr>
          ))}
          {productos.length===0 && (
            <tr><td colSpan={5}><div className="no-products">No hay productos</div></td></tr>
          )}
        </tbody>
      </table>
    </div>
  );
}
