export type Categoria = { ID: number; Nombre: string };
export type Producto = { ID: number; Producto: string; ID_Categoria: number; Precio_Caja: number; Cantidad: number };
export type Ajustes = { ID: number; Modo_Nocturno: boolean; Stock_Minimo: number; Porcentaje_Ganancia: number; Precio_Automatico: boolean; Nombre_Empresa: string; Ciudad: string; Direccion_Empresa: string; Logo_Empresa: string; };
export type MetricsResumen = { totalProductos: number; stockBajo: number };
