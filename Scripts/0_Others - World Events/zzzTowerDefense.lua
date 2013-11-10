
-- AoE Tower: Use Spell 66313 On Target
-- Phasing mobs
-- More bosses

local WaveList = {
--	{entry, bounty,	spawns}
	{17707, 1, 5}, --Dawnstone Crab
	{17707, 1, 10}, --Dawnstone Crab
	{17707, 1, 15}, --Dawnstone Crab
	{34165, 12, 1}, --Boss 1
	{135401, 1, 10}, --Elder Dawnstone Crab
	{70461, 2, 4}, --Shield Turtle
	{250081, 2, 3}, --Flying
	{70461, 1, 6}, --Shield Turtle
	{250081, 1, 6}, --Flying
	{70461, 1, 8}, --Shield Turtle
	{250081, 1, 8}, --Flying
	{135401, 1, 15}, --Elder Dawnstone Crab
	{17707, 1, 25}, --Dawnstone Crab
	{250081, 1, 8}, --Flying
	{109921, 10, 1}, --Boss 2
	{101831, 1, 2},  --Flying Lizards
	{101831, 1, 3},  --Flying Lizards
	{17707, 0, 100}, -- Dawnstone crab
	{70461, 1, 20}, --Shield Turtle
	{70461, 1, 50}, --Shield Turtle
	{70461, 1, 75}, --Shield Turtle
	{101831, 1, 6},  --Flying Lizards
	{34165, 1, 10},
	{135401, 0, 30},
	{250081, 1, 20},
	{70461, 1, 100},
	{101831, 0, 1}
	--Last wave repeats with (spawns * wavenum) spawns.
}

local runcoords = {
	{2846.48, 913.36, 0.1, 0},
	{2822.08, 913.5, 0.1, 0},
	{2822.47, 919.3, 0.1, 0},
	{2846.5, 919.5, 0.1, 0},
	{2846.6, 925, 0.1, 0},
	{2822.1, 925.1, 0.1, 0},
	{2822.3, 931, 0.1, 0},
	{2846.68, 931.66, 0.1, 0},
	{2846.73, 943.3, 0.1, 0}
}
local runcoords2 = {}
local flyingcoords = {
	{2847, 910, 5.6, 0},
	{2847.1, 937, 5, 0},
	{2846.73, 943.3, 0.1, 0}
}
local flyingcoords2 = {}

SetDBCSpellVar(55811, "Effect", 0, 0)

local running = false
local waverunning = false
local waveentry = 100
local shieldvalue = 100
local wavenum = 1
local resources = 20
local upvalue = 1
local creepsLeft = 0
local FuckingPlayer = nil

local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3
local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 -- Size: 1, Type: BYTES, Flags: PUBLIC

-- Mob running + despawning + damage to shield

