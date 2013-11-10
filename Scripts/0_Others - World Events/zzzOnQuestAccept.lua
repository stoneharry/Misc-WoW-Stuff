local PlayerAA = nil -- To Quest 829
local PPL = nil -- Quest 849

function OnQuestAccept(event, pPlayer, questId, pQuestGiver)
----------------------------------------------------------------------------------------
	if (questId == 1) then
		--pPlayer:PlaySoundToPlayer(50032)
		pQuestGiver:SendChatMessageToPlayer(12,0,"Welcome recruit. I have heard great things about you, let us hope that you can turn the tides of battle for the Alliance!",pPlayer)
	elseif (questId == 5) then
		pPlayer:_CreateTaxi()
		pPlayer:_AddPathNode(0, -8269, -2773, 184)
		pPlayer:_AddPathNode(0, -8138, -2778, 185)
		pPlayer:_AddPathNode(0, -8046, -2830, 168)
		pPlayer:_AddPathNode(0, -8042, -2901, 162)
		pPlayer:_AddPathNode(0, -8094, -2966, 160)
		pPlayer:_AddPathNode(0, -8138, -2983, 148)
		pPlayer:_AddPathNode(0, -8168, -2979, 135.3)
		pPlayer:_AddPathNode(0, -8168, -2979, 135.3)
		pPlayer:_StartTaxi(17697)
	elseif (questId == 6) then
		pPlayer:SetPhase(2)
	elseif (questId == 8) then
		local go = pQuestGiver:GetGameObjectNearestCoords(-8050, -2805, 121, 177165)
		if go ~= nil then
			go:SetByte(0x0006+0x000B,0,0) -- Open
			CreateLuaEvent(function() if go then go:SetByte(0x0006+0x000B,0,1) end end, 20000, 1)		
		end
		pPlayer:CastSpell(7178) -- water breathing - hack fix
	elseif (questId == 9) then
		pPlayer:_CreateTaxi()
		pPlayer:_AddPathNode(0, -8175, -2949, 138)
		pPlayer:_AddPathNode(0, -8156, -2967, 155)
		pPlayer:_AddPathNode(0, -8112, -2975, 164)
		pPlayer:_AddPathNode(0, -8066, -2938, 176)
		pPlayer:_AddPathNode(0, -8042, -2850, 172)
		pPlayer:_AddPathNode(0, -8082, -2770, 175)
		pPlayer:_AddPathNode(0, -8170, -2728, 180)
		pPlayer:_AddPathNode(0, -8269, -2735, 200)
		pPlayer:_AddPathNode(0, -8334, -2745, 210)
		pPlayer:_AddPathNode(0, -8365, -2737, 185.6)
		pPlayer:_AddPathNode(0, -8365, -2737, 185.6)
		pPlayer:_StartTaxi(17697)
	elseif (questId == 10045) then
		pPlayer:Teleport(0, -7648.69, -633.099, 200.45)
	elseif (questId == 10043) then
		--[[local race = pPlayer:GetPlayerRace() 
		if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
			pPlayer:Teleport(0, -7796.41, -1154.34, 212.89)
		else
			pPlayer:Teleport(0, -7293.59, -1068.05, 276.25)
		end]]
		pPlayer:CastSpell(64446) -- Teleport visual
		pPlayer:Teleport(0, -7299, -912.5, 165.5)
	elseif (questId == 10) then
		pPlayer:Teleport(0, -7806, -2425, 136.2)
		pPlayer:CastSpell(64446) -- teleport visual
	elseif (questId == 11) then
		pPlayer:Dismount()
		pPlayer:CastSpell(65640) -- mount
	elseif (questId == 75) then
		pPlayer:_CreateTaxi()
		pPlayer:_AddPathNode(0, -8356, -2787, 208)
		pPlayer:_AddPathNode(0, -8364, -2755, 202)
		pPlayer:_AddPathNode(0, -8327, -2731, 197)
		pPlayer:_AddPathNode(0, -8288, -2702, 182)
		pPlayer:_AddPathNode(0, -8264, -2665, 169)
		pPlayer:_AddPathNode(0, -8231, -2593, 160)
		pPlayer:_AddPathNode(0, -8172, -2536, 157)
		pPlayer:_AddPathNode(0,	-8145, -2524, 152)
		pPlayer:_AddPathNode(0,	-8126, -2526, 140.73)
		pPlayer:_AddPathNode(0,	-8126, -2526, 140.73)
		pPlayer:_StartTaxi(17697)
	elseif (questId == 24) then
		pPlayer:SetPhase(2)
		pPlayer:_CreateTaxi()
		pPlayer:_AddPathNode(0, -7946, -2425, 134)
		pPlayer:_AddPathNode(0, -7910, -2469, 179)
		pPlayer:_AddPathNode(0, -7789, -2404, 237)
		pPlayer:_AddPathNode(0, -7827, -1805, 261)
		pPlayer:_AddPathNode(0, -7864, -1540, 213)
		pPlayer:_AddPathNode(0, -7875, -1395, 178)
		pPlayer:_AddPathNode(0, -7849, -1368, 159.8)
		pPlayer:_StartTaxi(17697)
	elseif (questId == 25) then -- Alliance below
		pPlayer:SetPhase(2)
	elseif (questId == 26) then
		pPlayer:SetPhase(1)
	elseif (questId == 30) then
		pQuestGiver:SpawnCreature(32388, -8070, -1339, 139, 4.702261, 35, 42000)
		pPlayer:SendCinematic(251)
	elseif (questId == 31) then
		pPlayer:SetPhase(2)
	elseif (questId == 40) then
		pPlayer:Teleport(0, -7454.8, -2209.5, 169.5)
	elseif (questId == 45) then
		pPlayer:SetPhase(2)
		pPlayer:Teleport(0, -8126, -806, 149.5)
	elseif (questId == 304) then
		pPlayer:CastSpell(28136)
		pPlayer:GossipSPOI(8057, -2453, 7, 6, 0, "'Portal'")
	elseif (questId == 550) then
		pPlayer:CastSpell(47740)
		pQuestGiver:SendChatMessageToPlayer(1,0,"You see? All around us, we're manipulated by beings of another world. Beings of immense power- That I want you to destroy. Go now.",pPlayer)
	elseif (questId == 551) then
		if (pPlayer:HasAura(47740)) then
			pPlayer:RemoveAura(47740)
		end
	elseif (questId == 552) then
		pPlayer:CastSpell(64446) -- Teleport visual
		pPlayer:Teleport(0, -7299, -912.5, 165.5)
