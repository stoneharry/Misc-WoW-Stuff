---ref 
--3261167 = go object portal
--77170 Jane smith
--77290 portal dummy
---14967 music
---15120 music 2
---771746 Running citizens
-- portal display dummy 77220
-- 77183 Miniboss RANDOM 1
-- 77185 MINIBOSS RANDOM 2
--77289 BOMB ID
--- firedisplayid 30998 
-- 77186 Fel cannon
-- 14430Eyeball


---OCCULATHAR DUMMIES
--77291 mouth 2
--77292 mouth 1
--77293 laser 1
--77294 laser 2
--77295 laser 3
--77296 laser 4

--==========================--
--======NPC REFERENCE========--
--==========================--
--77182  = Shadow Demon 
--Blows up on Impact.
--==========================--

local Jane
local NetherP = nil
local i = 0
local b = 0
local f = 0
local Q3033Ready = false
local PortalDummy
local GroundEffect -- Removes Auras and debuffs Boss 77221(Dummy id)
local VanguardBoss
local Zoltan
local CannonA
local CannonB

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000

--[[ Phase 32 Mobs and dummies]]


function TownFirePhase32_OnSpawn(pUnit,Event)
pUnit:RegisterEvent("FireDummyDamageTown", 500, 0)
end

function FireDummyDamageTown(pUnit,Event)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if players:IsInPhase(32) then
			if pUnit:GetDistanceYards(players) < 3.5 then
				if players:IsDead() == false then
					players:CastSpell(38042)
					pUnit:DealDamage(players, 50, 38042)
				end
			end
		end
	end
end
  
   RegisterUnitEvent(485723, 18, "TownFirePhase32_OnSpawn")
   
   
   
function Phase32SoundSFX_OnSpawn(pUnit,Event)
pUnit:RegisterEvent("PlayMusicPhase32Town", 8000, 0)
end
   

    RegisterUnitEvent(485724, 18, "Phase32SoundSFX_OnSpawn")
	
	
function DukeBlake_OnSpawn(pUnit,Event)
pUnit:RegisterEvent("GhostEffectz",1200,1)
end
   

    RegisterUnitEvent(75630, 18, "DukeBlake_OnSpawn")
	
	
function PlayMusicPhase32Town(pUnit,Event)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 80 then
			if players:IsInPhase(32) then
				local choice = math.random(1,3)
				if choice == 1 then
					players:PlaySoundToPlayer(14557)
				elseif choice == 2 then
					players:PlaySoundToPlayer(14556)
				elseif choice == 3 then
					players:PlaySoundToPlayer(14559)
				end
			end
		end
	end
end


function InvadingDemon_OnSpawn(pUnit,Event)
	if pUnit:GetDisplay() == 5048 then
		pUnit:EquipWeapons(7717,0,0)
	elseif pUnit:GetDisplay() == 1913 then
		pUnit:EquipWeapons(0,0,0)
	elseif pUnit:GetDisplay() == 16874 then
		pUnit:CastSpell(39809)
		pUnit:EquipWeapons(0,0,0)
	end
end

RegisterUnitEvent(75631, 18, "InvadingDemon_OnSpawn")

function InvadingDemon_OnCombat(pUnit,Event)
	if pUnit:GetDisplay() == 5048 then
		pUnit:RegisterEvent("Felguard_Cleaving", 6000, 0)
		pUnit:RegisterEvent("Felguard_Charge", 1000, 1)
	elseif pUnit:GetDisplay() == 1913 then
		pUnit:RegisterEvent("Felbeast_Manaburn", 5000, 0)
		pUnit:RegisterEvent("Felbeast_Corruption", 8000, 0)
	elseif pUnit:GetDisplay() == 16874 then
		pUnit:RegisterEvent("Immolate_Infernal", 7000, 0)
	end
end

