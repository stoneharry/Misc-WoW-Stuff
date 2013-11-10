local TIKGnome 		= nil
local TIKGoblin 	= nil
local TIKGNRadio	= nil
local TIKGORadio	= nil
local TIKInUseGO 	= false
local TIKInUseGN 	= false
local TIKRaceGirl 	= nil
local q = 1
TIKtest = {"A","B","C"}

function TIKGnomeRacer_OnSpawn(pUnit,Event)
	pUnit:SetMovementFlags(1)
	TIKGnome = pUnit
end

function TIKGoblinRacer_OnSpawn(pUnit,Event)
	pUnit:SetMovementFlags(1)
	TIKGoblin = pUnit
end

function TIKRaceGirl_OnSpawn(pUnit,Event)
	TIKRaceGirl = pUnit
	pUnit:RegisterEvent("TIKRaceCheckEveryFive",5000,0)
end

function TIKGNRadio_OnSpawn(pUnit,Event)
	TIKGNRadio = pUnit
end

function TIKGORadio_OnSpawn(pUnit,Event)
	TIKGORadio = pUnit
end

RegisterUnitEvent(4252,18,"TIKGnomeRacer_OnSpawn")
RegisterUnitEvent(4251,18,"TIKGoblinRacer_OnSpawn")
RegisterUnitEvent(89014,18,"TIKRaceGirl_OnSpawn")
RegisterUnitEvent(89016,18,"TIKGNRadio_OnSpawn")
RegisterUnitEvent(89017,18,"TIKGORadio_OnSpawn")
--------------------------------------------------------------------
--------------------------------------------------------------------

function TIKLeRace_OnGossip(pUnit,Event,plr)
	pUnit:GossipCreateMenu(100, plr, 0)
	if plr:HasQuest(3404) then
		pUnit:GossipMenuAddItem(0, "The goblin team is ready!", 1, 0)	
	end
	pUnit:GossipMenuAddItem(0, "DEBUG Restart", 3, 0)	
	pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(plr)
end

function TIKLeRace_OnGossipSelect(pUnit, event, player, id, intid, code)
	if intid == 1 then
		player:GossipComplete()
		TIKInUseGO = true
		pUnit:SetNPCFlags(2)
	elseif intid == 2 then
		player:GossipComplete()
	elseif intid == 3 then
		player:GossipComplete()
		TIKInUseGO = false
		TIKInUseGN = false
		q = 1
		TIKGnome:Despawn(1000,1000)
		TIKGoblin:Despawn(1000,1000)
		pUnit:Despawn(1000,1000)
	end
end

RegisterUnitGossipEvent(89014, 1, "TIKLeRace_OnGossip")
RegisterUnitGossipEvent(89014, 2, "TIKLeRace_OnGossipSelect")

--------------------------------------------------------------------
--------------------------------------------------------------------

function TIKRaceCheckEveryFive(pUnit,Event)
	if TIKInUseGO == true then --Goblin team is going to win
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"Welcome, welcome! Take places now..!")
		pUnit:MoveTo(-6232,-4012,-58.749683,3.09402)
		pUnit:RegisterEvent("TIKRace_Goblin_q",11000,1)
	elseif TIKInUseGN == true then -- Gnome team
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"Welcome, welcome! Take places now..!")
		pUnit:MoveTo(-6232,-4012,-58.749683,3.09402)
	end
end

------Le Goblin------

