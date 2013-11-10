
function dungeonmasttemp(pUnit, event, player, id, intid, code)
	if event == 1 then
		pUnit:GossipCreateMenu(2, player, 0)
		if player:GetPlayerLevel() == 30 then
			pUnit:GossipMenuAddItem(2, "Caverns of Time (Fall of Dalaran)", 1, 0)
			pUnit:GossipMenuAddItem(2, "Caverns of Time (World's End)", 4, 0)
			pUnit:GossipMenuAddItem(2, "Caverns of Time (The Hunt)", 5, 0)
			pUnit:GossipMenuAddItem(2, "Shadow Hold", 2, 0)
			pUnit:GossipMenuAddItem(2, "Ragefire Chasm", 3, 0)
			--[[pUnit:GossipMenuAddItem(2, "Utgarde Keep (Tier 2)", 6, 0)
			pUnit:GossipMenuAddItem(2, "Blackwing Lair (Tier 2)", 7, 0)]]
		end
		pUnit:GossipMenuAddItem(0, "Nevermind.", 100, 0)
		pUnit:GossipSendMenu(player)
	else
		player:GossipComplete()
		_teleport(player, intid)
	end
end

function _teleport(player, intid)
	if intid == 100 then
		return
	end
	if player:IsInGroup() then
		if intid == 1 then
			player:Teleport(560, 2831, 2015, 170)
		elseif intid == 2 then
			player:Teleport(608, 2170, 763, 177)
		elseif intid == 3 then
			player:Teleport(389, -148, 2, -38)
		elseif intid == 4 then
			player:Teleport(309, -10795, -1698, 148.2)
		elseif intid == 5 then
			player:Teleport(429, -17.7, 195.68, -3)
		elseif intid == 6 then
			player:Teleport(574, 154.76,-85.53,12.55)
		elseif intid == 7 then
			player:Teleport(469, -7481.29,-1145.82,476.53)
		end
	else
		player:SendBroadcastMessage("You must be in a group!")
	end
end

RegisterUnitGossipEvent(264941, 1, "dungeonmasttemp")
RegisterUnitGossipEvent(264941, 2, "dungeonmasttemp")