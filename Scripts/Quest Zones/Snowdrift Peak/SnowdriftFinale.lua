local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local Sonya = nil
local Sonyaz = nil
local Skadi = nil
local Sha = nil
local playermess = nil
local trig = 0
local evFinale = 0
local shafinale = 0
local trig2 = 0

function Sonya_OnSpawn(pUnit,Event)
	Sonya = pUnit
end

RegisterUnitEvent(322430, 18, "Sonya_OnSpawn")

function Sonyaz_OnSpawn(pUnit,Event)
	Sonyaz = pUnit
end

RegisterUnitEvent(322428, 18, "Sonyaz_OnSpawn")

function Quest_Snowdrift(event, pPlayer, questId, pQuestGiver)
	if questId == 900010 then
		if trig == 0 then
			trig = 1
			Sonya:SetNPCFlags(8)
	Sonya:SendChatMessage(12,0,"This fight will take everything we have, I hope you are ready.")
	Sonya:PlaySoundToSet(50112)
	Sonya:Emote(1,4100)
			Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 4100, 1)
		end
			elseif questId == 900009 then
			Sonyaz:SetNPCFlags(8)
			Sonyaz:SendChatMessage(16,0,"Sonya Headhunter brittles in rage, in response to the news.")
			Sonyaz:Emote(35,2100)
			Sonyaz:RegisterEvent("Sonyaz_ContinueRant", 2100, 1)
	end
end

function Sonyaz_ContinueRant(pUnit)
	Sonyaz:SendChatMessage(12,0,"They have undermined every attempt at peace in Snowdrift Peaks!")
	Sonyaz:PlaySoundToSet(50117)
	Sonyaz:Emote(388,800)
	Sonyaz:RegisterEvent("Sonyaz_ContinueRantx", 4100, 1)
end

function Sonyaz_ContinueRantx(pUnit)
	Sonyaz:SendChatMessage(16,0,"Sonya begins calm down.")
	Sonyaz:RegisterEvent("Sonyaz_ContinueRantz", 6100, 1)
end

function Sonyaz_ContinueRantz(pUnit)
Sonyaz:SetNPCFlags(2)
	Sonyaz:SendChatMessage(12,0,"Speak to me at the lake when you are ready to launch the assault.")
	Sonyaz:PlaySoundToSet(50113)
end


function FINALEEVENTS_SNOWDRIFT(pUnit,Event)
evFinale = evFinale + 1
if evFinale == 1 then
	Sonya:SendChatMessage(12,0,"Everyone, Advance!")
	Sonya:PlaySoundToSet(50114)
	Sonya:SetMovementFlags(1)
	Sonya:AIDisableCombat(true)
	Sonya:SetMount(50147)
			Sonya:SpawnCreature(27105,5668.66,-3396.54,1588.62, 3.74, 14, 0)
			for place,creatures in pairs(Sonya:GetInRangeUnits()) do 
		if creatures:GetEntry() == 322431 or creatures:GetEntry() == 322432 then 
		if Sonya:GetDistanceYards(creatures) < 10 then
		creatures:MoveTo(5641.27+math.random(1,15),-3439.68+math.random(1,15),1586.27)
		creatures:AIDisableCombat(true)
		creatures:SetMovementFlags(1)
		creatures:SetMount(50147)
		end
			end
		end
			Sonya:MoveTo(5641.27,-3439.68,1586.27)
			Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 3000, 1)
elseif evFinale == 2 then
Sonya:SendChatMessage(12,0,"And if anyone sees that traitor, Aethas Sunreaver. Save that one for me.")
Sonya:PlaySoundToSet(50115)
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 and players:HasQuest(900010) then
	players:PlayMusicToPlayer(50004)
	players:SetPhase(2)
	end
		end
		Sonya:SetPhase(2)
		for place,creatures in pairs(Sonya:GetInRangeUnits()) do
			if creatures:GetEntry() == 322431 or creatures:GetEntry() == 322432 then 
		if Sonya:GetDistanceYards(creatures) < 10 then
		creatures:SetMovementFlags(1)
		creatures:SetPhase(2)
		end
			end
		end
Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 12000, 1)
elseif evFinale == 3 then
Sonya:AIDisableCombat(false)
		Skadi:SendChatMessage(14,0,"What mongrels dare intrude here? Look alive, my brothers! A feast for the one that brings me their heads!")
		Skadi:PlaySoundToSet(13497)
		Skadi:Emote(22,1000)
	Sonya:SpawnCreature(26690,5635.30, -3442.61, 1585.35, math.random(0,6), 14, 85000)
	Sonya:SpawnCreature(26690,5652.62, -3449.75, 1585.92, math.random(0,6), 14, 85000)
	Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 18000, 1)
	for place,creatures in pairs(Sonya:GetInRangeUnits()) do
			if creatures:GetEntry() == 322431 or creatures:GetEntry() == 322432 then 
		if Sonya:GetDistanceYards(creatures) < 7 then
	creatures:AIDisableCombat(false)
	end
		end
	end
