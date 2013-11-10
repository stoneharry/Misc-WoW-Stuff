--[[

Quest Name: Learning From the Past
Quest ID: 2500
Quest Starter: 310512
Quest Finisher: 77112

Made by Tikki

External Scripts: GenericMobs_SearingGorge.lua  Line 162-168
]]--

--Variables

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


local Q2500InUse = false
local DEBUGA = nil
local Luke = nil
local Jane = nil
local Thomas = nil
local Jessica = nil
local i = 0
local TIKKI_DEBUG = "#resetvar"
local TIKKI_START = "#startvar"
local pPlayer = nil
local BLACK_HOLE_A = nil
local BLACK_HOLE_B = nil
local BLACK_HOLE_C = nil
local BHA = 1 -- Short for Black Hole A. Used for the range of which to detect players.
local BHAY = 1.25
local BHB = 1 -- B
local BHBY = 1.25
local BHC = 1 -- C
local BHCY = 1.25
local c = nil
local DEBUG = false
plrsca = {}
plrsca.VAR = {}

-----------------------------------------------------
-----------------Stonewatch Falls--------------------
-----------------------------------------------------

function JessicaSOnGossip(pUnit, Event, player)
	pUnit:GossipCreateMenu(3630, player, 0)
	if player:HasQuest(2500) then
		pUnit:GossipMenuAddItem(4, "Take the ghost's hand.", 251, 0)
	end
	if player:HasQuest(3030) or player:HasQuest(3029) or player:HasQuest(3028) == true then
	pUnit:GossipMenuAddItem(4, "Send me back to the past.", 253, 0)
	end
	pUnit:GossipMenuAddItem(0, "I cannot help.", 252, 0)
    pUnit:GossipSendMenu(player)
end


function JessicaSOnSelect(pUnit, event, player, id, intid, code)
	if(intid == 251) then
		if Q2500InUse == false then
			player:GossipComplete()
			player:FullCastSpell(68085) --Mist Visual
			player:SetPhase(8) --The 8 of the quest.
			player:Teleport(0, -9216, -2151, 65) --Lakeshire Inn
		else
			player:GossipComplete()
			player:SendAreaTriggerMessage("|cFFFF0000This is currently in use. Please wait.")
		end
	elseif (intid == 253) then
		player:FullCastSpell(68085) 
		player:SetPhase(4) 
		player:Teleport(0, -9216, -2151, 65) 
		player:GossipComplete()
	elseif (intid == 252) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(77119, 1, "JessicaSOnGossip")
RegisterUnitGossipEvent(77119, 2, "JessicaSOnSelect")

-----------------------------------------------------
------------------Lakeshire Inn----------------------
-----------------------------------------------------

--Event Starter.

function JessicaSOnSpawn(pUnit, Event)
	pUnit:SetNPCFlags(3)
	DEBUGA = pUnit
	if (DEBUG) then print("Debug turned on for script TIK_Q2500_Start.lua") end
	pUnit:RegisterEvent("Are_we_ready", 5000, 0) --Checks every 5 seconds, to see wheter or not we are ready to start the event.
end


function JessicaOnGossip(pUnit, Event, player)
	pUnit:GossipCreateMenu(3630, player, 0)
	--if player:HasQuest(2500) == true then --Not needed, derp :3 
	pUnit:GossipMenuAddItem(0, "I'm ready.", 251, 0)
	pUnit:GossipMenuAddItem(0, "Please send me back.", 256, 0)
	pUnit:GossipSendMenu(player)
end

function JessicaOnSelect(pUnit, event, player, id, intid, code)
	if(intid == 251) then
		player:GossipComplete()
		Q2500InUse = true --The variable is set to "In use" to prevent other players from teleporting in.
		pUnit:SendChatMessage(12,0,"Very well then. Watch as the spirits take us back to their time...")
		pUnit:SetNPCFlags(2) --Disables gossip.
		pPlayer = player
	elseif(initid == 256) then
		if player:HasAura(68085) then
			player:RemoveAura(68085)
		end
		player:GossipComplete()
		player:SetPhase(1)
		player:Teleport(0, -9387.29, -3035.95, 139.43)
	end
