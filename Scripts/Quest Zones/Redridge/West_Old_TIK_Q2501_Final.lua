--[[
Quest Name: A Last Crime
Quest ID: 2501
Quest Starter: 77126
Quest Finisher:77126

Made by Tikki

External Scripts:
]]--
local i = 0
local areweyusready = false
local plraa = nil
local DEBUG = true
local BlackS

--Init

function BlackS_OnSpawn(pUnit,Event)
	BlackS = pUnit
	BlackS:Emote(30,999999999999)
	BlackS:SetCombatCapable(false)
	BlackS:SetFaction(35)
	BlackS:RegisterEvent("GhostEffectz",1200,1)
	BlackS:RegisterEvent("BlackS_CheckAndStart", 1000,0)
end

function Commander_Marcus_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("GhostEffectz",1200,1)
end

RegisterUnitEvent(77126, 18, "Commander_Marcus_OnSpawn")
RegisterUnitEvent(77127, 18, "BlackS_OnSpawn")

-------------------------------
----------COMMANDER------------
-------------------------------


function Commander_Marcus_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(77126, player, 0)
		if player:HasQuest(3030) then
			if player:HasFinishedQuest(2501) == false then
				if player:HasQuest(2501) == false then
					pUnit:GossipMenuAddItem(0, "Lakeshire residents need to be evacuated and Jane needs your help. You are the commander, right?", 236, 0)
				end
			end
		if player:HasFinishedQuest(2501) == true then
			if player:HasItem(28913) == true then
				pUnit:GossipMenuAddItem(0, "I've done your task, commander.", 238, 0)
			end
		end
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end



function Commander_Marcus_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if (intid == 236) then
		pUnit:GossipCreateMenu(543214, player, 0)
		pUnit:GossipMenuAddItem(0, "I will.", 237, 0)
		pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
		pUnit:GossipSendMenu(player)
	end
     if (intid == 237) then
		player:StartQuest(2501)
		player:GossipComplete()
	end
	if (intid == 238) then
		if player:HasQuest(3030) then
			player:RemoveItem(28913,1)
			pUnit:SendChatMessageToPlayer(12, 0, "Well done stranger! You can tell Jane that it would be my honor to assist her.", player)
			player:AdvanceQuestObjective(3030, 1)
		end
		player:GossipComplete()
	end
	if (initid == 250) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(77126, 1, "Commander_Marcus_On_Gossip")
RegisterUnitGossipEvent(77126, 2, "Commander_Marcus_Gossip_Submenus")

-------------------------------
----------BLACKSMITH-----------
-------------------------------

function BlackS_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(46672, player, 0)
	if player:HasQuest(2501) then
		if player:HasItem(28913) == false then
			pUnit:GossipMenuAddItem(0, "Why aren't you making equipment for the militia?", 246, 0)
		end
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end

function BlackS_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 246) then
		if player ~= nil then
			player:GossipComplete()
			plraa = player
			pUnit:SetNPCFlags(2)
			pUnit:SendChatMessage(14,0,"Those dirtbags killed my daughter! SHE WAS NOT A DEMON! DO YOU HEAR THAT MARCUS?!")
			pUnit:Emote(5,2000)
			areweyusready = true
		end
	end
	if (initid == 250) then
		player:GossipComplete()
	end
end

function BlackS_CheckAndStart(pUnit, event)
	if areweyusready == true then
		pUnit:RegisterEvent("BlackS_CheckAndStartz", 3000, 1)
		areweyusready = false
	end
end

function BlackS_CheckAndStartz(pUnit, event)
	i = i + 1
	if i == 1 then
		plraa:PlayerSendChatMessage(1, 0, "The militia needs you to make more equipment for them, demons are coming-")
		pUnit:RegisterEvent("BlackS_CheckAndStartz", 5000, 1)
	elseif i == 2 then
		BlackS:SendChatMessage(14,0,"I'm not making anything! Screw the militia and screw you, you dirtbag loving imperialist!")
		BlackS:Emote(5,2000)
		BlackS:SetFaction(22)
		pUnit:RegisterEvent("BlackS_CheckAndStartz", 2000, 1)
	elseif i == 3 then
		i = 0
	end
end

---combat--
function BlackS_CheckHealthyz(pUnit,Event)
	if pUnit:GetHealthPct() < 50 then
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(12,0,"Alright, ALRIGHT! I'll begin to make more equipment, here is some of what I've stashed.")
	pUnit:SetCombatCapable(true)
	pUnit:SetFaction(35)
	pUnit:Emote(431,5000)
		for a, players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 10 then
				if players:HasQuest(2501) == true then
				players:MarkQuestObjectiveAsComplete(2501,1)
			   players:FinishQuest(2501)
			   players:AddItem(28913,1)
				end
			end
		end
	tempplr = nil
	pUnit:RegisterEvent("Despawn_Unit", 2000, 1)
end
end

function Despawn_Unit(pUnit,Event)
pUnit:SetNPCFlags(1)
pUnit:Despawn(2000,3000)
end

function BSmithzs_OnCombat(pUnit,Event)
pUnit:RegisterEvent("BlackS_CheckHealthyz", 2000, 0)
end

------


RegisterUnitGossipEvent(77127, 1, "BlackS_On_Gossip")
RegisterUnitGossipEvent(77127, 2, "BlackS_Gossip_Submenus")


RegisterUnitEvent(77127, 1, "BSmithzs_OnCombat")