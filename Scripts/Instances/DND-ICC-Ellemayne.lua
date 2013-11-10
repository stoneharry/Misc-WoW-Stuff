
-- By Stoneharry

INS = {}
INS.VAR = {}

local Spawned = {}
local Players = {}

local OBJECT_END = 0x0006
--local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044 -- Size: 1, Type: BYTES, Flags: PUBLIC
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 -- Size: 1, Type: BYTES, Flags: PUBLIC
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit

function INS.VAR.Lorestone_spawn(pUnit, Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	INS[id] = INS[id] or {VAR={}}
	INS[id].VAR.Lore = pUnit
end

RegisterUnitEvent(203120, 18, "INS.VAR.Lorestone_spawn")

function INS.VAR.Elf_channel_spawn(pUnit, Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	INS[id] = INS[id] or {VAR={}}
	INS[id].VAR.Ready = true
	INS[id].VAR.Phase = 0
	pUnit:RegisterEvent("INS.VAR.Check_For_Ready_Elf", 5000, 0)
end

RegisterUnitEvent(203121, 18, "INS.VAR.Elf_channel_spawn")

function INS.VAR.zzzWolly_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(738, player, 0)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	INS[id] = INS[id] or {VAR={}}
	if INS[id].VAR.Ready and INS[id].VAR.Phase == 0 then
		pUnit:GossipMenuAddItem(9, "We are ready, begin.", 246, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end

function INS.VAR.zzzWolly_Gossip_Submenus(pUnit, event, player, id, intid, code)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	INS[id] = INS[id] or {VAR={}}
	if(intid == 246) then
		INS[id].VAR.Ready = false
		pUnit:SetNPCFlags(2)
		player:GossipComplete()
	elseif(intid == 250) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(203121, 1, "INS.VAR.zzzWolly_On_Gossip")
RegisterUnitGossipEvent(203121, 2, "INS.VAR.zzzWolly_Gossip_Submenus")

function INS.VAR.Check_For_Ready_Elf(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	INS[id] = INS[id] or {VAR={}}
	if INS[id].VAR.Ready == false then
		pUnit:SendChatMessage(12,0,"This is our final stand, make every blow count!")
		pUnit:PlaySoundToSet(11062)
		INS[id].VAR.Lore:ChannelSpell(48316, pUnit) -- soul sucker
		pUnit:ChannelSpell(13540, INS[id].VAR.Lore) -- Green channel
		pUnit:RemoveEvents()
		INS[id].VAR.i = 0
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 3500, 1)
	end
end

function INS.VAR.EventFunction_Handler(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	INS[id] = INS[id] or {VAR={}}
	if INS[id].VAR.i == 0 then
		INS[id].VAR.MoleA = pUnit:GetGameObjectNearestCoords(-517, 2232.7, 539.3, 188478)
		INS[id].VAR.MoleA:SetByte(0x0006+0x000B,0,0) -- Open
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 700, 1)
	elseif INS[id].VAR.i == 1 then
		INS[id].VAR.MoleB = pUnit:GetGameObjectNearestCoords(-515.8, 2187.9, 539.3, 188478)
		INS[id].VAR.MoleB:SetByte(0x0006+0x000B,0,0) -- Open
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 3000, 1)
	elseif INS[id].VAR.i == 2 then
		pUnit:SpawnCreature(203122, -521, 2230.6, 540, 4.394675, 21, 120000, 7945, 3450, 0)
		pUnit:SpawnCreature(203122, -519.44, 2191, 540, 2.004, 21, 120000, 7945, 3450, 0)
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 3000, 1)
	elseif INS[id].VAR.i == 3 then
		INS[id].VAR.MoleA:SetByte(0x0006+0x000B,0,1) -- Close
		INS[id].VAR.MoleB:SetByte(0x0006+0x000B,0,1) -- Close
		pUnit:SendChatMessage(12,0,"Fight! Fight till your dying breath!")
		pUnit:PlaySoundToSet(11063)
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 22000, 1)
	elseif INS[id].VAR.i == 4 then
		INS[id].VAR.MoleA:SetByte(0x0006+0x000B,0,0) -- Open
		INS[id].VAR.MoleB:SetByte(0x0006+0x000B,0,0) -- Open
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 2000, 1)
	elseif INS[id].VAR.i == 5 then
		pUnit:SpawnCreature(203122, -521, 2230.6, 540, 4.394675, 21, 120000, 23171, 0, 0)
		pUnit:SpawnCreature(203122, -520, 2230.6, 542, 4.394675, 21, 120000, 7945, 3450, 0)
		pUnit:SpawnCreature(203122, -519.44, 2191, 542, 2.004, 21, 120000, 23171, 0, 0)
		pUnit:SpawnCreature(203122, -518.44, 2191, 540, 2.004, 21, 120000, 7945, 3450, 0)
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 2000, 1)
	elseif INS[id].VAR.i == 6 then
		INS[id].VAR.MoleA:SetByte(0x0006+0x000B,0,1) -- Close
		INS[id].VAR.MoleB:SetByte(0x0006+0x000B,0,1) -- Close
		pUnit:SendChatMessage(12,0,"Give every ounce of strength, do not despair!")
		pUnit:PlaySoundToSet(11064)
		for place,creature in pairs(Spawned) do
			if creature ~= nil then
				if creature:IsInWorld() then
					if creature:IsAlive() == false then
						creature:Despawn(1000,0)
					end
				end
			end
		end
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 30000, 1) 
	elseif INS[id].VAR.i == 7 then
		pUnit:SendChatMessage(42,0,"Stay out of the red lights!")
		local plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			INS[id].VAR.BeamA = pUnit:SpawnCreature(203123, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 35, 0)
		end
		plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			INS[id].VAR.BeamB = pUnit:SpawnCreature(203123, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 35, 0)
		end
		INS[id].VAR.BeamA:SetUnitToFollow(INS[id].VAR.BeamA:GetClosestPlayer(), 0.2, 1) 
		INS[id].VAR.BeamB:SetUnitToFollow(INS[id].VAR.BeamB:GetClosestPlayer(), 0.2, 1)
		INS[id].VAR.BeamA:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		INS[id].VAR.BeamB:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 2000, 1)
	elseif INS[id].VAR.i == 8 then
		for place,creature in pairs(Spawned) do
			if creature ~= nil then
				if creature:IsInWorld() then
					if creature:IsAlive() == false then
						creature:Despawn(1500,0)
					end
				end
			end
			Spawned[place] = nil
		end
		INS[id].VAR.BeamA:CastSpell(32839) -- Red beam
		INS[id].VAR.BeamB:CastSpell(32839)
		pUnit:RegisterEvent("INS.VAR.CheckForNearbyPlayers_Beams", 1500, 0)
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 45000, 1) 
	elseif INS[id].VAR.i == 9 then
		pUnit:RemoveEvents()
		INS[id].VAR.BeamA:RemoveAura(32839) -- Red Beam
		INS[id].VAR.BeamB:RemoveAura(32839)
		INS[id].VAR.BeamA:Despawn(2000, 0)
		INS[id].VAR.BeamB:Despawn(2000, 0)
		INS[id].VAR.BeamA = nil
		INS[id].VAR.BeamB = nil
		pUnit:SendChatMessage(12,0,"We can not hold them off for long!")
		pUnit:PlaySoundToSet(11065)
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 5000, 1)
	elseif INS[id].VAR.i == 10 then
		pUnit:SendChatMessage(42,0,"Stay within the blue light!")
		pUnit:CastSpell(32840) -- Blue beam
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 8000, 1)
	elseif INS[id].VAR.i == 11 then
		for a, plrs in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(plrs) > 7.5 then
				plrs:CastSpell(39180)
				table.insert(Players, plrs)
			end
		end
		pUnit:RemoveAura(32840)
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 700, 1)
	elseif INS[id].VAR.i == 12 then --Bugged section
		for a, plrs in pairs(Players) do
			plrs:CastSpell(7)
			plrs:CastSpell(11)
			plrs:CastSpell(11)
			plrs:CastSpell(11)
			Players[a] = nil
		end
		pUnit:StopChannel()
		INS[id].VAR.Lore:StopChannel()
		INS[id].VAR.Visuals = pUnit:SpawnCreature(203124, INS[id].VAR.Lore:GetX(), INS[id].VAR.Lore:GetY(), INS[id].VAR.Lore:GetZ(), 0, 35, 0)
		--INS[id].VAR.Visuals:ChannelSpell(56571, pUnit) --Crashes the server
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 4000, 1)
	elseif INS[id].VAR.i == 13 then
		pUnit:SendChatMessage(12,0,"It is finished then. This is the end - for all of us.")
		pUnit:PlaySoundToSet(11067)
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 7500, 1)
	elseif INS[id].VAR.i == 14 then
		INS[id].VAR.Visuals:StopChannel()
		INS[id].VAR.Visuals:CastSpell(59084) -- boom visual
		INS[id].VAR.Visuals:Despawn(5500, 0)
		INS[id].VAR.Visuals = nil
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 2750, 1)
	elseif INS[id].VAR.i == 15 then
		if INS[id].VAR.Boss == nil then
			pUnit:PlaySoundToSet(17289) -- Epic music
			INS[id].VAR.Boss = pUnit:SpawnCreature(203125, INS[id].VAR.Lore:GetX(), INS[id].VAR.Lore:GetY(), INS[id].VAR.Lore:GetZ(), INS[id].VAR.Lore:GetO(), 21, 0, 4548, 0, 0)
			INS[id].VAR.Boss:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
			pUnit:ChannelSpell(27259, INS[id].VAR.Boss)
			INS[id].VAR.i = INS[id].VAR.i - 1
		else
			if INS[id].VAR.Boss:IsAlive() then
				INS[id].VAR.i = INS[id].VAR.i - 1
				if INS[id].VAR.Boss:GetHealthPct() < 50 and INS[id].VAR.Phase == 0 then
					INS[id].VAR.Boss:EquipWeapons(0,0,0)
					INS[id].VAR.Boss:CastSpell(70590) -- Drop weapon visual
					INS[id].VAR.Boss:CastSpell(35426) -- arcane explosion visual
					INS[id].VAR.Boss:CastSpell(18501) -- enrage
					INS[id].VAR.Phase = 1
				elseif INS[id].VAR.Boss:GetHealthPct() < 25 and INS[id].VAR.Phase == 1 then
					INS[id].VAR.Phase = 2
					INS[id].VAR.Boss:FullCastSpell(34807)
				end
			end
		end
		pUnit:RegisterEvent("INS.VAR.EventFunction_Handler", 5000, 1) -- Remove soon, register on boss death
	elseif INS[id].VAR.i == 16 then
		pUnit:StopChannel()
		INS[id].VAR.i = -1
		if INS[id].VAR.Boss ~= nil then
			INS[id].VAR.Boss:Despawn(120000, 0)
			INS[id].VAR.Boss = nil
		end
		INS[id].VAR.Ready = true
		pUnit:RemoveEvents()
		INS[id].VAR.Lore:StopChannel()
		pUnit:StopChannel()
		pUnit:SetNPCFlags(3)
		pUnit:RegisterEvent("INS.VAR.Check_For_Ready_Elf", 5000, 0)
	end
	INS[id].VAR.i = INS[id].VAR.i + 1
end

function INS.VAR.CheckForNearbyPlayers_Beams(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	INS[id] = INS[id] or {VAR={}}
	local plr = INS[id].VAR.BeamA:GetClosestPlayer()
	if plr ~= nil then
		if plr:GetDistanceYards(INS[id].VAR.BeamA) < 7 then
			plr:CastSpell(43418) -- impact
			INS[id].VAR.BeamA:Strike(plr, 1, 38043, 520, 530, 1.2)
		end
	end
	plr = INS[id].VAR.BeamB:GetClosestPlayer()
	if plr ~= nil then
		if plr:GetDistanceYards(INS[id].VAR.BeamB) < 7 then
			plr:CastSpell(43418) -- impact
			INS[id].VAR.BeamB:Strike(plr, 1, 38043, 520, 530, 1.2)
		end
	end
end

------------------------------------------------------------------------------

function INS.VAR.random_npc_onspawn(pUnit, Event)
	pUnit:RegisterEvent("INS.VAR.travel_spawn_lag", 1000, 1)
end

function INS.VAR.travel_spawn_lag(pUnit)
	table.insert(Spawned, pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	end
end

RegisterUnitEvent(203122, 18, "INS.VAR.random_npc_onspawn")

--


