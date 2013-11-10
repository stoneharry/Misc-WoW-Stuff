-------------------
-- By Stoneharry --
-------------------
-- Variable Decleration
-- Configuration

ARG = {}
ARG.VAR = {}

local Spawned = {}

local HANDLER_CREATURE = 780000
local AddA = 780002 -- 4 of them	 Gate A
local AddB = 780003 -- 10 of them 	 Gate A
local AddC = 780004 -- 2 of them 	 Gate A and B
local AddD = 780005 -- 20 of them 	 Gate A and B
local AddE = 780006 -- 6 of them 	 Gate A
local AddF = 780007 -- 15 of them	 Gate B
local AddG = 780008 -- 4 of them	 Gate A and B
local AddH = 780009 -- 20 of them	 no gate
local BossID = 780001
local FIRE = 780010	-- The ID for the lines of fire that spawn

local locA, locB, locC = 4523, 2778, 404 -- Randomly moves to one of these two coords on spawn (make near middle)
local locX, locY, locZ = 4522, 2760, 404
local gateAX, gateAY, gateAZ, gateAID = 4522.24, 2740.8, 403.984, 201374 -- The coords then ID of each gate on each side of the room
local gateBX, gateBY, gateBZ, gateBID = 4522.21, 2797.87, 403.984, 201374
local behindGateAX, behindGateAY, behindGateAZ = 4522, 2734, 404 -- The coords behind gate A to spawn mobs
local behindGateBX, behindGateBY, behindGateBZ = 4522, 2804, 404 -- The coords behind gate B to spawn mobs

-- Do not touch below unless you are not using 3.3.5a

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3

SetDBCSpellVar(52989, "c_is_flags", 0x01000)

---------------------------------------------------------
-- Wave Handler -----------------------------------------
---------------------------------------------------------

function ARG.VAR.Invisible_NpcDEFENDMALL(pUnit, Event)
	pUnit:RegisterEvent("ARG.VAR.Check_For_EventDEFENDMALL", 5000, 0)
end

function ARG.VAR.Check_For_EventDEFENDMALL(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.CanStart then
		pUnit:RemoveEvents()
		ARG[id].VAR.CanStart = false
		ARG[id].VAR.Wave = 1
		ARG[id].VAR.Dead = 0
		ARG[id].VAR.gateA = pUnit:GetGameObjectNearestCoords(gateAX, gateAY, gateAZ, gateAID)
		ARG[id].VAR.gateB = pUnit:GetGameObjectNearestCoords(gateBX, gateBY, gateBZ, gateBID)
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			pUnit:SendChatMessageToPlayer(42,0,"The event has begun! Defend the room for all 8 waves.", plrs)
			pack = LuaPacket:CreatePacket(SMSG_INIT_WORLD_STATES, 18) -- Waves remaining
			pack:WriteULong(534) -- Map
			pack:WriteULong(3606) -- Zone
			pack:WriteULong(0)
			pack:WriteUShort(2)
			pack:WriteULong(2842) -- ID
			pack:WriteULong(1) -- Value
			plrs:SendPacketToPlayer(pack)
			pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2842) -- ID, total
			pack:WriteULong(ARG[id].VAR.Wave) -- Value
			plrs:SendPacketToPlayer(pack)
			pUnit:SendChatMessageToPlayer(42, 0, "Wave "..ARG[id].VAR.Wave.."!", plrs) -- 1
		end
		pUnit:PlaySoundToSet(8887) -- Scary music
		pUnit:RegisterEvent("ARG.VAR.Spawn_Adds_DEFENDMALL", 7000, 1)
	end
end

RegisterUnitEvent(HANDLER_CREATURE, 18, "ARG.VAR.Invisible_NpcDEFENDMALL")

