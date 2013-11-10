
function LumberjackWilliamGossip(pUnit, event, player)
	pUnit:GossipCreateMenu(520, player, 0)
	pUnit:GossipMenuAddItem(2, "Send me down the river, William.", 251, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 1, 0)
	pUnit:GossipSendMenu(player)
end

function LumberjackWilliamClick(pUnit, event, player, id, intid, code)
	if(intid == 251) then
		if player:HasQuest(3001) then
			player:SetPhase(2)
		elseif player:HasQuest(3004) then
			player:SetPhase(1)
		end
		player:_CreateTaxi()
		player:_AddPathNode(0, -9493, -2983, 124)
		player:_AddPathNode(0, -9533, -2976, 62)
		player:_AddPathNode(0, -9558, -2988, 70)
		player:_AddPathNode(0, -9581, -2997, 54.5)
		player:_AddPathNode(0, -9596, -2999, 54.5)
		player:_AddPathNode(0, -9605, -3014, 77)
		player:_AddPathNode(0, -9594, -3073, 53)
		player:_AddPathNode(0, -9584, -3114, 54)
		player:_AddPathNode(0, -9590, -3136, 55)
		player:_AddPathNode(0, -9595, -3152, 54.5)
		player:_AddPathNode(0, -9580, -3176, 54.5)
		player:_AddPathNode(0, -9556, -3193, 54.5)
		player:_AddPathNode(0, -9552, -3193, 67)
		player:_AddPathNode(0, -9538, -3182, 53)
		player:_AddPathNode(0, -9516, -3136, 54.5)
		player:_AddPathNode(0, -9504, -3125, 54.5)
		player:_AddPathNode(0, -9489, -3121, 54.5)
		player:_AddPathNode(0, -9476, -3124, 55)
		player:_AddPathNode(0, -9460, -3145, 55)
		player:_AddPathNode(0, -9450, -3197, 55)
		player:_AddPathNode(0, -9440, -3245, 66)
		player:_AddPathNode(0, -9434, -3290, 3)
		player:_AddPathNode(0, -9449, -3311, -19)
		player:_StartTaxi(26610)
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(149111, 1, "LumberjackWilliamGossip")
RegisterUnitGossipEvent(149111, 2, "LumberjackWilliamClick")
