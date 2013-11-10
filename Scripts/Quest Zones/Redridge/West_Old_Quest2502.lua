--[[
Quest Name: Stealing From A Thief
Quest ID: 2502
Quest Starter: 75632
Quest Finisher: 75632
Quest Items: 'Ravenholdt Family Chest' ID: 32380

External Scripts:
]]--
--Chest ID:				186158
--Guard id: 			789423

-----------------------
--------FISHER---------
-----------------------

function Q2502_Fisherman_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(68233, player, 0)
	if player:HasQuest(3030) then
		if player:HasFinishedQuest(2502) == false then
			if player:HasQuest(2502) == false then
				pUnit:GossipMenuAddItem(0, "Lakeshire residents need to be evacuated and Jane needs your help.", 236, 0)
			end
		end
		if player:HasItem(32380) == true then
			pUnit:GossipMenuAddItem(0, "I retrieved your family chest.", 251, 0)
		end
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end

function Q2502_Fisherman_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 236) then
		pUnit:GossipCreateMenu(68231, player, 0)
		pUnit:GossipMenuAddItem(0, "I'm on it.", 237, 0)
		pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 237) then
		player:StartQuest(2502)
		player:GossipComplete()
	end
	if(intid == 251) then
		if player:HasQuest(3030) then
			pUnit:SendChatMessageToPlayer(12, 0, "Excellent! Tell Jane she has my word.", player)
			player:RemoveItem(32380,1)
			player:AdvanceQuestObjective(3030, 2) 
			player:FinishQuest(2502)
			player:GossipComplete()
		end
	end
	if(intid == 250) then
			player:GossipComplete()
	end
end

RegisterUnitGossipEvent(75632, 1, "Q2502_Fisherman_On_Gossip")
RegisterUnitGossipEvent(75632, 2, "Q2502_Fisherman_Gossip_Submenus")


-----------------------
---------INIT----------
-----------------------

function SyndicateThug_OnSpawn(pUnit,Event)
	pUnit:SetFaction(35)
	pUnit:EquipWeapons(5192,5192,0)
	pUnit:RegisterEvent("Syndicate_PlayerCheck", 1000, 0)
end

function Syndicate_PlayerCheck(pUnit,Event)
player = pUnit:GetClosestPlayer()
if player ~= nil then
if pUnit:GetDistanceYards(player) < 5 then
if player:HasQuest(2502) == true then
if player:IsInPhase(4) == true then
if player:IsDead() == false then
pUnit:RemoveEvents()
pUnit:SetFaction(14)
end
end
end
end
end
end

function SyndicateThug_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("Syndicate_PlayerCheck", 1000, 0)
pUnit:SetFaction(35)
end

RegisterUnitEvent(789423, 2, "SyndicateThug_OnLeave")
RegisterUnitEvent(789423, 18, "SyndicateThug_OnSpawn")

function ChestLoot_OnUseObject(pMisc, event, player)
	if player:HasQuest(2502) == true then
		if player:HasItem(32380) == false then
			player:AddItem(32380,1)
		elseif player:HasItem(32380) == true then
			player:SendAreaTriggerMessage("|cFFFF0000You have already looted the chest.|r")
		end
	end
end

RegisterGameObjectEvent(186158, 4, "ChestLoot_OnUseObject")