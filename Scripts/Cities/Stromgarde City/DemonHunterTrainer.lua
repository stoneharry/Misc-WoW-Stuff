function DH_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(1080, player, 0)
	if (player:GetPlayerClass() == "Demon Hunter") then
		pUnit:GossipMenuAddItem(6, "I'm missing a warglaive and steed", 2, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end

function DH_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if (intid == 2) then
if player:HasItem(14884) and player:GetItemCount(14884) == 1 then
player:AddItem(14884,1)
end
if player:HasSpell(50044) then
else
player:LearnSpell(50044)
end
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(99810, 1, "DH_On_Gossip")
RegisterUnitGossipEvent(99810, 2, "DH_Gossip_Submenus")