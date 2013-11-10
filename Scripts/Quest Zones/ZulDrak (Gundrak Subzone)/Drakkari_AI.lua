local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 


function Chieftan_Spawn(pUnit,Event)
pUnit:SetMaxPower(1000,1)
pUnit:SetPower(1000,1)	
pUnit:Dismount()
pUnit:SetMount(6469)
pUnit:EquipWeapons(43110,0,0)
end

function Drakkari_DefenderSpawn(pUnit,Event)
pUnit:SetMaxPower(1000,1)
pUnit:SetPower(1000,1)	
pUnit:SetPowerType(1)
pUnit:EquipWeapons(45204,35094,0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
end

function Drakkari_OracleSpawn(pUnit,Event)
pUnit:EquipWeapons(26795,0,0)
pUnit:CastSpell(325)
pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
end

function Blood_Spawn(pUnit,Event)
pUnit:CastSpell(9617)
end

RegisterUnitEvent(26704, 18, "Drakkari_DefenderSpawn")
RegisterUnitEvent(26795, 18, "Drakkari_OracleSpawn")
RegisterUnitEvent(28873, 18, "Chieftan_Spawn")
RegisterUnitEvent(28779, 18, "Blood_Spawn")

function GREATERBLOOD_SPAWN(pUnit,Event)
pUnit:CastSpell(9617)
end

RegisterUnitEvent(88862, 18, "GREATERBLOOD_SPAWN")

function Shari_SPAWN(pUnit,Event)
pUnit:CastSpell(9617)
pUnit:SetMaxPower(100,2)
pUnit:SetPower(100,2)	
pUnit:SetPowerType(2)	
if pUnit:IsPet() == true then
pUnit:SetScale(1.5)
else if math.random(1,3) <= 1 then
 pUnit:Despawn(1000,10800000)
end
end
end

RegisterUnitEvent(44765 , 18, "Shari_SPAWN")

function ORACLE_COMBAT(pUnit,Event)
pUnit:RegisterEvent("ORACLE_LIGHTNINGBOLT", 2800, 0)
pUnit:RegisterEvent("DRAKUNROOT_CASTER", 1000, 0)
end

function ORACLE_DISENGAGECOMBAT(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Unroot()
end

function ORACLE_LIGHTNINGBOLT(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:Root()
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 15 then
pUnit:FullCastSpellOnTarget(915,tank)
end
end
end
end

function DRAKUNROOT_CASTER(pUnit,Event)
if pUnit:IsCasting() == false then
if pUnit:IsRooted() == true then
pUnit:Unroot()
end
end
end


RegisterUnitEvent(26795, 1,"ORACLE_COMBAT")
RegisterUnitEvent(26795, 3,"ORACLE_DISENGAGECOMBAT")
RegisterUnitEvent(26795, 4,"ORACLE_DISENGAGECOMBAT")