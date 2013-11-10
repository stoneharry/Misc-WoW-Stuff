
-- Global variables
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000
local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

-- Unrestful Wisps
local gt = 0


	function RandomTuskarrGossip_Talking(pUnit)
	gt = gt + 1
	if gt == 1 then
	local Guy1 = pUnit:GetCreatureNearestCoords(4641.82,-1684.76,1279.97, 957813)
for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 13 then
			Guy1:SendChatMessageToPlayer(12,0,"They killed her, the darn tigers killed Betsy!",players)
			end
				end
				pUnit:RegisterEvent("RandomTuskarrGossip_Talking", 5100, 1)
	elseif gt == 2 then
		local Guy2 = pUnit:GetCreatureNearestCoords(4647.55,-1673.64,1279.16, 957813)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 13 then
						Guy2:SendChatMessageToPlayer(12,0,"Calm down! We will mourn her loss when we reach the village.",players)
			end
				end
	pUnit:RegisterEvent("RandomTuskarrGossip_Talking", 4100, 1)
	elseif gt == 3 then
		local Guy1 = pUnit:GetCreatureNearestCoords(4641.82,-1684.76,1279.97, 957813)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 13 then
			Guy1:SendChatMessageToPlayer(12,0,"We can't reach there without Betsy!",players)
			end
				end
		pUnit:RegisterEvent("RandomTuskarrGossip_Talking", 4100, 1)
	elseif gt == 4 then
		local Guy2 = pUnit:GetCreatureNearestCoords(4647.55,-1673.64,1279.16, 957813)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 13 then
						Guy2:SendChatMessageToPlayer(12,0,"We'll find a way!",players)
			end
				end
		pUnit:RegisterEvent("RandomTuskarrGossip_Talking", 2100, 1)
	elseif gt == 5 then
	gt = 0
	pUnit:RegisterEvent("RandomTuskarrGossip_Talking", math.random(42000,61000), 1)
		end
	end

	function GossipTriggerThree_OnSpawn(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:RegisterEvent("RandomTuskarrGossip_Talking", 1500, 1)
end

RegisterUnitEvent(957815, 18, "GossipTriggerThree_OnSpawn")


function UnrestfulWispEvents(pUnit, Event)
	if Event == 1 then
		pUnit:FullCastSpell(56716)
		pUnit:RegisterEvent("SpamFrost_Wisp", 9000, 0)
	else
		pUnit:RemoveEvents()
		if Event == 2 then
			pUnit:RemoveAura(56716)
		end
	end
end

function SpamFrost_Wisp(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:CastSpellOnTarget(45477, plr)
	end
end

RegisterUnitEvent(176071, 1, "UnrestfulWispEvents")
RegisterUnitEvent(176071, 2, "UnrestfulWispEvents")
RegisterUnitEvent(176071, 4, "UnrestfulWispEvents")

-- Warbringer Razuun

function WarbringerRazEvents(pUnit)
	if Event == 1 then
		pUnit:RegisterEvent("WarbringerStrike", 6000, 0)
	else
		pUnit:RemoveEvents()
	end
end

function WarbringerStrike(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(58504, plr)
	end
end

RegisterUnitEvent(21287, 1, "WarbringerRazEvents")
RegisterUnitEvent(21287, 2, "WarbringerRazEvents")
RegisterUnitEvent(21287, 4, "WarbringerRazEvents")


function Cyberragelord_Events(pUnit)
	if Event == 1 then
		pUnit:RegisterEvent("Sawbladez_ragelord", 3000, 0)
	else
		pUnit:RemoveEvents()
	end
end

function Sawbladez_ragelord(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(32735, plr)
	end
end

RegisterUnitEvent(16943, 1, "Cyberragelord_Events")
RegisterUnitEvent(16943, 2, "Cyberragelord_Events")
RegisterUnitEvent(16943, 4, "Cyberragelord_Events")

RegisterUnitEvent(92073, 1, "Cyberragelord_Events")
RegisterUnitEvent(92073, 2, "Cyberragelord_Events")
RegisterUnitEvent(92073, 4, "Cyberragelord_Events")

function IkuluaRunebreak_Events(pUnit)
	if Event == 1 then
		pUnit:RegisterEvent("IkuluaRunebreak_Stormstrike", 6000, 0)
		local choice = math.random(1,3)
	if choice == 1 then
	pUnit:CastSpell(65990)
	end
	else
		pUnit:RemoveEvents()
	end
end

function IkuluaRunebreak_Stormstrike(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:CastSpellOnTarget(51876, plr)
	end
end

RegisterUnitEvent(339812, 1, "Cyberragelord_Events")
RegisterUnitEvent(339812, 2, "Cyberragelord_Events")
RegisterUnitEvent(339812, 4, "Cyberragelord_Events")

-- Flightmasters
-- At the peaks

function SnowdriftPeaksFlightMaster(pUnit, event, player)
	pUnit:GossipCreateMenu(77781, player, 0)
	pUnit:GossipMenuAddItem(2, "Stromgarde.", 1, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function SnowdriftPeaksFlightMaster2(pUnit, event, player, id, intid, code)
	player:GossipComplete()
	if (intid == 1) then
		player:Teleport(0, -1650, -1777, 80.1)
	end
end

RegisterUnitGossipEvent(16822, 1, "SnowdriftPeaksFlightMaster")
RegisterUnitGossipEvent(16822, 2, "SnowdriftPeaksFlightMaster2")

-- At Stromgarde

function StromgardeToSnowdrift(pUnit, event, player)
	pUnit:GossipCreateMenu(1127, player, 0)
	if (player:HasQuest(80044) or player:HasFinishedQuest(80044)) then
		pUnit:GossipMenuAddItem(2, "Snowdrift Peaks.", 1, 0)
	end
	if (player:HasQuest(52014) or player:HasFinishedQuest(52014)) then
		pUnit:GossipMenuAddItem(2, "Sandy Plains.", 2, 0)
	end
	if (player:HasQuest(80045) or player:HasFinishedQuest(80045)) then
		pUnit:GossipMenuAddItem(2, "Desolace.", 3, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 4, 0)
	pUnit:GossipSendMenu(player)
end

function StromgardeToSnowdrift2(pUnit, event, player, id, intid, code)
	player:GossipComplete()
	if (intid == 1) then
		player:Teleport(1, 4692, -3748, 946.9)
	elseif (intid == 2) then
		player:Teleport(1, 5030.49,-4569.61,850.97)
	elseif (intid == 3) then
		player:Teleport(1, 124, 1344, 193)
	end
end

RegisterUnitGossipEvent(244721, 1, "StromgardeToSnowdrift")
RegisterUnitGossipEvent(244721, 2, "StromgardeToSnowdrift2")

-- Dummys for quest 41102

local plrsSent = {}

function Dummy41102Spawn(pUnit, Event)
	if pUnit:GetEntry() == 116100 then
		pUnit:RegisterEvent("Dummy41102Trigger", 1000, 0)
	else
		pUnit:RegisterEvent("Dummy44102Quest", 1000, 0)
	end
end

function Dummy41102Trigger(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		if v:GetDistanceYards(pUnit) < 50 then
			if v:HasQuest(41102) then
				local name = v:GetName()
				for _,x in pairs(plrsSent) do
					if x == name then
						return
					end
				end
				table.insert(plrsSent, name)
				pUnit:SendChatMessageToPlayer(42,0,"Head north now!",v)
			end
		end
	end
end

function Dummy44102Quest(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		if v:GetDistanceYards(pUnit) < 50 then
			if v:HasQuest(41102) and v:GetQuestObjectiveCompletion(41102, 0) == 0 then
				v:AdvanceQuestObjective(41102, 0)
				for _,npc in pairs(pUnit:GetInRangeUnits()) do
					if npc:GetEntry() == 240481 then
						local owner = npc:GetPetOwner()
						if owner then
							if owner:GetName() == v:GetName() then
								npc:Despawn(1,0)
								break
							end
						end
					end
				end
				v:SetPhase(3)
			end
		end
	end
end

RegisterUnitEvent(116100, 18, "Dummy41102Spawn")
RegisterUnitEvent(116101, 18, "Dummy41102Spawn")

-- Twisted Clan Leader

function TwistedClanEvents(pUnit, Event)
		if Event == 1 then
		local npc = pUnit:GetCreatureNearestCoords(5078.72,-1801.65,1330.54, 31620)
			pUnit:RegisterEvent("TwistedSpawns", 5000, 0)
	if npc then
	npc:SendChatMessage(12,0,"Do as told and crush these maggots!")
	npc:Emote(4,1500)
	end
			elseif Event == 2 then
			pUnit:RemoveEvents()
			elseif Event == 4 then
		pUnit:RemoveEvents()
		local npc = pUnit:GetCreatureNearestCoords(4001.19,-2717.24,1180.52, 31620)
	if npc then
	npc:SendChatMessage(12,0,"Pathetic. You will learn to fear me soon enough.")
	npc:Emote(1,2000)
	npc:Despawn(2100,4000)
		end
	end
		end

function TwistedSpawns(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 17477 then
				v:AttackReaction(tank, 1, 0)
			end
		end
		local choice = math.random(1,3)
	if choice == 1 then
		pUnit:SpawnCreature(17477, 4020.78,-2715.35,1180.33,3.4, 14, 60000)
		elseif choice == 2 then
		pUnit:SpawnCreature(17477, 4010.997,-2710.21,1180.35,5.08, 14, 60000)
			elseif choice == 3 then
		pUnit:SpawnCreature(17477, 4008.88,-2724.55,1180.54,0.8, 14, 60000)
		end
	end
end

RegisterUnitEvent(237531, 1, "TwistedClanEvents")
RegisterUnitEvent(237531, 2, "TwistedClanEvents")
RegisterUnitEvent(237531, 4, "TwistedClanEvents")


function zzINFESTEDSHA(pUnit,Event)
pUnit:CastSpell(52233)
end


RegisterUnitEvent(17477, 18, "zzINFESTEDSHA")
-- Energy Core

function EyeOfCuluthas_Sp(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("EyeofCuluthas_Channel", 3000, 1)
local npc = pUnit:GetCreatureNearestCoords(5078.72,-1801.65,1330.54, 20138)
	if npc then
local tank = pUnit:GetMainTank()
if tank then
	pUnit:CastSpellAoF(tank:GetX(), tank:GetY(),tank:GetZ() , 63722)
end
local choice = math.random(1,8)
if choice == 1 then
	npc:SendChatMessage(12,0,"Ah, I see you!")
	elseif choice == 2 then
	npc:SendChatMessage(12,0,"An intruder has entered the premises.")
	elseif choice == 3 then
	npc:SendChatMessage(12,0,"You cannot hide from Culuthas!")
		elseif choice == 4 then
	npc:SendChatMessage(12,0,"The Illidari will have dead to bury!")
	end
	end
elseif Event == 2 or Event == 4 then
pUnit:RemoveEvents()
end	
	end

	
	function EyeofCuluthas_Channel(pUnit)
		local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:CastSpellOnTarget(36414,tank)
		end
	end
	pUnit:RegisterEvent("EyeofCuluthas_Channel", 13000, 1)
	end
	
	RegisterUnitEvent(20394, 1, "EyeOfCuluthas_Sp")
	RegisterUnitEvent(20394, 2, "EyeOfCuluthas_Sp")
	RegisterUnitEvent(20394, 4, "EyeOfCuluthas_Sp")
	
	function Culuthas_Ev(pUnit,Event)
	if Event == 1 then
	pUnit:SendChatMessage(12,0,"Impossible, how did you get past my minions!?")
		pUnit:RegisterEvent("Culuthas_ShadF",  math.random(12000,16000), 0)
			pUnit:RegisterEvent("Culuthas_Chainfire",  math.random(6000,8000), 0)
				pUnit:RegisterEvent("Culuthas_Sleep",  math.random(14000,15000),0)
	elseif Event == 2 or Event == 4 then
	pUnit:RemoveEvents()
	end
		end
		
		function Culuthas_Chainfire(pUnit)
		local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:FullCastSpellOnTarget(37089,tank)
		end
	end
	end
		
				function Culuthas_ShadF(pUnit)
			pUnit:CastSpell(35373)
		end
	
			function Culuthas_Sleep(pUnit)
		local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:CastSpellOnTarget(36402,tank)
		end
	end
	end
	
		RegisterUnitEvent(20138, 1, "Culuthas_Ev")
	RegisterUnitEvent(20138, 2, "Culuthas_Ev")
	RegisterUnitEvent(20138, 4, "Culuthas_Ev")
	

function EnergyCoreSpawn(pUnit, Event)
	if Event == 1 then
		pUnit:SendChatMessage(14,0,"Warning! Warning! Intruder alert! Intruder alert!")
		pUnit:PlaySoundToSet(5805)
		pUnit:AIDisableCombat(true)
		pUnit:RegisterEvent("PrepareAddsEtcEC", 5000, 1)
	elseif Event == 18 then
		pUnit:RegisterEvent("SETAI_State_energy", 2500, 1)
	elseif Event == 4 then
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			if v:HasQuest(41107) then
				if not v:HasItem(35669) then
					v:AddItem(35669, 1)
				end
			end
		end
		pUnit:AIDisableCombat(false)
	elseif Event == 2 then
		pUnit:AIDisableCombat(false)
	end
end

function PrepareAddsEtcEC(pUnit)
	if pUnit:IsAlive() then
		pUnit:PlaySoundToSet(5806)
		pUnit:SendChatMessage(14,0,"Internalizing subward transport! Defense units inbound!")
		pUnit:SpawnCreature(339812, 3983, -2556, 1157.6, 5.42, 14, 60000, 50296, 0, 0)
		pUnit:SpawnCreature(339812, 3989, -2562, 1157.5, 2.36, 14, 60000, 50296, 0, 0)
	end
end

function SETAI_State_energy(pUnit)
	pUnit:Root()
end

RegisterUnitEvent(258741, 1, "EnergyCoreSpawn")
RegisterUnitEvent(258741, 2, "EnergyCoreSpawn")
RegisterUnitEvent(258741, 4, "EnergyCoreSpawn")
RegisterUnitEvent(258741, 18, "EnergyCoreSpawn")

-- Shadow patches

function DarknessPatchSpawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("Spawned_SendVisual_DarknessPatch", 5000, 0)
end

function Spawned_SendVisual_DarknessPatch(pUnit)
	if pUnit:GetEntry() == 85208 then
		pUnit:CastSpell(46265)
	else
		pUnit:CastSpell(64469)
		pUnit:SetScale(0.5)
	end
	local plr = pUnit:GetClosestPlayer()
	if plr and plr:IsAlive() then
		if plr:GetDistanceYards(pUnit) < 40 then
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("DarknessPatchSpawn", 120000, 1)
			pUnit:SpawnCreature(500091, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 14, 60000)
		end
	end
end

RegisterUnitEvent(85208, 18, "DarknessPatchSpawn")
RegisterUnitEvent(85209, 18, "DarknessPatchSpawn")

function ShaSpawnEtc(pUnit, Event)
	pUnit:RegisterEvent("AddsAttackKeymaster", 800, 1)
end

RegisterUnitEvent(500091, 18, "ShaSpawnEtc")

-- Kegmaster

function KegmasterE(pUnit, Event)
	if Event == 1 then
		if pUnit:GetEntry() == 240571 then
			pUnit:SendChatMessage(14,0,"You cannot hope to defeat me!")
			--pUnit:PlaySoundToSet(50015)
			pUnit:RegisterEvent("WhirlwindSpama", 12000, 0)
			WhirlwindSpama(pUnit)
		else
			pUnit:SendChatMessage(14,0,"Fools!")
			pUnit:RegisterEvent("WaterBoltSpama", 8000, 0)
			WaterBoltSpama(pUnit)
		end
	else
		pUnit:RemoveEvents()
	end
end

function WhirlwindSpama(pUnit)
	pUnit:FullCastSpell(55266)
end

function WaterBoltSpama(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(61375, plr)
	end
end

RegisterUnitEvent(240571, 1, "KegmasterE")
RegisterUnitEvent(240571, 2, "KegmasterE")
RegisterUnitEvent(240571, 4, "KegmasterE")
RegisterUnitEvent(240541, 1, "KegmasterE")
RegisterUnitEvent(240541, 2, "KegmasterE")
RegisterUnitEvent(240541, 4, "KegmasterE")

--

function Oragnaktor_Events(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("ORAGNAKTOR_BERSERK", 420000, 1)
pUnit:RegisterEvent("ORAGNAKTOR_LOOP", 222000, 1)
pUnit:RegisterEvent("Oragnaktor_AcidSpit", math.random(2500,4200), 0)
pUnit:RegisterEvent("Oragnaktor_SprayRandom", math.random(12000,18000), 0)
pUnit:RegisterEvent("Oragnaktor_Bite", math.random(8000,14000), 0)
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
		players:PlayMusicToPlayer(50109)
		end
	end
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:Despawn(2000,5000)
 local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	players:PlayMusicToPlayer(0)
	end
		end
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 9)
elseif Event == 4 then
pUnit:RemoveEvents()
 local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	players:PlayMusicToPlayer(50084)
	end
		end
		end
end

function ORAGNAKTOR_LOOP(pUnit)
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
		players:PlayMusicToPlayer(50109)
		end
	end
end

function ORAGNAKTOR_BERSERK(pUnit)
pUnit:CastSpell(68335)
end


function Oragnaktor_AcidSpit(pUnit) -- ranged attack
local plr = pUnit:GetMainTank()
	if plr then
		if pUnit:GetDistanceYards(plr) < 40 then
		if not plr:GetCurrentSpellId() then
			pUnit:FullCastSpellOnTarget(66880, plr)
		end
		end
	end
end

function Oragnaktor_SprayRandom(pUnit)
	local plr = pUnit:GetRandomPlayer(0) 
	if plr then
	if pUnit:GetDistanceYards(plr) < 40 and plr:IsInCombat() then
		pUnit:FullCastSpellOnTarget(66901, plr) 
		pUnit:SpawnCreature(957819, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 35, 30000)
	end
end
	end

function Oragnaktor_Bite(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
	if pUnit:GetDistanceYards(plr) < 7 and plr:IsAlive() then
		pUnit:CastSpellOnTarget(66824, plr) 
	end
end
	end
	
	function Oragnaktor_CHECKRANGE(pUnit)
 local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) > 20 and players:IsAlive() then
	pUnit:CastSpell(68335)
	end
		end
			end
			
			function Oragnaktor_Slime_spawn(pUnit,Event)
pUnit:CastSpell(45212)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("Oragnaktor_Slime_Damage", 1000, 0)
end

RegisterUnitEvent(957819, 18, "Oragnaktor_Slime_spawn")


function Oragnaktor_Slime_Damage(pUnit,Event)
	pUnit:CastSpell(45212)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 5 then
  if not players:HasAura(49870) then
  players:CastSpell(49870)
  end
pUnit:Strike(players,1,69508,240,260,2)
end
end
end

	
RegisterUnitEvent(35144, 1, "Oragnaktor_Events")
RegisterUnitEvent(35144, 2, "Oragnaktor_Events")
RegisterUnitEvent(35144, 4, "Oragnaktor_Events")