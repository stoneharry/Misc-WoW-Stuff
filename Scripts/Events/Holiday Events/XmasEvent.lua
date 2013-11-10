--[[--DISABLED UNTIL XMAS
XMAS = {}
XMAS.VAR = {}
]]

--[[
WEATHER EFFECTS
0, // NORMAL (SUNNY)
1, // FOG
2, // RAIN
4, // HEAVY_RAIN
8, // SNOW
16 // SANDSTORM


===BOSS==
Phase 1 - Spawns Exploding Clockgnomes(explodes on nearby player)
--Spawns little helpers(act as adds)
SNOWBALL -- decks a random player in the face with a magical snowball, pacifying the player and turning the player into a snowman.

]]

--[[
function XMAS.VAR.XMASOnEnterZone(event, pPlayer, ZoneId, OldZoneId)
if pPlayer:GetAreaId() == 796 then
pPlayer:SetZoneWeather(796, 8, 1000)
pPlayer:SetPlayerWeather(8, 1000)
end
end

RegisterServerHook(15, "XMAS.VAR.XMASOnEnterZone")


function XMAS.VAR.TickingPresent_Spawn(pUnit,Event)
local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		if plr:IsDead() == false then
			if pUnit:GetDistanceYards(plr) < 40 then
			local name = plr:GetName()
		pUnit:SendChatMessage(42,0,"The Ticking Present is following "..name.."")
		pUnit:ChangeTarget(plr) 
		pUnit:ModThreat(plr, 100000)
		pUnit:DisableTargeting(true) 
		pUnit:SetUnitToFollow(plr, 1, 2) 
		pUnit:SetUnitToFollow(plr, 1, 1) 
		pUnit:MoveTo(plr:GetX(),plr:GetY(),plr:GetZ(),plr:GetO())
			end
		end
	end
pUnit:RegisterEvent("XMAS.VAR.LOOKINGFORPLAYER_TP",1000,0) 
end


RegisterUnitEvent(43877,18, "XMAS.VAR.TickingPresent_Spawn") -- one needs a ID



function XMAS.VAR.LOOKINGFORPLAYER_TP(pUnit,Event)
local enemy = pUnit:GetClosestEnemy()
if enemy ~= nil then
if enemy:IsDead() == false then
local EnemiesAllAround = pUnit:GetInRangeEnemies()
  for a, enemies in pairs(EnemiesAllAround) do
if pUnit:GetDistanceYards(enemies) < 5 then
pUnit:RemoveEvents()
pUnit:CastSpell(46419)
pUnit:Kill(enemies)
pUnit:Despawn(2500,0)
pUnit:RegisterEvent("XMAS.VAR.KILLUNIT",100,1) 
			end
		end
	end
end
end

function XMAS.VAR.KILLUNIT(pUnit,Event)
pUnit:Kill(pUnit)
end

function XMAS.VAR.SPAWNTICKINGPRESENT(pUnit,Event)
pUnit:SpawnCreature(43877, pUnit:GetX()+math.random(8,16), pUnit:GetY()+math.random(8,16), pUnit:GetZ(), pUnit:GetO(), 14, 60000) -- local for events to be added.
end

function XMAS.VAR.SNOWBALL(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	XMAS[id] = XMAS[id] or {VAR={}}
	if XMAS[id].VAR.SNOWBALLED == nil then
		XMAS[id].VAR.SNOWBALLED = pUnit:GetRandomPlayer(0)
		if XMAS[id].VAR.SNOWBALLED ~= nil then
			pUnit:CastSpellOnTarget(46661, DM[id].VAR.SNOWBALLED) -- SNOWBALL VISUAL
			   XMAS[id].VAR.SNOWBALLED:DisableSpells(1)
			   XMAS[id].VAR.SNOWBALLED:SetPlayerLock(1)
   XMAS[id].VAR.SNOWBALLED:Root()
    XMAS[id].VAR.SNOWBALLED:SetModel(13730)
			pUnit:RegisterEvent("XMAS.VAR.REMOVESNOWBALLED", 10000, 0)
		end
	else
		XMAS[id].VAR.SNOWBALLED = nil
		XMAS[id].VAR.SNOWBALLED = pUnit:GetRandomPlayer(0)
		if XMAS[id].VAR.SNOWBALLED ~= nil then
			pUnit:CastSpellOnTarget(46661,XMAS[id].SNOWBALLED)
			   XMAS[id].VAR.SNOWBALLED:DisableSpells(1)
			   XMAS[id].VAR.SNOWBALLED:SetPlayerLock(1)
   XMAS[id].VAR.SNOWBALLED:Root()
   XMAS[id].VAR.SNOWBALLED:SetModel(13730)
			pUnit:RegisterEvent("XMAS.VAR.REMOVESNOWBALLED", 10000, 0)
		end
	end
end

function XMAS.VAR.REMOVESNOWBALLED(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	XMAS[id] = XMAS[id] or {VAR={}}
	if XMAS[id].VAR.SNOWBALLED ~= nil then
   XMAS[id].VAR.SNOWBALLED:DisableSpells(0)
   XMAS[id].VAR.SNOWBALLED:SetPlayerLock(0)
   XMAS[id].VAR.SNOWBALLED:Unroot()
  XMAS[id].VAR.SNOWBALLED:DeMorph()
			end
	end

	function XMAS.VAR.GREATFATHER_COMBAT(pUnit,Event)
		pUnit:SendChatMessage(14,0,"You've all been very naughty!")
		pUnit:RegisterEvent("XMAS.VAR.SNOWBALL", 23000, 0)
		pUnit:RegisterEvent("XMAS.VAR.SPAWNTICKINGPRESENT", 14000, 0)
		pUnit:RegisterEvent("XMAS.VAR.GREATFATHER_COC", 8000, 0)
	end
	
	function XMAS.VAR.GREATFATHER_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Despawn(2000,4000)
	for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 43877 then 
	creatures:Despawn(1,0)
	end
	end
	end
	
		function XMAS.VAR.GREATFATHER_SLAY(pUnit,Event)
			pUnit:SendChatMessage(14,0,"HO..HO..HO!")
	end
	
	function XMAS.VAR.GREATFATHER_COC(pUnit,Event)
	pUnit:CastSpell(10161)
	end
	
	
	function XMAS.VAR.GREATFATHER_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	for k,players in pairs(pUnit:GetInRangePlayers()) do
	if players:HasTitle(102) == false then
	players:SetKnownTitle(102)
	end
	end
	end
	
	
	
	RegisterUnitEvent(98532, 1, "XMAS.VAR.GREATFATHER_COMBAT")
RegisterUnitEvent(98532, 2, "XMAS.VAR.GREATFATHER_LEAVE")
RegisterUnitEvent(98532, 4, "XMAS.VAR.GREATFATHER_DEAD")

function DUNGEONMASTER_OnClick(pUnit, event, player)
pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(0, "Send me to the Waygate", 250, 0)
	pUnit:GossipMenuAddItem(0, "...Nevermind.", 251, 0)
    pUnit:GossipSendMenu(player)
end

function DUNGEONMASTER_OnGossip(pUnit, event, player, id, intid, code)
if(intid == 250) then
player:GossipComplete()
player:Teleport(1, -6170.75, -1324.78, -172.36)
end
if(intid == 251) then
player:GossipComplete()
end
end
		
		
		
		RegisterUnitGossipEvent(44776, 1, "DUNGEONMASTER_OnClick")
RegisterUnitGossipEvent(44776, 2, "DUNGEONMASTER_OnGossip")]]