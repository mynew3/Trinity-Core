-- 虚无行者爪牙
UPDATE `creature_template` set `minlevel`      =  1 where  `entry` = 8996;
UPDATE `creature_template` set `mindmg`        = 15 where  `entry` = 8996;
UPDATE `creature_template` set `maxdmg`        = 27 where  `entry` = 8996;
UPDATE `creature_template` set `attackpower`   = 35 where  `entry` = 8996;
UPDATE `creature_template` set `minrangedmg`   = 19 where  `entry` = 8996;
UPDATE `creature_template` set `maxrangedmg`   = 32 where  `entry` = 8996;
UPDATE `creature_template` set `rangedattackpower`   = 32 where  `entry` = 8996;

-- 暗爪伤害过高
UPDATE `smart_scripts` set `action_param1` = 695 where `entryorguid` = 3203 and `action_param1` =20791;
UPDATE `smart_scripts` set `action_param1` = 695 where `entryorguid` = 3204 and `action_param1` =20791;
UPDATE `smart_scripts` set `action_param1` = 695 where `entryorguid` = 3198 and `action_param1` =20791;










