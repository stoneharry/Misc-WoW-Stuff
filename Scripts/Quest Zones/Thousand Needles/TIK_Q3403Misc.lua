--Q3403_ACTIV_DEBUGA = true --Tailor|	Uncomment to activate debug function (Should be commented on live-realm!)
Q3403_ACTIV_DEBUGB = true --Mage|		Since there are multiple parts in the scripts, I need more variables
--Q3403_ACTIV_DEBUGC = true --Sabotage|	Uncomment to activate debug function (Should be commented on live-realm!)
local pp = "Q3403: "
local quid = 003403
local quida = 013403
local quidb = 023403
--/\/\/\/\/\/\/--
--//VARIABLES\\--
--/\/\/\/\/\/\/--

--Le Tailor Variables
local TIKTailor = nil
local TIKChestA = false
local TIKChestB = false
local TIKChestC = false
local TIKChestAA = nil
local TIKChestBB = nil
local TIKChestCC = nil
local plr1 = nil

--Le Mage Variables
local TIKMage = nil
local plr2 = nil
local TIKReady = false
local TIKMageA = nil
local TIKMageB = nil
local c = 0

--Le Gnome Car

local TIKPit1 = nil
local TIKPit2 = nil
local TIKPit3 = nil
local TIKInUse = false
local plr3 = nil
local cc = 0

--Q3403 = {}
--Q3403.VAR = {}
--/\/\/\/\/\--
--//Tailor\\--
--/\/\/\/\/\--

--[[Now the intention of this script is that Erica is watching her crates.
If she's looking, you will be unable to steal them. She moves around in 
her booth, unlocking a different crate, and locking the others each time.
If caught, you will be teleported in the air, and thrown down, taking
fall damage ^^]]--

function Q3403_EricaYoungOnSpawn(pUnit,Event)
	TIKTailor = pUnit --Defining her as TIKTailor. Could come in handy, but so far unused.
	pUnit:RegisterEvent("Q3404_EricaYoungMoveRandomly",math.random(5000,20000),0) --Activating the next script, with a random timer on.
	TIKChestAA = pUnit:SpawnGameObject(89002, -6136,-3955,-58.749527,4.797995, 0, 100,1,0) 
	TIKChestBB = pUnit:SpawnGameObject(89002, -6132,-3959,-58.749420,2.576104, 0, 100,1,0) 
	TIKChestCC = pUnit:SpawnGameObject(89002, -6137,-3962.539063,-56.543873,1.822122, 0, 100,1,0) 
end

RegisterUnitEvent(89005,18,"Q3403_EricaYoungOnSpawn")

function Q3404_EricaYoungMoveRandomly(pUnit,Event)
	local q = math.random(1,3) --We choose between 3 possible ways to stand.
	--debprint("q ="..tostring(q),quid)
	if q == 1 then
		pUnit:MoveTo(-6136.775879,-3958.315674,-58.749596,5.410435)
		TIKChestA = true --Used to define which chest is able to be opened.
		TIKChestB = false
		TIKChestC = false
	elseif q == 2 then
		pUnit:MoveTo(-6133.684082,-3958.468506,-58.749596,2.934860)
		TIKChestB = true
		TIKChestC = false
		TIKChestA = false
	elseif q == 3 then
		pUnit:MoveTo(-6136.165526,-3960.164551,-58.749596,0.907747)
		TIKChestC = true
		TIKChestA = false
		TIKChestB = false
	end
end

