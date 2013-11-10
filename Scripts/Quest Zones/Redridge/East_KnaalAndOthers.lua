local Knaal
local Player


function KnaalDarkshield(pUnit,Event)
Knaal = pUnit
Knaal:Unroot()
Knaal:SetMovementFlags(1)
Knaal:DisableCombat(false)
end

RegisterUnitEvent(77016, 18, "KnaalDarkshield")

function DummyChecking(pUnit,Event)
pUnit:RegisterEvent("FindingPlayer", 1000, 0)
end

RegisterUnitEvent(77018, 18, "DummyChecking")

function FindingPlayer(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 10 then
if plr:HasQuest(3005) == true then
Knaal:RegisterEvent("Playerfound", 2000, 1)
Knaal:MoveTo(-9716.39, -3226.60, 58.89, 0)
pUnit:RemoveEvents()
pUnit:Despawn(1000,10000)
end
end
end
end


function Playerfound(pUnit,Event)
Knaal:SendChatMessage(14,0,"You will never defeat us! FALL BACK!")
Knaal:RegisterEvent("PhasingPlayer", 3000, 1)
end

function PhasingPlayer(pUnit,Event)
local plr = Knaal:GetClosestPlayer()
if plr ~= nil then
if Knaal:GetDistanceYards(plr) < 30 then
local PlayersAllAround = Knaal:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if players:IsInPhase(1) == true then
  players:SetPhase(4)
  players:FinishQuest(3005)
Knaal:Despawn(1000,3000)
Knaal:SetPhase(1)
end
end
end
end
end


-----Archers----
function Archers(pUnit,Event)
pUnit:Root()
pUnit:AIDisableCombat(true)
pUnit:RegisterEvent("CatchPlayer", math.random(4000,6000), 0)
end

function CatchPlayer(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 36 then
if plr:IsInPhase(1) == true then
if plr:IsDead() ~= true then
pUnit:SetPosition(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:CalcRadAngle(pUnit:GetX(), pUnit:GetY(), plr:GetX(), plr:GetY()))
pUnit:FullCastSpellOnTarget(54405,plr)
end
end
end
end
end


RegisterUnitEvent(77017, 18, "Archers")

function SpawningRaiders_Spawns(pUnit,Event)
--pUnit:RegisterEvent("Spawning_Raiders",  math.random(8000,20000), 0)
--pUnit:RegisterEvent("PlayMusic", 65000, 0)
--pUnit:RegisterEvent("DESPAWN_DEAD_RAIDERS", 1000, 0)
end

RegisterUnitEvent(17428, 18, "SpawningRaiders_Spawns")

function DESPAWN_DEAD_RAIDERS(pUnit,Event)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
  if creatures:GetEntry() == 77046 then
  if creatures:IsDead() == true then
  creatures:Despawn(1,0)
end
end
end
end

function DespawnMofos_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
 pUnit:Despawn(3000,0)
 end

RegisterUnitEvent(77046, 2, "DespawnMofos_OnLeave")

function PlayMusic(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 70 then
  for a, players in pairs(pUnit:GetInRangePlayers()) do
if players:IsInPhase(1) then
players:PlaySoundToPlayer(6350)
end
end
end
end
end

function Spawning_Raiders(pUnit,Event)
if math.random(1,6) <= 1 then
pUnit:SpawnCreature(77046,-9677.36, -3245.91, 53.06, 0.30, 14, 0)
elseif math.random(1,6) <= 2 then
pUnit:SpawnCreature(77046,-9677.99, -3243.94, 52.80, 0.30, 14, 0)
elseif math.random(1,6) <= 3 then
pUnit:SpawnCreature(77046,-9675.74, -3241.69, 51.81, 0.09, 14, 0)
elseif math.random(1,6) <= 4 then
pUnit:SpawnCreature(77046,-9677.36, -3245.91, 53.06, 0.30, 14, 0)
pUnit:SpawnCreature(77046,-9677.99, -3243.94, 52.80, 0.30, 14, 0)
elseif math.random(1,6) <= 5 then
pUnit:SpawnCreature(77046,-9675.74, -3241.69, 51.81, 0.09, 14, 0)
pUnit:SpawnCreature(77046,-9677.99, -3243.94, 52.80, 0.30, 14, 0)
elseif math.random(1,6) <= 6 then
pUnit:SpawnCreature(77046,-9675.74, -3241.69, 51.81, 0.09, 14, 0)
pUnit:SpawnCreature(77046,-9677.36, -3245.91, 53.06, 0.30, 14, 0)
end
end