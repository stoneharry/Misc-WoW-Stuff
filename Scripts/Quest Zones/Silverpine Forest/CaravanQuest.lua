local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

function Caravan_quest_Dummy_Spawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:RegisterEvent("Caravan_Quest_Dummy_FINDPLAYERS", 1000, 0)
end

RegisterUnitEvent(44201, 18, "Caravan_quest_Dummy_Spawn")

function Caravan_Quest_Dummy_FINDPLAYERS(pUnit, Event)
	local player = pUnit:GetClosestPlayer()
	if player ~= nil and pUnit:GetDistanceYards(player) < 10 and
	 player:HasQuest(5200) and player:GetQuestObjectiveCompletion(5200, 0) == 0 then
		player:MarkQuestObjectiveAsComplete(5200,0)
		pUnit:SendChatMessageToPlayer(42, 0, "The Caravan has been demolished by the forest goblins!", player)
	end
end

