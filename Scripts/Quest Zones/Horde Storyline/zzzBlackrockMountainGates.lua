--[[
local OBJECT_END=0x0006
local UNIT_FIELD_FLAGS= OBJECT_END+0x0034
local UNIT_FLAG_NOT_SELECTABLE= 0x02000000
local UNIT_FLAG_DEFAULT = 0X00
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 -- Size: 1, Type: BYTES, Flags: PUBLIC

local FlyingDude = nil

------------------------------------------------------------

function flying_due_onspawnea(pUnit, Event)
	pUnit:RegisterEvent("aeioth_zehgozh_ezgoz_zigh",1000,1)
end

function aeioth_zehgozh_ezgoz_zigh(pUnit, Event)
	FlyingDude = pUnit
	FlyingDude:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	FlyingDude:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+5, pUnit:GetO())
	FlyingDude:CastSpell(40280) -- visual
	FlyingDude:SetScale(5)
end

RegisterUnitEvent(240251, 18, "flying_due_onspawnea")

------------------------------------------------------------

function aeihae_zeughz_szejht_kzhzjhhjjhjhjhz(pUnit, Event)
	pUnit:RegisterEvent("aeihae_zeughz_szejht_kzhzjhhjjhjhjh",1,1)
	pUnit:RegisterEvent("incoming_adds_for_horde_lzieohyt",1000,1)
	pUnit:RegisterEvent("lolfire_all_over_The_place_Zopghk",math.random(1000,2000),0)
end

function aeihae_zeughz_szejht_kzhzjhhjjhjhjh(pUnit, Event)
	pUnit:FullCastSpell(40280)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(240252, 18, "aeihae_zeughz_szejht_kzhzjhhjjhjhjhz")

function incoming_adds_for_horde_lzieohyt(pUnit, Event)
	if math.random(1,2) == 1 then	
	pUnit:SpawnCreature(305092, -7383, -1090, 278, 4.7, 1, 20000)
	pUnit:SpawnCreature(310241, -7304, -1056.6, 277.1, 5.088263, 2, 20000)
	else
	pUnit:SpawnCreature(305091, -7383, -1090, 278, 4.7, 1, 20000)
	pUnit:SpawnCreature(310261, -7304, -1056.6, 277.1, 5.088263, 2, 20000)
	end
	pUnit:RegisterEvent("zincoming_adds_for_horde_lzieohyt",math.random(1000,8000),1)
end

function zincoming_adds_for_horde_lzieohyt(pUnit, Event)
	if math.random(1,2) == 1 then
	pUnit:SpawnCreature(305091, -7383, -1090, 278, 4.7, 1, 20000)
		if math.random(1,2) == 1 then
		pUnit:SpawnCreature(305091, -7383, -1090, 278, 4.7, 1, 20000)
		end
		pUnit:SpawnCreature(310261, -7304, -1056.6, 277.1, 5.088263, 2, 20000)
		if math.random(1,2) == 1 then
		pUnit:SpawnCreature(310261, -7304, -1056.6, 277.1, 5.088263, 2, 20000)
		end
	else
	pUnit:SpawnCreature(305092, -7383, -1090, 278, 4.7, 1, 20000)
		if math.random(1,2) == 1 then
		pUnit:SpawnCreature(305092, -7383, -1090, 278, 4.7, 1, 20000)
		end
		if math.random(1,2) == 1 then
		pUnit:SpawnCreature(310241, -7304, -1056.6, 277.1, 5.088263, 2, 20000)
		end
	pUnit:SpawnCreature(310241, -7304, -1056.6, 277.1, 5.088263, 2, 20000)
	end
	pUnit:RegisterEvent("incoming_adds_for_horde_lzieohyt",math.random(1000,8000),1)
end

------------------------------------------------------------

function zzzflying_due_onspawnea(pUnit, Event)
	pUnit:RegisterEvent("zzzaeioth_zehgozh_ezgoz_zigh", 1000,1)
end

function zzzaeioth_zehgozh_ezgoz_zigh(pUnit, Event)
	if FlyingDude ~= nil then
		pUnit:ChannelSpell(31324, FlyingDude)--48316
	end
	pUnit:RegisterEvent("zzzaeioth_zehgozh_ezgoz_zigh", 60000,0)
end

RegisterUnitEvent(30117, 18, "zzzflying_due_onspawnea")

------------------------------------------------------------
-- Horde

function Horde_On_Spawn_spawn_zihdeg(pUnit, Event)
	pUnit:RegisterEvent("Horde_On_Spawn_spawn_zihdeg_z", 1000, 1)
end

function Horde_On_Spawn_spawn_zihdeg_z(pUnit, Event)
	pUnit:CastSpell(64446)
	pUnit:EquipWeapons(15424, 0, 0)
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	if math.random(1,2) == 1 then
	pUnit:SetMovementFlags(1) -- Run
	pUnit:MoveTo(-7312, -1069, 277.1, 3)
	else
	pUnit:SetMovementFlags(1) -- Run
	pUnit:MoveTo(-7311.3, -1072.4, 277.1, 3)
	end
	pUnit:RegisterEvent("Horde_On_Spawn_spawn_zihdeg_zzz", 3000, 1)
end

function Horde_On_Spawn_spawn_zihdeg_zzz(pUnit, Event)
	if math.random(1,2) == 1 then
	pUnit:SetMovementFlags(1) -- Run
	pUnit:MoveTo(-7331.6, -1092, 277.1, 3)
	else
	pUnit:SetMovementFlags(1) -- Run
	pUnit:MoveTo(-7339.6, -1088.2, 277.1, 3)
	end
end

RegisterUnitEvent(310261, 18, "Horde_On_Spawn_spawn_zihdeg")
RegisterUnitEvent(310241, 18, "Horde_On_Spawn_spawn_zihdeg")

-- Alliance

function Alliance_On_Spawn_spawn_zihdeg(pUnit, Event)
	pUnit:RegisterEvent("Alliance_On_Spawn_spawn_zihdeg_z", 1000, 1)
end

function Alliance_On_Spawn_spawn_zihdeg_z(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	pUnit:CastSpell(64446)
	pUnit:EquipWeapons(18867, 0, 0)
	if math.random(1,2) == 1 then
	pUnit:SetMovementFlags(1) -- Run
	pUnit:MoveTo(-7362, -1102, 277.9, 0)
	else
	pUnit:SetMovementFlags(1) -- Run
	pUnit:MoveTo(-7359.5, -1110.4, 277.9, 0)
	end
	pUnit:RegisterEvent("Alliance_On_Spawn_spawn_zihdeg_zzz", 5000, 1)
end

function Alliance_On_Spawn_spawn_zihdeg_zzz(pUnit, Event)
	if math.random(1,2) == 1 then
	pUnit:SetMovementFlags(1) -- Run
	pUnit:MoveTo(-7331.6, -1092, 277.1, 3)
	else
	pUnit:SetMovementFlags(1) -- Run
	pUnit:MoveTo(-7339.6, -1088.2, 277.1, 3)
	end
end

RegisterUnitEvent(305091, 18, "Alliance_On_Spawn_spawn_zihdeg")
RegisterUnitEvent(305092, 18, "Alliance_On_Spawn_spawn_zihdeg")

------------------------------------------------------------

function lolfire_all_over_The_place_Zopghk(pUnit, Event)
	local choice = math.random(1,10)
	if choice == 1 then
	pUnit:SpawnCreature(256973, -7316, -1085, 277, 0, 35, 0)
	end
	if choice == 2 then
	pUnit:SpawnCreature(256973, -7327, -1093.7, 277, 0, 35, 0)
	end
	if choice == 3 then
	pUnit:SpawnCreature(256973, -7340, -1102, 277, 0, 35, 0)
	end
	if choice == 4 then
	pUnit:SpawnCreature(256973, -7364.7, -1109.4, 278, 0, 35, 0)
	end
	if choice == 5 then
	pUnit:SpawnCreature(256973, -7361.7, -1083, 277, 0, 35, 0)
	end
	if choice == 6 then
	pUnit:SpawnCreature(256973, -7346, -1079, 277, 0, 35, 0)
	end
	if choice == 7 then
	pUnit:SpawnCreature(256973, -7336, -1073, 277, 0, 35, 0)
	end
	if choice == 8 then
	pUnit:SpawnCreature(256973, -7325, -1068.7, 277, 0, 35, 0)
	end
	if choice == 9 then
	pUnit:SpawnCreature(256973, 7338.5, -1085.7, 277, 0, 35, 0)
	end
	if choice == 10 then
	pUnit:SpawnCreature(256973, -7347, -1099.7, 277, 0, 35, 0)
	end
end

function zzaeihga_bombtrigger_onspawnosej(pUnit, Event)
	pUnit:RegisterEvent("zzzzaeihga_bombtrigger_onspawnosej", 2000, 1)
end

function zzzzaeihga_bombtrigger_onspawnosej(pUnit, Event)
	pUnit:CastSpell(64079)
	--pUnit:CastSpell(61126)
	pUnit:Despawn(4000, 0)
end

RegisterUnitEvent(256973, 18, "zzaeihga_bombtrigger_onspawnosej")

------------------------------------------------------------
]]