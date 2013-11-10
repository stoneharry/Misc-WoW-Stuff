
-- By Stoneharry

-- 72313 -- nice visual -- cast on people

-- 65684 ground visual, player stand on it
-- 70763 -- good portal
-- 60285 -- dat visual

-- Variables

TOC = {}
TOC.VAR = {}

local debugmode = false

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 -- Size: 1, Type: BYTES, Flags: PUBLIC
-- 3rd boss flags
local UNIT_FIELD_CHARMEDBY = OBJECT_END + 0x0006
local UNIT_FIELD_CHARM = OBJECT_END + 0x0000
local UNIT_FLAG_PVP_ATTACKABLE = 0x00000008
local UNIT_FLAG_PLAYER_CONTROLLED_CREATURE = 0x01000000
local UNIT_END = OBJECT_END + 0x008E
local PLAYER_DUEL_TEAM = UNIT_END + 0x0008
local PLAYER_DUEL_ARBITER = UNIT_END + 0x0000

-- Gossip to start

function TOC.VAR.Tournament_start_Gossipc(pUnit, event, player)
	pUnit:GossipCreateMenu(12733, player, 0)
	pUnit:GossipMenuAddItem(9, "Let us begin this tournament.", 424, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 526, 0)
	pUnit:GossipSendMenu(player)
end


function TOC.VAR.Tournament_start_Gossipm(pUnit, event, player, id, intid, code)
	player:GossipComplete()
	if(intid == 424) then
		pUnit:SetNPCFlags(2)
		pUnit:Emote(2, 0)
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		TOC[id] = TOC[id] or {VAR={}}
		TOC[id].VAR.ready = true
	end
end

RegisterUnitGossipEvent(27060, 1, "TOC.VAR.Tournament_start_Gossipc")
RegisterUnitGossipEvent(27060, 2, "TOC.VAR.Tournament_start_Gossipm")

function TOC.VAR.Tournament_starter_Spawn(pUnit, Event)
	pUnit:SetNPCFlags(1)
	pUnit:RegisterEvent("TOC.VAR.CheckToBegin_Tournament_Starter", 5000, 0)
end

function TOC.VAR.CheckToBegin_Tournament_Starter(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id] = TOC[id] or {VAR={}}
	if TOC[id].VAR.ready then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("TOC.VAR.RunAwayEtc_LoL_Courier", 3000, 1)
	end
end

function TOC.VAR.RunAwayEtc_LoL_Courier(pUnit)
	pUnit:SetMovementFlags(1)
	pUnit:MoveTo(563, 86, 395.3, 0)
	pUnit:Despawn(6000, 0)
end

RegisterUnitEvent(27060, 18, "TOC.VAR.Tournament_starter_Spawn")

-- Tirion Fordwing

function TOC.VAR.Tirion_Spawn_Events(pUnit, Event)
	pUnit:RegisterEvent("TOC.VAR.Tirion_CheckToStart_Tournament", 8000, 0)
end

function TOC.VAR.Tirion_CheckToStart_Tournament(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id] = TOC[id] or {VAR={}}
	if TOC[id].VAR.ready then
		pUnit:RemoveEvents()
		TOC[id].VAR.count = 0
		pUnit:PlaySoundToSet(15852)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 10000, 1)
	end
end

