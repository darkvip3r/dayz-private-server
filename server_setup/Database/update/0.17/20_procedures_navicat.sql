/*
Navicat MySQL Data Transfer

Source Server         : localhost_3310
Source Server Version : 50516
Source Host           : localhost:3310
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2012-09-19 19:30:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Procedure structure for `proc_checkWhitelist`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_checkWhitelist`;
DELIMITER ;;
CREATE DEFINER=`dayz`@`localhost` PROCEDURE `proc_checkWhitelist`(in p_instanceId int, in p_uniqueId varchar(128))
begin
  select
    if(i.whitelist = 1, coalesce(is_whitelisted, 0), 1)
  from
    instances i
    left join profile p on p.unique_id = p_uniqueId
  where
    i.instance = p_instanceId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_loglogout`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_loglogout`;
DELIMITER ;;
CREATE DEFINER=`dayz`@`localhost` PROCEDURE `proc_loglogout`(in `p_uniqueId` varchar(128), in `p_instanceId` int)
begin
  insert into log_entry (unique_id, instance_id, log_code_id) values (p_uniqueId, p_instanceId, 5); --
end
;;
DELIMITER ;