elseif evFinale == 4 then
Sonya:SendChatMessage(12,0,"They're trying to flank us, hold this position!")
Sonya:PlaySoundToSet(50116)
Sonya:SpawnCreature(26690,5635.30, -3442.61, 1585.35, math.random(0,6), 14, 85000)
	Sonya:SpawnCreature(26690,5652.62, -3449.75, 1585.92, math.random(0,6), 14, 85000)
	Sonya:SpawnCreature(26690,5636.59, -3467.34, 1585.19, math.random(0,6), 14, 85000)
	Sonya:SpawnCreature(26690,1583.25, -3457.30, 1583.25, math.random(0,6), 14, 85000)
	for place,creatures in pairs(Sonya:GetInRangeUnits()) do
			if creatures:GetEntry() == 322431 or creatures:GetEntry() == 322432 then 
		if Sonya:GetDistanceYards(creatures) < 7 then
	creatures:AIDisableCombat(false)
	end
		end
	end
	Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 24000, 1)
elseif evFinale == 5 then
Sonya:SpawnCreature(26690,5635.30, -3442.61, 1585.35, math.random(0,6), 14, 85000)
	Sonya:SpawnCreature(26690,1583.25, -3457.30, 1583.25, math.random(0,6), 14, 85000)
	Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 18000, 1)
	elseif evFinale == 6 then
	Sonya:SendChatMessage(12,0,"Everyone, Advance!")
	Sonya:AIDisableCombat(true)
	Sonya:PlaySoundToSet(50114)
				for place,creatures in pairs(Sonya:GetInRangeUnits()) do 
		if creatures:GetEntry() == 322431 or creatures:GetEntry() == 322432 then 
		if Sonya:GetDistanceYards(creatures) < 20 then
		creatures:MoveTo(5657.26+math.random(1,15),-3407.32+math.random(1,15),1586.82)
		creatures:AIDisableCombat(true)
		end
			end
		end
			Sonya:MoveTo(5657.26,-3407.32,1586.82)
			Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 3000, 1)
	elseif evFinale == 7 then
	Skadi:SendChatMessage(14,0,"I ask for friggle to kill them yet all I get are feeble whelps, by Ymirion. SLAUGHTER THEM!")
		Skadi:PlaySoundToSet(13501)
		Skadi:Emote(1,9000)
	Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 9000, 1)
	elseif evFinale == 8 then
	Skadi:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		Sonya:AIDisableCombat(false)
						local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	players:PlayMusicToPlayer(50006)
	end
		end
					for place,creatures in pairs(Sonya:GetInRangeUnits()) do 
		if creatures:GetEntry() == 322431 or creatures:GetEntry() == 322432 then 
		if Sonya:GetDistanceYards(creatures) < 20 then
		creatures:AIDisableCombat(false)
		end
			end
		end
elseif evFinale == 9 then
	Sonya:SendChatMessage(12,0,"Everyone, regroup back at the camp our work here is done!")
	Sonya:PlaySoundToSet(50118)
	Sonya:SetPhase(3)
				local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 40 and players:HasQuest(900010) then
			players:MarkQuestObjectiveAsComplete(900010,0)
				players:SetPhase(1)
	end
		end
		Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 4100, 1)
elseif evFinale == 10 then
trig = 0
evFinale = 0
shafinale = 0
trig2 = 0
Sonya:Despawn(2000,4000)
Sonya:SetNPCFlags(2)
Sonya:AIDisableCombat(false)
		for place,creatures in pairs(Sonya:GetInRangeUnits()) do 
		if creatures:GetEntry() == 322432 then 
		if Sonya:GetDistanceYards(creatures) < 70 then
		creatures:Despawn(1000,5000)
		creatures:SetPhase(3)
		end
			end
		end
		for place,creatures in pairs(Sonya:GetInRangeUnits()) do 
		if creatures:GetEntry() == 322431 then 
		if Sonya:GetDistanceYards(creatures) < 20 then
		creatures:Despawn(1000,5000)
		end
			end
		end
end
	end


RegisterServerHook(14, "Quest_Snowdrift")


