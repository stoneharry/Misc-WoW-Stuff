function Taxigyrocopterstonewatchz(pUnit, event, player)
	pUnit:GossipCreateMenu(432142, player, 0)
	if player:HasQuest(3008) or player:HasQuest(3007) or player:HasQuest(3006) then
		if player:IsInPhase(4) then
			pUnit:GossipMenuAddItem(2, "Return me to Stonewatch.", 2, 0)
		end
	end
	pUnit:GossipMenuAddItem(4, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function gyrocoptergossipselectz(pUnit, event, player, id, intid, code)
	if (intid == 2) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -9674.671875, -3225.777588, 50.839832)
		player:_AddPathNode(0, -9652.700195, -3217.266602, 53.144356)
		player:_AddPathNode(0, -9629.071289, -3026.680420, 95.911118)
		player:_AddPathNode(0, -9465.642578, -2930.974854, 109.703384)
		player:_AddPathNode(0, -9361.274414, -2835.358154, 92.927216)
		player:_AddPathNode(0, -9212.375977, -2868.998291, 153.670517)
		player:_AddPathNode(0, -9311.712891, -3011.962891, 149.595016)
		player:_AddPathNode(0, -9375.707031, -3013.746094, 148.826920)
		player:_AddPathNode(0, -9397.924805, -3013.171143, 136.687317)
		player:_StartTaxi(25587)
		player:SetPhase(1)
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(77156, 1, "Taxigyrocopterstonewatchz")
RegisterUnitGossipEvent(77156, 2, "gyrocoptergossipselectz")


