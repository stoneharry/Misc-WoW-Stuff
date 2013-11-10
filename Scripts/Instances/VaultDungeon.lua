
VAULT = {}
VAULT.VAR = {} 

--[[ Blackshield Boss, #1 Variables ]]
local Beam_A = nil-- bottom left
local Beam B = nil -- bottom right
local Beam_C = nil -- top left
local Beam_D = nil -- top right
local PORTAL_A = nil
local PORTAL_B = nil
local PORTAL_C = nil
local PORTAL_D = nil
local Channeler_A = nil -- bottom left
local Channeler_B = nil --bottom right
local Channeler_C = nil --top left
local Channeler_D = nil -- top right
local ORB = nil --first orb
local Orb_B = nil -- second orb

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B

--[[
Blackshield Boss, #1 Dummies:
68940 == fire dummy
68939 == orb 
68938 == beam(uses multiple var due to loc finder)
68937 == Portal Dummy

]]




  
  
 --[[ function VAULT.VAR.OrbSpawn(pUnit,Event)
  pUnit:CastSpell(35194)
 local plr = pUnit:GetRandomPlayer(0)
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 20 then
if plr:IsDead() == false then
pUnit:ChannelSpell(60857,plr)
pUnit:SetUnitToFollow(plr, 1, 1) 
  pUnit:RegisterEvent("VAULT.VAR.OrbFireSpawn",500,0) 
  else
  plr = nil
  pUnit:RegisterEvent("VAULT.VAR.OrbSpawn",200,1) 
  end
  end
  end
  end ]]
  
  
function VAULT.VAR.OrbFireSpawn(pUnit,Event)
if ORB ~= nil then
ORB:SpawnCreature(68940 ,ORB:GetX() , ORB:GetY(), ORB:GetZ(), ORB:GetO(), 35, 11000)
end
end
  
  --RegisterUnitEvent(68939, 18, "VAULT.VAR.OrbSpawn")
  
  
  function VAULT.VAR.EREDARCHANNELSPAWN(pUnit,Event)
pUnit:EquipWeapons(30732,0,0)
pUnit:Root()
pUnit:SetCombatTargetingCapable(true) 
pUnit:SetCombatCapable(true) 
end
  
  RegisterUnitEvent(68944, 18, "VAULT.VAR.EREDARCHANNELSPAWN")
  
  --[[ Blackshield Trash
  Blackshield Sentry = 68943
  55948 - Grow
  ]]
  
  function VAULT.VAR.BlackSentry_OnCombat(pUnit,Event)
  pUnit:RegisterEvent("VAULT.VAR.BlackSentry_GrowOne",7000,1) 
  pUnit:RegisterEvent("VAULT.VAR.BlackSentry_MortalStrike",6000,0) 
  pUnit:RegisterEvent("VAULT.VAR.BlackSentry_SliceDice",8000,1) 
  pUnit:RegisterEvent("VAULT.VAR.BlackSentry_ExposeArmor",10000,0)
  end
  
  
   function VAULT.VAR.BlackSentry_OnLeave(pUnit,Event)
   pUnit:RemoveEvents()
   pUnit:RemoveAura(55948)
  end
  
  
   function VAULT.VAR.BlackSentry_OnDead(pUnit,Event)
   pUnit:RemoveEvents()
   pUnit:RemoveAura(55948)
  end
  
  
  function VAULT.VAR.BlackSentry_MortalStrike(pUnit,Event)
  local target = pUnit:GetMainTank()
  if target ~= nil then
  if pUnit:GetDistanceYards(target) < 10 then
   target:RemoveAura(27850)
   pUnit:CastSpellOnTarget(27580,target)
   end
   end
   end
   
     function VAULT.VAR.BlackSentry_ExposeArmor(pUnit,Event)
  local target = pUnit:GetMainTank()
  if target ~= nil then
  if pUnit:GetDistanceYards(target) < 10 then
   target:RemoveAura(60842)
   pUnit:CastSpellOnTarget(60842,target)
   end
   end
   end
   
   
   function VAULT.VAR.BlackSentry_SliceDice(pUnit,Event)
   pUnit:CastSpell(43547)
   pUnit:RegisterEvent("VAULT.VAR.BlackSentry_SliceDice",21000,1) 
   end
  
function VAULT.VAR.BlackSentry_GrowOne(pUnit,Event)
pUnit:CastSpell(55948)
pUnit:RegisterEvent("VAULT.VAR.BlackSentry_GrowTwo",9000,1) 
end

function VAULT.VAR.BlackSentry_GrowTwo(pUnit,Event)
pUnit:CastSpell(55948)
pUnit:RegisterEvent("VAULT.VAR.BlackSentry_GrowThree",9000,1) 
end

function VAULT.VAR.BlackSentry_GrowThree(pUnit,Event)
pUnit:CastSpell(55948)
pUnit:RegisterEvent("VAULT.VAR.BlackSentry_GrowFour",9000,1) 
end

function VAULT.VAR.BlackSentry_GrowFour(pUnit,Event)
pUnit:CastSpell(55948)
pUnit:RegisterEvent("VAULT.VAR.BlackSentry_GrowEffect",9000,1) 
end

function VAULT.VAR.BlackSentry_GrowEffect(pUnit,Event)
pUnit:CastSpell(13021)
pUnit:RemoveAura(55948)
pUnit:RemoveAura(55948)
pUnit:RemoveAura(55948)
pUnit:RemoveAura(55948)
pUnit:RegisterEvent("VAULT.VAR.BlackSentry_GrowOne",9000,1) 
end
  
  RegisterUnitEvent(68943, 1, "VAULT.VAR.BlackSentry_OnCombat")
RegisterUnitEvent(68943, 2, "VAULT.VAR.BlackSentry_OnLeave")
RegisterUnitEvent(68943, 4, "VAULT.VAR.BlackSentry_OnDead")
 
 
 function VAULT.VAR.EredarChanneler_OnDead(pUnit,Event)
 pUnit:RemoveEvents()
 pUnit:StopChannel()
 end
 
RegisterUnitEvent(68944, 4, "VAULT.VAR.EredarChanneler_OnDead")
 
 --[[ ZURTROGG BLACKSHIELD
 ID: 68942
 p1 - Basic tank and spank with adds coming through the portals that need to be dealt with, Shadow orbs will come through the portal 
and link themself to a player, the player has to run away from the orb and the group because the orb drops fire at it's location every
few seconds.

p2 - at 80, 65, and 45%, Zurtrogg will run in the middle and 4 eredar channelers will spawn from each of the portals, 
the boss will then cast a big bang type spell and the channelers must be killed before he sets it off in order to interrupt
the boss.

p3 - at 25%, Zurtrogg will enrage and deal twice as much damage.  The portals will spawn beams that hit the ground, if touched they will
deal damage and they also drop fire on the ground. 
-------
portal coords
NW: -10.46, 158.89, -28.8, 5.40
NE: 6.93, 158.75, 28.80, 4.01
SE: 8.71, 139.57 , 28.80, 2.15
SW: -10.95, 140.01, 28.80, 0.70
]]



function VAULT.VAR.BLACKSHIELD_OnCombat(pUnit,Event)
pUnit:GetGameObjectNearestCoords(-1.12, 133.16, 27.55, 175947):SetByte(GAMEOBJECT_BYTES_1,0,1)
pUnit:PlaySoundToSet(11433)
pUnit:SendChatMessage(14, 0, "Time to feast!")
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_SpawnOrbs", 13000,0)
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_MortalWound",5000,0) 
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_CLEAVE",7000,0) 
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_PHASE2", 2000,0)
end

function VAULT.VAR.BLACKSHIELD_OnDead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:PlaySoundToSet(11439)
pUnit:SetScale(.4)
pUnit:GetGameObjectNearestCoords(-1.12, 133.16, 27.55, 175947):SetByte(GAMEOBJECT_BYTES_1,0,0)
pUnit:GetGameObjectNearestCoords(-5.62, 71.76, -27.55, 175947):SetByte(GAMEOBJECT_BYTES_1,0,0)
PORTAL_A:StopChannel()
PORTAL_B:StopChannel()
PORTAL_C:StopChannel()
PORTAL_D:StopChannel()
BEAM_A:RemoveEvents()
BEAM_B:RemoveEvents()
BEAM_C:RemoveEvents()
BEAM_D:RemoveEvents()
end

function VAULT.VAR.BLACKSHIELD_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
pUnit:RemoveAura(60177)
pUnit:RemoveAura(28131)
pUnit:GetGameObjectNearestCoords(-1.12, 133.16, 27.55, 175947):SetByte(GAMEOBJECT_BYTES_1,0,0)
pUnit:SetCombatTargetingCapable(false) 
pUnit:SetCombatCapable(false) 
pUnit:Despawn(2000,7000)
pUnit:SetScale(.4)
if PORTAL_A ~= nil then
PORTAL_A:StopChannel()
PORTAL_A:Despawn(1,2)
PORTAL_B:StopChannel()
PORTAL_B:Despawn(1,2)
PORTAL_C:StopChannel()
PORTAL_C:Despawn(1,2)
PORTAL_D:StopChannel()
PORTAL_D:Despawn(1,2)
end
end


function VAULT.VAR.BLACKSHIELD_SpawnOrbs(pUnit,Event)
ORB = pUnit:SpawnCreature(68939 ,-10.46, 158.89, -28.8, 5.40, 35, 10000)
 ORB:CastSpell(35194)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_ORBTRIGGER",1000,1) 
end

function VAULT.VAR.BLACKSHIELD_ORBTRIGGER(pUnit,Event)
 local plr = ORB:GetRandomPlayer(0)
 if plr ~= nil then
 if plr:IsDead() == false then
if ORB:GetDistanceYards(plr) < 35 then
ORB:SetUnitToFollow(plr, 1, 1) 
ORB:ChannelSpell(60857,plr)
  pUnit:RegisterEvent("VAULT.VAR.OrbFireSpawn",500,0) 
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_ORBNIL",10500,1) 
  elseif plr == nil then
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_ORBTRIGGER",200,1) 
end
end
end
end

function VAULT.VAR.BLACKSHIELD_ORBNIL(pUnit,Event)
ORB = nil
end

function VAULT.VAR.BLACKSHIELD_OnSlay(pUnit,Event)
pUnit:CastSpell(60177)
if math.random(1,2) <= 1 then
pUnit:PlaySoundToSet(11437)
elseif math.random(1,2) <= 2 then
pUnit:PlaySoundToSet(11434)
pUnit:SendChatMessage(14,0,"More! I want more!")
end
end

function VAULT.VAR.BLACKSHIELD_MortalWound(pUnit,Event)
  local target = pUnit:GetMainTank()
  if target ~= nil then
  if pUnit:GetDistanceYards(target) < 5 then
   pUnit:CastSpellOnTarget(25646,target)
   end
   end
   end
   
   
   function VAULT.VAR.BLACKSHIELD_CLEAVE(pUnit,Event)
  local target = pUnit:GetMainTank()
  if target ~= nil then
  if pUnit:GetDistanceYards(target) < 5 then
   pUnit:CastSpellOnTarget(90981,target)
   end
   end
   end
  



function VAULT.VAR.BLACKSHIELD_PHASE2(pUnit,Event)
if pUnit:GetHealthPct() < 80 then
pUnit:RemoveEvents()
pUnit:CastSpell(22663)
pUnit:Root()
pUnit:TeleportCreature(-1.09,149.64,-28.80)
pUnit:SetFacing(4.61)
pUnit:SetCombatTargetingCapable(true) 
pUnit:SetCombatCapable(true) 
Channeler_A = pUnit:SpawnCreature(68944, -8.21, 142.50, -28.80, 0.83, 14, 0)
Channeler_A:ChannelSpell(46016,pUnit)
Channeler_B = pUnit:SpawnCreature(68944, 6.72, 143.33, -28.80, 2.38, 14, 0)
Channeler_B:ChannelSpell(46016,pUnit)
Channeler_C = pUnit:SpawnCreature(68944, -8.85, 157.12, -28.80, 5.47, 14, 0) -- top left
Channeler_C:ChannelSpell(46016,pUnit)
Channeler_D = pUnit:SpawnCreature(68944, 5.05, 156.34, -28.80, 3.9, 14, 0) -- top right
Channeler_D:ChannelSpell(46016,pUnit)
if math.random(1,2) <= 1 then
pUnit:PlaySoundToSet(11435)
pUnit:SendChatMessage(14,0,"Drink your blood! Eat your flesh!")
elseif math.random(1,2) <= 2 then
pUnit:PlaySoundToSet(11436)
pUnit:SendChatMessage(14,0,"I hunger!")
end
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_CHANNELERCHECK", 1000,0)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDFAILED", 31000,1)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDWARNINGTENSECONDS", 21000,1)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDWARNINGTWENTYSECONDS", 11000,1)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDWARNINGTHIRTYSECONDS", 1000,1)
end
end

