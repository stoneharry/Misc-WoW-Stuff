PVPARATHI = {}
PVPARATHI.VAR = {}

function PVPARATHI.VAR.FACTIONCHAMPIONALLIANCE_COMBAT(pUnit,Event)
for place, plrs in pairs(GetPlayersInZone(45)) do
local race = plrs:GetPlayerRace()
if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
plrs:SendAreaTriggerMessage("Your Grand Champion is under attack!")
plrs:PlaySoundToPlayer(9379)
end
pUnit:SendChatMessageToPlayer(14,0,"Horde filth, I will not fall today! Come Alliance brothers, to arms!",plrs)
end
 pUnit:RegisterEvent("PVPARATHI.VAR.FACTIONCHAMPIONHORDE_SPAWNGUARD", math.random(7000,18000), 0)
end

function PVPARATHI.VAR.LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end


function PVPARATHI.VAR.FACTIONCHAMPIONALLIANCE_DEAD(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	PVPARATHI[id] = PVPARATHI[id] or {VAR={}}
pUnit:RemoveEvents()
PVPARATHI[id].VAR.HORDECHAMP:RegisterEvent("PVPARATHI.VAR.DESPAWNCHAMPIONS_EVENTOVER", 500, 1)
for place, plrs in pairs(GetPlayersInZone(45)) do
local race = plrs:GetPlayerRace()
if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
plrs:SendAreaTriggerMessage("Your Grand Champion is has been slain.")
else
plrs:SendAreaTriggerMessage("The Alliance's Grand Champion has been slain, the Horde is victorious!.")
end
plrs:PlaySoundToPlayer(9377)
SendPvPCaptureMessage(45, "The Alliance's Grand Champion has been slain, the Horde is victorious!") -- test
end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 100 then
  local race = players:GetPlayerRace()
if race == 2 or race == 5 or race == 6 or race == 8 or race == 10 then
players:GiveHonor(1200)
players:SendBroadcastMessage("You have been rewarded 1200 honor.")
end
end
end
end


RegisterUnitEvent(447982,1,"PVPARATHI.VAR.FACTIONCHAMPIONALLIANCE_COMBAT")
--RegisterUnitEvent(447982, 3, "PVPARATHI.VAR.FACTIONCHAMPIONALLIANCE_KILL")
RegisterUnitEvent(447982,2,"PVPARATHI.VAR.LEAVE")
RegisterUnitEvent(447982,4,"PVPARATHI.VAR.FACTIONCHAMPIONALLIANCE_DEAD")

function PVPARATHI.VAR.DESPAWNCHAMPIONS_EVENTOVER(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	PVPARATHI[id] = PVPARATHI[id] or {VAR={}}
PVPARATHI[id].VAR.HORDECHAMP:Despawn(30000,1500000)
PVPARATHI[id].VAR.ALLIANCECHAMP:Despawn(30000,1500000)
end

function PVPARATHI.VAR.FACTIONCHAMPIONHORDE_SPAWN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	PVPARATHI[id] = PVPARATHI[id] or {VAR={}}
	PVPARATHI[id].VAR.HORDECHAMP = pUnit
	pUnit:SetFaction(29)
	for place, plrs in pairs(GetPlayersInZone(45)) do
local race = plrs:GetPlayerRace()
if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
end
end
pUnit:SendChatMessageToPlayer(14,0,"Alliance dogs! Give me your best, I spit on the skulls of your fallen brethren.",plrs)
end

RegisterUnitEvent(447984, 18, "PVPARATHI.VAR.FACTIONCHAMPIONHORDE_SPAWN")

function PVPARATHI.VAR.FACTIONCHAMPIONALLIANCE_SPAWN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	PVPARATHI[id] = PVPARATHI[id] or {VAR={}}
	pUnit:SetFaction(12)
PVPARATHI[id].VAR.ALLIANCECHAMP = pUnit
	for place, plrs in pairs(GetPlayersInZone(45)) do
local race = plrs:GetPlayerRace()
if race == 2 or race == 5 or race == 6 or race == 8 or race == 10 then
end
end
pUnit:SendChatMessageToPlayer(14,0,"Horde scum, this is our land, try your best to strike me down!",plrs)
end

RegisterUnitEvent(447982, 18, "PVPARATHI.VAR.FACTIONCHAMPIONALLIANCE_SPAWN")

--horde shit

function PVPARATHI.VAR.FACTIONCHAMPIONHORDE_COMBAT(pUnit,Event)
for place, plrs in pairs(GetPlayersInZone(45)) do
local race = plrs:GetPlayerRace()
if race == 2 or race == 5 or race == 6 or race == 8 or race == 10 then
plrs:SendAreaTriggerMessage("Your Grand Champion is under attack!")
plrs:PlaySoundToPlayer(9378)
end
pUnit:SendChatMessageToPlayer(14,0,"YOU DARE ATTACK ME? Come fellow Horde warriors, attack!",plrs)
end
 pUnit:RegisterEvent("PVPARATHI.VAR.FACTIONCHAMPIONHORDE_SPAWNGUARD", math.random(7000,18000), 0)
end


function PVPARATHI.VAR.FACTIONCHAMPIONALLIANCE_SPAWNGUARD(pUnit,Event)
local x = pUnit:GetX()
local y = pUnit:GetY()
pUnit:SpawnCreature(10696, x-math.random(1,6), y-math.random(1,6), pUnit:GetZ(), pUnit:GetO(), 12, 45000)
end


function PVPARATHI.VAR.FACTIONCHAMPIONHORDE_SPAWNGUARD(pUnit,Event)
local x = pUnit:GetX()
local y = pUnit:GetY()
pUnit:SpawnCreature(2621, x-math.random(1,6), y-math.random(1,6), pUnit:GetZ(), pUnit:GetO(), 29, 45000)
end

function PVPARATHI.VAR.FACTIONCHAMPIONHORDE_DEAD(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	PVPARATHI[id] = PVPARATHI[id] or {VAR={}}
pUnit:RemoveEvents()
PVPARATHI[id].VAR.ALLIANCECHAMP:RegisterEvent("PVPARATHI.VAR.DESPAWNCHAMPIONS_EVENTOVER", 500, 1)
for place, plrs in pairs(GetPlayersInZone(45)) do
local race = plrs:GetPlayerRace()
if race == 2 or race == 5 or race == 6 or race == 8 or race == 10 then
plrs:SendAreaTriggerMessage("Your Grand Champion is has been slain.")
else
plrs:SendAreaTriggerMessage("The Alliance's Grand Champion has been slain, the Horde is victorious!.")
end
plrs:PlaySoundToPlayer(9376)
end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 100 then
  local race = players:GetPlayerRace()
if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
players:GiveHonor(1200)
players:SendBroadcastMessage("You have been rewarded 1200 honor.")
end
end
end
end


RegisterUnitEvent(447984, 1, "PVPARATHI.VAR.FACTIONCHAMPIONHORDE_COMBAT")
--RegisterUnitEvent(447984, 3, "PVPARATHI.VAR.FACTIONCHAMPIONHORDE_KILL")
RegisterUnitEvent(447984, 2,"PVPARATHI.VAR.LEAVE")
RegisterUnitEvent(447984, 4, "PVPARATHI.VAR.FACTIONCHAMPIONHORDE_DEAD")


--[[guards]]--

function RefugeGuardSpawn(pUnit,Event)
pUnit:EquipWeapons(2488,9974,0)
end

RegisterUnitEvent(10696, 18,"RefugeGuardSpawn")

function HammerfallSpawn(pUnit,Event)
pUnit:EquipWeapons(15234,10767,0)
	if pUnit:GetEntry() == 497005 then
	pUnit:SetFaction(1857)
	else
	pUnit:SetFaction(29)
	end
end

RegisterUnitEvent(2621, 18,"HammerfallSpawn")
RegisterUnitEvent(497005, 18,"HammerfallSpawn")