end

RegisterUnitGossipEvent(310513, 1, "JessicaOnGossip")
RegisterUnitGossipEvent(310513, 2, "JessicaOnSelect")
RegisterUnitEvent(310513, 18, "JessicaSOnSpawn")

--Are we ready?
function Are_we_ready(pUnit, Event)
	if Q2500InUse ==  true then
		pUnit:RemoveEvents() --Prevents us from getting spammed.
		pUnit:RegisterEvent("SETUP_Spawn",1000,1) --Spawns the NPC's
		pUnit:RegisterEvent("Make_Them_Move_A",2000,1) --Make them move and talk.
	end
end

---------------------------------
------------[[SETUP]]------------
---------------------------------

--The four city council members.

function Jane_OnSpawn(pUnit, Event)
	pUnit:RegisterEvent("GhostEffect",1000,1)
end

function Luke_Talbot_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("GhostEffect",1100,1)
end

--function Alternative_Jessica_OnSpawn(pUnit,Event)
	--pUnit:RegisterEvent("GhostEffect",1200,1) --Not needed, since the model is allready transparent.
--end

function Thomas_Chamberlayn_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("GhostEffect",1200,1)
end

function GhostEffect(pUnit,Event)
	pUnit:FullCastSpell(44816) --Adds a nice ghost visual.
end
RegisterUnitEvent(310514, 18, "Jane_OnSpawn")
--RegisterUnitEvent(77111, 18, "Jane_OnSpawn")--Disabled until further notice.
RegisterUnitEvent(310515, 18, "Luke_Talbot_OnSpawn")
--RegisterUnitEvent(310516, 18, "Alternative_Jessica_OnSpawn")
RegisterUnitEvent(310517, 18, "Thomas_Chamberlayn_OnSpawn")

--Making them appear magicly.

function SETUP_Spawn(pUnit,Event)
	Jane = pUnit:SpawnCreature(310514, -9236.85, -2152.89, 64.36, 4.725575, 35, 0, 0, 0, 0, 8, 0)  --Jane
	Luke = pUnit:SpawnCreature(310515, -9238.85, -2152.89, 64.36, 4.725575, 35, 0, 0, 0, 0, 8, 0)  --Luke
	Jessica = pUnit:SpawnCreature(310516, -9236.85, -2150.89, 64.36, 4.725575, 35, 0, 0, 0, 0, 8, 0)  --Jessica
	Thomas = pUnit:SpawnCreature(310517, -9238.85, -2150.89, 64.36, 4.725575, 35, 0, 0, 0, 0, 8, 0)  --Thomas
end

---------------------------------
---------The Event START---------
---------------------------------

--[[
Jane
Luke
Thomas
Jessica]]--

function Make_Them_Move_A(pUnit, Event)
	--pUnit:MoveTo(X, Y, Z, O)
	Jane:MoveTo(-9236,-2156,64.357895,0)
	Jane:SendChatMessage(12,0,"This is ridiculous; you blame anyone you see of being a demon!")
	Luke:MoveTo(-9237,-2160,64.357910,0)
	Jessica:MoveTo(-9237,-2157,64.357513,0)
	Thomas:MoveTo(-9237,-2156,64.357910,0)
	pUnit:RegisterEvent("Handle_Creature_Interaction", 2500, 1)
end

