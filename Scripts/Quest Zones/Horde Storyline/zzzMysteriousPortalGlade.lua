
local player = nil
local Dummy = nil
local Drake = nil

function Ohai_Trigger_Spawn_SPAWN(pUnit, Event)
	pUnit:RegisterEvent("aejheiojahoeaoeaog_oh_la_la", 1500, 0)
end

function aejheiojahoeaoeaog_oh_la_la(pUnit, Event)
	BVZABZ = pUnit:GetClosestPlayer()
	if BVZABZ ~= nil then
		if pUnit:GetDistanceYards(BVZABZ) < 1 then
			if BVZABZ:HasQuest(304) == true or  BVZABZ:HasFinishedQuest(304) == true or BVZABZ:HasQuest(1103) == true or  BVZABZ:HasFinishedQuest(1103) == true then
			pUnit:RemoveEvents()
			player = BVZABZ
			npc = pUnit
			player:SetPlayerLock(true)
			player:CastSpell(44681) -- Camera Shake
			pUnit:RegisterEvent("camera_shake_Spamz", 4000, 0)
			pUnit:RegisterEvent("test_omnomnomnomnomnommmm", 5000, 1)
			end
		end
	end
end

RegisterUnitEvent(158801, 18, "Ohai_Trigger_Spawn_SPAWN")

function camera_shake_Spamz(pUnit, Event)
	player:CastSpell(44681) -- Camera shake spam
end

function test_omnomnomnomnomnommmm(pUnit, Event)
	player:Emote(383, 20000) -- Emote
	Dummy:ChannelSpell(48316, player)
	pUnit:ChannelSpell(52388, Dummy)
	pUnit:RegisterEvent("let_the_player_animation_freeze_halfway_through_emote", 1500, 1)
end

function let_the_player_animation_freeze_halfway_through_emote(pUnit, Event)
	if Dummy ~= nil and player ~= nil then
	player:Emote(383, 30000) -- Emote
	pUnit:MoveTo(player:GetX(),player:GetY(),player:GetZ()+2.5, player:GetO())
	player:CastSpell(16245) -- Freeze animation
	player:MovePlayerTo(player:GetX(),player:GetY(),player:GetZ()+5, player:GetO(), 12288)
	player:Emote(383, 30000) -- Emote
	pUnit:RegisterEvent("ohlalalalla_eagiogh_asgihea_eagieah", 2000, 1)
	pUnit:RegisterEvent("ohlalalalla_eagiogh_asgihea_eagieahzz", 5000, 1)
	pUnit:RegisterEvent("ohlalalalla_eagiogh_asgihea_eagieahzzz", 6000, 1)
	else
	player = nil
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("aejheiojahoeaoeaog_oh_la_la", 1000, 0)
	end
end

function ohlalalalla_eagiogh_asgihea_eagieah(pUnit, Event)
	player:Emote(383, 30000) -- Emote
	player:RemoveAura(16245)
	Dummy:SetScale(5)
end

function ohlalalalla_eagiogh_asgihea_eagieahzz(pUnit, Event)
	Dummy:CastSpell(41380)
end

function ohlalalalla_eagiogh_asgihea_eagieahzzz(pUnit, Event)
	pUnit:CastSpell(70787)
	pUnit:RegisterEvent("aegjogheagoea_drake_inc", 1000, 1)
end

function aegjogheagoea_drake_inc(pUnit, Event)
	pUnit:SpawnCreature(32491, 8016.6, -2489, 494, 0.445164, 35, 0)
	pUnit:RegisterEvent("uohgeuhguahguih_zzzz_delay_to_takeoff", 3000, 1)
end

function uohgeuhguahguih_zzzz_delay_to_takeoff(pUnit, Event)
	if Dummy ~= nil and player ~= nil and Drake ~= nil then
	Drake:SetMovementFlags(1)
	Drake:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0)
	pUnit:RegisterEvent("jeagihoag_disapear", 8000, 1)
	else
	player = nil
	if Dummy ~= nil then
	Dummy:StopChannel()
	Dummy:SetScale(1)
	end
	if Drake ~= nil then
	Drake:Despawn(1,0)
	end
	pUnit:StopChannel()
	pUnit:ReturnToSpawnPoint()
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("aejheiojahoeaoeaog_oh_la_la", 1000, 0)
	end
