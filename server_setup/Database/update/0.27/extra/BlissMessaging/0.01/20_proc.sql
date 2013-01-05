/*
Navicat MySQL Data Transfer

Source Server         : localhost_3310
Source Server Version : 50516
Source Host           : localhost:3310
Source Database       : dayz

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2012-11-01 12:55:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Procedure structure for `proc_getBuildingPageCount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getBuildingPageCount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getBuildingPageCount`(in `p_instanceId` int)
begin
  declare itemsPerPage int default 5; -- must match proc_getobjects
  select
    floor(count(*) / itemsPerPage) + if((count(*) mod itemsPerPage) > 0, 1, 0)
  from instance_building
  where instance_id = p_instanceId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getBuildings`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getBuildings`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getBuildings`(in `p_instanceId` int, in `p_currentPage` int)
begin
  set @instance = p_instanceId; --
  set @page = greatest(((p_currentPage - 1) * 5), 0); --
  prepare stmt from '
  select
    b.class_name, ib.worldspace
  from
    instance_building ib
    inner join building b on ib.building_id = b.id
  where
    ib.instance_id = ?
  limit ?, 5'; --
  execute stmt using @instance, @page; --
  deallocate prepare stmt; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getMessagePage`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getMessagePage`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getMessagePage`(in `p_instanceId` int, in `p_currentPage` int)
begin
  set @instance = p_instanceId; --
  set @page = greatest(((p_currentPage - 1) * 10), 0); --
  prepare stmt from 'select payload, loop_interval, start_delay  from message where instance_id = ? limit ?, 10'; --
  execute stmt using @instance, @page; -- 
  deallocate prepare stmt; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getMessagePageCount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getMessagePageCount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getMessagePageCount`(in `p_instanceId` int)
begin
  declare itemsPerPage int default 10; -- must match proc_getMessagePage
  select
    floor(count(*) / itemsPerPage) + if((count(*) mod itemsPerPage) > 0, 1, 0)
  from message
  where message.instance_id = p_instanceId; --
end
;;
DELIMITER ;