function TOC.VAR.TirionSendMessagesEtc(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id].VAR.count = TOC[id].VAR.count + 1
	if debugmode then
		if TOC[id].VAR.count < 5 then
			TOC[id].VAR.count = 18 -- 15 = boss 2, 18 = boss 3
		end
	end
	if TOC[id].VAR.count == 1 then
		pUnit:SendChatMessage(14,0,"Welcome to the trials of the crusader. Only the most powerful companions of Azeroth are allowed to undergo these trials. You are among the worthy few.")
		pUnit:PlaySoundToSet(16053)
		pUnit:Emote(1, 4000)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 12000, 1)
	elseif TOC[id].VAR.count == 2 then
		pUnit:SendChatMessage(14,0,"Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry!")
		pUnit:PlaySoundToSet(16043)
		pUnit:Emote(1, 3000)
		pUnit:SpawnCreature(35476, 563.7, 89.8, 395.3, 1.587163, 35, 0)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 1000, 1)
	elseif TOC[id].VAR.count == 3 then
		TOC[id].VAR.gnome = pUnit:GetCreatureNearestCoords(563.7, 89.8, 395.3, 35476)
		TOC[id].VAR.gnome:SetMovementFlags(1)
		TOC[id].VAR.gnome:MoveTo(563.52, 135, 394.3, 0)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 7500, 1)
	elseif TOC[id].VAR.count == 4 then
		TOC[id].VAR.gnome:SendChatMessage(14,0,"Thank you, Highlord! Now challengers, I will begin the ritual of summoning! When I am done, a fearsome Doomguard will appear!")
		TOC[id].VAR.gnome:PlaySoundToSet(16268)
		TOC[id].VAR.gnome:Emote(1,4000)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 7000, 1)
	elseif TOC[id].VAR.count == 5 then
		TOC[id].VAR.portal = pUnit:GetCreatureNearestCoords(563.9, 149, 394, 21862)
		TOC[id].VAR.gnome:ChannelSpell(48185, TOC[id].VAR.portal)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 12000, 1)
	elseif TOC[id].VAR.count == 6 then
		TOC[id].VAR.gnome:PlaySoundToSet(16269)
		TOC[id].VAR.gnome:StopChannel()
		TOC[id].VAR.gnome:SendChatMessage(14,0,"Prepare for oblivion!")
		TOC[id].VAR.portal:CastSpell(40280) -- visual
		TOC[id].VAR.portal:SetScale(1.5)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 2000, 1)
	elseif TOC[id].VAR.count == 7 then
		TOC[id].VAR.Jarax = pUnit:SpawnCreature(34780, 564, 147.3, 394, 4.72, 21, 0, 29981)
		TOC[id].VAR.Jarax:SetUInt32Value(UNIT_FIELD_FLAGS, 2) -- unattackable
		pUnit:SendChatMessage(16, 0, "A portal opens, and Lord Jaraxxus - clearly not a doomguard - enters the arena.")
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 3000, 1)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Visualc", 1500, 1)
	elseif TOC[id].VAR.count == 8 then
		TOC[id].VAR.gnome:Emote(4,0)
		TOC[id].VAR.gnome:SendChatMessage(14,0,"Ah ha, I have done it! Behold the absolute power of Wilfred Fizzlebang, master summoner! You are bound to ME, demon!")
		TOC[id].VAR.gnome:PlaySoundToSet(16270)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 12000, 1)
	elseif TOC[id].VAR.count == 9 then
		TOC[id].VAR.Jarax:SendChatMessage(14,0,"Trifling gnome, your arrogance will be your undoing!")
		TOC[id].VAR.Jarax:PlaySoundToSet(16143)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 6500, 1)
	elseif TOC[id].VAR.count == 10 then
		TOC[id].VAR.gnome:SendChatMessage(14,0,"But I'm in charge her-")
		TOC[id].VAR.gnome:PlaySoundToSet(16271)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 1000, 1)
	elseif TOC[id].VAR.count == 11 then
		TOC[id].VAR.Jarax:CastSpell(58538) -- visual
		TOC[id].VAR.Jarax:StopChannel()
		TOC[id].VAR.gnome:MoveKnockback(554.8, 85.4, 395.2, 3,4)
		pUnit:SendChatMessage(16, 0, "Lord Jaraxxus kills the Grand Warlock - the gnome's last breath an agonized scream.")
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 1000, 1)
	elseif TOC[id].VAR.count == 12 then
		TOC[id].VAR.gnome:CastSpell(11)
		pUnit:SendChatMessage(14,0,"Quickly, heroes! Destroy the demon lord before it can open a portal to its twisted demonic realm!")
		pUnit:PlaySoundToSet(16044)
		TOC[id].VAR.portal:RemoveAura(40280)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 6000, 1)
	elseif TOC[id].VAR.count == 13 then
		TOC[id].VAR.Jarax:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		TOC[id].VAR.Jarax:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 3000, 1)
	elseif TOC[id].VAR.count == 14 then
		if TOC[id].VAR.jaraxdead then
			TOC[id].VAR.count = TOC[id].VAR.count + 1
		end
		TOC[id].VAR.count = TOC[id].VAR.count - 1
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 6000, 1)
	elseif TOC[id].VAR.count == 15 then
		pUnit:Emote(1,4000)
		pUnit:SendChatMessage(14,0,"The loss of Wilfred Fizzlebang, while unfortunate, should be a lesson to those that dare dabble in dark magic. Alas, you are victorious and must now face the next challenge.")
		pUnit:SendChatMessage(42,0,"Warning : You can only attempt the next boss once. The vehicles that aid you do not respawn.")
		pUnit:PlaySoundToSet(16045)
		pUnit:SpawnCreature(33412, 563.6, 172.2, 394.6, 4.756226, 35, 0):SetUInt32Value(UNIT_FIELD_FLAGS, 2) -- unattackable
		local faction = nil
		for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			faction = plrs:GetFaction()
			break
		end
		if faction ~= nil then
			pUnit:SpawnCreature(280211, 563.6, 99, 394.7, 1.556860, faction, 0)
			pUnit:SpawnCreature(280213, 563.6, 90, 395.3, 1.556860, faction, 0)
			pUnit:SpawnCreature(280213, 556.5, 94.5, 395.3, 1.374647, faction, 0)
			pUnit:SpawnCreature(280212, 551.5, 95.6, 395.3, 1.374647, faction, 0)
			pUnit:SpawnCreature(280212, 545, 97, 395.3, 1.303961, faction, 0)
		end
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 6000, 1)
	elseif TOC[id].VAR.count == 16 then
		if TOC[id].VAR.xtdead then
			TOC[id].VAR.count = TOC[id].VAR.count + 1
		end
		TOC[id].VAR.count = TOC[id].VAR.count - 1
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 6000, 1)
	elseif TOC[id].VAR.count == 17 then
		pUnit:RegisterEvent("TOC.VAR.TirionSendMessagesEtc", 5000, 1)
	elseif TOC[id].VAR.count == 18 then
		local object = pUnit:GetGameObjectNearestCoords(563.4, 177.8, 398.8, 195527)
		if object ~= nil then
			object:SetUInt32Value(0x0006+0x0003,0x200) -- damaged
		end
		for _,units in pairs(pUnit:GetInRangeUnits()) do
			if not units:IsPlayer() then
				units:RemoveEvents()
				units:Despawn(1,0)
			end
		end
		pUnit:SpawnGameObject(195709, 616.3, 136.3, 139, 3.111200, 300000, 200) -- 2nd boss loot
		pUnit:SpawnCreature(252691, 789.56, 134.7, 142.64, 3.112541, 21, 0) -- 3rd boss
	end
	
