
local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local MPlayer = nil
local thorgeneral = nil
local drayzen = nil

--Tank

function nowletsgetsomerealactionehehe(pUnit,event)
	pUnit:SendChatMessage(14, 0, "Defense mode activated!")
end

function alliancesiegetankisdowndefendit(pUnit,event)
	local zDrayzen = pUnit:GetCreatureNearestCoords(-6539.24,-1108.95,309.79, 448023)
	if zDrayzen then
		zDrayzen:SendChatMessage(14, 0, "Ahaha Direct hit! She's going down!")
		zDrayzen:PlaySoundToSet(40000)
	end
end

RegisterUnitEvent(32389, 1, "nowletsgetsomerealactionehehe")
RegisterUnitEvent(32389, 4, "alliancesiegetankisdowndefendit")


function ThoriumGeneral_CombatRegister(pUnit,Event)
	pUnit:RegisterEvent("ThoriumGeneral_Whirlwind", math.random(15000,20500), 0)
	--pUnit:RegisterEvent("ThoriumGeneral_IntimidatingShout", math.random(9200,16200), 0)
	pUnit:RegisterEvent("ThoriumGeneral_hpphase",1000, 0)
end

function ThoriumGeneral_Whirlwind(pUnit,Event)
	pUnit:CastSpell(40653)
end

function ThoriumGeneral_IntimidatingShout(pUnit,Event)
	pUnit:CastSpell(5246)
end

function ThoriumGeneral_hpphase(pUnit,Event)
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(55694)
		pUnit:RegisterEvent("ThoriumGeneral_Whirlwind", 12000, 0)
		--pUnit:RegisterEvent("ThoriumGeneral_IntimidatingShout", math.random(9200,16200), 0)
	end
end

function ThoriumGeneralDies(pUnit,event)
	pUnit:RemoveEvents()
	local Rivet = Drayzen:GetCreatureNearestCoords(Drayzen:GetX(),Drayzen:GetY(),Drayzen:GetZ(), 90028)
	if not Rivet then
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 90028 then
				Rivet = v
				break
			end
		end
	end
	Drayzen:SendChatMessage(12, 0, "Good work friend, speak with Rivet and Kierin while I assess our new surroundings.")
	pUnit:PlaySoundToSet(40007)
	Drayzen:RegisterEvent("DELAYED_PHASE", 6000, 1)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 60 and (players:HasQuest(827)) and (players:IsInPhase(4)) and players:GetQuestObjectiveCompletion(827, 0) == 0 then
			players:MarkQuestObjectiveAsComplete(827, 0)
		end
	end
	Drayzen:Despawn(7500, 30000)
	Rivet:Despawn(7500, 30000)
end

function DELAYED_PHASE(pUnit,Event)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 60 and (players:HasQuest(827)) and (players:IsInPhase(4)) and players:GetQuestObjectiveCompletion(827, 0) == 1 then
			players:SetPhase(1)
		end
	end
end

RegisterUnitEvent(207531, 4, "ThoriumGeneralDies")
RegisterUnitEvent(207531, 1, "ThoriumGeneral_CombatRegister")

---------------

function Drayzen_quest_Spawn(pUnit, Event)
	Drayzen = pUnit
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:SetFaction(2)
	thorgeneral = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 207531)
	if thorgeneral ~= nil then
		if thorgeneral:IsDead() then
			thorgeneral:Despawn(1, 1)
		end
	end
	pUnit:RegisterEvent("Drayzen_zzFINDPLAYERS", 2000, 0)
end

RegisterUnitEvent(448024, 18, "Drayzen_quest_Spawn")

function ThoriumGeneral_SPAWN(pUnit, Event)
	pUnit:SetFaction(1)
	pUnit:SetModel(28560)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	thorgeneral = pUnit
end

RegisterUnitEvent(207531, 18, "ThoriumGeneral_SPAWN")

function Rivet_SPAWN(pUnit, Event)
	pUnit:SetFaction(2)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
end

RegisterUnitEvent(90028, 18, "Rivet_SPAWN")

