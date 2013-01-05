/*
Navicat MySQL Data Transfer

Source Server         : localhost_3310
Source Server Version : 50516
Source Host           : localhost:3310
Source Database       : update

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2012-09-12 10:12:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Procedure structure for `proc_loginSurvivor`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_loginSurvivor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loginSurvivor`(in `p_uniqueId` varchar(128), in `p_playerName` varchar(128))
begin 
  update profile set name = p_playerName where unique_id = p_uniqueId; --
  update survivor
  set state = '["","aidlpercmstpsnonwnondnon_player_idlesteady04",36]' 
  where 
    unique_id = p_uniqueId and is_dead = 0 and state rlike '.*_(driver|pilot)'; --
  select
    id, inventory, backpack, floor(time_to_sec(timediff(now(), start_time)) / 60), model, last_ate, last_drank
  from survivor
  where
    survivor.unique_id = p_uniqueId
    and is_dead = 0; --
end
;;
DELIMITER ;