function Felbeast_Manaburn(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target then
		if pUnit:GetDistanceYards(target) < 15 then
			pUnit:CastSpellOnTarget(2691,target)
		end
	end
end


function Felbeast_Corruption(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target then
		if pUnit:GetDistanceYards(target) < 15 then
			target:RemoveAura(6223)
			pUnit:CastSpellOnTarget(6223,target)
		end
	end
end


function Felguard_Charge(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target then
		if pUnit:GetDistanceYards(target) < 18 then
			pUnit:CastSpellOnTarget(100,target)
		end
	end
end


function Felguard_Cleaving(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target then
		if pUnit:GetDistanceYards(target) < 7 then
			pUnit:CastSpellOnTarget(7369,target)
		end
	end
end

function Immolate_Infernal(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target then
		if pUnit:GetDistanceYards(target) < 20 then
			pUnit:CastSpellOnTarget(1094,target)
		end
	end
end

function InvadingDemon_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

function InvadingDemon_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
end

 RegisterUnitEvent(75631, 1, "InvadingDemon_OnCombat")
 RegisterUnitEvent(75631, 2, "InvadingDemon_OnLeave")
 RegisterUnitEvent(75631, 4, "InvadingDemon_OnDead")


function Jane_OnSpawn(pUnit,Event)
	local portal = pUnit:GetGameObjectNearestCoords(-9345.87,-2280.62, 71.64, 3261167)
	if portal then
	portal:SetByte(GAMEOBJECT_BYTES_1,0,1)
	end
	pUnit:CastSpell(44816)
	pUnit:SetMaxHealth(6200)
	pUnit:SetHealth(6200)
	pUnit:StopChannel()
	pUnit:SetCombatTargetingCapable(true) -- debug 
	pUnit:SetCombatCapable(true) -- debug
	pUnit:Root()
	pUnit:SetNPCFlags(1)
	pUnit:RegisterEvent("VariableGossipCheckz", 3000, 0)
	pUnit:RegisterEvent("GhostEffectz",1200,1)
end

RegisterUnitEvent(77170, 18, "Jane_OnSpawn")

function CheckingDummy_Spawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	NetherP = pUnit
	if NetherP ~= nil then
		NetherP:RegisterEvent("Checking_For_NPC",2000,0) 
	end
end

RegisterUnitEvent(77220, 18, "CheckingDummy_Spawn")



function CiviliansRunning_OnSpawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:ModifyWalkSpeed(8)
	pUnit:SetMovementFlags(1)
	pUnit:Unroot()
	pUnit:RegisterEvent("Movemovemove",1000,1)
end

RegisterUnitEvent(771746, 18, "CiviliansRunning_OnSpawn")


function Movemovemove(pUnit,Event)
	pUnit:MoveTo(-9346.92, -2280.93 , 71.64 , 3.10)
	pUnit:RegisterEvent("Imadeitlulz",2500,1)
end

function Imadeitlulz(pUnit,Event)
	pUnit:CastSpell(52096)
	pUnit:Despawn(1000,0)
end

function GhostEffectz(pUnit,Event)
	pUnit:CastSpell(44816)
end

function JaneSmithEvent_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(142360, player, 0)
	if player:HasQuest(3032) then 
		pUnit:GossipMenuAddItem(9, "I am ready.", 246, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end


function JaneSmithEvent_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 246) then
		Jane = pUnit
		Jane:SetNPCFlags(2)
		PortalDummy = Jane:GetCreatureNearestCoords(Jane:GetX(),Jane:GetY(), Jane:GetZ(), 77290)
		Jane:ChannelSpell(70634,PortalDummy)
		PortalDummy:CastSpell(58538)
		Jane:GetGameObjectNearestCoords(Jane:GetX(),Jane:GetY(), Jane:GetZ(), 3261167):SetByte(GAMEOBJECT_BYTES_1,0,0)
		Q3033Ready =  true
		Jane:SendChatMessage(12,0,"Hold them back as long as possible!")
		Jane:PlaySoundToSet(11050)
	end
	player:GossipComplete()
end

function VariableGossipCheckz(pUnit, Event)
	if Q3033Ready ==  true then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("HealthCheckerzxz",2000,0)
		for a, players in pairs(pUnit:GetInRangePlayers()) do
			if players:IsInPhase(32) then
				if pUnit:GetDistanceYards(players) < 14 then
					players:PlayMusicToPlayer(15120)
				end
			end
		end
		Jane = pUnit
		i = 0
		Jane:RegisterEvent("PortalEvent",2000,1) 
	end
end


--==========================--
--==========WAVES===========--
--==========================--

function PortalEvent(pUnit,Event)
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:GetPhase() == 32 then
			plrs:SetHealthPct(100)
		end
	end
	i = i + 1
	if i == 1 then
		Jane:RegisterEvent("PortalEventz",4000,0) 
		Jane:RegisterEvent("PortalEvent",5000,1) 
		-------------------------
	elseif i == 2 then
		Jane:SpawnCreature(77220, -9309.79, -2283.65, 70.24, 3.091, 35, 0)
		Jane:RegisterEvent("PortalEvent",3000,1) 
		-------------------------------------------
	elseif i == 3 then -- Wave one
		local choice = math.random(1,3)
		if choice == 1 then
		Jane:SpawnCreature(77182 ,-9310.83, -2280.69, 70.36, 3.09, 14, 0)
		elseif choice == 2 then
		Jane:SpawnCreature(77182 ,-9310.96, -2283.38, 70.31, 3.09, 14, 0)
		elseif choice == 3 then
		Jane:SpawnCreature(77182 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		end
		NetherP:RegisterEvent("PortalEvent",7000,1) 
		-----------------------------------------
	elseif i == 4 then -- Wave two
		local choice = math.random(1,3)
		if choice == 1 then
		Jane:SpawnCreature(77182 ,-9310.83, -2280.69, 70.36, 3.09, 14, 0)
		elseif choice == 2 then
		Jane:SpawnCreature(77182 ,-9310.96, -2283.38, 70.31, 3.09, 14, 0)
		elseif choice == 3 then
		Jane:SpawnCreature(77182 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		end
		NetherP:RegisterEvent("PortalEvent",7000,1) 
		------------------------------
	elseif i == 5 then -- Wave three
		local choice = math.random(1,3)
		if choice == 1 then
		Jane:SpawnCreature(77182 ,-9310.83, -2280.69, 70.36, 3.09, 14, 0)
		elseif choice == 2 then
		Jane:SpawnCreature(77182 ,-9310.96, -2283.38, 70.31, 3.09, 14, 0)
		elseif choice == 3 then
		Jane:SpawnCreature(77182 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		end
		NetherP:RegisterEvent("PortalEvent",7000,1) 
		------------------------------
	elseif i == 6 then -- Wave four
		local choice = math.random(1,3)
		if choice == 1 then
		Jane:SpawnCreature(77182 ,-9310.83, -2280.69, 70.36, 3.09, 14, 0)
		elseif choice == 2 then
		Jane:SpawnCreature(77182 ,-9310.96, -2283.38, 70.31, 3.09, 14, 0)
		elseif choice == 3 then
		Jane:SpawnCreature(77182 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		end
		NetherP:RegisterEvent("PortalEvent",12000,1) 
		------------------------------
	elseif i == 7 then -- wave 5
		Jane:SendChatMessage(12,0,"Stay alert! Another wave approaches.")
		Jane:PlaySoundToSet(11008)
		local choice = math.random(1,3)
		if choice == 1 then
		Jane:SpawnCreature(77287 ,-9310.83, -2280.69, 70.36, 3.09, 14, 0)
		elseif choice == 2 then
		Jane:SpawnCreature(77184 ,-9310.96, -2283.38, 70.31, 3.09, 14, 0)
		elseif choice == 3 then
		Jane:SpawnCreature(77182 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		end
		NetherP:RegisterEvent("PortalEvent",25000,1) 
		------------------------------
	elseif i == 8 then -- Wave six
		local choice = math.random(1,3)
		if choice == 1 then
		Jane:SpawnCreature(77184 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		Jane:SpawnCreature(77182 ,-9310.83, -2280.69, 70.36, 3.09, 14, 0)
		elseif choice == 2 then
		Jane:SpawnCreature(77182 ,-9310.96, -2283.38, 70.31, 3.09, 14, 0)
		Jane:SpawnCreature(77184 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		elseif choice == 3 then
		Jane:SpawnCreature(77287 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		end
		NetherP:RegisterEvent("PortalEvent",25000,1) 
		------------------------------
	elseif i == 9 then -- Wave seven
		local choice = math.random(1,3)
		if choice == 1 then
		Jane:SpawnCreature(77184 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		Jane:SpawnCreature(77182 ,-9310.83, -2280.69, 70.36, 3.09, 14, 0)
		elseif choice == 2 then
		Jane:SpawnCreature(77182 ,-9310.96, -2283.38, 70.31, 3.09, 14, 0)
		Jane:SpawnCreature(77184 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		elseif choice == 3 then
		Jane:SpawnCreature(77287 ,-9311.12, -2286.42, 70.33, 3.09, 14, 0)
		end
		NetherP:RegisterEvent("PortalEvent",35000,1) 
		------------------------------
	elseif i == 10 then -- boss test

		Jane:SpawnCreature(77185, -9310.83, -2280.69, 70.36, 3.09, 14, 0)

		Jane:SendChatMessage(42, 0, "A Powerful Demon crosses through the  Nether Portal.")
	end
end
   
function PortalEventz(pUnit,Event)
	if math.random(1,2) == 1 then
		Jane:SpawnCreature(771746 ,-9329.72, -2277.89, 71.45, 3.26, 35, 5000)
	else
		Jane:SpawnCreature(771746 ,-9330.05, -2286.19, 71.48, 2.90, 35, 5000)
	end
end
	
RegisterUnitGossipEvent(77170, 1, "JaneSmithEvent_On_Gossip")
RegisterUnitGossipEvent(77170, 2, "JaneSmithEvent_Gossip_Submenus")

function JaneSmith_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

function JaneSmith_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Despawn(1000,4000)
	local portal = pUnit:GetGameObjectNearestCoords(-9345.87,-2280.62, 71.64, 3261167)
	if portal then
		portal:SetByte(GAMEOBJECT_BYTES_1,0,1)
	end
	Q3033Ready = false
	pUnit:SendChatMessage(12, 0, "I did... my best.")
	pUnit:PlaySoundToSet(11010)
end

--==========================--
--==========VOIDHOUND BOSS===========--
--==========================--
--===dummies===--
--77291 mouth 2
--77292 mouth 1
--77293 laser 1
--77294 laser 2
--77295 laser 3 OBSELETE
--77296 laser 4 OBSELETE

function FireDummy(pUnit,Event)
	pUnit:SetScale(.7)
	pUnit:SetMovementFlags(1)
	pUnit:ModifyWalkSpeed(8)
	pUnit:RegisterEvent("FireDummyDamage",1500,0) 
	pUnit:RegisterEvent("MoveToRandom",3000,0) 
end

function FireDummyDamage(pUnit,Event)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if players:IsInPhase(32) then
			if pUnit:GetDistanceYards(players) < 3.5 then
				players:CastSpell(38042)
				pUnit:DealDamage(players, 50, 38042)
			end
		end
	end
end
  
function MoveToRandom(pUnit,Event)
	local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
	local choice = math.random(1,6)
	if choice == 1 then
		pUnit:MoveTo( x+math.random(1,3), y+math.random(1,3),z,o)
	elseif choice == 2 then
		pUnit:MoveTo( x-math.random(1,3), y-math.random(1,3),z,o)
	elseif choice == 3 then
		pUnit:MoveTo( x+math.random(2,4), y+math.random(1,2),z,o)
	elseif choice == 4 then
		pUnit:MoveTo( x-math.random(2,4), y-math.random(1,2),z,o)
	elseif choice == 5 then
		pUnit:MoveTo( x+math.random(1,2), y+math.random(1,2),z,o)
	elseif choice == 6 then
		pUnit:MoveTo( x-math.random(1,2), y-math.random(1,2),z,o)
	end
end

RegisterUnitEvent(78221, 18, "FireDummy")
 
function VoidHoundBoss_OnCombat(pUnit,Event)
	pUnit:RegisterEvent("FireChoice",9500,0) 
end

function FireChoice(pUnit,Event)
	f = 0
	pUnit:CastSpell(44863)
	pUnit:Root()
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:RegisterEvent("FireChoicex",500,1) 
	elseif choice == 2 then
		pUnit:RegisterEvent("FireChoicey",500,1) 
	elseif choice == 3 then
		pUnit:RegisterEvent("FireChoicez",500,1) 
	end
end

function FireChoicex(pUnit,Event) --1
	f = f + 1
	if f == 1 then
		pUnit:SpawnCreature(78221 ,-9333.96, -2288.66, 71.57, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicex",200,1) 
	elseif f == 2 then
		pUnit:SpawnCreature(78221 ,-9340.12, -2281.95, 71.63, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicex",200,1) 
	elseif f == 3 then
		pUnit:SpawnCreature(78221 ,-9336.11, -2273.61, 71.59, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicex",200,1) 
	elseif f == 4 then
		pUnit:SpawnCreature(78221 ,-9324.90, -2275.12, 71.29, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicex",200,1) 
	elseif f == 5 then
		pUnit:SpawnCreature(78221 ,-9317.44, -2282, 70.85, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicex",200,1) 
	elseif f == 6 then
		pUnit:SpawnCreature(78221 ,-9317.44, -2282, 70.85, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicex",200,1) 
	elseif f == 7 then
		pUnit:SpawnCreature(78221 ,-9343.54, -2294.23, 71.61, 0, 35, 9000)
	end
	pUnit:Unroot()
end

function FireChoicey(pUnit,Event) -- 2
	f = f + 1
	if f == 1 then
		pUnit:SpawnCreature(78221 ,-9317.44, -2282, 70.85, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicey",100,1) 
	elseif f == 2 then
		pUnit:SpawnCreature(78221 ,-9340.12, -2281.95, 71.63, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicey",100,1) 
	elseif f == 3 then
		pUnit:SpawnCreature(78221 ,-9336.11, -2273.61, 71.59, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicey",100,1) 
	elseif f == 4 then
		pUnit:SpawnCreature(78221 ,-9329.93, -2282.86, 71.46, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicey",100,1) 
	elseif f == 5 then
		pUnit:SpawnCreature(78221 ,-9344.47, -2295.15, 71.62, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicey",200,1) 
	elseif f == 6 then
		pUnit:SpawnCreature(78221 ,-9317.44, -2282, 70.85, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicey",200,1) 
	elseif f == 7 then
		pUnit:SpawnCreature(78221 ,-9343.54, -2294.23, 71.61, 0, 35, 9000)
	end
	pUnit:Unroot()
end

function FireChoicez(pUnit,Event) -- 3
	f = f + 1
	if f == 1 then
		pUnit:SpawnCreature(78221 ,-9317.44, -2282, 70.85, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicez",100,1) 
	elseif f == 2 then
		pUnit:SpawnCreature(78221 ,9340.12, -2281.95, 71.63, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicez",100,1) 
	elseif f == 3 then
		pUnit:SpawnCreature(78221 ,-9329.93, -2282.86, 71.46, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicez",100,1) 
	elseif f == 4 then
		pUnit:SpawnCreature(78221 ,-9344.47, -2295.15, 71.62, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicez",100,1) 
	elseif f == 5 then
		pUnit:SpawnCreature(78221 ,-9324.90, -2275.12, 71.29, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicez",100,1) 
	elseif f == 6 then
		pUnit:SpawnCreature(78221 ,-9317.44, -2282, 70.85, 0, 35, 9000)
		pUnit:RegisterEvent("FireChoicez",100,1) 
	elseif f == 7 then
		pUnit:SpawnCreature(78221 ,-9343.54, -2294.23, 71.61, 0, 35, 9000)
	end
	pUnit:Unroot()
end

function VoidHoundBoss_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end
 
function VoidHoundBoss_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
	Q3033Ready = false
	NetherP:Despawn(1000,1000)
	Jane:RegisterEvent("BossDied",3000,1) 
end
 
function VoidHoundBoss_OnSpawn(pUnit,Event)
	pUnit:SetMaxHealth(6500)
	pUnit:SetHealth(6500)
	pUnit:SetMovementFlags(1)
	pUnit:ModifyWalkSpeed(9)
	pUnit:ChannelSpell(12380,NetherP)
	pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
	pUnit:RegisterEvent("RemoveChannel",1500,1)
end
 
RegisterUnitEvent(77288, 18, "VoidHoundBoss_OnSpawn")
RegisterUnitEvent(77288, 1, "VoidHoundBoss_OnCombat")
RegisterUnitEvent(77288, 2, "VoidHoundBoss_OnLeave")
RegisterUnitEvent(77288, 4, "VoidHoundBoss_OnDead")
 
--==========================--
--==========NPC AI===========--
--==========================--

--====Shadow Demon=====--
function ShadowDemon_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Despawn(2000,0)
end

function ShadowDemon_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowDemon_OnCombat(pUnit,Event)
	pUnit:RegisterEvent("Shadowcrash",1500,0) 
end

function Shadowcrash(pUnit,Event)
	local enemy = pUnit:GetClosestEnemy()
	if enemy then
		pUnit:CastSpell(39180)
	end
	for _, enemies in pairs(pUnit:GetInRangeEnemies()) do
		if pUnit:GetDistanceYards(enemies) < 10 then
			pUnit:CastSpellOnTarget(686,enemies)
		end
	end
	pUnit:Despawn(2500,0)
	pUnit:RegisterEvent("Die",500,1)
end

function Die(pUnit,Event)
	pUnit:Kill(pUnit)
end

function Checking_For_NPC(pUnit,Event)
	if Jane then
		if Jane:IsDead() then
			pUnit:Despawn(1000,0)
		end
	end
end

---------------------------------------------

function LegionEngineer_OnCombat(pUnit,Event)
	pUnit:RegisterEvent("LegionEngineer_Dynomite",5000,0)  
end

function LegionEngineer_Dynomite(pUnit,Event)
	local mt = pUnit:GetMainTank()
	if mt then
	pUnit:FullCastSpellAoF(mt:GetX(), mt:GetY(), mt:GetZ(), 4061)
	end
end

function LegionEngineer_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

function LegionEngineer_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(77184, 1, "LegionEngineer_OnCombat")
RegisterUnitEvent(77184, 2, "LegionEngineer_OnLeave")
RegisterUnitEvent(77184, 2, "LegionEngineer_OnDead")

function MorgEngineer_OnCombat(pUnit,Event)
	pUnit:RegisterEvent("MorgEngineer_Saw",5000,1) 
end

function MorgEngineer_Saw(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32735, pUnit:GetMainTank())
end

function MorgEngineer_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

function MorgEngineer_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(77287, 1, "MorgEngineer_OnCombat")
RegisterUnitEvent(77287, 2, "MorgEngineer_OnLeave")
RegisterUnitEvent(77287, 2, "MorgEngineer_OnDead")

function MorgEngineer_OnSpawn(pUnit,Event)
	pUnit:ModifyWalkSpeed(6)
	pUnit:ChannelSpell(12380,NetherP)
	pUnit:SetMovementFlags(1)
	pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
	pUnit:RegisterEvent("RemoveChannel",1500,1)
end

RegisterUnitEvent(77287, 18, "MorgEngineer_OnSpawn")

RegisterUnitEvent(77182, 1, "ShadowDemon_OnCombat")
RegisterUnitEvent(77182, 2, "ShadowDemon_OnLeave")
RegisterUnitEvent(77182, 4, "ShadowDemon_OnDead")


function GroundEffect_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("CheckingForBoss",2500,0)
end

RegisterUnitEvent(77221, 18, "GroundEffect_OnSpawn")

function Shadowdemon_OnSpawn(pUnit,Event)
	pUnit:CastSpell(41408)
	pUnit:SetMovementFlags(1)
	pUnit:ChannelSpell(12380,NetherP)
	pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
	pUnit:RegisterEvent("RemoveChannel",1500,1)
end

RegisterUnitEvent(77182, 18, "Shadowdemon_OnSpawn")

function LegionEngineer_OnSpawn(pUnit,Event)
	pUnit:ModifyWalkSpeed(6)
	pUnit:SetMovementFlags(1)
	pUnit:ChannelSpell(12380,NetherP)
	pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
	pUnit:RegisterEvent("RemoveChannel",1500,1)
end

RegisterUnitEvent(77184, 18, "LegionEngineer_OnSpawn")

function RemoveChannel(pUnit,Event) -- for portal spawned units
	pUnit:StopChannel()
	pUnit:MoveTo(-9346.92, -2280.93 , 71.64 , 3.10)
	pUnit:CastSpell(44816)
end

--==========================--
--==========JAILOR BOSS AI===========--
--==========================--

function CheckingForBoss(pUnit,Event)
	if VanguardBoss then
		if pUnit:GetDistanceYards(VanguardBoss) < 8 then
			VanguardBoss:RemoveAura(63364)
			pUnit:CastSpellOnTarget(41410,VanguardBoss) -- increases damage taken
			pUnit:Despawn(3000,0)
		end
	end
end

function VanguardBoss_Spawn(pUnit,Event)
	VanguardBoss = pUnit
	VanguardBoss:EquipWeapons(19363,19363,0)
	VanguardBoss:ChannelSpell(12380,NetherP)
	VanguardBoss:RegisterEvent("Checking_For_NPC",2000,0) 
	VanguardBoss:RegisterEvent("RemoveChannel",1500,1)
end

RegisterUnitEvent(77183, 18, "VanguardBoss_Spawn")

--==========================--
--==========ZOLTAN BOSS AI===========--
--==========================--

function Zoltan_OnSpawn(pUnit,Event)
	Zoltan = pUnit
	Zoltan:Unroot()
	pUnit:SetMovementFlags(1)
	Zoltan:ChannelSpell(12380,NetherP)
	Zoltan:RegisterEvent("Checking_For_NPC",2000,0) 
	Zoltan:RegisterEvent("RemoveChannel",1500,1)
end

function Zoltan_OnCombat(pUnit,Event)
	pUnit:RegisterEvent("ExplosivePre",16000,0) 
	pUnit:RegisterEvent("Dragongun",9000,0) 
	pUnit:RegisterEvent("ZoltanPhase2",2000,0)
end

function ExplosivePre(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Root()
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if players:IsInPhase(32) then
			if pUnit:GetDistanceYards(players) < 15 then
				if players:IsDead() == false then
					pUnit:SendChatMessageToPlayer(42, 0, "Zoltan has a flaring look in his eyes", players)
				end
			end
		end
	end
	pUnit:RegisterEvent("Explosives",2000,1) 
	pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
	if pUnit:GetHealthPct() < 50 then
		pUnit:RegisterEvent("ZoltanPhase2",1000,0) 
	end
end

function Dragongun(pUnit,Event)
	pUnit:FullCastSpell(13183)
	pUnit:Root()
	pUnit:RegisterEvent("CancelDragongun",4000,1) 
end

function CancelDragongun(pUnit,Event)
	pUnit:InterruptSpell()
	pUnit:Unroot()
end

function Explosives(pUnit,Event)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if players:IsInPhase(32) then
			if pUnit:GetDistanceYards(players) < 15 then
				players:CastSpell(69693)
				if math.random(1,2) == 1 then
					pUnit:SpawnCreature(77289 , players:GetX(), players:GetY(), players:GetZ(), players:GetO(), 35, 6000)
					pUnit:CastSpellAoF(players:GetX(), players:GetY(), players:GetZ(), 4064)
				end
			end
		end
	end
	pUnit:RegisterEvent("Unroot_Zoltan",2000,1) 
end

function Unroot_Zoltan(pUnit,Event)
	pUnit:Unroot()
	pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
	pUnit:RegisterEvent("ExplosivePre",16000,0) 
	pUnit:RegisterEvent("Dragongun",9000,0) 
	if pUnit:GetHealthPct() < 50 then
		pUnit:RegisterEvent("ZoltanPhase2",1000,0) 
	end
end

function Zoltan_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

function Zoltan_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
	Q3033Ready = false
	NetherP:Despawn(1000, 1000)
	Jane:RegisterEvent("BossDied",3000,1) 
end

----zoltan died----
function BossDied(pUnit,Event)
	Jane:PlaySoundToSet(11011)
	Jane:StopChannel()
	Jane:SendChatMessage(12, 0, "We have won valuable time. Now we must pull back!")
	Jane:RegisterEvent("PullBackz",3000,1) 
end
	
function PullBackz(pUnit,Event)
	Jane:Unroot()
	Jane:MoveTo(-9346.92, -2280.93 , 71.64 , 3.10)
	for _,players in pairs(Jane:GetInRangePlayers()) do
		if Jane:IsInPhase(32) then
			if Jane:GetDistanceYards(players) < 14 then
				Jane:SendChatMessageToPlayer(42, 0, "You start to fade into present times.", players)
			end
		end
	end
	Jane:RegisterEvent("PullBackzz",3000,1) 
end	
	
function PullBackzz(pUnit,Event)
	Jane:CastSpell(52096)
	for _,players in pairs(Jane:GetInRangePlayers()) do
		if players:IsInPhase(32) then
			if Jane:GetDistanceYards(players) < 20 then
				if players:HasQuest(3032) then
					players:MarkQuestObjectiveAsComplete(3032,0)
					players:SetPhase(1)
					players:RemoveAura(68085)  
					players:Teleport(0, -9387.29, -3035.95, 139.43)
				end
			end
		end
	end
	Jane:Despawn(2000,5000)
end
----------------------

RegisterUnitEvent(77185, 1, "Zoltan_OnCombat")
RegisterUnitEvent(77185, 2, "Zoltan_OnLeave")
RegisterUnitEvent(77185, 4, "Zoltan_OnDead")

function TickingBomb_OnSpawn(pUnit,Event)
	pUnit:CastSpell(11817)
	pUnit:RegisterEvent("TickingBomb_3",1000,1) 
end

function TickingBomb_3(pUnit,Event)
	pUnit:CastSpell(11817)
	pUnit:RegisterEvent("TickingBomb_2",1000,1) 
end

function TickingBomb_2(pUnit,Event)
	pUnit:CastSpell(11817)
	pUnit:RegisterEvent("TickingBomb_1",1000,1) 
end

function TickingBomb_1(pUnit,Event)
	pUnit:CastSpell(11817)
	pUnit:RegisterEvent("TickingBomb_BOOM",1000,1) 
end

function TickingBomb_BOOM(pUnit,Event)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if players:IsInPhase(32) then
			if pUnit:GetDistanceYards(players) < 5 then
				pUnit:CastSpell(35341)
				players:CastSpell(35341)
				pUnit:DealDamage(players, 250, 35341)
			end
		end
	end
end

function ZoltanPhase2(pUnit,Event)
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		pUnit:Root()
		pUnit:TeleportCreature(-9324.63,-2282.42,71.27)
		pUnit:SendChatMessage(12,0,"Witness the power of  the Gan'arg!")
		CannonA = pUnit:SpawnCreature(77286, -9342.15, -2270.68, 71.62, 5.37, 14, 0)
		CannonB = pUnit:SpawnCreature(77286, -9343.54, -2294.23, 71.61, 0.72, 14, 0)
		if CannonA and CannonB then
			pUnit:CastSpell(63364)
		end
		pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
		pUnit:RegisterEvent("CheckingCannons",2000,0) 
		pUnit:RegisterEvent("RapidBombing",3000,0) 
		pUnit:RegisterEvent("ESET_SNAYA", 30000, 1)
	end
end

function ESET_SNAYA(pUnit)
	if CannonA and CannonA:IsAlive() then
		CannonA:RemoveEvents()
		CannonA:Kill(CannonA)
	end
	if CannonB and CannonB:IsAlive() then
		CannonB:RemoveEvents()
		CannonB:Kill(CannonB)
	end
	pUnit:RemoveEvents()
	pUnit:Unroot()
	pUnit:RemoveAura(63364)
	pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
	pUnit:RegisterEvent("ExplosivePre",16000,0) 
	pUnit:RegisterEvent("Dragongun",9000,0) 
end

function CheckingCannons(pUnit,Event)
	if (CannonA == nil or CannonA:IsDead()) and (CannonB == nil or CannonB:IsDead()) then
		pUnit:RemoveEvents()
		pUnit:Unroot()
		pUnit:RemoveAura(63364)
		pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
		pUnit:RegisterEvent("ExplosivePre",16000,0) 
		pUnit:RegisterEvent("Dragongun",9000,0) 
	end
end

function RapidBombing(pUnit,Event)
	b = 0
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:RegisterEvent("RapidBombingChoicex",500,1) 
	elseif choice == 2 then
		pUnit:RegisterEvent("RapidBombingChoicey",500,1) 
	elseif choice == 3 then
		pUnit:RegisterEvent("RapidBombingChoicez",500,1) 
	end
end

function RapidBombingChoicex(pUnit,Event) --1
	b = b + 1
	if b == 1 then
	pUnit:CastSpellAoF(-9333.96, -2288.66, 71.57, 4064)
	pUnit:RegisterEvent("RapidBombingChoicex",200,1) 
	elseif b == 2 then
	pUnit:CastSpellAoF(-9340.12, -2281.95, 71.63, 4064)
	pUnit:RegisterEvent("RapidBombingChoicex",200,1) 
	elseif b == 3 then
	pUnit:CastSpellAoF(-9336.11, -2273.61, 71.59, 4064)
	pUnit:RegisterEvent("RapidBombingChoicex",200,1) 
	elseif b == 4 then
	pUnit:CastSpellAoF(-9324.90, -2275.12, 71.29, 4064)
	pUnit:RegisterEvent("RapidBombingChoicex",200,1) 
	elseif b == 5 then
	pUnit:CastSpellAoF(-9317.44, -2282, 70.85, 4064)
	pUnit:RegisterEvent("RapidBombingChoicex",200,1) 
	elseif b == 6 then
	pUnit:CastSpellAoF(-9317.44, -2282, 70.85, 4064)
	pUnit:RegisterEvent("RapidBombingChoicex",200,1) 
	elseif b == 7 then
	pUnit:CastSpellAoF(-9343.54, -2294.23, 71.61, 4064)
	end
end

function RapidBombingChoicey(pUnit,Event) -- 2
	b = b + 1
	if b == 1 then
	pUnit:CastSpellAoF(-9317.44, -2282, 70.85, 4064)
	pUnit:RegisterEvent("RapidBombingChoicey",100,1) 
	elseif b == 2 then
	pUnit:CastSpellAoF(-9340.12, -2281.95, 71.63, 4064)
	pUnit:RegisterEvent("RapidBombingChoicey",100,1) 
	elseif b == 3 then
	pUnit:CastSpellAoF(-9336.11, -2273.61, 71.59, 4064)
	pUnit:RegisterEvent("RapidBombingChoicey",100,1) 
	elseif b == 4 then
	pUnit:CastSpellAoF(-9329.93, -2282.86, 71.46, 4064)
	pUnit:RegisterEvent("RapidBombingChoicey",100,1) 
	elseif b == 5 then
	pUnit:CastSpellAoF(-9344.47, -2295.15, 71.62, 4064)
	pUnit:RegisterEvent("RapidBombingChoicey",200,1) 
	elseif b == 6 then
	pUnit:CastSpellAoF(-9317.44, -2282, 70.85, 4064)
	pUnit:RegisterEvent("RapidBombingChoicey",200,1) 
	elseif b == 7 then
	pUnit:CastSpellAoF(-9343.54, -2294.23, 71.61, 4064)
	end
end

function RapidBombingChoicez(pUnit,Event) -- 3
	b = b + 1
	if b == 1 then
	pUnit:CastSpellAoF(-9317.44, -2282, 70.85, 4064)
	pUnit:RegisterEvent("RapidBombingChoicez",100,1) 
	elseif b == 2 then
	pUnit:CastSpellAoF(-9340.12, -2281.95, 71.63, 4064)
	pUnit:RegisterEvent("RapidBombingChoicez",100,1) 
	elseif b == 3 then
	pUnit:CastSpellAoF(-9329.93, -2282.86, 71.46, 4064)
	pUnit:RegisterEvent("RapidBombingChoicez",100,1) 
	elseif b == 4 then
	pUnit:CastSpellAoF(-9344.47, -2295.15, 71.62, 4064)
	pUnit:RegisterEvent("RapidBombingChoicez",100,1) 
	elseif b == 5 then
	pUnit:CastSpellAoF(-9324.90, -2275.12, 71.29, 4064)
	pUnit:RegisterEvent("RapidBombingChoicez",100,1) 
	elseif b == 6 then
	pUnit:CastSpellAoF(-9317.44, -2282, 70.85, 4064)
	pUnit:RegisterEvent("RapidBombingChoicez",100,1) 
	elseif b == 7 then
	pUnit:CastSpellAoF(-9343.54, -2294.23, 71.61, 4064)
	end
end

function Cannon_OnSpawn(pUnit,Event)
	pUnit:SetCombatTargetingCapable(true) -- debug 
	pUnit:SetCombatCapable(true) -- debug
	pUnit:Root()
	pUnit:SetMaxHealth(500)
	pUnit:SetHealth(500)
	pUnit:RegisterEvent("Checking_For_NPC",2000,0) 
	pUnit:RegisterEvent("Damage_Jane",4000,0) 
	pUnit:ChannelSpell(46319,Jane)
end

function Damage_Jane(pUnit,Event)
	if pUnit:IsDead() == false then
		if Jane then
			pUnit:DealDamage(Jane, 100, 36247)
			pUnit:CastSpellOnTarget(36247, Jane)
		end
	end
end

function Cannon_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:StopChannel()
end

RegisterUnitEvent(77286, 4, "Cannon_OnDead")

RegisterUnitEvent(77289, 18, "TickingBomb_OnSpawn")
RegisterUnitEvent(77185, 18, "Zoltan_OnSpawn")
RegisterUnitEvent(77286, 18, "Cannon_OnSpawn")


function Jane_OnCombat(pUnit,Event)
	pUnit:RegisterEvent("HealthCheckerzxz",2000,0) 
end

function HealthCheckerzxz(pUnit,Event)
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12, 0, "I'm in jeopardy, help me if you can!")
		pUnit:PlaySoundToSet(11007)
	end
end

RegisterUnitEvent(77170, 1, "Jane_OnCombat")
RegisterUnitEvent(77170, 2, "JaneSmith_OnLeave")
RegisterUnitEvent(77170, 4, "JaneSmith_OnDead")