end

function TOC.VAR.Jaraxxus_Visualc(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id].VAR.Jarax:ChannelSpell(67924, TOC[id].VAR.Jarax)
end

-- 16037 -- Let the games begin!

RegisterUnitEvent(24232, 18, "TOC.VAR.Tirion_Spawn_Events")

-- Jaraxxus

function TOC.VAR.JaraxussEventsHandler(pUnit, Event)
	if Event == 1 then
		pUnit:PlaySoundToSet(16144) -- voice
		pUnit:SendChatMessage(14,0,"You face Jaraxxus, eredar lord of the Burning Legion!")
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Buffself", 6000, 1)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Cleave", 7000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Flamestrike", 11000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_RandomFelfireBolt", 8000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxuss_PathOfFire", 15000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxuss_FireEverywhere", 2000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(16146)
		pUnit:SendChatMessage(14,0,"Banished to the Nether!")
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(16147)
		pUnit:SendChatMessage(14,0,"Another will take my place. Your world is doomed.")
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		TOC[id].VAR.jaraxdead = true
	end
end

function TOC.VAR.Jaraxuss_FireEverywhere(pUnit)
	if pUnit:GetHealthPct() < 60 then
		pUnit:RemoveEvents()
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		TOC[id].VAR.chaos = true
		TOC[id].VAR.chaosplayers = {}
		TOC[id].VAR.chaosid = 0
		local count = 0
		for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			count = count + 1
			table.insert(TOC[id].VAR.chaosplayers, plrs)
		end
		for i=1,count do
			pUnit:SpawnCreature(68333, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 30000):SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		end
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_ResetChaos", 3000, 1)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Buffself", 6000, 1)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Cleave", 7000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Flamestrike", 5000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_RandomFelfireBolt", 8000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxuss_PathOfFire", 15000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxuss_FireEverywhere_PartTwo", 2000, 0)
	end
end

function TOC.VAR.Jaraxuss_FireEverywhere_PartTwo(pUnit)
	if pUnit:GetHealthPct() < 20 then
		pUnit:RemoveEvents()
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		TOC[id].VAR.chaos = true
		TOC[id].VAR.chaosplayers = {}
		TOC[id].VAR.chaosid = 0
		local count = 0
		for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			count = count + 1
			table.insert(TOC[id].VAR.chaosplayers, plrs)
		end
		for i=1,count do
			pUnit:SpawnCreature(68333, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 30000):SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		end
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Chaos", 3000, 1)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_ResetChaos", 6000, 1)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Buffself", 1000, 1)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Cleave", 7000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Flamestrike", 5000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxxus_RandomFelfireBolt", 8000, 0)
		pUnit:RegisterEvent("TOC.VAR.Jaraxuss_PathOfFire", 10000, 0)
	end
end

function TOC.VAR.Jaraxxus_Chaos(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id].VAR.chaosplayers = {}
	TOC[id].VAR.chaosid = 0
	local count = 0
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		count = count + 1
		table.insert(TOC[id].VAR.chaosplayers, plrs)
	end
	for i=1,count do
		pUnit:SpawnCreature(68333, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 30000):SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	end
end

function TOC.VAR.Jaraxxus_ResetChaos(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id].VAR.chaos = false
	TOC[id].VAR.chaosid = 0
	TOC[id].VAR.chaosplayers = {}
end

function TOC.VAR.Jaraxxus_Buffself(pUnit)
	pUnit:FullCastSpell(67108) -- +20% spell damage, stacks
	pUnit:RegisterEvent("TOC.VAR.Jaraxxus_Buffself", math.random(10000,50000), 1)
end

function TOC.VAR.Jaraxxus_Cleave(pUnit)
	local plr = pUnit:GetMainTank()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(38742, plr)
	end
end

function TOC.VAR.Jaraxxus_Flamestrike(pUnit)
	if math.random(1,2) == 1 then
		local choice = math.random(1,2)
		if choice == 1 then
			pUnit:SendChatMessage(16,0,"Lord Jaraxxus laughs maniacally.")
			pUnit:PlaySoundToSet(16148)
		else
			pUnit:SendChatMessage(14,0,"Inferno!")
			pUnit:PlaySoundToSet(16151)
		end
	end
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 39139)
	end
end

