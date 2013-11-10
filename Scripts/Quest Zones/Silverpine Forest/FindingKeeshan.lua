local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local MPlayer = nil
local keeshan = nil
local crone = nil


function Crone_quest_Spawn(pUnit, Event)
	crone = pUnit
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	keeshan = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 349)
	if keeshan ~= nil then
		if keeshan:IsDead() then
			keeshan:Despawn(1, 1)
		end
		pUnit:RegisterEvent("Crone_DelayChannelKeeshan", 100, 1)
	end
	pUnit:RegisterEvent("Crone_zzFINDPLAYERS", 2000, 0)
end

RegisterUnitEvent(44008, 18, "Crone_quest_Spawn")

function Crone_quest_Dummy_Spawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
	pUnit:RegisterEvent("Crone_Quest_Dummy_FINDPLAYERS", 1000, 0)
end

RegisterUnitEvent(43999, 18, "Crone_quest_Dummy_Spawn")

function Crone_DelayChannelKeeshan(pUnit, Event)
	if keeshan == nil then 
		keeshan = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 349)
	pUnit:ChannelSpell(66256, keeshan)
	else
		pUnit:ChannelSpell(66256, keeshan)
end
end

function Crone_Quest_Dummy_FINDPLAYERS(pUnit, Event)
	local player = pUnit:GetClosestPlayer()
	if player ~= nil and pUnit:GetDistanceYards(player) < 8 and
	 player:HasQuest(5502) == true and player:GetQuestObjectiveCompletion(5502, 0) == 0 and 
	 player:HasSpell(73712) == false then
		player:LearnSpell(73712)
		pUnit:SendChatMessageToPlayer(42, 0, "A trail of blood and meat starts here... You should follow it.", player)
	end
end

function KEESHAN_SPAWN(pUnit, Event)
	pUnit:SetFaction(35)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 8)
	pUnit:SetModel(1826)
	keeshan = pUnit
end

RegisterUnitEvent(349, 18, "KEESHAN_SPAWN")

function Crone_zzFINDPLAYERS(pUnit, Event)
	local player = pUnit:GetClosestPlayer()
	if player ~= nil and pUnit:GetDistanceYards(player) < 7 and
	 player:HasQuest(5502) == true and player:GetQuestObjectiveCompletion(5502, 0) == 0 then
		pUnit:RemoveEvents()
		player = MPlayer
		keeshan = nil
		keeshan = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 349)
			if keeshan == nil then 
			keeshan = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 349)
			keeshan:SendChatMessage(14, 0, "You witch! What you have done to me? You will pay for your atrocities by being burnt alive!")
		pUnit:RegisterEvent("Crone_Next_Chapter_z", 7000, 1)
	else
		keeshan:SendChatMessage(14, 0, "You witch! What you have done to me? You will pay for your atrocities by being burnt alive!")
		pUnit:RegisterEvent("Crone_Next_Chapter_z", 7000, 1)
	end
end
end

function Crone_Next_Chapter_z(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "It will all be over soon!")
	pUnit:PlaySoundToSet(9307)
	pUnit:RegisterEvent("Crone_Next_Chapter_zz", 7000, 1)
end

function Crone_Next_Chapter_zz(pUnit, Event)
	local player = MPlayer or pUnit:GetClosestPlayer()
	if keeshan == nil then 
	keeshan = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 349)
	keeshan:SendChatMessage(12, 0, player:GetName().."!? Is that you? Run now! Get away while you still can!")
	pUnit:RegisterEvent("Crone_Next_Chapter_zzz", 7000, 1)
	else
		keeshan = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 349)
	keeshan:SendChatMessage(12, 0, player:GetName().."!? Is that you? Run now! Get away while you still can!")
	pUnit:RegisterEvent("Crone_Next_Chapter_zzz", 7000, 1)
end
end

function Crone_Next_Chapter_zzz(pUnit, Event)
	if keeshan == nil then 
		keeshan = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 349)
	keeshan:SendChatMessage(12,0,"Arghhh-!")
	pUnit:RegisterEvent("Crone_Next_Chapter_x", 2000, 1)
	else
	keeshan:SendChatMessage(12,0,"Arghhh-!")
	pUnit:RegisterEvent("Crone_Next_Chapter_x", 2000, 1)
end
end

function Crone_Next_Chapter_x(pUnit, Event)
		if keeshan == nil then 
			keeshan = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 349)
		keeshan:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	keeshan:CastSpell(48582)
	keeshan:SetFaction(14)
	keeshan:SetModel(203)
	pUnit:StopChannel()
	pUnit:RegisterEvent("Crone_Next_Chapter_xx", 2000, 1)
	else
	keeshan:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	keeshan:CastSpell(48582)
	keeshan:SetFaction(14)
	keeshan:SetModel(203)
	pUnit:StopChannel()
	pUnit:RegisterEvent("Crone_Next_Chapter_xx", 2000, 1)
end
end

function Crone_Next_Chapter_xx(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Fixed you, didn't I?")
	pUnit:PlaySoundToSet(9180)
	pUnit:Emote(11, 1000)
	pUnit:CastSpell(61456)
	pUnit:RegisterEvent("Crone_Next_Chapter_y", 3000, 1)
end

function Crone_Next_Chapter_y(pUnit,Event)
	if keeshan == nil then 
	pUnit:Despawn(700, 30000)
	keeshan:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	else
	pUnit:Despawn(700, 30000)
	keeshan:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end
end

