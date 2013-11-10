local OBJECT_END = 0x0006
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 

function FelguardSummoned_SPAWN(pUnit,Event)
	pUnit:EquipWeapons(12784,0,0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
end

RegisterUnitEvent(17252, 18,"FelguardSummoned_SPAWN")

function TerrorguardSummoned_SPAWN(pUnit,Event)
	pUnit:EquipWeapons(37108,0,0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
end

RegisterUnitEvent(16951, 18,"TerrorguardSummoned_SPAWN")


function SkeletonSummoned_SPAWN(pUnit,Event)
	pUnit:EquipWeapons(44639,0,0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
	pUnit:SetMaxPower(100,3)
pUnit:SetPower(100,3)
pUnit:SetPowerType(3)
pUnit:CastSpell(6673)
end

RegisterUnitEvent(6412, 18,"SkeletonSummoned_SPAWN")


function SatyrSummoned_SPAWN(pUnit,Event)
	pUnit:EquipWeapons(51932,51932,0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
end

RegisterUnitEvent(17337, 18,"SatyrSummoned_SPAWN")

function gnargSummoned_SPAWN(pUnit,Event)
pUnit:SetScale(.7)
end

RegisterUnitEvent(21960, 18,"gnargSummoned_SPAWN")

function SpiritWolfSummoned_SPAWN(pUnit,Event)
pUnit:SetScale(1.5)
end

RegisterUnitEvent(29264, 18,"SpiritWolfSummoned_SPAWN")