function Handle_Creature_Interaction(pUnit)
	if i == 0 then
		Thomas:MoveTo(-9227,-2155,63.731266,0)
		pUnit:RegisterEvent("Handle_Creature_Interaction", 200, 1)
	elseif i == 1 then
		Jessica:MoveTo(-9232,-2155,64.357903,0)
		pUnit:RegisterEvent("Handle_Creature_Interaction", 2800, 1)
	elseif i == 2 then
		Jessica:MoveTo(-9227.434,-2156.397,63.630713,0)
		pUnit:RegisterEvent("Handle_Creature_Interaction", 100, 1)
	elseif i == 3 then
		Luke:MoveTo(-9232.727539,-2159.225098,64.357483,0)
		Luke:SendChatMessage(12,0,"We do not. Those people were taken in the act of practising black magic - you know this.")
		pUnit:RegisterEvent("Handle_Creature_Interaction", 200, 1)
	elseif i == 4 then
		Thomas:MoveTo(-9222.723,-2151.226,63.730713,0)
		pUnit:RegisterEvent("Handle_Creature_Interaction", 5600, 1)
	elseif i == 5 then
		Jane:MoveTo(-9233.704,-2158.42,64.358093,0)
		Jane:SendChatMessage(12,0,"You know just as well as I that those accusations were based upon rumors!")
		Jessica:SetFacing(3.662716)
		pUnit:RegisterEvent("Handle_Creature_Interaction", 300, 1)
	elseif i == 6 then
		Thomas:MoveTo(-9222.601,-2149.5,63.740713,0)
		pUnit:RegisterEvent("Handle_Creature_Interaction", 4900, 1)
	elseif i == 7 then
		Luke:SendChatMessage(12,0,"What should I have done then? It is times like these where we must remain strong!")
		pUnit:RegisterEvent("Handle_Creature_Interaction", 300, 1)
	elseif i == 8 then
		Thomas:SendChatMessage(12,0,"Oh...")
		pUnit:RegisterEvent("Handle_Creature_Interaction", 4900, 1)
	elseif i == 9 then
		Jessica:MoveTo(-9229.677,-2158.061,63.731255,0)
		Jessica:SendChatMessage(12,0,"No. You're wrong. It is times like these where we provide guidance and not raid innocent folk!")
		pUnit:RegisterEvent("Handle_Creature_Interaction", 6000, 1)
	elseif i == 10 then
		Thomas:SendChatMessage(12,0,"Beautiful... flames.")
		pUnit:RegisterEvent("Handle_Creature_Interaction",800,1)
	elseif i == 11 then
		Jane:SendChatMessage(16,0,"Jane sends Thomas a worried look.")
		pUnit:RegisterEvent("Handle_Creature_Interaction",2000,1)
	elseif i == 12 then
		Jane:SendChatMessage(12,0,"Thomas, are you all right?")
		Jane:MoveTo(-9232.208,-2154.953,64.357948,0)
		pUnit:RegisterEvent("Handle_Creature_Interaction",2000,1)
	elseif i == 13 then
		Jane:SetFacing(0.777151)
		pUnit:RegisterEvent("Handle_Creature_Interaction",700,1)
	elseif i == 14 then
		Jessica:MoveTo(-9222.80,-2150.17,63.73085)
		Jessica:SendChatMessage(12,0,"Thomas?")
		pUnit:RegisterEvent("Handle_Creature_Interaction",2900,1)
	elseif i == 15 then
		Jane:SendChatMessage(12,0,"Stop Jessica, stay away from him!")
		Luke:MoveTo(-9232.284,-2156.559,64.37941,0)
		pUnit:RegisterEvent("Handle_Creature_Interaction",100,1)
	elseif i == 16 then
		Thomas:CastSpellOnTarget(67888, Jessica)
		Jessica:SetHealthPct(1)
		Jessica:SendChatMessage(14,0,"UGH-")
		Jessica:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Jessica:SetScale(0.01)
		Jessica:Despawn(1000, 0)
		Jessica:CastSpell(11)
		
		Thomas:FullCastSpell(46223)
		Luke:SetFacing(0.596509)
		pUnit:RegisterEvent("Handle_Creature_Interaction",100,1)
	elseif i == 17 then
		Thomas:RemoveAura(46223)
		Thomas:SetScale(0.7)
		Thomas:SetModel(15298)
		Thomas:EquipWeapons(42943,0,0) 
		Thomas:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
		Thomas:SetFaction(21)
		Thomas:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
		pUnit:RegisterEvent("Handle_Creature_Interaction",400,1)
	elseif i == 18 then
		Luke:SendChatMessage(14,0,"JESSICA!")
		Thomas:SetFacing(4.225988)
		Luke:SetMovementFlags(1)
		Luke:MoveTo(-9223.98,-2152.68,63.73,0)
		pUnit:RegisterEvent("Handle_Creature_Interaction",1800,1)
	elseif i == 19 then
		Luke:SendChatMessage(12,0,"You.. you.. monster!")
		Luke:Emote(16, 2900)
		pUnit:RegisterEvent("Handle_Creature_Interaction",3000,1)
	elseif i == 20 then
		Jane:SendChatMessage(12,0,"Get back here, you idiot!")
		Luke:Emote(27, 30000)
		pUnit:RegisterEvent("Handle_Creature_Interaction",2600,1)
	elseif i == 21 then
		Luke:SendChatMessage(12,0,"No! That abberation just killed Jessica!")
		Thomas:SendChatMessage(16,0,"Thomas the Devourer laughs at Luke.")
		pUnit:RegisterEvent("Handle_Creature_Interaction",3900,1)
	elseif i == 22 then
		Thomas:Emote(25, 3000)
		Thomas:SendChatMessage(14,0,"Your life belongs to me now.")
		pUnit:RegisterEvent("Handle_Creature_Interaction",3000,1)
	elseif i == 23 then
		Thomas:CastSpellOnTarget(67888, Luke)
		Luke:SetHealthPct(1)
		Luke:SendChatMessage(14,0,"AGH-")
		Luke:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Luke:SetScale(0.01)
		Luke:Despawn(1000, 0)
		Luke:CastSpell(11)

		pUnit:RegisterEvent("Handle_Creature_Interaction",700,1)
	elseif i == 24 then
		Jane:SendChatMessage(12,0,"No!")
		pUnit:RegisterEvent("Handle_Creature_Interaction",2900,1)
	elseif i == 25 then
		Jane:SendChatMessage(16,0,"Jane mumbles some words - a shield appears around her.")
		Jane:FullCastSpell(31635) --Mana Shield Visual
		pUnit:RegisterEvent("Handle_Creature_Interaction",3400,1)
	elseif i == 26 then
		Thomas:SendChatMessage(12,0,"And now it is your turn, mage.")
		Thomas:SetFacing(3.700795)
		Thomas:SendChatMessage(16,0,"Thomas lets out a laugh.")
		pUnit:RegisterEvent("Handle_Creature_Interaction",5000,1)
	elseif i == 27 then
		Jane:SendChatMessage(12,0,"Think again, demon!")
		pUnit:RegisterEvent("Handle_Creature_Interaction",2700,1)
	elseif i == 28 then
		Jane:SendChatMessage(16,0,"Jane begins to summon someone. You can't quite make out what she's saying.")
		Jane:FullCastSpell(54219)
		pUnit:RegisterEvent("Handle_Creature_Interaction",400,1)
	elseif i == 29 then
		Thomas:SendChatMessage(16,0,"Thomas releases a big laugh, clearly amused.")
		pUnit:RegisterEvent("Handle_Creature_Interaction",5600,1)
	elseif i == 30 then
		Thomas:SendChatMessage(12,0,"And who exactly do you think can help you?")
		pUnit:RegisterEvent("Handle_Creature_Interaction",6200,1)
	elseif i == 31 then
		Jane:SendChatMessage(16,0,"You begin to feel something pulling you...")
		Jane:SendChatMessage(12,0,"A hero...")
		pUnit:RegisterEvent("Handle_Creature_Interaction",3900,1)
	elseif i == 32 then
		Jane:SendChatMessage(16,0,"You get teleported over to Jane. Past has suddenly turned into reality!")
		Thomas:RemoveAura(44816)
		Jane:RemoveAura(44816)
		Jane:RemoveAura(54219)
		pPlayer:RemoveAura(68085)
		pPlayer:Teleport(0,-9232.774,-2153.031,64.358017)
		pPlayer:FullCastSpell(41232)
		pUnit:RegisterEvent("Handle_Creature_Interaction",2100,1)
	elseif i == 32 then
		pPlayer:PlayerSendChatMessage(1, 0, "Huh!? Wait... What?")
		pUnit:RegisterEvent("Handle_Creature_Interaction",2700,1)
	elseif i == 33 then
		Jane:Emote(27, 90000)
		Jane:SendChatMessage(12,0,"Sorry! We do not have a lot of time. Summary: demon trying to-")
		pUnit:RegisterEvent("Handle_Creature_Interaction",3300,1)
	elseif i == 34 then
		pPlayer:PlayerSendChatMessage(1, 0, "-Kill us?")
		pUnit:RegisterEvent("Handle_Creature_Interaction",2300,1)
	elseif i == 35 then
		Jane:SendChatMessage(12,0,"How did you?")
		pUnit:RegisterEvent("Handle_Creature_Interaction",2700,1)
	elseif i == 36 then
		Thomas:SendChatMessage(14,0,"Enough talk!")
		pUnit:RegisterEvent("Handle_Creature_Interaction",3700,1)
	elseif i == 37 then
		pUnit:RegisterEvent("Handle_Creature_Interaction",1200,1)
	elseif i == 38 then
		Jane:SendChatMessage(12,0,"Hero, defend me from this abomination while I prepare a spell!")
		pUnit:RegisterEvent("Handle_Creature_Interaction",2000,1)
	elseif i == 39 then
		i = 0
		if (DEBUG) then print("Setting i to 0, for the next part.") end
		pUnit:SendChatMessage(42,0,"Defend Jane, and do not let her die!")
		Jane:FullCastSpell(54219)
		Thomas:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		pUnit:RegisterEvent("Jane_SuperNovaKill_Interaction",80000,1)
	end
	if (DEBUG) then print(i) end
	i = i + 1
