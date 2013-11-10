
local OBJECT_END = 0x0006
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 -- Size: 1, Type: BYTES, Flags: PUBLIC
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B

local object = nil

local raid_canstart = false
local raid_i = 0
local raid_guards = {}
local raid_positions_first = {
	{-8057, -2884, 137},
	{-8051, -2887, 136.22},
	{-8052, -2892, 135.2},
	{-8057, -2891, 136.5},
	{-8059, -2885, 136.8},
	{-8065, -2888, 136.4}
}

local raid_positions_second = {
	{-8008, -2886, 135.8},
	{-8004, -2879, 135.6},
	{-8007, -2872, 136},
	{-8012, -2875, 135.5},
	{-8021, -2882, 135.7},
	{-7997.8, -2871.5, 135.6}
}
local raid_player = nil

function LeitSpencer_Click(pUnit, event, player)
	pUnit:GossipCreateMenu(5564, player, 0)
	if player:HasQuest(6) == true then
		pUnit:GossipMenuAddItem(9, "Lieutenant, we are ready!", 1, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function LeitSpencer_Gossip(pUnit, event, player, id, intid, code)
	if (intid == 1) then
		if not raid_canstart then
			pUnit:Emote(1, 0)
			pUnit:SetNPCFlags(2)
			pUnit:SendChatMessage(12,0,"Very well, let us begin.")
			raid_canstart = true
		end
	else
		raid_canstart = false
		raid_i = 0
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(32039, 1, "LeitSpencer_Click")
RegisterUnitGossipEvent(32039, 2, "LeitSpencer_Gossip")

function LeitSpencer_StartSpawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 0)
	pUnit:SetNPCFlags(1)
	pUnit:RegisterEvent("LeitSpencer_CanStart", 1000, 0)
	raid_canstart = false
end

function LeitSpencer_CanStart(pUnit)
	if raid_i == 0 then
		if raid_canstart then
			raid_i = 1
		else
			pUnit:SetNPCFlags(1)
			raid_canstart = false
		end
	else
		raid_i = raid_i + 1
		if raid_i == 5 then
			pUnit:MoveTo(-8134, -2932.5, 133.62, 0)
		elseif raid_i == 6 then
			pUnit:Emote(1,0)
			pUnit:SendChatMessage(12,0,"Men...")
		elseif raid_i == 8 then
			pUnit:SendChatMessage(14,0,"Charge!")
			pUnit:Emote(5, 0)
		elseif raid_i == 10 then
			for _,unit in pairs(pUnit:GetInRangeUnits()) do
				if unit:GetEntry() == 50500 then
					unit:AIDisableCombat(true)
					unit:SetMovementFlags(1)
					MoveUnitToRaidPosition(unit)
					table.insert(raid_guards, unit)
				end
			end
			pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
			pUnit:SetMovementFlags(1)
			pUnit:AIDisableCombat(true)
			MoveUnitToRaidPosition(pUnit)
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("LeitSpencer_CanStart", 2000, 0)
		elseif raid_i == 11 then
			MoveUnitsAroundFirst(pUnit)
		elseif raid_i == 12 then
			MoveUnitsAroundFirst(pUnit)
		elseif raid_i == 13 then
			MoveUnitsAroundFirst(pUnit)
		elseif raid_i == 14 then
			MoveUnitsAroundFirst(pUnit)
		elseif raid_i == 14 then
			MoveUnitsAroundFirst(pUnit)
		elseif raid_i == 15 then
			MoveUnitsAroundSecond(pUnit)
		elseif raid_i == 16 then
			MoveUnitsAroundSecond(pUnit)
		elseif raid_i == 17 then
			MoveUnitsAroundSecond(pUnit)
		elseif raid_i == 18 then
			MoveUnitsAroundSecond(pUnit)
		elseif raid_i == 19 then
			AttackAllUnitsAndStuff(pUnit)
		end
	end
end

function AttackAllUnitsAndStuff(pUnit)
	for _,unit in pairs(raid_guards) do
		if unit then
			unit:AIDisableCombat(false)
		end
	end
	local plr = pUnit:GetClosestPlayer()
	local name = ""
	if plr then
		name = plr:GetName()
	end
	if name then
		pUnit:SendChatMessage(14,0,"This way, "..name.."!")
	else
		pUnit:SendChatMessage(14,0,"This way!")
	end
	pUnit:MoveTo(-7989.5, -2874.3, 135.3, 0)
	pUnit:RemoveEvents()
	pUnit:Emote(375, 7900)
	pUnit:RegisterEvent("TellPlayersWhattodo_Raid", 5000, 1)
end

function TellPlayersWhattodo_Raid(pUnit)
	pUnit:SendChatMessage(12,0,"Get into the keep, free the prisoner! We'll hold them off here.")
	pUnit:RegisterEvent("AttackAll_RaidBoss", 3000, 1)
end

function AttackAll_RaidBoss(pUnit)
	pUnit:AIDisableCombat(false)
	pUnit:RegisterEvent("Raid_ResetAllEvents", 15000, 1)
end

function Raid_ResetAllEvents(pUnit)
	pUnit:SetMovementFlags(0)
	raid_canstart = false
	raid_i = 0
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 0)
	pUnit:SetNPCFlags(1)
	pUnit:Despawn(1, 5000)
	for _,unit in pairs(raid_guards) do
		if unit then
			unit:Despawn(1, math.random(1000,5000))
		end
	end
end