function VAULT.VAR.BLACKSHIELD_RAIDWARNINGTENSECONDS(pUnit,Event)
pUnit:SendChatMessage(42,0,"10 seconds until \124cff71d5ff\124Hspell:64166\124h[Extinguish All Life]\124h\124r")
end

function VAULT.VAR.BLACKSHIELD_RAIDWARNINGTHIRTYSECONDS(pUnit,Event)
pUnit:SendChatMessage(42,0,"30 seconds until \124cff71d5ff\124Hspell:64166\124h[Extinguish All Life]\124h\124r")
end

function VAULT.VAR.BLACKSHIELD_RAIDWARNINGTWENTYSECONDS(pUnit,Event)
pUnit:SendChatMessage(42,0,"20 seconds until \124cff71d5ff\124Hspell:64166\124h[Extinguish All Life]\124h\124r")
end

function VAULT.VAR.BLACKSHIELD_CHANNELERCHECK(pUnit,Event)
if Channeler_A:IsDead() and Channeler_B:IsDead() and Channeler_C:IsDead() and Channeler_D:IsDead() == true then
pUnit:RemoveEvents()
pUnit:RemoveAura(22663)
pUnit:Unroot()
pUnit:SetCombatTargetingCapable(false) 
pUnit:SetCombatCapable(false) 
Channeler_A:Despawn(1,0)
Channeler_B:Despawn(1,0)
Channeler_C:Despawn(1,0)
Channeler_D:Despawn(1,0)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_SpawnOrbs", 17000,0)
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_MortalWound",5000,0) 
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_CLEAVE",7000,0) 
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_PHASE3", 2000,0)
end
end

