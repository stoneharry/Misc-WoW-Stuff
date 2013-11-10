local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local UNIT_FIELD_CHARMEDBY = OBJECT_END + 0x0006
local UNIT_FIELD_CHARM = OBJECT_END + 0x0000
local UNIT_FLAG_PVP_ATTACKABLE = 0x00000008
local UNIT_FLAG_PLAYER_CONTROLLED_CREATURE = 0x01000000
local UNIT_END = OBJECT_END + 0x008E
local PLAYER_DUEL_TEAM = UNIT_END + 0x0008
local PLAYER_DUEL_ARBITER = UNIT_END + 0x0000
local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3


function Corsac_fox_events(pUnit,Event)
if Event == 1 then
pUnit:RemoveAura(55474)
pUnit:RegisterEvent("Corsac_fox_eventone", math.random(2000,5000), 0)
elseif Event == 18 then
pUnit:RegisterEvent("Corsac_fox_sleeping", 2000, 0)
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:RegisterEvent("Corsac_fox_sleeping", 2000, 1)
elseif Event == 4 then
pUnit:RemoveEvents()
end
end

function Corsac_fox_eventone(pUnit,Event)
if not pUnit:HasAura(5426) then
pUnit:CastSpell(5426)
	end
end

function Corsac_fox_sleeping(pUnit,Event)
if not pUnit:IsInCombat() then
if (pUnit:GetByteValue(UNIT_FIELD_BYTES_1,0) == 3) and (pUnit:HasAura(55474) == false) then
pUnit:CastSpell(55474)
end
end
end

RegisterUnitEvent(12418, 18, "Corsac_fox_events")
RegisterUnitEvent(12418, 1, "Corsac_fox_events")
RegisterUnitEvent(12418, 2, "Corsac_fox_events")
RegisterUnitEvent(12418, 4, "Corsac_fox_events")
RegisterUnitEvent(150700, 18, "Corsac_fox_events")
RegisterUnitEvent(150700, 1, "Corsac_fox_events")
RegisterUnitEvent(150700, 2, "Corsac_fox_events")
RegisterUnitEvent(150700, 4, "Corsac_fox_events")


function Trap_Click(pMisc, event, player)
	if player:HasQuest(11004) and player:GetQuestObjectiveCompletion(11004, 0) ~= 5 then
	pMisc:Despawn(1000,7000)
	player:CastSpell(61437)
	player:AdvanceQuestObjective(11004, 0)
	end
end

RegisterGameObjectEvent(179485, 4, "Trap_Click")