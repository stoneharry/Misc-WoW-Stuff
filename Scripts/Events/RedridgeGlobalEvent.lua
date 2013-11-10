
--[[

AKD = {}
AKD.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000


--74633 WORLD BOSS ID
-- 89190 DUMMY SPAWNER
-- 74634 STONEWATCH CRYSTAL. IF DESTROYED, PLAYERS LOSE.
--8173 soundid capture good
--8174 CRYSTAL IS IN TROUBLE
--8213 FAILED.
-- Earthen Wardstone 74635
-- Earthen Invader 74636


local START_EVENTz = "#debugboss"
local i = 0
local b = 0
]]
--[[

function AKD.VAR.BossSpawnDummy_OnSpawn(pUnit,Event)
	if id == nil then id = 1 end
	AKD[id] = AKD[id] or {VAR={}}
	AKD[id].VAR.Bossspawner = pUnit
end

RegisterUnitEvent(89190, 18, "AKD.VAR.BossSpawnDummy_OnSpawn")



function AKD.VAR.StonewatchCrystal_OnSpawn(pUnit,Event)
pUnit:Root()
pUnit:SetCombatTargetingCapable(false)
pUnit:SetCombatCapable(false)
pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
end


RegisterUnitEvent(74634, 18, "AKD.VAR.StonewatchCrystal_OnSpawn")


function AKD.VAR.BaseSpawn_OnSpawn(pUnit,Event)
local x = pUnit:GetX()
 local y = pUnit:GetY()
 local z = pUnit:GetZ()
 local o = pUnit:GetO()
pUnit:SpawnCreature(74637, x+math.random(4,6), y+math.random(4,6), z, o, 14, 0)
pUnit:SpawnCreature(74637, x-math.random(4,6), y-math.random(4,6), z, o, 14, 0)
pUnit:SpawnCreature(74637, x+math.random(1,3), y+math.random(1,3), z, o, 14, 0)
pUnit:SpawnCreature(74637, x-math.random(1,3), y-math.random(1,3), z, o, 14, 0)
pUnit:Root()
pUnit:SetCombatTargetingCapable(false)
pUnit:SetCombatCapable(false)
pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
end


RegisterUnitEvent(74635, 18, "AKD.VAR.BaseSpawn_OnSpawn")


function AKD.VAR.ZoneInvaderRR_OnSpawn(pUnit,Event)
pUnit:SetMovementFlags(1)
pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
pUnit:RegisterEvent("AKD.VAR.Invaders_Moveto",2000,1)
end


RegisterUnitEvent(74636, 18, "AKD.VAR.ZoneInvaderRR_OnSpawn")


function AKD.VAR.ZoneProtRR_OnSpawn(pUnit,Event)
pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
end


RegisterUnitEvent(74637, 18, "AKD.VAR.ZoneProtRR_OnSpawn")


function AKD.VAR.Invaders_Moveto(pUnit,Event)
pUnit:MoveTo(-9374.29, -3017.72, 136.687, 3.11)
end

function AKD.VAR.BossSpawn_OnSpawn(pUnit,Event)
	if id == nil then
		id = 1
	end
	AKD[id] = AKD[id] or {VAR={}}
	AKD[id].VAR.AKIDIA = pUnit
	AKD[id].VAR.Bossspawner:SpawnCreature(74634 ,-9374.29, -3017.72, 136.687, 3.11, 1857, 0)
	AKD[id].VAR.Bossspawner:SpawnCreature(74635 ,-9228.59, -2957.47, 113.05, 0.51, 16, 0)
	AKD[id].VAR.Bossspawner:SpawnCreature(74635 ,-9303.84, -3057.65, 124.80, 2.60, 16, 0)
	AKD[id].VAR.Bossspawner:SpawnCreature(74635 ,-9269.09, -2828.88, 88.71, 1.36, 16, 0)
	AKD[id].VAR.Bossspawner:SpawnCreature(74635 ,-9228.68, -3113.93, 108.76, 4.3, 16, 0)
	AKD[id].VAR.Bossspawner:SpawnCreature(74635 ,-9122.28, -2698.10, 90.15, 3.33, 16, 0)
	AKD[id].VAR.Bossspawner:SpawnCreature(74635 ,-9117.43, -3049.96, 109.63, 5.35, 16, 0)
	AKD[id].VAR.Bossspawner:SpawnCreature(74639 ,-9169.22, -3015.98, 93.89, 2.88, 16, 0)
	AKD[id].VAR.Bossspawner:SpawnCreature(74639 ,-9417.08, -3144.63, 78.41, 6.28, 16, 0)
	AKD[id].VAR.Bossspawner:SpawnCreature(74639 ,-9391.14, -2946.06, 70.179, 0.09, 16, 0)
	b = 1
	local plrs = GetPlayersInZone(44)
	if type(plrs) == "table" then
		for place, plrs in pairs(plrs) do
			AKD[id].VAR.AKIDIA:SendChatMessageToPlayer(14, 0, "For too long has the Plane of Earth stood silent! Redridge will be ours once again, Stonewatch will fall!", plrs)
			AKD[id].VAR.AKIDIA:SendChatMessageToPlayer(42, 0, "Akidia has appeared at Alther's Mill.", plrs)
			if not plrs:HasQuest(2984) then
				plrs:StartQuest(2984) -- make this universal every time akidia spawns
			end
			plrs:PlaySoundToPlayer(13363)
		end
	end
end


RegisterUnitEvent(74633, 18, "AKD.VAR.BossSpawn_OnSpawn")


function AKD.VAR.EGladiator_OnSpawn(pUnit,Event)
pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
end


RegisterUnitEvent(74639, 18, "AKD.VAR.EGladiator_OnSpawn")

function AKD.VAR.Checking_For_ZoneBoss(pUnit,Event)
if i == 1 then
pUnit:Despawn(1,0)
end
end

function AKD.VAR.UPDATE_SPAWN_BOSS(pUnit,Event)
	if id == nil then id = 1 end
	AKD[id] = AKD[id] or {VAR={}}
	i = 0
	if AKD[id].VAR.Bossspawner ~= nil then
		AKD[id].VAR.Bossspawner:RegisterEvent("AKD.VAR.Spawn_WorldBossRR",15000,1)
		local plrs = GetPlayersInZone(44)
		if type(plrs) == "table" then
			for place, plrs in pairs(plrs) do
				AKD[id].VAR.Bossspawner:SendChatMessageToPlayer(42, 0, "You feel a rumbling sensation from the ground.", plrs)
				plrs:PlaySoundToPlayer(7197)
				plrs:CastSpell(69235)
			end
		end
	end
end

function AKD.VAR.Spawn_WorldBossRR(pUnit,Event)
	if id == nil then id = 1 end
	AKD[id] = AKD[id] or {VAR={}}
	AKD[id].VAR.Bossspawner:SpawnCreature(74633 ,-9195.50, -2734.27, 88.80, 5.1, 14, 0)
	AKD[id].VAR.Bossspawner:RegisterEvent("AKD.VAR.SpawnInvaders",20000,0)
	local plrs = GetPlayersInZone(44)
	if type(plrs) == "table" then
		for place, plrs in pairs(plrs) do
			plrs:SendBroadcastMessage("|cffffff00Akidia has spawned at Alther's Mill in Redridge.|r")
		end
	end
end

function AKD.VAR.SpawnInvaders(pUnit,Event)
	if id == nil then id = 1 end
	AKD[id] = AKD[id] or {VAR={}}
	if AKD[id].VAR.AKIDIA ~= nil then
		if AKD[id].VAR.AKIDIA:IsDead() == false then
			AKD[id].VAR.Bossspawner:SpawnCreature(74636 ,-9323.76, -3024.15, 132.63, 2.96, 14, 0)
			AKD[id].VAR.Bossspawner:SpawnCreature(74636 ,-9324.59, -3028.74, 132.67, 2.96, 14, 0)
			AKD[id].VAR.Bossspawner:SpawnCreature(74636 ,-9323.29, -3034.43, 132.92, 2.94, 14, 0)
		end
	end
end

]]




