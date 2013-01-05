/*
Navicat MySQL Data Transfer

Source Server         : localhost_3310
Source Server Version : 50516
Source Host           : localhost:3310
Source Database       : dayz

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2012-11-01 12:40:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Procedure structure for `proc_deleteObject`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_deleteObject`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteObject`(in `p_uniqueId` varchar(128))
begin
  delete from instance_deployable where unique_id = p_uniqueId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_deleteObjectId`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_deleteObjectId`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteObjectId`(in `p_objectId` int)
begin
  delete from instance_deployable where id = p_objectId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getInstanceLoadout`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getInstanceLoadout`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getInstanceLoadout`(in `p_instanceId` int)
begin
  select inventory from instance where id = p_instanceId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getInstanceTime`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getInstanceTime`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getInstanceTime`(in `p_instanceId` int)
begin
  declare server_time datetime default now(); --
  select now() + interval (tz_offset) hour into server_time from instance where id = p_instanceId; --
  select date_format(server_time, '%d-%m-%y'), time_format(server_time, '%T'); --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getObjectPageCount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getObjectPageCount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getObjectPageCount`(in `p_instanceId` int)
begin
  declare itemsPerPage int default 5; -- must match proc_getobjects
  select
    floor(count(*) / itemsPerPage) + if((count(*) mod itemsPerPage) > 0, 1, 0)
  from (
    select id, instance_id from instance_vehicle
    union
    select unique_id id, instance_id from instance_deployable 
  ) instance_objects
  where instance_id = p_instanceId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getObjects`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getObjects`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getObjects`(in `p_instanceId` int, in `p_currentPage` int)
begin
  set @instance = p_instanceId; --
  set @page = greatest(((p_currentPage - 1) * 5), 0); --
  prepare stmt from '
select * from (
  select
    iv.id, v.class_name, 0 owner_id, iv.worldspace, iv.inventory, iv.parts, fuel, damage
  from
    instance_vehicle iv
    inner join vehicle v on iv.vehicle_id = v.id
  where
    iv.instance_id = ?
union
  select
    id.id, d.class_name, id.owner_id, worldspace, inventory, \'[]\' parts, 0 fuel, 0 damage
  from
    instance_deployable id
    inner join deployable d on id.deployable_id = d.id
  where
    id.instance_id = ?
) o limit ?, 5'; --
  execute stmt using @instance, @instance, @page; --
  deallocate prepare stmt; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getSurvivorStats`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getSurvivorStats`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getSurvivorStats`(in `p_survivorId` int)
begin
  select
    medical, worldspace, zombie_kills, state, p.humanity, headshots, survivor_kills, bandit_kills
  from
    survivor s
    inner join profile p on s.unique_id = p.unique_id
  where
    s.id = p_survivorId
    and s.is_dead = 0; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_insertObject`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_insertObject`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertObject`(in `p_uniqueId` varchar(255), in `p_type` varchar(255), in `p_ownerId` int, in `p_worldspace` varchar(255), in `p_instanceId` int)
begin
  insert into instance_deployable (unique_id, deployable_id, owner_id, instance_id, worldspace, created)
  select
    p_uniqueId,
    d.id,
    p_ownerId,
    p_instanceId,
    p_worldspace,
    current_timestamp()
  from
    deployable d
  where
    d.class_name = p_type; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_insertSurvivor`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_insertSurvivor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertSurvivor`(in `p_uniqueId` varchar(128), in `p_playerName` varchar(255), in `p_worldName` varchar(60))
begin
  insert into profile
    (unique_id, name)
  values
    (p_uniqueId, p_playerName)
  on duplicate key update name = p_playerName; --

  insert into survivor (unique_id, start_time, world_id)
  select p_uniqueId, now(), w.id from world w where w.name = p_worldName; --

  select last_insert_id(); --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_killSurvivor`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_killSurvivor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_killSurvivor`(in `p_survivorId` int)
begin
  update survivor set is_dead = 1 where id = p_survivorId; --
  update
    profile
    left join survivor on survivor.unique_id = profile.unique_id
  set
    survival_attempts = survival_attempts+1,
    total_survivor_kills = total_survivor_kills+survivor_kills,
    total_bandit_kills = total_bandit_kills+bandit_kills,
    total_zombie_kills = total_zombie_kills+zombie_kills,
    total_headshots = total_headshots+headshots,
    total_survival_time = total_survival_time+survival_time
  where
    survivor.id = p_survivorId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_loginSurvivor`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_loginSurvivor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loginSurvivor`(in `p_uniqueId` varchar(128), in `p_playerName` varchar(128), in `p_worldName` varchar(60))
begin
  update profile set name = p_playerName where unique_id = p_uniqueId; --

  update
    survivor s
    inner join world w on s.world_id = w.id
  set
    s.state = '["","aidlpercmstpsnonwnondnon_player_idlesteady04",36]'
  where
    w.name = p_worldName
    and s.unique_id = p_uniqueId
    and s.is_dead = 0
    and s.state rlike '.*_(driver|pilot)'; --

  select
    s.id, s.inventory, s.backpack, floor(time_to_sec(timediff(now(), s.start_time)) / 60), s.model, s.last_ate, s.last_drank
  from
    survivor s
    inner join world w on s.world_id = w.id
  where
    w.name = p_worldName
    and s.unique_id = p_uniqueId
    and s.is_dead = 0; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_updateObjectHealth`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_updateObjectHealth`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateObjectHealth`(in `p_objectId` int, in `p_parts` varchar(1024), in `p_damage` double)
begin
  update instance_vehicle set
    parts = p_parts,
    damage = p_damage
  where
    id = p_objectId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_updateObjectInventory`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_updateObjectInventory`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateObjectInventory`(in `p_objectId` int, in `p_inventory` varchar(2048))
begin
  update instance_vehicle set
    inventory = p_inventory
  where
    id = p_objectId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_updateObjectInventoryByUID`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_updateObjectInventoryByUID`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateObjectInventoryByUID`(in `p_uniqueId` varchar(128), in `p_inventory` varchar(8192))
begin
  update instance_deployable set inventory = p_inventory where unique_id = p_uniqueId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_updateObjectPosition`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_updateObjectPosition`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateObjectPosition`(in `p_objectId` int, in `p_worldspace` varchar(255), in `p_fuel` double)
begin
  update instance_vehicle set
    worldspace = if(p_worldspace = '[]', worldspace, p_worldspace),
    fuel = p_fuel
  where
    id = p_objectId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_updateSurvivor`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_updateSurvivor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateSurvivor`(in `p_survivorId` int, in `p_worldspace` varchar(1024), in `p_inventory` varchar(2048), in `p_backpack` varchar(2048), in `p_medical` varchar(1024), in `p_lastAte` int, in `p_lastDrank` int, in `p_survivalTime` int, in `p_model` varchar(255), in `p_humanity` int, in `p_zombieKills` int, in `p_headshots` int, in `p_murders` int, in `p_banditKills` int, in `p_state` varchar(255))
begin
  update
    profile p
    inner join survivor s on s.unique_id = p.unique_id
  set
    p.humanity = if(p_humanity = 0, humanity, humanity + p_humanity)
  where
    s.id = p_survivorId; --

  update survivor set
    zombie_kills = zombie_kills + p_zombieKills,
    headshots = headshots + p_headshots,
    bandit_kills = bandit_kills + p_banditKills,
    survivor_kills = survivor_kills + p_murders,
    state = p_state,
    model = if(p_model = 'any', model, p_model),
    last_ate = if(p_lastAte = -1, 0, last_ate + p_lastAte),
    last_drank = if(p_lastDrank = -1, 0, last_drank + p_lastDrank),
    survival_time = survival_time + p_survivalTime,
    worldspace = if(p_worldspace = '[]', worldspace, p_worldspace),
    medical = if(p_medical = '[]', medical, p_medical),
    backpack = if(p_backpack='[]', backpack, p_backpack),
    inventory = if(p_inventory='[]', inventory, p_inventory)
  where
    id = p_survivorId; --
end
;;
DELIMITER ;
