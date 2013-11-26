-- 石头掉率高的高低的低

-- 铜矿（劣质的石头）
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 2835 and `ChanceOrQuestChance` = 25;

-- 锡矿（粗糙的石头）
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 2836 and `ChanceOrQuestChance` = 25;

-- 铁矿（沉重的石头）
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 2838 and `ChanceOrQuestChance` = 100;

-- 秘银（坚固的石头）
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 7912 and `ChanceOrQuestChance` = 80;

-- 瑟银（厚重的石头）
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 12365 and `ChanceOrQuestChance` = 100;

-- 不正确掉落
UPDATE `creature_template` set `skinloot` = 0 where `minlevel` > 79 and `skinloot` = 100011;
UPDATE `creature_template` set `skinloot` = 0 where `minlevel` > 79 and `skinloot` = 100010;
UPDATE `creature_template` set `skinloot` = 0 where `minlevel` > 79 and `skinloot` = 100009;

-- 定义混乱
UPDATE `creature_template` set `skinloot` = 100001 where `skinloot` = 100008;

-- 追加掉落
UPDATE `creature_template` set `skinloot` = 100008 where `entry` = 1042;
UPDATE `creature_template` set `skinloot` = 100008 where `entry` = 1043;
UPDATE `creature_template` set `skinloot` = 100008 where `entry` = 1069;


-- 错误
UPDATE `skinning_loot_template` set `item` = 4232 where `entry` = 100007 and `item` = 4332;


