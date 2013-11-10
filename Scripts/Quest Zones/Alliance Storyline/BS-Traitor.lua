
function zzzOhai_spawn_crystal_OnGossip(pUnit, event, player)
    pUnit:GossipCreateMenu(257411, player, 0)
    if player:HasQuest(36) == true then
		pUnit:GossipMenuAddItem(9, "I know what you really are, traitor.", 8, 0)
		pUnit:GossipMenuAddItem(0, "Nevermind.", 3, 0)
		pUnit:GossipSendMenu(player)
    else
		pUnit:GossipMenuAddItem(0, "Nevermind.", 3, 0)
		pUnit:GossipSendMenu(player)
    end
end

function zzzOhai_spawn_crystal_GossipSubmenus(pUnit, event, player, id, intid, code)
	if(intid == 8) then
		player:MarkQuestObjectiveAsComplete(36, 0)
		pUnit:SetFaction(2)
		pUnit:CastSpell(24222)
		pUnit:SendChatMessage(12,0,"You will pay for this!")
		player:GossipComplete()
	elseif(intid == 3) then
		player:GossipComplete()
	end
end

function zzzOhai_spawn_crystal_spawn(pUnit, Event)
	pUnit:SetFaction(35)
	pUnit:SetModel(3138)
end

RegisterUnitGossipEvent(231111, 1, "zzzOhai_spawn_crystal_OnGossip")
RegisterUnitGossipEvent(231111, 2, "zzzOhai_spawn_crystal_GossipSubmenus")
RegisterUnitEvent(231111, 18, "zzzOhai_spawn_crystal_spawn")