----------------------------------------------------------------------------------------
	 -- Horde onwards
	elseif (questId == 807) then
	pPlayer:Dismount()
	pPlayer:CastSpell(16739)
	--pPlayer:GossipSPOI(-7008, -1748, 7, 6, 0, "Dig Master Wolly")
	pPlayer:SetPhase(2)
	
	elseif (questId == 808) then
	pPlayer:RemoveAura(16739)
	--pPlayer:CastSpell(28136)
	--pPlayer:GossipSPOI(-6395, -1942, 7, 6, 0, "The Captain")
	
	elseif (questId == 812) then
	pPlayer:SetPhase(2)
	pQuestGiver:SpawnCreature(151519, -7205, -1964, 312, 1, 35, 0)
	
	elseif (questId == 813) then
	pPlayer:SetPhase(1)
	
	elseif (questId == 814) then
	pPlayer:CastSpell(2825)
	
	elseif (questId == 815) then
	pPlayer:CastSpell(37962) -- Soaring
	pPlayer:CastSpell(33271) -- God knows
	--pPlayer:SetPlayerWeather(4,2) -- This looks ugly as it rains a lot in searing gorge already
	pPlayer:CastSpell(50203) -- Fog
	pPlayer:MovePlayerTo(-6605, -1481, 292, 3.556944, 12288, 45)
	
	elseif (questId == 816) then
	pPlayer:CastSpell(58538)
	pPlayer:RemoveAura(50203)
	
	elseif (questId == 820) then
	local name = pPlayer:GetName()
	--pQuestGiver:SChatMessage(12, 0 ,"Go with peace "..name..". You have my blessing.")
	--pQuestGiver:FullCastSpell(24217)
	pPlayer:FullCastSpell(46242)
	
	elseif (questId == 821) then
	pPlayer:FullCastSpell(10689)
	
	elseif (questId == 826) then
	pPlayer:SetPhase(2)
	
	elseif (questId == 827) then
	pPlayer:SetPhase(4)
	
	elseif (questId == 828) then
	pPlayer:SetPhase(1)
	pPlayer:CastSpell(64446)
	pPlayer:Teleport(0, -6725, -1078, 270)
	
	elseif (questId == 829) then
	PlayerAA = pPlayer
	pPlayer:SetPhase(4)
	pPlayer:CastSpell(5267)
	pPlayer:CastSpell(22650)
	pPlayer:CastSpell(51347)
	pPlayer:Teleport(0, -6632.10887, -1229.971924, 209.810593)
	RegisterTimedEvent("themagicalmomentsofalittlecinematichehe", 4000, 1)
	
	elseif (questId == 831) then
	pPlayer:CastSpell(64446)
	pPlayer:Teleport(0, -6729.4, -1244.5, 187)
	
	elseif (questId == 832) then
	pPlayer:CastSpell(64446)
	pPlayer:Teleport(0, -6736, -1223, 207)
	
	elseif (questId == 834) then
	SetDBCSpellVar(61611, "c_is_flags", 0x01000)
	pPlayer:CastSpell(61611)
	
	elseif (questId == 840) then
	pPlayer:PlaySoundToSet(8886)
	
	elseif (questId == 843) then
	pPlayer:PlaySoundToSet(8887)
	
	elseif (questId == 846) then
	SetDBCSpellVar(47740, "c_is_flags", 0x01000)
	pPlayer:CastSpell(47740)
	
	elseif (questId == 847) then
	pPlayer:RemoveAura(47740)
	pPlayer:CastSpell(58538)
	
	elseif (questId == 849) then
			
		pPlayer:Teleport(0,-9012, -3215, 109)
		local packet = LuaPacket:CreatePacket(0x0FA, 4) -- Move type 4
		packet:WriteULong(161) -- Id
		pPlayer:SendPacketToPlayer(packet) -- S to players
	
	elseif (questId == 852) then
	local packet = LuaPacket:CreatePacket(0x0FA, 4) -- Move type 4
	packet:WriteULong(1) -- Id
	pPlayer:SendPacketToPlayer(packet) -- S to players
	
	-- Ths vision
	elseif (questId == 10042) then
		pPlayer:SetPlayerLock(1)
		pPlayer:Root()
		pPlayer:Teleport(0, -7597, -1112.7, 291.5)

	--Horde still
