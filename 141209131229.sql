/*
MySQL Backup
Source Server Version: 5.6.13
Source Database: nomina
Date: 09/12/2014 13:12:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (`id` int(4) NOT NULL AUTO_INCREMENT,`descripcion` varchar(20) NOT NULL,`tipoid` int(11) NOT NULL,`key` varchar(15) NOT NULL,PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `users` VALUES ('1','master','1','1234');