function TOC.VAR.Jaraxxus_RandomFelfireBolt(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:CastSpellOnTarget(36404, plr)
	end
end

function TOC.VAR.Jaraxuss_PathOfFire(pUnit)
	pUnit:SpawnCreature(68333, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 30000):SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(34780, 1, "TOC.VAR.JaraxussEventsHandler")
RegisterUnitEvent(34780, 2, "TOC.VAR.JaraxussEventsHandler")
RegisterUnitEvent(34780, 4, "TOC.VAR.JaraxussEventsHandler")

-- path of fire

function TOC.VAR.Jaraxxus_PathOfFireSpawn(pUnit, Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id] = TOC[id] or {VAR={}}
	if TOC[id].VAR.chaos then
		TOC[id].VAR.chaosid = TOC[id].VAR.chaosid + 1
		local plrs = TOC[id].VAR.chaosplayers[TOC[id].VAR.chaosid]
		if plrs ~= nil then
			pUnit:SetMovementFlags(1)
			pUnit:MoveTo(plrs:GetX(), plrs:GetY(), plrs:GetZ(), 0)
			pUnit:RegisterEvent("TOC.VAR.SpawnMoreStaticFiresJarax", 700, 14)
		end
	else
		local range = 0
		local target = nil
		for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			if plrs:GetDistanceYards(pUnit) > range then
				range = plrs:GetDistanceYards(pUnit)
				target = plrs
			end
		end
		if target ~= nil then
			pUnit:SetMovementFlags(1)
			pUnit:MoveTo(target:GetX(), target:GetY(), target:GetZ(), 0)
			pUnit:RegisterEvent("TOC.VAR.SpawnMoreStaticFiresJarax", 700, 14)
		end
	end
end

function TOC.VAR.SpawnMoreStaticFiresJarax(pUnit)
	if not pUnit:IsCreatureMoving() then
		pUnit:RemoveEvents()
	end
	pUnit:SpawnCreature(68334, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 20000):SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(68333, 18, "TOC.VAR.Jaraxxus_PathOfFireSpawn")

function TOC.VAR.Jaraxxus_DealDamageSpawn(pUnit, Event)
	pUnit:RegisterEvent("TOC.VAR.FireVisualStuff", 1100, 1)
	pUnit:RegisterEvent("TOC.VAR.FireVisualStuff_Damage", 1000, 19)
end

function TOC.VAR.FireVisualStuff_Damage(pUnit)
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:GetDistanceYards(pUnit) < 7 then
			pUnit:Strike(plrs, 2, 67060, 75, 150, 1)
		end
	end
end

function TOC.VAR.FireVisualStuff(pUnit)
	pUnit:SetScale(5)
	pUnit:FullCastSpell(36006)
end

RegisterUnitEvent(68334, 18, "TOC.VAR.Jaraxxus_DealDamageSpawn")

-- Gossip to start 2nd boss

function TOC.VAR.Tournament_start_Gossipd(pUnit, event, player)
	pUnit:GossipCreateMenu(12734, player, 0)
	pUnit:GossipMenuAddItem(9, "We accept.", 424, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 526, 0)
	pUnit:GossipSendMenu(player)
end


function TOC.VAR.Tournament_start_Gossipg(pUnit, event, player, id, intid, code)
	player:GossipComplete()
	if(intid == 424) then
		pUnit:SetNPCFlags(2)
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		TOC[id] = TOC[id] or {VAR={}}
		TOC[id].VAR.readytwo = true
		pUnit:SetFaction(21)
	end
end

RegisterUnitGossipEvent(33412, 1, "TOC.VAR.Tournament_start_Gossipd")
RegisterUnitGossipEvent(33412, 2, "TOC.VAR.Tournament_start_Gossipg")

function TOC.VAR.TournamentSecondBoss(pUnit, Event)
	pUnit:SetNPCFlags(1)
	pUnit:SetFaction(15)
	pUnit:RegisterEvent("TOC.VAR.CheckToStartsecondBoss", 5000, 0)
end

function TOC.VAR.CheckToStartsecondBoss(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id] = TOC[id] or {VAR={}}
	if TOC[id].VAR.readytwo then
		pUnit:RemoveEvents()
		TOC[id].VAR.xt = pUnit:SpawnCreature(1133293, 563.844, 265.08, 395, 4.724016, 21, 0)
		TOC[id].VAR.xt:SetUInt32Value(UNIT_FIELD_FLAGS, 2) -- unattackable
		pUnit:RegisterEvent("TOC.VAR.LolSpawnXT200", 2000, 1)
	end
end

function TOC.VAR.LolSpawnXT200(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id] = TOC[id] or {VAR={}}
	TOC[id].VAR.xt:SetMovementFlags(1)
	TOC[id].VAR.xt:MoveTo(563.38, 190.17, 394.62, 0)
	pUnit:GetGameObjectNearestCoords(564.5, 213.3, 395.2, 195647):SetByte(0x0006+0x000B,0,0) -- Open
	pUnit:RegisterEvent("TOC.VAR.LolOpenXT200", 11000, 1)
	pUnit:RegisterEvent("TOC.VAR.LolGetInXT200", 14000, 1)
	pUnit:RegisterEvent("TOC.VAR.LolGetGoingXT200", 17000, 1)
	pUnit:RegisterEvent("TOC.VAR.LolGoGoGOXT", 21000, 1)
end

function TOC.VAR.LolOpenXT200(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id].VAR.xt:SetUInt32Value(UNIT_FIELD_BYTES_1, 9) -- kneel
	pUnit:GetGameObjectNearestCoords(564.5, 213.3, 395.2, 195647):SetByte(0x0006+0x000B,0,1)
end

function TOC.VAR.LolGetInXT200(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	pUnit:EnterVehicle(TOC[id].VAR.xt, 1000)
end

function TOC.VAR.LolGetGoingXT200(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id].VAR.xt:SetUInt32Value(UNIT_FIELD_BYTES_1, 0) -- get up
end

function TOC.VAR.LolGoGoGOXT(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id].VAR.xt:MoveCharge(564, 155.31, 394.4)
	pUnit:RegisterEvent("TOC.VAR.BeginXTFight", 2000, 1)
end

function TOC.VAR.BeginXTFight(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	--TOC[id].VAR.xt:SetPosition(563, 141, 393.909, 4.711210)
	TOC[id].VAR.xt:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

RegisterUnitEvent(33412, 18, "TOC.VAR.TournamentSecondBoss")

-- 2nd Boss

local TopSpawns = {
	[1] = { -- alliance flag
		{33350, 606.15, 170.5, 417.5, 3.829799, 21, 300000},
		{33350, 617.63, 145.7, 416.5, 3.327062, 21, 300000},
		{33350, 617.89, 132.737, 416.5, 3.048250, 21, 300000}
	},
	[2] = {
		{33350, 605.45, 106.82, 417.5, 2.429357, 21, 300000},
		{33350, 600.83, 101.45, 417.5, 2.441138, 21, 300000},
		{33350, 594.86, 96.459, 417.5, 2.297408, 21, 300000}
	},
	-- between 2 & 3 = center
	[3] = {
		{33350, 569.39, 85.18, 416.5, 1.903139, 21, 300000},
		{33350, 556.74, 85.3, 416.5, 1.491590, 21, 300000},
		{33350, 532, 96.7, 417.5, 0.875837, 21, 300000}
	},
	[4] = { -- horde flag
		{33350, 520.7, 107.8, 417.5, 0.632363, 21, 300000},
		{33350, 509.4, 133.5, 416.5, 0.048419, 21, 300000},
		{33350, 509.2, 146, 416.5, 6.157244, 21, 300000}
	}
}

function TOC.VAR.XTEnterEventAndStuff(pUnit, Event)
	if Event == 1 then
		pUnit:SendChatMessage(14,0,"New toys? For me? I promise I won't break them this time!")
		pUnit:PlaySoundToSet(15724)
		pUnit:RegisterEvent("TOC.VAR.Stun_Everyone_Baddass_Boss", 40000, 0)
		pUnit:RegisterEvent("TOC.VAR.pewpewmaintandana", 25000, 0)
		pUnit:RegisterEvent("TOC.VAR.slamthegrounda", 33000, 0)
		pUnit:RegisterEvent("TOC.VAR.SpawnTrashConstantly", 5000, 0)
		pUnit:RegisterEvent("TOC.VAR.CheckForWIPEXT", 3000, 0)
		pUnit:RegisterEvent("TOC.VAR.XTplayerscastself", 24000, 0)
		pUnit:RegisterEvent("TOC.VAR.SendRandomMessagesRandomlyXT", 5000, 0)
	elseif Event == 4 then
		pUnit:PlaySoundToSet(15731)
		pUnit:SendChatMessage(14,0,"You are bad... Toys... Very... Baaaaad!")
		pUnit:RemoveEvents()
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			if not unit:IsPlayer() then
				if unit:GetEntry() == 280211 or unit:GetEntry() == 280212 or unit:GetEntry() == 280213 then
					unit:Kill(unit)
				elseif unit:GetEntry() == 33350 then
					unit:Despawn(1,0)
				end
			end
		end
	end
end

function TOC.VAR.SendRandomMessagesRandomlyXT(pUnit)
	if math.random(1,4) == 1 then
		local choice = math.random(1,3)
		if choice == 1 then
			pUnit:SendChatMessage(14,0,"I guess it doesn't bend that way.")
			pUnit:PlaySoundToSet(15729)
		elseif choice == 2 then
			pUnit:SendChatMessage(14,0,"I'm tired of these toys. I don't want to play anymore!")
			pUnit:PlaySoundToSet(15730)
		elseif choice == 3 then
			pUnit:SendChatMessage(14,0,"Time for a new game! My old toys will fight my new toys!")
			pUnit:PlaySoundToSet(15732)
		end
	end
end

function TOC.VAR.XTplayerscastself(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		if plr:GetVehicleBase() ~= nil then
			plr:GetVehicleBase():FullCastSpell(63025)
		else
			plr:FullCastSpell(63025)
		end
	end
end

function TOC.VAR.CheckForWIPEXT(pUnit)
	local found = false
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:IsAlive() then
			found = true
			break
		end
	end
	if not found then
		pUnit:PlaySoundToSet(15728)
		pUnit:SendChatMessage(14,0,"I... I think I broke it.")
		pUnit:RemoveEvents()
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			if not unit:IsPlayer() then
				unit:Despawn(1,0)
			end
		end
		pUnit:SendChatMessage(42,0,"You have failed.")
		pUnit:Despawn(2000, 0)
	end
end

function TOC.VAR.Stun_Everyone_Baddass_Boss(pUnit)
	if not pUnit:IsCasting() then
		local plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			pUnit:FullCastSpellOnTarget(38052, plr)
		end
	end
end

function TOC.VAR.pewpewmaintandana(pUnit)
	if not pUnit:IsCasting() then
		pUnit:FullCastSpell(25322)
		pUnit:SendChatMessage(14,0,"I'm ready to play!")
		pUnit:PlaySoundToSet(15726)
	end
end

function TOC.VAR.slamthegrounda(pUnit)
	pUnit:Root()
	pUnit:SendChatMessage(14,0,"NO! NO! NO! NO! NO!")
	pUnit:PlaySoundToSet(15727)
	pUnit:FullCastSpell(62776)
	pUnit:RegisterEvent("TOC.VAR.unrootBossXT", 8000, 1)
end

function TOC.VAR.unrootBossXT(pUnit)
	pUnit:Unroot()
end

RegisterUnitEvent(1133293, 1, "TOC.VAR.XTEnterEventAndStuff")
RegisterUnitEvent(1133293, 4, "TOC.VAR.XTEnterEventAndStuff")

function TOC.VAR.SpawnTrashConstantly(pUnit)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if not unit:IsPlayer() then
			if not unit:IsAlive() then
				unit:Despawn(1, 0)
			end
		end
	end
	local chance = math.random(1,100)
	if chance < 26 then
		chance = 1
	elseif chance < 51 then
		chance = 2
	elseif chance < 76 then
		chance = 3
	elseif chance < 101 then
		chance = 4
	end
	local tbl = TopSpawns[chance]
	for info in pairs(tbl) do
		pUnit:SpawnCreature(unpack(tbl[info])):SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	end
end

function TOC.VAR.TrashSpawnedFoRXT(pUnit, Event)
	pUnit:RegisterEvent("TOC.VAR.trashXTJump", math.random(1000, 4000), 1)
end

function TOC.VAR.trashXTJump(pUnit)
	local a = pUnit:CalcToDistance(589.75, 139.4, 394.4)
	local b = pUnit:CalcToDistance(563.5, 113.8, 394.4)
	local c = pUnit:CalcToDistance(537.4, 139.3, 394.4)
	local answer = 1
	if b < a then
		answer = 2
	end
	if c < a then
		answer = 3
	end
	if answer == 1 then
		pUnit:MoveJump(589.75+math.random(0,2), 139.4+math.random(0,2), 394.4)
	elseif answer == 2 then
		pUnit:MoveJump(563.5+math.random(0,2), 113.8+math.random(0,2), 394.4)
	elseif answer == 3 then
		pUnit:MoveJump(537.4+math.random(0,2), 139.3+math.random(0,2), 394.4)
	end
	pUnit:RegisterEvent("TOC.VAR.trashSetHostileXT", 3000, 1)
end

function TOC.VAR.trashSetHostileXT(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
	end
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

RegisterUnitEvent(33350, 18, "TOC.VAR.TrashSpawnedFoRXT")

-- 2nd boss main guy death

function TOC.VAR.miniXTEvents(pUnit, Event)
	if Event == 1 then
		pUnit:RegisterEvent("TOC.VAR.MiniDoThingsXT", 3500, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:Despawn(2000, 0)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		TOC[id].VAR.xtdead = true
	end
end

function TOC.VAR.MiniDoThingsXT(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 4069) -- bomb
	end
end

RegisterUnitEvent(33412, 1, "TOC.VAR.miniXTEvents")
RegisterUnitEvent(33412, 2, "TOC.VAR.miniXTEvents")
RegisterUnitEvent(33412, 4, "TOC.VAR.miniXTEvents")

--[[

"This kingdom belongs to the Scourge! Only the dead may enter."

"We are besieged. Strike out and bring back their corpses!"

"They hunger."
"Dinner time, my pets."

"You were foolish to come."
"As Anub'Arak commands!"

14076	10	A_KRIKTHIRKILL01
14077	10	A_KRIKTHIRKILL02
14078	10	A_KRIKTHIRKILL03
14079	10	A_KRIKTHIRSENDGROUP01
14080	10	A_KRIKTHIRSENDGROUP02
14081	10	A_KRIKTHIRSENDGROUP03
14082	10	A_KRIKTHIRPREFIGHT01
14083	10	A_KRIKTHIRPREFIGHT02
14084	10	A_KRIKTHIRPREFIGHT03
14085	10	A_KRIKTHIRSWARM01
14086	10	A_KRIKTHIRSWARM02
]]

-- 3rd boss

function TOC.VAR.thirdbosseventsTOC(pUnit, Event)
	if Event == 1 then
		pUnit:SendChatMessage(14,0,"This kingdom belongs to the Scourge! Only the dead may enter.")
		pUnit:PlaySoundToSet(14075)
		pUnit:RegisterEvent("TOC.VAR.MindControlAPlayer", 5000, 1)
		local object = pUnit:GetGameObjectNearestCoords(665.92, 143.5, 142.1, 195485)
		object:SetByte(GAMEOBJECT_BYTES_1,0,1)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(665.92, 143.5, 142.1, 195485)
		object:SetByte(GAMEOBJECT_BYTES_1,0,0)
	elseif Event == 3 then
	
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"I should be grateful, but I long ago lost the capacity...")
		pUnit:PlaySoundToSet(14087)
		local object = pUnit:GetGameObjectNearestCoords(665.92, 143.5, 142.1, 195485)
		object:SetByte(GAMEOBJECT_BYTES_1,0,0)
		for _,plr in pairs(pUnit:GetInRangePlayers()) do
			if plr:HasAura(45631) then -- mind controlled
				plr:RemoveAura(50224) -- sight visual
				plr:RemoveAura(45631) -- chains self
				local count = 0
				local faction = 0
				while count < 6 and faction == 0 do
					local plr = pUnit:GetRandomPlayer()
					if plr then
						if plr:GetName() ~= plrs:GetName() then
							faction = plr:GetFaction()
						end
					end
					count = count + 1
				end
				if faction ~= 0 then
					plr:SetFaction(faction)
				else
					plr:SetFaction(1) -- to hell with it
				end
				plr:SetPlayerLock(0)
				plr:SetUInt64Value(UNIT_FIELD_CHARMEDBY, 0)
				plr:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
				plr:SetUInt32Value(PLAYER_DUEL_TEAM, 0)
				plr:SetUInt64Value(PLAYER_DUEL_ARBITER,0)
				plr:SetPlayerLock(0)
			end
		end
	end
end

function TOC.VAR.MindControlAPlayer(pUnit)
	if pUnit:GetInRangePlayersCount() > 1 then
		local plr = pUnit:GetRandomPlayer(0)
		local count = 0
		while plr == nil and count < 5 do
			plr = pUnit:GetRandomPlayer(0)
			count = count + 1
		end
		if plr then
			local name = plr:GetName()
			pUnit:SendChatMessage(14,0,"Hush-tak Hee-tah!")
			pUnit:PlaySoundToSet(14078)
			pUnit:SendChatMessage(42,0,name.." has been mind controlled!")
			TOC.VAR.MindControlPlayer(plr, pUnit)
		end
	end
end

function TOC.VAR.MindControlPlayer(plr, pUnit)
	if pUnit:GetMainTank():GetName() == plr:GetName() then
		local c = pUnit:GetRandomPlayer(7) -- not main tank
		if c then
			pUnit:ChangeTarget(c)
		end
	end
	plr:CastSpell(50224) -- sight visual
	plr:CastSpell(45631) -- chains self
	plr:SetPlayerLock(1)
	plr:SetUInt64Value(UNIT_FIELD_CHARMEDBY, pUnit)
	plr:SetFaction(21)
	plr:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PLAYER_CONTROLLED_CREATURE)
	plr:SetUInt32Value(PLAYER_DUEL_TEAM, 1)
	local found = false
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:GetName() ~= plr:GetName() then
			plrs:SetUInt32Value(PLAYER_DUEL_TEAM, 0)
			plrs:SetUInt64Value(PLAYER_DUEL_ARBITER,plr)
			if not found then
				found = true
				plr:SetUInt64Value(PLAYER_DUEL_ARBITER,plrs)
			end
		end
	end
	local count = 0
	local b = nil
	local nam = nil
	while b == nil and count < 5 and nam == nil do
		count = count + 1
		b = pUnit:GetRandomPlayer(0)
		if b then
			if b:GetName() ~= plr:GetName() then
				nam = plr:GetName()
			end
		end
	end
	if b and nam then
		plr:Unroot()
		plr:AttackReaction(b, 250, 11)
	end
 	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id] = TOC[id] or {VAR={}}
	TOC[id].VAR.class = plr:GetPlayerClass()
	TOC[id].VAR.plr = plr
	pUnit:RegisterEvent("TOC.VAR.MindControlPlayer_Actions", 5000, 0)
	pUnit:RegisterEvent("TOC.VAR.MindControlPlayer_Reset", 26000, 1)
end

function TOC.VAR.MindControlPlayer_Actions(pUnit)
 	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id] = TOC[id] or {VAR={}}
	if TOC[id].VAR.plr then
		local count = 0
		local b = nil
		local target = nil
		while b == nil and target == nil and count < 5 do
			count = count + 1
			b = pUnit:GetRandomPlayer(0)
			if b:GetName() ~= TOC[id].VAR.plr:GetName() then
				target = b
			end
		end
		if target then
			TOC[id].VAR.class = string.lower(TOC[id].VAR.class)
			if TOC[id].VAR.class == "warrior" then
				if math.random(1,2) == 1 then
					TOC[id].VAR.plr:StopMovement(4000)
					TOC[id].VAR.plr:FullCastSpellOnTarget(TOC.VAR.getWarriorSpell(), target)
				else
					TOC[id].VAR.plr:MovePlayerTo(target:GetX(), target:GetY(), target:GetZ(), 0, 4096)
				end
			elseif TOC[id].VAR.class == "warlock" then
				if math.random(1,2) == 1 then
					TOC[id].VAR.plr:StopMovement(4000)
					TOC[id].VAR.plr:FullCastSpellOnTarget(TOC.VAR.getWarriorSpell(), target)
				else
					TOC[id].VAR.plr:MovePlayerTo(target:GetX(), target:GetY(), target:GetZ(), 0, 4096)
				end
			elseif TOC[id].VAR.class == "shaman" then
				if math.random(1,2) == 1 then
					TOC[id].VAR.plr:StopMovement(4000)
					TOC[id].VAR.plr:FullCastSpellOnTarget(TOC.VAR.getWarriorSpell(), target)
				else
					TOC[id].VAR.plr:MovePlayerTo(target:GetX(), target:GetY(), target:GetZ(), 0, 4096)
				end
			elseif TOC[id].VAR.class == "rogue" then
				if math.random(1,2) == 1 then
					TOC[id].VAR.plr:StopMovement(4000)
					TOC[id].VAR.plr:FullCastSpellOnTarget(TOC.VAR.getWarriorSpell(), target)
				else
					TOC[id].VAR.plr:MovePlayerTo(target:GetX(), target:GetY(), target:GetZ(), 0, 4096)
				end
			elseif TOC[id].VAR.class == "priest" then
				if math.random(1,2) == 1 then
					TOC[id].VAR.plr:StopMovement(4000)
					TOC[id].VAR.plr:FullCastSpellOnTarget(TOC.VAR.getWarriorSpell(), target)
				else
					TOC[id].VAR.plr:MovePlayerTo(target:GetX(), target:GetY(), target:GetZ(), 0, 4096)
				end
			elseif TOC[id].VAR.class == "paladin" then
				if math.random(1,2) == 1 then
					TOC[id].VAR.plr:StopMovement(4000)
					TOC[id].VAR.plr:FullCastSpellOnTarget(TOC.VAR.getWarriorSpell(), target)
				else
					TOC[id].VAR.plr:MovePlayerTo(target:GetX(), target:GetY(), target:GetZ(), 0, 4096)
				end
			elseif TOC[id].VAR.class == "mage" then
				if math.random(1,2) == 1 then
					TOC[id].VAR.plr:StopMovement(4000)
					TOC[id].VAR.plr:FullCastSpellOnTarget(TOC.VAR.getWarriorSpell(), target)
				else
					TOC[id].VAR.plr:MovePlayerTo(target:GetX(), target:GetY(), target:GetZ(), 0, 4096)
				end
			elseif TOC[id].VAR.class == "hunter" then
				if math.random(1,2) == 1 then
					TOC[id].VAR.plr:StopMovement(4000)
					TOC[id].VAR.plr:FullCastSpellOnTarget(TOC.VAR.getWarriorSpell(), target)
				else
					TOC[id].VAR.plr:MovePlayerTo(target:GetX(), target:GetY(), target:GetZ(), 0, 4096)
				end
			elseif TOC[id].VAR.class == "druid" then
				if math.random(1,2) == 1 then
					TOC[id].VAR.plr:StopMovement(4000)
					TOC[id].VAR.plr:FullCastSpellOnTarget(TOC.VAR.getWarriorSpell(), target)
				else
					TOC[id].VAR.plr:MovePlayerTo(target:GetX(), target:GetY(), target:GetZ(), 0, 4096)
				end
			end
		end
	end
end

function TOC.VAR.getWarriorSpell()

	return 11
end

function TOC.VAR.getWarlockSpell()

	return 11
end

function TOC.VAR.getShamanSpell()

	return 11
end

function TOC.VAR.getRogueSpell()

	return 11
end

function TOC.VAR.getPriestSpell()

	return 11
end

function TOC.VAR.getPaladinSpell()

	return 11
end

function TOC.VAR.getMageSpell()

	return 11
end

function TOC.VAR.getHunterSpell()

	return 11
end

function TOC.VAR.getDruidSpell()

	return 11
end

function TOC.VAR.MindControlPlayer_Reset(pUnit)
 	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOC[id] = TOC[id] or {VAR={}}
	local plr = TOC[id].VAR.plr
	if plr then
		pUnit:SendChatMessageToPlayer(42,0,"You have broken free of Krik'thir's will!", plr)
		plr:RemoveAura(50224) -- sight visual
		plr:RemoveAura(45631) -- chains self
		local count = 0
		local faction = 0
		while count < 6 and faction == 0 do
			local plrs = pUnit:GetRandomPlayer(0)
			if plrs then
				if plr:GetName() ~= plrs:GetName() then
					faction = plrs:GetFaction()
				end
			end
			count = count + 1
		end
		if faction ~= 0 then
			plr:SetFaction(faction)
		else
			plr:SetFaction(1) -- to hell with it
		end
		plr:SetPlayerLock(0)
		plr:SetUInt64Value(UNIT_FIELD_CHARMEDBY, 0)
		plr:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		plr:SetUInt32Value(PLAYER_DUEL_TEAM, 0)
		plr:SetUInt64Value(PLAYER_DUEL_ARBITER,0)
	end
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		plrs:SetUInt64Value(PLAYER_DUEL_ARBITER,0)
	end
	TOC[id].VAR.class = nil
	TOC[id].VAR.plr = nil
	pUnit:RegisterEvent("TOC.VAR.MindControlAPlayer", 5000, 1)
end

RegisterUnitEvent(252691, 1, "TOC.VAR.thirdbosseventsTOC")
RegisterUnitEvent(252691, 2, "TOC.VAR.thirdbosseventsTOC")
RegisterUnitEvent(252691, 3, "TOC.VAR.thirdbosseventsTOC")
RegisterUnitEvent(252691, 4, "TOC.VAR.thirdbosseventsTOC")

