
function gryphonfthemainguyterlcik(pUnit, event, player)
	pUnit:GossipCreateMenu(699, player, 0)
	if player:HasFinishedQuest(3010) then
		pUnit:GossipMenuAddItem(2, "Send me to Render's Valley.", 3, 0)
	end
	if player:HasQuest(3008) or player:HasQuest(3007) or player:HasQuest(3006) then
		pUnit:GossipMenuAddItem(2, "Send me to Render's Valley", 5, 0)
	end
	if player:HasQuest(3033) or player:HasQuest(3034) or player:HasQuest(3035) then
		pUnit:GossipMenuAddItem(2, "Send me to Lakeshire", 6, 0)
	end
	pUnit:GossipMenuAddItem(2, "Return me to Blackrock Mountain.", 2, 0)
	pUnit:GossipMenuAddItem(4, "Pat the gryphon.", 1, 0)
	pUnit:GossipSendMenu(player)
end

function gryphonthemainguyecat(pUnit, event, player, id, intid, code)
	if intid == 1 then
		player:GossipComplete()
	elseif (intid == 2) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -9396.187500, -3016.221436, 140.831238)
		player:_AddPathNode(0, -9336.750977, -3012.142090, 163.988007)
		player:_AddPathNode(0, -9263.320313, -2960.584229, 167.805740)
		player:_AddPathNode(0, -9207.885742, -2881.226807, 165.042770)
		player:_AddPathNode(0, -9035.144531, -2664.063721, 202.403046)
		player:_AddPathNode(0, -8889.648438, -2584.381348, 192.662506)
		player:_AddPathNode(0, -8673.914063, -2571.988525, 170.760422)
		player:_AddPathNode(0, -8512.179688, -2553.238525, 207.923462)
		player:_AddPathNode(0, -8326.922852, -2512.669434, 164.788422)
		player:_AddPathNode(0, -8214.511719, -2445.064209, 188.196396)
		player:_AddPathNode(0, -8167.949707, -2313.015381, 194.464386)
		player:_AddPathNode(0, -8153.333008, -2176.431641, 200.266708)
		player:_AddPathNode(0, -8028.690430, -1980.883301, 210.172882)
		player:_AddPathNode(0, -7971.843750, -1765.893677, 174.524246)
		player:_AddPathNode(0, -7927.728027, -1616.108643, 208.687820)
		player:_AddPathNode(0, -7843.714844, -1562.531616, 258.068146)
		player:_AddPathNode(0, -7766.048828, -1591.361694, 295.440979)
		player:_AddPathNode(0, -7672.097168, -1605.035034, 335.269440)
		player:_AddPathNode(0, -7630.164551, -1544.403931, 389.532257)
		player:_AddPathNode(0, -7556.375000, -1501.596191, 466.360382)
		player:_AddPathNode(0, -7500.333496, -1354.415283, 512.812866)
		player:_AddPathNode(0, -7498.192383, -1287.089233, 502.110352)
		player:_AddPathNode(0, -7500.848633, -1265.770264, 496.025787)
		player:_AddPathNode(0, -7488.001465, -1251.719116, 481.318604)
		player:_AddPathNode(0, -7479.236328, -1248.374878, 477.419464)
		player:_StartTaxi(28652)
		player:GossipComplete()
	elseif(intid == 3) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -9397.924805, -3013.171143, 136.687317)
		player:_AddPathNode(0, -9375.707031, -3013.746094, 148.826920)
		player:_AddPathNode(0, -9311.712891, -3011.962891, 149.595016)
		player:_AddPathNode(0, -9212.375977, -2868.998291, 153.670517)
		player:_AddPathNode(0, -9361.274414, -2835.358154, 92.927216)
		player:_AddPathNode(0, -9465.642578, -2930.974854, 109.703384)
		player:_AddPathNode(0, -9550.647461, -3017.167969, 114.964676)
		player:_AddPathNode(0, -9695.663086, -3117.667969, 70.897003)
		player:_AddPathNode(0, -9700.188477, -3118.229980, 60.069725)
		player:_StartTaxi(28652)
		player:GossipComplete()
		player:SetPhase(8)
	elseif (intid == 5) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -9397.924805, -3013.171143, 136.687317)
		player:_AddPathNode(0, -9375.707031, -3013.746094, 148.826920)
		player:_AddPathNode(0, -9311.712891, -3011.962891, 149.595016)
		player:_AddPathNode(0, -9212.375977, -2868.998291, 153.670517)
		player:_AddPathNode(0, -9361.274414, -2835.358154, 92.927216)
		player:_AddPathNode(0, -9465.642578, -2930.974854, 109.703384)
		player:_AddPathNode(0, -9629.071289, -3026.680420, 95.911118)
		player:_AddPathNode(0, -9652.700195, -3217.266602, 53.144356)
		player:_AddPathNode(0, -9674.671875, -3225.777588, 50.839832)
		player:_StartTaxi(28652)
		player:GossipComplete()
		player:SetPhase(4)
	elseif (intid == 6) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -9401.37, -3018.35, 136.68)
		player:_AddPathNode(0, -9359.26, -3014.06, 140.83)
		player:_AddPathNode(0, -9364.47, -2966.42, 147.88)
		player:_AddPathNode(0, -9394.15, -2862.92, 72.40)
		player:_AddPathNode(0, -9450.54, -2542.12, 69.92)
		player:_AddPathNode(0, -9367.05, -2410.15, 88.49)
		player:_AddPathNode(0, -9328.63, -2378.26, 74.83)
		player:_AddPathNode(0, -9341.16, -2347.95, 61.24)
		player:_StartTaxi(28652)
		player:GossipComplete()
		if player:HasQuest(3033) == true then
			player:MarkQuestObjectiveAsComplete(3033, 0) 
		end
	end
end

RegisterUnitGossipEvent(60208, 1, "gryphonfthemainguyterlcik")
RegisterUnitGossipEvent(60208, 2, "gryphonthemainguyecat")