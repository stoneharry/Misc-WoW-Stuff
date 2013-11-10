function InterrogateFarmer_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(8068, player, 0)
	if player:HasQuest(8000) then
		if (player:GetQuestObjectiveCompletion(8000, 0) == 0) then
			pUnit:GossipMenuAddItem(0, "Furlbrow, your wife is laying dead. We NEED you to talk before we can do anything.", 246, 0)
		end
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end



function InterrogateFarmer_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
if player ~= nil then
pUnit:GossipCreateMenu(8069, player, 0)
	if player:HasQuest(8000) then
		pUnit:GossipMenuAddItem(0, "You do not understand, lives are at stake here. If we do not get the information we need, many could die. Tell me, what happened before your wife died?", 248, 0)
	end
	pUnit:GossipMenuAddItem(0, "...", 250, 0)
    pUnit:GossipSendMenu(player)
end
end


if(intid == 248) then
pUnit:SendChatMessageToPlayer(12,0,"Okay! OKAY! I was unloading newly shipped grain which had the strangest smell to it when i heard a scream within my house. I came back to find my wife dead on the floor and felt something stalking in the shadows. I fled in terror...",player)
player:GossipComplete()
player:MarkQuestObjectiveAsComplete(8000, 0)
end

if(intid == 250) then
player:GossipComplete()
end
end

RegisterUnitGossipEvent(237, 1, "InterrogateFarmer_On_Gossip")
RegisterUnitGossipEvent(237, 2, "InterrogateFarmer_Gossip_Submenus")