function TIKRace_Goblin_q(pUnit,Event)
	if q == 1 then
		pUnit:SendChatMessage(14,0,"Welcome, once again! Today we're going to see a furious battle between...")
		pUnit:Emote(22,0)
		pUnit:RegisterEvent("TIKRace_Goblin_q",5900,1)
	elseif q == 2 then
		pUnit:SetFacing(1.6)
		pUnit:RegisterEvent("TIKRace_Goblin_q",100,1)
	elseif q == 3 then
		pUnit:SendChatMessage(14,0,"The gnomes...")
		pUnit:Emote(25,0)
		pUnit:RegisterEvent("TIKRace_Goblin_q",4500,1)
	elseif q == 4 then
		pUnit:SetFacing(4.660542)
		pUnit:SendChatMessage(14,0,"And the goblins.")
		pUnit:Emote(25,0)
		pUnit:RegisterEvent("TIKRace_Goblin_q",4500,1)
	elseif q == 5 then
		pUnit:SetFacing(3.09402)
		pUnit:SendChatMessage(14,0,"The winner will take the 500 gold! Good luck!")
		pUnit:RegisterEvent("TIKRace_Goblin_q",3500,1)
	elseif q == 6 then
		pUnit:SendChatMessage(14,0,"The race will begin in one minute. Get ready!")
		pUnit:MoveTo(-6248,-4001,-58.749802,4.5)
		pUnit:RegisterEvent("TIKRace_Goblin_q",3000,1) --REMEMBER TO SET UP
	elseif q == 7 then
		pUnit:SendChatMessage(14,0,"Thirty seconds left")
		pUnit:RegisterEvent("TIKRace_Goblin_q",2000,1) --REMEMBER TO SET UP
	elseif q == 8 then
		pUnit:SendChatMessage(14,0,"Ten...")
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 9 then
		pUnit:SendChatMessage(14,0,"Nine...")
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 10 then
		pUnit:SendChatMessage(14,0,"Eight...")
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 11 then
		pUnit:SendChatMessage(14,0,"Seven...")
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 12 then
		pUnit:SendChatMessage(14,0,"Six...")
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 13 then
		pUnit:SendChatMessage(14,0,"Five...")
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 14 then
		pUnit:SendChatMessage(14,0,"Four...")
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 15 then
		pUnit:SendChatMessage(14,0,"Three...")
		TIKGnome:Emote(393,0)
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 16 then
		pUnit:SendChatMessage(14,0,"Two...")
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 17 then
		pUnit:SendChatMessage(14,0,"One...")
		pUnit:RegisterEvent("TIKRace_Goblin_q",1000,1)
	elseif q == 18 then
		pUnit:SendChatMessage(14,0,"GO GO GO GO!")
		pUnit:RegisterEvent("TIKRace_Goblin_q",100,1)
	elseif q == 19 then
		TIKGoblin:MoveTo(-6003,-4007,-58.750259,6.210389)
		TIKGnome:MoveTo(-6004,-4018,-58.750259,6.230023)
		pUnit:RegisterEvent("TIKRace_Goblin_q",5200,1)
	elseif q == 20 then
		TIKGnome:SendChatMessage(12,0,"Something is... Wrong.")
		pUnit:RegisterEvent("TIKRace_Goblin_q",4800,1)
	elseif q == 21 then
		TIKGNRadio:SendChatMessage(12,0,"[Noise] Gnome team, come in! Something is wrong with the controls! They're not responding! Requesting immidiate assistance!")
		TIKGnome:Despawn(4000,29800)
		pUnit:RegisterEvent("TIKRace_Goblin_q",3800,1)
	elseif q == 22 then
		TIKGNRadio:SendChatMessage(12,0,"[Noise] The controls! They're smo-")
		TIKGNRadio:SendChatMessage(42,0,"An explosion can be herd in the distance")
		TIKGnome:SendChatMessage(14,0,"WAAH!")
		TIKGnome:CastSpell(46419)
		local x,y,z,o = TIKGnome:GetLocation()
		TIKGnome:SpawnGameObject(89005,x,y,z,o,30000,100)
		local TIKTemp = TIKGnome:SpawnCreature(89015, x, y+3, z, o, 35, 30000, 0, 0, 0, 1, 0)
		TIKTemp:SetStandState(7) 
		pUnit:RegisterEvent("TIKRace_Goblin_q",31000,1)
	elseif q == 23 then
		TIKInUseGO = false
		TIKInUseGN = false
		q = 0
		TIKGnome:Despawn(1000,1000)
		TIKGoblin:Despawn(1000,1000)
		TIKRaceGirl:Despawn(1000,1000)
		TIKRaceGirl:SetNPCFlags(1)
	end
	q = q + 1
end