----------------------------------------------------------------------------------------
	--Peace
	elseif (questId == 1100) then
	pPlayer:SetPhase(4)
	pPlayer:AddAchievement(522)
	
	elseif (questId == 1102) then
	pPlayer:SetPhase(24)
	
----------------------------------------------------------------------------------------
	--War
	elseif (questId == 1300) then
	pPlayer:SetPhase(16)
	pPlayer:AddAchievement(522)
	pPlayer:_CreateTaxi()
	pPlayer:_AddPathNode(1, 7835, -2236, 472)
	pPlayer:_AddPathNode(1, 7794, -2319, 467)
	pPlayer:_AddPathNode(1, 7716, -2381, 456)
	pPlayer:_AddPathNode(1, 7698, -2495, 459)
	pPlayer:_AddPathNode(1, 7763, -2658, 457)
	pPlayer:_AddPathNode(1, 7839., -2706, 479)
	pPlayer:_AddPathNode(1, 7937, -2718, 513)
	pPlayer:_AddPathNode(1, 7977, -2700, 520)
	pPlayer:_AddPathNode(1, 7993, -2681, 513)
	pPlayer:_AddPathNode(1, 7993, -2681, 513)
	pPlayer:_StartTaxi(28400)
	
	elseif (questId == 1302) then
		pPlayer:Teleport(0, -7556.4, -1199.2, 476.8)
		pPlayer:SetPhase(1)
	
	elseif (questId == 1105) then
		pPlayer:Teleport(0, -7556.4, -1199.2, 476.8)
		pPlayer:SetPhase(1)
	
	elseif (questId == 90535) then
		pPlayer:Teleport(0, -7556.4, -1199.2, 476.8)
		pPlayer:SetPhase(1)
	