function VAULT.VAR.BLACKSHIELD_RAIDFAILED(pUnit,Event)
pUnit:CastSpell(64166)
pUnit:CastSpell(64166)
pUnit:RemoveAura(22663)
pUnit:Unroot()
pUnit:SetCombatTargetingCapable(false) 
pUnit:SetCombatCapable(false) 
pUnit:Despawn(2000,7000)
Channeler_A:Despawn(1,0)
Channeler_B:Despawn(1,0)
Channeler_C:Despawn(1,0)
Channeler_D:Despawn(1,0)
end

function VAULT.VAR.BLACKSHIELD_PHASE3(pUnit,Event)
if pUnit:GetHealthPct() < 65 then
pUnit:RemoveEvents()
pUnit:CastSpell(22663)
pUnit:Root()
pUnit:TeleportCreature(-1.09,149.64,-28.80)
pUnit:SetFacing(4.61)
pUnit:SetCombatTargetingCapable(true) 
pUnit:SetCombatCapable(true) 
Channeler_A = pUnit:SpawnCreature(68944, -8.21, 142.50, -28.80, 0.83, 14, 0)
Channeler_A:ChannelSpell(46016,pUnit)
Channeler_B = pUnit:SpawnCreature(68944, 6.72, 143.33, -28.80, 2.38, 14, 0)
Channeler_B:ChannelSpell(46016,pUnit)
Channeler_C = pUnit:SpawnCreature(68944, -8.85, 157.12, -28.80, 5.47, 14, 0) -- top left
Channeler_C:ChannelSpell(46016,pUnit)
Channeler_D = pUnit:SpawnCreature(68944, 5.05, 156.34, -28.80, 3.9, 14, 0) -- top right
Channeler_D:ChannelSpell(46016,pUnit)
if math.random(1,2) <= 1 then
pUnit:PlaySoundToSet(11435)
pUnit:SendChatMessage(14,0,"Drink your blood! Eat your flesh!")
elseif math.random(1,2) <= 2 then
pUnit:PlaySoundToSet(11436)
pUnit:SendChatMessage(14,0,"I hunger!")
end
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_CHANNELERCHECKz", 1000,0)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDFAILED", 31000,1)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDWARNINGTENSECONDS", 21000,1)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDWARNINGTWENTYSECONDS", 11000,1)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDWARNINGTHIRTYSECONDS", 1000,1)
end
end


