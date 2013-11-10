local OBJECT_END = 0x0006
local UNIT_FLAG_PVP = 0x00001000
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035

function ExplosionVisual(pUnit,Event)
	pUnit:RegisterEvent("TimeExplosion",math.random(5000,10000),0) 
end

function TimeExplosion(pUnit,Event)
	pUnit:CastSpell(46419)
end

RegisterUnitEvent(6804, 18, "ExplosionVisual")
  
function GrimDarkshield_Spawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP)
end

RegisterUnitEvent(6940, 18, "GrimDarkshield_Spawn")