function Q3403_CrateOnUse(pUnit, Event, pMisc)
	debprint(pUnit:GetX(),quid)
	if pMisc:HasQuest(3403) == true then
		if pUnit:GetX() == -6136 then
			debprint("It's an A.",quid)
			if TIKChestA == true then
				debprint("add item",quid)
				plr1 = pMisc
				if plr1:HasItem(1309) ~= true then
					plr1:AddItem(1309,1)
				end
				if plr1:GetQuestObjectiveCompletion(3403, 1) == 0 then
					debprint("Advance Quest Objective")
					plr1:AdvanceQuestObjective(3403, 1)
				end
			else
				pMisc:CastSpell(73536)
				pMisc:Teleport(1, -6167,-3933,-57)
				TIKTailor:RegisterEvent("Q3403_RandomMSG",1000,1)
			end
		elseif pUnit:GetX() == -6132 then
			debprint("It's an B.",quid)
			if TIKChestB == true then
				debprint("add item",quid)
				plr1 = pMisc
				if plr1:HasItem(1309) ~= true then
					plr1:AddItem(1309,1)
				end
				if plr1:GetQuestObjectiveCompletion(3403, 1) == 0 then
					debprint("Advance Quest Objective")
					plr1:AdvanceQuestObjective(3403, 1)
				end
			else
				pMisc:CastSpell(73536)
				pMisc:Teleport(1, -6167,-3933,-57)
				TIKTailor:RegisterEvent("Q3403_RandomMSG",1000,1)
			end
		elseif pUnit:GetX() == -6137 then
			debprint("It's an C.",quid)
			if TIKChestC == true then
				debprint("add item",quid)
				plr1 = pMisc
				if plr1:HasItem(1309) ~= true then
					plr1:AddItem(1309,1)
				end
				if plr1:GetQuestObjectiveCompletion(3403, 1) == 0 then
					debprint("Advance Quest Objective")
					plr1:AdvanceQuestObjective(3403, 1)
				end
			else
				pMisc:CastSpell(73536)
				pMisc:Teleport(1, -6167,-3933,-57)
				TIKTailor:RegisterEvent("Q3403_RandomMSG",1000,1)
			end
		end
	else
		pMisc:SendAreaTriggerMessage("You need the required quest: 'Visiting The Enemy'.")
		pMisc:SendBroadcastMessage("You need the required quest: 'Visiting The Enemy'.")
	end
end

function Q3403_RandomMSG(pUnit,Event)
	local q = math.random(1,3)
	if q == 1 then
		pUnit:SendChatMessageToPlayer(14,0,"Trespasser! Guards!",plr1)
	elseif q == 2 then
		pUnit:SendChatMessageToPlayer(14,0,"You tought I didn't learn a trick or two?",plr1)
	elseif q == 3 then
		pUnit:SendChatMessageToPlayer(14,0,"Leave! Your not welcome here!",plr1)
	end
end

RegisterGameObjectEvent(89002 , 4, "Q3403_CrateOnUse")

--/\/\/\/\/--
--//MAGES\\--
--/\/\/\/\/--
function Q3403_MageAOnSpawn(pUnit,Event)
	TIKMageA = pUnit
	--pUnit:RegisterEvent("Q3403_MageCheckReady",5000,0)
end

RegisterUnitEvent(89006,18,"Q3403_MageAOnSpawn")

function Q3403_MageBOnSpawn(pUnit,Event)
	TIKMageB = pUnit
end

RegisterUnitEvent(89007,18,"Q3403_MageBOnSpawn")

function Q3403_MageMenu(pUnit, event, player)
	if player:HasQuest(3403) == true then
		if TIKReady == false then
			--[[plr2 = player
			debprint("Caught player: "..plr2:GetName(),quida)
			plr2:SetPlayerLock(true)
			pUnit:SendChatMessageToPlayer(12,0,"Not so fast, my friend.",plr2)
			TIKReady = true]]--
			if player:HasItem(31489) ~= true then
				player:AddItem(31489,1)
			end
			if player:GetQuestObjectiveCompletion(3403, 0) == 0 then
				debprint("Advance Quest Objective")
				player:AdvanceQuestObjective(3403, 0)
			end
		end
	else
		player:SendAreaTriggerMessage("You need the required quest: 'Visiting The Enemy'")
		player:SendBroadcastMessage("You need the required quest: 'Visiting The Enemy'")
	end
end

RegisterUnitGossipEvent(89006, 1, "Q3403_MageMenu")

function OrbOfDisguise(pItem, event, player)
	if player:HasItem(1309) == true then	
		player:SetModel(5435)
		player:CastSpell(60034)
	else
		player:SendAreaTriggerMessage("You need the required item: 'Crate of Cloth'")
		player:SendBroadcastMessage("You need the required item: 'Crate of Cloth'")
	end
end

RegisterItemGossipEvent(31489, 1, "OrbOfDisguise")

function Q3403_TriggerAOnSpawn(pUnit,Event)
	TIKPit1 = pUnit:SpawnCreature(4430, -6229,-3872,-58.749397,2.310438, 35, 0, 0, 0, 0, 1, 0)
	TIKPit2 = pUnit:SpawnCreature(4430, -6230,-3868,-58.749901,4.165230, 35, 0, 0, 0, 0, 1, 0)
	TIKPit3 = pUnit:SpawnCreature(4495, -6227.310059,-3871.570068,-58.751701,2.7476, 35, 0, 0, 0, 0, 1, 0)
	pUnit:RegisterEvent("Q3403_GnomeHiPlayers",3000,0)
