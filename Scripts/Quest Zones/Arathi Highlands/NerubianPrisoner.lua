local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC

local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

function NerubianPrisoner_OnUseObject(pGameObject, event, pPlayer)
	if pPlayer:HasQuest(45018) then
		if (pPlayer:GetQuestObjectiveCompletion(45018, 0) ~= 6) then
			pGameObject:SetByte(GAMEOBJECT_BYTES_1, 0, 0)
			if pPlayer:IsInCombat() then
				pPlayer:SendAreaTriggerMessage("|cFFFF0000You are in combat.|r")
			else
				pGameObject:Despawn(1, 15000)
				local nerubian = pGameObject:GetCreatureNearestCoords(pGameObject:GetX(), pGameObject:GetY(), pGameObject:GetZ(),442981)
				if (not nerubian) then return; end --Otherwise it will error while the nerubian is despawned. //Laurea
				nerubian:MoveTo(pPlayer:GetX(), pPlayer:GetY(), pPlayer:GetZ(), 0)
				nerubian:Despawn(2000, 15000)
				local r = math.random(1, 3)
				if r == 1 then
					local race = pPlayer:GetPlayerRace()
					nerubian:SendChatMessage(12, 0, "You have my thanks, surface-walker.")
				elseif r == 2 then
					nerubian:SendChatMessage(12, 0, "They're planning to sacrifice us!")
				elseif r == 3 then
					nerubian:SendChatMessage(12, 0, "I owe you a huge debt, surface-dweller")
					--pPlayer:CreateGuardian(442981, 10000, 2, 25) bugged as of June 22nd
				end
				pPlayer:AdvanceQuestObjective(45018, 0)
			end
		end
	end
end

RegisterGameObjectEvent(187369, 4, "NerubianPrisoner_OnUseObject")
