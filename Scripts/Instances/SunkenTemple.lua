----=====Table of Reference=====----
--[--NPCS--]
-- 89045 + 89046 = Ancient Wardstones
-- 89044 Mysera
-- 89050, 89051, 89052 = Trigger checkings stairwell
--[--Dummies--]--
-- 77294 LASER DUMMY
-- 

--Variables
CRAWL = {}
CRAWL.VAR = {}

local Laser_A
local Laser_B

function CRAWL.VAR.Crystal_Spawn(pUnit,Event)
pUnit:Root()
Laser_A = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(),77293) -- left
pUnit:RegisterEvent("CRAWL.VAR.TargetLaser_CrystalPointA", 1000, 1)
end

function CRAWL.VAR.Crystalb_Spawn(pUnit,Event)
pUnit:Root()
Laser_B = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(),77294) -- right
pUnit:RegisterEvent("CRAWL.VAR.TargetLaser_CrystalPointB", 1000, 1)
end

function CRAWL.VAR.TargetLaser_CrystalPointA(pUnit,Event)
if Laser_A ~= nil then
pUnit:ChannelSpell(60857,Laser_A)
Laser_A:ModifyWalkSpeed(1.5)
Laser_A:SetScale(.1)
pUnit:RegisterEvent("CRAWL.VAR.TargetLaser_Damage", 500, 0)
end
end


function CRAWL.VAR.TargetLaser_CrystalPointB(pUnit,Event)
if Laser_B ~= nil then
pUnit:ChannelSpell(60857,Laser_B)
Laser_B:ModifyWalkSpeed(1.5)
Laser_B:SetScale(.1)
pUnit:RegisterEvent("CRAWL.VAR.TargetLaser_Damageb", 500, 0)
end
end

function CRAWL.VAR.TargetLaser_Damageb(pUnit,Event)
local plr = Laser_B:GetClosestPlayer()
if plr ~= nil then
if plr:IsDead() == false then
if Laser_B:GetDistanceYards(plr) < 3.3 then
plr:CastSpell(39180)
Laser_B:DealDamage(plr, 340, 39180)
end
end
end
end

function CRAWL.VAR.TargetLaser_Damage(pUnit,Event)
local plr = Laser_A:GetClosestPlayer()
if plr ~= nil then
if plr:IsDead() == false then
if Laser_A:GetDistanceYards(plr) < 3.3 then
plr:CastSpell(39180)
Laser_A:DealDamage(plr, 340, 39180)
end
end
end
end


RegisterUnitEvent(89045, 18, "CRAWL.VAR.Crystal_Spawn")
RegisterUnitEvent(89046, 18, "CRAWL.VAR.Crystalb_Spawn")



function CRAWL.VAR.Mysera_Spawn(pUnit,Event)
pUnit:Root()
pUnit:SetScale(.6)
end


RegisterUnitEvent(89044, 18, "CRAWL.VAR.Mysera_Spawn")

---Staircase--
function CRAWL.VAR.DummyCheckingTOP(pUnit,Event)
pUnit:RegisterEvent("CRAWL.VAR.FindingPlayer", 1000, 0)
end

function CRAWL.VAR.FindingPlayer(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 10 then
if plr:IsInPhase(8) == true then
pUnit:RemoveEvents()
--pUnit:RegisterEvent("Playerfound", 2000, 1)
end
end
end
end

RegisterUnitEvent(89052, 18, "CRAWL.VAR.DummyCheckingTOP")