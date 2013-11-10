

function Wolly_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(151510, player, 0)
		if player:HasQuest(807) then
		pUnit:GossipMenuAddItem(0, "I appear to have suffered from amnesia, what exactly are we digging for again?", 246, 0)
		end
   pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
   pUnit:GossipSendMenu(player)
end


function Wolly_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
   pUnit:GossipCreateMenu(151511, player, 0)
		if player:HasQuest(807) then
		pUnit:GossipMenuAddItem(0, "I see, I will be on my way then...", 245, 0)
		end
   pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
   pUnit:GossipSendMenu(player)
end
if(intid == 245) then
		if player:HasQuest(807) then
		player:MarkQuestObjectiveAsComplete(807, 0)
		end
	local name = player:GetName()
	pUnit:SendChatMessage(12,0,"Hey, wait a minute - you are Horde scum!")
	player:SetPhase(1)
	player:GossipComplete()
end
if(intid == 250) then
	player:GossipComplete()
end
end

RegisterUnitGossipEvent(288602, 1, "Wolly_On_Gossip")
RegisterUnitGossipEvent(288602, 2, "Wolly_Gossip_Submenus")

