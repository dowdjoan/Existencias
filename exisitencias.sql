-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.39 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para existencias
CREATE DATABASE IF NOT EXISTS `existencias` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `existencias`;

-- Volcando estructura para tabla existencias.categorias
CREATE TABLE IF NOT EXISTS `categorias` (
  `id_categoria` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Nombre de la cateogia, ej : legumbres',
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Descripcion de las legumbres',
  `status` char(1) DEFAULT NULL COMMENT 'Estados: 0 inactivo, 1 activo, 2 suspendido',
  PRIMARY KEY (`id_categoria`),
  CONSTRAINT `FK_categorias_productos` FOREIGN KEY (`id_categoria`) REFERENCES `productos` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla existencias.categorias: ~0 rows (aproximadamente)

-- Volcando estructura para tabla existencias.ofertas
CREATE TABLE IF NOT EXISTS `ofertas` (
  `id_oferta` int unsigned NOT NULL AUTO_INCREMENT,
  `id_producto` int unsigned NOT NULL DEFAULT '0' COMMENT 'id producto en oferta',
  `descripcion` varchar(50) NOT NULL DEFAULT '0',
  `descuento` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `precio_descuento` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT 'precio final del producto en oferta',
  `fecha_inicio` date NOT NULL DEFAULT (0),
  `fecha_fin` date NOT NULL DEFAULT (0),
  `status` char(1) NOT NULL DEFAULT '0' COMMENT 'Estados: 0 inactiva, 1 activa, 2 suspendida',
  PRIMARY KEY (`id_oferta`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `FK_ofertas_productos` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla existencias.ofertas: ~0 rows (aproximadamente)

-- Volcando estructura para tabla existencias.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `id_producto` int unsigned NOT NULL AUTO_INCREMENT,
  `id_proveedor` int unsigned NOT NULL COMMENT 'tabla proveedores',
  `id_stock` int unsigned NOT NULL COMMENT 'tabla stock contendra toda la informacion sobre la cantidad de ese porducto en esa sucursal',
  `id_sucursal` smallint unsigned NOT NULL COMMENT 'puede haber multiples sucursales',
  `id_categoria` int unsigned NOT NULL COMMENT 'costos contendra toda la informacion sobre el costo de cada producto',
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `id_proveedor` (`id_proveedor`),
  KEY `id_stock` (`id_stock`),
  KEY `id_sucursal` (`id_sucursal`),
  KEY `id_costos` (`id_categoria`) USING BTREE,
  CONSTRAINT `FK_productos_categorias` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla existencias.productos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla existencias.proveedores
CREATE TABLE IF NOT EXISTS `proveedores` (
  `id_proveedor` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'estados : 0 inactivo, 1 activo, 2 suspendido',
  PRIMARY KEY (`id_proveedor`),
  CONSTRAINT `FK_proveedores_productos` FOREIGN KEY (`id_proveedor`) REFERENCES `productos` (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla existencias.proveedores: ~0 rows (aproximadamente)

-- Volcando estructura para tabla existencias.repartidor
CREATE TABLE IF NOT EXISTS `repartidor` (
  `id_repartidor` int NOT NULL AUTO_INCREMENT,
  `id_venta` int DEFAULT NULL COMMENT 'la venta a la que esta asociado a repartir',
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `costoEnvio` smallint DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `status` char(1) DEFAULT NULL COMMENT 'Estados: 0 inactivo, 1 activo, 2 suspendido',
  PRIMARY KEY (`id_repartidor`),
  KEY `id_venta` (`id_venta`),
  CONSTRAINT `FK_repartidor_ventas` FOREIGN KEY (`id_repartidor`) REFERENCES `ventas` (`id_repartidor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla existencias.repartidor: ~0 rows (aproximadamente)

-- Volcando estructura para tabla existencias.stock
CREATE TABLE IF NOT EXISTS `stock` (
  `id_stock` int unsigned NOT NULL AUTO_INCREMENT,
  `id_producto` int unsigned DEFAULT NULL,
  `id_sucursal` smallint unsigned DEFAULT NULL COMMENT 'stock de esa sucursal',
  `ubicacion` varchar(50) DEFAULT NULL COMMENT 'ubicacion dentro del espacio de almacenaminto como referencia',
  `cantidad` int DEFAULT NULL COMMENT 'cantidad disponible del producto',
  `fechaCompra` date DEFAULT NULL COMMENT 'fecha de ingreso del producto al stock',
  `costo` decimal(10,2) NOT NULL COMMENT 'Precio del costo del producto',
  `precioVenta` decimal(10,2) NOT NULL COMMENT 'Precio de venta al consumidor final',
  PRIMARY KEY (`id_stock`),
  KEY `id_producto` (`id_producto`),
  KEY `id_sucursal` (`id_sucursal`),
  CONSTRAINT `FK_stock_productos` FOREIGN KEY (`id_stock`) REFERENCES `productos` (`id_stock`),
  CONSTRAINT `FK_stock_sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla existencias.stock: ~0 rows (aproximadamente)

-- Volcando estructura para tabla existencias.sucursal
CREATE TABLE IF NOT EXISTS `sucursal` (
  `id_sucursal` smallint unsigned NOT NULL DEFAULT (0),
  `nombre` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) NOT NULL DEFAULT '0',
  `telefono` varchar(50) NOT NULL DEFAULT '0',
  `horarioApertura` varchar(50) NOT NULL DEFAULT '0',
  `horarioCierre` varchar(50) NOT NULL DEFAULT '0',
  `status` char(1) DEFAULT NULL COMMENT 'Estados: 0 inactiva, 1 activa, 2 suspendida',
  PRIMARY KEY (`id_sucursal`),
  CONSTRAINT `FK_sucursal_productos` FOREIGN KEY (`id_sucursal`) REFERENCES `productos` (`id_sucursal`),
  CONSTRAINT `FK_sucursal_ventas` FOREIGN KEY (`id_sucursal`) REFERENCES `ventas` (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla existencias.sucursal: ~0 rows (aproximadamente)

-- Volcando estructura para tabla existencias.ventas
CREATE TABLE IF NOT EXISTS `ventas` (
  `id_venta` int unsigned NOT NULL AUTO_INCREMENT,
  `id_repartidor` int DEFAULT NULL COMMENT 'si retira, null',
  `id_sucursal` smallint unsigned NOT NULL COMMENT 'sucursal de donde se genera la venta',
  `fecha` date DEFAULT NULL,
  `total` int DEFAULT NULL COMMENT 'total precio de venta',
  `envio` bit(1) DEFAULT NULL COMMENT '0 si retira, 1 si envia a domicilio',
  `metodo_pago` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_repartidor` (`id_repartidor`),
  KEY `id_sucursal` (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla existencias.ventas: ~0 rows (aproximadamente)

-- Volcando estructura para tabla existencias.ventas_detalle
CREATE TABLE IF NOT EXISTS `ventas_detalle` (
  `id_ventas_detalle` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ventas_id` int unsigned NOT NULL DEFAULT '0',
  `id_prod_id` int unsigned NOT NULL DEFAULT '0',
  `cantidad` int unsigned DEFAULT NULL,
  `precio` decimal(10,2) unsigned DEFAULT NULL,
  `costo` decimal(10,2) unsigned DEFAULT NULL,
  `direccion` int DEFAULT NULL COMMENT 'si es con envio direccion del comprador, sino null',
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'descripcion para el repartidor o algun detalle de la venta',
  PRIMARY KEY (`id_ventas_detalle`),
  KEY `id_ventas_id` (`id_ventas_id`),
  KEY `id_prod_id` (`id_prod_id`),
  CONSTRAINT `FK_ventas_detalle_productos` FOREIGN KEY (`id_prod_id`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `FK_ventas_detalle_ventas` FOREIGN KEY (`id_ventas_id`) REFERENCES `ventas` (`id_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla existencias.ventas_detalle: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
