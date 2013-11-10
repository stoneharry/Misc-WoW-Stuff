OBJECT_END = 0x0006
GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
UNIT_FLAG_STUNNED = 0x00040000

function invisistalker_spawn_hx(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- Untargetable
	pUnit:CastSpell(55474)
	pUnit:RegisterEvent("refresh_sleepcos", 5000, 1)
end
		
function refresh_sleepcos(pUnit,Event)
	pUnit:CastSpell(55474)
	pUnit:RegisterEvent("refresh_sleepcos", 5000, 1)
end
		
RegisterUnitEvent(441229, 18, "invisistalker_spawn_hx")

function Goblin_Spawn_Marker(pUnit, Event)
	pUnit:RegisterEvent("ShowMarketOnSelfGoblin", 5000, 0)
end

function ShowMarketOnSelfGoblin(pUnit)
	pUnit:CastSpell(20374)
end

RegisterUnitEvent(197421,18,"Goblin_Spawn_Marker")