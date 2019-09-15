-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema heladeros
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `heladeros`;

-- -----------------------------------------------------
-- Schema heladeros
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `heladeros` DEFAULT CHARACTER SET utf8;
USE `heladeros`;

-- -----------------------------------------------------
-- Table `heladeros`.`concepto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`concepto`;

CREATE TABLE IF NOT EXISTS `heladeros`.`concepto`
(
    `id_concepto`      INT(11)      NOT NULL AUTO_INCREMENT,
    `detalle_concepto` VARCHAR(250) NOT NULL,
    PRIMARY KEY (`id_concepto`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 2
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`concesionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`concesionario`;

CREATE TABLE IF NOT EXISTS `heladeros`.`concesionario`
(
    `id_concesionario` INT(11)     NOT NULL AUTO_INCREMENT,
    `nombre_conces`    VARCHAR(45) NOT NULL,
    `distrito`         VARCHAR(45) NOT NULL,
    `propietario`      VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id_concesionario`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 6
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`heladero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`heladero`;

CREATE TABLE IF NOT EXISTS `heladeros`.`heladero`
(
    `id_heladero`      INT(11)     NOT NULL AUTO_INCREMENT,
    `id_concesionario` INT(11)     NOT NULL,
    `nombres`          VARCHAR(45) NOT NULL,
    `apellidos`        VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id_heladero`),
    INDEX `fk_heladero_concesionario1` (`id_concesionario` ASC),
    CONSTRAINT `fk_heladero_concesionario1`
        FOREIGN KEY (`id_concesionario`)
            REFERENCES `heladeros`.`concesionario` (`id_concesionario`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 21
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`contrato_heladero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`contrato_heladero`;

CREATE TABLE IF NOT EXISTS `heladeros`.`contrato_heladero`
(
    `idcontrato_heladero` INT(11)     NOT NULL AUTO_INCREMENT,
    `id_heladero`         INT(11)     NOT NULL,
    `numero_contrato`     INT(11)     NOT NULL,
    `tipo`                VARCHAR(45) NOT NULL,
    `contenido`           VARCHAR(45) NOT NULL,
    `fecha_inicio`        DATE        NOT NULL,
    `fecha_fin`           DATE        NOT NULL,
    PRIMARY KEY (`idcontrato_heladero`),
    INDEX `fk_contrato_heladero_heladero1` (`id_heladero` ASC),
    CONSTRAINT `fk_contrato_heladero_heladero1`
        FOREIGN KEY (`id_heladero`)
            REFERENCES `heladeros`.`heladero` (`id_heladero`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`stock_helado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`stock_helado`;

CREATE TABLE IF NOT EXISTS `heladeros`.`stock_helado`
(
    `id_stock_helado` INT(11)          NOT NULL AUTO_INCREMENT,
    `cantidad`        INT(11) ZEROFILL NOT NULL,
    `fecha_caducidad` DATE             NULL,
    `fecha_registro`  TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_stock_helado`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`helado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`helado`;

CREATE TABLE IF NOT EXISTS `heladeros`.`helado`
(
    `id_helado`       INT(11)     NOT NULL AUTO_INCREMENT,
    `nombre_helado`   VARCHAR(45) NOT NULL,
    `precio`          DOUBLE      NOT NULL,
    `id_stock_helado` INT(11)     NULL,
    PRIMARY KEY (`id_helado`),
    INDEX `fk_helado_stock_helado1_idx` (`id_stock_helado` ASC),
    CONSTRAINT `fk_helado_stock_helado1`
        FOREIGN KEY (`id_stock_helado`)
            REFERENCES `heladeros`.`stock_helado` (`id_stock_helado`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 28
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`helados_entregado_recibido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`helados_entregado_recibido`;

CREATE TABLE IF NOT EXISTS `heladeros`.`helados_entregado_recibido`
(
    `id_helados_entregado_recibido` INT(11) NOT NULL AUTO_INCREMENT,
    `id_heladero`                   INT(11) NOT NULL,
    `fecha`                         DATE    NOT NULL,
    `total`                         DOUBLE  NOT NULL,
    PRIMARY KEY (`id_helados_entregado_recibido`),
    INDEX `fk_helado_entregado_recibido_heladero1` (`id_heladero` ASC),
    CONSTRAINT `fk_helado_entregado_recibido_heladero1`
        FOREIGN KEY (`id_heladero`)
            REFERENCES `heladeros`.`heladero` (`id_heladero`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 11
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`factura`;

CREATE TABLE IF NOT EXISTS `heladeros`.`factura`
(
    `id_factura`     INT(11)     NOT NULL AUTO_INCREMENT,
    `numero_factura` INT(11)     NOT NULL,
    `fecha`          DATE        NOT NULL,
    `descripcion`    VARCHAR(45) NOT NULL,
    `pago`           DOUBLE      NOT NULL,
    PRIMARY KEY (`id_factura`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 6
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`pago_helado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`pago_helado`;

CREATE TABLE IF NOT EXISTS `heladeros`.`pago_helado`
(
    `idpago_helado` INT(11)       NOT NULL AUTO_INCREMENT,
    `id_factura`    INT(11)       NOT NULL,
    `id_concepto`   INT(11)       NOT NULL,
    `cant_pagada`   DOUBLE(11, 0) NOT NULL,
    PRIMARY KEY (`idpago_helado`),
    INDEX `fk_pago_helado_factura1` (`id_factura` ASC),
    INDEX `fk_pago_helado_concepto1` (`id_concepto` ASC),
    CONSTRAINT `fk_pago_helado_concepto1`
        FOREIGN KEY (`id_concepto`)
            REFERENCES `heladeros`.`concepto` (`id_concepto`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_pago_helado_factura1`
        FOREIGN KEY (`id_factura`)
            REFERENCES `heladeros`.`factura` (`id_factura`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 16
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`detalle_helado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`detalle_helado`;

CREATE TABLE IF NOT EXISTS `heladeros`.`detalle_helado`
(
    `id_detalle_helado`             INT(11) NOT NULL AUTO_INCREMENT,
    `id_helado`                     INT(11) NOT NULL,
    `id_helados_entregado_recibido` INT(11) NOT NULL,
    `id_pago_helado`                INT(11) NULL DEFAULT NULL,
    `cant_entregada`                INT(11) NOT NULL,
    `cant_devuelta`                 INT(11) NOT NULL,
    `cant_vendida`                  INT(11) NOT NULL,
    PRIMARY KEY (`id_detalle_helado`),
    INDEX `fk_detalle_helado_helado1` (`id_helado` ASC),
    INDEX `fk_detalle_helado_helados_entregado_recibido1` (`id_helados_entregado_recibido` ASC),
    INDEX `fk_detalle_helado_pago_helado1` (`id_pago_helado` ASC),
    CONSTRAINT `fk_detalle_helado_helado1`
        FOREIGN KEY (`id_helado`)
            REFERENCES `heladeros`.`helado` (`id_helado`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_detalle_helado_helados_entregado_recibido1`
        FOREIGN KEY (`id_helados_entregado_recibido`)
            REFERENCES `heladeros`.`helados_entregado_recibido` (`id_helados_entregado_recibido`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_detalle_helado_pago_helado1`
        FOREIGN KEY (`id_pago_helado`)
            REFERENCES `heladeros`.`pago_helado` (`idpago_helado`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 28
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heladeros`.`usuario`;

CREATE TABLE IF NOT EXISTS `heladeros`.`usuario`
(
    `id_usuario`       INT(11)     NOT NULL AUTO_INCREMENT,
    `id_concesionario` INT(11)     NOT NULL,
    `nombre_usuario`   VARCHAR(45) NOT NULL,
    `contrasenha`      VARCHAR(45) NOT NULL,
    `cargo`            VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id_usuario`),
    INDEX `fk_usuario_concesionario` (`id_concesionario` ASC),
    CONSTRAINT `fk_usuario_concesionario`
        FOREIGN KEY (`id_concesionario`)
            REFERENCES `heladeros`.`concesionario` (`id_concesionario`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 7
    DEFAULT CHARACTER SET = utf8;

USE `heladeros`;

DELIMITER $$

USE `heladeros`$$
DROP TRIGGER IF EXISTS `heladeros`.`stock_helado_BEFORE_INSERT` $$
USE `heladeros`$$
CREATE DEFINER = CURRENT_USER TRIGGER `heladeros`.`stock_helado_BEFORE_INSERT`
    BEFORE INSERT
    ON `stock_helado`
    FOR EACH ROW
BEGIN
    SET NEW.fecha_caducidad = DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY);
END$$


DELIMITER ;

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `heladeros`.`concepto`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`concepto` (`id_concepto`, `detalle_concepto`)
VALUES (1, 'Pago por venta de helados');

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`concesionario`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (1, 'Adex', 'Ate-Vitarte', 'Luis Hanampa');
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (2, 'GYH', 'Comas', 'Edgar Cordova');
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (3, 'Frigolac', 'Callao', 'Mariana Rivero');
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (4, 'PyT', 'Barranco', 'Javier Lorenao');
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (5, 'FerD', 'Jesus Maria', 'Delia Martinez');

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`heladero`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (1, 1, 'Mario', 'Ramirez Coronado');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (2, 1, 'Jose David', 'Torres Cordova');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (3, 1, 'Mariana', 'Quispe Delgado');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (4, 1, 'Lady Diana', 'Saavedra Luque');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (5, 1, 'Francisco ', 'Gonzales Diaz');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (6, 2, 'Daniela', 'Zapata Cruz');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (7, 2, 'Juan Esteban', 'Gamarra Desposorio');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (8, 2, 'Miguel ', 'Zarate Abanto');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (9, 3, 'Flor de Maria', 'Izquierdo Morales');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (10, 3, 'Ana Cristina', 'Vadillo Montes');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (11, 3, 'Luis Enrique', 'Bustamante Montoya');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (12, 4, 'Cesar ', 'Salinas Romero');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (13, 4, 'Yasmin Liset', 'Carranza Lopez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (14, 4, 'Eduardo ', 'Atoche Zapata');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (15, 4, 'Ulises ', 'Elguera Gallo');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (16, 5, 'Felipe Otoniel', 'Coronel Pedreros');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (17, 5, 'Denisse ', 'Infantes Morales');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (18, 5, 'Miguel ', 'Luyo Pineda');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (19, 5, 'Denisse Katherine', 'Palomino Astupuma');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (20, 5, 'Juan Luis', 'Hurtado Medina');

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`stock_helado`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (1, 1000, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (2, 2000, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (3, 1500, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (4, 1200, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (5, 1100, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (6, 1147, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (7, 2500, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (8, 8215, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (9, 15968, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (10, 21584, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (11, 38416, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (12, 318421, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (13, 578132, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (14, 15482, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (15, 1211812, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (16, 18412, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (17, 1548513, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (18, 1519845, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (19, 188134, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (20, 51854812, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (21, 18461, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (22, 154123, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (23, 154745, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (24, 11546512, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (25, 15194, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (26, 15231, NULL, DEFAULT);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `fecha_registro`)
VALUES (27, 2888623, NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`helado`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (1, 'Carnevale fresa', 2.5, 3);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (2, 'Oasu', 1.5, 1);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (3, 'Copa viva vainilla', 3.5, 2);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (4, 'Piccolo fresa', 1, 6);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (5, 'Frutarello limon', 1, 10);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (6, 'DPelicula', 4, 11);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (7, 'Lamborgini Light', 3.5, 12);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (8, 'Tartufo', 2, 13);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (9, 'Tartufo Clasico', 1.5, 17);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (10, 'Tartuffo Pecatto', 2, 14);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (11, 'Bombones Choconum', 3, 4);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (12, 'Sandwich vainilla pequeño', 1, 15);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (13, 'Sandwich choconieve grande ', 2, 16);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (14, 'Sandiwch vainilla grande', 2, 26);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (15, 'Carnavale chocolate', 2.5, 5);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (16, 'Vip mora', 1, 22);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (17, 'Vip mango ', 1, 24);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (18, 'Copa viva lucuma - vainilla', 3.5, 8);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (19, 'Copa viva mermelada fresa', 3.5, 7);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (20, 'Piccolo chica', 1, 9);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (21, 'Piccolo manzana', 1, 18);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (22, 'Frutarello guanabana', 1, 19);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (23, 'Frutarello coco', 1, 21);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (24, 'Pionono vainilla', 4.5, 25);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (25, 'Pionono lucuma', 4.5, 20);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (26, 'Casino chocolate', 1.5, 27);
INSERT INTO `heladeros`.`helado` (`id_helado`, `nombre_helado`, `precio`, `id_stock_helado`)
VALUES (27, 'Casino lucuma', 1.5, 23);

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`)
VALUES (1, 1, 'LHanampa', 'luis', 'Gerente');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`)
VALUES (2, 2, 'ECordova', 'edgar', 'Jefe de Ventas');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`)
VALUES (3, 3, 'MRivero', 'mariana', 'Asistente');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`)
VALUES (4, 4, 'JLorenao', 'javier', 'Gerente');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`)
VALUES (5, 5, 'DMartinez', 'delia', 'Contador');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`)
VALUES (6, 1, 'admin', '4dm1n', 'Administrador');

COMMIT;

-- begin attached script 'script'
DROP TRIGGER `heladeros`.`stock_helado_BEFORE_INSERT`;
-- end attached script 'script'