end

---------------------------------
---------The Event FIGHT---------
---------------------------------

function Thomas_OnLeave(pUnit, Event) --Fail safe. If he leaves combat, the event resets itself.
	if Thomas:IsAlive() then --So it doesn't activate on his death :P
		Jane:SetHealthPct(1) --Set the hp to one
		Jane:CastSpell(11) --And finish herself off
		pUnit:SendChatMessage(42,0,"You feel time unwind.")
		ResetVar()
	else
		pUnit:RemoveEvents()
		DEBUGA:RegisterEvent("Jane_SuperNovaKill_Interaction",1000,1)
	end
end


function Jane_OnDead(pUnit,Event)
	pUnit:SendChatMessage(12,0,"All... is lost.")
	pUnit:Despawn(1000,0)
	Jane = nil
end

function Thomas_OnCombat(pUnit,Event)
	pUnit:RegisterEvent("Check_5_Hp",3000,0)
	pUnit:SendChatMessage(14,0,"I shall flay you apart!")
	c = 1 --To the black holes.
	pUnit:RegisterEvent("Random_Black_Holes", 7500,3) --After 10 seconds, black holes appears, trying to kill you.
end

	
RegisterUnitEvent(310517, 1, "Thomas_OnCombat")
RegisterUnitEvent(310517, 2, "Thomas_OnLeave")
RegisterUnitEvent(310517, 4, "Thomas_OnLeave")
RegisterUnitEvent(310514, 4, "Jane_OnDead")