function MoveUnitToRaidPosition(pUnit)
	local num = math.random(1,#raid_positions_first)
	pUnit:MoveTo(raid_positions_first[num][1], raid_positions_first[num][2], raid_positions_first[num][3], 0)
end

function MoveUnitsAroundFirst(pUnit)
	for _,unit in pairs(raid_guards) do
		if unit then
			MoveUnitToRaidPosition(unit)
		end
	end
	MoveUnitToRaidPosition(pUnit)
end

function MoveUnitToRaidPositionSecond(pUnit)
	local num = math.random(1,#raid_positions_second)
	pUnit:MoveTo(raid_positions_second[num][1], raid_positions_second[num][2], raid_positions_second[num][3], 0)
end

function MoveUnitsAroundSecond(pUnit)
	for _,unit in pairs(raid_guards) do
		if unit then
			MoveUnitToRaidPositionSecond(unit)
		end
	end
	MoveUnitToRaidPositionSecond(pUnit)
end

RegisterUnitEvent(32039, 18, "LeitSpencer_StartSpawn")

-- 'boss'

function RaidBoss_Spawn(pUnit)
	pUnit:RegisterEvent("ChannelSpell_visual_raidboss", 1000, 1)
	pUnit:RegisterEvent("CheckForPlayersToStart_Raid", 2500, 0)
end

function ChannelSpell_visual_raidboss(pUnit)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:ChannelSpell(52993, pUnit)
end

function CheckForPlayersToStart_Raid(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if plr:GetDistanceYards(pUnit) < 15 and plr:GetPhase() == 2 and plr:IsAlive() then
			pUnit:RemoveEvents()
			pUnit:StopChannel()
			pUnit:SendChatMessage(12,0,"Foolish "..plr:GetPlayerClass()..", your precious prisoner is not here. Now you can join him, to be sacrificed!")
			plr:SetPlayerLock(true)
			plr:CastSpell(69413) -- strangulating
			pUnit:ChannelSpell(72735, plr)
			raid_player = plr
			pUnit:RegisterEvent("Spam_Player_Around_Raid", 500, 30)
			pUnit:RegisterEvent("Teleport_Player_Raid", 16000, 1)
		end
	end
end

function Spam_Player_Around_Raid(pUnit)
	if raid_player then
		local xa = 7918
		local xb = 7934
		local ya = 2848
		local yb = 2874
		local xa = math.random(xa, xb)
		local ya = math.random(ya, yb)
		raid_player:MoveKnockback(-xa, -ya, 143.3, 1,1)
		raid_player:CastSpell(72313) -- visual
	end
end

function Teleport_Player_Raid(pUnit)
	if raid_player then
		if raid_player:HasQuest(6) then
			raid_player:MarkQuestObjectiveAsComplete(6, 0)
		end
		raid_player:RemoveAura(69413)
		raid_player:SetPlayerLock(0)
		raid_player:Teleport(0, -8062.5, -2811, 123)
		raid_player:CastSpell(64446)
		raid_player:SetPhase(1)
		raid_player = nil
	end
	pUnit:StopChannel()
	pUnit:RegisterEvent("ChannelSpell_visual_raidboss", 1000, 1)
	pUnit:RegisterEvent("CheckForPlayersToStart_Raid", 2500, 0)
end

RegisterUnitEvent(50505, 18, "RaidBoss_Spawn")

-- Quest 8

function zzzGolemoth_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(23522, player, 0)
	if player:HasQuest(8) == true then
		pUnit:GossipMenuAddItem(0, "I am here to save you, do not worry.", 246, 0)
	end
   pUnit:GossipMenuAddItem(0, "No, I shall not free you.", 250, 0)
   pUnit:GossipSendMenu(player)
end


function zzzGolemoth_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 246) then
		local name = player:GetName()
		pUnit:SendChatMessage(12,0,"Freedom at last! I'll meet you on the outside.")
		if player:GetQuestObjectiveCompletion(8, 0) == 0 then
			player:AdvanceQuestObjective(8, 0)
		end
		object = pUnit:GetGameObjectNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 225008)
		if object ~= nil then
			object:SetByte(GAMEOBJECT_BYTES_1,0,0)
		end
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(-8031, -2820, 120.1, 0)
		pUnit:Despawn(3500,40000)
		CreateLuaEvent("CloseGateGossip",10000,1)
		player:GossipComplete()
	elseif(intid == 250) then
		player:GossipComplete()
		pUnit:Emote(18, 0) -- cry
	end
end

function CloseGateGossip()
	if object then
		object:SetByte(GAMEOBJECT_BYTES_1,0,1)
	end
end

RegisterUnitGossipEvent(252975, 1, "zzzGolemoth_On_Gossip")
RegisterUnitGossipEvent(252975, 2, "zzzGolemoth_Gossip_Submenus")

-- Escaping

function Knockback_spam_escaping_raid(pUnit, Event)
	pUnit:RegisterEvent("Pulse_Knockback_Raid", 2000, 0)
end

function Pulse_Knockback_Raid(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if plr:GetDistanceYards(pUnit) < 30 and plr:HasQuest(8) and plr:IsAlive() then
			plr:CastSpell(52687) -- knockback
			pUnit:CastSpellOnTarget(72313, plr) -- visual
			pUnit:SendChatMessageToPlayer(14,0,"You shall not pass, "..plr:GetPlayerClass().."!", plr)
		end
	end
end

RegisterUnitEvent(50506, 18, "Knockback_spam_escaping_raid")

function Bunny_Quest_complete_Raid(pUnit, Event)
	pUnit:RegisterEvent("Bunny_Quest_Mark_Raid", 1000, 0)
end

function Bunny_Quest_Mark_Raid(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if plr:HasQuest(8) and plr:GetDistanceYards(pUnit) < 10 then
			if plr:GetQuestObjectiveCompletion(8, 1) == 0 then
				plr:AdvanceQuestObjective(8, 1)
			end	
		end
	end
end

RegisterUnitEvent(50508, 18, "Bunny_Quest_complete_Raid")
