--[[
-- By Stoneharry

local Ulda = {}

local OBJECT_END = 0x0006
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 -- Size: 1, Type: BYTES, Flags: PUBLIC
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit

local ready = false
local i = 0

local UldamanInfo = {}

UldamanLocations = { -- in format as x, y, z, o, registertime
	{
		{-6124.356445, -3313.370117, 266.941101, 0, 2000},
		{-6146.251953, -3347.607666, 273.031586, 0, 6000},
		{-6182.091797, -3362.557129, 274.688446, 0, 6000},
		{-6223.678223, -3388.206787, 274.688446, 0, 7000},
		{-6261.023926, -3442.613525, 274.688446, 0, 9000},
		{-6294.992676, -3481.985352, 282.688446, 0, 7500},
		{-6328.961426, -3521.356934, 282.688446, 0, 7000},
		{-6383.515137, -3573.903320, 282.688446, 0, 10000},
		{-6437.695801, -3607.957764, 282.688446, 0, 10000},
		{-6488.143066, -3625.346191, 282.688446, 0, 9000},
		{-6535.789551, -3631.161377, 282.688446, 0, 7000},
		{-6569.892578, -3636.962891, 282.688446, 0, 4000},
		{-6594.637207, -3657.114258, 274.688446, 0, 4000},
		{-6606.420898, -3690.925049, 269.328461, 0, 5000},
		{-6613.697754, -3710.938232, 269.328461, 0, 3000},
		{1, 1, 1, 1, 1}
	}
}

-- Stone Titan - Handles mobs incoming and messages etc

function MainTitanUldaman_OnSpawn(pUnit, Event)
	pUnit:RegisterEvent("Wait_For_Spawn_UldamanTitan", 1000, 1)
	pUnit:SetFaction(35)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

function Wait_For_Spawn_UldamanTitan(pUnit)
	pUnit:SetFaction(35)
	pUnit:FullCastSpell(15533) -- stone state visual
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("EquipWeaponUldamanTitan", 4000, 1)
end

function EquipWeaponUldamanTitan(pUnit)
	pUnit:EquipWeapons(12796, 0, 0)
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	Ulda.captain = pUnit:GetUnitBySqlId(9271259)
	Ulda.dwarfa = pUnit:GetUnitBySqlId(9271263)
	Ulda.dwarfb = pUnit:GetUnitBySqlId(9271261)
	Ulda.dwarfc = pUnit:GetUnitBySqlId(9271260)
	Ulda.ballista = pUnit:GetUnitBySqlId(9271324)
	Ulda.main = pUnit:GetUnitBySqlId(9271616)
	pUnit:RegisterEvent("Send_EnemiesToUlda_pUnit", 4000, 0)
	pUnit:RegisterEvent("PLayRepetativeMusic", 60000, 0)
	Ulda.captain:PlaySoundToSet(17673) -- Battle Music
end

function PLayRepetativeMusic(pUnit)
	Ulda.captain:PlaySoundToSet(17673) -- Battle Music
	if Ulda.captain:GetSelection() ~= nil then
		if Ulda.captain:GetSelection():GetEntry() ~= 239131 then
			Ulda.captain:Despawn(1,1)
		end
	end
end

function Send_EnemiesToUlda_pUnit(pUnit)
	if math.random(1,10) == 5 then
		local choice = math.random(1,4)
		if choice == 1 then
			if math.random(1,2) == 1 then
				Ulda.captain:SendChatMessage(12,0,"Hold your ground!")
			else
				Ulda.captain:SendChatMessage(12,0,"Where are those ballista!?")
			end
		elseif choice == 2 then
			Ulda.dwarfa:SendChatMessage(12,0,"Ugh-")
		elseif choice == 3 then
			Ulda.dwarfb:SendChatMessage(12,0,"Another one bites the dust.")
		elseif choice == 4 then
			Ulda.dwarfc:SendChatMessage(12,0,"They just don't stop!")
		end
	end
	if (ready) then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("MainEvent_Handler_Go", 7500, 1)
	else
		pUnit:SpawnCreature(239131, -6080.8, -3160.8, 254.5, 3.644125, 21, 30000)
	end
end

RegisterUnitEvent(259271, 18, "MainTitanUldaman_OnSpawn")

function MainTitanUldaman_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(259271, 4, "MainTitanUldaman_OnDead")

-- The adds

function DreadBatburroweronspawn(pUnit, Event)
	pUnit:RegisterEvent("BirrwerAttack_Ulda", 1000, 1)
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:MoveTo(6102.8, -3234.1, 261.4, 0)
	elseif choice == 2 then
		pUnit:MoveTo(-6112.3, -3234.6, 260.8, 0)
	elseif choice == 3 then
		pUnit:MoveTo(-6120.6, -3234, 263.2, 0)
	end
end

function BirrwerAttack_Ulda(pUnit)
	pUnit:SetMovementFlags(1)
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:MoveTo(6102.8, -3234.1, 261.4, 0)
	elseif choice == 2 then
		pUnit:MoveTo(-6112.3, -3234.6, 260.8, 0)
	elseif choice == 3 then
		pUnit:MoveTo(-6120.6, -3234, 263.2, 0)
	end
	pUnit:ChangeTarget(Ulda.captain)
	pUnit:RegisterEvent("KeepAttacking", 250, 0)
end

function KeepAttacking(pUnit)
	if pUnit then
		if pUnit:IsAlive() then
			pUnit:ChangeTarget(Ulda.captain)
		else
			pUnit:RemoveEvents()
		end
	end
end

RegisterUnitEvent(239131, 18, "DreadBatburroweronspawn")

-- The snipers

function DwarfSniper_Uldaman(pUnit, Event)
	if pUnit:GetPhase() == 1 then
		pUnit:RegisterEvent("PrepareToShoot_Sniper", math.random(2000, 4000), 0)
	end
end

function PrepareToShoot_Sniper(pUnit)
	for place,creature in pairs(pUnit:GetInRangeUnits()) do
		if creature:GetEntry() == 239131 then
			if (not creature:IsAlive()) then
				creature:RemoveEvents()
				creature:Despawn(1,0)
			else
				if pUnit:GetDistanceYards(creature) < 30 then
					if math.random(1,20) == 5 then
						Ulda.ballista:FullCastSpellOnTarget(53117, creature)
						creature:CastSpell(11) -- suicide
					else
						pUnit:CastSpellOnTarget(30221, creature)
					end
					break -- stop checking
				end
			end
		end
	end
end

RegisterUnitEvent(158352, 18, "DwarfSniper_Uldaman")

-- The main guy

function TheLight_Guy_Uldamanclick(pUnit, event, player)
	if pUnit:GetPhase() == 1 then
		pUnit:GossipCreateMenu(7362, player, 0)
		if player:HasQuest(6508) == true then
			pUnit:GossipMenuAddItem(9, "I am here, Brom.", 11, 0)
		end
		pUnit:GossipMenuAddItem(0, "Nevermind Brom.", 3, 0)
		pUnit:GossipSendMenu(player)
	end
end

function TheLight_Guy_Uldamangossip(pUnit, event, player, id, intid, code)
	if(intid == 11) then
		player:GossipComplete()
		pUnit:SendChatMessage(12,0,"Good, now I am going to attempt to seal this tunnel.")
		pUnit:SetNPCFlags(2)
		ready = true
	end
	if(intid == 3) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(225101, 1, "TheLight_Guy_Uldamanclick")
RegisterUnitGossipEvent(225101, 2, "TheLight_Guy_Uldamangossip")

-- Main event handler

function MainEvent_Handler_Go(pUnit)
	if i == 0 then
		Ulda.main:SendChatMessage(12,0,"That's odd, they appear to have stopped coming out of the tunnel.")
		pUnit:RegisterEvent("MainEvent_Handler_Go", 4000, 1)
	elseif i == 1 then
		Ulda.main:PlaySoundToSet(6077)
		pUnit:RemoveAura(15533) -- stone state visual
		pUnit:FullCastSpell(10347) -- Awaken Visual
		pUnit:RegisterEvent("MainEvent_Handler_Go", 3000, 1)
	elseif i == 2 then
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2) -- unattackable
		pUnit:SetFaction(21)
		pUnit:MoveKnockback(-6088, -3201, 255.5, 5, 10)
		Ulda.main:Emote(45, 30000)
		pUnit:RegisterEvent("MainEvent_Handler_Go", 1850, 1)
	elseif i == 3 then
		pUnit:Root()
		Ulda.main:SendChatMessage(12,0,"What foul manner of creature is this?!")
		pUnit:RegisterEvent("MainEvent_Handler_Go", 4000, 1)
	elseif i == 4 then
		pUnit:SendChatMessage(14,0,"You were foolish to think you could disturb the Titans without awakening me. You shall all be punished.")
		pUnit:SetScale(1.1)
		pUnit:RegisterEvent("MainEvent_Handler_Go", 2000, 1)
	elseif i == 5 then
		pUnit:SetScale(1.25)
		pUnit:RegisterEvent("MainEvent_Handler_Go", 2000, 1)
	elseif i == 6 then
		pUnit:SetScale(1.5)
		pUnit:RegisterEvent("MainEvent_Handler_Go", 2000, 1)
	elseif i == 7 then
		pUnit:SetScale(1.75)
		Ulda.main:SendChatMessage(14,0,"May light protect me!")
		Ulda.main:CastSpell(70571) -- visual
		pUnit:RegisterEvent("MainEvent_Handler_Go", 500, 1)
	elseif i == 8 then
		pUnit:SetScale(1.85)
		pUnit:Emote(38, 1500)
		pUnit:RegisterEvent("MainEvent_Handler_Go", 4000, 1)
	elseif i == 9 then
		pUnit:SendChatMessage(14,0,"Your gods will not save you.")
		pUnit:CastSpell(64785) -- Lightning visual
		pUnit:FullCastSpell(52893) -- summon adds
		pUnit:RegisterEvent("MainEvent_Handler_Go", 5500, 1)
	elseif i == 10 then
		Ulda.main:PlaySoundToSet(14556) -- Scream
		Ulda.main:PlaySoundToSet(11836) -- Explosion
		for place,plrs in pairs(Ulda.main:GetInRangePlayers()) do
			if plrs:GetDistanceYards(Ulda.main) < 30 then
				if plrs:GetPhase() == 1 then
					plrs:MoveKnockback(-6049.7, -3333, 263, 5, 5)
					plrs:CastSpell(61456) -- visual
					if plrs:HasQuest(6508) then
						plrs:MarkQuestObjectiveAsComplete(6508, 0)
					end
					plrs:SetPhase(2)
				end
			end
		end
		ready = false
		Ulda.main:SetNPCFlags(1)
		Ulda.main:RemoveAura(70571)
		pUnit:SetScale(1)
		pUnit:Unroot()
		pUnit:SetPosition(-6092.3, -3183.9, 268.2, 4.985440)
		pUnit:EquipWeapons(0,0,0)
		i = 0
		pUnit:RegisterEvent("MainTitanUldaman_OnSpawn", 5000, 1)
	end
	i = i + 1
end

-- Transport vehicle part

function UldamanQuestAccept(event, player, questId, pQuestGiver)
	if (questId == 6509) then -- Badlands, transport to uldaman side enterence quest
		player:SetPhase(1)
		player:SetModel(28476) -- box
		player:SetScale(0.2)
		player:SpawnAndEnterVehicle(288301, 1000)
		local vehicle = player:GetCreatureNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 288301)
		UldamanInfo[tostring(vehicle)] = {
			track = 1, 
			racecount = 1,
			player = player,
			vehicle = vehicle
		}
		RegisterTimedEvent("Uldaman_TrackGo", 1500, 1, vehicle)
	end
