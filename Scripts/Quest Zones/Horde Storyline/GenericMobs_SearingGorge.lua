--[[ Put all your trash mobs here :D ]]--

-- Script variables

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

---------------- Some Captured Guy ------------------

function Some_Undead_Dude_OnSpawn(pUnit, Event)
 pUnit:SetStandState(7)
 pUnit:Root()
end

RegisterUnitEvent(286011, 18, "Some_Undead_Dude_OnSpawn")

---------------- Scarlet Executioner ------------------

function ScarletExecutioner_DE_OnSpawn(pUnit, Event)
	pUnit:EquipWeapons(7717,0,0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 19175 then
			if pUnit:GetDistanceYards(creatures) < 10 then
				creatures:SetByteValue(UNIT_FIELD_BYTES_1, 0, 8)
			end
		end
	end
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 240 then
			players:SendBroadcastMessage("[EoC-Addon]- -3-3-Event-Slay the Scarlet Executioner!")
			pUnit:SendChatMessageToPlayer(14, 0, "The Horde dare test the strength of the Scarlet Order? On this day; in one minute, one of their own shall fall! Gather brothers and sisters and watch as I slay this filth!", players)
		end
	end
	pUnit:RegisterEvent("ScarletExecutioner_FAILEVENT", 60000, 1)
end

function ScarletExecutioner_FAILEVENT(pUnit,Event)
	if pUnit:IsInCombat() == false then
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 19175 then
				if pUnit:GetDistanceYards(creatures) < 10 then
					pUnit:CastSpellOnTarget(30273,creatures)
					pUnit:Despawn(3000,180000)
					creatures:Despawn(5000,120000)
				end
			end
		end
		--[[for _,players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 120 then
				players:SendBroadcastMessage("CHAOTIC:SCENARIO- -3-3-Event Failed-")
			end
		end]]
	else
		pUnit:RegisterEvent("ScarletExecutioner_FAILEVENT", 30000, 1)
	end
end

function ScarletExecutioner_Leave(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("ScarletExecutioner_FAILEVENT", 60000, 1)
end

function ScarletExecutioner_Dead(pUnit,Event)
	pUnit:RemoveEvents()
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 19175 then
			if pUnit:GetDistanceYards(creatures) < 40 then
				creatures:SendChatMessage(12, 0, "Thank you, I will report to Captain Drayzen as soon as I can!")
				creatures:Despawn(5000,120000)
				creatures:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
			end
		end
	end
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 240 then
			players:SendBroadcastMessage("[EoC-Addon]- -3-3-EVENT SUCCEEDED-")
			players:GiveXp(180)
		end
	end
end

RegisterUnitEvent(44991, 18, "ScarletExecutioner_DE_OnSpawn")
RegisterUnitEvent(44991, 2, "ScarletExecutioner_Leave")
RegisterUnitEvent(44991, 4, "ScarletExecutioner_Dead")

-----------------------------------------------------

function ScarletAmbusher_Combat(pUnit,Event)
	pUnit:RegisterEvent("ScarletAmbusher_Net", 1000, 1)
end

function ScarletAmbusher_Net(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 30 then
			pUnit:CastSpellOnTarget(52761,tank)
		end
	end
end

RegisterUnitEvent(86733, 1, "ScarletAmbusher_Combat")
---------------- Some Tree --------------------------

function Some_Tree_that_kills_People(pUnit, Event)
	pUnit:Root()
	pUnit:SpawnCreature(207811, pUnit:GetX()+2, pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 21, 30000)
	pUnit:SpawnCreature(207811, pUnit:GetX(), pUnit:GetY()+2, pUnit:GetZ(), pUnit:GetO(), 21, 30000)
end

function Some_Tree_that_kills_People_Z(pUnit, Event)
	--pUnit:DisableTargeting(true)
	pUnit:SetCombatCapable(true)
	pUnit:Root()
end

RegisterUnitEvent(169771, 1, "Some_Tree_that_kills_People")
RegisterUnitEvent(169771, 18, "Some_Tree_that_kills_People_Z")

function TREE_GOES_ON_WALKZ_lllol(pUnit, Event)
	local zzz = pUnit:GetClosestPlayer()
	if zzz ~= nil then
		pUnit:MoveTo(zzz:GetX(), zzz:GetY(), zzz:GetZ(), 1)
	end
end

RegisterUnitEvent(207811, 18, "TREE_GOES_ON_WALKZ_lllol")

-----------------------------------------------------

---------- Horde Dead Guys --------------------------

function Horde_Cinematic_Dead_Guys_OnSpawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(426010, 18, "Horde_Cinematic_Dead_Guys_OnSpawn")

-----------------------------------------------------

---------- Alli Dead Guys ---------------------------

function zHorde_Cinematic_Dead_Guys_OnSpawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(20556, 18, "zHorde_Cinematic_Dead_Guys_OnSpawn")

-----------------------------------------------------

------- some flying girl ----------------------------

function lol_girl_flies_supergirl_woot(pUnit, Event)
	pUnit:RegisterEvent("lol_girl_flies_supergirl_woot_two_prephase_gone", 500, 1)
end

function lol_girl_flies_supergirl_woot_two_prephase_gone(pUnit, Event)
	pUnit:FullCastSpell(57764)
	pUnit:CastSpell(57764)
end

RegisterUnitEvent(259601, 18, "lol_girl_flies_supergirl_woot")

-----------------------------------------------------

------- Naturist Flora ------------------------------

function headtodeskaugyhaoehea_z(pUnit, Event)
	pUnit:SendChatMessage(12,0, "I shall put you out of your misery, savage animal.")
	pUnit:RegisterEvent("headtodeskaugyhaoehea", 1500, 0)
end

function headtodeskaugyhaoehea(pUnit, Event)
	local plraaaa = pUnit:GetClosestPlayer()
	if plraaaa then
		pUnit:FullCastSpellOnTarget(5176, plraaaa)
	end
end

function headtodeskaugyhaoehea_zz(pUnit, Event)
	pUnit:RemoveEvents()
end

function headtodeskaugyhaoehea_zzz(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(255915, 1, "headtodeskaugyhaoehea_z")
RegisterUnitEvent(255915, 2, "headtodeskaugyhaoehea_zz")
RegisterUnitEvent(255915, 4, "headtodeskaugyhaoehea_zzz")

-----------------------------------------------------

------- rogue test ----------------------------------

function zgzlol_girl_flies_supergirl_woot(pUnit, Event)
	pUnit:RegisterEvent("zgzlol_girl_flies_supergirl_woot_two_prephase_gone", 500, 1)
end

function zgzlol_girl_flies_supergirl_woot_two_prephase_gone(pUnit, Event)
	pUnit:SetMaxPower(100, 2) -- amount is 100, type is 3
	pUnit:SetPowerType(2) -- type is 3
end

RegisterUnitEvent(156155, 18, "zgzlol_girl_flies_supergirl_woot")

-----------------------------------------------------

------- rogue test ----------------------------------

function zgzlol_girl_flies_supergirl_dead(pUnit, Event)
	pUnit:PlaySoundToSet(8454)
end

RegisterUnitEvent(207531, 4, "zgzlol_girl_flies_supergirl_dead")

-----------------------------------------------------

------- Alarm-o-bot  --------------------------------
function roflihavenoaccessbeyondthispointhothefuckknew2(pUnit, Event)
	pUnit:RegisterEvent("ALERTTREEPASSER", 1000, 0)
end

RegisterUnitEvent(426018, 18, "roflihavenoaccessbeyondthispointhothefuckknew2")

function ALERTTREEPASSER(pUnit, Event)
	local player = pUnit:GetClosestPlayer()
	if player ~= nil then
		if player:GetPhase() == 4 then
			if pUnit:GetDistanceYards(player) < 10 then
			player:Teleport(0, -6651, -1310, 208)
			player:CastSpell(64446)
			pUnit:SendChatMessage(14, 0, "Error Code 22: No access beyond this point!")
			end
		elseif player:GetPhase() == 8 then --Redridge Quest 2500
			if pUnit:GetDistanceYards(player) < 5 then
			player:Teleport(0, -9216, -2151, 65)
			player:CastSpell(64446)
			pUnit:SendChatMessageToPlayer(16, 0, "You feel a force teleporting you back.", player)
			end
		end
	end
end

-----------------------------------------------------

---- Blight Bombers ---------------------------------

function ttrzgzlol_girl_flies_supergirl_woot(pUnit, Event)
	pUnit:RegisterEvent("ttrzgzlol_girl_flies_supergirl_woot_two_prephase_gone", 500, 1)
end

function ttrzgzlol_girl_flies_supergirl_woot_two_prephase_gone(pUnit, Event)
	pUnit:SetMaxPower(100, 2)
	pUnit:SetPowerType(2)
end

RegisterUnitEvent(253221, 18, "ttrzgzlol_girl_flies_supergirl_woot")

-----------------------------------------------------

---- Archmage Halendor ---------------------------------

function TheMuhahahahahaMage_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(57014, player, 0)
   if player:HasQuest(2000) == true or player:HasFinishedQuest(2000) == true then
	pUnit:GossipMenuAddItem(0, "Teleport me to The Nether", 249, 0)
   end
   pUnit:GossipMenuAddItem(0, "Nevermind", 241, 0)
   pUnit:GossipSendMenu(player)
end

function TheMuhahahahahaMageSubmenus(pUnit, event, player, id, intid, code)
if(intid == 249) then
  player:CastSpell(64446)
  player:GossipComplete()
  player:Teleport(550, 55, -2, 1)
end
if(intid == 241) then
  player:GossipComplete()
end
end


RegisterUnitGossipEvent(426022, 1, "TheMuhahahahahaMage_Gossip")
RegisterUnitGossipEvent(426022, 2, "TheMuhahahahahaMageSubmenus")

-----------------------------------------------------

---- Outcast - Moonglade ----------------------------

function testijhsropighoshguoz_outcast(pUnit, Event)
	pUnit:RegisterEvent("zztestijhsropighoshguoz_outcast", 2500, 1)
end

function zztestijhsropighoshguoz_outcast(pUnit, Event)
	pUnit:CastSpell(72521)
end

RegisterUnitEvent(305831, 18, "testijhsropighoshguoz_outcast")

-----------------------------------------------------


function HordeRecruit_Defeated(pUnit,Event)
if pUnit:GetHealthPct() < 10 then
pUnit:RemoveEvents()
pUnit:AIDisableCombat(true)
pUnit:SetFaction(2)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:Despawn(4000,2000)
if math.random(1,3) == 1 then
pUnit:SendChatMessage(12,0,"I don't want to go back!")
pUnit:Emote(20,2000)
elseif math.random(1,3) == 2 then
pUnit:SendChatMessage(12,0,"I hope the showers will be private..")
pUnit:Emote(66,2000)
elseif math.random(1,3) == 3 then
pUnit:SendChatMessage(12,0,"This is nuts!")
pUnit:Emote(20,2000)
end
local player = pUnit:GetClosestPlayer()
if player ~= nil then
if pUnit:GetDistanceYards(player) < 10 then
--:GetPrimaryCombatTarget() 
if player:HasQuest(48000) == true then
if (player:GetQuestObjectiveCompletion(48001, 0) ~= 6) then
player:AdvanceQuestObjective(48001, 0)
end
end
end
end
end
end

function HordeRecruit_Spawn(pUnit,Event)
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:SetFaction(7)
pUnit:RegisterEvent("HordeRecruit_Defeated", 2000, 0)
end

RegisterUnitEvent(23720, 18, "HordeRecruit_Spawn")


function Halfus_Events(pUnit,Event)
if Event == 1 then
pUnit:SendChatMessage(12,0,"I will squeeze the life from you!")
		pUnit:PlaySoundToSet(15592)
	pUnit:RegisterEvent("Halfus_Fear", math.random(15000,20000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(12,0,"No, no, nooo!")
end
end

function Halfus_Fear(pUnit)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 30 then
		if players:IsDead() == false then
		pUnit:CastSpellOnTarget(72321,players)
			end
		end
	end
	end
	
	
RegisterUnitEvent(339182, 1, "Halfus_Events")
RegisterUnitEvent(339182, 2, "Halfus_Events")
RegisterUnitEvent(339182, 4, "Halfus_Events")


function Dreadlord_Events(pUnit,Event)
	if Event == 1 then
		pUnit:SendChatMessage(14, 0, "You are defenders of a doomed world. Flee here and perhaps you will prolong your pathetic lives.")
		pUnit:PlaySoundToSet(10977)
		pUnit:StopChannel()
		local AllianceGuy = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 27858)
		local HordeGuy = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 448023)
		if AllianceGuy and HordeGuy then 
			for _,players in pairs(pUnit:GetInRangePlayers()) do
				if pUnit:GetDistanceYards(players) < 30 then
					local race = players:GetPlayerRace() 
					if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
						AllianceGuy:SendChatMessageToPlayer(12, 0, "Ughh..Slay this demonic entity! Do not harm the horde, they are on our side!", players)
					else
						HordeGuy:SendChatMessageToPlayer(12, 0, "Ughh..Slay this demonic entity! Do not harm the alliance, they are on our side!", players)
					end
				end
			end
		end
	elseif Event == 2 then
		pUnit:RemoveEvents()
		local AllianceGuy = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 27858)
		local HordeGuy = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 448023)
		pUnit:ChannelSpell(45104,pUnit)
		if HordeGuy then
			HordeGuy:CastSpell(72523)
			HordeGuy:Emote(473,800000)
		end
		if AllianceGuy then
			AllianceGuy:CastSpell(72523)
			AllianceGuy:Emote(473,800000)
		end
	elseif Event == 18 then
		local AllianceGuy = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 27858)
		local HordeGuy = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 448023)
		pUnit:ChannelSpell(45104,pUnit)
		if HordeGuy and AllianceGuy then
			HordeGuy:CastSpell(72523)
			AllianceGuy:CastSpell(72523)
			HordeGuy:Emote(473,450000)
			AllianceGuy:Emote(473,450000)
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		for _,players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 60 then
				if players:HasQuest(10043) then
					pUnit:SendChatMessageToPlayer(14, 0, "The clock... is still... ticking.",players)
					players:PlaySoundToSet(10982)
					players:MarkQuestObjectiveAsComplete(10043, 0)
					players:GiveXp(3500) -- Temporary hackfix
					local race = players:GetPlayerRace() 
					if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
						if AllianceGuy then
							AllianceGuy:SendChatMessageToPlayer(12, 0, "Good work..go through the portal on the left! We have much to do..", players)
						end
					else
						if HordeGuy then
							HordeGuy:SendChatMessageToPlayer(12, 0, "Good work..go through the portal on the left! We have much to do..", players)
						end
					end
				end
			end
		end
		local AllianceGuy = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 27858)
		local HordeGuy = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 448023)
		if AllianceGuy and HordeGuy then 
			AllianceGuy:Emote(470,40000)
			AllianceGuy:RemoveAura(72523)
			HordeGuy:Emote(470,40000)
			HordeGuy:RemoveAura(72523)
		end
	end
end

RegisterUnitEvent(14506,1,"Dreadlord_Events") 
RegisterUnitEvent(14506,18,"Dreadlord_Events") 
RegisterUnitEvent(14506,2,"Dreadlord_Events") 
RegisterUnitEvent(14506,4,"Dreadlord_Events") 
