/*
Navicat MySQL Data Transfer

Source Server         : localhost_3310
Source Server Version : 50516
Source Host           : localhost:3310
Source Database       : dayz

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2012-11-12 14:38:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `instance`
-- ----------------------------
DROP TABLE IF EXISTS `instance`;
CREATE TABLE `instance` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `world_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `backpack` varchar(2048) NOT NULL DEFAULT '["DZ_Patrol_Pack_EP1",[[],[]],[[],[]]]',
  PRIMARY KEY (`id`),
  KEY `fk1_instance` (`world_id`),
  CONSTRAINT `instance_ibfk_1` FOREIGN KEY (`world_id`) REFERENCES `world` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instance
-- ----------------------------
INSERT INTO `instance` VALUES ('1', '1', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('2', '2', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('3', '3', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('4', '4', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('5', '5', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('6', '6', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('7', '7', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('8', '8', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('9', '9', '[]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