function Check_5_Hp(pUnit,Event) --If a player manages to knock him down to 5 0hp before jane cast her super nova, it activates.
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		DEBUGA:RegisterEvent("Jane_SuperNovaKill_Interaction",1000,1)
	end
end

function Random_Black_Holes(pUnit,event)
	if pPlayer then
		pUnit:SendChatMessage(42,0,"A black hole is trying to rip out your energy! Avoid it!")
		if c == 1 then
			pUnit:RegisterEvent("Shrink_Player_If_Close_And_Grown", 1000, 0)
			c = 2
			BLACK_HOLE_A = pUnit:SpawnCreature(310518, pPlayer:GetX(), pPlayer:GetY(), pPlayer:GetZ(), pPlayer:GetO(), 35, 0, 0, 0, 0, 8, 0)
			BLACK_HOLE_A:SetScale(0.4)
			BLACK_HOLE_A:SetModel(11686)
			BLACK_HOLE_A:CastSpell(73525)
			BLACK_HOLE_A:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		elseif c == 2 then
			c = 3
			BLACK_HOLE_B = pUnit:SpawnCreature(310518, pPlayer:GetX(), pPlayer:GetY(), pPlayer:GetZ(), pPlayer:GetO(), 35, 0, 0, 0, 0, 8, 0)
			BLACK_HOLE_B:SetScale(0.4)
					BLACK_HOLE_B:SetModel(11686)
			BLACK_HOLE_B:CastSpell(73525)
					BLACK_HOLE_B:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		elseif c == 3 then
			c = 0
			BLACK_HOLE_C = pUnit:SpawnCreature(310518, pPlayer:GetX(), pPlayer:GetY(), pPlayer:GetZ(), pPlayer:GetO(), 35, 0, 0, 0, 0, 8, 0)
			BLACK_HOLE_C:SetScale(0.4)
					BLACK_HOLE_C:SetModel(11686)
			BLACK_HOLE_C:CastSpell(73525)
					BLACK_HOLE_C:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		end
	end