function VAULT.VAR.BLACKSHIELD_CHANNELERCHECKz(pUnit,Event)
if Channeler_A:IsDead() and Channeler_B:IsDead() and Channeler_C:IsDead() and Channeler_D:IsDead() == true then
pUnit:RemoveEvents()
pUnit:RemoveAura(22663)
pUnit:Unroot()
pUnit:SetCombatTargetingCapable(false) 
pUnit:SetCombatCapable(false) 
Channeler_A:Despawn(1,0)
Channeler_B:Despawn(1,0)
Channeler_C:Despawn(1,0)
Channeler_D:Despawn(1,0)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_SpawnOrbs", 17000,0)
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_MortalWound",5000,0) 
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_CLEAVE",7000,0) 
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_PHASE4", 2000,0)
end
end

function VAULT.VAR.BLACKSHIELD_PHASE4(pUnit,Event)
if pUnit:GetHealthPct() < 45 then
pUnit:RemoveEvents()
pUnit:CastSpell(22663)
pUnit:Root()
pUnit:TeleportCreature(-1.09,149.64,-28.80)
pUnit:SetFacing(4.61)
pUnit:SetCombatTargetingCapable(true) 
pUnit:SetCombatCapable(true) 
Channeler_A = pUnit:SpawnCreature(68944, -8.21, 142.50, -28.80, 0.83, 14, 0)
Channeler_A:ChannelSpell(46016,pUnit)
Channeler_B = pUnit:SpawnCreature(68944, 6.72, 143.33, -28.80, 2.38, 14, 0)
Channeler_B:ChannelSpell(46016,pUnit)
Channeler_C = pUnit:SpawnCreature(68944, -8.85, 157.12, -28.80, 5.47, 14, 0) -- top left
Channeler_C:ChannelSpell(46016,pUnit)
Channeler_D = pUnit:SpawnCreature(68944, 5.05, 156.34, -28.80, 3.9, 14, 0) -- top right
Channeler_D:ChannelSpell(46016,pUnit)
if math.random(1,2) <= 1 then
pUnit:PlaySoundToSet(11435)
pUnit:SendChatMessage(14,0,"Drink your blood! Eat your flesh!")
elseif math.random(1,2) <= 2 then
pUnit:PlaySoundToSet(11436)
pUnit:SendChatMessage(14,0,"I hunger!")
end
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_CHANNELERCHECKzz", 1000,0)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDFAILED", 31000,1)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDWARNINGTENSECONDS", 21000,1)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDWARNINGTWENTYSECONDS", 11000,1)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_RAIDWARNINGTHIRTYSECONDS", 1000,1)
end
end

