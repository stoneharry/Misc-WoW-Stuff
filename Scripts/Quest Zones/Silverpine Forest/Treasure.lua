local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B

function TreasureLoot_OnUseObject(pGameObject, event, pPlayer)
	if pPlayer:HasQuest(5501) then
		if pPlayer:IsInCombat() then
			pPlayer:SendAreaTriggerMessage("|cFFFF0000You are in combat.|r")
		else
			if pPlayer:HasItem(7968) == false then
				pPlayer:SpawnCreature(44004, 34.62, 789.20, 69.71,1.5, 14, 60000)
				pGameObject:Despawn(1000, 15000)
			else
				pPlayer:SendAreaTriggerMessage("|cFFFF0000You already have the treasure.|r")
			end
		end
	end
end

RegisterGameObjectEvent(186888, 4, "TreasureLoot_OnUseObject")

function NinjaLord_Spawn(pUnit, Event)
	pUnit:EquipWeapons(35793, 35793, 0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
	pUnit:CastSpell(24222)
	pUnit:RegisterEvent("Sayso_FewSecondszz", 1000, 1)
end

function Sayso_FewSecondszz(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Silly pirates always fall for the same ol' trick!")
end

RegisterUnitEvent(44004, 18, "NinjaLord_Spawn")

function Cult_Combatzzz(pUnit, Event)
	pUnit:RegisterEvent("Monsterz_Strike", 3000, 0)
	pUnit:RegisterEvent("Monsterz_Numb", 6000, 0)
end

function Monsterz_Strike(pUnit, Event)
	local tank = pUnit:GetMainTank()
	if tank ~= nil and pUnit:GetDistanceYards(tank) < 10 then
		pUnit:CastSpellOnTarget(1758, tank)
	end
end

function Monsterz_Numb(pUnit, Event)
	local tank = pUnit:GetMainTank()
	if tank ~= nil and pUnit:GetDistanceYards(tank) < 12 then
		pUnit:CastSpellOnTarget(25810, tank)
	end
end

function Cult_Leavezzz(pUnit, Event) -- general leave
	pUnit:RemoveEvents()
end

RegisterUnitEvent(44004, 1,"Cult_Combatzzz")
RegisterUnitEvent(44004, 3,"Cult_Leavezzz")
RegisterUnitEvent(44004, 4,"Cult_Leavezzz")
RegisterUnitEvent(22060, 1,"Cult_Combatzzz")
RegisterUnitEvent(22060, 3,"Cult_Leavezzz")
RegisterUnitEvent(22060, 4,"Cult_Leavezzz")