end

function Shrink_Player_If_Close_And_Grown(pUnit,event)
	if BLACK_HOLE_A ~= nil then
	BHA = BHA + 0.5
	BHAY = 1.25 + 0.15 * BHA
	BLACK_HOLE_A:SetScale(BHA * 0.01)
		if (DEBUG) then 
		print("BHA: "..tostring(BHA))
		print("BHAY: "..tostring(BHAY)) 
		end
		local plr = BLACK_HOLE_A:GetClosestPlayer()
		if plr ~= nil then
			if plr:GetDistanceYards(BLACK_HOLE_A) < BHAY then
				if plr:GetPhase() == 8 then
					plrsca[plr:GetName()] = plrsca[plr:GetName()] or {VAR={}}
					if plrsca[plr:GetName()].VAR.scale == nil then
						plrsca[plr:GetName()].VAR.scale = 1
					end
					plrsca[plr:GetName()].VAR.scale = plrsca[plr:GetName()].VAR.scale - 0.05
					plr:SetScale(plrsca[plr:GetName()].VAR.scale)
					if (DEBUG) then print("Setting scale of "..tostring(plr:GetName()).." to "..tostring(plrsca[plr:GetName()].VAR.scale)) end
					if plrsca[plr:GetName()].VAR.scale < 0.10 then
						ResetVar()
						pUnit:SendChatMessage(42,0,"Time shifts back.")
						plr:SetScale(1)
						if (DEBUG) then print("DIE, YER SON OF A BITCH!") end
						plr:SetHealthPct(1)
						plr:CastSpell(11)
					end
				end
			end
		end
	end
	if BLACK_HOLE_B ~= nil then
	local plr = BLACK_HOLE_B:GetClosestPlayer()
	BHB = BHB + 0.5
	BHBY = 1.25 + 0.15 * BHB
	BLACK_HOLE_B:SetScale(BHB * 0.01)
		if (DEBUG) then
		print("BHB: "..tostring(BHB))
		print("BHBY: "..tostring(BHBY))
		end
		if plr ~= nil then
			if plr:GetDistanceYards(BLACK_HOLE_B) < BHBY then
				if plr:GetPhase() == 8 then
					plrsca[plr:GetName()] = plrsca[plr:GetName()] or {VAR={}}
					if plrsca[plr:GetName()].VAR.scale == nil then
						plrsca[plr:GetName()].VAR.scale = 1
					end
					plrsca[plr:GetName()].VAR.scale = plrsca[plr:GetName()].VAR.scale - 0.05
					plr:SetScale(plrsca[plr:GetName()].VAR.scale)
					if (DEBUG) then print("Setting scale of "..tostring(plr:GetName()).." to "..tostring(plrsca[plr:GetName()].VAR.scale)) end
					if plrsca[plr:GetName()].VAR.scale < 0.10 then
						ResetVar()
						pUnit:SendChatMessage(42,0,"Time shifts back.")
						plr:SetScale(1)
						if (DEBUG) then print("DIE, YER SON OF A BITCH!") end
						plr:SetHealthPct(1)
						plr:CastSpell(11)
					end
				end
			end
		end
	end
	if BLACK_HOLE_C ~= nil then
	local plr = BLACK_HOLE_C:GetClosestPlayer()
	BHC = BHC + 0.5
	BHCY = 1.25 + 0.15 * BHC
	BLACK_HOLE_C:SetScale(BHC * 0.01)
		if (DEBUG) then
		print("BHC: "..tostring(BHC))
		print("BHCY: "..tostring(BHCY))
		end
		if plr ~= nil then
			if plr:GetDistanceYards(BLACK_HOLE_A) < BHCY then
				if plr:GetPhase() == 8 then
					plrsca[plr:GetName()] = plrsca[plr:GetName()] or {VAR={}}
					if plrsca[plr:GetName()].VAR.scale == nil then
						plrsca[plr:GetName()].VAR.scale = 1
					end
					plrsca[plr:GetName()].VAR.scale = plrsca[plr:GetName()].VAR.scale - 0.05
					plr:SetScale(plrsca[plr:GetName()].VAR.scale)
					if (DEBUG) then print("Setting scale of "..tostring(plr:GetName()).." to "..tostring(plrsca[plr:GetName()].VAR.scale)) end
					if plrsca[plr:GetName()].VAR.scale < 0.10 then
						ResetVar()
						pUnit:SendChatMessage(42,0,"Time shifts back.")
						plr:SetScale(1)
						if (DEBUG) then print("DIE, YER SON OF A BITCH!") end
						plr:SetHealthPct(1)
						plr:CastSpell(11)
					end
				end
			end
		end
	end
