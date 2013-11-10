function Luckystonewatch(pUnit, event, player)
	pUnit:GossipCreateMenu(699, player, 0)
	if player:HasFinishedQuest(3032) then
		pUnit:GossipMenuAddItem(2, "Return me to Stonewatch.", 2, 0)
	end
	if player:HasFinishedQuest(3010) then
		pUnit:GossipMenuAddItem(2, "Send me to Render's Valley.", 3, 0)
	end
	pUnit:GossipMenuAddItem(4, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function Luckygossipselect(pUnit, event, player, id, intid, code)
	if (intid == 2) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -9341.16, -2347.95, 61.24)
		player:_AddPathNode(0, -9328.63, -2378.26, 74.83)
		player:_AddPathNode(0, -9367.05, -2410.15, 88.49)
		player:_AddPathNode(0, -9450.54, -2542.12, 69.92)
		player:_AddPathNode(0, -9394.15, -2862.92, 72.40)
		player:_AddPathNode(0, -9364.47, -2966.42, 147.88)
		player:_AddPathNode(0, -9359.26, -3014.06, 140.83)
		player:_AddPathNode(0, -9401.37, -3018.35, 136.68)
		player:_StartTaxi(27913)
		player:GossipComplete()
		player:SetPhase(1)
	elseif (intid == 3) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -9314.61, -2409.16, 97.28)
		player:_AddPathNode(0, -9631.08, -2772.54, 116.27)
		player:_AddPathNode(0, -9650.22, -3025.51, 72.33)
		player:_AddPathNode(0, -9672.62, -3143.51, 67.06)
		player:_AddPathNode(0, -9706.20, -3128.64, 63.36)
		player:_AddPathNode(0, -9701.79, -3122.08, 60)
		player:_StartTaxi(27913)
		player:SetPhase(8)
	end
end

RegisterUnitGossipEvent(77410, 1, "Luckystonewatch")
RegisterUnitGossipEvent(77410, 2, "Luckygossipselect")