function Fill_runcoords2(player)
	for i = 1, (#runcoords) do
		if (runcoords2[i]) then runcoords2[i]:Despawn(1, 0); end
		runcoords2[i] = player:SpawnCreature(135400, runcoords[i][1], runcoords[i][2], runcoords[i][3], 0, 35, 3600000)
	end
end
function Fill_flyingcoords2(player)
	for i = 1, (#flyingcoords) do
		if (flyingcoords2[i]) then flyingcoords2[i]:Despawn(1, 0); end
		flyingcoords2[i] = player:SpawnCreature(135400, flyingcoords[i][1], flyingcoords[i][2], flyingcoords[i][3], 0, 35, 3600000)
	end
end

function Mob_PathFind(pUnit)
	if (not pUnit:IsAlive()) then return; end
	local cp = pUnit:GetValue("TD_NextPoint")
	local flying = pUnit:GetValue("TD_IsFlying")
	local cps
	if (flying) then
		cps = flyingcoords2
	else
		cps = runcoords2
	end
	if not cps[cp] then
		return
	end
	local x, y, z = cps[cp]:GetLocation()
	local dist = pUnit:CalcToDistance(x, y, z)
	if (dist < 3 and cp == (#cps)) then
		creepsLeft = creepsLeft - 1
		shieldvalue = shieldvalue - 5
		if (shieldvalue < 1) then shieldvalue = 0; end
		for _, player in pairs (pUnit:GetInRangePlayers()) do
			UpdateAttempts(player, shieldvalue)
		end
		pUnit:RemoveEvents()
		pUnit:Despawn(100, 0)
	elseif (dist < 2) then
		cp = cp + 1
		pUnit:SetValue("TD_NextPoint", cp)
		pUnit:SetUnitToFollow(cps[cp], 0, 0)
	end
end

function Mob_SpawnEventHandle(pUnit, Event)
	pUnit:RegisterEvent("Mob_MoveAtRandom", 200, 1)
	if pUnit:GetEntry() == 109921 then
		pUnit:RegisterEvent("Boss2Visuals_Tower", 1000, 1)
		for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			plrs:CastSpell(50224) -- zombie vision
		end
	end
end

function Mob_MoveAtRandom(pUnit)
	pUnit:SetValue("TD_NextPoint", 1)
	pUnit:SetValue("TD_IsFlying", false)
	pUnit:SetCombatCapable(true)
	pUnit:SetCombatTargetingCapable(true)
	pUnit:AIDisableCombat(true)
	pUnit:SetMovementFlags(1)
	pUnit:SetUnitToFollow(runcoords2[1])
	pUnit:RegisterEvent("Mob_PathFind", 500, 0)
end

RegisterUnitEvent(17707, 18, "Mob_SpawnEventHandle")
RegisterUnitEvent(34165, 18, "Mob_SpawnEventHandle")
RegisterUnitEvent(135401, 18, "Mob_SpawnEventHandle")
RegisterUnitEvent(70461, 18, "Mob_SpawnEventHandle")
RegisterUnitEvent(109921, 18, "Mob_SpawnEventHandle")

function DiabloBosssDeath_Tower(pUnit, Event)
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		plrs:RemoveAura(50224) -- zombie vision
	end
end

RegisterUnitEvent(109921, 4, "DiabloBosssDeath_Tower")

function FlyingMob_SpawnEventHandle(pUnit, Event)
	pUnit:RegisterEvent("FlyingMob_MoveAtRandom", 200, 1)
end

function FlyingMob_MoveAtRandom(pUnit)
	pUnit:SetValue("TD_NextPoint", 1)
	pUnit:SetValue("TD_IsFlying", true)
	pUnit:SetCombatCapable(true)
	pUnit:SetCombatTargetingCapable(true)
	pUnit:AIDisableCombat(true)
	pUnit:SetMovementFlags(2)
	pUnit:SetFlying()
	pUnit:SetUnitToFollow(flyingcoords2[1])
	pUnit:RegisterEvent("Mob_PathFind", 500, 0)
end

RegisterUnitEvent(250081, 18, "FlyingMob_SpawnEventHandle")
RegisterUnitEvent(101831, 18, "FlyingMob_SpawnEventHandle")

-- boss 2

function Boss2Visuals_Tower(pUnit)
	local x = math.random(2815,2853)
	local y = math.random(905,940)
	pUnit:CastSpellAoF(x,y,0,57467)
	pUnit:RegisterEvent("Boss2Visuals_Tower", math.random(100,1000), 1)
end

local function CanAttack(pUnit, target)
	local f1 = pUnit:GetValue("TD_target")
	local f2 = target:GetValue("TD_IsFlying")
	f2 = f2 and 2 or 1
	if (f1 == 3 or f1 == f2) then
		return true
	end
	return false
end
local function GetCreeps(pUnit, amt, distance)
	if (not pUnit) then return {}; end
	if (type(amt) ~= "number" or amt < 1) then amt = 1; end
	local targets = {}
	local i = 0
	for _, unit in pairs (pUnit:GetInRangeUnits()) do
		if (unit:GetEntry() == waveentry and unit:IsAlive() and
		 CanAttack(pUnit, unit) and unit:GetDistanceYards(pUnit) < distance) then
			table.insert(targets, unit)
			i = i + 1
			if (i >= amt) then break; end
		end
	end
	return targets
end
local function TowerDmg(pUnit, dmg)
	if (dmg < pUnit:GetHealth()) then
		pUnit:SetHealth(pUnit:GetHealth() - dmg)
	else
		pUnit:Kill(pUnit)
	end
end

-- Rock Tower

function TowerOnSpawn(pUnit, Event)
	pUnit:SetValue("TD_target", 1)
	pUnit:SetScale(0.15)
	pUnit:RegisterEvent("Tower_DoDamage", 1500, 0)
end

function Tower_DoDamage(pUnit)
	for _, unit in pairs(GetCreeps(pUnit, 1, 8)) do
		-- when facing units, it turns too fast to play visuals
		--pUnit:SetPosition(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:CalcRadAngle(pUnit:GetX(), pUnit:GetY(), unit:GetX(), unit:GetY()))
		TowerDmg(unit, math.random(2000, 4000))
		pUnit:CastSpellOnTarget(55811, unit)
	end
end

RegisterUnitEvent(31229, 18, "TowerOnSpawn")

-- Upgrade Rock Tower

function TowerRock_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(4, "Rock Tower", 250, 0)
	pUnit:GossipMenuAddItem(4, "You have "..tostring(resources).." resources.", 250, 0)
	if pUnit:GetDisplay() == 8811 then
		pUnit:GossipMenuAddItem(4, "Upgrade to level 2 (0.5 seconds faster attack) (Costs 3)", 1, 0)
	elseif pUnit:GetDisplay() == 1461 then
		pUnit:GossipMenuAddItem(4, "Upgrade to level 3 (0.5 seconds faster attack) (Costs 3)", 2, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end


function TowerRock_Click(pUnit, event, player, id, intid, code)
	if intid == 1 then
		if resources < 3 then
			player:SendBroadcastMessage("Not enough resources!")
		else
			resources = resources - 3
			pUnit:RemoveEvents()
			pUnit:SetModel(1461)
			pUnit:RegisterEvent("Tower_DoDamage", 1000, 0)
		end
	elseif intid == 2 then
		if resources < 3 then
			player:SendBroadcastMessage("Not enough resources!")
		else
			resources = resources - 3
			pUnit:RemoveEvents()
			pUnit:SetModel(1460)
			pUnit:SetNPCFlags(2)
			pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
			pUnit:RegisterEvent("Tower_DoDamage", 500, 0)
		end
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(31229, 1, "TowerRock_Gossip")
RegisterUnitGossipEvent(31229, 2, "TowerRock_Click")

-- Ice Tower

function IceTowerSpawn(pUnit, Event)
	pUnit:SetValue("TD_target", 1)
	pUnit:RegisterEvent("IceLance_Slow_Units", 2000, 0)
end

function IceLance_Slow_Units(pUnit)
	local creeps = {}
	if (pUnit:HasAura(7742)) then creeps = GetCreeps(pUnit, 999, 8);
	else creeps = GetCreeps(pUnit, 1, 8);
	end
	for _, unit in pairs(creeps) do
		if (not pUnit:HasAura(7742)) then
			pUnit:ChannelSpell(63676, unit)
			pUnit:RegisterEvent("StopChannelIceTower", 1500, 1)
		end
		unit:CastSpell(26036) -- visual
		unit:CastSpell(15571) -- daze
		unit:SetValue("TD_SlowEffect", (os.clock() + 3))
		unit:RegisterEvent("Remove_Slow_Effect_Self", 3000, 1)
	end
end

function StopChannelIceTower(pUnit)
	pUnit:StopChannel()
end

function Remove_Slow_Effect_Self(unit)
	if (unit:GetValue("TD_SlowEffect") < os.clock()) then
		unit:RemoveAura(26036)
	end
end

RegisterUnitEvent(116592, 18, "IceTowerSpawn")

-- Upgrade Ice Tower

function TowerIce_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(4, "Ice Tower", 250, 0)
	pUnit:GossipMenuAddItem(4, "You have "..tostring(resources).." resources.", 250, 0)
	if not pUnit:HasAura(7742) then
		pUnit:GossipMenuAddItem(4, "Upgrade to level 2 (Area of Effect) (Costs 10)", 1, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end


function TowerIce_Click(pUnit, event, player, id, intid, code)
	if intid == 1 then
		if resources < 10 then
			player:SendBroadcastMessage("Not enough resources!")
		else
			resources = resources - 10
			pUnit:RemoveEvents()
			pUnit:CastSpell(7742)
			pUnit:StopChannel()
			pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
			pUnit:RegisterEvent("IceLance_Slow_Units", 1000, 0)
		end
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(116592, 1, "TowerIce_Gossip")
RegisterUnitGossipEvent(116592, 2, "TowerIce_Click")

-- Fire tower

function FireTower_Spawn(pUnit, Event)
	pUnit:SetValue("TD_target", 1)
	pUnit:RegisterEvent("FireTower_Damage", 5000, 0)
end

function FireTower_Damage(pUnit)
	local targets = pUnit:GetValue("TD_FireTargets")
	for k, unit in pairs(GetCreeps(pUnit, targets, 16)) do
		if (k == 1) then pUnit:Emote(37, 800); end
		local x, y, z = pUnit:GetLocation()
		pUnit:SetPosition(x, y, z, pUnit:CalcRadAngle(x, y, unit:GetX(), unit:GetY()))
		TowerDmg(unit, math.random(10000, 30000))
		pUnit:CastSpellOnTarget(74420, unit)
	end
end

RegisterUnitEvent(140512, 18, "FireTower_Spawn")

-- Fire tower upgrade

function TowerFire_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(4, "Fire Tower", 250, 0)
	pUnit:GossipMenuAddItem(4, "You have "..tostring(resources).." resources.", 250, 0)
	if not pUnit:HasAura(36006) then
		pUnit:GossipMenuAddItem(4, "Upgrade to level 2 (Hits 2 targets) (Costs 10)", 1, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end


function TowerFire_Click(pUnit, event, player, id, intid, code)
	if intid == 1 then
		if resources < 10 then
			player:SendBroadcastMessage("Not enough resources!")
		else
			resources = resources - 10
			pUnit:CastSpell(36006)
			pUnit:SetScale(1.2)
			pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
			pUnit:SetValue("TD_FireTargets", 2)
		end
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(140512, 1, "TowerFire_Gossip")
RegisterUnitGossipEvent(140512, 2, "TowerFire_Click")

-- Anti-Air Tower

function AntiAirTowerSpawn(pUnit, Event)
	pUnit:SetValue("TD_target", 2)
	pUnit:RegisterEvent("AntiAirTowerShoot", 1500, 0)
end

function AntiAirTowerShoot(pUnit)
	for _, unit in pairs(GetCreeps(pUnit, 1, 15)) do
		local x, y, z = pUnit:GetLocation()
		pUnit:SetPosition(x, y, z, pUnit:CalcRadAngle(x, y, unit:GetX(), unit:GetY()))
		TowerDmg(unit, math.random(10, 20))
		pUnit:CastSpellOnTarget(61647, unit) -- shoot bow
	end
end

RegisterUnitEvent(485211, 18, "AntiAirTowerSpawn")

-- Anti-Air Tower Upgrade

function TowerAir_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(4, "Anti-Air Tower", 250, 0)
	pUnit:GossipMenuAddItem(4, "You have "..tostring(resources).." resources.", 250, 0)
	if pUnit:GetDisplay() == 4852 then
		pUnit:GossipMenuAddItem(4, "Upgrade to level 2 (0.5 seconds faster attack) (Costs 3)", 1, 0)
	elseif pUnit:GetDisplay() == 4851 then
		pUnit:GossipMenuAddItem(4, "Upgrade to level 3 (0.5 seconds faster attack) (Costs 3)", 2, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end


function TowerAir_Click(pUnit, event, player, id, intid, code)
	if intid == 1 then
		if resources < 3 then
			player:SendBroadcastMessage("Not enough resources!")
		else
			resources = resources - 3
			pUnit:RemoveEvents()
			pUnit:SetModel(4851)
			pUnit:RegisterEvent("AntiAirTowerShoot", 1000, 0)
		end
	elseif intid == 2 then
		if resources < 3 then
			player:SendBroadcastMessage("Not enough resources!")
		else
			resources = resources - 3
			pUnit:RemoveEvents()
			pUnit:SetModel(4849)
			pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
			pUnit:RegisterEvent("AntiAirTowerShoot", 500, 0)
		end
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(485211, 1, "TowerAir_Gossip")
RegisterUnitGossipEvent(485211, 2, "TowerAir_Click")

-- Gossip

function towerdefenseclick(item, event, player)
	showmenutowerdefense(item, player)
end

function showmenutowerdefense(item, player)
	item:GossipCreateMenu(1, player, 0)
	if not running then
		item:GossipMenuAddItem(4, "|cff3060B5Start The Event.|r", 5, 0)
	else
		item:GossipMenuAddItem(4, "You have "..tostring(resources).." resources.", 98, 0)
		if not waverunning then
			item:GossipMenuAddItem(4, "Start wave "..tostring(wavenum)..".", 7, 0)
		end
		item:GossipMenuAddItem(4, "Spawn a Rock Tower at the nearest block (Cost 10).", 8, 0)
		if wavenum > 1 then
			item:GossipMenuAddItem(4, "Spawn a Ice Tower at the nearest block (Cost 10).", 10, 0)
		end
		if wavenum > 4 then
			item:GossipMenuAddItem(4, "Spawn a Fire Tower at the nearest block (Cost 15).", 9, 0)
		end
		if wavenum > 6 then
			item:GossipMenuAddItem(4, "Spawn a Anti-Air Tower at the nearest block (Cost 5).", 11, 0)
		end
		item:GossipMenuAddItem(4, "Exit The Event.", 6, 0)
	end
	item:GossipMenuAddItem(0, "Nevermind.", 99, 0)
	item:GossipSendMenu(player)
end

function showconfirmed(item, player)
	item:GossipCreateMenu(1, player, 0)
	if running then
		item:GossipMenuAddItem(4, "Spawned Tower!", 98, 0)
		item:GossipMenuAddItem(4, "Return to main menu.", 98, 0)
	end
	item:GossipSendMenu(player)
end

function SpawnWaveCreature()
	FuckingPlayer:SpawnCreature(waveentry, 2846.7, 901.96, 0, 1.561545, 35, 0)
end
local function CanPlaceTower(object)
	local x, y, z = object:GetLocation()
	for _, units in pairs(object:GetInRangeUnits()) do
		if (units:GetObjectType() ~= "Player" and units:CalcToDistance(x, y, z) < 0.6) then
			return false
		end
	end
	return true
end

function towerdefesneselect(item, event, player, id, intid, code)
	if intid == 5 then
		shieldvalue = 100
		resources = 20
		running = true
		player:SendBroadcastMessage("The event has started, you can now place towers.")
		UpdateWorldstatesUI(player)
		UpdateAttempts(player, shieldvalue)
		showmenutowerdefense(item, player)
		Fill_runcoords2(player)
		Fill_flyingcoords2(player)
	elseif intid == 6 then
		wavenum = 1
		resources = 0
		shieldvalue = 0
		running = false
		waverunning = false
		for _,unit in pairs(player:GetInRangeUnits()) do
			if unit:GetEntry() ~= 32298 then
				unit:RemoveEvents()
				unit:Despawn(1,0)
			end
		end
		for _, plr in pairs(player:GetInRangePlayers()) do
			ResetWorldstatesUI(plr)
		end
		player:GossipComplete()
	elseif intid == 7 then
		if not waverunning then
			waverunning = true
			local wavenum2 = wavenum
			local mult = 1
			if (wavenum2 >= #WaveList) then
				wavenum2 = #WaveList
				mult = wavenum
			end
			waveentry = WaveList[wavenum2][1]
			upvalue = WaveList[wavenum2][2]
			local numSpawns = math.floor(WaveList[wavenum2][3] * mult)
			creepsLeft = numSpawns
			FuckingPlayer = player
			for i = 1, numSpawns do
				CreateLuaEvent(SpawnWaveCreature, (350 * i), 1)
			end		
		end
		player:GossipComplete()
	elseif intid == 8 then
		local object = player:GetGameObjectNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 185301)
		if (object == nil or player:CalcToDistance(object:GetLocation()) > 1.5) then
			player:SendBroadcastMessage("No nearby block found!")
			showmenutowerdefense(item, player)
		elseif (CanPlaceTower(object)) then
			if resources > 9 then
				resources = resources - 10
				player:SpawnCreature(31229, object:GetX(), object:GetY(), object:GetZ()+0.5, 0, 35, 0)
				showconfirmed(item, player)
			else
				player:SendBroadcastMessage("Not enough resources!")
				showmenutowerdefense(item, player)
			end
		else
			player:SendBroadcastMessage("Another tower is too close.")
			showmenutowerdefense(item, player)	
		end
	elseif intid == 9 then
		local object = player:GetGameObjectNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 185301)
		if (object == nil or player:CalcToDistance(object:GetLocation()) > 1.5) then
			player:SendBroadcastMessage("No nearby block found!")
			showmenutowerdefense(item, player)
		elseif (CanPlaceTower(object)) then
			if resources > 14 then
				resources = resources - 15
				player:SpawnCreature(140512, object:GetX(), object:GetY(), object:GetZ()+0.5, 0, 35, 0)
				showconfirmed(item, player)
			else
				player:SendBroadcastMessage("Not enough resources!")
				showmenutowerdefense(item, player)
			end
		else
			player:SendBroadcastMessage("Another tower is too close.")
			showmenutowerdefense(item, player)	
		end
	elseif intid == 10 then
		local object = player:GetGameObjectNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 185301)
		if (object == nil or player:CalcToDistance(object:GetLocation()) > 1.5) then
			player:SendBroadcastMessage("No nearby block found!")
			showmenutowerdefense(item, player)
		elseif (CanPlaceTower(object)) then
			if resources > 9 then
				resources = resources - 10
				player:SpawnCreature(116592, object:GetX(), object:GetY(), object:GetZ()+0.5, 0, 35, 0)
				showconfirmed(item, player)
			else
				player:SendBroadcastMessage("Not enough resources!")
				showmenutowerdefense(item, player)
			end
		else
			player:SendBroadcastMessage("Another tower is too close.")
			showmenutowerdefense(item, player)	
		end
	elseif intid == 11 then
		local object = player:GetGameObjectNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 185301)
		if (object == nil or player:CalcToDistance(object:GetLocation()) > 1.5) then
			player:SendBroadcastMessage("No nearby block found!")
			showmenutowerdefense(item, player)
		elseif (CanPlaceTower(object)) then
			if resources > 4 then
				resources = resources - 5
				player:SpawnCreature(485211, object:GetX(), object:GetY(), object:GetZ()+0.5, 0, 35, 0, 0, 0, 44643):SetUInt32Value(UNIT_FIELD_BYTES_2, 2)
				showconfirmed(item, player)
			else
				player:SendBroadcastMessage("Not enough resources!")
				showmenutowerdefense(item, player)
			end
		else
			player:SendBroadcastMessage("Another tower is too close.")
			showmenutowerdefense(item, player)	
		end
	elseif intid == 98 then
		showmenutowerdefense(item, player)
	elseif intid == 99 then
		player:GossipComplete()
	end
end

RegisterItemGossipEvent(57061, 1, "towerdefenseclick")
RegisterItemGossipEvent(57061, 2, "towerdefesneselect")

-- Handle win/lose

function DummyHandlerSpawn_TowerDefense(pUnit, Event)
	pUnit:RegisterEvent("CheckForStatusChange_TowerDefense", 2000, 0)
end

function CheckForStatusChange_TowerDefense(pUnit)
	if waverunning then
		if shieldvalue == 0 then
			pUnit:SendChatMessage(42,0,"You have lost!")
			for _,plrs in pairs(pUnit:GetInRangePlayers()) do
				ResetWorldstatesUI(plrs)
			end
			for _,plrs in pairs(pUnit:GetInRangePlayers()) do
				towerdefesneselect(nil, nil, plrs, nil, 6, nil)
				break
			end
			waverunning = false
		end
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			if unit:GetEntry() == waveentry then
				if not unit:IsAlive() then
					creepsLeft = creepsLeft - 1
					unit:RemoveEvents()
					unit:Despawn(1500,0)
					resources = resources + upvalue
				end
			end
		end
		if creepsLeft == 0 then
			waverunning = false
			for _,plrs in pairs(pUnit:GetInRangePlayers()) do
				UpdateWorldstatesUI(plrs)
				UpdateAttempts(plrs, shieldvalue)
			end
			pUnit:SendChatMessage(42,0,"End of wave "..tostring(wavenum).."!")
			if wavenum == 15 then
				for _,plrs in pairs(pUnit:GetInRangePlayers()) do
					if plrs:HasAura(50224) then
						plrs:RemoveAura(50224) -- zombie vision
					end
				end
			end
			wavenum = wavenum + 1
		end
	end
end

RegisterUnitEvent(32298, 18, "DummyHandlerSpawn_TowerDefense")

-- Handle the worldstates

function UpdateWorldstatesUI(plrs)
	local pack = LuaPacket:CreatePacket(SMSG_INIT_WORLD_STATES, 18)
	pack:WriteULong(608) -- Map
	pack:WriteULong(0) -- Zone
	pack:WriteULong(0)
	pack:WriteUShort(1)
	pack:WriteULong(3816) -- ID
	pack:WriteULong(1) -- Value
	plrs:SendPacketToPlayer(pack)
end

function UpdateAttempts(plrs, value)
	local pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
	pack:WriteULong(3815) -- ID, X
	pack:WriteULong(value) -- Value
	plrs:SendPacketToPlayer(pack)
end

function ResetWorldstatesUI(plrs)
	local pack = LuaPacket:CreatePacket(SMSG_INIT_WORLD_STATES, 18)
	pack:WriteULong(0) -- Map
	pack:WriteULong(0) -- Zone
	pack:WriteULong(0)
	pack:WriteUShort(0)
	pack:WriteULong(0) -- ID
	pack:WriteULong(0) -- Value
	plrs:SendPacketToPlayer(pack)
end

--