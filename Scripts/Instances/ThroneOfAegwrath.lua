TOA = {}
TOA.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local UNIT_FIELD_CHARMEDBY = OBJECT_END + 0x0006
local UNIT_FIELD_CHARM = OBJECT_END + 0x0000
local UNIT_FLAG_PVP_ATTACKABLE = 0x00000008
local UNIT_FLAG_PLAYER_CONTROLLED_CREATURE = 0x01000000
local UNIT_END = OBJECT_END + 0x008E
local PLAYER_DUEL_TEAM = UNIT_END + 0x0008
local PLAYER_DUEL_ARBITER = UNIT_END + 0x0000
local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3

-- Cinematic creature

function TOA.VAR.CinematicDummy(pUnit, Event)
	pUnit:RegisterEvent("TOA.VAR.DummyCheckPlayers", 1000, 0)
end

function TOA.VAR.DummyCheckPlayers(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if plr:GetDistanceYards(pUnit) < 15 then
			for _,v in pairs(pUnit:GetInRangePlayers()) do
				v:Root()
				v:SetPlayerLock(1)
				v:SendCinematic(250)
			end
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("TOA.VAR.OpenGateCinematic", 10000, 1)
			pUnit:RegisterEvent("TOA.VAR.UnrootPlayersCinematic", 30000, 1)
		end
	end
end

function TOA.VAR.UnrootPlayersCinematic(pUnit)
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		plrs:Unroot()
		plrs:SetPlayerLock(0)
	end
	pUnit:Despawn(1,0)
end

function TOA.VAR.OpenGateCinematic(pUnit)
	local gate = pUnit:GetGameObjectNearestCoords(2557.13,2493.04,-33.779,177307)
	if gate then
		gate:SetByte(GAMEOBJECT_BYTES_1,0,0)
	end
end

RegisterUnitEvent(116865, 18, "TOA.VAR.CinematicDummy")

--

function TOA.VAR.MEGAERA_EVENTS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if Event == 1 then
		TOA[id].VAR.FirstHead = pUnit
		pUnit:RegisterEvent("TOA.VAR.BringupHeads", 1000, 1)
		pUnit:RegisterEvent("TOA.VAR.Heads_ConeofFire", math.random(15000,25000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		TOA[id].VAR.SecondHead:Despawn(2000,4000)
		TOA[id].VAR.ThirdHead:Despawn(2000,4000)
		pUnit:Despawn(2000,4000)
	elseif Event == 18 then
		TOA[id].VAR.FirstHead = pUnit
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end

RegisterUnitEvent(749814, 1, "TOA.VAR.MEGAERA_EVENTS")
RegisterUnitEvent(749814, 2, "TOA.VAR.MEGAERA_EVENTS")
RegisterUnitEvent(749814, 4, "TOA.VAR.MEGAERA_EVENTS")


function TOA.VAR.BringupHeads(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	pUnit:SendChatMessage(42,0,"Megaera calls it's other heads to aid it!")
	TOA[id].VAR.SecondHead:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	TOA[id].VAR.SecondHead:SetUInt32Value(UNIT_FIELD_BYTES_1, 0)
	TOA[id].VAR.ThirdHead:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	TOA[id].VAR.ThirdHead:SetUInt32Value(UNIT_FIELD_BYTES_1, 0)
	
end

function TOA.VAR.SecondHead_Events(pUnit,Event)
	if Event == 18 then
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		TOA[id] = TOA[id] or {VAR={}}
		pUnit:AIDisableCombat(false)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 9)
		TOA[id].VAR.SecondHead = pUnit
	elseif Event == 1 then
		pUnit:RegisterEvent("TOA.VAR.SecondHeadLow", 2000, 0)
		pUnit:RegisterEvent("TOA.VAR.Heads_ConeofFire", math.random(15000,25000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:Despawn(2000,4000)
	end
end

function TOA.VAR.ThirdHead_Events(pUnit,Event)
	if Event == 18 then
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		TOA[id] = TOA[id] or {VAR={}}
		pUnit:AIDisableCombat(false)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 9)
		TOA[id].VAR.ThirdHead = pUnit
	elseif Event == 1 then
		pUnit:RegisterEvent("TOA.VAR.ThirdHeadLow", 2000, 0)
		pUnit:RegisterEvent("TOA.VAR.Heads_ConeofFire", math.random(15000,25000), 0)
		pUnit:RegisterEvent("TOA.VAR.ThirdHead_Icelance", math.random(7000,10000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:Despawn(2000,4000)
	end
end

function TOA.VAR.ThirdHeadLow(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if pUnit:GetHealthPct() < 2 then
		pUnit:RemoveEvents()
		pUnit:AIDisableCombat(true)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 9)
		---
		pUnit:SendChatMessage(42,0,"|cff00ff00|TInterface\\icons\\spell_frost_stun:30|t|r Megaera has been damaged!")
		pUnit:CastSpellOnTarget(41410, TOA[id].VAR.FirstHead)
		TOA[id].VAR.FirstHead:AIDisableCombat(true)
		TOA[id].VAR.FirstHead:Emote(468,10000)
		TOA[id].VAR.FirstHead:CastSpell(61251)
		TOA[id].VAR.FirstHead:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
		pUnit:RegisterEvent("TOA.VAR.ResetHeads_romstun", 10000, 1)
		if 	TOA[id].VAR.SecondHead:GetHealthPct() > 2 then
			TOA[id].VAR.SecondHead:Emote(468,10000)
			TOA[id].VAR.SecondHead:AIDisableCombat(true)
			pUnit:CastSpellOnTarget(41410, TOA[id].VAR.SecondHead)
			TOA[id].VAR.SecondHead:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
		end
	end
end
	
function TOA.VAR.SecondHeadLow(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if pUnit:GetHealthPct() < 2 then
		pUnit:RemoveEvents()
		pUnit:AIDisableCombat(true)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 9)
		---
		pUnit:SendChatMessage(42,0,"|cff00ff00|TInterface\\icons\\spell_frost_stun:30|t|r Megaera has been damaged!")
		pUnit:CastSpellOnTarget(41410,TOA[id].VAR.FirstHead)
		TOA[id].VAR.FirstHead:AIDisableCombat(true)
		TOA[id].VAR.FirstHead:Emote(468,10000)
		TOA[id].VAR.FirstHead:CastSpell(58105)
		TOA[id].VAR.FirstHead:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
		pUnit:RegisterEvent("TOA.VAR.ResetHeads_romstun", 10000, 1)
		if 	TOA[id].VAR.ThirdHead:GetHealthPct() > 2 then
			TOA[id].VAR.ThirdHead:Emote(468,10000)
			TOA[id].VAR.ThirdHead:AIDisableCombat(true)
			pUnit:CastSpellOnTarget(41410,TOA[id].VAR.ThirdHead)
			TOA[id].VAR.ThirdHead:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
		end
	end
end

function TOA.VAR.ResetHeads_romstun(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	pUnit:SendChatMessage(42,0,"Megaera has regained it's consciousness!")
	TOA[id].VAR.FirstHead:AIDisableCombat(false)
	TOA[id].VAR.FirstHead:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	if 	TOA[id].VAR.SecondHead:GetHealthPct() > 2 then
		TOA[id].VAR.SecondHead:AIDisableCombat(false)
		TOA[id].VAR.SecondHead:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	end
		if 	TOA[id].VAR.ThirdHead:GetHealthPct() > 2 then
		TOA[id].VAR.ThirdHead:AIDisableCombat(false)
		TOA[id].VAR.ThirdHead:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	end
end

function TOA.VAR.Heads_ConeofFire(pUnit,Event)
	pUnit:SendChatMessage(42,0,pUnit:GetName().." Casts |cff00ff00|TInterface\\icons\\spell_fire_windsofwoe:30|t|r \124cffffd000\124Hspell:19630\124h[Cone of Fire]\124h\124r!")
	pUnit:CastSpell(19630)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 34 then
			pUnit:Strike(players,1,37826,940,1125,2)
		end
	end
end

function TOA.VAR.ThirdHead_Icelance(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(3)
	if plr then
		if pUnit:GetDistanceYards(plr) < 50 then
			if not plr:IsDead() then
				pUnit:CastSpellOnTarget(30455,plr)
				for _,players in pairs(plr:GetInRangePlayers()) do
					if pUnit:GetDistanceYards(players) < 10 then
						pUnit:CastSpellOnTarget(33528,players)
						pUnit:CastSpellOnTarget(33528,plr)
					end
				end
				if plr:HasAura(33528) then
					plr:CastSpell(65802)
					plr:RemoveAura(33528)
					plr:SetHealth(plr:GetHealth()-800)
				else
					pUnit:SpawnCreature(777190,plr:GetX() , plr:GetY(), plr:GetZ(), plr:GetO(), 14, 3000)
				end
			end
		end
	end
end

RegisterUnitEvent(749815, 18, "TOA.VAR.SecondHead_Events")
RegisterUnitEvent(749815, 1, "TOA.VAR.SecondHead_Events")
RegisterUnitEvent(749815, 2, "TOA.VAR.SecondHead_Events")

RegisterUnitEvent(749816, 18, "TOA.VAR.ThirdHead_Events")
RegisterUnitEvent(749816, 1, "TOA.VAR.ThirdHead_Events")
RegisterUnitEvent(749816, 2, "TOA.VAR.ThirdHead_Events")

function TOA.VAR.FrozenDummySpwn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("TOA.VAR.zzEnsureregister", 1000, 1)
end

function TOA.VAR.zzEnsureregister(pUnit,Event)
	pUnit:CastSpell(122)
end

RegisterUnitEvent(777190, 18, "TOA.VAR.FrozenDummySpwn")

--------------

function TOA.VAR.Gatekeep_Events(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if Event == 18 then
		if TOA[id].VAR.Gateintrospeech ~= 1 then
			pUnit:SendChatMessage(14, 0, "Enough hiding little ones!")
			pUnit:PlaySoundToSet(50011)
			pUnit:RegisterEvent("TOA.VAR.Gatekeep_Intro", 4100, 1)
		end
	elseif Event == 1 then
		pUnit:SendChatMessage(14, 0, "Trespassers will be EXECUTED!")
		pUnit:RegisterEvent("TOA.VAR.Gatekeep_Phase", 1000, 0)
		pUnit:RegisterEvent("TOA.VAR.Gatekeep_Event",  math.random(25000,35000), 0)
		pUnit:RegisterEvent("TOA.VAR.Gatekeep_leap",  math.random(12000,15000), 0)
		pUnit:RegisterEvent("TOA.VAR.GATEKEEP_THROWSTUFF",  math.random(8000,13000), 0)
		pUnit:PlaySoundToSet(50007)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:Despawn(1000,4000)
		for _,rocks in pairs(pUnit:GetInRangeObjects()) do 
			if rocks:GetEntry() == 196485 then 
				rocks:Despawn(1,0)
				end
end
	elseif Event == 3 then
		pUnit:SendChatMessage(14, 0, "YOU ARE FINISHED!")
		--pUnit:PlaySoundToSet(14375)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14, 0, "NONE... SHALL...")
		pUnit:PlaySoundToSet(50008)
	end
end
	function TOA.VAR.GATEKEEP_PERMAFROST(pUnit)
		for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 50 then
		if players:IsAlive() then
	pUnit:CastSpellOnTarget(68786,players)
	end
	end
	end
	end
	
	function TOA.VAR.GATEKEEP_THROWSTUFF(pUnit,Event)
		pUnit:RegisterEvent("TOA.VAR.RESIZE_ROCKS", 2000, 1)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 50 then
		if players:IsAlive() then
		pUnit:CastSpellOnTarget(68788,players)
			end
		end
	end
end

function TOA.VAR.RESIZE_ROCKS(pUnit)
for _,rocks in pairs(pUnit:GetInRangeObjects()) do 
	if rocks:GetEntry() == 196485 then 
		rocks:SetScale(5)
		end
	end
end
	
	
function TOA.VAR.Gatekeep_leap(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(3)
	if plr then
		if pUnit:GetDistanceYards(plr) < 50 then
			if not plr:IsDead() then
				pUnit:CastSpellOnTarget(58960, plr)
			end
		end
	end
end


	
function TOA.VAR.Gatekeep_Phase(pUnit,Event)
	if pUnit:GetHealthPct() < 30 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14, 0, "To strike me, is to strike his majesty! HE will not suffer this insult!")
		pUnit:PlaySoundToSet(50010)
pUnit:RegisterEvent("TOA.VAR.GATEKEEP_PERMAFROST",  math.random(2000,3000), 0)
		pUnit:RegisterEvent("TOA.VAR.Gatekeep_leap",  math.random(12000,15000), 0)
		pUnit:RegisterEvent("TOA.VAR.GATEKEEP_THROWSTUFF",  math.random(5000,7000), 0)
	end
end
	
function TOA.VAR.Gatekeep_Event(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "KEEP OUT!")
	pUnit:PlaySoundToSet(50009)
	pUnit:CastSpell(33525)
	pUnit:RegisterEvent("TOA.VAR.Gatekeep_EventCheck", 11100, 1)
end
	
function TOA.VAR.Gatekeep_EventCheck(pUnit,Event)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 50 then
			if players:HasAura(22683) or players:HasAura(22684) then
				players:RemoveAura(33525)
				pUnit:Strike(players,1,37826,810,850,2)
			else
				pUnit:Kill(players)
			end
		end
	end
end
	
function TOA.VAR.Gatekeep_Intro(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "There is no escape..the only way out is through me!")
	pUnit:PlaySoundToSet(50012)
	pUnit:RegisterEvent("TOA.VAR.Gatekeep_Introtwo", 8100, 1)
end
	
function TOA.VAR.Gatekeep_Introtwo(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	TOA[id].VAR.Gateintrospeech = 1
	pUnit:SendChatMessage(14, 0, "These gates are sealed by imperial decree!")
	pUnit:PlaySoundToSet(50013)
end

RegisterUnitEvent(7819231, 18, "TOA.VAR.Gatekeep_Events")
RegisterUnitEvent(7819231, 1, "TOA.VAR.Gatekeep_Events")
RegisterUnitEvent(7819231, 2, "TOA.VAR.Gatekeep_Events")
RegisterUnitEvent(7819231, 3, "TOA.VAR.Gatekeep_Events")
RegisterUnitEvent(7819231, 4, "TOA.VAR.Gatekeep_Events")

function TOA.VAR.BOUNDSERVANT_Events(pUnit,Event)
	if Event == 18 then
		pUnit:CastSpell(15533)
	elseif Event == 1 then
		pUnit:CastSpell(10347)
		pUnit:RemoveAura(15533)
	end
end

RegisterUnitEvent(33722, 18, "TOA.VAR.BOUNDSERVANT_Events")
RegisterUnitEvent(33722, 1, "TOA.VAR.BOUNDSERVANT_Events")

function TOA.VAR.KING_EVENTS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if Event == 1 then
		TOA[id].VAR.KingInCombat = 1
		pUnit:SendChatMessage(14, 0, "You invade my home and then dare to challenge me? I will tear the hearts from your chests and offer them as gifts to the death god! Rualg nja gaborr!")
		pUnit:PlaySoundToSet(13609)
		pUnit:RegisterEvent("TOA.VAR.KING_Decapitate",  math.random(10000,15000), 0)
	elseif Event == 3 then
		local choice = math.random(1,3)
		if choice == 1 then
			pUnit:SendChatMessage(14, 0, "Your death is only the beginning!")
			pUnit:PlaySoundToSet(13614)
		elseif choice == 2 then
			pUnit:SendChatMessage(14, 0, "You have failed your people!")
			pUnit:PlaySoundToSet(13615)
		elseif choice == 3 then
			pUnit:SendChatMessage(14, 0, "There is a reason I am king!")
			pUnit:PlaySoundToSet(13616)
		end
	elseif Event == 2 then
		pUnit:RemoveEvents()
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 36789 then 
				creatures:Despawn(1,0)
			end
		end
		TOA[id].VAR.KingInCombat = 0
		pUnit:Unroot()
		pUnit:Despawn(1000,5000)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14, 0, "What... awaits me... now?")
		pUnit:PlaySoundToSet(13618)
		TOA[id].VAR.KingInCombat = 0
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 36789 then 
				creatures:Despawn(1,0)
			end
		end
	end
end

function TOA.VAR.KING_Decapitate(pUnit,Event)
	pUnit:Root()
	pUnit:FullCastSpell(54670)
	pUnit:RegisterEvent("TOA.VAR.KING_UNROOTSIR", 3100, 1)
end

function TOA.VAR.KING_UNROOTSIR(pUnit,Event)
	pUnit:Unroot()
end

--[[
function TOA.VAR.KING_RUNICPOWER_CRYSTALS(pUnit,Event) -- gives nearby crystals runic power per second(up to 100)
-- if crystals are 100 rp and king is near, king is buffed and crystals explode. implement later..
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if pUnit:GetDistanceYards(creatures) < 15 then
		if creatures:GetEntry() == 493812 then 
		pUnit:SetMaxPower(1000,6)
		pUnit:SetPowerType(6)
pUnit:SetPower(creatures:GetPowerType()+1,6)	
end
end
end
end]]

function TOA.VAR.crystal_crashes(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if TOA[id].VAR.KingInCombat == 1 then
		local player = pUnit:GetRandomPlayer(0)
		if player then
			TOA[id].VAR.xloc = player:GetX()
			TOA[id].VAR.yloc = player:GetY()
			TOA[id].VAR.zloc = player:GetZ()
			if pUnit:GetDistanceYards(player) < 60 then
				if not player:IsDead() then
					pUnit:CastSpellAoF(TOA[id].VAR.xloc, TOA[id].VAR.yloc,TOA[id].VAR.zloc,63722)
					pUnit:RegisterEvent("TOA.VAR.AFTERMATH_VOIDZONES",  5000, 1)
				end
			end
		end
	end
end

function TOA.VAR.AFTERMATH_VOIDZONES(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	pUnit:SpawnCreature(743124,TOA[id].VAR.xloc, TOA[id].VAR.yloc,TOA[id].VAR.zloc,pUnit:GetO(), 35, 22000)
	pUnit:SpawnCreature(36789,TOA[id].VAR.xloc, TOA[id].VAR.yloc,TOA[id].VAR.zloc,pUnit:GetO(), 14, 9999000)
end

function TOA.VAR.CRYSTAL_Events(pUnit,Event)
	if Event == 18 then
		pUnit:RegisterEvent("TOA.VAR.crystal_crashes",  math.random(15000,21000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	end
end

RegisterUnitEvent(493812, 18, "TOA.VAR.CRYSTAL_Events")
RegisterUnitEvent(493812, 2, "TOA.VAR.CRYSTAL_Events")

RegisterUnitEvent(498121, 1, "TOA.VAR.KING_EVENTS")
RegisterUnitEvent(498121, 2, "TOA.VAR.KING_EVENTS")
RegisterUnitEvent(498121, 3, "TOA.VAR.KING_EVENTS")
RegisterUnitEvent(498121, 4, "TOA.VAR.KING_EVENTS")



---SECRET BOSS--


function TOA.VAR.RADEN_EVENTS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if Event == 18 then
		TOA[id].VAR.TitanCaptured = pUnit
		pUnit:Unroot()
		pUnit:RegisterEvent("TOA.VAR.RADEN_SETFLAGS", 2000, 1)
	elseif Event == 1 then
		pUnit:SendChatMessage(14, 0, "When I am finished with you, I shall not rest until this world is cleansed. Now, perish!")
		pUnit:PlaySoundToSet(50016)
		pUnit:RegisterEvent("TOA.VAR.AGONIZINGSTRIKE_RADEN",  math.random(12000,16000), 2)
		pUnit:RegisterEvent("TOA.VAR.RADEN_TASEOFPOWER",  math.random(31000,35000), 1)
		pUnit:RegisterEvent("TOA.VAR.RADEN_CHAINLIGHTNING",  math.random(8000,10000), 3)
	elseif Event == 2 then -- leave
		pUnit:RemoveEvents()
		TOA[id].VAR.RadenAttempts = TOA[id].VAR.RadenAttempts + 1
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 9981232 or 9981233 or 9981234 then 
				creatures:Despawn(1,0)
			end
		end
		if TOA[id].VAR.RadenAttempts >= 25 then
			pUnit:Despawn(1,0)
		else
			pUnit:Despawn(1,7000)
		end
	elseif Event == 3 then --kill
		if math.random(1,2) == 1 then
			pUnit:SendChatMessage(14, 0, "Accept the inevitable.")
			pUnit:PlaySoundToSet(50020)
		else
			pUnit:SendChatMessage(14, 0, "Amusing. You really thought you could win.")
			pUnit:PlaySoundToSet(50021)
		end
	end
end

function TOA.VAR.AGONIZINGSTRIKE_RADEN(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 12 then
			pUnit:CastSpellOnTarget(58504,tank)
		end
	end
end

function TOA.VAR.RADEN_TASEOFPOWER(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "This is but a taste of my power.")
	pUnit:PlaySoundToSet(50029)
	pUnit:Root()
	--pUnit:TeleportCreature(2599.93,2489.66,-32.30)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
	pUnit:Emote(468,30000)
	pUnit:SpawnCreature(9981232,pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),0,35,30000)
	--pUnit:SpawnCreature(9981233,2572.93,2490.87,-33.24,0,35,30000)
	local plr = pUnit:GetRandomPlayer(7)
	if not plr then
		plr = pUnit:GetClosestPlayer()
	end
	pUnit:SpawnCreature(9981233,plr:GetX(), plr:GetY(), plr:GetZ(),0,35,32000)
	pUnit:RegisterEvent("TOA.VAR.RADEN_DEALDAMAGES",  1000, 30)
	pUnit:RegisterEvent("TOA.VAR.RADEN_REVERT",  30000, 1)
	pUnit:RegisterEvent("TOA.VAR.SPAWNAIRELEMENTALS_RADEN",  5000, 5)	
end

function TOA.VAR.SPAWNAIRELEMENTALS_RADEN(pUnit,Event)
	pUnit:SpawnCreature(9981234,pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),0,14,0)
end

function TOA.VAR.THUNDERSPAWN_EVENTS(pUnit,Event)
	if Event == 18 then
		pUnit:SetMovementFlags(1) 
		pUnit:RegisterEvent("TOA.VAR.THUNDERSPAWN_MOVETO",  1000, 1)
	end
end

function TOA.VAR.THUNDERSPAWN_MOVETO(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(0)
	if not plr then
		plr = pUnit:GetClosestPlayer()
	end
	if plr then
		if plr:IsAlive() then
			pUnit:AttackReaction(plr, 1, 0)
		else
			pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
		end
	end
end

RegisterUnitEvent(9981234, 18, "TOA.VAR.THUNDERSPAWN_EVENTS")

function TOA.VAR.RADEN_REVERT(pUnit,Event)
	pUnit:Unroot()
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	pUnit:RegisterEvent("TOA.VAR.AGONIZINGSTRIKE_RADEN",  math.random(12000,16000), 2)
	pUnit:RegisterEvent("TOA.VAR.RADEN_CHAINLIGHTNING",  math.random(8000,10000), 3)
	pUnit:RegisterEvent("TOA.VAR.RADEN_TASEOFPOWER",  math.random(31000,35000), 1)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 80 then
			players:RemoveAura(31901)
		end
	end
end

function TOA.VAR.RADEN_CHAINLIGHTNING(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		if pUnit:GetDistanceYards(plr) < 70 then
			if not plr:IsDead() then
				pUnit:CastSpellOnTarget(32690,plr)
			end
		end
	end
end


function TOA.VAR.RADEN_DEALDAMAGES(pUnit,Event)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 80 then
			if not players:IsDead() then
				pUnit:Strike(players,1,1535,400,540,1)
			end
		end
	end
end

function TOA.VAR.SHIELDPROTECT_RADENFROMTHUNDER(pUnit,Event)
	pUnit:RegisterEvent("TOA.VAR.RepeatSpell_Visual", 1000, 1)
	pUnit:CastSpell(63894)
	pUnit:SetScale(.5)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("TOA.VAR.REVISUAL_PROTECT",  8000, 4)
	pUnit:RegisterEvent("TOA.VAR.PROTECTPLAYERS",  1000, 29)
	pUnit:RegisterEvent("TOA.VAR.RemoveVisualFromBubble", 30000, 1)
end

function TOA.VAR.RepeatSpell_Visual(pUnit)
	pUnit:CastSpell(63894)
end

function TOA.VAR.RemoveVisualFromBubble(pUnit)
	pUnit:RemoveAura(63894)
end

RegisterUnitEvent(9981233, 18, "TOA.VAR.SHIELDPROTECT_RADENFROMTHUNDER")

function TOA.VAR.PROTECTPLAYERS(pUnit,Event)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 12 then
			if players:HasAura(31901) == false and players:IsDead() == false then
				players:CastSpell(31901)
			elseif pUnit:GetDistanceYards(players) > 12 then
				players:RemoveAura(31901)
			end
		end
	end
end

function TOA.VAR.REVISUAL_PROTECT(pUnit,Event)
	pUnit:CastSpell(63894)
end

function TOA.VAR.THUNDERCALLDUMMY_RADEN(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:SetScale(7)
	pUnit:RegisterEvent("TOA.VAR.THUNDERCALL_VISUAL",  1000, 30)
end

RegisterUnitEvent(9981232, 18, "TOA.VAR.THUNDERCALLDUMMY_RADEN")

function TOA.VAR.THUNDERCALL_VISUAL(pUnit,Event)
	pUnit:CastSpell(59507)
end

-------

function TOA.VAR.RADEN_SETFLAGS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if TOA[id].VAR.RadenAwakened == 1 then
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	else
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
		--pUnit:Emote(403, 0)
	end
end

RegisterUnitEvent(5449712, 1, "TOA.VAR.RADEN_EVENTS")
RegisterUnitEvent(5449712, 2, "TOA.VAR.RADEN_EVENTS")
RegisterUnitEvent(5449712, 3, "TOA.VAR.RADEN_EVENTS")
RegisterUnitEvent(5449712, 18, "TOA.VAR.RADEN_EVENTS")

function TOA.VAR.CHANNELER_EVENTS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if Event == 18 then
		TOA[id].VAR.RadenAwakened = 0
		TOA[id].VAR.RadenAttempts = 0
		pUnit:ChannelSpell(68834,TOA[id].VAR.TitanCaptured)
		TOA[id].VAR.TitanCaptured:Emote(403,26000)
		pUnit:RegisterEvent("TOA.VAR.KEEPEMOTE_TITAN", 25000, 0)
	elseif Event == 1 then
		pUnit:StopChannel()
		pUnit:SendChatMessage(14, 0, "The power, IT CANNOT BE WIELDED THIS WAY! You tempt forces you do not understand!")
		pUnit:PlaySoundToSet(50025)
	elseif Event == 2 then -- leave
		pUnit:RemoveEvents()
		if pUnit:IsAlive() then
			pUnit:Despawn(1,5000)
			pUnit:RegisterEvent("TOA.VAR.KEEPEMOTE_TITAN", 25000, 0)
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		TOA[id].VAR.RadenAwakened = 1
		TOA[id].VAR.RadenAttempts = 1
		pUnit:SendChatMessage(14, 0, "You... have doomed yourselves... it.. is.. unleashed.")
		pUnit:PlaySoundToSet(50026)
		TOA[id].VAR.TitanCaptured:RegisterEvent("TOA.VAR.RADENINTRO_ONE", 9000, 1)
	end
end

function TOA.VAR.KEEPEMOTE_TITAN(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	TOA[id] = TOA[id] or {VAR={}}
	if not pUnit:IsDead() then
		if TOA[id].VAR.RadenAwakened == 1 then
			TOA[id].VAR.TitanCaptured:Emote(0,26000)
		else
			TOA[id].VAR.TitanCaptured:Emote(403,26000)
		end
	end
end

function TOA.VAR.RADENINTRO_ONE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(14, 0, "For millennia I have waited in darkness, in silence pierced only by the shrieks of the tormented, my dreams a waking nightmare.")
	pUnit:PlaySoundToSet(50017)
	pUnit:Emote(420,14000)
	--pUnit:Emote(420,0)
	pUnit:RegisterEvent("TOA.VAR.RADENINTRO_TWO", 15100, 1)
	pUnit:RegisterEvent("TOA.VAR.RADEINTRO_EMOTEFX", 14000, 1)
end

function TOA.VAR.RADEINTRO_EMOTEFX(pUnit,Event)
	pUnit:Emote(378, 0)
end

function TOA.VAR.RADENINTRO_TWO(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "I see the naive hope in your eyes... You think you are my saviors? Wring that mocking pity from your hearts and focus it inwards, for you shall soon know my agony.")
	pUnit:PlaySoundToSet(50018)
	pUnit:RegisterEvent("TOA.VAR.RADENINTRO_THREE", 24100, 1)
end

function TOA.VAR.RADENINTRO_THREE(pUnit,Event)
	pUnit:MoveTo(2599.01,2489.94,-32.40,3.1)
	pUnit:SendChatMessage(14, 0, "This twisted world is beyond redemption... beyond the reach of deluded heroes. The only answer to corruption... is destruction. And that begins now.")
	pUnit:PlaySoundToSet(50019)
	pUnit:RegisterEvent("TOA.VAR.RADENINTRO_FOURTH", 20100, 1)
end

function TOA.VAR.RADENINTRO_FOURTH(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

RegisterUnitEvent(9981231, 1, "TOA.VAR.CHANNELER_EVENTS")
RegisterUnitEvent(9981231, 2, "TOA.VAR.CHANNELER_EVENTS")
RegisterUnitEvent(9981231, 3, "TOA.VAR.CHANNELER_EVENTS")
RegisterUnitEvent(9981231, 4, "TOA.VAR.CHANNELER_EVENTS")
RegisterUnitEvent(9981231, 18, "TOA.VAR.CHANNELER_EVENTS")


---9981231 CHANNELER
---5449712 ORLANTH

function TOA.VAR.SARONITEROCKSPWN(pMisc)
pMisc:SetScale(5)
end

RegisterGameObjectEvent(196485,2, "TOA.VAR.SARONITEROCKSPWN")