function VAULT.VAR.BLACKSHIELD_CHANNELERCHECKzz(pUnit,Event)
if Channeler_A:IsDead() and Channeler_B:IsDead() and Channeler_C:IsDead() and Channeler_D:IsDead() == true then
pUnit:RemoveEvents()
pUnit:RemoveAura(22663)
pUnit:Unroot()
pUnit:SetCombatTargetingCapable(false) 
pUnit:SetCombatCapable(false) 
Channeler_A:Despawn(1,0)
Channeler_B:Despawn(1,0)
Channeler_C:Despawn(1,0)
Channeler_D:Despawn(1,0)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_SpawnOrbs", 17000,0)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_CLEAVE",7000,0) 
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_PHASE5", 2000,0)
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_MortalWound",5000,0) 
end
end

function VAULT.VAR.BLACKSHIELD_PHASE5(pUnit,Event)
if pUnit:GetHealthPct() < 25 then
pUnit:RemoveEvents()
pUnit:PlaySoundToSet(11438)
pUnit:SendChatMessage(14,0,"I'll rip the meat from your bones!")
pUnit:SetScale(.5)
pUnit:CastSpell(28131)
BEAM_A = pUnit:GetCreatureNearestCoords(6.93, 158.75, 28.80,68938) --top right
BEAM_B = pUnit:GetCreatureNearestCoords(-10.46, 158.89, -28.8,68938) -- top left
BEAM_C = pUnit:GetCreatureNearestCoords(8.71, 139.57 , 28.80,68938) -- bottom left
BEAM_D = pUnit:GetCreatureNearestCoords(-10.95, 140.01, 28.80,68938) -- bottom right
PORTAL_A = pUnit:GetCreatureNearestCoords(6.93, 158.75, 28.80,68937) --top right
PORTAL_B = pUnit:GetCreatureNearestCoords(-10.46, 158.89, -28.8,68937) -- top left
PORTAL_C = pUnit:GetCreatureNearestCoords(8.71, 139.57 , 28.80,68937) --bottom right
PORTAL_D = pUnit:GetCreatureNearestCoords(-10.95, 140.01, 28.80,68937)  -- bottom left
PORTAL_A:ChannelSpell(39123,BEAM_A)
PORTAL_B:ChannelSpell(39123,BEAM_B)
PORTAL_C:ChannelSpell(39123,BEAM_C)
PORTAL_D:ChannelSpell(39123,BEAM_D)
BEAM_A:ModifyWalkSpeed(1.5)
BEAM_A:SetScale(.1)
BEAM_B:ModifyWalkSpeed(1.5)
BEAM_B:SetScale(.1)
BEAM_C:ModifyWalkSpeed(1.5)
BEAM_C:SetScale(.1)
BEAM_D:ModifyWalkSpeed(1.5)
BEAM_D:SetScale(.1)
pUnit:RegisterEvent("VAULT.VAR.BEAM_A_FUNCTION", 1000,0)
pUnit:RegisterEvent("VAULT.VAR.BEAM_B_FUNCTION", 1000,0)
pUnit:RegisterEvent("VAULT.VAR.BEAM_C_FUNCTION", 1000,0)
pUnit:RegisterEvent("VAULT.VAR.BEAM_D_FUNCTION", 1000,0)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_SpawnOrbs", 12000,0)
pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_CLEAVE",7000,0) 
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_MortalWound",5000,0) 
  pUnit:RegisterEvent("VAULT.VAR.BLACKSHIELD_BLOODBOLT",2000,0) 
