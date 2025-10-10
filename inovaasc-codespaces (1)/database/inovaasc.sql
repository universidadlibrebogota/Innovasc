-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-09-2025 a las 20:08:23
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inovaasc`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ajustes`
--

CREATE TABLE `ajustes` (
  `ID` int(11) NOT NULL,
  `Ganancia` decimal(10,2) DEFAULT 0.00,
  `Porcentaje` tinyint(1) DEFAULT 0,
  `Stock` int(11) DEFAULT 10,
  `Nombre_Empresa` varchar(255) DEFAULT NULL,
  `Ciudad` varchar(255) DEFAULT NULL,
  `Direccion` varchar(255) DEFAULT NULL,
  `Modo_Nocturno` tinyint(1) DEFAULT 0,
  `Stock_Minimo` int(11) DEFAULT 10,
  `Porcentaje_Ganancia` decimal(5,2) DEFAULT 10.00,
  `Precio_Automatico` tinyint(1) DEFAULT 0,
  `Nit_Empresa` varchar(45) DEFAULT '',
  `Direccion_Empresa` varchar(255) DEFAULT '',
  `Logo_Empresa` varchar(255) DEFAULT 'logo.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ajustes`
--

INSERT INTO `ajustes` (`ID`, `Ganancia`, `Porcentaje`, `Stock`, `Nombre_Empresa`, `Ciudad`, `Direccion`, `Modo_Nocturno`, `Stock_Minimo`, `Porcentaje_Ganancia`, `Precio_Automatico`, `Nit_Empresa`, `Direccion_Empresa`, `Logo_Empresa`) VALUES
(1, 0.00, 0, 10, 'InnovaASC', 'Bogotá', 'Carrera 1 # 1-1', 0, 10, 10.00, 0, '', '', 'logo.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `ID` int(11) NOT NULL,
  `NT` varchar(45) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Telefono` varchar(45) DEFAULT NULL,
  `Direccion` varchar(255) DEFAULT NULL,
  `Ciudad` varchar(255) DEFAULT NULL,
  `Correo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_factura_entrada`
--

CREATE TABLE `detalle_factura_entrada` (
  `ID` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Producto` varchar(255) NOT NULL,
  `Precio_caja` decimal(10,2) NOT NULL,
  `Sub_total` decimal(10,2) NOT NULL,
  `ID_Factura` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_factura_salida`
--

CREATE TABLE `detalle_factura_salida` (
  `ID` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Producto` varchar(255) NOT NULL,
  `Precio_caja` decimal(10,2) NOT NULL,
  `Sub_total` decimal(10,2) NOT NULL,
  `Nro_Factura` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_historial`
--

CREATE TABLE `detalle_historial` (
  `ID` int(11) NOT NULL,
  `Detall` varchar(255) NOT NULL,
  `ID_Historial` int(11) NOT NULL,
  `ID_User` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distribuidores`
--

CREATE TABLE `distribuidores` (
  `ID` int(11) NOT NULL,
  `NIT` varchar(45) NOT NULL,
  `Nombre_Empresa` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `Telefono` varchar(45) NOT NULL,
  `Ciudad` varchar(255) NOT NULL,
  `Estado` varchar(45) DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas_entrada`
--

CREATE TABLE `facturas_entrada` (
  `ID` int(11) NOT NULL,
  `Nro_Factura` varchar(11) NOT NULL,
  `NT` varchar(45) NOT NULL,
  `Fecha` varchar(10) NOT NULL,
  `Total` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas_salida`
--

CREATE TABLE `facturas_salida` (
  `ID` int(11) NOT NULL,
  `Nro_Factura` varchar(11) NOT NULL,
  `NC` varchar(45) NOT NULL,
  `Fecha` varchar(45) NOT NULL,
  `Total` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial`
--

CREATE TABLE `historial` (
  `ID` int(11) NOT NULL,
  `Fecha` varchar(45) NOT NULL,
  `Hora` varchar(255) NOT NULL,
  `Accion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `ID` int(11) NOT NULL,
  `Editar` tinyint(1) DEFAULT 0,
  `Agregar` tinyint(1) DEFAULT 0,
  `Entrada` tinyint(1) DEFAULT 0,
  `Facturar` tinyint(1) DEFAULT 0,
  `Clientes` tinyint(1) DEFAULT 0,
  `Proveedores` tinyint(1) DEFAULT 0,
  `Reportes` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`ID`, `Editar`, `Agregar`, `Entrada`, `Facturar`, `Clientes`, `Proveedores`, `Reportes`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `ID` int(11) NOT NULL,
  `Producto` varchar(255) NOT NULL,
  `Categoria` varchar(45) DEFAULT NULL,
  `Precio_Caja` decimal(10,2) NOT NULL,
  `Imagen` varchar(255) DEFAULT NULL,
  `ID_Categoria` int(11) DEFAULT NULL,
  `Cantidad` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `ID` int(11) NOT NULL,
  `NT` varchar(45) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Direccion` varchar(255) DEFAULT NULL,
  `Ciudad` varchar(255) DEFAULT NULL,
  `Telefono` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID` int(11) NOT NULL,
  `Usuario` varchar(255) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `ID_Permission` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID`, `Usuario`, `Nombre`, `Email`, `Password`, `ID_Permission`) VALUES
(1, 'mariapaula.manrique1218@gmail.com', 'Maria Manrique', 'mariapaula.manrique1210@gmail.com', '$2y$10$Al9AkodS3NiN6mmrwRD8peC3bKYrZ8TiPpTMpgG4BMomLYMjKqql.', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ajustes`
--
ALTER TABLE `ajustes`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `NT` (`NT`);

--
-- Indices de la tabla `detalle_factura_entrada`
--
ALTER TABLE `detalle_factura_entrada`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_Factura` (`ID_Factura`);

--
-- Indices de la tabla `detalle_factura_salida`
--
ALTER TABLE `detalle_factura_salida`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Nro_Factura` (`Nro_Factura`);

--
-- Indices de la tabla `detalle_historial`
--
ALTER TABLE `detalle_historial`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_Historial` (`ID_Historial`),
  ADD KEY `ID_User` (`ID_User`);

--
-- Indices de la tabla `distribuidores`
--
ALTER TABLE `distribuidores`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `NIT` (`NIT`);

--
-- Indices de la tabla `facturas_entrada`
--
ALTER TABLE `facturas_entrada`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `NT` (`NT`);

--
-- Indices de la tabla `facturas_salida`
--
ALTER TABLE `facturas_salida`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `NT` (`NT`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ajustes`
--
ALTER TABLE `ajustes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_factura_entrada`
--
ALTER TABLE `detalle_factura_entrada`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_factura_salida`
--
ALTER TABLE `detalle_factura_salida`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_historial`
--
ALTER TABLE `detalle_historial`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `distribuidores`
--
ALTER TABLE `distribuidores`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `facturas_entrada`
--
ALTER TABLE `facturas_entrada`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `facturas_salida`
--
ALTER TABLE `facturas_salida`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial`
--
ALTER TABLE `historial`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
