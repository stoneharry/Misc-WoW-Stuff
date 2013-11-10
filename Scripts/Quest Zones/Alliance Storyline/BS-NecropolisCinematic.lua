local Necro = nil
local NecTarget = nil

local running = false

local OBJECT_END = 0x0006
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044

local shoot = 0

-- Dummy units

function TEst_oahaoejznhzzzz(pUnit, Event)
	Necro = pUnit
end

RegisterUnitEvent(278031, 18, "TEst_oahaoejznhzzzz")

function TargetOnSpawneahah(pUnit, Event)
	NecTarget = pUnit
	pUnit:RegisterEvent("Wait_Then_Root_and_Set_RAGE", 5000, 1)
end

function Wait_Then_Root_and_Set_RAGE(pUnit)
	pUnit:Root()
	pUnit:SetCombatCapable(1)
end

RegisterUnitEvent(182251, 18, "TargetOnSpawneahah")

-- rebith

function RESET_NECRO_GUY()
	running = false
	Necro:SetUInt32Value(UNIT_FIELD_BYTES_1, 0)
end

-- script

function NecropolisCinematicStart(pUnit, Event)
	if running then
		pUnit:SetScale(0.01)
	end
	pUnit:RegisterEvent("StartTheEvent_NecroCinematic", 1000, 1)
end

function StartTheEvent_NecroCinematic(pUnit)
	if running then
		pUnit:SetScale(0.01)
	else
		running = true
		pUnit:ModifyFlySpeed(10)
		pUnit:SetFlying()
		pUnit:SetMovementFlags(2)
		pUnit:MoveTo(-8046, -1751, 206, 0)
		pUnit:RegisterEvent("CastSpellOnNecro_Cine", 19000, 1)
		pUnit:RegisterEvent("KillNecropolis_Cinematic", 25000, 1)
	end
end

function CastSpellOnNecro_Cine(pUnit)
	shoot = shoot + 1
	if shoot == 6 then
		shoot = 0
		return
	else
		pUnit:FullCastSpellOnTarget(51235, NecTarget)
	end
	pUnit:RegisterEvent("CastSpellOnNecro_Cine", 1000, 1)
end

function KillNecropolis_Cinematic(pUnit)
	Necro:SetUInt32Value(UNIT_FIELD_BYTES_1, 7)
	CreateLuaEvent(RESET_NECRO_GUY, 60000, 1)
end

RegisterUnitEvent(32388, 18, "NecropolisCinematicStart")