end

function Q3403_GnomeHiPlayers(pUnit,Event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 10 then
			if plr:IsAlive() then
				if plr:GetDisplay() == 5435 then
					if TIKInUse == false then
						TIKInUse = true
						plr3 = plr
						TIKPit3:SendChatMessageToPlayer(12,0,"DON'T BEND THAT! Carefull!",plr3)
						pUnit:RegisterEvent("Q3403_GnomeTalk",4000,1)
						cc = 1
					end
				end
			end
		end
	end
end

RegisterUnitEvent(89012,18,"Q3403_TriggerAOnSpawn")

function Q3403_GnomeTalk(pUnit,Event)
	if cc == 1 then
		TIKPit3:SendChatMessageToPlayer(12,0,"Oh, the boss is here.",plr3)
		TIKPit3:Emote(1,0)
	elseif cc == 2 then
		TIKPit1:SendChatMessageToPlayer(12,0,"Bwah, I can smell those rotten goblins from here. Oh well, boss, is it approved?",plr3)
		TIKPit1:Emote(6,0)
	elseif cc == 3 then
		TIKInUse = false
		plr3 = nil
		cc = 0
	end
	cc = cc + 1
end

--Le Toolbox
function Q3403_ToolboxAOnUse(pUnit, Event, pMisc)
	if pMisc:HasQuest(3403) == true then
		if pMisc:GetDisplay() == 5435 then
			if pMisc:GetQuestObjectiveCompletion(3403, 2) == 0 then
			pMisc:AdvanceQuestObjective(3403, 2)
			TIKPit1:SendChatMessageToPlayer(9,0,"You sabotage the gnome racing cart.",pMisc)
			TIKPit1:SendChatMessageToPlayer(12,0,"What are you..? Oh, ofcourse! Geniously!",pMisc)
			TIKPit1:Emote(4,0)
			end
		end
	else
		player:SendAreaTriggerMessage("You need the required quest: 'Visiting The Enemy'")
		player:SendBroadcastMessage("You need the required quest: 'Visiting The Enemy'")
	end
end

RegisterGameObjectEvent(89004 , 4, "Q3403_ToolboxAOnUse")
------------------
---OUTCOMMENTED---
------------------






--[[function Q3403_MageCheckReady(pUnit,Event)
	if TIKReady == true then
		if c == 0 then
			pUnit:RemoveEvents()
			debprint("Ready!",quida)
			pUnit:SendChatMessageToPlayer(12,0,"So... You think you can steal from me?",plr2)
			pUnit:RegisterEvent("Q3403_MageCheckReady",1000,1)
		elseif c == 1 then
			pUnit:Emote(1,0)
			debprint("Emote",quida)
			pUnit:RegisterEvent("Q3403_MageCheckReady",5000,1)
		elseif c == 2 then
			if plr2:GetGender() == 0 then
				TIKMageB:SendChatMessageToPlayer(12,0,"Well, we better teach him a lesson, right Adurin?", plr2)
			else
				TIKMageB:SendChatMessageToPlayer(12,0,"Well, we better teach her a lesson, right Adurin?", plr2)
			end
			TIKMageB:Emote(11,0)
			debprint("Talk + Laugh",quida)
			pUnit:RegisterEvent("Q3403_MageCheckReady",5000,1)
		elseif c == 3 then
			debprint("Correct",quida)
			pUnit:Emote(1,0)
			pUnit:SendChatMessageToPlayer(12,0,"Correct Elathor. I think a visit- What to call it? Challenge? Haha, this is going to be entertaining.",plr2)
			pUnit:RegisterEvent("Q3403_MageCheckReady",5000,1)
		elseif c == 4 then
			plr2:CastSpell(51347)
			pUnit:Emote(463,0)
			debprint("Visual",quida)
			pUnit:RegisterEvent("Q3403_MageCheckReady",1000,1)
		elseif c == 5 then
			debprint("last thing",quida)
			plr2:SetPlayerLock(false)
			plr2:SetPhase(1)
			plr2:Teleport(578,1016,1201,439.431885)
			pUnit:RegisterEvent("Q3403_MageCheckReady",100,1)
		elseif c == 6 then
			c = 0
			TIKReady = false
			plr2:CastSpell(51347)
			debprint("Visual2",quida)
		end
		c = c + 1
	end
end


-------------
--On Spawns--
-------------
function Q3403.VAR.AstralProjectMage(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	Q3403[id] = Q3403[id] or {VAR={}}
	Q3403[id].VAR.Mage = pUnit
	Q3403[id].VAR.c = 1
	Q3403[id].VAR.cc = 0
	pUnit:CastSpell(44816)
	pUnit:RegisterEvent("Q3403.VAR.AstralSpells",1000,1)
	pUnit:RegisterEvent("Q3403.VAR.DetectPlayers",5000,0)
end

function Q3403.VAR.AstralSpells(pUnit,Event)
	pUnit:CastSpell(50195)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end	


RegisterUnitEvent(89008,18,"Q3403.VAR.AstralProjectMage")

---------------------------------------------------------------
---------------------------------------------------------------

function Q3403.VAR.DetectPlayers(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	Q3403[id] = Q3403[id] or {VAR={}}
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 10 then
			if plr:IsAlive() then
				pUnit:RemoveEvents()
				print(" ") -- To clean the console line
				Q3403[id].VAR.plr = plr
				pUnit:SendChatMessage(14,0,"Welcome, welcome! To the Arcane Prison!")
				pUnit:RegisterEvent("Q3403.VAR.StartEvent", 4000, 1)
			end
		end
	end
end

function Q3403.VAR.StartEvent(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	Q3403[id] = Q3403[id] or {VAR={}}
	if Q3403[id].VAR.c == 1 then
		pUnit:Emote(1,0)
		pUnit:SendChatMessage(12,0,"So... You think you're a master thief?")
		pUnit:RegisterEvent("Q3403.VAR.StartEvent", 4000, 1)
	elseif Q3403[id].VAR.c == 2 then
		pUnit:Emote(11,0)
		pUnit:SendChatMessage(12,0,"Well, I caught you. Didn't do a pretty good job, hm? Hahaha.")
		pUnit:RegisterEvent("Q3403.VAR.StartEvent", 6000, 1)
	elseif Q3403[id].VAR.c == 3 then
		pUnit:Emote(1,0)
		pUnit:SendChatMessage(12,0,"So, Master Thief, I will have to test you... Catch Ronal, and I will let you go.")
		pUnit:RegisterEvent("Q3403.VAR.StartEvent", 5000, 1)
	elseif Q3403[id].VAR.c == 4 then
		pUnit:Emote(1,0)
		pUnit:SendChatMessage(12,0,"And you get the orb.")
		pUnit:RegisterEvent("Q3403.VAR.StartEvent", 3000, 1)
	elseif Q3403[id].VAR.c == 5 then
		pUnit:Emote(11,0)
		pUnit:SendChatMessage(12,0,"Good luck. You'll need it more than ever.")
		pUnit:RegisterEvent("Q3403.VAR.StartEvent", 6000, 1)
	elseif Q3403[id].VAR.c == 6 then
		Q3403[id].VAR.plr:CastSpell(51347)
		pUnit:RegisterEvent("Q3403.VAR.StartEvent", 1000, 1)
	elseif Q3403[id].VAR.c == 7 then
		Q3403[id].VAR.plr:Teleport(578,1046,1032,432.516541)
	end		
	Q3403[id].VAR.c = Q3403[id].VAR.c + 1
	print("Q3403["..id.."].VAR.c = "..Q3403[id].VAR.c)
end

-------------------
--Le Distractions--
-------------------
function Q3403.VAR.LefireOnSpawn(pUnit,Event)
	pUnit:RegisterEvent("Q3403.VAR.Lefire",3000,0)
	pUnit:SetScale(0.5)
end

function Q3403.VAR.LeTriggerOnSpawn(pUnit,Event)
	pUnit:RegisterEvent("Q3403.VAR.LefireStrike",1000,0)
end

function Q3403.VAR.LefireOnSpawn(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	Q3403[id] = Q3403[id] or {VAR={}}
	if Q3403[id].VAR.cc == 0 then
		Q3403[id].VAR.cc = 1 
		pUnit:CastSpell(58522)
	elseif Q3403[id].VAR.cc == 1 then
		Q3403[id].VAR.cc = 0
		pUnit:RemoveAura(58522)
	end
end

function Q3403.VAR.LeFireStrike(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	Q3403[id] = Q3403[id] or {VAR={}}
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 3 then
			if plr:IsAlive() then
				if Q3403[id].VAR.cc == 1 then
					print("It's 1")
					pUnit:Strike(plr, 1, 38043, 220, 230, 1.2)
				end
			end
		end
	end
end


RegisterUnitEvent(89010,18,"Q3403.VAR.LefireOnSpawn")]]--