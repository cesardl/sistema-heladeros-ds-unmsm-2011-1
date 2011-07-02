/*
MySQL Data Transfer
Source Host: localhost
Source Database: heladeros
Target Host: localhost
Target Database: heladeros
Date: 01/07/2011 19:45:41
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for concepto
-- ----------------------------
DROP TABLE IF EXISTS `concepto`;
CREATE TABLE `concepto` (
  `id_concepto` int(11) NOT NULL auto_increment,
  `numero_concepto` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  PRIMARY KEY  (`id_concepto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for concesionario
-- ----------------------------
DROP TABLE IF EXISTS `concesionario`;
CREATE TABLE `concesionario` (
  `id_concesionario` int(11) NOT NULL auto_increment,
  `nombre_conces` varchar(45) NOT NULL,
  `distrito` varchar(45) NOT NULL,
  `propietario` varchar(45) NOT NULL,
  PRIMARY KEY  (`id_concesionario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for contrato_heladero
-- ----------------------------
DROP TABLE IF EXISTS `contrato_heladero`;
CREATE TABLE `contrato_heladero` (
  `idcontrato_heladero` int(11) NOT NULL auto_increment,
  `id_heladero` int(11) NOT NULL,
  `numero_contrato` int(11) NOT NULL,
  `tipo` varchar(45) NOT NULL,
  `contenido` varchar(45) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY  (`idcontrato_heladero`),
  KEY `fk_contrato_heladero_heladero1` (`id_heladero`),
  CONSTRAINT `fk_contrato_heladero_heladero1` FOREIGN KEY (`id_heladero`) REFERENCES `heladero` (`id_heladero`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for detalle_helado
-- ----------------------------
DROP TABLE IF EXISTS `detalle_helado`;
CREATE TABLE `detalle_helado` (
  `id_detalle_helado` int(11) NOT NULL auto_increment,
  `id_helado` int(11) NOT NULL,
  `id_helados_entregado_recibido` int(11) NOT NULL,
  `id_pago_helado` int(11) default NULL,
  `cant_entregada` int(11) NOT NULL,
  `cant_devuelta` int(11) NOT NULL,
  `cant_vendida` int(11) NOT NULL,
  PRIMARY KEY  (`id_detalle_helado`),
  KEY `fk_detalle_helado_helado1` (`id_helado`),
  KEY `fk_detalle_helado_helados_entregado_recibido1` (`id_helados_entregado_recibido`),
  KEY `fk_detalle_helado_pago_helado1` (`id_pago_helado`),
  CONSTRAINT `fk_detalle_helado_helado1` FOREIGN KEY (`id_helado`) REFERENCES `helado` (`id_helado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_helado_helados_entregado_recibido1` FOREIGN KEY (`id_helados_entregado_recibido`) REFERENCES `helados_entregado_recibido` (`id_helados_entregado_recibido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_helado_pago_helado1` FOREIGN KEY (`id_pago_helado`) REFERENCES `pago_helado` (`idpago_helado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for factura
-- ----------------------------
DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL auto_increment,
  `numero_factura` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `pago` double NOT NULL,
  PRIMARY KEY  (`id_factura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for heladero
-- ----------------------------
DROP TABLE IF EXISTS `heladero`;
CREATE TABLE `heladero` (
  `id_heladero` int(11) NOT NULL auto_increment,
  `id_concesionario` int(11) NOT NULL,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  PRIMARY KEY  (`id_heladero`),
  KEY `fk_heladero_concesionario1` (`id_concesionario`),
  CONSTRAINT `fk_heladero_concesionario1` FOREIGN KEY (`id_concesionario`) REFERENCES `concesionario` (`id_concesionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for helado
-- ----------------------------
DROP TABLE IF EXISTS `helado`;
CREATE TABLE `helado` (
  `id_helado` int(11) NOT NULL auto_increment,
  `nombre_helado` varchar(45) NOT NULL,
  `precio` double NOT NULL,
  PRIMARY KEY  (`id_helado`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for helados_entregado_recibido
-- ----------------------------
DROP TABLE IF EXISTS `helados_entregado_recibido`;
CREATE TABLE `helados_entregado_recibido` (
  `id_helados_entregado_recibido` int(11) NOT NULL auto_increment,
  `id_heladero` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY  (`id_helados_entregado_recibido`),
  KEY `fk_helado_entregado_recibido_heladero1` (`id_heladero`),
  CONSTRAINT `fk_helado_entregado_recibido_heladero1` FOREIGN KEY (`id_heladero`) REFERENCES `heladero` (`id_heladero`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for pago_helado
-- ----------------------------
DROP TABLE IF EXISTS `pago_helado`;
CREATE TABLE `pago_helado` (
  `idpago_helado` int(11) NOT NULL auto_increment,
  `id_factura` int(11) NOT NULL,
  `id_concepto` int(11) NOT NULL,
  `cant_pagada` int(11) NOT NULL,
  PRIMARY KEY  (`idpago_helado`),
  KEY `fk_pago_helado_factura1` (`id_factura`),
  KEY `fk_pago_helado_concepto1` (`id_concepto`),
  CONSTRAINT `fk_pago_helado_concepto1` FOREIGN KEY (`id_concepto`) REFERENCES `concepto` (`id_concepto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_helado_factura1` FOREIGN KEY (`id_factura`) REFERENCES `factura` (`id_factura`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for stock_helado
-- ----------------------------
DROP TABLE IF EXISTS `stock_helado`;
CREATE TABLE `stock_helado` (
  `id_stock_helado` int(11) NOT NULL auto_increment,
  `id_helado` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY  (`id_stock_helado`),
  KEY `fk_stock_helado_helado1` (`id_helado`),
  CONSTRAINT `fk_stock_helado_helado1` FOREIGN KEY (`id_helado`) REFERENCES `helado` (`id_helado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL auto_increment,
  `id_concesionario` int(11) NOT NULL,
  `nombre_usuario` varchar(45) NOT NULL,
  `contrasenha` varchar(45) NOT NULL,
  `cargo` varchar(45) NOT NULL,
  PRIMARY KEY  (`id_usuario`),
  KEY `fk_usuario_concesionario` (`id_concesionario`),
  CONSTRAINT `fk_usuario_concesionario` FOREIGN KEY (`id_concesionario`) REFERENCES `concesionario` (`id_concesionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `concesionario` VALUES ('1', 'Adex', 'Ate-Vitarte', 'Luis Hanampa'), ('2', 'GYH', 'Comas', 'Edgar Cordova'), ('3', 'Frigolac', 'Callao', 'Mariana Rivero'), ('4', 'PyT', 'Barranco', 'Javier Lorenao'), ('5', 'FerD', 'Jesus Maria', 'Delia Martinez');
INSERT INTO `detalle_helado` VALUES ('1', '13', '1', null, '30', '0', '0'), ('2', '8', '1', null, '10', '0', '0'), ('3', '11', '1', null, '12', '0', '0'), ('4', '17', '2', null, '20', '0', '0'), ('5', '11', '2', null, '20', '0', '0'), ('6', '9', '2', null, '11', '0', '0'), ('7', '9', '3', null, '23', '0', '0'), ('8', '11', '4', null, '20', '0', '0'), ('9', '11', '5', null, '20', '0', '0'), ('10', '9', '5', null, '12', '0', '0');
INSERT INTO `heladero` VALUES ('1', '1', 'Mario', 'Ramirez Coronado'), ('2', '1', 'Jose David', 'Torres Cordova'), ('3', '1', 'Mariana', 'Quispe Delgado'), ('4', '1', 'Lady Diana', 'Saavedra Luque'), ('5', '1', 'Francisco ', 'Gonzales Diaz'), ('6', '2', 'Daniela', 'Zapata Cruz'), ('7', '2', 'Juan Esteban', 'Gamarra Desposorio'), ('8', '2', 'Miguel ', 'Zarate Abanto'), ('9', '3', 'Flor de Maria', 'Izquierdo Morales'), ('10', '3', 'Ana Cristina', 'Vadillo Montes'), ('11', '3', 'Luis Enrique', 'Bustamante Montoya'), ('12', '4', 'Cesar ', 'Salinas Romero'), ('13', '4', 'Yasmin Liset', 'Carranza Lopez'), ('14', '4', 'Eduardo ', 'Atoche Zapata'), ('15', '4', 'Ulises ', 'Elguera Gallo'), ('16', '5', 'Felipe Otoniel', 'Coronel Pedreros'), ('17', '5', 'Denisse ', 'Infantes Morales'), ('18', '5', 'Miguel ', 'Luyo Pineda'), ('19', '5', 'Denisse Katherine', 'Palomino Astupuma'), ('20', '5', 'Juan Luis', 'Hurtado Medina');
INSERT INTO `helado` VALUES ('1', 'Carnevale fresa', '2.5'), ('2', 'Oasu', '1.5'), ('3', 'Copa viva vainilla', '3.5'), ('4', 'Piccolo fresa', '1'), ('5', 'Frutarello limon', '1'), ('6', 'DPelicula', '4'), ('7', 'Lamborgini Light', '3.5'), ('8', 'Tartufo', '2'), ('9', 'Tartufo Clasico', '1.5'), ('10', 'Tartuffo Pecatto', '2'), ('11', 'Bombones Choconum', '3'), ('12', 'Sandwich vainilla pequeño', '1'), ('13', 'Sandwich choconieve grande ', '2'), ('14', 'Sandiwch vainilla grande', '2'), ('15', 'Carnavale chocolate', '2.5'), ('16', 'Vip mora', '1'), ('17', 'Vip mango ', '1'), ('18', 'Copa viva lucuma - vainilla', '3.5'), ('19', 'Copa viva mermelada fresa', '3.5'), ('20', 'Piccolo chica', '1'), ('21', 'Piccolo manzana', '1'), ('22', 'Frutarello guanabana', '1'), ('23', 'Frutarello coco', '1'), ('24', 'Pionono vainilla', '4.5'), ('25', 'Pionono lucuma', '4.5'), ('26', 'Casino chocolate', '1.5'), ('27', 'Casino lucuma', '1.5');
INSERT INTO `helados_entregado_recibido` VALUES ('1', '2', '2011-07-01', '52'), ('2', '5', '2011-07-01', '51'), ('3', '7', '2011-07-01', '23'), ('4', '13', '2011-07-01', '20'), ('5', '3', '2011-07-01', '32');
INSERT INTO `usuario` VALUES ('1', '1', 'LHanampa', 'luis', 'Gerente'), ('2', '2', 'ECordova', 'edgar', 'Jefe de Ventas'), ('3', '3', 'MRivero', 'mariana', 'Asistente'), ('4', '4', 'JLorenao', 'javier', 'Gerente'), ('5', '5', 'DMartinez', 'delia', 'Contador'), ('6', '1', 'admin', 'admin', 'Administrador');
