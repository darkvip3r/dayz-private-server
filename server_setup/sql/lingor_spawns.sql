
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

USE `dayz`;


-- Dumping structure for table dayz.spawns
DROP TABLE IF EXISTS `spawns`;
CREATE TABLE IF NOT EXISTS `spawns` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `pos` varchar(128) NOT NULL COMMENT 'Spawn location',
  `otype` varchar(128) NOT NULL DEFAULT 'Smallboat_1' COMMENT 'Type of the spawning object',
  `uuid` int(2) unsigned NOT NULL,
  `descr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- Dumping data for table dayz.spawns: 0 rows
DELETE FROM `spawns`;
/*!40000 ALTER TABLE `spawns` DISABLE KEYS */;
INSERT INTO `spawns` (`id`, `pos`, `otype`, `uuid`, `descr`) VALUES
	(1, '[79,[3572.71,1374.62,0.00143909]]', 'Ikarus', 4294967271, 'near hospital parked in football pitch'),
	(2, '[267,[4080.74,1130.51,0.00143909]]', 'TT650_TK_CIV_EP1', 4294967273, 'Military camp (in netting)'),
	(3, '[273,[8842.5,921.916,0.00130701]]', 'Fishing_Boat', 4294967270, 'Player Start Zone (near water)'),
	(4, '[249,[7563.33,1693.72,0.00143909]]', 'UAZ_Unarmed_TK_EP1', 4294967274, 'Between Airfield Hangers'),
	(5, '[90,[6821.08,2497.89,0.00143909]]', 'UralCivil2', 4294967294, 'Small Oil Compund (east-ish)'),
	(6, '[89,[7971.34,1091.71,0.00143909]]', 'tractor', 4294967293, 'Large Open Desert Oilfield - Next to pump'),
	(7, '[195,[6800.51,2828.05,-0.00150663]]', 'Fishing_Boat', 4294967292, 'Small Oil Compund (east dock area)'),
	(8, '[355,[6888.25,3147.13,0.00132751]]', 'ATV_US_EP1', 4294967291, 'Random hill near town (lol)'),
	(9, '[292,[8328.85,8789.24,0.00143909]]', 'TT650_TK_CIV_EP1', 4294967290, 'Bike in t junction at Cemarin'),
	(10, '[104,[8560.03,8102.29,0.00143909]]', 'TT650_TK_CIV_EP1', 256588888, 'NE island area - football field'),
	(11, '[181,[6952.14,6240.73,0.00143909]]', 'hilux1_civil_3_open_EP1', 12555555, 'Parked at store president palace area.'),
	(12, '[88,[5968.15,6595.98,0.00117016]]', 'ATV_US_EP1', 255558869, 'ATV - Redbull racetrack (road area)'),
	(13, '[51,[5927.38,6616.12,0.00140476]]', 'ATV_US_EP1', 255558868, 'ATV - Redbull racetrack (dirt area)'),
	(14, '[5,[5643.03,4860.26,0.000733852]]', 'Fishing_Boat', 4294967289, 'In harbour - East of Corazan'),
	(15, '[179,[5802.9,4712.73,0.00143814]]', 'TT650_TK_CIV_EP1', 1122334455, 'At carpark in Corazan town'),
	(16, '[180,[5775.69,4724.98,0.00143814]]', 'Ikarus', 4294967288, 'Car park at corazon'),
	(17, '[134,[6781.75,1631.72,0.00143814]]', 'car_hatchback', 2020141454, 'Old Mines'),
	(18, '[274,[6090.88,1689.93,0.00143886]]', 'V3S_Civ', 20878965, 'Lagoso Army Camp Office'),
	(19, '[314,[5229.58,1397.14,0.00131416]]', 'hilux1_civil_3_open_EP1', 4294967287, 'Calamar Woods Area (on end road)'),
	(20, '[351,[2677.54,2474.74,0.00143147]]', 'UralCivil2', 789456123, 'Island Between Ugauado (near bridge)'),
	(21, '[9,[3053.34,8034.07,0.00143909]]', 'LandRover_CZ_EP1', 4294967286, 'Military barracks (prison)'),
	(22, '[322,[2878.26,7971.67,0.00223923]]', 'PBX', 1452256589, 'Prison bay'),
	(23, '[317,[2645.8,6945.16,0.00143909]]', 'tractor', 4294967285, 'FOB - Near prison on farmed area'),
	(24, '[75,[3287.92,6434.28,0.00110245]]', 'ATV_US_EP1', 210125589, 'Hecienious crossroads'),
	(25, '[223,[3955.09,5245.02,0.0023964]]', 'PBX', 8978955, 'Alculto Pier'),
	(26, '[177,[4073.41,5156.29,0.00143814]]', 'UAZ_Unarmed_TK_CIV_EP1', 142058777, 'Alculto Office Area'),
	(27, '[285,[4290.23,4935.53,0.00152206]]', 'S1203_TK_CIV_EP1', 4294967284, 'San Arulco Carpark (not far from a store)'),
	(28, '[5,[4198.66,4442.61,0.00143814]]', 'S1203_TK_CIV_EP1', 4294967283, 'Football pitch in san arulco'),
	(29, '[276,[3985.99,4118.58,0.00143433]]', 'Old_bike_TK_CIV_EP1', 202050254, 'Outside Dutch castle (dirt road)'),
	(30, '[268,[3956.76,4229.46,0.00143433]]', 'UH1H_DZ', 4294967282, 'Inside Dutch Castle (main Area)'),
	(31, '[254,[3933.37,4220.77,0.00143433]]', 'Old_bike_TK_CIV_EP1', 4294967281, 'Inside castle Wall (dutch)'),
	(32, '[184,[3551.31,3739.72,0.0010376]]', 'Old_bike_TK_CIV_EP1', 14151617, 'Research Lab 102'),
	(33, '[186,[3546.66,3740.02,0.00143433]]', 'ATV_US_EP1', 2048987898, 'Research Lab 102 - Side'),
	(34, '[87,[2476.24,4105.05,0.00119781]]', 'UAZ_Unarmed_TK_CIV_EP1', 4294967280, '4x4 racetrack'),
	(35, '[357,[1938.92,4559.71,0.00143909]]', 'SUV_TK_CIV_EP1', 4294967279, 'Rapido raceway (tarmac)'),
	(36, '[105,[1213.43,4815.59,0.00133926]]', 'PBX', 4294967278, 'Pista By Villa'),
	(37, '[94,[621.466,4631.81,0.00143814]]', 'Volha_2_TK_CIV_EP1', 4294967277, 'Villa Oscura'),
	(38, '[168,[602.249,4686.56,6.81655]]', 'UH1H_DZ', 4294967276, 'Possible spawn on villa garage roof'),
	(39, '[68,[690.968,2267.13,0.00147247]]', 'Old_bike_TK_CIV_EP1', 42089, 'Garden in rago.'),
	(40, '[294,[595.54,1374.92,0.00143814]]', 'Ikarus', 17171789, 'Rago Store / Petrol Station'),
	(41, '[57,[1562.65,1456.18,0.00101298]]', 'Fishing Boat', 696969, 'Waters Edge - EAST of pintosa');
/*!40000 ALTER TABLE `spawns` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;