end

	
---------------------------------
---------The Event DEATH---------
---------------------------------

function Jane_SuperNovaKill_Interaction(pUnit)
	if i == 1 then --Since there are no 0
		--Fix scale event
		local playershaha = Jane:GetInRangePlayers()
			for a, plrs in pairs(playershaha) do
				if Jane:GetDistanceYards(plrs) < 40 then
					plrs:SetScale(1)
					if plrs:HasQuest(2500) == true then
						plrs:MarkQuestObjectiveAsComplete(2500,0)
					end
				end
			end
		Jane:Emote(999, 1000)
		Jane:SendChatMessage(42,0,"Jane casts Greater Blast Wave!")
		Jane:RemoveAura(54219) --Removes the visual from Jane.
		Jane:FullCastSpell(40162) --Visuals
		Jane:FullCastSpell(71599)
		Jane:FullCastSpell(46225)
		Thomas:SetHealthPct(1) --Set the hp to one
		Thomas:CastSpell(11) --And finish himself off
		if BLACK_HOLE_A ~= nil then BLACK_HOLE_A:Despawn(1000,0) end
		if BLACK_HOLE_B ~= nil then BLACK_HOLE_B:Despawn(1000,0) end
		if BLACK_HOLE_C ~= nil then BLACK_HOLE_C:Despawn(1000,0) end
		--We're not moving them to phase 4 just yet. Small dialogue first :D
		DEBUGA:RegisterEvent("Jane_SuperNovaKill_Interaction",2400,1)
	elseif i == 2 then
		Jane:SendChatMessage(12,0,"So... he was a demon.")
		pUnit:RegisterEvent("Jane_SuperNovaKill_Interaction",3400,1)
	elseif i == 3 then
		Jane:SendChatMessage(16,0,"You let out a cough.")
		pUnit:RegisterEvent("Jane_SuperNovaKill_Interaction",4000,1)
	elseif i == 4 then
		Jane:SendChatMessage(12,0,"Oh, I'm sorry. My name is Jane - thank you for the intervention.")
		pUnit:RegisterEvent("Jane_SuperNovaKill_Interaction",4500,1)
	elseif i == 5 then
		pUnit:RegisterEvent("Jane_SuperNovaKill_Interaction",2500,1)
	elseif i == 6 then
		Jane:SendChatMessage(16,0,"There is a short silence.")
		pUnit:RegisterEvent("Jane_SuperNovaKill_Interaction",6800,1)
	elseif i == 7 then
		Jane:SendChatMessage(12,0,"...What was your name?")
		pUnit:RegisterEvent("Jane_SuperNovaKill_Interaction",2000,1)
	elseif i == 8 then
		pUnit:RegisterEvent("Jane_SuperNovaKill_Interaction",400,1)
	elseif i == 9 then
		pUnit:SendChatMessage(42,0,"You feel time shifting, and Jane disappears in front of your eyes.")
		local playershaha = Jane:GetInRangePlayers()
			for a, plrs in pairs(playershaha) do
				if Jane:GetDistanceYards(plrs) < 40 then
				plrs:SetPhase(4)
				plrs:CastSpell(68085)
				end
			end
		ResetVar()
	end
	i = i + 1
	if (DEBUG) then print(i) end
