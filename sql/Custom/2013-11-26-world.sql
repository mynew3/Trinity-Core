-- ʯͷ���ʸߵĸߵ͵ĵ�

-- ͭ�����ʵ�ʯͷ��
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 2835 and `ChanceOrQuestChance` = 25;

-- ���󣨴ֲڵ�ʯͷ��
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 2836 and `ChanceOrQuestChance` = 25;

-- ���󣨳��ص�ʯͷ��
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 2838 and `ChanceOrQuestChance` = 100;

-- ��������̵�ʯͷ��
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 7912 and `ChanceOrQuestChance` = 80;

-- ɪ�������ص�ʯͷ��
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 75 WHERE `item` = 12365 and `ChanceOrQuestChance` = 100;

-- ����ȷ����
UPDATE `creature_template` set `skinloot` = 0 where `minlevel` > 79 and `skinloot` = 100011;
UPDATE `creature_template` set `skinloot` = 0 where `minlevel` > 79 and `skinloot` = 100010;
UPDATE `creature_template` set `skinloot` = 0 where `minlevel` > 79 and `skinloot` = 100009;

-- �������
UPDATE `creature_template` set `skinloot` = 100001 where `skinloot` = 100008;

-- ׷�ӵ���
UPDATE `creature_template` set `skinloot` = 100008 where `entry` = 1042;
UPDATE `creature_template` set `skinloot` = 100008 where `entry` = 1043;
UPDATE `creature_template` set `skinloot` = 100008 where `entry` = 1069;


-- ����
UPDATE `skinning_loot_template` set `item` = 4232 where `entry` = 100007 and `item` = 4332;


