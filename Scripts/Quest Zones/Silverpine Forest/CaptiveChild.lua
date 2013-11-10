
local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC

local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

function CaptiveChild_OnUseObject(pGameObject, event, pPlayer)
	if pPlayer:HasQuest(5322) then
		pGameObject:SetByte(GAMEOBJECT_BYTES_1, 0, 0)
		if pPlayer:IsInCombat() then
			pPlayer:SendAreaTriggerMessage("|cFFFF0000You are in combat.|r")
		else
			if pPlayer:HasItem(46895) == false then
				pPlayer:SendAreaTriggerMessage("|cFFFF0000Requires Black Cage Key to open.|r")
			else
				pGameObject:Despawn(2000, 15000)
				pPlayer:RemoveItem(46895, 1)
				local child = pGameObject:GetCreatureNearestCoords(pGameObject:GetX(), pGameObject:GetY(), pGameObject:GetZ(), 22314)
				if (not child) then return; end --Otherwise it will error while the child is despawned. //Laurea
				child:MoveTo(pPlayer:GetX(), pPlayer:GetY(), pPlayer:GetZ(), 0)
				child:Despawn(2000, 15000)
				local r = math.random(1, 3)
				if r == 1 then
					child:SendChatMessage(12, 0, "Woot!")
				elseif r == 2 then
					child:SendChatMessage(12, 0, "I'm free! Yay!")
				else
					child:SendChatMessage(12, 0, "Yay!")
				end
				if pPlayer:GetQuestObjectiveCompletion(5322, 0) ~= 6 then
					pPlayer:AdvanceQuestObjective(5322, 0)
				end
			end
		end
	end
end

RegisterGameObjectEvent(195310, 4, "CaptiveChild_OnUseObject")
