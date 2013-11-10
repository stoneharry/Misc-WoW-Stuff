
local Summoner_z
local Summoner_y
local Erdel

local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local OBJECT_END = 0x0006





function Erdel_Spawn(pUnit)
pUnit:Root()
pUnit:DeMorph()
pUnit:EquipWeapons(0,0,0)
pUnit:SetMovementFlags(1)
pUnit:CastSpell(63364)
Erdel = pUnit
end

RegisterUnitEvent(37628, 18,"Erdel_Spawn")


function Erdel_Combat(pUnit,Event)
pUnit:RegisterEvent("Erdel_Phase2",2000,0)
pUnit:RegisterEvent("Shadow_BoltErdel",3500,0)
end


function Shadow_BoltErdel(pUnit)
pUnit:FullCastSpellOnTarget(1088, pUnit:GetMainTank())
end


function Erdel_Dead(pUnit,Event)
pUnit:RemoveEvents()
end

function Erdel_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Despawn(1000,12000)
Summoner_z:Despawn(1000,12000)
Summoner_y:Despawn(1000,12000)
end


function Erdel_Phase2(pUnit,Event)
if Summoner_z:IsDead() and Summoner_y:IsDead() == true then
pUnit:RemoveEvents()
Summoner_z:StopChannel()
Summoner_y:StopChannel()
pUnit:Unroot()
pUnit:CastSpell(39180)
pUnit:CastSpell(18159)
pUnit:SendChatMessage(14,0,"NOOOO! WHAT HAVE YOU DONE!?")
pUnit:SetModel(27074)
pUnit:RemoveAura(63364)
pUnit:EquipWeapons(40343,0,0)
pUnit:SetMovementFlags(2)
pUnit:RegisterEvent("Deathstrike_Erdel",5500,0)
--pUnit:RegisterEvent("IcyTouch_Erdel",7000,0)
end
end


function Deathstrike_Erdel(pUnit)
local target = pUnit:GetMainTank()
if pUnit:GetDistanceYards(target) < 5 then
if target ~= nil then
pUnit:CastSpellOnTarget(66188,target)
end
end
end


function IcyTouch_Erdel(pUnit)
local target = pUnit:GetMainTank()
if pUnit:GetDistanceYards(target) < 15 then
if target ~= nil then
pUnit:CastSpellOnTarget(53549,target)
end
end
end


RegisterUnitEvent(37628, 1, "Erdel_Combat")
RegisterUnitEvent(37628, 2, "Erdel_OnLeave")
RegisterUnitEvent(37628, 4, "Erdel_Dead")



function Summoner_Z_Spawn(pUnit,Event)
pUnit:SetCombatTargetingCapable(true) 
pUnit:SetCombatCapable(true) 
pUnit:Root()
pUnit:ChannelSpell(46016,Erdel)
Summoner_z = pUnit
Summoner_z:RegisterEvent("SummonZ_Channel",2000,1)
end

RegisterUnitEvent(37629, 18,"Summoner_Z_Spawn")

function Summoner_Y_Spawn(pUnit,Event)
pUnit:SetCombatTargetingCapable(true) 
pUnit:SetCombatCapable(true) 
pUnit:Root()
Summoner_y = pUnit
Summoner_y:RegisterEvent("Summony_Channel",2000,1)
end

function SummonZ_Channel(pUnit,Event)
Summoner_z:ChannelSpell(46016,Erdel)
end

function Summony_Channel(pUnit,Event)
Summoner_y:ChannelSpell(46016,Erdel)
end

RegisterUnitEvent(37630, 18,"Summoner_Y_Spawn")