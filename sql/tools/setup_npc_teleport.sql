DROP TABLE IF EXISTS `custom_npc_tele_category`;
CREATE TABLE `custom_npc_tele_category` (
  `id` int(6) unsigned NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `flag` tinyint(3) unsigned NOT NULL default '0',
  `data0` bigint(20) unsigned NOT NULL default '0',
  `data1` int(6) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `custom_npc_tele_destination`;
CREATE TABLE `custom_npc_tele_destination` (
  `id` int(6) unsigned NOT NULL auto_increment,
  `name` char(100) NOT NULL default '',
  `pos_X` float NOT NULL default '0',
  `pos_Y` float NOT NULL default '0',
  `pos_Z` float NOT NULL default '0',
  `map` smallint(5) unsigned NOT NULL default '0',
  `orientation` float NOT NULL default '0',
  `level` tinyint(3) unsigned NOT NULL default '0',
  `cost` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `custom_npc_tele_association`;
CREATE TABLE `custom_npc_tele_association` (
  `cat_id` int(6) unsigned NOT NULL default '0',
  `dest_id` int(6) unsigned NOT NULL default '0',
  PRIMARY KEY  (`cat_id`, `dest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `custom_npc_tele_category` (`id`, `name`, `flag`, `data0`, `data1`) VALUES (1, '【城市】', 0, 1, 0);
INSERT INTO `custom_npc_tele_category` (`id`, `name`, `flag`, `data0`, `data1`) VALUES (2, '【城市】', 0, 2, 0);
INSERT INTO `custom_npc_tele_category` (`id`, `name`, `flag`, `data0`, `data1`) VALUES (3, '【中立城市】', 0, 0, 0);
INSERT INTO `custom_npc_tele_category` (`id`, `name`, `flag`, `data0`, `data1`) VALUES (4, '【出生地】', 0, 1, 0);
INSERT INTO `custom_npc_tele_category` (`id`, `name`, `flag`, `data0`, `data1`) VALUES (5, '【出生地】', 0, 2, 0);
INSERT INTO `custom_npc_tele_category` (`id`, `name`, `flag`, `data0`, `data1`) VALUES (6, '【艾泽拉斯副本与世界首领】', 0, 0, 0);
INSERT INTO `custom_npc_tele_category` (`id`, `name`, `flag`, `data0`, `data1`) VALUES (7, '【燃烧的远征副本】', 5, 60, 0);
INSERT INTO `custom_npc_tele_category` (`id`, `name`, `flag`, `data0`, `data1`) VALUES (8, '【巫妖王之怒副本】', 5, 70, 0);
INSERT INTO `custom_npc_tele_category` (`id`, `name`, `flag`, `data0`, `data1`) VALUES (9, '【GM岛】', 5, 80, 0);

INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (1, '|cff000000|TInterface\\ICONS\\Achievement_Leader_King_Magni_Bronzebeard.blp:32:32:2:2|t【联盟主城】铁炉堡', -4948, -921, 504, 0, 2.1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (2, '|cff000000|TInterface\\ICONS\\Achievement_Leader_ Thrall.blp:32:32:2:2|t【部落主城】奥格瑞玛', 1337, -4380, 26.2, 1, 0.23, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (3, '|cff000000|TInterface\\ICONS\\Achievement_Leader_King_Varian_Wrynn.blp:32:32:2:2|t【联盟】暴风城', -8829, 626, 96, 0, 3, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (4, '|cff000000|TInterface\\ICONS\\Achievement_Leader_Tyrande_Whisperwind.blp:32:32:2:2|t【联盟】达纳苏斯', 9951, 2319, 1340, 1, 0.18, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (5, '|cff000000|TInterface\\ICONS\\Achievement_Leader_Prophet_Velen.blp:32:32:2:2|t【联盟】埃索达', -4071.7, -12036.7, -1.5, 530, 1.55, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (6, '|cff000000|TInterface\\ICONS\\Achievement_Leader_Cairne Bloodhoof.blp:32:32:2:2|t【部落】雷霆崖', -1347, 190, 61.3, 1, 6, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (7, '|cff000000|TInterface\\ICONS\\Achievement_Leader_Sylvanas.blp:32:32:2:2|t【部落】幽暗城', 1607, 239, -50, 0, 1.97, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (8, '|cff000000|TInterface\\ICONS\\Achievement_Leader_Lorthemar_Theron .blp:32:32:2:2|t【部落】银月城', 9336.9, -7278.4, 13.6, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (9, '|cff000000|TInterface\\ICONS\\Achievement_Zone_EversongWoods.blp:32:32:2:2|t【外域主城】|cff0000ff沙塔斯', -1871.5, 5432, -10, 530, 5.9, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (10, '|cff000000|TInterface\\ICONS\\Achievement_Zone_GrizzlyHills_01.blp:32:32:2:2|t【诺森德主城】|cff0000ff 达拉然', 4165, 3011.7, 337.6, 571, 6, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (11, '|cff000000|TInterface\\ICONS\\Achievement_Reputation_08.blp:32:32:2:2|t【管理员】|cffAE0000迷之岛', 16211, 16223.5, 3, 1, 1.25, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (201, '|cff000000|TInterface\\ICONS\\Achievement_Zone_ArathiHighlands_01.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff 棘齿城', -977, -3788, 6, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (202, '|cff000000|TInterface\\ICONS\\Achievement_Zone_ElwynnForest.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff藏宝海湾', -14302, 518, 9, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (203, '|cff000000|TInterface\\ICONS\\Achievement_Zone_Tanaris_01.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff加基森', -7175.3, -3793.2, 8.37, 1, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (204, '|cff000000|TInterface\\ICONS\\Achievement_Zone_Ashenvale_01.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff 月光林地', 7959, -2400, 489, 1, 1.6, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (205, '|cff000000|TInterface\\ICONS\\Achievement_Zone_Badlands_01.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff 希利苏斯', -6833.5, 746.7, 42.6, 1, 3.6, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (206, '|cff000000|TInterface\\ICONS\\Achievement_Zone_AlteracMountains_01.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff 永望镇', 6723, -4606, 720.5, 1, 4.78, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (207, '|cff000000|TInterface\\ICONS\\Achievement_Zone_Terrokar.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff 奎尔丹纳斯', 12835, -7114, 5.4, 530, 2.38, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (208, '|cff000000|TInterface\\ICONS\\Achievement_Zone_Feralas.blp:32:32:2:2|t【外域】|cff0000ff 哈兰', 4165, 7960, -22.8, 530, 1.5, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (209, '|cff000000|TInterface\\ICONS\\Achievement_Zone_DragonBlight_04.blp:32:32:2:2|t【外域】|cff0000ff风暴尖塔', 4165, 3011, 338, 530, 6, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (301, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff血色修道院', 2906, -805, 160.3, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (302, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff剃刀高地', -4655.27, -2522.84, 81.57, 1, 4, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (303, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff剃刀沼泽', -4464.4, -1666, 81.9, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (304, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff诺莫瑞根', -5163.33, 927.62, 257.1, 0, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (305, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff暴风城监狱', -8767.3, 843.7, 88.75, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (306, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff黑暗深渊', 4249, 745.37, -24.4, 1, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (307, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff影牙城堡', -232.7, 1567.17, 76.89, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (308, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff哀号洞穴', -742.01, -2217, 15.915, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (309, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff死亡矿井', -11208, 1676.98, 24.53, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (310, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff怒焰裂谷', 1814, -4416.98, -18.46, 1, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (311, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】奥达曼', -6067.8, -2955.21, 209.77, 0, 5, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (312, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】祖尔法拉克', -6797.45, -2891.98, 8.879, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (313, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】玛拉顿', -1187.4, 2879.81, 85.822, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (314, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】沉没的神庙', -10180.1, -3994.19, -109.98, 0, 6, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (315, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】黑石深渊', -7179.48, -923.93, 166.51, 0, 5, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (316, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】黑石塔', -7524.42, -1229.53, 285.73, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (317, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】黑石塔上层', -7524.42, -1229.53, 285.73, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (318, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】厄运之锤', -4350.45, 1331.02, 159.233, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (319, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】通灵学院', 1274.82, -2553.2, 90.2, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (320, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_Normal.blp:32:32:2:2|t【艾泽拉斯】斯坦索姆', 3392.44, -3407.23, 142.245, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (321, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_10man.blp:32:32:2:2|t【艾泽拉斯】祖尔格拉布', -11915.8, -1225.04, 92.29, 0, 4, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (322, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_10man.blp:32:32:2:2|t【艾泽拉斯】安其拉废墟', -8416.96, 1505.12, 31.47, 1, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (323, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_10man.blp:32:32:2:2|t【艾泽拉斯】熔火之心', 1166.89, -410.335, -93.841, 230, 3.89, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (324, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_10man.blp:32:32:2:2|t【艾泽拉斯】黑翼之巢', 163.167, -444.165, 122.058, 229, 3.124, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (325, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_10man.blp:32:32:2:2|t【艾泽拉斯】安其拉神庙', -8233.87, 1996.74, 129.84, 1, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (326, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_25man.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff暮色森林', -10526.2, -434.997, 50.8948, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (327, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_25man.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff辛特兰', 759.606, -3893.34, 116.475, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (328, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_25man:32:32:2:2|t【艾泽拉斯】|cff0000ff灰谷', 3120.29, -3439.44, 139.566, 1, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (329, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_25man.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff艾萨拉', 2622.22, -5977.93, 100.563, 1, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (330, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_25man.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff菲拉斯', -2741.29, 2009.48, 31.8773, 1, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (331, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_25man.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff诅咒之地', -12201.8, -2523.68, 1.08551, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (332, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_25man.blp:32:32:2:2|t【艾泽拉斯】|cff0000ff水晶谷', -6301, 1539.32, 3.66896, 1, 1, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (333, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar77_10man.blp:32:32:2:2|t【艾泽拉斯】奥妮克西亚的的巢穴', -4715.51, -3732.64, 54.072, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (401, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_Heroic.blp:32:32:2:2|t【燃烧远征】|cff0000ff破碎大厅', -308.98, 3073.8, -3.65, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (402, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_Heroic.blp:32:32:2:2|t【燃烧远征】|cff0000ff暗影迷宫', -3524.92, 4943.5, -101.4, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (403, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_Heroic.blp:32:32:2:2|t【燃烧远征】|cff0000ff黑色沼泽', -8751.58, -4201.73, -209.5, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (404, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_Heroic.blp:32:32:2:2|t【燃烧远征】|cff0000ff蒸汽地窟', 732.3, 6865.8, -70.23, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (405, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_Heroic.blp:32:32:2:2|t【燃烧远征】|cff0000ff能源舰', 2871.5, 1554.5, 252.16, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (406, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_Heroic.blp:32:32:2:2|t【燃烧远征】|cff0000ff生态船', 3404.8, 1490.2, 182.8, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (407, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_Heroic.blp:32:32:2:2|t【燃烧远征】|cff0000ff禁魔监狱', 3308.2, 1342, 505.56, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (408, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_Heroic.blp:32:32:2:2|t【燃烧远征】|cff0000ff魔导师平台', -5.89, -0.12, -0.12, 585, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (409, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_25man.blp:32:32:2:2|t【燃烧远征】卡拉赞', -11115, -2007.54, 50, 0, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (410, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_25man.blp:32:32:2:2|t【燃烧远征】格鲁尔的巢穴', 3545.9, 5090, 3.4, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (411, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_25man.blp:32:32:2:2|t【燃烧远征】玛瑟里顿的巢穴', -340.159, 3139.83, -102.927, 530, 5.104, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (412, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_25man.blp:32:32:2:2|t【燃烧远征】毒蛇神殿', 891.4, 6865.7, -66.9, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (413, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_25man.blp:32:32:2:2|t【燃烧远征】风暴要塞', 3088.8, 1385.5, 184.9, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (414, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_25man.blp:32:32:2:2|t【燃烧远征】海加尔峰', -8183.4, -4195.9, -171.36, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (415, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_25man.blp:32:32:2:2|t【燃烧远征】黑暗神殿', -3597.4, 344.3, 38.7, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (416, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_25man.blp:32:32:2:2|t【燃烧远征】祖阿曼', 6850.44, -7990.36, 190.07, 530, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (417, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_Ulduar80_25man.blp:32:32:2:2|t【燃烧远征】太阳之井高地', 12560.8, -6774.59, 15.08, 530, 3.11626, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (501, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】乌特加德城堡', 1216.17, -4865.75, 41.25, 571, 0.279, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (502, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】乌特加德之巅', 1260.03, -4851.55, 215.77, 571, 3.4558, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (503, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】魔枢', 3891.43, 6985.33, 69.49, 571, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (504, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】魔环', 3879.12, 6984.11, 106.32, 571, 3.068, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (505, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】净化斯坦索姆', -8662.03, -4397.35, -207.35, 1, 3.416, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (506, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】岩石大厅', 8921.85, -1001.07, 1039.49, 571, 1.52, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (507, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】达克萨隆要塞', 4774.72, -2039, 229.41, 571, 1.5865, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (508, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】艾卓－尼鲁布', 3696.68, 2153.9, 35.69, 571, 2.516, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (509, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】闪电大厅', 9153.33, -1356.36, 1079.91, 571, 5.519, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (510, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】古达克', 6719.21, -4643.54, 450.06, 571, 3.883, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (511, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】紫罗兰监狱', 5707.65, 521.31, 649.86, 571, 4.03, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (512, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】安卡赫特古王国', 3699.5, 2150.03, 35.74, 571, 4.217, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (513, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】勇士的试炼', 8572.89, 792.227, 558.6, 571, 6.2125, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (514, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】众魂熔炉', 5636.65, 2064.4, 798.1, 571, 4.6224, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (515, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】萨伦之渊', 5636.65, 2064.4, 798.1, 571, 4.6224, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (516, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_Heroic.blp:32:32:2:2|t【巫妖王之怒】倒影大厅', 5636.65, 2064.4, 798.1, 571, 4.6224, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (517, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_25man.blp:32:32:2:2|t【巫妖王之怒】纳克萨玛斯', 3665.48, -1267, 243.51, 571, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (518, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_25man.blp:32:32:2:2|t【巫妖王之怒】黑曜石圣殿', 3555.79, 274.26, -115.96, 571, 3.232, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (519, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_25man.blp:32:32:2:2|t【巫妖王之怒】永恒之眼', 3857.7, 6991.78, 152.03, 571, 5.738, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (520, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_25man.blp:32:32:2:2|t【巫妖王之怒】奥杜尔', 9242.13, -1114.1, 1216.2, 571, 6.2824, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (521, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_25man.blp:32:32:2:2|t【巫妖王之怒】十字军试炼', 8515.31, 734.686, 558.6, 571, 4.7, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (522, '|cff000000|TInterface\\ICONS\\Achievement_Dungeon_UtgardePinnacle_25man.blp:32:32:2:2|t【巫妖王之怒】冰冠要塞', 5861.95, 2105.08, 636, 571, 3.5657, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (601, '|cff000000|TInterface\\ICONS\\Achievement_Character_Human_Male.blp:32:32:2:2|t【人类】|cff0000ff 北郡山谷', -8942.65, -136, 83.7, 0, 0.58, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (602, '|cff000000|TInterface\\ICONS\\Achievement_Character_Draenei_Male.blp:32:32:2:2|t【德莱尼】|cff0000ff 埃门谷', -3981.95, -13890, 95, 530, 2, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (603, '|cff000000|TInterface\\ICONS\\Achievement_Character_Nightelf_Male.blp:32:32:2:2|t【暗夜精灵】|cff0000ff 幽影谷', 10321, 834.7, 1326.4, 1, 0, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (604, '|cff000000|TInterface\\ICONS\\Achievement_Character_Gnome_Male.blp:32:32:2:2|t【矮人与地精】|cff0000ff 寒脊山谷', -6233, 334, 383, 0, 0.45, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (605, '|cff000000|TInterface\\ICONS\\Achievement_Character_Undead_Male.blp:32:32:2:2|t【亡灵】|cff0000ff 丧钟镇', 1674, 1663, 138.3, 0, 0.22, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (606, '|cff000000|TInterface\\ICONS\\Achievement_Character_Bloodelf_Male.blp:32:32:2:2|t【血精灵】|cff0000ff 逐日岛', 10349, -6364, 34.7, 530, 4, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (607, '|cff000000|TInterface\\ICONS\\Achievement_Character_Tauren_Male.blp:32:32:2:2|t【牛头人】|cff0000ff 纳拉其营地', -2928, -257.5, 53, 1, 0.4, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (608, '|cff000000|TInterface\\ICONS\\Achievement_Character_Orc_Male.blp:32:32:2:2|t【兽人与巨魔】|cff0000ff 试炼谷', -605.5, -4259, 39, 1, 2.3, 0, 0);
INSERT INTO `custom_npc_tele_destination` (`id`, `name`, `pos_X`, `pos_Y`, `pos_Z`, `map`, `orientation`, `level`, `cost`) VALUES (609, '|cff000000|TInterface\\ICONS\\Achievement_Boss_JedogaShadowseeker.blp:32:32:2:2|t【死亡骑士】|cff0000ff 黯黑堡', 2369.5, -5657, 426, 609, 0.7, 0, 0);


INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (1, 3);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (1, 4);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (1, 5);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (1, 9);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (1, 10);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (2, 2);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (2, 6);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (2, 7);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (2, 8);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (2, 9);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (2, 10);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (3, 201);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (3, 202);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (3, 203);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (3, 204);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (3, 205);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (3, 206);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (3, 207);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (3, 208);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (3, 209);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (4, 601);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (4, 602);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (4, 603);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (4, 604);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (4, 609);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (5, 605);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (5, 606);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (5, 607);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (5, 608);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (5, 609);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 301);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 302);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 303);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 304);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 305);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 306);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 307);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 308);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 309);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 310);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 311);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 312);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 313);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 314);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 315);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 316);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 317);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 318);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 319);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 320);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 321);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 322);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 323);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 324);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 325);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 326);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 327);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 328);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 329);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 330);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 331);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 332);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (6, 333);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 401);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 402);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 403);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 404);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 405);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 406);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 407);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 408);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 409);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 410);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 411);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 412);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 413);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 414);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 415);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 416);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (7, 417);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 501);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 502);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 503);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 504);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 505);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 506);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 507);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 508);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 509);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 510);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 511);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 512);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 513);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 514);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 515);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 516);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 517);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 518);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 519);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 520);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 521);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (8, 522);
INSERT INTO `custom_npc_tele_association` (`cat_id`, `dest_id`) VALUES (9, 11);

-- `npc_text`
REPLACE INTO `npc_text` (`ID`, `text0_0`) VALUES
   (100000, 'Choose your Category.'),
   (100001, 'Choose your Destination.');

-- `creature_template`
DELETE FROM `creature_template` WHERE (`entry`='100000');
INSERT INTO `creature_template` VALUES (100000, 0, 0, 0, 0, 0, 26502, 0, 0, 0, '传送大师', '', '', 0, 83, 83, 0, 35, 35, 1, 1, 1.14286, 2, 1, 509, 683, 0, 805, 1, 0, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_teleport', 2, 1);
