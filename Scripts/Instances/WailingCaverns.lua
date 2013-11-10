
WC = {}
WC.VAR = {} 

local entry = 0
local initial = 0
local boss1 = 0
local boss2 = 0
local boss3 = 0
local XerathStart = 0
local FinalAble = 0
local Xerath = nil
local Wipe = 0
local TentacleCount = 0 
local XerathDum = nil



local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B


 function WC.VAR.Tentacle_OnSpawn(pUnit, Event)
 pUnit:Emote(449, 2500)
 pUnit:RegisterEvent("WC.VAR.TentacleCrush",8000,0) 
end

 
 RegisterUnitEvent(33966, 18, "WC.VAR.Tentacle_OnSpawn")
 
 
 
 function WC.VAR.Xerath_OnSpawn(pUnit, Event)
 pUnit:Emote(449, 4000)
 Xerath = pUnit
end

 
 RegisterUnitEvent(42225, 18, "WC.VAR.Xerath_OnSpawn")

 
  function WC.VAR.WailingCaverns_EntrySpawnBoss(pUnit,Event)
  XerathDum = pUnit
 XerathDum:RegisterEvent("WC.VAR.WailingCaverns_EntrySpawnBossz",1000,0) 
  end
  
  RegisterUnitEvent(42229, 18, "WC.VAR.WailingCaverns_EntrySpawnBoss")
  
  
 function WC.VAR.WailingCaverns_EntrySpawnBossz(pUnit,Event)
local plr = XerathDum:GetClosestPlayer()
if plr ~= nil then
if XerathDum:GetDistanceYards(plr) < 20 then
if XerathStart == 0 then
XerathStart = 1 
XerathDum:SpawnCreature(33966,99.70, 283.93, -103.94, 5.26, 14, 0)
XerathDum:SpawnCreature(33966,144.59,271.34,-104.28,3.94, 14, 0)
XerathDum:SpawnCreature(33966,146.38, 217.88, -103.45, 2.43, 14, 0)
XerathDum:SpawnCreature(33966,138.41, 190.71, -103.35, 2.40, 14, 0)
end
end
end
end

function WC.VAR.TENTACLEDEAD(pUnit,Event)
if TentacleCount == 0 then
TentacleCount = 1
elseif TentacleCount == 1 then
TentacleCount = 2
XerathDum:SpawnCreature(42225,152.69, 244.14, -99.54, 3.31, 14, 0)
elseif TentacleCount == 4 then
Xerath:CastSpell(64173) 
Xerath:RegisterEvent("WC.VAR.RESUMMONTENTACLES",8000,1) 
Xerath:RegisterEvent("WC.VAR.REMOVEAURA",8000,1) 
elseif TentacleCount == 6 then
Xerath:CastSpell(64173) 
Xerath:RegisterEvent("WC.VAR.RESUMMONTENTACLES",8000,1) 
Xerath:RegisterEvent("WC.VAR.REMOVEAURA",8000,1) 
end
end

function WC.VAR.RESUMMONTENTACLES(pUnit,Event)
if math.random(1,4) <= 1 then
pUnit:SpawnCreature(33966,99.70, 283.93, -103.94, 5.26, 14, 0)
pUnit:SpawnCreature(33966,144.59,271.34,-104.28,3.94, 14, 0)
elseif math.random(1,5) <= 2 then
pUnit:SpawnCreature(33966,144.59,271.34,-104.28,3.94, 14, 0)
pUnit:SpawnCreature(33966,146.38, 217.88, -103.45, 2.43, 14, 0)
elseif math.random(1,5) <= 3 then
pUnit:SpawnCreature(33966,146.38, 217.88, -103.45, 2.43, 14, 0)
pUnit:SpawnCreature(33966,138.41, 190.71, -103.35, 2.40, 14, 0)
elseif math.random(1,5) <= 4 then
pUnit:SpawnCreature(33966,99.70, 283.93, -103.94, 5.26, 14, 0)
pUnit:SpawnCreature(33966,146.38, 217.88, -103.45, 2.43, 14, 0)
elseif math.random(1,5) <= 5 then
pUnit:SpawnCreature(33966,144.59,271.34,-104.28,3.94, 14, 0)
pUnit:SpawnCreature(33966,138.41, 190.71, -103.35, 2.40, 14, 0)
end
end

function WC.VAR.TentacleCrush(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 8 then
 pUnit:CastSpellOnTarget(50234, plr)
end
end
end

function WC.VAR.TENTACLEHIT(pUnit, event, pAttacker, pAmount)
pUnit:RegisterEvent("WC.VAR.Tentaclepowerz",500,1) 
end

function WC.VAR.Tentaclepowerz(pUnit,Event)
pUnit:CastSpell(57689)
end

function WC.VAR.REMOVEAURA(pUnit,Event)
Xerath:RemoveAura(64173)
end

RegisterUnitEvent(33966, 23, "WC.VAR.TENTACLEHIT")
--RegisterUnitEvent(33966, 4, "WC.VAR.TENTACLEDEAD")


 