end


RegisterServerHook(14, "UldamanQuestAccept")

function Uldaman_TrackGo(pUnit)
	pUnit:CastSpell(60534)
	pUnit:SetMovementFlags(2)
	--pUnit:SendChatMessage(12,0, "POINT: "..UldamanInfo[tostring(pUnit)].racecount..".")
	if UldamanInfo[tostring(pUnit)].racecount == #UldamanLocations[UldamanInfo[tostring(pUnit)].track] then
		-- Were done
		if UldamanInfo[tostring(pUnit)].vehicle ~= nil then
			UldamanInfo[tostring(pUnit)].vehicle:EjectAllPassengers()
		end
		if UldamanInfo[tostring(pUnit)].player ~= nil then
			UldamanInfo[tostring(pUnit)].player:DeMorph()
			UldamanInfo[tostring(pUnit)].player:SetScale(1)
		end
		pUnit:Despawn(1000, 0)
		return
	end
	pUnit:MoveTo(UldamanLocations[UldamanInfo[tostring(pUnit)].track][UldamanInfo[tostring(pUnit)].racecount][1],UldamanLocations[UldamanInfo[tostring(pUnit)].track][UldamanInfo[tostring(pUnit)].racecount][2],UldamanLocations[UldamanInfo[tostring(pUnit)].track][UldamanInfo[tostring(pUnit)].racecount][3],UldamanLocations[UldamanInfo[tostring(pUnit)].track][UldamanInfo[tostring(pUnit)].racecount][4])
	-- Register the event again (recursion)
	RegisterTimedEvent("Uldaman_TrackGo", UldamanLocations[UldamanInfo[tostring(pUnit)].track][UldamanInfo[tostring(pUnit)].racecount][5], 1, pUnit)
	-- Add to the counter
	UldamanInfo[tostring(pUnit)].racecount = UldamanInfo[tostring(pUnit)].racecount + 1
end

]]
	