end
	
------------------------------------------------------
--------------Reset Var-------------------------------
------------------------------------------------------

function TIK_OnChatThingy(event, plr, message, type, language)
	local message = string.lower(message)
	if (DEBUG) then
		if (message == TIKKI_DEBUG) then
			ResetVar()
			plr:SendAreaTriggerMessage("Variables have been reset.")
			plr:SendBroadcastMessage("Variables have been reset.")
			return false
		elseif (message == TIKKI_START) then
			pPlayer = plr
			DEBUGA:SetNPCFlags(2)
			DEBUGA:SendChatMessage(12,0,"Very well then. Watch as the spirits take us back to their time...")
			Q2500InUse = true
			return false
		end
	end
end

function ResetVar()
	BHA = 1
	BHAY = 1.25
	BHB = 1 
	BHBY = 1.25
	BHC = 1 
	BHCY = 1.25
	plrsca = {}
	plrsca.VAR = {}
	pPlayer = nil
		if DEBUGA ~= nil then
		DEBUGA:RemoveEvents()
		DEBUGA:SetNPCFlags(3)
		DEBUGA:RegisterEvent("Are_we_ready", 5000, 0)
		end
		if Thomas ~= nil then 
		Thomas:RemoveEvents()
		Thomas:Despawn(1000,0) 
		end
		if Jane ~= nil then 
		Jane:RemoveEvents()
		Jane:Despawn(1000,0)
		end
	if BLACK_HOLE_A ~= nil then BLACK_HOLE_A:Despawn(1000,0) end
	if BLACK_HOLE_B ~= nil then BLACK_HOLE_B:Despawn(1000,0) end
	if BLACK_HOLE_C ~= nil then BLACK_HOLE_C:Despawn(1000,0) end
	Q2500InUse = false
	if Luke ~= nil then Luke:Despawn(1000,0) end
	if Thomas ~= nil then Thomas:Despawn(1000,0) end
	if Jessica ~= nil then Jessica:Despawn(1000,0) end
	i = 0
end

----AfterQuest---

function JW_Phase4_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(3630, player,0)
	pUnit:GossipMenuAddItem(0, "Send me back to my time.", 246, 0)
   pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
   pUnit:GossipSendMenu(player)
end

function JW_Phase4_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
if player ~= nil then
player:SetPhase(1)
player:RemoveAura(68085)  
player:Teleport(0, -9387.29, -3035.95, 139.43)
player:GossipComplete()
else
  player:GossipComplete()
end
if(intid == 250) then
	player:GossipComplete()
end
end
end

RegisterUnitGossipEvent(77118, 1, "JW_Phase4_On_Gossip")
RegisterUnitGossipEvent(77118, 2, "JW_Phase4_Gossip_Submenus")


--RegisterServerHook(16, "TIK_OnChatThingy")