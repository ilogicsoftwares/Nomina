/*
MySQL Backup
Source Server Version: 5.6.13
Source Database: nomina
Date: 09/12/2014 14:45:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `cargo`
-- ----------------------------
DROP TABLE IF EXISTS `cargo`;
CREATE TABLE `cargo` (`id` int(10) NOT NULL,`Nombre` varchar(30) NOT NULL,`Descripcion` varchar(250) DEFAULT NULL,`conceptos` varchar(100) DEFAULT NULL,PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `company`
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (`Nombre` varchar(100) DEFAULT NULL,`Rif` varchar(10) DEFAULT NULL,`Direccion` varchar(250) DEFAULT NULL,`Telefono1` varchar(20) DEFAULT NULL,`Telefono2` varchar(20) DEFAULT NULL,`Telefono3` varchar(20) DEFAULT NULL,`Representante` varchar(50) DEFAULT NULL,`Logo` varchar(50) DEFAULT NULL,`Correo` varchar(50) DEFAULT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `departamentos`
-- ----------------------------
DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE `departamentos` (`id` int(10) NOT NULL AUTO_INCREMENT,`Descripcion` varchar(50) NOT NULL,PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `nominagen`
-- ----------------------------
DROP TABLE IF EXISTS `nominagen`;
CREATE TABLE `nominagen` (`id` int(10) NOT NULL,`idtype` int(10) NOT NULL,`cedula` varchar(12) NOT NULL,`conceptos` varchar(250) NOT NULL,`montos` varchar(250) NOT NULL,`basico` decimal(10,0) DEFAULT NULL,`totalded` decimal(10,0) DEFAULT NULL,`totalasig` decimal(10,0) DEFAULT NULL, `neto` decimal(10,0) DEFAULT NULL, PRIMARY KEY (`idtype`,`cedula`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `nominaini`
-- ----------------------------
DROP TABLE IF EXISTS `nominaini`;
CREATE TABLE `nominaini` (`id` int(10) NOT NULL DEFAULT '0',`desde` date DEFAULT NULL,`hasta` date DEFAULT NULL,`estatus` varchar(20) DEFAULT NULL, PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `nominatype`
-- ----------------------------
DROP TABLE IF EXISTS `nominatype`;
CREATE TABLE `nominatype` (`id` int(10) NOT NULL AUTO_INCREMENT,`descripcion` varchar(50) NOT NULL,`intervalo` int(10) NOT NULL, `conceptos` varchar(250) DEFAULT NULL, PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `trabajador`
-- ----------------------------
DROP TABLE IF EXISTS `trabajador`;
CREATE TABLE `trabajador` (`id` int(10) NOT NULL AUTO_INCREMENT,`cedula` varchar(10) NOT NULL,`nombres` varchar(100) NOT NULL, `apellidos` varchar(100) NOT NULL, `idcargo` int(10) NOT NULL, `iddepartamento` int(10) NOT NULL, `direccion` varchar(250) NOT NULL,`telefonocel` varchar(12) NOT NULL,`telefonolocal` varchar(12) NOT NULL, `telefonocontacto` varchar(12) NOT NULL,`nombrecontacto` varchar(50) NOT NULL,`correo` varchar(50) NOT NULL,`Sueldo` decimal(10,2) NOT NULL,`idstatus` int(10) NOT NULL,`conceptos` varchar(250) DEFAULT NULL,PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (`id` int(4) NOT NULL AUTO_INCREMENT, `descripcion` varchar(20) NOT NULL, `tipoid` int(11) NOT NULL,`key` varchar(15) NOT NULL, PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `usertype`
-- ----------------------------
DROP TABLE IF EXISTS `usertype`;
CREATE TABLE `usertype` (`id` int(3) NOT NULL AUTO_INCREMENT,`descripcion` varchar(50) NOT NULL,PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `users` VALUES ('1','master','1','1234');
