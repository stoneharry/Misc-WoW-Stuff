-- Triggered by spell 90006

GF = {}
GF.VAR = {}

local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044

function GF.VAR.GhoulSpawn(pUnit, Event)
	if Event == 18 then
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 9)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
		pUnit:RegisterEvent("GF.VAR.ComingOutOfTheGround", 1000, 1)
	else
		pUnit:RemoveEvents()
	end
end

function GF.VAR.ComingOutOfTheGround(pUnit)
	pUnit:SetScale(1)
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 0)
	pUnit:RegisterEvent("GF.VAR.TurnHostileGhoul", 4000, 1)
	pUnit:RegisterEvent("GF.VAR.CheckHpToReturn", 1000, 0)
end

function GF.VAR.TurnHostileGhoul(pUnit)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	local target = pUnit:GetClosestEnemy()
	if target then
		pUnit:AttackReaction(target, 1, 0)
	end
end

function GF.VAR.CheckHpToReturn(pUnit)
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		pUnit:Root()
		pUnit:DisableCombat(true)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 9)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
		pUnit:Despawn(3000, 0)
	end
end

RegisterUnitEvent(190005, 18, "GF.VAR.GhoulSpawn")
RegisterUnitEvent(190005, 4, "GF.VAR.GhoulSpawn")