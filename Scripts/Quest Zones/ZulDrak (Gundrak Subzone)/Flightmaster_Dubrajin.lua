
function Drakkari_Flightmaster_Main(pUnit, event, player)
	pUnit:GossipCreateMenu(7778, player, 0)
		pUnit:GossipMenuAddItem(2,"Eastern Kingdoms", 2, 0)
		pUnit:GossipMenuAddItem(2,"Kalimdor", 3, 0)
		pUnit:GossipMenuAddItem(0, "Nevermind.", 80, 0)
	pUnit:GossipSendMenu(player)
end

function Drakkari_Flightmaster_Sub(pUnit, event, player, id, intid, code)
	if intid == 1 then
	 player:GossipComplete()
	elseif (intid == 2) then
	pUnit:GossipCreateMenu(7778, player, 0)
		pUnit:GossipMenuAddItem(2, "Blackrock Mountain", 10, 0)
		pUnit:GossipMenuAddItem(2, "Badlands", 11, 0)
	pUnit:GossipMenuAddItem(2, "Redridge", 12, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 80, 0)
	pUnit:GossipSendMenu(player)
	elseif(intid == 3) then
		player:GossipComplete()
		---EK---
	elseif (intid == 10) then -- blackrock
		player:_CreateTaxi()
		player:_AddPathNode(571, 6902.444336, -4113.858887, 473.912140)
		player:_AddPathNode(571, 6938.260254, -4127.324219, 486.199890)
		player:_AddPathNode(571, 6958.970215, -4197.775879, 492.905548)
		player:_AddPathNode(571, 7003.672852, -4281.633789, 499.889740)
		player:_AddPathNode(571, 6976.082031, -4331.083984, 503.843323)
		player:_AddPathNode(571, 6908.357422, -4428.315918, 504.805603)
		player:_AddPathNode(571, 6881.908203, -4555.436523, 505.432159)
		player:_AddPathNode(571, 6913.817383, -4701.841309, 528.339722)
		player:_AddPathNode(571, 6942.014648, -4796.221191, 546.164551)
		player:_AddPathNode(571, 6996.870605, -4896.770508, 559.091431)
		player:_AddPathNode(571, 7072.354492, -5014.517090, 539.705627)
		player:_AddPathNode(571, 7261.115234, -5267.980469, 438.922180)
		player:_AddPathNode(571, 7345.005859, -5380.626953, 390.423370)
		player:_AddPathNode(0, -6984.490723, -867.018188, 508.534119)
		player:_AddPathNode(0, -7025.448242, -995.812317, 475.307587)
		player:_AddPathNode(0, -7135.000488, -1175.789551, 469.385742)
		player:_AddPathNode(0, -7277.241699, -1265.274658, 475.478760)
		player:_AddPathNode(0, -7374.246582, -1279.003174, 468.552185)
		player:_AddPathNode(0, -7438.795898, -1254.969727, 458.040619)
		player:_AddPathNode(0, -7451.916504, -1230.236084, 493.027649)
		player:_AddPathNode(0, -7482.587891, -1237.027466, 483.595551)
		player:_AddPathNode(0, -7477.663086, -1254.791138, 477.402588)
		local race = player:GetPlayerRace()
		if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then 
		player:_StartTaxi(27913) -- ally
		else
		player:_StartTaxi(27914) -- horde
	   end
		player:GossipComplete()
	elseif (intid == 11) then -- Badlands
		   player:_CreateTaxi()
			player:_AddPathNode(571, 6900.51, -4122.53, 474.61)
		player:_AddPathNode(571, 6988.19, -4251.00, 484.36)
		player:_AddPathNode(571, 7215.47, -4172.02, 470.71)
		player:_AddPathNode(571, 7524.81, -4209.90, 295.13)
		player:_AddPathNode(0, -6476.01, -2210.79, 378.26)
		player:_AddPathNode(0, -6577.56, -2206.20, 297.95)
		player:_AddPathNode(0, -6630.78, -2182.14, 244.14)
		local race = player:GetPlayerRace()
		if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then 
		player:_StartTaxi(27913) -- ally
		else
		player:_StartTaxi(27914) -- horde
		player:GossipComplete()
	  end
	  	elseif (intid == 12) then -- RR
		   player:_CreateTaxi()
			player:_AddPathNode(571, 6900.51, -4122.53, 474.61)
		player:_AddPathNode(571, 6988.19, -4251.00, 484.36)
		player:_AddPathNode(571, 7215.47, -4172.02, 470.71)
		player:_AddPathNode(571, 7524.81, -4209.90, 295.13)
		player:_AddPathNode(0, -9280.57, -3114.31, 222.37)
		player:_AddPathNode(0, -9352.72, -3017.34, 163.63)
		player:_AddPathNode(0, -9396.96, -3012.97, 136.68)
		local race = player:GetPlayerRace()
		if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then 
		player:_StartTaxi(27913) -- ally
		else
		player:_StartTaxi(27914) -- horde
		player:GossipComplete()
	  end
		elseif (intid == 80) then
		player:GossipComplete()
	end
end


RegisterUnitGossipEvent(30569, 1, "Drakkari_Flightmaster_Main")
RegisterUnitGossipEvent(30569, 2, "Drakkari_Flightmaster_Sub")