local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local ZPlayer
local professor

local function re()
	if (professor == nil) then
		print ("[DeepElmMine.lua] professor not found during cinematic!")
	else
		professor:RegisterEvent("zzCrone_zzFINDPLAYERS", 2000, 0)
	end
	ZPlayer = nil
	professor = nil
end

function Cronexx_quest_Spawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:RegisterEvent("zzCrone_zzFINDPLAYERS", 2000, 0)
end

RegisterUnitEvent(44044, 18, "Cronexx_quest_Spawn")

function zzCrone_zzFINDPLAYERS(pUnit, Event)
	local player = pUnit:GetClosestPlayer()
	if player ~= nil and pUnit:GetDistanceYards(player) < 12 and
	 player:HasQuest(5302) == true and player:GetQuestObjectiveCompletion(5302, 0) == 0 then
		pUnit:RemoveEvents()
		ZPlayer = player
		professor = nil
		professor = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 44045)
		if (professor == nil) then re(); return; end
		professor:SendChatMessage(12, 0, "Our meeting with the Burning Legion's ambassador is soon, we need to eradicate Horde and Alliance presence here as soon as possible.")
		professor:Emote(1, 7000)
		pUnit:RegisterEvent("zCrone_Next_Chapter_z", 7000, 1)
	end
end

function zCrone_Next_Chapter_z(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Don't you worry, things will be put in place in due time. They will soon serve me, their presence is to our benefit.")
	pUnit:Emote(1, 7000)
	pUnit:RegisterEvent("zCrone_Next_Chapter_zz", 7000, 1)
end

function zCrone_Next_Chapter_zz(pUnit, Event)
	if (professor == nil) then re(); return; end
	local player = ZPlayer or pUnit:GetClosestPlayer()
	if (player == nil) then  re(); return; end
	professor:SendChatMessage(12, 0, "It would seem we have company, shall I handle this?")
	professor:Emote(1, 4000)
	professor:SetOrientation(player:GetO())
	pUnit:RegisterEvent("zCrone_Next_Chapter_zzz", 5000, 1)
end

function zCrone_Next_Chapter_zzz(pUnit, Event)
	local player = ZPlayer or pUnit:GetClosestPlayer()
	if (player == nil) then return; end
	local g1 = player:GetGender() == 0 and "his" or "her"
	local g2 = player:GetGender() == 0 and "him" or "her"
	pUnit:SendChatMessage(12, 0, "No need, "..g1.." former allies will deal with "..g2..".")
	pUnit:Emote(1, 5000)
	pUnit:RegisterEvent("zCrone_Next_Chapter_x", 5000, 1)
end

function zCrone_Next_Chapter_x(pUnit, Event)
	if (professor == nil) then re(); return; end
	professor:SendChatMessage(12, 0, "So be it.")
	pUnit:Emote(1, 2000)
	pUnit:RegisterEvent("zCrone_Next_Chapter_xx", 2000, 1)
end

function zCrone_Next_Chapter_xx(pUnit, Event)
	if (professor == nil) then re(); return; end
	professor:CastSpell(61456)
	professor:Despawn(1000, 30000)
	pUnit:CastSpell(61456)
	pUnit:Despawn(1000, 30000)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for _, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 15 and players:GetQuestObjectiveCompletion(5302, 0) == 0 then
			players:MarkQuestObjectiveAsComplete(5302, 0)
		end
	end
end