function ARG.VAR.Spawn_Adds_DEFENDMALL(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.gateA ~= nil then
		ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		ARG[id].VAR.Open = true
	end
	local i = 0
	while i ~= 4 do
		i = i + 1
		pUnit:SpawnCreature(AddA, behindGateAX, behindGateAY, behindGateAZ, 0, 15, 180000)
	end
	pUnit:RegisterEvent("ARG.VAR.CheckForDeadAddsOhLol", 10000, 0)
	pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_WIPE_hurpdurpDEFENDMALL", 180000, 1)
end

function ARG.VAR.CheckForDeadAddsOhLol(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.Open then
		if ARG[id].VAR.gateA ~= nil then
			ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
	end
	if ARG[id].VAR.Dead > 3 then
		ARG[id].VAR.Wave = ARG[id].VAR.Wave + 1
		pUnit:RemoveEvents()
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2842) -- ID, total
			pack:WriteULong(ARG[id].VAR.Wave) -- Value
			plrs:SendPacketToPlayer(pack)
			pUnit:SendChatMessageToPlayer(42, 0, "Wave "..ARG[id].VAR.Wave.."!", plrs) -- 2
		end
		if ARG[id].VAR.gateA ~= nil then
			ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
			ARG[id].VAR.Open = true
		end
		local i = 0
		while i ~= 10 do
			i = i + 1
			pUnit:SpawnCreature(AddB, behindGateAX, behindGateAY, behindGateAZ, 0, 15, 300000)
		end
		pUnit:RegisterEvent("ARG.VAR.Check_For_All_DeadDEFENDMALL", 10000, 0)
		pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_WIPE_hurpdurpDEFENDMALL", 300000, 1)
	end
end

function ARG.VAR.Check_For_All_DeadDEFENDMALL(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.Open then
		if ARG[id].VAR.gateA ~= nil then
			ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
	end
	if ARG[id].VAR.Dead > 11 then
		pUnit:RemoveEvents()
		ARG[id].VAR.Wave = ARG[id].VAR.Wave + 1
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2842) -- ID, total
			pack:WriteULong(ARG[id].VAR.Wave) -- Value
			plrs:SendPacketToPlayer(pack)
			pUnit:SendChatMessageToPlayer(42, 0, "Wave "..ARG[id].VAR.Wave.."!", plrs) -- 3
		end
		if ARG[id].VAR.gateA ~= nil then
			ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
			ARG[id].VAR.Open = true
		end
		if ARG[id].VAR.gateB ~= nil then
			ARG[id].VAR.gateB:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
			ARG[id].VAR.Open = true
		end
		for place,creature in pairs(Spawned) do
			if creature ~= nil then
				if creature:IsInWorld() then
					if creature:IsAlive() == false then
						creature:Despawn(1000,0)
					end
				end
			end
		end
		pUnit:SpawnCreature(AddC, behindGateAX, behindGateAY, behindGateAZ, 0, 15, 320000)
		pUnit:SpawnCreature(AddC, behindGateBX, behindGateBY, behindGateBZ, 0, 15, 320000)
		pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_WIPE_hurpdurpDEFENDMALL", 320000, 1)
		pUnit:RegisterEvent("ARG.VAR.Check_For_ADDCDEATHS_DEFENDMALL", 10000, 0)
	end
end

function ARG.VAR.Check_For_ADDCDEATHS_DEFENDMALL(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.Open then
		if ARG[id].VAR.gateA ~= nil then
			ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
		if ARG[id].VAR.gateB ~= nil then
			ARG[id].VAR.gateB:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
	end
	if ARG[id].VAR.Dead > 13 then
		pUnit:RemoveEvents()
		ARG[id].VAR.Wave = ARG[id].VAR.Wave + 1
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2842) -- ID, total
			pack:WriteULong(ARG[id].VAR.Wave) -- Value
			plrs:SendPacketToPlayer(pack)
			pUnit:SendChatMessageToPlayer(42, 0, "Wave "..ARG[id].VAR.Wave.."!", plrs) -- 4
		end
		pUnit:RegisterEvent("ARG.VAR.Break_Break_GiveBreak_DEFENDMALL", 8000, 1)
	end
end

function ARG.VAR.Break_Break_GiveBreak_DEFENDMALL(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	local i = 0
	while i ~= 20 do
		i = i + 1
		if math.random(1,2) == 1 then
			pUnit:SpawnCreature(AddD, behindGateAX, behindGateAY, behindGateAZ , 0, 15, 180000)
		else
			pUnit:SpawnCreature(AddD, behindGateBX, behindGateBY, behindGateBZ , 0, 15, 180000)
		end
	end
	if ARG[id].VAR.gateA ~= nil then
		ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		ARG[id].VAR.Open = true
	end
	if ARG[id].VAR.gateB ~= nil then
		ARG[id].VAR.gateB:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		ARG[id].VAR.Open = true
	end
	pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_WIPE_hurpdurpDEFENDMALL", 180000, 1)
	pUnit:RegisterEvent("ARG.VAR.Check_For_mobDDeaths_Yarp", 10000, 0)
end

function ARG.VAR.Check_For_mobDDeaths_Yarp(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.Open then
		if ARG[id].VAR.gateA ~= nil then
			ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
		if ARG[id].VAR.gateB ~= nil then
			ARG[id].VAR.gateB:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
	end
	if ARG[id].VAR.Dead > 35 then
		pUnit:RemoveEvents()
		ARG[id].VAR.Wave = ARG[id].VAR.Wave + 1
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2842) -- ID, total
			pack:WriteULong(ARG[id].VAR.Wave) -- Value
			plrs:SendPacketToPlayer(pack)
			pUnit:SendChatMessageToPlayer(42, 0, "Wave "..ARG[id].VAR.Wave.."!", plrs) -- 5
		end
		pUnit:PlaySoundToSet(15119)
		pUnit:RegisterEvent("ARG.VAR.WAIT_FOR_THE_RIGHT_MOMENT_DUN_DUN_DEFENDMALL", 7500, 1)
	end
end

function ARG.VAR.WAIT_FOR_THE_RIGHT_MOMENT_DUN_DUN_DEFENDMALL(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	local i = 0
	while i ~= 6 do
		i = i + 1
		pUnit:SpawnCreature(AddE, behindGateAX, behindGateAY, behindGateAZ , 0, 15, 380000)
	end
	if ARG[id].VAR.gateA ~= nil then
		ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		ARG[id].VAR.Open = true
	end
	pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_WIPE_hurpdurpDEFENDMALL", 380000, 1)
	pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_DEAD_MALLEVENTgtoustwo", 10000, 0)
end

function ARG.VAR.CHECK_FOR_DEAD_MALLEVENTgtoustwo(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.Open then
		if ARG[id].VAR.gateA ~= nil then
			ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
	end
	if ARG[id].VAR.Dead > 40 then
		pUnit:RemoveEvents()
		ARG[id].VAR.Wave = ARG[id].VAR.Wave + 1
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2842) -- ID, total
			pack:WriteULong(ARG[id].VAR.Wave) -- Value
			plrs:SendPacketToPlayer(pack)
			pUnit:SendChatMessageToPlayer(42, 0, "Wave "..ARG[id].VAR.Wave.."!", plrs) -- 6
		end
		pUnit:RegisterEvent("ARG.VAR.WAIT_FOR_THE_RIGHT_MOMENT_DUN_DUN_DEFENDMALLtwo", 7500, 1)
	end
end

function ARG.VAR.WAIT_FOR_THE_RIGHT_MOMENT_DUN_DUN_DEFENDMALLtwo(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	local i = 0
	while i ~= 15 do
		i = i + 1
		pUnit:SpawnCreature(AddF, behindGateBX, behindGateBY, behindGateBZ , 0, 15, 280000)
	end
	if ARG[id].VAR.gateB ~= nil then
		ARG[id].VAR.gateB:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		ARG[id].VAR.Open = true
	end
	pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_WIPE_hurpdurpDEFENDMALL", 280000, 1)
	pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_DEAD_MALLEVENTaaassssffff", 10000, 0)
end

function ARG.VAR.CHECK_FOR_DEAD_MALLEVENTaaassssffff(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.Open then
		if ARG[id].VAR.gateB ~= nil then
			ARG[id].VAR.gateB:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
	end
	if ARG[id].VAR.Dead > 54 then
		pUnit:RemoveEvents()
		ARG[id].VAR.Wave = ARG[id].VAR.Wave + 1
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2842) -- ID, total
			pack:WriteULong(ARG[id].VAR.Wave) -- Value
			plrs:SendPacketToPlayer(pack)
			pUnit:SendChatMessageToPlayer(42, 0, "Wave "..ARG[id].VAR.Wave.."!", plrs) -- 7
		end
		pUnit:RegisterEvent("ARG.VAR.WAIT_FOR_THE_RIGHT_MOMENT_DUN_DUN_DEFENDMALLgaga", 7500, 1)
	end
end

function ARG.VAR.WAIT_FOR_THE_RIGHT_MOMENT_DUN_DUN_DEFENDMALLgaga(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	local i = 0
	while i ~= 4 do
		i = i + 1
		if math.random(1,2) == 1 then
			pUnit:SpawnCreature(AddG, behindGateAX, behindGateAY, behindGateAZ , 0, 15, 480000)
		else
			pUnit:SpawnCreature(AddG, behindGateBX, behindGateBY, behindGateBZ , 0, 15, 480000)
		end
	end
	if ARG[id].VAR.gateA ~= nil then
		ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		ARG[id].VAR.Open = true
	end
	if ARG[id].VAR.gateB ~= nil then
		ARG[id].VAR.gateB:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		ARG[id].VAR.Open = true
	end
	pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_WIPE_hurpdurpDEFENDMALL", 480000, 1)
	pUnit:RegisterEvent("ARG.VAR.Check_For_mobDDeaths_Yarpgggggh", 10000, 0)
end

function ARG.VAR.Check_For_mobDDeaths_Yarpgggggh(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.Open then
		if ARG[id].VAR.gateA ~= nil then
			ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
		if ARG[id].VAR.gateB ~= nil then
			ARG[id].VAR.gateB:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
	end
	if ARG[id].VAR.Dead > 59 then
		pUnit:RemoveEvents()
		ARG[id].VAR.Wave = ARG[id].VAR.Wave + 1
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2842) -- ID, total
			pack:WriteULong(ARG[id].VAR.Wave) -- Value
			plrs:SendPacketToPlayer(pack)
			pUnit:SendChatMessageToPlayer(42, 0, "Wave "..ARG[id].VAR.Wave.."!", plrs) -- 8
		end
		pUnit:RegisterEvent("ARG.VAR.FINALWAVE_DEFENDMALL", 8000, 1)
	end
end

function ARG.VAR.FINALWAVE_DEFENDMALL(pUnit)
	local i = 0
	local pla = nil
	while i ~= 20 do
		i = i + 1
		pla = pUnit:GetRandomPlayer(0)
		if pla ~= nil then
			pUnit:SpawnCreature(AddH, pla:GetX(), pla:GetY(), pla:GetZ(), 0, 15, 300000)
		end
	end
	pUnit:RegisterEvent("ARG.VAR.CHECK_FOR_WIPE_hurpdurpDEFENDMALL", 300000, 1)
	pUnit:RegisterEvent("ARG.VAR.WAVES_COMPLETE_BOSS_DUNDUN", 10000, 0)
end

function ARG.VAR.WAVES_COMPLETE_BOSS_DUNDUN(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if ARG[id].VAR.Dead > 63 then
		pUnit:RemoveEvents()
		ARG[id].VAR.Wave = 1
		ARG[id].VAR.Dead = 0
		local Grill = pUnit:GetGameObjectNearestCoords(4522, 2769, 404, 201755) -- x,y,z,id
		if Grill ~= nil then
			Grill:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open Trap
			pUnit:PlaySoundToSet(16541)
			Grill:Despawn(30000, 120000)
		end
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			pUnit:SendChatMessageToPlayer(42, 0, "The way to the boss is clear!", plrs)
		end
		pUnit:SpawnCreature(BossID, 4575, 2768, 361.3, 3.121345, 35, 0)
		pUnit:RegisterEvent("ARG.VAR.Check_For_EventDEFENDMALL", 10000, 0) -- CanStart is not true yet
	end
end

--

function ARG.VAR.CHECK_FOR_WIPE_hurpdurpDEFENDMALL(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	pUnit:RemoveEvents()
	ARG[id].VAR.Wave = 1
	ARG[id].VAR.Dead = 0
	if ARG[id].VAR.Open then
		if ARG[id].VAR.gateA ~= nil then
			ARG[id].VAR.gateA:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
		if ARG[id].VAR.gateB ~= nil then
			ARG[id].VAR.gateB:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
			ARG[id].VAR.Open = false
		end
	end
	pUnit:RegisterEvent("ARG.VAR.Check_For_EventDEFENDMALL", 10000, 0)
end

---------------------------------------------------------
-- Add Scripts ------------------------------------------
---------------------------------------------------------

function ARG.VAR.Adds_OnSpawn_ohlol(pUnit, Event)
	table.insert(Spawned, pUnit)
	pUnit:SetMovementFlags(1)
	pUnit:RegisterEvent("ARG.VAR.SetFaction_Hostile_After_Gate", 2500, 1)
	if pUnit:GetEntry() == AddG then
		pUnit:RegisterEvent("ARG.VAR.CastSoekks_DEFENDMALL", math.random(2000, 12000), 1)
	elseif pUnit:GetEntry() == AddH then
		pUnit:RegisterEvent("ARG.VAR.SPawnVisual_teoaj", math.random(250, 1000), 1)
	end
end

function ARG.VAR.SetFaction_Hostile_After_Gate(pUnit)
	pUnit:SetMovementFlags(1)
	pUnit:SetFaction(21)
	if math.random(1,2) == 1 then
		pUnit:MoveTo(locA+math.random(0,2),locB-math.random(0,2),locC,0)
	else
		pUnit:MoveTo(locX-math.random(0,2),locY+math.random(0,2),locZ,0)
	end
end

function ARG.VAR.Adds_OnDead_Ohlol(pUnit)
	pUnit:RemoveEvents()
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	if not ARG[id].VAR.Dead then
		ARG[id].VAR.Dead  = 0
	end
	ARG[id].VAR.Dead = ARG[id].VAR.Dead + 1
	--pUnit:Despawn(10,0) -- bugs
end

function ARG.VAR.CastSoekks_DEFENDMALL(pUnit)
	pUnit:CastSpell(15636) -- Avatar of flame
end

function ARG.VAR.SPawnVisual_teoaj(pUnit)
	pUnit:CastSpell(64446) -- Teleport visual
end

RegisterUnitEvent(AddA, 18, "ARG.VAR.Adds_OnSpawn_ohlol")
RegisterUnitEvent(AddB, 18, "ARG.VAR.Adds_OnSpawn_ohlol")
RegisterUnitEvent(AddC, 18, "ARG.VAR.Adds_OnSpawn_ohlol")
RegisterUnitEvent(AddD, 18, "ARG.VAR.Adds_OnSpawn_ohlol")
RegisterUnitEvent(AddE, 18, "ARG.VAR.Adds_OnSpawn_ohlol")
RegisterUnitEvent(AddF, 18, "ARG.VAR.Adds_OnSpawn_ohlol")
RegisterUnitEvent(AddG, 18, "ARG.VAR.Adds_OnSpawn_ohlol")
RegisterUnitEvent(AddH, 18, "ARG.VAR.Adds_OnSpawn_ohlol")

RegisterUnitEvent(AddA, 4, "ARG.VAR.Adds_OnDead_Ohlol")
RegisterUnitEvent(AddB, 4, "ARG.VAR.Adds_OnDead_Ohlol")
RegisterUnitEvent(AddC, 4, "ARG.VAR.Adds_OnDead_Ohlol")
RegisterUnitEvent(AddD, 4, "ARG.VAR.Adds_OnDead_Ohlol")
RegisterUnitEvent(AddE, 4, "ARG.VAR.Adds_OnDead_Ohlol")
RegisterUnitEvent(AddF, 4, "ARG.VAR.Adds_OnDead_Ohlol")
RegisterUnitEvent(AddG, 4, "ARG.VAR.Adds_OnDead_Ohlol")
RegisterUnitEvent(AddH, 4, "ARG.VAR.Adds_OnDead_Ohlol")

---------------------------------------------------------
-- Boss -------------------------------------------------
---------------------------------------------------------

function ARG.VAR.BOSS_ONDEATH_HURPDURP(pUnit)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(12,0,"Death... Is only the beginning.")
	for place, plrs in pairs(pUnit:GetInRangePlayers()) do
		pack = LuaPacket:CreatePacket(SMSG_INIT_WORLD_STATES, 18) -- Waves remaining
		pack:WriteULong(0) -- Map
		pack:WriteULong(0) -- Zone
		pack:WriteULong(0)
		pack:WriteUShort(0)
		pack:WriteULong(0) -- ID
		pack:WriteULong(0) -- Value
		plrs:SendPacketToPlayer(pack)
	end
end

function ARG.VAR.BOSS_ONLEAVE_HURPDURP(pUnit)
	pUnit:RemoveEvents()
end

function ARG.VAR.Boss_ONSPAWN_DEFENDMALL(pUnit)
	pUnit:RegisterEvent("ARG.VAR.CheckFOrPlayers_HUtoayp", 2500, 0)
end

function ARG.VAR.CheckFOrPlayers_HUtoayp(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 12 then
			pUnit:RemoveEvents()
			pUnit:SendChatMessage(12,0,"Welcome all, salutations are in order. My name is Arugal and unfortunately, you appear to be on tonights menu.")
			pUnit:MoveTo(4552.8, 2769.2, 351.4, 3)
			pUnit:EquipWeapons(18842, 0, 0)
			pUnit:RegisterEvent("ARG.VAR.WalkingDownStairs_DEFENDMALL", 11000, 1)
		end
	end
end

function ARG.VAR.WalkingDownStairs_DEFENDMALL(pUnit)
	pUnit:SendChatMessage(12,0,"Let me tenderise you all.")
	pUnit:Emote(1,3000)
	pUnit:RegisterEvent("ARG.VAR.Delay_A_Moment_GPOAJ", 4000, 1)
end

function ARG.VAR.Delay_A_Moment_GPOAJ(pUnit)
	pUnit:CastSpell(29880) -- Mana shield
	pUnit:Root()
	pUnit:SetFaction(21)
	local plr = nil
	local i = 0
	while i ~= 10 do
		i = i + 1
		plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			if math.random(1,2) == 1 then
				pUnit:CastSpellOnTarget(52257, plr) -- Shadowbolt
			end
			pUnit:CastSpellOnTarget(7124, plr) -- Damage
		end
	end
	pUnit:RegisterEvent("ARG.VAR.Shadowbolt_Spam_Three_Argual", 3005, 0)
	pUnit:RegisterEvent("ARG.VAR.VolleyOfShadowbolts", 7000, 0)
	pUnit:RegisterEvent("ARG.VAR.CheckForManaPCTPCTPCT", 2500, 0)
end

function ARG.VAR.Shadowbolt_Spam_Three_Argual(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		if math.random(1,5) ~= 1 then
			pUnit:FullCastSpellOnTarget(12739, plr) -- shadowbolt
		else
			pUnit:FullCastSpell(39082) -- shadowfury
		end
	end
end

function ARG.VAR.VolleyOfShadowbolts(pUnit)
	pUnit:CastSpell(29166) -- Innervate
	local plr = nil
	local i = 0
	while i ~= 10 do
		i = i + 1
		plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			pUnit:CastSpellOnTarget(52257, plr) -- Shadowbolt
		end
	end
end

function ARG.VAR.CheckForManaPCTPCTPCT(pUnit)
	if pUnit:GetManaPct() < 86 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12,0,"You're still underdone. Let me see if I can speed up the process.")
		pUnit:Unroot()
		pUnit:SetCombatCapable(true)
		pUnit:SetMovementFlags(1) -- Run
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			plrs:CastSpell(46416) -- Stun
		end
		pUnit:MoveTo(4522.52, 2769.3, 351.5, 0)
		pUnit:RegisterEvent("ARG.VAR.ResetPlayershurpdurp", 5000, 1)
	end
end

function ARG.VAR.ResetPlayershurpdurp(pUnit)
	pUnit:MoveTo(4522.52, 2769.3, 351.5, 0)
	pUnit:Root()
	pUnit:SetCombatCapable(false)
	for place, plrs in pairs(pUnit:GetInRangePlayers()) do
		plrs:RemoveAura(46416) -- Stun
	end
	pUnit:RegisterEvent("ARG.VAR.Stoneharry_FireLines", 1000, 1)
	pUnit:RegisterEvent("ARG.VAR.Shadowbolt_Spam_Three_Argual", 3005, 0)
	pUnit:RegisterEvent("ARG.VAR.VolleyOfShadowbolts", 7000, 0)
	pUnit:RegisterEvent("ARG.VAR.FlyPhaseDUndundun", 5000, 0)
	pUnit:RegisterEvent("ARG.VAR.LightningVisual_DEFENDMALL", 6397, 0)
	
end

function ARG.VAR.LightningVisual_DEFENDMALL(pUnit)
	local plz = pUnit:GetRandomPlayer(0)
	if plz ~= nil then
		pUnit:CastSpellOnTarget(37848, plz)
		pUnit:FullCastSpell(17228)
	end
	plz = pUnit:GetClosestPlayer()
	if plz ~= nil then
		if pUnit:GetDistanceYards(plz) < 10 then
			pUnit:CastSpellOnTarget(24199,plz)
		end
	end
end

function ARG.VAR.Stoneharry_FireLines(pUnit)
	-- We have four directions in which to go in
	local choice = math.random(1,4)
	if choice == 1 then
		-- Direction 1
		pUnit:SpawnCreature(FIRE, pUnit:GetX()+5, pUnit:GetY(), pUnit:GetZ(), 0, 21, 4500)
		zX = pUnit:GetX()+5
		-- Keep them spawning in the line
		pUnit:RegisterEvent("ARG.VAR.Keep_spawning_fires_in_a_line", 750, 5)
	elseif choice == 2 then
		pUnit:SpawnCreature(FIRE, pUnit:GetX(), pUnit:GetY()+5, pUnit:GetZ(), 0, 21, 4500)
		zX = pUnit:GetY()+5
		pUnit:RegisterEvent("ARG.VAR.zKeep_spawning_fires_in_a_line", 750, 5)
	elseif choice == 3 then
		pUnit:SpawnCreature(FIRE, pUnit:GetX()+5, pUnit:GetY()+5, pUnit:GetZ(), 0, 21, 4500)
		zX = pUnit:GetY()+5
		zY = pUnit:GetX()+5
		pUnit:RegisterEvent("ARG.VAR.zzKeep_spawning_fires_in_a_line", 750, 5)	
	elseif choice == 4 then
		pUnit:SpawnCreature(FIRE, pUnit:GetX()-5, pUnit:GetY()-5, pUnit:GetZ(), 0, 21, 4500)
		zX = pUnit:GetY()-5
		zY = pUnit:GetX()-5
		pUnit:RegisterEvent("ARG.VAR.zzzKeep_spawning_fires_in_a_line", 750, 5)
	elseif choice == 5 then
		pUnit:SpawnCreature(FIRE, pUnit:GetX()-5, pUnit:GetY()+5, pUnit:GetZ(), 0, 21, 4500)
		zX = pUnit:GetY()+5
		zY = pUnit:GetX()-5
		pUnit:RegisterEvent("ARG.VAR.zzzzKeep_spawning_fires_in_a_line", 750, 5)	
	elseif choice == 5 then
		pUnit:SpawnCreature(FIRE, pUnit:GetX()+5, pUnit:GetY()-5, pUnit:GetZ(), 0, 21, 4500)
		zX = pUnit:GetY()-5
		zY = pUnit:GetX()+5
		pUnit:RegisterEvent("ARG.VAR.zzzzzKeep_spawning_fires_in_a_line", 750, 5)	
	end
	-- So we are random timer each time
	pUnit:RegisterEvent("ARG.VAR.Stoneharry_FireLines", math.random(4000, 10000), 1)
end

function ARG.VAR.Keep_spawning_fires_in_a_line(pUnit)
	zX = zX + 5 -- left
	pUnit:SpawnCreature(FIRE, zX, pUnit:GetY(), pUnit:GetZ(), 0, 21, 5000)	
end

function ARG.VAR.zKeep_spawning_fires_in_a_line(pUnit)
	zX = zX + 5 -- Right
	pUnit:SpawnCreature(FIRE, pUnit:GetX(), zX, pUnit:GetZ(), 0, 21, 5000)	
end

function ARG.VAR.zzKeep_spawning_fires_in_a_line(pUnit)
	zX = zX + 5 -- Up
	zY = zY + 5 -- Up
	pUnit:SpawnCreature(FIRE, zY, zX, pUnit:GetZ(), 0, 21, 5000)	
end

function ARG.VAR.zzzKeep_spawning_fires_in_a_line(pUnit)
	zX = zX - 5 -- Down
	zY = zY - 5 -- Down
	pUnit:SpawnCreature(FIRE, zY, zX, pUnit:GetZ(), 0, 21, 5000)	
end

function ARG.VAR.zzzzKeep_spawning_fires_in_a_line(pUnit)
	zX = zX - 5
	zY = zY + 5
	pUnit:SpawnCreature(FIRE, zY, zX, pUnit:GetZ(), 0, 21, 5000)	
end

function ARG.VAR.zzzzzKeep_spawning_fires_in_a_line(pUnit)
	zX = zX + 5 -- Down
	zY = zY - 5 -- Down
	pUnit:SpawnCreature(FIRE, zY, zX, pUnit:GetZ(), 0, 21, 5000)	
end

function ARG.VAR.FlyPhaseDUndundun(pUnit)
	if pUnit:GetManaPct() < 50 then
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			plrs:EnableFlight(true)
		end
		pUnit:CastSpell(29166) -- Innervate
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12,0,"I think you would taste better overdone afterall!")
		pUnit:Unroot()
		pUnit:SetMovementFlags(2)
		pUnit:SetCombatCapable(true)
		pUnit:CastSpell(41918) -- Visual
		pUnit:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+8, 0)
		pUnit:SendChatMessage(42,0,"You can now fly!")
		pUnit:RegisterEvent("ARG.VAR.CheckHealthTROLOLOL", 5000, 0)
		pUnit:RegisterEvent("ARG.VAR.FixtateMovement", 1000, 1)
		pUnit:RegisterEvent("ARG.VAR.messup_Stoneharry", 5500, 0)
		pUnit:RegisterEvent("ARG.VAR.Stoneharry_FireLines", 5000, 1)
		pUnit:RegisterEvent("ARG.VAR.Shadowbolt_Spam_Three_Argual", 3005, 0)
		pUnit:RegisterEvent("ARG.VAR.VolleyOfShadowbolts", 7000, 0)
	end
end

function ARG.VAR.FixtateMovement(pUnit)
	pUnit:SetCombatCapable(false)
	pUnit:Root()
end

function ARG.VAR.messup_Stoneharry(pUnit)
	local plrA = pUnit:GetRandomPlayer(0) -- Get two players
	local plrB = pUnit:GetRandomPlayer(0) -- Get two players
	if plrA ~= nil and plrB ~= nil then	  -- Make sure we did return somebody in the fight
		if plrA == plrB then -- Make sure they are not the same person
			local plrB = pUnit:GetRandomPlayer(0) -- Try again
			if plrA == plrB then -- You better not be the same person
				plrB = pUnit:GetClosestPlayer()	-- That's it, someone more reliable
			end
		end
		if plrA ~= plrB then
			plrA:CancelSpell()
			plrB:CancelSpell() -- Stop casting
			local aX = plrA:GetX()
			local aY = plrA:GetY()
			local aZ = plrA:GetZ()
			local aO = plrA:GetO()
			plrA:SetPosition(plrB:GetX(), plrB:GetY(), plrB:GetZ(), plrB:GetO()) -- Switch players, muhahaha
			plrB:SetPosition(aX, aY, aZ, aO)
			pUnit:SendChatMessageToPlayer(42,0,"You have switches places with "..plrB:GetName().."!", plrA)
			pUnit:SendChatMessageToPlayer(42,0,"You have switches places with "..plrA:GetName().."!", plrB)
			plrA:CastSpell(64446) -- Teleport visual
			plrB:CastSpell(64446)
		end
	end
end

function ARG.VAR.CheckHealthTROLOLOL(pUnit)
	if pUnit:GetManaPct() < 3 then
		pUnit:CastSpell(29166) -- Innervate
		pUnit:RemoveEvents()
		pUnit:SetMovementFlags(1)
		pUnit:Unroot()
		pUnit:RemoveAura(29880) -- Mana shield
		pUnit:SetCombatCapable(false)
		pUnit:SendChatMessage(12,0,"Shaken, not stirred.")
		for place, plrs in pairs(pUnit:GetInRangePlayers()) do
			plrs:EnableFlight(false)
		end
		pUnit:RegisterEvent("ARG.VAR.nomanaleft_malldefense", 5000, 0)
		pUnit:RegisterEvent("ARG.VAR.MINDCONTROLLLLLLL", 3005, 0)
	end
end

function ARG.VAR.MINDCONTROLLLLLLL(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		plr:SetPlayerLock(true)
		pUnit:Root()
		plr:SetFaction(21)
		pUnit:ChannelSpell(60452, plr)
		plr:FullCastSpell(39082) -- shadowfury
		RegisterTimedEvent("ARG.VAR.RESETPUNITANDPLAYER_DEFENDMALL", 3000, 1, pUnit, plr)
	end
end

function ARG.VAR.RESETPUNITANDPLAYER_DEFENDMALL(pUnit, plr)
	if plr ~= nil then
		plr:SetPlayerLock(false)
		local race = plr:GetPlayerRace()
		if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then -- alliance
			plr:SetFaction(1)
		else
			plr:SetFaction(2)
		end
		pUnit:Unroot()
		pUnit:StopChannel()
	end
end

function ARG.VAR.nomanaleft_malldefense(pUnit)
	if pUnit:GetHealthPct() < 80 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("ARG.VAR.Stoneharry_FireLines", 1000, 1)
		pUnit:RegisterEvent("ARG.VAR.MINDCONTROLLLLLLL", 3005, 0)
		pUnit:SendChatMessage(12,0,"You appear to have escaped a roasted end, however, I am afraid I will have to put you out of your misery. Livestock must not be released.")
	end
end

RegisterUnitEvent(BossID, 18, "ARG.VAR.Boss_ONSPAWN_DEFENDMALL")
RegisterUnitEvent(BossID, 4, "ARG.VAR.BOSS_ONDEATH_HURPDURP")
RegisterUnitEvent(BossID, 2, "ARG.VAR.BOSS_ONLEAVE_HURPDURP")

---------------------------------------------------------

function ARG.VAR.Fire_Visuals_Stoneharry(pUnit, event)
	pUnit:Root()
	pUnit:SetCombatCapable(true)
	pUnit:RegisterEvent("ARG.VAR.WAIT_A_SEC_SEC_SEC", 1000, 1)
end

function ARG.VAR.WAIT_A_SEC_SEC_SEC(pUnit, Event)
	pUnit:Root() -- On spawn doesn't always trigger properly, so we'll do it again to be safe
	pUnit:SetCombatCapable(true)
	pUnit:CastSpell(74713) -- Visual
	pUnit:RegisterEvent("ARG.VAR.zzzWAIT_A_SEC_SEC_SEC", math.random(500,1000), 5) -- To give a bit of variety
end

function ARG.VAR.zzzWAIT_A_SEC_SEC_SEC(pUnit, Event)
	pUnit:CastSpell(1449) -- Visual and damage
end

RegisterUnitEvent(FIRE, 18, "ARG.VAR.Fire_Visuals_Stoneharry")

---------------------------------------------------------

--[[
	Debug Below
		Comment out later
]]

--[[function ARG.VAR.OnChat_Hook_ToJoinBG(event, plr, message, pType, pLanguage, pMisc)
	local message = string.lower(message)
	if message == "#start" then
		local id = plr:GetInstanceID()
		if id == nil then id = 1 end
		ARG[id] = ARG[id] or {VAR={}}
		ARG[id].VAR.CanStart = true
		return 0
	end
end

RegisterServerHook(16, "ARG.VAR.OnChat_Hook_ToJoinBG")]]

function ARG.VAR.ControlNPC_OnDeath(pUnit, Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ARG[id] = ARG[id] or {VAR={}}
	ARG[id].VAR.CanStart = true
	table.insert(Spawned, pUnit)
end

RegisterUnitEvent(95341, 4, "ARG.VAR.ControlNPC_OnDeath")

---------------------------------------------------------