end
end


function VAULT.VAR.BLACKSHIELD_BLOODBOLT(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  pUnit:CastSpellOnTarget(31281,players)
  end
  end
  end


----BEAM FIRE/FUNCTIONS
function VAULT.VAR.BEAM_A_FUNCTION(pUnit,Event)
BEAM_A:SpawnCreature(68940 ,BEAM_A:GetX() , BEAM_A:GetY(), BEAM_A:GetZ(), BEAM_A:GetO(), 35, 7000)
local PlayersAllAround = BEAM_A:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if BEAM_A:GetDistanceYards(players) < 3 then
players:CastSpell(39180)
BEAM_A:DealDamage(players, 240, 39180)
end
end
end


function VAULT.VAR.BEAM_B_FUNCTION(pUnit,Event)
BEAM_B:SpawnCreature(68940 ,BEAM_B:GetX() , BEAM_B:GetY(), BEAM_B:GetZ(), BEAM_B:GetO(), 35, 7000)
local PlayersAllAround = BEAM_B:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if BEAM_B:GetDistanceYards(players) < 3 then
players:CastSpell(39180)
BEAM_B:DealDamage(players, 240, 39180)
end
end
end

function VAULT.VAR.BEAM_C_FUNCTION(pUnit,Event)
BEAM_C:SpawnCreature(68940 ,BEAM_C:GetX() , BEAM_C:GetY(), BEAM_C:GetZ(), BEAM_C:GetO(), 35, 7000)
local PlayersAllAround = BEAM_C:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if BEAM_C:GetDistanceYards(players) < 3 then
players:CastSpell(39180)
BEAM_C:DealDamage(players, 240, 39180)
end
end
end

function VAULT.VAR.BEAM_D_FUNCTION(pUnit,Event)
BEAM_D:SpawnCreature(68940 ,BEAM_D:GetX() , BEAM_D:GetY(), BEAM_D:GetZ(), BEAM_D:GetO(), 35, 7000)
local PlayersAllAround = BEAM_D:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if BEAM_D:GetDistanceYards(players) < 3 then
players:CastSpell(39180)
BEAM_D:DealDamage(players, 240, 39180)
end
end
end



  RegisterUnitEvent(68942, 1, "VAULT.VAR.BLACKSHIELD_OnCombat")
RegisterUnitEvent(68942, 2, "VAULT.VAR.BLACKSHIELD_OnLeave")
RegisterUnitEvent(68942, 3, "VAULT.VAR.BLACKSHIELD_OnSlay")
RegisterUnitEvent(68942, 4, "VAULT.VAR.BLACKSHIELD_OnDead")

---[[LEFT WING TRASH]]

 function VAULT.VAR.TRAPSPAWNLEFTWINGONE(pUnit,Event)
  pUnit:RegisterEvent("VAULT.VAR.TRIGGERTRAPLEFTWINGONE",1000,0) 
  end
  
  RegisterUnitEvent(46542, 18, "VAULT.VAR.TRAPSPAWNLEFTWINGONE")
  
  
   function VAULT.VAR.TRAPSPAWNLEFTWINGTWO(pUnit,Event)
  pUnit:RegisterEvent("VAULT.VAR.TRIGGERTRAPLEFTWINGTWO",1000,0) 
  end
  
  RegisterUnitEvent(46541, 18, "VAULT.VAR.TRAPSPAWNLEFTWINGTWO")
  
  
 function VAULT.VAR.TRIGGERTRAPLEFTWINGONE(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 5 then
pUnit:RemoveEvents()
pUnit:SpawnCreature(68946, -34.69, 77.28, -32.63, 4.69, 14, 0)
pUnit:SpawnCreature(68946, -34.69, 66.74, -32.63, 1.55, 14, 0)
end
end
end

 function VAULT.VAR.TRIGGERTRAPLEFTWINGTWO(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 5 then
pUnit:RemoveEvents()
pUnit:SpawnCreature(68946, -56.89, 76.46, -32.61, 4.73, 14, 0)
pUnit:SpawnCreature(68946, -56.90, 66.74, -32.63, 1.6, 14, 0)
end
end
end

function VAULT.VAR.BLACKBUSHASSASSIN_ONSPAWN(pUnit,Event)
pUnit:SetFaction(16)
pUnit:EquipWeapons(32369,32369,0)
end

RegisterUnitEvent(68946, 18, "VAULT.VAR.BLACKBUSHASSASSIN_ONSPAWN")

function VAULT.VAR.BLACKBUSHASSASSIN_ONCOMBAT(pUnit,Event)
pUnit:CastSpell(24222)
pUnit:RegisterEvent("VAULT.VAR.BLACKBUSHASSASSIN_WOUNDPOISON",11000,0) 
pUnit:RegisterEvent("VAULT.VAR.BLACKBUSHASSASSIN_MUTI",5000,0) 
pUnit:RegisterEvent("VAULT.VAR.BLACKBUSHASSASSIN_BLIND",7000,0) 
end

function VAULT.VAR.BLACKBUSHASSASSIN_WOUNDPOISON(pUnit,Event)
  local target = pUnit:GetMainTank()
  if target ~= nil then
  if pUnit:GetDistanceYards(target) < 5 then
  target:RemoveAura(54121)
   pUnit:CastSpellOnTarget(54121,target)
end
end
end

function VAULT.VAR.BLACKBUSHASSASSIN_BLIND(pUnit,Event)
local randomplayer = pUnit:GetRandomPlayer(7)
  if randomplayer ~= nil then
  if pUnit:GetDistanceYards(randomplayer) < 20 then
pUnit:CastSpellOnTarget(34694, randomplayer)
end
end
end

function VAULT.VAR.BLACKBUSHASSASSIN_MUTI(pUnit,Event)
  local target = pUnit:GetMainTank()
  if target ~= nil then
  if pUnit:GetDistanceYards(target) < 5 then
   pUnit:CastSpellOnTarget(11294,target)
end
end
end

function VAULT.VAR.BLACKBUSHASSASSIN_ONLEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

function VAULT.VAR.BLACKBUSHASSASSIN_ONDEAD(pUnit,Event)
pUnit:RemoveEvents()
end


  RegisterUnitEvent(68946, 1, "VAULT.VAR.BLACKBUSHASSASSIN_ONCOMBAT")
RegisterUnitEvent(68946, 2, "VAULT.VAR.BLACKBUSHASSASSIN_ONLEAVE")
RegisterUnitEvent(68946, 4, "VAULT.VAR.BLACKBUSHASSASSIN_ONDEAD")
  