--[[
function FixatePrepareEtc(pUnit,Event)
	if id == nil then id = 1 end
	AKD[id] = AKD[id] or {VAR={}}
	pUnit:RemoveEvents()
	AKD[id].VAR.FixatedTarget = pUnit:GetRandomPlayer(0)
	if pUnit:GetDistanceYards(AKD[id].VAR.FixatedTarget) < 30 then
		local name = AKD[id].VAR.FixatedTarget:GetName()
		pUnit:SendChatMessageToPlayer(42,0,"Stop Casting!", AKD[id].VAR.FixatedTarget)
		pUnit:CastSpellOnTarget(67823,AKD[id].VAR.FixatedTarget)
		pUnit:RegisterEvent("AKD.VAR.Fixate_Casting",1000,0)
		pUnit:RegisterEvent("AKD.VAR.StoppedFixating",8000,1)
		pUnit:RegisterEvent("AKD.VAR.Akidia_Poisonbolt",math.random(10000,14000),0)
		pUnit:RegisterEvent("AKD.VAR.Akidia_GroundTremor",math.random(8000,12000),0)
		pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
		local PlayersAllAround = pUnit:GetInRangePlayers()
		for a, players in pairs(PlayersAllAround) do
			if pUnit:GetDistanceYards(players) < 50 then
				pUnit:SendChatMessageToPlayer(42,0,"Akidia begins Fixating on "..name.."", players)
			else
				AKD[id].VAR.FixatedTarget = nil
				pUnit:RegisterEvent("FixatePrepareEtc",1000,1)
			end
		end
	end
end

function AKD.VAR.Akidia_OnCombat(pUnit,Event)
pUnit:RegisterEvent("FixatePrepareEtc",20000,1)
pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
pUnit:RegisterEvent("AKD.VAR.Akidia_Poisonbolt",math.random(10000,14000),0)
pUnit:RegisterEvent("AKD.VAR.Akidia_GroundTremor",math.random(8000,12000),0)
end


function AKD.VAR.Akidia_GroundTremor(pUnit,Event)
pUnit:CastSpell(6524)
end

function AKD.VAR.Akidia_Poisonbolt(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 40 then
			players:RemoveAura(21067)
			pUnit:CastSpellOnTarget(21067, players)
		end
	end
end

function AKD.VAR.Fixate_Casting(pUnit,Event)
	if id == nil then id = 1 end
	AKD[id] = AKD[id] or {VAR={}}
	if AKD[id].VAR.FixatedTarget ~= nil then
		if AKD[id].VAR.FixatedTarget:GetCurrentSpellId() ~= nil then
			pUnit:CastSpellOnTarget(68101, AKD[id].VAR.FixatedTarget)
			AKD[id].VAR.FixatedTarget = nil
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("FixatePrepareEtc",20000,1)
			pUnit:RegisterEvent("AKD.VAR.Akidia_Poisonbolt",math.random(10000,14000),0)
			pUnit:RegisterEvent("AKD.VAR.Akidia_GroundTremor",math.random(8000,12000),0)
			pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
		end
	end
end

function AKD.VAR.StoppedFixating(pUnit,Event)
if id == nil then id = 1 end
	AKD[id] = AKD[id] or {VAR={}}
	pUnit:RemoveEvents()
	AKD[id].VAR.FixatedTarget = nil
	pUnit:RegisterEvent("FixatePrepareEtc",20000,1)
	pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
	pUnit:RegisterEvent("AKD.VAR.Akidia_Poisonbolt",math.random(10000,14000),0)
	pUnit:RegisterEvent("AKD.VAR.Akidia_GroundTremor",math.random(8000,12000),0)
end


function AKD.VAR.Akidia_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
end

----boss---
function AKD.VAR.Akidia_OnDead(pUnit,Event)
	if id == nil then id = 1 end
	AKD[id] = AKD[id] or {VAR={}}
	pUnit:RemoveEvents()
	AKD[id].VAR.Bossspawner:Despawn(1000,3000)
	AKD[id].VAR.Bossspawner:RemoveEvents()
	CreateLuaEvent(AKD.VAR.UPDATE_SPAWN_BOSS, 3600000 , 1)
	i = 1
	b = 0
	local plrs = GetPlayersInZone(44)
	if type(plrs) == "table" then
		for place, plrs in pairs(plrs) do
			pUnit:SendChatMessageToPlayer(42, 0, "Akidia has been Defeated! Stonewatch is safe once again!", plrs)
			plrs:PlaySoundToPlayer(8454)
			plrs:FinishQuest(2984)
			if plrs:HasAchievement(59386) == false then
				plrs:AddAchievement(59386)
			end
			plrs:AddItem(32569,8)
			if pUnit:GetDistanceYards(plrs) < 60 then
				plrs:AddItem(32569,2)
				if plrs:HasAchievement(59385) == false then
					plrs:AddAchievement(59385)
				end
			end
		end
	end
end

 RegisterUnitEvent(74633, 1, "AKD.VAR.Akidia_OnCombat")
RegisterUnitEvent(74633, 2, "AKD.VAR.Akidia_OnLeave")
RegisterUnitEvent(74633, 4, "AKD.VAR.Akidia_OnDead")
]]
--[[
function AKD.VAR.StoneCrystal_OnDead(pUnit,Event)
	if id == nil then id = 1 end
	AKD[id] = AKD[id] or {VAR={}}
	pUnit:RemoveEvents()
	AKD[id].VAR.Bossspawner:RemoveEvents()
	AKD[id].VAR.AKIDIA:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
	i = 1
	b = 0
	CreateLuaEvent(AKD.VAR.UPDATE_SPAWN_BOSS, 3600000 , 1)
	local plrs = GetPlayersInZone(44)
	if type(plrs) == "table" then
		for place, plrs in pairs(plrs) do
			AKD[id].VAR.AKIDIA:SendChatMessageToPlayer(14, 0, "Redridge now belongs to the plane of earth! Bow before your new masters!", plrs)
			pUnit:SendChatMessageToPlayer(42, 0, "The forces of Stonewatch have been defeated, Redridge has fallen!", plrs)
			plrs:PlaySoundToPlayer(8213)
		end
	end
end


RegisterUnitEvent(74634, 4, "AKD.VAR.StoneCrystal_OnDead")


function InvRendStuff(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target ~= nil then
		if pUnit:GetDistanceYards(target) < 5 then
			pUnit:CastSpellOnTarget(772,target)
		end
	end
end


function AKD.VAR.InvaderEarth_OnCombat(pUnit,Event)
	if pUnit:GetDisplay() == 21234 then
		pUnit:RegisterEvent("InvRendStuff",9000,0)
		pUnit:RegisterEvent("InvaderEarth_Sunder",5000,0)
	elseif pUnit:GetDisplay() == 171 then
		pUnit:RegisterEvent("InvaderEarth_Earthshock",6000,0)
	elseif pUnit:GetDisplay() == 11010 then
		pUnit:RegisterEvent("InvaderEarth_Acidic",8000,0)
	end
end

function InvaderEarth_Earthshock(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target ~= nil then
		if pUnit:GetDistanceYards(target) < 12 then
			pUnit:CastSpellOnTarget(8044,target)
		end
	end
end

function InvaderEarth_Acidic(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target ~= nil then
		if pUnit:GetDistanceYards(target) < 5 then
			pUnit:CastSpellOnTarget(18070,target)
		end
	end
end

function InvaderEarth_Sunder(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target ~= nil then
		if pUnit:GetDistanceYards(target) < 5 then
			pUnit:CastSpellOnTarget(7386,target)
		end
	end
end

function AKD.VAR.InvaderEarth_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
end

RegisterUnitEvent(74636, 2, "AKD.VAR.InvaderEarth_OnLeave")
RegisterUnitEvent(74636, 1, "AKD.VAR.InvaderEarth_OnCombat")
RegisterUnitEvent(74637, 1, "AKD.VAR.InvaderEarth_OnCombat")


function AKD.VAR.EGladiator_OnCombat(pUnit,Event)
pUnit:RegisterEvent("Knockback_players",10000,0)
end

function Knockback_players(pUnit,Event)
pUnit:CastSpell(8732)
pUnit:CastSpell(55563)
end

function AKD.VAR.EGladiator_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("AKD.VAR.Checking_For_ZoneBoss",1000,0)
end

RegisterUnitEvent(74639, 2, "AKD.VAR.EGladiator_OnLeave")
RegisterUnitEvent(74639, 1, "AKD.VAR.EGladiator_OnCombat")


------------

--------

function AKD.VAR.EarthBase_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 75 then
			players:AddItem(32569,1)
		end
	end
end
RegisterUnitEvent(74635, 4, "AKD.VAR.EarthBase_OnDead")


function AKD.VAR.eGladiator_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 75 then
			players:AddItem(32569,3)
		end
	end
end

RegisterUnitEvent(74639, 4, "AKD.VAR.eGladiator_OnDead")

function AKD.VAR.PlayerEntersZoneIsLate(event, pPlayer, zoneId)
	if b == 1 then
		if pPlayer:GetZoneId() == 44 then
			if pPlayer:HasQuest(2984) == false then
				if pPlayer:HasFinishedQuest(2984) == false then
					pPlayer:StartQuest(2984)
				end
			end
		end
	end
end


--CreateLuaEvent(AKD.VAR.UPDATE_SPAWN_BOSS, 360000, 1)
RegisterServerHook(15, "AKD.VAR.PlayerEntersZoneIsLate")
]]