function Drayzen_zzFINDPLAYERS(pUnit, Event)
	local player = pUnit:GetClosestPlayer()
	if player and pUnit:GetDistanceYards(player) < 7 and (player:HasQuest(827) == true) and (player:IsInPhase(4) == true) and player:GetQuestObjectiveCompletion(827, 0) == 0 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12, 0, "You... you escaped me in Vashjir! You won't be so lucky here.")
		pUnit:PlaySoundToSet(40005)
		pUnit:RegisterEvent("Drayzen_Next_Chapter_z", 6500, 1)
	end
end

function Drayzen_Next_Chapter_z(pUnit, Event)
	if thorgeneral == nil then 
		thorgeneral = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 207531)
		thorgeneral:SendChatMessage(12, 0, "Only three Horde rats left, shouldn't be a problem to finish you off once and for all!")
		thorgeneral:PlaySoundToSet(40009)
		pUnit:RegisterEvent("Drayzen_Next_Chapter_zz", 6500, 1)
	else
		thorgeneral = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 207531)
		thorgeneral:SendChatMessage(12, 0, "Only three Horde rats left, shouldn't be a problem to finish you off once and for all!")
		thorgeneral:PlaySoundToSet(40009)
		pUnit:RegisterEvent("Drayzen_Next_Chapter_zz", 6500, 1)
	end
end

function Drayzen_Next_Chapter_zz(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "My axe will soon feast upon your blood, human!")
	pUnit:PlaySoundToSet(40003)
	pUnit:RegisterEvent("Drayzen_Next_Chapter_zzz", 5500, 1)
end

function Drayzen_Next_Chapter_zzz(pUnit, Event)
	if thorgeneral == nil then 
		thorgeneral = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 207531)
		thorgeneral:SendChatMessage(12,0,"How many innocents have died at your hand orc? Your Horde has no honor!")
		thorgeneral:PlaySoundToSet(40008)
		pUnit:RegisterEvent("Drayzen_Next_Chapter_x", 7500, 1)
	else
		thorgeneral:SendChatMessage(12,0,"How many innocents have died at your hand orc? Your Horde has no honor!")
		thorgeneral:PlaySoundToSet(40008)
		pUnit:RegisterEvent("Drayzen_Next_Chapter_x", 7500, 1)
	end
end

function Drayzen_Next_Chapter_x(pUnit, Event)
	if thorgeneral == nil then 
		thorgeneral = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 207531)
		thorgeneral:SendChatMessage(12,0,"Look at the peaceful, kind people of this land! They were born to belong to the Alliance!")
		thorgeneral:PlaySoundToSet(40010)
		pUnit:RegisterEvent("Drayzen_Next_Chapter_xx", 7200, 1)
	else
		thorgeneral:SendChatMessage(12,0,"Look at the peaceful, kind people of this land! They were born to belong to the Alliance!")
		thorgeneral:PlaySoundToSet(40010)
		pUnit:RegisterEvent("Drayzen_Next_Chapter_xx", 7200, 1)
	end
end

function Drayzen_Next_Chapter_xx(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Soon you and your... Alliance will only be found in Azeroth's history books.")
	pUnit:PlaySoundToSet(40002)
	pUnit:RegisterEvent("Drayzen_Next_Chapter_a", 8500, 1)
end

function Drayzen_Next_Chapter_a(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Your kind shall never build a foothold here, no. This is destined to be Horde land!")
	pUnit:PlaySoundToSet(40004)
	pUnit:RegisterEvent("Drayzen_Next_Chapter_b", 8500, 1)
end

function Drayzen_Next_Chapter_b(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "I hope you have the courage to die bravely human. I'm in the mood for a good fight!")
	pUnit:PlaySoundToSet(40006)
	pUnit:RegisterEvent("Drayzen_Next_Chapter_y", 8200, 1)
end

function Drayzen_Next_Chapter_y(pUnit,Event)
	if thorgeneral == nil then 
		thorgeneral = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 207531)
		thorgeneral:SendChatMessage(12,0,"These people shall not be enslaved by your cruel Horde. I will not allow it!")
		thorgeneral:PlaySoundToSet(40011)
		thorgeneral:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	else
		thorgeneral:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		thorgeneral:SendChatMessage(12,0,"These people shall not be enslaved by your cruel Horde. I will not allow it!")
		thorgeneral:PlaySoundToSet(40011)
	end
	local Rivet = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 90028)
	Rivet:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

