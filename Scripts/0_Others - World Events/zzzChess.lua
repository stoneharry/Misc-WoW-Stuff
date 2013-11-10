--[[
SET @CHESS := 68000;

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+0, "Chess Piece - White Pawn", "", '', '0', '10', '0', '0', '0', '0', '3526', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+0, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+1, "Chess Piece - White Tower", "", '', '0', '10', '0', '0', '0', '0', '525', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+1, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+2, "Chess Piece - White Knight", "", '', '0', '10', '0', '0', '0', '0', '3167', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+2, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+3, "Chess Piece - White Bishop", "", '', '0', '10', '0', '0', '0', '0', '5548', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+3, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+4, "Chess Piece - White Queen", "", '', '0', '10', '0', '0', '0', '0', '30863', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+4, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+5, "Chess Piece - White King", "", '', '0', '10', '0', '0', '0', '0', '28127', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+5, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+6, "Chess Piece - Black Pawn", "", '', '0', '10', '0', '0', '0', '0', '2141', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+6, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+7, "Chess Piece - Black Tower", "", '', '0', '10', '0', '0', '0', '0', '1405', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+7, '1', '1', '35', '1', '1', '0', '1.4', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+8, "Chess Piece - Black Knight", "", '', '0', '10', '0', '0', '0', '0', '4602', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+8, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+9, "Chess Piece - Black Bishop", "", '', '0', '10', '0', '0', '0', '0', '17568', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+9, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+10, "Chess Piece - Black Queen", "", '', '0', '10', '0', '0', '0', '0', '28213', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+10, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`) 
VALUES (@CHESS+11, "Chess Piece - Black King", "", '', '0', '10', '0', '0', '0', '0', '27744', '0', '0', '0', '1', '1', '0');
INSERT INTO `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`, `summonguard`) 
VALUES (@CHESS+11, '1', '1', '35', '1', '1', '0', '1', '0', '100', '0', '0', '0', '0', '0', '0', '0', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '8.00', '8.00', '8.00', '0', '0', '0', '0', '0', '0', '0', '0');
]]
--------------------------------------------------------
-- Variable setup
--------------------------------------------------------

local CHESS_ENTRY_START = 68000
local gameInProgress = false
local grid_npc = {}
local grid_obj = {}
local a_npcs = {}
local h_npcs = {}
local current_npc = nil
local TURN = false
local clock = os.clock()

-- Format entry Id's: Castle, Bishop, Knight, King, Queen, Knight, Bishop, Castle, Pawn
local alliance_creatures = {CHESS_ENTRY_START + 1, CHESS_ENTRY_START + 3, CHESS_ENTRY_START + 2,
							CHESS_ENTRY_START + 5, CHESS_ENTRY_START + 4, CHESS_ENTRY_START + 2,
							CHESS_ENTRY_START + 3, CHESS_ENTRY_START + 1, CHESS_ENTRY_START}
local horde_creatures = {CHESS_ENTRY_START + 7, CHESS_ENTRY_START + 9, CHESS_ENTRY_START + 8,
						CHESS_ENTRY_START + 11, CHESS_ENTRY_START + 10, CHESS_ENTRY_START + 8,
						CHESS_ENTRY_START + 9, CHESS_ENTRY_START + 7, CHESS_ENTRY_START + 6}
-- Creature entry ID's and what they are
local creature_index = {[CHESS_ENTRY_START + 1] = "a_castle",
						[CHESS_ENTRY_START + 7] = "h_castle",
						[CHESS_ENTRY_START + 3] = "a_bishop",
						[CHESS_ENTRY_START + 9] = "h_bishop",
						[CHESS_ENTRY_START + 2] = "a_knight",
						[CHESS_ENTRY_START + 8] = "h_knight",
						[CHESS_ENTRY_START + 4] = "a_queen",
						[CHESS_ENTRY_START + 10] = "h_queen",
						[CHESS_ENTRY_START + 5] = "a_king",
						[CHESS_ENTRY_START + 11] = "h_king",
						[CHESS_ENTRY_START + 0] = "a_pawn",
						[CHESS_ENTRY_START + 6] = "h_pawn"}

--------------------------------------------------------
-- Event triggering (toggle)
--------------------------------------------------------

function chesschat(event, plr, message, mtype, language)
	if message == "#chess" and plr:IsGm() then
		if gameInProgress then
			plr:SendBroadcastMessage("Ending chess.")
			DespawnChess()
		else
			plr:SendBroadcastMessage("Starting chess.")
			SpawnChess(plr)
		end
		return false
	end
end

RegisterServerHook(16, "chesschat")

--------------------------------------------------------
-- Spawn/Despawn grid
--------------------------------------------------------

function SpawnChess(pUnit)
	if not pUnit then
		return
	end
	if gameInProgress then
		pUnit:SendBroadcastMessage("Game is in progress - try again later.")
		return
	end
	gameInProgress = true
	local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local i, j
	local a = 0
	local b = 0
	for i=0,35,5 do
		a = a + 1
		table.insert(a_npcs, pUnit:SpawnCreature(alliance_creatures[a], x+i, y, z+0.1, 1.5, 35, 0))
		for j=0,35,5 do
			if j == 5 then
				table.insert(a_npcs, pUnit:SpawnCreature(alliance_creatures[9], x+i, y+j, z+0.1, 1.5, 35, 0))
			elseif j == 30 then
				table.insert(h_npcs, pUnit:SpawnCreature(horde_creatures[9], x+i, y+j, z+0.1, 4.7, 35, 0))
			elseif j == 35 then
				b = b + 1
				table.insert(h_npcs, pUnit:SpawnCreature(horde_creatures[b], x+i, y+j, z+0.1, 4.7, 35, 0))
			end
			table.insert(grid_npc, pUnit:SpawnCreature(28816, x+i, y+j, z, 0, 35, 0))
			table.insert(grid_obj, pUnit:SpawnGameObject(185301, x+i, y+j, z-0.21, 0, 0, 100))
		end
	end
end

function DespawnChess()
	for _,v in ipairs(grid_npc) do
		if v then
			v:Despawn(1,0)
		end
	end
	for _,v in ipairs(grid_obj) do
		if v then
			v:Despawn(1,0)
		end
	end
	for _,v in ipairs(a_npcs) do
		if v then
			v:Despawn(1,0)
		end
	end
	for _,v in ipairs(h_npcs) do
		if v then
			v:Despawn(1,0)
		end
	end
	grid_npc = {}
	grid_obj = {}
	a_npcs = {}
	h_npcs = {}
	gameInProgress = false
	current_npc = nil
	TURN = false
end

--------------------------------------------------------
-- Utility
--------------------------------------------------------

function IsHordeCreature(entry)
	for _,v in pairs(horde_creatures) do
		if v == entry then
			return true
		end
	end
	return false
end

function IsAllianceCreature(entry)
	for _,v in pairs(alliance_creatures) do
		if v == entry then
			return true
		end
	end
	return false
end

function checkValidTile(pUnit)
	if pUnit:HasAura(50236) then
		return true
	end
	local u = pUnit:GetClosestFriend()
	if u then
		if u:GetDistanceYards(pUnit) > 2 then
			pUnit:CastSpell(50236) -- light beam
			return true
		end
	end
	return false
end

function AttackTile(pUnit, _x, _y, kill)
	local z = pUnit:GetZ()
	local npc = nil
	if (IsAllianceCreature(pUnit:GetEntry())) then
		for _,v in pairs(horde_creatures) do
			npc = pUnit:GetCreatureNearestCoords(_x, _y, z, v)
			if npc and npc:GetDistanceYards(pUnit) < 7 then
				pUnit:SendChatMessage(12,0,"pUnit = "..pUnit:GetName().." | npc = "..npc:GetName())
				if kill then
					pUnit:Kill(npc)
					break
				end
				npc = pUnit:GetCreatureNearestCoords(_x, _y, z, 28816)
				if npc then
					npc:CastSpell(62296)
				end
				break
			end
		end
		return
	end
	for _,v in pairs(alliance_creatures) do
		npc = pUnit:GetCreatureNearestCoords(_x, _y, z, v)
		if npc and npc:GetDistanceYards(pUnit) < 7 then
			pUnit:SendChatMessage(12,0,"pUnit = "..pUnit:GetName().." | npc = "..npc:GetName())
			if kill then
				pUnit:Kill(npc)
				break
			end
			npc = pUnit:GetCreatureNearestCoords(_x, _y, z, 28816)
			if npc then
				npc:CastSpell(62296)
			end
			break
		end
	end
end

--------------------------------------------------------
-- Moving a piece
--------------------------------------------------------

function Chess_Piece_Move(pUnit)
	if os.clock() - clock < 5 then
		return
	end
	local plr = pUnit:GetClosestPlayer()
	if not plr then
		return
	end
	if plr:GetDistanceYards(pUnit) > 1.5 then
		return
	end
	if IsAllianceCreature(pUnit:GetEntry()) then
		if TURN then
			plr:SendBroadcastMessage("It isn't your turn.")
			return
		end
	end
	if IsHordeCreature(pUnit:GetEntry()) then
		if not TURN then
			plr:SendBroadcastMessage("It isn't your turn.")
			return
		end
	end
	-- Flags for stationary creatures, instead see the clock replacement
	--[[local _c = pUnit:GetInRangeUnits()
	for _,v in ipairs(_c) do
		if IsAllianceCreature(v:GetEntry()) or IsHordeCreature(v:GetEntry()) then
			if v:IsCreatureMoving() then
				pUnit:SendChatMessage(12,0,v:GetName().." is moving!")
				return
			end
		end
	end]]
	if current_npc then
		if current_npc:GetX() ~= pUnit:GetX() then
			current_npc:RemoveAura(50236) -- light beam
			--for _,v in pairs(grid_npc) do
			for _,v in pairs(pUnit:GetInRangeUnits()) do
				v:RemoveAura(50236)
			end
		end
	end
	current_npc = pUnit
	pUnit:CastSpell(50236) -- light beam visual
	------------------------------------------------
	-- Handle where this unit can move
	------------------------------------------------
	local piece = creature_index[pUnit:GetEntry()]
	if not piece then
		pUnit:SendChatMessage(12,0,"ERROR: I am not handled. creature_index{} needs populating.")
		return
	end
	if piece == "h_king" or piece == "a_king" then
		king_move(pUnit)
	elseif piece == "a_pawn" or piece == "h_pawn" then
		pawn_move(pUnit)
	end
end

function GridNPCSpawn(pUnit, Event)
	pUnit:SetUInt32Value(0x0006+0x0035, 0x02000000) -- untargetable
	pUnit:RegisterEvent("CheckPlayerComeAtMe", 1000, 0)
end

function CheckPlayerComeAtMe(pUnit)
	if not pUnit:HasAura(50236) and not pUnit:HasAura(62296) then
		return
	end
	local plr = pUnit:GetClosestPlayer()
	if not plr then
		return
	end
	if plr:GetDistanceYards(pUnit) > 1.5 then
		return
	end
	if current_npc then
		current_npc:RemoveAura(50236) -- light beam
		current_npc:SetValue("move", 1)
		if pUnit:HasAura(62296) then
			AttackTile(pUnit, pUnit:GetX(), pUnit:GetY(), true)
			current_npc:SetMovementFlags(1)
			pUnit:RemoveAura(62296)
		end
		current_npc:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0) -- orientation should be handled
		for _,v in pairs(grid_npc) do
			v:RemoveAura(50236)
			v:RemoveAura(62296)
		end
		TURN = not TURN
		clock = os.clock()
	end
end

RegisterUnitEvent(28816, 18, "GridNPCSpawn")

--------------------------------------------------------
-- Pawn movement
--------------------------------------------------------

function pawn_move(pUnit)
	local x, y, z = pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()
	local movetwo = pUnit:GetValue("move")
	local allowed = false

	-- Alliance pawn movement
	if IsAllianceCreature(pUnit:GetEntry()) then
		-- Movement
		local n = pUnit:GetCreatureNearestCoords(x, y+5, z, 28816)
		if n then
			allowed = checkValidTile(n)
		end
		if allowed then
			if movetwo == nil then
				n = pUnit:GetCreatureNearestCoords(x, y+10, z, 28816)
				if n then
					checkValidTile(n)
				end
			end
		end
		current_npc = pUnit
		-- Taking pieces
		AttackTile(pUnit, x+5, y+5, false)
		AttackTile(pUnit, x-5, y+5, false)
		return
	end
	-- Horde pawn movement
	-- Movement
	local n = pUnit:GetCreatureNearestCoords(x, y-5, z, 28816)
	if n then
		allowed = checkValidTile(n)
	end
	if allowed then
		if movetwo == nil then
			n = pUnit:GetCreatureNearestCoords(x, y-10, z, 28816)
			if n then
				checkValidTile(n)
			end	
		end
	end
	current_npc = pUnit
	-- Taking pieces
	AttackTile(pUnit, x+5, y-5, false)
	AttackTile(pUnit, x-5, y-5, false)
end

--------------------------------------------------------
-- King movement
--------------------------------------------------------

function king_move(pUnit)
	local x, y, z = pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()
	local n = pUnit:GetCreatureNearestCoords(x+5, y, z, 28816)
	if n then
		checkValidTile(n)
	end
	n = pUnit:GetCreatureNearestCoords(x-5, y, z, 28816)
	if n then
		checkValidTile(n)
	end
	n = pUnit:GetCreatureNearestCoords(x, y+5, z, 28816)
	if n then
		checkValidTile(n)
	end
	n = pUnit:GetCreatureNearestCoords(x, y-5, z, 28816)
	if n then
		checkValidTile(n)
	end
	current_npc = pUnit
end

--------------------------------------------------------
-- Piece events (spawn)
--------------------------------------------------------

function PieceSpawn(pUnit, Event)
	pUnit:RegisterEvent("Chess_Piece_Move", 1000, 0)
	local piece = creature_index[pUnit:GetEntry()]
	if piece == "a_knight" or piece == "h_knight" then
		pUnit:RegisterEvent("MountUpKnight_Piece", 1000, 1)
	end
end

function MountUpKnight_Piece(pUnit)
	local piece = creature_index[pUnit:GetEntry()]
	if piece == "a_knight" then	
		pUnit:SetMount(14337)
	else
		pUnit:SetMount(14334)
	end
end

local m
for m=1,#alliance_creatures do
	RegisterUnitEvent(alliance_creatures[m], 18, "PieceSpawn")
end
for m=1,#horde_creatures do
	RegisterUnitEvent(horde_creatures[m], 18, "PieceSpawn")
end
m = nil