end

function jeagihoag_disapear(pUnit, Event)
	Dummy:SetScale(1)
	Drake:Despawn(1,0)
	Dummy:StopChannel()
	pUnit:StopChannel()
	pUnit:RemoveEvents()
	pUnit:ReturnToSpawnPoint()
	pUnit:RegisterEvent("aejheiojahoeaoeaog_oh_la_la", 1500, 0)
	if player ~= nil then
	player:SetPlayerLock(false)
	player:_CreateTaxi()
		local race = player:GetPlayerRace()
		if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then -- Alliance
		player:_AddPathNode(1, 8043.6, -2465, 515)
		player:_AddPathNode(1, 8035, -2522, 534)
		player:_AddPathNode(1, 7998, -2520.7, 539)
		player:_AddPathNode(1, 8021.9, -2472.8, 531.1)
		player:_AddPathNode(1, 8066, -2442.9, 532)
		player:_AddPathNode(1, 8066, -2442.9, 532)
		player:_AddPathNode(0, 1297, -2566.9, 160)
		player:_AddPathNode(0, 1254, -2591, 160)
		player:_AddPathNode(0, 1157, -2614, 93)
		player:_AddPathNode(0, 1105, -2565, 75)
		player:_AddPathNode(0, 1079, -2536, 69)
		player:_AddPathNode(0, 1046, -2523, 63)
		player:_AddPathNode(0, 1008, -2506, 69)
		player:_AddPathNode(0, 976, -2505, 62)
		player:_AddPathNode(0, 976, -2505, 62)
		else
		player:_AddPathNode(1, 8043.6, -2465, 515)
		player:_AddPathNode(1, 8035, -2522, 534)
		player:_AddPathNode(1, 7998, -2520.7, 539)
		player:_AddPathNode(1, 8021.9, -2472.8, 531.1)
		player:_AddPathNode(1, 8066, -2442.9, 532)
		player:_AddPathNode(1, 8066, -2442.9, 532)
		player:_AddPathNode(0, -7090, -1197, 381.3)
		player:_AddPathNode(0, -7105, -1149, 388)
		player:_AddPathNode(0, -7152, -1177, 376)
		player:_AddPathNode(0, -7126, -1224, 372)
		player:_AddPathNode(0, -7056, -1218, 386)
		player:_AddPathNode(0, -7041, -1137, 364)
		player:_AddPathNode(0, -7217, -1069, 315)
		player:_AddPathNode(0, -7339, -1106, 290)
		player:_AddPathNode(0, -7377, -1096, 282) -- enter mountain
		player:_AddPathNode(0, -7404, -1104, 282)
		player:_AddPathNode(0, -7419, -1062, 277)
		player:_AddPathNode(0, -7456, -1062, 270)
		player:_AddPathNode(0, -7546, -1093, 271)
		player:_AddPathNode(0, -7586, -1147, 278)
		player:_AddPathNode(0, -7627, -1176, 258)
		player:_AddPathNode(0, -7669, -1105, 230)
		player:_AddPathNode(0, -7711, -1088, 221)
		player:_AddPathNode(0, -7739, -1088, 219)
		player:_AddPathNode(0, -7750, -1121, 221)
		player:_AddPathNode(0, -7835, -1136, 222)
		player:_AddPathNode(0, -8081, -987, 239)
		player:_AddPathNode(0, -8063, -806, 162)
		player:_AddPathNode(0, -8150, -752, 142)
		player:_AddPathNode(0, -8163, -754, 135)
		player:_AddPathNode(0, -8163, -754, 137)
		end
	player:_StartTaxi(28045)
	player:Emote(0, 1000) -- repair emote bug, test only
	player = nil
	end
end

------------------------------------------------------

function Dummy_Visual_NPCzz(pUnit, Event)
	Dummy = pUnit
end

RegisterUnitEvent(158802, 18, "Dummy_Visual_NPCzz")

function zDummy_Visual_NPCzz(pUnit, Event)
	Drake = pUnit
end

RegisterUnitEvent(32491, 18, "zDummy_Visual_NPCzz")