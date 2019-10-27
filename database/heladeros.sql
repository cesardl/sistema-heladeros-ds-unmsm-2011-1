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
CREATE TABLE IF NOT EXISTS `heladeros`.`concepto`
(
    `id_concepto`      INT(11)      NOT NULL AUTO_INCREMENT,
    `detalle_concepto` VARCHAR(250) NOT NULL,
    PRIMARY KEY (`id_concepto`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`concesionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heladeros`.`concesionario`
(
    `id_concesionario` INT(11)     NOT NULL AUTO_INCREMENT,
    `nombre_conces`    VARCHAR(45) NOT NULL,
    `distrito`         VARCHAR(45) NOT NULL,
    `propietario`      VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id_concesionario`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`heladero`
-- -----------------------------------------------------
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
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`contrato_heladero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heladeros`.`contrato_heladero`
(
    `idcontrato_heladero` INT(11)                        NOT NULL AUTO_INCREMENT,
    `id_heladero`         INT(11)                        NOT NULL,
    `numero_contrato`     VARCHAR(11)                    NOT NULL,
    `tipo`                ENUM ('TEMPORAL', 'PERMANENT') NOT NULL,
    `contenido`           TEXT                           NOT NULL,
    `fecha_inicio`        DATE                           NOT NULL,
    `fecha_fin`           DATE                           NOT NULL,
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
CREATE TABLE IF NOT EXISTS `heladeros`.`stock_helado`
(
    `id_stock_helado` INT(11)          NOT NULL AUTO_INCREMENT,
    `cantidad`        INT(11) ZEROFILL NOT NULL,
    `fecha_caducidad` DATE             NULL,
    `created_at`      TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `last_modified`   TIMESTAMP        NULL,
    PRIMARY KEY (`id_stock_helado`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`helado`
-- -----------------------------------------------------
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
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`helados_entregado_recibido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heladeros`.`helados_entregado_recibido`
(
    `id_helados_entregado_recibido` INT(11)   NOT NULL AUTO_INCREMENT,
    `id_heladero`                   INT(11)   NOT NULL,
    `fecha`                         DATE      NOT NULL,
    `created_at`                    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_helados_entregado_recibido`),
    INDEX `fk_helado_entregado_recibido_heladero1` (`id_heladero` ASC),
    CONSTRAINT `fk_helado_entregado_recibido_heladero1`
        FOREIGN KEY (`id_heladero`)
            REFERENCES `heladeros`.`heladero` (`id_heladero`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heladeros`.`factura`
(
    `id_factura`     INT(11)     NOT NULL AUTO_INCREMENT,
    `numero_factura` INT(11)     NOT NULL,
    `fecha`          DATE        NOT NULL,
    `descripcion`    VARCHAR(45) NOT NULL,
    `pago`           DOUBLE      NOT NULL,
    `create_at`      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_factura`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`pago_helado`
-- -----------------------------------------------------
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
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`detalle_helado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heladeros`.`detalle_helado`
(
    `id_detalle_helado`             INT(11) NOT NULL AUTO_INCREMENT,
    `id_helado`                     INT(11) NOT NULL,
    `id_helados_entregado_recibido` INT(11) NOT NULL,
    `id_pago_helado`                INT(11) NULL     DEFAULT NULL,
    `cant_entregada`                INT(11) NOT NULL DEFAULT 0,
    `cant_devuelta`                 INT(11) NOT NULL DEFAULT 0,
    `cant_vendida`                  INT(11) NOT NULL DEFAULT 0,
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
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heladeros`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heladeros`.`usuario`
(
    `id_usuario`       INT(11)                   NOT NULL AUTO_INCREMENT,
    `id_concesionario` INT(11)                   NOT NULL,
    `nombre_usuario`   VARCHAR(45)               NOT NULL,
    `contrasenha`      VARCHAR(45)               NOT NULL,
    `cargo`            VARCHAR(45)               NOT NULL,
    `role`             ENUM ('ADMIN', 'MANAGER') NOT NULL,
    PRIMARY KEY (`id_usuario`),
    INDEX `fk_usuario_concesionario` (`id_concesionario` ASC),
    CONSTRAINT `fk_usuario_concesionario`
        FOREIGN KEY (`id_concesionario`)
            REFERENCES `heladeros`.`concesionario` (`id_concesionario`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;

USE `heladeros`;

DELIMITER $$
USE `heladeros`$$
CREATE DEFINER = CURRENT_USER TRIGGER `heladeros`.`contrato_heladero_BEFORE_INSERT`
    BEFORE INSERT
    ON `contrato_heladero`
    FOR EACH ROW
BEGIN
    SET NEW.fecha_inicio = DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH);
    SET NEW.fecha_fin = DATE_ADD(CURRENT_DATE, INTERVAL 6 MONTH);
END$$

USE `heladeros`$$
CREATE DEFINER = CURRENT_USER TRIGGER `heladeros`.`stock_helado_BEFORE_INSERT`
    BEFORE INSERT
    ON `stock_helado`
    FOR EACH ROW
BEGIN
    SET NEW.fecha_caducidad = DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY);
END$$

USE `heladeros`$$
CREATE DEFINER = CURRENT_USER TRIGGER `heladeros`.`helados_entregado_recibido_BEFORE_INSERT`
    BEFORE INSERT
    ON `helados_entregado_recibido`
    FOR EACH ROW
BEGIN
    SET NEW.fecha = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
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
VALUES (1, 'GLOBAL', 'Lima', 'GLOBAL');
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (2, 'GYH', 'Comas', 'Edgar Cordova');
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (3, 'Frigolac', 'Callao', 'Mariana Rivero');
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (4, 'PyT', 'Barranco', 'Javier Lorenao');
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (5, 'FerD', 'Jesus Maria', 'Delia Martinez');
INSERT INTO `heladeros`.`concesionario` (`id_concesionario`, `nombre_conces`, `distrito`, `propietario`)
VALUES (6, 'Adex', 'Ate-Vitarte', 'Luis Hanampa');

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`heladero`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (1, 6, 'Mario', 'Ramirez Coronado');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (2, 6, 'Jose David', 'Torres Cordova');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (3, 6, 'Mariana', 'Quispe Delgado');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (4, 6, 'Lady Diana', 'Saavedra Luque');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (5, 6, 'Francisco ', 'Gonzales Diaz');
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
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (21, 2, 'Jose Luis', 'Enriquez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (22, 4, 'FRANCESCOLY PAOLO', 'PEREZ');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (23, 2, 'eloy', 'baez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (24, 4, 'Andres', 'Barrientos Garcia');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (25, 4, 'ruben', 'mendoza alca');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (26, 2, 'juan eduardo', 'yarasca carranza');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (27, 3, 'Joel', 'Montoya');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (28, 4, 'ALBERT JUAN', 'MONTES ANCCASI');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (29, 4, 'bruno', 'palacios');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (30, 5, 'Daniel', 'Carpio Contreras');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (31, 4, 'Christian', 'Ruiz Gonzales');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (32, 2, 'Cesar David', 'Neira Huaman');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (33, 2, 'Milton Alonso', 'Tejada Tejada');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (34, 5, 'Zuly', 'Diaz Soto');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (35, 3, 'Jorge Alberto', 'Vilca Ypanaque');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (36, 5, 'Luis', 'Palomino Paniora');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (37, 5, 'Ronnier', 'Atayauri Calderon');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (38, 3, 'Eduardo ', 'De Amat');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (39, 5, 'Felipe Guillermo', 'Maguina Ramirez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (40, 5, 'Jose Santos', 'Ventura Arteaga');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (41, 3, 'Juan Pablo', 'Huachaca Vargas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (42, 3, 'Jonathan', 'Medina Diaz');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (43, 4, 'Jonathan', 'Medina Diaz');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (44, 6, 'Max Jairo', 'Collao Aldave');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (45, 4, 'Julio Hidalgo', 'Portella Hidalgo');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (46, 5, 'Manuel Jesus', 'Ramos Vargas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (47, 4, 'David', 'Vilca Quispe');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (48, 6, 'Franco', 'Mallqui Parra');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (49, 4, 'john jesus ', 'epiquin castillo');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (50, 4, 'jhonny americo', 'Estrella Palomino');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (51, 5, 'Anthony ', 'Ramos');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (52, 2, 'Jose David', 'Esquicha Tejada');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (53, 4, 'Cesar', 'Miranda');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (54, 2, 'Franklin Jerry', 'Medina Escalante');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (55, 4, 'Hector Abel', 'Ramirez collado');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (56, 2, 'Eduardo Agustin', 'Espinoza Chaparro');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (57, 5, 'Erwin Jose', 'Espinoza Chaparro');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (58, 3, 'sony', 'rios cahuas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (59, 6, 'Jose Luis', 'Granda Visso');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (60, 4, 'Carlos Alfredo', 'Finquin Pejerrey');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (61, 3, 'Yensi', 'Vega');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (62, 6, 'EDWIN', 'CAPCHA CORONADO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (63, 2, 'EDWIN', 'CAPCHA CORONADO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (64, 5, 'Richard', 'Mata Rosales');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (65, 5, 'DE LA CRUZ', 'PISFIL');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (66, 3, 'PEDRO SANTOS', 'DE LA CRUZ PISFIL');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (67, 6, 'Frank', 'Chavez Malpartida');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (68, 6, 'John Augusto', 'Vargas Pozo');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (69, 4, 'Giancarlo', 'Laredo Aguero');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (70, 6, 'Marianela Justina', 'Perez Garcia');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (71, 4, 'Luis Enrique', 'Benites Sanchez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (72, 6, 'alexis', 'rosas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (73, 4, 'John Orfelino', 'Ortiz Rodriguez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (74, 4, 'Victor', 'Muchica');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (75, 5, 'Luisa', 'Oscanoa Ojeda');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (76, 5, 'RICARDO LUIS', 'GONZALES CASTILLO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (77, 6, 'ALONSO RAFAEL', 'MARTINEZ ACHULLA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (78, 6, 'Cebastiana N', 'Salazar Jachilla');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (79, 2, 'Crist', 'Palli Apaza');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (80, 4, 'Neyder', 'Achahuanco Apaza');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (81, 3, 'Johnny Williams', 'Camones Tapia');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (82, 4, 'Isbella Merici', 'Miranda Vasquez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (83, 6, 'Williams Javier', 'Manrique Salazar');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (84, 3, 'Evelyn Roxana', 'Poma Nicho');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (85, 6, 'SANTOS JESUS', 'ESQUIVEL MURGA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (86, 6, 'Luis Miguel', 'Caballero Gonzalez Cueva');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (87, 5, 'Marco', 'Montoro');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (88, 2, 'Luis Alejandro', 'Zumaeta Rivera');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (89, 4, 'Daniel Eduardo', 'Barrios Lambruschini');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (90, 3, 'Arturo Carlos Alberto', 'Castaneda Melchor');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (91, 2, 'Eduardo Miguel', 'Florian Arteaga');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (92, 4, 'Jorge Fabian ', 'Chuquitaype Zuniga');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (93, 6, 'eduardo renzo', 'florian flores');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (94, 6, 'Raul Pablo Cesar', 'Cuentas Barbaran');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (95, 2, 'Cristhian Efrain', 'Ccallo Quispe');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (96, 3, 'Miguel Armando', 'Tito Ascue');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (97, 6, 'Maria Elena', 'Chavez Barces');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (98, 2, 'jose carlos', 'gomero montalvan');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (99, 5, 'Hohammed', 'Estrada Vargas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (100, 4, 'Jorge Felix', 'Tito Mitma');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (101, 5, 'SONIA VERONICA ', 'CHAVEZ VIZA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (102, 5, 'Jorge Felix', 'Tito Mitma');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (103, 3, 'freddy', 'Quispe Paquispe');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (104, 4, 'Yen', 'Gonzalez Mayta');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (105, 3, 'Jose Luis', 'Almonacid aquino');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (106, 4, 'Juan Luis ', 'Diaz Aylas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (107, 6, 'Ruben', 'Garcia Ucharima');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (108, 4, 'Kerry Thomas', 'Perez Huanca');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (109, 3, 'Marizell', 'Ccopa Mamani');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (110, 5, 'Mario Junior', 'Inga Cahuana');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (111, 6, 'Juan Alfredo', 'MIGUEL Hilario');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (112, 2, 'Jorge', 'Mandujano');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (113, 4, 'katia jimena', 'oscanoa ojeda');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (114, 6, 'Danilo', 'BE');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (115, 4, 'david', 'fernandez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (116, 2, 'Daniel ', 'Serrano Zavala');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (117, 6, 'Oscar Percy', 'Susanibar Cruz');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (118, 2, 'vladimir', 'caballa torres');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (119, 4, 'Carlos', 'Rojas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (120, 6, 'Yesenia Fiorella', 'Penaranda Cordero');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (121, 2, 'Juan Mijail', 'Benites Vivar');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (122, 4, 'jorge luis', 'delgado portorraro');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (123, 4, 'Humberto Martin', 'Gibaja Ravello');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (124, 2, 'Jorge Luis', 'Giraldez  Cardenas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (125, 6, 'Gerardo Manuel', 'Guzman Reyes');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (126, 3, 'Roberto Francisco', 'Contreras Diestra');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (127, 6, 'Manuel Augusto', 'Lara Lopez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (128, 3, 'Eduardo Karol', 'Corzo Martinez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (129, 4, 'Jorge Felix', 'Tito Mitma');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (130, 5, 'Carlos', 'Luis');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (131, 5, 'Geancarlo Fernando', 'Quispe Rojas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (132, 3, 'Jorge Luis', 'Quiroz Guevara');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (133, 2, 'Leoncio ', 'Tirado salazar');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (134, 4, 'Edwin Enrique ', 'Flores Bautista');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (135, 2, 'Zaida Nieves', 'Cuadros Falcon');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (136, 5, 'Carlos', 'Luis');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (137, 6, 'Roxana Jessica ', 'Chipana Choque');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (138, 5, 'Mario Julian', 'Chilo Quiroz');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (139, 6, 'RAFAEL', 'QUISPE');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (140, 6, 'Jazminne Jhoanna', 'Gridilla Velazco');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (141, 2, 'Christopher', 'Cesti Castro');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (142, 5, 'Diego Enrique', 'Juarez Vargas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (143, 4, 'Jose Carlos', 'Gamarra');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (144, 4, 'Roger Mitchel', 'Ungaro Casanova');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (145, 6, 'John Bruno', 'Minano Silva');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (146, 4, 'Hugo Ivan', 'Villegas Valenzuela');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (147, 3, 'HUGO IVAN', 'VILLEGAS VALENZUELA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (148, 5, 'Jose Carlos', 'Minano Contreras');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (149, 2, 'Jhonny Sandro', 'Toledo Vera');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (150, 2, 'John Bruno', 'Minano Silva');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (151, 6, 'robinson', 'quispe mendez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (152, 2, 'JOEL', 'PAUCARIMA FRANCO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (153, 6, 'ALEX DICK', 'COCHACHIN COCHACHIN');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (154, 3, 'EDWARD ROGER', 'VILCA TUMBILLO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (155, 4, 'Luis Alberto', 'Arellano Villajulca');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (156, 4, 'edwin', 'rojas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (157, 2, 'RONMEL HECTOR', 'HURTADO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (158, 5, 'Otoniel Felipe ', 'Coronel Pedreros');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (159, 5, 'Jorge Luis', 'Castaneda Cano');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (160, 3, 'Jorge Felix', 'Tito Mitma');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (161, 2, 'David', 'Puchoc Lara');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (162, 5, 'KARINA MIRELLA', 'ESPINOZA LEON');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (163, 4, 'william', 'luque');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (164, 6, 'Alcides Nicolas', 'Coronel Chempen');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (165, 6, 'Miguel Angel', 'Luyo Pineda');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (166, 3, 'carlos junior ', 'caso casimiro');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (167, 2, 'Lucero Trilce', 'Vivas Bautista');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (168, 4, 'Anthony Jonathan Ivan', 'Hernandez Zegarra');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (169, 6, 'paul ', 'vilca aguilar');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (170, 5, 'aleco', 'portu');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (171, 4, 'vladimir', 'Garcia Leandro');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (172, 2, 'Cesar', 'Neira');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (173, 5, 'jose maria', 'vegas castillo');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (174, 6, 'Franco', 'Bringas Gonzalez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (175, 2, 'Walter Antonio', 'Rafael Palomino');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (176, 4, 'Cesar', 'Orosco Pacora');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (177, 3, 'Abigail Areli', 'Pena Espinoza');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (178, 3, 'David Adrian ', 'Placido Astupina');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (179, 2, 'Sergio Ernesto', 'Azahuanche Gutierrez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (180, 3, 'Julio Cesar', 'Lopez Ayvar');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (181, 3, 'Estuardo', 'Romero');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (182, 2, 'Gabriela', 'Valdivia Dextre');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (183, 4, 'javier', 'solis flores');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (184, 4, 'Alexis', 'Roque Cueva');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (185, 6, 'Jose Carlos', 'Pariona Arangoitia');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (186, 6, 'JOSE RAUL', 'SHICSHI LUNA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (187, 4, 'CRISTHIAN GENARO', 'CUEVA PAREJAS');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (188, 6, 'Hernan Ysidro', 'Poma Quiroz');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (189, 2, 'Juan Jose', 'VILLENA AVILA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (190, 3, 'Franre', 'Silvera Ortiz');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (191, 6, 'miguel alfonso', 'morales rojo');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (192, 3, 'pablo miguel', 'sullca perez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (193, 6, 'Hugo Kenyo', 'Arbieto Torres');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (194, 5, 'Juan Gustavo', 'Giraldo');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (195, 2, 'MIRKO', 'LLANTO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (196, 5, 'JESUS ANTONIO', 'PACAHUALA ARROYO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (197, 6, 'CARLOS GUILLERMO', 'TELLO VILLENA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (198, 2, 'VIRGINIA MARGARITA', 'SOTELO POMA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (199, 2, 'kield', 'Benites  Quispe');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (200, 2, 'Jorge Felix', 'Tito Mitma');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (201, 6, 'Daniel Jesus', 'Sobrevilla Tarazona');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (202, 2, 'Ricardo ', 'Lam Odicio');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (203, 3, 'Hadassa Jhussara', 'Cruz Yarleque');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (204, 5, 'JUAN CARLOS', 'RIOS VARAS');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (205, 4, 'Robert Marlon', 'More Inga');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (206, 4, 'EDWIN OMAR', 'RODRIGUEZ CRUZ');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (207, 6, 'Jorge Luis', 'Morales Loayza');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (208, 5, 'Rosa Graciela', 'Chavez Cordero');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (209, 6, 'omar', 'mendoza ciprian');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (210, 3, 'LUIS ALBERTO', 'RUIZ ASTO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (211, 3, 'Freddy ', 'Castellanos Santa Cruz');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (212, 6, 'Anthony', 'Pisco Vasquez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (213, 6, 'Fidel', 'Malca Perez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (214, 3, 'Luis Alfonso', 'Alfaro Mendoza');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (215, 3, 'Andy Ludwing', 'De La Cruz More');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (216, 6, 'jhon michael', 'huerta vergaray');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (217, 4, 'jhon michael', 'huerta vergaray');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (218, 4, 'Juan Rafael', 'Mejia Melo');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (219, 4, 'Gino Paolo', 'Romero Talavera');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (220, 5, 'Paul Michels', 'CALVO PEREZ');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (221, 6, 'Adderlyn  Tito', 'Palacios Rojas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (222, 3, 'Jose Alexander', 'Montero Onofre');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (223, 4, 'Ruben', 'Jimenez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (224, 2, 'Emerson ', 'Pastor');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (225, 5, 'Gino Paul', 'Gonzales Custodio');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (226, 5, 'Rafael Marcos', 'Vasquez Felipe');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (227, 3, 'Jose Alberto', 'Yugar Ladines');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (228, 6, 'Silvia Patricia', 'Valdivia Heredia');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (229, 4, 'Omar', 'Palomino');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (230, 5, 'Claudel Helder', 'Dominguez Fernandez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (231, 6, 'Adrian ', 'Rodriguez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (232, 3, 'Yuri', 'Arias');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (233, 3, 'jose joel', 'ramos tanca');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (234, 4, 'MARITZA', 'GUTARRA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (235, 3, 'Claudel Helder', 'Dominguez Fernandez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (236, 5, 'Willian Pool', 'Rios Bardales');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (237, 2, 'Roberto Jesus', 'Mejia Andrade');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (238, 3, 'Luis Alberto', 'Supo Orihuela');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (239, 4, 'Cesar Gustavo', 'Garay Reyes');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (240, 5, 'antonio', 'pereda bardales');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (241, 2, 'RICARDO EDUARDO', 'SALDANA CAMACHO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (242, 6, 'GIOVANNA JULISSA', 'HARO SANCHEZ');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (243, 2, 'favio ', 'zea brousset');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (244, 6, 'oscar ', 'palacios gutierrez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (245, 6, 'JACQUELINE ', 'RAMON GOMEZ');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (246, 4, 'Omar Jesus', 'Olivos Aguero');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (247, 2, 'ROSA VICTORIA', 'CHUQUISPUMA JESUS');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (248, 3, 'Dennys ', 'Ato Saavedra');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (249, 3, 'Carlos Moises', 'Gonzales Lopez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (250, 5, 'CHRISTIAN ', 'GUZMAN PASQUEL');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (251, 2, 'Billie', 'Amstrong');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (252, 6, 'Andy', 'De La Cruz More');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (253, 6, 'Josselin del Carmen', 'Pozo Roman');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (254, 2, 'yasmin pamela', 'condor leon');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (255, 2, 'John', 'Vargas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (256, 4, 'Henry', 'Huarsaya');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (257, 3, 'Elvis', 'Silva');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (258, 3, 'Carlos', 'Rojas');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (259, 4, 'Marcel Igor', 'Gutierrez Gavonel');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (260, 2, 'JOEL JULIO', 'ZEGARRA VALVERDE');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (261, 2, 'KARLA VANESSA', 'RUIDIAS ANAYA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (262, 4, 'CHRISTIAN PEDRO ', 'UCEDA RUIZ');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (263, 4, 'Johel Esteban', 'Cora Valeriano');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (264, 3, 'Carlos Moises', 'Gonzales Lopez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (265, 3, 'Anthony Joel', 'Mateo Mendoza');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (266, 3, 'Miguel Angel', 'Yaguilla');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (267, 5, 'Magaly', 'Yucra  Puma');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (268, 2, 'Victoria', 'Bustamante Toscano');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (269, 3, 'Hugo Renzo', 'Rosales Saavedra');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (270, 3, 'Antonio Rafael', 'Galvez Horna');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (271, 3, 'JOSE ALEJANDRO', 'SABASTIZAGAL ORELLANA');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (272, 4, 'RAUL', 'ESTACIO RIOS');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (273, 6, 'Felix', 'Huamani Fernandez');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (274, 4, 'Jorge Luis', 'Chavez Soto');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (275, 6, 'Gonzalo', 'Soto');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (276, 2, 'Abraham', 'Amasifuen');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (277, 2, 'Isaias', 'Mayon');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (278, 2, 'etrterte', 'treterrtertrt');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (279, 5, 'ERIKA VALERIA', 'MINAN CASTILLO');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (280, 4, 'Jose Carlos', 'Ramirez tello');
INSERT INTO `heladeros`.`heladero` (`id_heladero`, `id_concesionario`, `nombres`, `apellidos`)
VALUES (281, 3, 'Bermaly Araceli', 'Revilla Ramos');

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`contrato_heladero`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (1, 1, '0000813134', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (2, 2, '0000273243', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (3, 3, '0000926813', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (4, 4, '0000814336', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (5, 5, '0000291242', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (6, 6, '0000013200', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (7, 7, '0000192278', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (8, 8, '0000921790', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (9, 9, '0000032117', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (10, 10, '0000395215', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (11, 11, '0000879724', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (12, 12, '0000212975', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (13, 13, '0000425703', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (14, 14, '0000489591', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (15, 15, '0000170846', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (16, 16, '0000385458', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (17, 17, '0000414752', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (18, 18, '0000917386', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (19, 19, '0000342676', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (20, 20, '0000961223', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (21, 21, '0000778085', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (22, 22, '0000006760', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (23, 23, '0000699544', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (24, 24, '0000477439', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (25, 25, '0000288566', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (26, 26, '0000010511', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (27, 27, '0000186859', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (28, 28, '0000902764', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (29, 29, '0000953242', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (30, 30, '0000057918', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (31, 31, '0000429867', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (32, 32, '0000975580', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (33, 33, '0000588300', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (34, 34, '0000014759', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (35, 35, '0000308898', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (36, 36, '0000500213', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (37, 37, '0000574373', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (38, 38, '0000371226', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (39, 39, '0000133011', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (40, 40, '0000551379', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (41, 41, '0000357862', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (42, 42, '0000135174', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (43, 43, '0000602284', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (44, 44, '0000605900', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (45, 45, '0000222648', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (46, 46, '0000295540', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (47, 47, '0000809755', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (48, 48, '0000162155', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (49, 49, '0000381511', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (50, 50, '0000421091', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (51, 51, '0000960921', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (52, 52, '0000541335', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (53, 53, '0000823912', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (54, 54, '0000495554', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (55, 55, '0000006037', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (56, 56, '0000543522', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (57, 57, '0000699499', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (58, 58, '0000866929', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (59, 59, '0000236149', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (60, 60, '0000579957', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (61, 61, '0000191338', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (62, 62, '0000216821', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (63, 63, '0000510093', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (64, 64, '0000900003', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (65, 65, '0000969736', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (66, 66, '0000148670', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (67, 67, '0000834145', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (68, 68, '0000724713', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (69, 69, '0000121130', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (70, 70, '0000431515', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (71, 71, '0000794182', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (72, 72, '0000676366', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (73, 73, '0000999286', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (74, 74, '0000967330', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (75, 75, '0000838794', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (76, 76, '0000291979', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (77, 77, '0000943515', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (78, 78, '0000841638', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (79, 79, '0000377644', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (80, 80, '0000363310', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (81, 81, '0000683616', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (82, 82, '0000328151', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (83, 83, '0000589908', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (84, 84, '0000965086', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (85, 85, '0000055707', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (86, 86, '0000383277', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (87, 87, '0000749265', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (88, 88, '0000596493', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (89, 89, '0000734671', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (90, 90, '0000883879', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (91, 91, '0000215382', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (92, 92, '0000425272', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (93, 93, '0000480213', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (94, 94, '0000125252', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (95, 95, '0000185622', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (96, 96, '0000552354', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (97, 97, '0000204905', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (98, 98, '0000367463', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (99, 99, '0000222599', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (100, 100, '0000010606', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (101, 101, '0000385234', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (102, 102, '0000894355', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (103, 103, '0000316070', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (104, 104, '0000897288', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (105, 105, '0000538230', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (106, 106, '0000999288', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (107, 107, '0000381751', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (108, 108, '0000910890', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (109, 109, '0000409196', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (110, 110, '0000313313', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (111, 111, '0000338979', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (112, 112, '0000754953', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (113, 113, '0000757831', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (114, 114, '0000524298', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (115, 115, '0000347995', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (116, 116, '0000167083', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (117, 117, '0000791428', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (118, 118, '0000455893', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (119, 119, '0000905183', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (120, 120, '0000158236', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (121, 121, '0000075629', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (122, 122, '0000903440', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (123, 123, '0000290313', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (124, 124, '0000741245', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (125, 125, '0000835286', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (126, 126, '0000952694', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (127, 127, '0000257615', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (128, 128, '0000429992', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (129, 129, '0000377115', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (130, 130, '0000595602', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (131, 131, '0000846664', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (132, 132, '0000446516', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (133, 133, '0000692586', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (134, 134, '0000123382', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (135, 135, '0000539155', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (136, 136, '0000325630', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (137, 137, '0000010683', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (138, 138, '0000076525', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (139, 139, '0000350579', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (140, 140, '0000523322', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (141, 141, '0000564870', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (142, 142, '0000254385', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (143, 143, '0000577318', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (144, 144, '0000123435', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (145, 145, '0000885219', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (146, 146, '0000055793', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (147, 147, '0000623307', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (148, 148, '0000949159', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (149, 149, '0000875871', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (150, 150, '0000531882', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (151, 151, '0000031796', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (152, 152, '0000563333', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (153, 153, '0000721279', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (154, 154, '0000916394', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (155, 155, '0000418136', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (156, 156, '0000341500', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (157, 157, '0000453090', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (158, 158, '0000240952', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (159, 159, '0000845492', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (160, 160, '0000504601', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (161, 161, '0000986532', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (162, 162, '0000418855', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (163, 163, '0000134680', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (164, 164, '0000416836', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (165, 165, '0000680140', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (166, 166, '0000150193', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (167, 167, '0000710548', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (168, 168, '0000102158', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (169, 169, '0000379149', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (170, 170, '0000589271', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (171, 171, '0000808907', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (172, 172, '0000276725', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (173, 173, '0000956901', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (174, 174, '0000954334', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (175, 175, '0000900968', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (176, 176, '0000641837', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (177, 177, '0000506283', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (178, 178, '0000605903', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (179, 179, '0000510668', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (180, 180, '0000735630', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (181, 181, '0000146146', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (182, 182, '0000523842', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (183, 183, '0000180774', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (184, 184, '0000332342', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (185, 185, '0000119389', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (186, 186, '0000599919', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (187, 187, '0000641427', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (188, 188, '0000407381', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (189, 189, '0000112622', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (190, 190, '0000340970', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (191, 191, '0000366985', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (192, 192, '0000812014', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (193, 193, '0000959116', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (194, 194, '0000359538', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (195, 195, '0000920342', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (196, 196, '0000523096', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (197, 197, '0000854453', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (198, 198, '0000702981', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (199, 199, '0000951546', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (200, 200, '0000648788', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (201, 201, '0000389304', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (202, 202, '0000000155', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (203, 203, '0000832862', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (204, 204, '0000163849', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (205, 205, '0000320656', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (206, 206, '0000111737', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (207, 207, '0000596714', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (208, 208, '0000648361', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (209, 209, '0000451665', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (210, 210, '0000313243', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (211, 211, '0000211219', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (212, 212, '0000116368', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (213, 213, '0000948181', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (214, 214, '0000391803', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (215, 215, '0000114474', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (216, 216, '0000396961', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (217, 217, '0000641385', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (218, 218, '0000016039', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (219, 219, '0000156043', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (220, 220, '0000732100', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (221, 221, '0000192369', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (222, 222, '0000765547', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (223, 223, '0000250630', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (224, 224, '0000956508', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (225, 225, '0000030651', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (226, 226, '0000283733', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (227, 227, '0000326709', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (228, 228, '0000782350', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (229, 229, '0000931621', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (230, 230, '0000311056', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (231, 231, '0000760416', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (232, 232, '0000868913', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (233, 233, '0000063318', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (234, 234, '0000709853', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (235, 235, '0000359313', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (236, 236, '0000667003', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (237, 237, '0000257078', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (238, 238, '0000284380', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (239, 239, '0000650666', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (240, 240, '0000400191', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (241, 241, '0000048958', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (242, 242, '0000044215', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (243, 243, '0000074205', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (244, 244, '0000238380', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (245, 245, '0000969284', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (246, 246, '0000131280', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (247, 247, '0000748550', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (248, 248, '0000348911', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (249, 249, '0000498906', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (250, 250, '0000447797', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (251, 251, '0000742266', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (252, 252, '0000367942', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (253, 253, '0000612911', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (254, 254, '0000960732', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (255, 255, '0000964925', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (256, 256, '0000942431', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (257, 257, '0000817379', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (258, 258, '0000259603', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (259, 259, '0000845880', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (260, 260, '0000450592', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (261, 261, '0000715319', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (262, 262, '0000224820', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (263, 263, '0000978144', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (264, 264, '0000216262', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (265, 265, '0000146877', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (266, 266, '0000085600', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (267, 267, '0000987368', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (268, 268, '0000680042', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (269, 269, '0000438106', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (270, 270, '0000150403', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (271, 271, '0000437697', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (272, 272, '0000737278', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (273, 273, '0000373299', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (274, 274, '0000654661', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (275, 275, '0000153408', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (276, 276, '0000803056', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (277, 277, '0000555059', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (278, 278, '0000366129', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (279, 279, '0000165466', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (280, 280, '0000728943', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');
INSERT INTO `heladeros`.`contrato_heladero` (`idcontrato_heladero`, `id_heladero`, `numero_contrato`, `tipo`,
                                             `contenido`, `fecha_inicio`, `fecha_fin`)
VALUES (281, 281, '0000148317', 'TEMPORAL', 'Sample Independent Contractor Agreement', '2019-04-27', '2020-04-27');

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`stock_helado`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (1, 1000, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (2, 2000, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (3, 1500, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (4, 1200, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (5, 1100, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (6, 1147, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (7, 2500, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (8, 8215, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (9, 15968, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (10, 21584, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (11, 38416, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (12, 318421, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (13, 578132, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (14, 15482, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (15, 1211812, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (16, 18412, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (17, 1548513, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (18, 1519845, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (19, 188134, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (20, 51854812, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (21, 18461, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (22, 154123, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (23, 154745, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (24, 11546512, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (25, 15194, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (26, 15231, NULL, DEFAULT, NULL);
INSERT INTO `heladeros`.`stock_helado` (`id_stock_helado`, `cantidad`, `fecha_caducidad`, `created_at`, `last_modified`)
VALUES (27, 2888623, NULL, DEFAULT, NULL);

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
VALUES (5, 'Frutarello limón', 1, 10);
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
-- Data for table `heladeros`.`helados_entregado_recibido`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`helados_entregado_recibido` (`id_helados_entregado_recibido`, `id_heladero`, `fecha`, `created_at`)
VALUES (1, 37, '2019-04-27', DEFAULT);
INSERT INTO `heladeros`.`helados_entregado_recibido` (`id_helados_entregado_recibido`, `id_heladero`, `fecha`, `created_at`)
VALUES (2, 143, '2019-04-27', DEFAULT);
INSERT INTO `heladeros`.`helados_entregado_recibido` (`id_helados_entregado_recibido`, `id_heladero`, `fecha`, `created_at`)
VALUES (3, 193, '2019-04-27', DEFAULT);
INSERT INTO `heladeros`.`helados_entregado_recibido` (`id_helados_entregado_recibido`, `id_heladero`, `fecha`, `created_at`)
VALUES (4, 214, '2019-04-27', DEFAULT);
INSERT INTO `heladeros`.`helados_entregado_recibido` (`id_helados_entregado_recibido`, `id_heladero`, `fecha`, `created_at`)
VALUES (5, 276, '2019-04-27', DEFAULT);
INSERT INTO `heladeros`.`helados_entregado_recibido` (`id_helados_entregado_recibido`, `id_heladero`, `fecha`, `created_at`)
VALUES (6, 76, '2019-04-27', DEFAULT);
INSERT INTO `heladeros`.`helados_entregado_recibido` (`id_helados_entregado_recibido`, `id_heladero`, `fecha`, `created_at`)
VALUES (7, 80, '2019-04-27', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`detalle_helado`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (1, 1, 1, NULL, 100, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (2, 2, 1, NULL, 100, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (3, 5, 2, NULL, 20, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (4, 6, 2, NULL, 50, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (5, 11, 2, NULL, 30, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (6, 15, 3, NULL, 40, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (7, 16, 3, NULL, 10, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (8, 17, 4, NULL, 40, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (9, 20, 4, NULL, 50, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (10, 16, 4, NULL, 30, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (11, 2, 4, NULL, 40, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (12, 3, 5, NULL, 50, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (13, 11, 5, NULL, 20, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (14, 11, 6, NULL, 30, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (15, 19, 6, NULL, 60, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (16, 19, 7, NULL, 50, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (17, 12, 7, NULL, 300, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (18, 5, 7, NULL, 11, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (19, 22, 7, NULL, 203, DEFAULT, DEFAULT);
INSERT INTO `heladeros`.`detalle_helado` (`id_detalle_helado`, `id_helado`, `id_helados_entregado_recibido`,
                                          `id_pago_helado`, `cant_entregada`, `cant_devuelta`, `cant_vendida`)
VALUES (20, 18, 7, NULL, 252, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `heladeros`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `heladeros`;
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`, `role`)
VALUES (1, 1, 'admin', '4dm1n', 'Administrador', 'ADMIN');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`, `role`)
VALUES (2, 2, 'LHanampa', 'luis', 'Gerente', 'MANAGER');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`, `role`)
VALUES (3, 3, 'ECordova', 'edgar', 'Jefe de Ventas', 'MANAGER');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`, `role`)
VALUES (4, 4, 'MRivero', 'mariana', 'Asistente', 'MANAGER');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`, `role`)
VALUES (5, 5, 'JLorenao', 'javier', 'Gerente', 'MANAGER');
INSERT INTO `heladeros`.`usuario` (`id_usuario`, `id_concesionario`, `nombre_usuario`, `contrasenha`, `cargo`, `role`)
VALUES (6, 6, 'DMartinez', 'delia', 'Contador', 'MANAGER');

COMMIT;

-- begin attached script 'script'
DROP TRIGGER `heladeros`.`stock_helado_BEFORE_INSERT`;
DROP TRIGGER `heladeros`.`helados_entregado_recibido_BEFORE_INSERT`;
DROP TRIGGER `heladeros`.`contrato_heladero_BEFORE_INSERT`;

-- end attached script 'script'