function Ymjir_Overlord_Events(pUnit,Event)
if Event == 18 then
pUnit:EquipWeapons(22798,0,0)
pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
if pUnit:GetEntry() == 27105 then
Skadi = pUnit
Skadi:SetPhase(2)
Skadi:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
elseif pUnit:GetEntry() == 26690 then
pUnit:CastSpell(57551)
pUnit:SetScale(.75)
pUnit:SetModel(26623)
end
elseif Event == 1 then
	pUnit:SendChatMessage(14,0,"I'll mount your skull from the highest tower!")
		pUnit:PlaySoundToSet(13505)
		pUnit:RegisterEvent("Skadi_Whirlwind", math.random(15000,20500), 0)
						local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 and players:HasQuest(900010) then
	players:PlayMusicToPlayer(50005)
	end
		end
elseif Event == 4 then
pUnit:RemoveEvents()
trig2 = 1 
Sonya:AIDisableCombat(true)
	--pUnit:SendChatMessage(14,0,"ARGH! You call that... an attack? I'll... show... aghhhh...")
		--pUnit:PlaySoundToSet(13506)
end
	end
	
	RegisterUnitEvent(27105, 18, "Ymjir_Overlord_Events")
	RegisterUnitEvent(27105, 1, "Ymjir_Overlord_Events")
	RegisterUnitEvent(27105, 4, "Ymjir_Overlord_Events")
	
	RegisterUnitEvent(26690, 18, "Ymjir_Overlord_Events")
	
	
	function Ymjir_Warrior(pUnit,Event)
	if Event == 1 then
	if math.random(1,2) <= 1 then
	pUnit:RegisterEvent("Ymjir_ShaTransform", 1000, 0)
	end
	elseif Event == 2 then
	pUnit:RemoveEvents()
	elseif Event == 4 then
	pUnit:RemoveEvents()
		end
	end
	
	function Ymjir_ShaTransform(pUnit)
	if pUnit:GetHealthPct() < 50 then
	pUnit:RemoveEvents()
	pUnit:CastSpell(62003)
	pUnit:SetScale(1.35)
	pUnit:SetModel(40059)
	pUnit:EquipWeapons(0,0,0)
		end
	end
	
		RegisterUnitEvent(26690, 1, "Ymjir_Warrior")
		RegisterUnitEvent(26690, 2, "Ymjir_Warrior")
		RegisterUnitEvent(26690, 4, "Ymjir_Warrior")
	
	function Skadi_Whirlwind(pUnit,Event)
	pUnit:CastSpell(40653)
end

	
	function ShaofHatesnowdriftEvent(pUnit,Event)
	pUnit:SetPhase(2)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 9)
pUnit:RegisterEvent("ShaofHatesnowdrift_Talkingone", 1000, 0)
	end
	
	
	function ShaofHatesnowdrift_Talkingone(pUnit,Event)
	if trig2 == 1 then
	pUnit:RemoveEvents()
	shafinale = shafinale + 1
if shafinale == 1 then
		pUnit:SendChatMessage(14,0,"What is this? a trap!?")
pUnit:PlaySoundToSet(18171)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
pUnit:RegisterEvent("ShaofHatesnowdrift_Talkingone", 6100, 1)
elseif shafinale == 2 then
		pUnit:SendChatMessage(14,0,"You pitiful weaklings!")
pUnit:PlaySoundToSet(18180)
pUnit:RegisterEvent("ShaofHatesnowdrift_Talkingone", 8100, 1)
elseif shafinale == 3 then
		pUnit:SendChatMessage(14,0,"Even your strongest warriors, succumb like lambs to the slaughter!")
pUnit:PlaySoundToSet(18181)
pUnit:RegisterEvent("ShaofHatesnowdrift_Talkingone", 9100, 1)
elseif shafinale == 4 then
		pUnit:SendChatMessage(14,0,"Your turn will come, hate will turn you all against one another until this world burns!")
pUnit:PlaySoundToSet(18182)
pUnit:RegisterEvent("ShaofHatesnowdrift_Talkingone", 13000, 1)
elseif shafinale == 5 then
pUnit:PlaySoundToSet(18176)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 9)
pUnit:Despawn(2100,6000)
Sonya:RegisterEvent("FINALEEVENTS_SNOWDRIFT", 2000, 1)
end
end
	end
	
	
		RegisterUnitEvent(927012, 18, "ShaofHatesnowdriftEvent")
		
		function SonyaEvents(pUnit,Event)
		if Event == 1 then
		pUnit:RegisterEvent("huntermarksnowdrift", 1000, 1)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 2)
		end
			end
			
			RegisterUnitEvent(322430, 1, "SonyaEvents")

function huntermarksnowdrift(pUnit)
local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(53338,tank)
		end
end			
			function SonyaHunters_Ev(pUnit,Event)
			if Event == 1 then
			pUnit:RegisterEvent("Huntertaunt", 1000, 1)
			end
			end
			
			function Huntertaunt(pUnit)
			local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(70428,tank)
		end
			end
			
			RegisterUnitEvent(322432, 1, "SonyaHunters_Ev")