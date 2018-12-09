/*
-- ###################################################################################### --
--  ____    __                                         ____                           
-- /\  _`\ /\ \__                  __                 /\  _`\                         
-- \ \,\L\_\ \ ,_\  __  __     __ /\_\     __      ___\ \ \/\_\    ___   _ __    __   
--  \/_\__ \\ \ \/ /\ \/\ \  /'_ `\/\ \  /'__`\  /' _ `\ \ \/_/_  / __`\/\`'__\/'__`\ 
--    /\ \L\ \ \ \_\ \ \_\ \/\ \L\ \ \ \/\ \L\.\_/\ \/\ \ \ \L\ \/\ \L\ \ \ \//\  __/ 
--    \ `\____\ \__\\/`____ \ \____ \ \_\ \__/.\_\ \_\ \_\ \____/\ \____/\ \_\\ \____\
--     \/_____/\/__/ `/___/> \/___L\ \/_/\/__/\/_/\/_/\/_/\/___/  \/___/  \/_/ \/____/
--                      /\___/ /\____/                                                
--                      \/__/  \_/__/          http://stygianthebest.github.io                                         
-- 
-- ###################################################################################### --
-- CHARACTERS: DEFAULT GUILDS
-- GUID 1: Horde
-- GUID 2: Alliance
-- 
-- This is the supporting SQL file for the StartGuild released with the StygianCore
-- repack. This file creates two default guilds for both Horde and Alliance characters 
-- to join when using the StartGuild module.
--
-- ** NOTE *
-- ** Characters serving as Guildmaster for each guild are included in the StygianCore
-- ** restoration archive. If you are running this stand-alone and not part of the 
-- ** StygianCore repack, you will need to meet the pre-requisites outlined below
-- ** to successfully run the StartGuild module.
-- **
-- ** The 'leaderguid` value must be present before running worldserver.exe
-- ** Pre-requisites:
-- ** 1. Create an Horde character with ID: 1.
-- ** 2. Create an Alliance character with ID: 2.
--
-- -- DEFAULT HORDE/ALLIANCE CHARACTERS
-- -- GUILD_MEMBER
-- -- GUILD_RANK
-- -- GUILD_BANK_TAB
-- -- GUILD_BANK_RIGHT
-- -- GUILD_MEMBER_WITHDRAW
--
-- ###################################################################################### --
*/

USE stygian_characters;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------------------------------------------------------------------------------------------
-- GUILD
-- ----------------------------------------------------------------------------------------------------------------

-- Faction: Horde
-- Name: Adventure
-- Guild GUID: 1
-- GuildMaster GUID: 1
-- GMName: Scara(Female Troll Warrior)
DELETE FROM `guild` WHERE `guildid`=1;
INSERT INTO `guild` (`guildid`, `name`, `leaderguid`, `EmblemStyle`, `EmblemColor`, `BorderStyle`, `BorderColor`, `BackgroundColor`, `info`, `motd`, `createdate`, `BankMoney`) VALUES (1, 'Adventure', 1, 166, 14, 1, 14, 44, 'Adventure is reborn! We began our grand adventure in 2006 and ended in 2011 after the Cataclysm ravaged the lands. Many moons have passed and we are reborn during the Summer Solstice Fire Festival of June 2017. Strength and Honor! May the Warsong Never Fade!', 'Welcome to Adventure!', 1498723958, 0);

-- Faction: Alliance
-- Name: Caress of Steel
-- Guild GUID: 2
-- GuildMaster GUID: 2
-- GMName: Tira (Female Dwarf Warrior)
DELETE FROM `guild` WHERE `guildid`=2;
INSERT INTO `guild` (`guildid`, `name`, `leaderguid`, `EmblemStyle`, `EmblemColor`, `BorderStyle`, `BorderColor`, `BackgroundColor`, `info`, `motd`, `createdate`, `BankMoney`) VALUES (2, 'Caress of Steel', 2, 112, 3, 5, 3, 35, 'An Alliance guild based out of Stormwind. Ask to visit our guild house.', 'Welcome to Caress of Steel', 1499669732, 0);


-- ----------------------------------------------------------------------------------------------------------------
-- GUILD_MEMBER
-- ----------------------------------------------------------------------------------------------------------------

-- Add EXISTING users to guilds
-- Character GUIDs referenced are imported by the StygianCore restoration archive
INSERT INTO `stygian_characters`.`guild_member` (`guildid`, `guid`, `rank`, `pnote`, `offnote`) VALUES ('1', '1', '1', '', '');
INSERT INTO `stygian_characters`.`guild_member` (`guildid`, `guid`, `rank`, `pnote`, `offnote`) VALUES ('2', '2', '1', '', '');


