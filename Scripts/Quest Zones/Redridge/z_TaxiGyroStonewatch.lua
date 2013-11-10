function Taxigyrocopterstonewatch(pUnit, event, player)
	pUnit:GossipCreateMenu(432142, player, 0)
	if player:HasQuest(3033) or player:HasQuest(3034) or player:HasQuest(3035) == true then
		pUnit:GossipMenuAddItem(2, "Send me to Lakeshire", 3, 0)
	end
	pUnit:GossipMenuAddItem(2, "Return me to Stonewatch.", 2, 0)
	pUnit:GossipMenuAddItem(4, "Nevermind.", 1, 0)
	pUnit:GossipSendMenu(player)
end

function gyrocoptergossipselect(pUnit, event, player, id, intid, code)
	if (intid == 2) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -9700.188477, -3118.229980, 60.069725)
		player:_AddPathNode(0, -9695.663086, -3117.667969, 70.897003)
		player:_AddPathNode(0, -9550.647461, -3017.167969, 114.964676)
		player:_AddPathNode(0, -9465.642578, -2930.974854, 109.703384)
		player:_AddPathNode(0, -9361.274414, -2835.358154, 92.927216)
		player:_AddPathNode(0, -9212.375977, -2868.998291, 153.670517)
		player:_AddPathNode(0, -9311.712891, -3011.962891, 149.595016)
		player:_AddPathNode(0, -9375.707031, -3013.746094, 148.826920)
		player:_AddPathNode(0, -9397.924805, -3013.171143, 136.687317)
		player:_StartTaxi(25587)
		player:SetPhase(1)
	elseif (intid == 3) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -9706.20, -3128.64, 63.36)
		player:_AddPathNode(0, -9672.62, -3143.51, 67.06)
		player:_AddPathNode(0, -9650.22, -3025.51, 72.33)
		player:_AddPathNode(0, -9631.08, -2772.54, 116.27)
		player:_AddPathNode(0, -9314.61, -2409.16, 97.28)
		player:_AddPathNode(0, -9341.79, -2346.78, 61.24)
		player:_StartTaxi(25587)
		player:SetPhase(1)
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(77055, 1, "Taxigyrocopterstonewatch")
RegisterUnitGossipEvent(77055, 2, "gyrocoptergossipselect")


