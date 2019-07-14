-- MySQL dump 10.13  Distrib 5.7.13, for Win32 (AMD64)
--
-- Host: 127.0.0.1    Database: heladeros
-- ------------------------------------------------------
-- Server version	5.7.13-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `concepto`
--

DROP TABLE IF EXISTS `concepto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concepto` (
  `id_concepto` int(11) NOT NULL AUTO_INCREMENT,
  `detalle_concepto` varchar(250) NOT NULL,
  PRIMARY KEY (`id_concepto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concepto`
--

LOCK TABLES `concepto` WRITE;
/*!40000 ALTER TABLE `concepto` DISABLE KEYS */;
INSERT INTO `concepto` VALUES (1,'Pago por venta de helados');
/*!40000 ALTER TABLE `concepto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concesionario`
--

DROP TABLE IF EXISTS `concesionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concesionario` (
  `id_concesionario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_conces` varchar(45) NOT NULL,
  `distrito` varchar(45) NOT NULL,
  `propietario` varchar(45) NOT NULL,
  PRIMARY KEY (`id_concesionario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concesionario`
--

LOCK TABLES `concesionario` WRITE;
/*!40000 ALTER TABLE `concesionario` DISABLE KEYS */;
INSERT INTO `concesionario` VALUES (1,'Adex','Ate-Vitarte','Luis Hanampa'),(2,'GYH','Comas','Edgar Cordova'),(3,'Frigolac','Callao','Mariana Rivero'),(4,'PyT','Barranco','Javier Lorenao'),(5,'FerD','Jesus Maria','Delia Martinez');
/*!40000 ALTER TABLE `concesionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contrato_heladero`
--

DROP TABLE IF EXISTS `contrato_heladero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contrato_heladero` (
  `idcontrato_heladero` int(11) NOT NULL AUTO_INCREMENT,
  `id_heladero` int(11) NOT NULL,
  `numero_contrato` int(11) NOT NULL,
  `tipo` varchar(45) NOT NULL,
  `contenido` varchar(45) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`idcontrato_heladero`),
  KEY `fk_contrato_heladero_heladero1` (`id_heladero`),
  CONSTRAINT `fk_contrato_heladero_heladero1` FOREIGN KEY (`id_heladero`) REFERENCES `heladero` (`id_heladero`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contrato_heladero`
--

LOCK TABLES `contrato_heladero` WRITE;
/*!40000 ALTER TABLE `contrato_heladero` DISABLE KEYS */;
/*!40000 ALTER TABLE `contrato_heladero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_helado`
--

DROP TABLE IF EXISTS `detalle_helado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_helado` (
  `id_detalle_helado` int(11) NOT NULL AUTO_INCREMENT,
  `id_helado` int(11) NOT NULL,
  `id_helados_entregado_recibido` int(11) NOT NULL,
  `id_pago_helado` int(11) DEFAULT NULL,
  `cant_entregada` int(11) NOT NULL,
  `cant_devuelta` int(11) NOT NULL,
  `cant_vendida` int(11) NOT NULL,
  PRIMARY KEY (`id_detalle_helado`),
  KEY `fk_detalle_helado_helado1` (`id_helado`),
  KEY `fk_detalle_helado_helados_entregado_recibido1` (`id_helados_entregado_recibido`),
  KEY `fk_detalle_helado_pago_helado1` (`id_pago_helado`),
  CONSTRAINT `fk_detalle_helado_helado1` FOREIGN KEY (`id_helado`) REFERENCES `helado` (`id_helado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_helado_helados_entregado_recibido1` FOREIGN KEY (`id_helados_entregado_recibido`) REFERENCES `helados_entregado_recibido` (`id_helados_entregado_recibido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_helado_pago_helado1` FOREIGN KEY (`id_pago_helado`) REFERENCES `pago_helado` (`idpago_helado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_helado`
--

LOCK TABLES `detalle_helado` WRITE;
/*!40000 ALTER TABLE `detalle_helado` DISABLE KEYS */;
INSERT INTO `detalle_helado` VALUES (1,13,1,7,30,1,29),(2,8,1,6,10,2,8),(3,11,1,8,12,2,10),(4,17,2,4,20,3,17),(5,11,2,3,20,2,18),(6,9,2,5,11,1,10),(7,9,3,NULL,23,0,0),(8,11,4,NULL,20,0,0),(9,11,5,2,20,3,17),(10,9,5,1,12,2,10),(15,8,7,NULL,17,0,0),(16,9,7,NULL,20,0,0),(17,13,7,NULL,21,0,0),(18,11,7,NULL,27,0,0),(19,11,8,9,20,2,18),(20,2,8,10,10,4,6),(21,1,8,12,20,1,19),(22,8,8,11,10,2,8),(23,8,9,14,20,2,18),(24,11,9,13,15,2,13),(25,2,9,15,15,0,15),(26,20,10,NULL,44,0,0),(27,1,10,NULL,21,0,0);
/*!40000 ALTER TABLE `detalle_helado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL AUTO_INCREMENT,
  `numero_factura` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `pago` double NOT NULL,
  PRIMARY KEY (`id_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,6812325,'2011-07-03','Venta de helados a fecha 03-07-2011',66),(2,2564848,'2011-07-03','Venta de helados a fecha 03-07-2011',86),(3,9035400,'2011-07-03','Venta de helados a fecha 03-07-2011',104),(4,8289500,'2011-07-04','Venta de helados a fecha 04-07-2011',126.5),(5,1125900,'2011-07-04','Venta de helados a fecha 04-07-2011',97.5);
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `heladero`
--

DROP TABLE IF EXISTS `heladero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `heladero` (
  `id_heladero` int(11) NOT NULL AUTO_INCREMENT,
  `id_concesionario` int(11) NOT NULL,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  PRIMARY KEY (`id_heladero`),
  KEY `fk_heladero_concesionario1` (`id_concesionario`),
  CONSTRAINT `fk_heladero_concesionario1` FOREIGN KEY (`id_concesionario`) REFERENCES `concesionario` (`id_concesionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `heladero`
--

LOCK TABLES `heladero` WRITE;
/*!40000 ALTER TABLE `heladero` DISABLE KEYS */;
INSERT INTO `heladero` VALUES (1,1,'Mario','Ramirez Coronado'),(2,1,'Jose David','Torres Cordova'),(3,1,'Mariana','Quispe Delgado'),(4,1,'Lady Diana','Saavedra Luque'),(5,1,'Francisco ','Gonzales Diaz'),(6,2,'Daniela','Zapata Cruz'),(7,2,'Juan Esteban','Gamarra Desposorio'),(8,2,'Miguel ','Zarate Abanto'),(9,3,'Flor de Maria','Izquierdo Morales'),(10,3,'Ana Cristina','Vadillo Montes'),(11,3,'Luis Enrique','Bustamante Montoya'),(12,4,'Cesar ','Salinas Romero'),(13,4,'Yasmin Liset','Carranza Lopez'),(14,4,'Eduardo ','Atoche Zapata'),(15,4,'Ulises ','Elguera Gallo'),(16,5,'Felipe Otoniel','Coronel Pedreros'),(17,5,'Denisse ','Infantes Morales'),(18,5,'Miguel ','Luyo Pineda'),(19,5,'Denisse Katherine','Palomino Astupuma'),(20,5,'Juan Luis','Hurtado Medina');
/*!40000 ALTER TABLE `heladero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helado`
--

DROP TABLE IF EXISTS `helado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helado` (
  `id_helado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_helado` varchar(45) NOT NULL,
  `precio` double NOT NULL,
  PRIMARY KEY (`id_helado`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helado`
--

LOCK TABLES `helado` WRITE;
/*!40000 ALTER TABLE `helado` DISABLE KEYS */;
INSERT INTO `helado` VALUES (1,'Carnevale fresa',2.5),(2,'Oasu',1.5),(3,'Copa viva vainilla',3.5),(4,'Piccolo fresa',1),(5,'Frutarello limon',1),(6,'DPelicula',4),(7,'Lamborgini Light',3.5),(8,'Tartufo',2),(9,'Tartufo Clasico',1.5),(10,'Tartuffo Pecatto',2),(11,'Bombones Choconum',3),(12,'Sandwich vainilla pequeño',1),(13,'Sandwich choconieve grande ',2),(14,'Sandiwch vainilla grande',2),(15,'Carnavale chocolate',2.5),(16,'Vip mora',1),(17,'Vip mango ',1),(18,'Copa viva lucuma - vainilla',3.5),(19,'Copa viva mermelada fresa',3.5),(20,'Piccolo chica',1),(21,'Piccolo manzana',1),(22,'Frutarello guanabana',1),(23,'Frutarello coco',1),(24,'Pionono vainilla',4.5),(25,'Pionono lucuma',4.5),(26,'Casino chocolate',1.5),(27,'Casino lucuma',1.5);
/*!40000 ALTER TABLE `helado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helados_entregado_recibido`
--

DROP TABLE IF EXISTS `helados_entregado_recibido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helados_entregado_recibido` (
  `id_helados_entregado_recibido` int(11) NOT NULL AUTO_INCREMENT,
  `id_heladero` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`id_helados_entregado_recibido`),
  KEY `fk_helado_entregado_recibido_heladero1` (`id_heladero`),
  CONSTRAINT `fk_helado_entregado_recibido_heladero1` FOREIGN KEY (`id_heladero`) REFERENCES `heladero` (`id_heladero`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helados_entregado_recibido`
--

LOCK TABLES `helados_entregado_recibido` WRITE;
/*!40000 ALTER TABLE `helados_entregado_recibido` DISABLE KEYS */;
INSERT INTO `helados_entregado_recibido` VALUES (1,2,'2011-07-02',52),(2,5,'2011-07-03',51),(3,7,'2011-07-03',23),(4,13,'2011-07-03',20),(5,3,'2011-07-03',32),(7,2,'2011-07-03',85),(8,1,'2011-07-04',60),(9,2,'2011-07-04',50),(10,1,'2018-06-24',65);
/*!40000 ALTER TABLE `helados_entregado_recibido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pago_helado`
--

DROP TABLE IF EXISTS `pago_helado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pago_helado` (
  `idpago_helado` int(11) NOT NULL AUTO_INCREMENT,
  `id_factura` int(11) NOT NULL,
  `id_concepto` int(11) NOT NULL,
  `cant_pagada` double(11,0) NOT NULL,
  PRIMARY KEY (`idpago_helado`),
  KEY `fk_pago_helado_factura1` (`id_factura`),
  KEY `fk_pago_helado_concepto1` (`id_concepto`),
  CONSTRAINT `fk_pago_helado_concepto1` FOREIGN KEY (`id_concepto`) REFERENCES `concepto` (`id_concepto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_helado_factura1` FOREIGN KEY (`id_factura`) REFERENCES `factura` (`id_factura`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pago_helado`
--

LOCK TABLES `pago_helado` WRITE;
/*!40000 ALTER TABLE `pago_helado` DISABLE KEYS */;
INSERT INTO `pago_helado` VALUES (1,1,1,15),(2,1,1,51),(3,2,1,54),(4,2,1,17),(5,2,1,15),(6,3,1,16),(7,3,1,58),(8,3,1,30),(9,4,1,54),(10,4,1,9),(11,4,1,16),(12,4,1,47),(13,5,1,39),(14,5,1,36),(15,5,1,22);
/*!40000 ALTER TABLE `pago_helado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_helado`
--

DROP TABLE IF EXISTS `stock_helado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_helado` (
  `id_stock_helado` int(11) NOT NULL AUTO_INCREMENT,
  `id_helado` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id_stock_helado`),
  KEY `fk_stock_helado_helado1` (`id_helado`),
  CONSTRAINT `fk_stock_helado_helado1` FOREIGN KEY (`id_helado`) REFERENCES `helado` (`id_helado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_helado`
--

LOCK TABLES `stock_helado` WRITE;
/*!40000 ALTER TABLE `stock_helado` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_helado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_concesionario` int(11) NOT NULL,
  `nombre_usuario` varchar(45) NOT NULL,
  `contrasenha` varchar(45) NOT NULL,
  `cargo` varchar(45) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `fk_usuario_concesionario` (`id_concesionario`),
  CONSTRAINT `fk_usuario_concesionario` FOREIGN KEY (`id_concesionario`) REFERENCES `concesionario` (`id_concesionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,1,'LHanampa','luis','Gerente'),(2,2,'ECordova','edgar','Jefe de Ventas'),(3,3,'MRivero','mariana','Asistente'),(4,4,'JLorenao','javier','Gerente'),(5,5,'DMartinez','delia','Contador'),(6,1,'admin','4dm1n','Administrador');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-24 11:58:13