----------------------------------------------------------------------------------------
	-- Redridge
	elseif (questId == 3003) then
		pPlayer:SetPhase(1)
		pPlayer:_CreateTaxi()
		pPlayer:_AddPathNode(0, -9456.013672, -3327.354248, 9.704073)
		pPlayer:_AddPathNode(0, -9437.247070, -3246.597656, 54.637737)
		pPlayer:_AddPathNode(0, -9442.260742, -3182.257813, 81.351387)
		pPlayer:_AddPathNode(0, -9411.743164, -3147.505127, 87.569862)
		pPlayer:_AddPathNode(0, -9431.865234, -3119.050049, 119.598381)
		pPlayer:_AddPathNode(0, -9465.062500, -3105.152588, 145.049484)
		pPlayer:_AddPathNode(0, -9500.271484, -3121.793701, 140.100052)
		pPlayer:_AddPathNode(0, -9424.994141, -3132.638672, 158.264465)
		pPlayer:_AddPathNode(0, -9427.501953, -3053.850342, 171.366562)
		pPlayer:_AddPathNode(0, -9405.849609, -3029.036865, 168.437790)
		pPlayer:_AddPathNode(0, -9376.934570, -3025.620117, 146.530945)
		pPlayer:_AddPathNode(0, -9372.770508, -3008.606201, 138.499664)
		pPlayer:_AddPathNode(0, -9401.430664, -3018.008057, 136.767807)
		pPlayer:_StartTaxi(28652)
	
	elseif (questId == 3030) then
		pPlayer:SetPhase(4)
	
	elseif (questId == 3750) then
		pPlayer:_CreateTaxi()
		pPlayer:_AddPathNode(0, -7438, -1210, 480)
		pPlayer:_AddPathNode(0, -7411, -1184, 472)
		pPlayer:_AddPathNode(0, -7297, -972, 335)
		pPlayer:_AddPathNode(0, -7256, -852, 321)
		pPlayer:_AddPathNode(0, -7253, -813, 346)
		pPlayer:_AddPathNode(0, -7313, -769, 338)
		pPlayer:_AddPathNode(0, -7399, -715, 350)
		pPlayer:_AddPathNode(0, -7499, -676, 346)
		pPlayer:_AddPathNode(0, -7634.9, -632, 218)
		pPlayer:_AddPathNode(0, -7655.6, -634.5, 200.8)
		pPlayer:_StartTaxi(28053)	
	
	elseif (questId == 3036) then
		pPlayer:SetPhase(16)
	
	elseif questId == 11001 then
		pQuestGiver:SChatMessageToPlayer(12,0,"Swim West and use the same typhoon that we used yesterday, "..pPlayer:GetName()..".", pPlayer)
	elseif (questId == 40043) then
	  --[[pPlayer:Teleport(632,5629.51,2467.66,708.69)
	  pPlayer:CastSpell(82010)]]
	  pPlayer:SendBroadcastMessage("THIS QUEST IS BUGGED. Auto-completing. Gotta' love betas, eh?")
	  pPlayer:MarkQuestObjectiveAsComplete(40043, 0)
	elseif (questId == 41102) then
		pPlayer:CreateGuardian(240481, 0, 2, 19):SetPetOwner(pPlayer)
	elseif (questId == 41104) then
		pQuestGiver:SendChatMessageToPlayer(12,0,"Meet me by the portal, "..pPlayer:GetName()..".", pPlayer)
		pPlayer:SetPhase(4)
	elseif (questId == 41108) then
		pQuestGiver:SpawnCreature(311231, pQuestGiver:GetX(), pQuestGiver:GetY(), pQuestGiver:GetZ(), pQuestGiver:GetO(), 35, 0)
	end
end

RegisterServerHook(14, "OnQuestAccept")

-- quest 829

local The_Npc_A = nil -- This is the first npc we shall use
local The_Npc_B = nil -- This is the second npc we shall use

function NPCGIA_GJOEAOJG_HXOJzzz(pUnit, Event)
    The_Npc_A = pUnit -- Here we say variable is the unit
end

RegisterUnitEvent(426016, 18, "NPCGIA_GJOEAOJG_HXOJzzz") -- The first npc, on spawn tell the script that this is him

function NPCGIA_GJOEAOJG_HXOJ_Zzzz(pUnit, Event)
    The_Npc_B = pUnit -- Here we say variable is the unit
end

RegisterUnitEvent(426017, 18, "NPCGIA_GJOEAOJG_HXOJ_Zzzz") -- The second npc, on spawn tell the script that this is him

function themagicalmomentsofalittlecinematichehe(pUnit,event)
  PlayerAA:SetPlayerLock(true)
  The_Npc_A:ChannelSpell(24618, PlayerAA)
  The_Npc_B:ChannelSpell(24618, PlayerAA)
  The_Npc_A:SChatMessage(12,0,"Welcome mage, to the mines of the Slag Pit.") 
  The_Npc_A:RegisterEvent("nowlettheotheronetalkalittleyouidiot", 7000, 1)
end

function nowlettheotheronetalkalittleyouidiot(pUnit,event)
  The_Npc_B:SChatMessage(12,0,"We're almost done with the summoning! Hang on!") 
  The_Npc_A:RegisterEvent("nowletusmovearoundandspyimeanpieyummyyummypie", 8000, 1)
end

function nowletusmovearoundandspyimeanpieyummyyummypie(pUnit,event)
  The_Npc_B:SChatMessage(14,0,"Another proud member of the Alliance has joined us!") 
  The_Npc_A:StopChannel() -- stop it
  The_Npc_B:StopChannel() -- stop it
  PlayerAA:SetPlayerLock(false)
  PlayerAA:RemoveAura(22650)
  PlayerAA:CastSpell(58538)
end