-- ----------------------------------------------------------------------------------------------------------------
-- GUILD_RANK
-- ----------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `guild_rank`;
CREATE TABLE `guild_rank` (
  `guildid` int(10) unsigned NOT NULL DEFAULT '0',
  `rid` tinyint(3) unsigned NOT NULL,
  `rname` varchar(20) NOT NULL DEFAULT '',
  `rights` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `BankMoneyPerDay` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`rid`),
  KEY `Idx_rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System';

-- ----------------------------
-- Records of guild_rank
-- ----------------------------
INSERT INTO `guild_rank` VALUES ('1', '0', 'Guild Master', '1962495', '99999');
INSERT INTO `guild_rank` VALUES ('1', '1', 'VIP', '1962495', '0');
INSERT INTO `guild_rank` VALUES ('1', '2', 'Adventurer', '1876191', '0');
INSERT INTO `guild_rank` VALUES ('1', '3', 'Member', '786515', '0');
INSERT INTO `guild_rank` VALUES ('1', '4', 'Initiate', '786515', '0');
INSERT INTO `guild_rank` VALUES ('2', '0', 'Guild Master', '1962495', '99999');
INSERT INTO `guild_rank` VALUES ('2', '1', 'VIP', '1962495', '0');
INSERT INTO `guild_rank` VALUES ('2', '2', 'Adventurer', '811231', '0');
INSERT INTO `guild_rank` VALUES ('2', '3', 'Member', '794835', '0');
INSERT INTO `guild_rank` VALUES ('2', '4', 'Initiate', '794707', '0');


-- ----------------------------------------------------------------------------------------------------------------
-- GUILD_BANK_TAB
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `guild_bank_tab`;
CREATE TABLE `guild_bank_tab` (
  `guildid` int(10) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TabName` varchar(16) NOT NULL DEFAULT '',
  `TabIcon` varchar(100) NOT NULL DEFAULT '',
  `TabText` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`guildid`,`TabId`),
  KEY `guildid_key` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of guild_bank_tab
-- ----------------------------
INSERT INTO `guild_bank_tab` VALUES ('1', '0', 'Storage', 'INV_Misc_Bag_12', null);
INSERT INTO `guild_bank_tab` VALUES ('1', '1', 'WeaponsArmor', 'INV_Shield_64', null);
INSERT INTO `guild_bank_tab` VALUES ('1', '2', 'ScrollsReagents', 'INV_Scroll_13', null);
INSERT INTO `guild_bank_tab` VALUES ('1', '3', 'FoodDrink', 'INV_Misc_Food_99', null);
INSERT INTO `guild_bank_tab` VALUES ('1', '4', 'JewelryGems', 'INV_Misc_Gem_EbonDraenite_02', null);
INSERT INTO `guild_bank_tab` VALUES ('1', '5', 'GuildMaster', 'INV_Misc_FireDancer_01', null);
INSERT INTO `guild_bank_tab` VALUES ('2', '0', 'Storage', 'INV_Misc_Bag_12', null);
INSERT INTO `guild_bank_tab` VALUES ('2', '1', 'Gear', 'INV_Shield_64', null);
INSERT INTO `guild_bank_tab` VALUES ('2', '2', 'Enchantments', 'INV_Scroll_13', null);
INSERT INTO `guild_bank_tab` VALUES ('2', '3', 'Consumables', 'INV_Misc_Food_99', null);
INSERT INTO `guild_bank_tab` VALUES ('2', '4', 'Crafting', 'INV_Misc_Gem_EbonDraenite_02', null);
INSERT INTO `guild_bank_tab` VALUES ('2', '5', 'GuildMaster', 'INV_Misc_FireDancer_01', null);


-- ----------------------------------------------------------------------------------------------------------------
-- GUILD_BANK_RIGHT
-- ----------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `guild_bank_right`;
CREATE TABLE `guild_bank_right` (
  `guildid` int(10) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `gbright` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SlotPerDay` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`TabId`,`rid`),
  KEY `guildid_key` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of guild_bank_right
-- ----------------------------
INSERT INTO `guild_bank_right` VALUES ('1', '0', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('1', '0', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '0', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '0', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '0', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '1', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('1', '1', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '1', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '1', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '1', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '2', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('1', '2', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '2', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '2', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '2', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '3', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('1', '3', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '3', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '3', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '3', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '4', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('1', '4', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '4', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '4', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '4', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '5', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('1', '5', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '5', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '5', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('1', '5', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '0', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('2', '0', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '0', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '0', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '0', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '1', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('2', '1', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '1', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '1', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '1', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '2', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('2', '2', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '2', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '2', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '2', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '3', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('2', '3', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '3', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '3', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '3', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '4', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('2', '4', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '4', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '4', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '4', '4', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '5', '0', '255', '4294967295');
INSERT INTO `guild_bank_right` VALUES ('2', '5', '1', '7', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '5', '2', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '5', '3', '0', '0');
INSERT INTO `guild_bank_right` VALUES ('2', '5', '4', '0', '0');

-- ----------------------------------------------------------------------------------------------------------------
-- GUILD_MEMBER_WITHDRAW
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `guild_member_withdraw`;
CREATE TABLE `guild_member_withdraw` (
  `guid` int(10) unsigned NOT NULL,
  `tab0` int(10) unsigned NOT NULL DEFAULT '0',
  `tab1` int(10) unsigned NOT NULL DEFAULT '0',
  `tab2` int(10) unsigned NOT NULL DEFAULT '0',
  `tab3` int(10) unsigned NOT NULL DEFAULT '0',
  `tab4` int(10) unsigned NOT NULL DEFAULT '0',
  `tab5` int(10) unsigned NOT NULL DEFAULT '0',
  `money` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild Member Daily Withdraws';
-- ----------------------------------------------------------------------------------------------------------------
-- Records of guild_member_withdraw
-- ----------------------------------------------------------------------------------------------------------------
INSERT INTO `guild_member_withdraw` VALUES ('1', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `guild_member_withdraw` VALUES ('2', '3', '0', '0', '0', '0', '0', '0');