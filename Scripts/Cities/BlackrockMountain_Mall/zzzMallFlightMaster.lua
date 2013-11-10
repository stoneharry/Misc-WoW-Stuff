
function FlightMaster_OnClick(pUnit, event, player)
	SetupDefaultMenu(pUnit, player)
end

function SetupDefaultMenu(pUnit, player)
	pUnit:GossipCreateMenu(522, player, 0)
	if player:GetMapId() == 0 then
		pUnit:GossipMenuAddItem(9, "Take me to the arena.", 261, 0)
		pUnit:GossipMenuAddItem(4, "Quest Areas.", 800, 0)
		-- Trolling
		--pUnit:GossipMenuAddItem(2, "Take me on a tour of the winds.", 610, 0)
		pUnit:GossipMenuAddItem(4, "Dungeons", 250, 0)
		pUnit:GossipMenuAddItem(4, "Challenges", 600, 0)
		pUnit:GossipMenuAddItem(4, "Courses", 251, 0)
		--pUnit:GossipMenuAddItem(4, "Races", 252, 0) --The race is bugged.
	else
		pUnit:GossipMenuAddItem(2, "Return me to Blackrock Mountain.", 248, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 1, 0)
	pUnit:GossipSendMenu(player)
end

function FlightMaster_OnGossip(pUnit, event, player, id, intid, code)
	if (intid == 1) then
		player:GossipComplete()
	elseif (intid == 2) then
		local amount = CharDBQuery("SELECT * FROM character_coursecomplete WHERE name = '"..player:GetName().."';")
		if amount == nil then
			CharDBQuery("INSERT INTO character_coursecomplete VALUES ('"..player:GetName().."', '0', '0', '0', '0');")
		else
			local count = 0
			if amount:GetColumn(1):GetString() == "1" then
				count = count + 1
			end
			if amount:GetColumn(2):GetString() == "1" then
				count = count + 1
			end
			if amount:GetColumn(3):GetString() == "1" then
				count = count + 1
			end
			if count == 3 and amount:GetColumn(4):GetString() == "0" then
				player:AddItem(29434, 1)
				player:CastSpell(47292) -- Level up visual
				pUnit:SendChatMessageToPlayer(42,0,"Congratulations! You have been rewarded 1 \124cffa335ee\124Hitem:29434:0:0:0:0:0:0:0:0\124h[Badge of Justice]\124h\124r !", player)
				CharDBQuery("UPDATE character_coursecomplete SET Rewarded = '1' WHERE name = '"..player:GetName().."';")
			elseif amount:GetColumn(4):GetString() == "1" then
				player:SendBroadcastMessage("You have already recieved the reward!")
			elseif count ~= 3 then
				player:SendBroadcastMessage("You have not completed all three courses yet!")
			end
		end
		player:GossipComplete()
	elseif (intid == 245) then
		player:GossipComplete()
		player:_CreateTaxi()
		player:_AddPathNode(0, -7458, -1281, 482.8)
		player:_AddPathNode(0, -7480, -1366, 445)
		player:_AddPathNode(0, -7614, -1595, 245)
		player:_AddPathNode(0, -7773, -1809, 158)
		player:_AddPathNode(0, -7875, -1956, 175)
		player:_AddPathNode(0, -7988, -2288, 161)
		player:_AddPathNode(0, -8207, -2614.8, 171)
		player:_AddPathNode(0, -8312, -2716, 215)
		player:_AddPathNode(0, -8358, -2744, 192)
		player:_AddPathNode(0, -8368, -2739, 187)
		player:_StartTaxi(22471)
		--player:StartTaxi(1, 22471)
	elseif (intid == 246) then
		player:GossipComplete()
		player:_CreateTaxi()
		player:_AddPathNode(0, -7453, -1284, 489.85)
		player:_AddPathNode(0, -7351, -1335, 415)
		player:_AddPathNode(0, -7134, -1490, 357)
		player:_AddPathNode(0, -6907, -1607, 358)
		player:_AddPathNode(0, -6740, -1705, 384)
		player:_AddPathNode(0, -6723, -1726, 381)
		player:_AddPathNode(0, -6708, -1791, 346)
		player:_AddPathNode(0, -6685, -1871, 293)
		player:_AddPathNode(0, -6606, -1927, 264)
		player:_AddPathNode(0, -6499, -1947, 261)
		player:_AddPathNode(0, -6439, -1975, 284)
		player:_AddPathNode(0, -6404, -2032, 285)
		player:_AddPathNode(0, -6398, -2075, 263)
		player:_AddPathNode(0, -6398, -2075, 263)
		player:_StartTaxi(22471)		
	elseif (intid == 247) then
		player:GossipComplete()
		if player:IsInGroup() then
			player:Teleport(631, -17, 2211.45, 31)
		else
			pUnit:SendChatMessage(12,0,"You must be with a group "..player:GetName().." if you wish to face these challenges.")
		end
	elseif (intid == 248) then
		player:GossipComplete()
		player:Teleport(0, -7555, -1200, 477)
	elseif (intid == 250) then -- instances
		pUnit:GossipCreateMenu(522, player, 0)
		pUnit:GossipMenuAddItem(2, "Send me to Ellemayne (|CFF9400D3Very Easy|R)", 254, 0)
		pUnit:GossipMenuAddItem(2, "Send me to Lord Marrow (|CFF9400D3Easy|R)", 247, 0)
		pUnit:GossipMenuAddItem(2, "Send me to Putrid (|CFF4B0082Medium|R)", 603, 0)
		pUnit:GossipMenuAddItem(2, "Send me to The Deadmines (|CFF4B0082Medium|R)", 606, 0)
		pUnit:GossipMenuAddItem(2, "Send me to The Caverns of Time (|CFF4B0082Medium|R)", 608, 0)
		--pUnit:GossipMenuAddItem(2, "Send me to Archmage Argural (|CFFFF0000Hard|R)", 255, 0)
		pUnit:GossipMenuAddItem(2, "Send me to Ruins of Bael Modan (|CFFFF0000Hard (10man Raid)|R)", 607, 0)
		pUnit:GossipMenuAddItem(0, "Back.", 300, 0)
		pUnit:GossipSendMenu(player)
	elseif (intid == 251) then -- obstacle courses
		pUnit:GossipCreateMenu(522, player, 0)
		local amount = CharDBQuery("SELECT * FROM character_coursecomplete WHERE name = '"..player:GetName().."';")
		if amount ~= nil then
			local count = 0
			if amount:GetColumn(1):GetString() == "1" then
				count = count + 1
			end
			if amount:GetColumn(2):GetString() == "1" then
				count = count + 1
			end
			if amount:GetColumn(3):GetString() == "1" then
				count = count + 1
			end
			if count == 3 and amount:GetColumn(4):GetString() == "0" then
				pUnit:GossipMenuAddItem(4, "You have completed "..count.."/3 of the courses. Click here for a reward.", 2, 0)
			else
				pUnit:GossipMenuAddItem(4, "You have completed "..count.."/3 of the courses.", 2, 0)
			end
		else
			pUnit:GossipMenuAddItem(4, "You have completed 0/3 of the courses.", 2, 0)
		end
		pUnit:GossipMenuAddItem(2, "Send me to the Maze (|CFF9400D3Easy|R)", 256, 0)
		pUnit:GossipMenuAddItem(2, "Send me to the Maze (|CFF4B0082Medium|R)", 257, 0)
		pUnit:GossipMenuAddItem(2, "Send me to the Maze (|CFFFF0000Hard|R)", 258, 0)
		pUnit:GossipMenuAddItem(2, "Send me to the Maze (|cff000088Hourly|r)", 259, 0)
		pUnit:GossipMenuAddItem(0, "Back.", 300, 0)
		pUnit:GossipSendMenu(player)
	elseif (intid == 252) then -- races
		pUnit:GossipCreateMenu(522, player, 0)
		pUnit:GossipMenuAddItem(2, "Dorfus. (Unlocks 100% Mount - |CFFFF0000Very Hard|R)", 253, 0)
		pUnit:GossipMenuAddItem(0, "Back.", 300, 0)
		pUnit:GossipSendMenu(player)
	elseif (intid == 253) then -- dorfus race
		player:GossipComplete()
		player:Teleport(0, -7797, -1153, 213)
	elseif (intid == 254) then -- ellemayne
		player:GossipComplete()
		if player:IsInGroup() then
			player:Teleport(631, -549, 2211, 540)
		else
			pUnit:SendChatMessage(12,0,"You must be with a group "..player:GetName()..", if you wish to face these challenges.")
		end
	elseif (intid == 255) then -- Argural
		player:GossipComplete()
		if player:IsInGroup() then
			player:Teleport(631, 4494.65, 2769.25, 404)
		else
			pUnit:SendChatMessage(12,0,"You must be with a group "..player:GetName()..", if you wish to face these challenges.")
		end	
	elseif (intid == 256) then -- Easy Maze
		player:GossipComplete()
		if player:HasItem(13815) ~= true then player:AddItem(13815, 1) end
		player:Teleport(13, -6, -11, -144)
	elseif (intid == 257) then -- Medium Maze
		player:GossipComplete()
		if player:HasItem(13815) ~= true then player:AddItem(13815, 1) end
		player:Teleport(13, -30, -63, -134)
	elseif (intid == 258) then -- Hard Maze
		player:GossipComplete()
		if player:HasItem(13815) ~= true then player:AddItem(13815, 1) end
		player:Teleport(13, 305, -404, -423)
	elseif (intid == 259) then --Hourly Maze
		player:GossipComplete()
		if (mazeInfo.generating) then
			pUnit:SendChatMessageToPlayer(12, 0, "A new maze is being generated, please wait a few seconds.", player)
		else
			if (not player:HasItem(13815)) then player:AddItem(13815, 1); end
			local x = mazeInfo.mazeStart[1]
			local y = mazeInfo.mazeStart[2]
			local z = mazeInfo.mazeStart[3]
			player:Teleport(13, x, y, z)
		end
	elseif (intid == 260) then -- Stonewatch
		player:_CreateTaxi()
		player:_AddPathNode(0,-7458.630371, -1293.626709, 470.061707)
		player:_AddPathNode(0,-7516.928711, -1414.140991, 436.686279)
		player:_AddPathNode(0,-7715.451660, -1518.654053, 278.783997)
		player:_AddPathNode(0,-7832.617676, -1576.310547, 172.626465)
		player:_AddPathNode(0,-7881.160645, -1681.575684, 158.794540)
		player:_AddPathNode(0,-7871.496094, -1824.439697, 151.464493)
		player:_AddPathNode(0,-7911.747070, -1916.582031, 154.859451)
		player:_AddPathNode(0,-7899.254883, -2090.159424, 161.357330)
		player:_AddPathNode(0,-7957.317871, -2259.862305, 159.869980)
		--player:_AddPathNode(0,-8110.579102, -2384.270264, 166.566772)
		player:_AddPathNode(0,-8258.665039, -2479.799072, 174.502884)
		player:_AddPathNode(0,-8351.740234, -2526.649902, 156.691925)
		player:_AddPathNode(0,-8507.270508, -2554.209961, 181.384171)
		player:_AddPathNode(0,-8625.625977, -2563.982666, 180.163208)
		player:_AddPathNode(0,-8876.421875, -2585.375244, 184.883041)
		player:_AddPathNode(0,-9067.831055, -2618.899902, 141.782883)
		player:_AddPathNode(0,-9170.679688, -2738.707520, 171.089371)
		player:_AddPathNode(0,-9207.382813, -2857.506104, 184.368240)
		player:_AddPathNode(0,-9271.178711, -2955.801758, 164.516144)
		player:_AddPathNode(0,-9330.302734, -3011.820801, 150.681061)
		player:_AddPathNode(0,-9376.573242, -3012.984863, 140.102814)
		player:_AddPathNode(0,-9398.026367, -3015.658691, 136.687576)
		player:_StartTaxi(22471)
		player:GossipComplete()
	elseif (intid == 261) then
		player:GossipComplete()
		player:Teleport(0, -13260, 165, 36) -- Arena
	elseif (intid == 300) then -- reset
		SetupDefaultMenu(pUnit, player)
	elseif (intid == 600) then
		pUnit:GossipCreateMenu(522, player, 0)
		pUnit:GossipMenuAddItem(2, "Send me to the challenge to unlock level 20 spells.", 601, 0)
		pUnit:GossipMenuAddItem(2, "Send me to the challenge to gain more gold.", 604, 0)
		pUnit:GossipMenuAddItem(0, "Back.", 300, 0)
		pUnit:GossipSendMenu(player)
	elseif (intid == 601) then
		player:GossipComplete()
		player:Teleport(668, 5256.2, 1951.7, 708) -- level 20 spells
	elseif (intid == 603) then -- putrid
		player:GossipComplete()
		if player:IsInGroup() then
			player:Teleport(631, 4353.15, 2893.2, 352)
		else
			pUnit:SendChatMessage(12,0,"You must be with a group "..player:GetName()..", if you wish to face these challenges.")
		end	
	elseif (intid == 604) then -- gold challenge
		player:GossipComplete()
		player:Teleport(289, 152.8, 155.5, 94)
	elseif (intid == 605) then -- badlands
		player:GossipComplete()
		player:_CreateTaxi()
		player:_AddPathNode(0, -7452.461914, -1279.253052, 475.036102)
		player:_AddPathNode(0, -7401.180176, -1381.382690, 436.007843)
		player:_AddPathNode(0, -7337.440918, -1546.127197, 374.017456)
		player:_AddPathNode(0, -7289.967285, -1581.487305, 351.656464)
		player:_AddPathNode(0, -7112.109863, -1635.970215, 280.772186)
		player:_AddPathNode(0, -6955.700195, -1752.625732, 257.138550)
		player:_AddPathNode(0, -6904.156250, -1843.487183, 265.313293)
		player:_AddPathNode(0, -6923.511719, -1934.474243, 311.055481)
		player:_AddPathNode(0, -6941.145996, -2034.799805, 316.724182)
		player:_AddPathNode(0, -6913.185059, -2153.158936, 302.866302)
		player:_AddPathNode(0, -6841.178223, -2201.752930, 294.085480)
		player:_AddPathNode(0, -6727.727539, -2188.852539, 266.377655)
		player:_AddPathNode(0, -6642.717285, -2189.419678, 250.487381)
		player:_AddPathNode(0, -6630.423828, -2177.915771, 244.143723)
		player:_StartTaxi(22471)
	elseif (intid == 606) then -- the deadmines
		player:GossipComplete()
		player:_CreateTaxi()
		player:_AddPathNode(0, -7463.636719, -1274.373047, 479.581116)
		player:_AddPathNode(0, -7464.694336, -1308.647949, 461.404480)
		player:_AddPathNode(0, -7489.122559, -1366.995605, 426.845154)
		player:_AddPathNode(0, -7510.297363, -1392.863770, 403.755951)
		player:_AddPathNode(0, -7552.342773, -1416.759277, 361.307251)
		player:_AddPathNode(0, -7579.522461, -1428.126953, 332.810303)
		player:_AddPathNode(0, -7612.564941, -1487.073853, 280.625641)
		player:_AddPathNode(0, -7628.167480, -1571.151245, 242.701492)
		player:_AddPathNode(0, -7694.015137, -1658.088257, 213.464844)
		player:_AddPathNode(0, -7772.010742, -1712.799438, 183.781189)
		player:_AddPathNode(0, -7824.804688, -1768.863647, 163.590866)
		player:_AddPathNode(0, -7867.633789, -1835.640869, 155.435303)
		player:_AddPathNode(0, -7930.884277, -1892.415649, 153.580994)
		player:_AddPathNode(0, -7991.332031, -1930.598145, 157.633179)
		player:_AddPathNode(0, -8038.231445, -1999.490234, 155.799667)
		player:_AddPathNode(0, -8086.368164, -2070.814941, 155.670273)
		player:_AddPathNode(0, -8155.501465, -2149.115967, 162.308044)
		player:_AddPathNode(0, -8187.687988, -2240.116211, 160.901520)
		player:_AddPathNode(0, -8210.262695, -2306.097412, 171.055161)
		player:_AddPathNode(0, -8259.286133, -2365.641602, 191.655334)
		player:_AddPathNode(0, -8295.119141, -2405.903076, 208.561630)
		player:_AddPathNode(0, -8333.682617, -2433.453125, 215.871796)
		player:_AddPathNode(0, -8371.666992, -2465.311768, 208.79016)
		player:_AddPathNode(0, -8407.600586, -2489.906250, 185.797607)
		player:_AddPathNode(0, -8432.899414, -2527.848389, 167.658722)
		player:_AddPathNode(0, -8443.202148, -2537.594727, 164.683685)
		player:_AddPathNode(0, -8490.830078, -2552.589844, 158.987320)
		player:_AddPathNode(0, -8555.571289, -2562.418213, 186.565659)
		player:_AddPathNode(0, -8597.696289, -2563.251709, 189.867036)
		player:_AddPathNode(0, -8625.860352, -2564.713867, 177.940552)
		player:_AddPathNode(0, -8659.062500, -2570.459961, 165.329468)
		player:_AddPathNode(0, -8683.435547, -2574.651123, 159.799316)
		player:_AddPathNode(0, -8783.204102, -2576.753906, 154.764481)
		player:_AddPathNode(0, -8863.123047, -2575.249268, 152.319061)
		player:_AddPathNode(0, -8900.568359, -2584.055176, 149.241745)
		player:_AddPathNode(0, -8948.548828, -2596.279297, 144.701538)
		player:_AddPathNode(0, -9006.747070, -2591.479980, 142.755539)
		player:_AddPathNode(0, -9061.811523, -2556.872070, 141.827240)
		player:_AddPathNode(0, -9104.260742, -2515.048828, 134.952423)
		player:_AddPathNode(0, -9159.692383, -2476.515625, 126.369720)
		player:_AddPathNode(0, -9206.531250, -2482.147949, 121.409660)
		player:_AddPathNode(0, -9263.620117, -2499.369141, 114.932167)
		player:_AddPathNode(0, -9302.340820, -2508.632813, 111.530128)
		player:_AddPathNode(0, -9356.832031, -2509.668213, 108.867508)
		player:_AddPathNode(0, -9392.773438, -2502.654541, 109.588821)
		player:_AddPathNode(0, -9452.526367, -2486.315918, 112.997955)
		player:_AddPathNode(0, -9523.209961, -2466.983398, 117.327965)
		player:_AddPathNode(0, -9596.257813, -2440.535645, 136.298035)
		player:_AddPathNode(0, -9687.800781, -2375.750488, 144.650070)
		player:_AddPathNode(0, -9700.712891, -2342.335693, 140.914658)
		player:_AddPathNode(0, -9710.919922, -2261.829102, 127.723969)
		player:_AddPathNode(0, -9728.268555, -2196.109131, 116.536911)
		player:_AddPathNode(0, -9766.100586, -2174.716553, 125.370155)
		player:_AddPathNode(0, -9836.239258, -2155.136719, 156.175842)
		player:_AddPathNode(0, -9868.801758, -2130.563965, 173.249985)
		player:_AddPathNode(0, -9885.630859, -2082.204834, 158.418854)
		player:_AddPathNode(0, -9897.449219, -1997.315308, 129.577423)
		player:_AddPathNode(0, -9897.449219, -1997.315308, 129.577423)
		player:_AddPathNode(0, -9883.068359, -1924.843628, 93.938774)
		player:_AddPathNode(0, -9868.711914, -1849.871094, 55.993473)
		player:_AddPathNode(0, -9886.864258, -1777.407959, 42.928913)
		player:_AddPathNode(0, -9919.897461, -1701.776733, 53.774677)
		player:_AddPathNode(0, -9982.130859, -1611.981445, 61.769455)
		player:_AddPathNode(0, -10029.933594, -1563.226074, 94.810692)
		player:_AddPathNode(0, -10057.183594, -1531.929077, 100.651192)
		player:_AddPathNode(0, -10096.208008, -1409.629150, 97.762878)
		player:_AddPathNode(0, -10110.319336, -1351.336426, 96.435417)
		player:_AddPathNode(0, -10131.363281, -1306.850220, 90.444099)
		player:_AddPathNode(0, -10167.771484, -1259.643066, 85.312943)
		player:_AddPathNode(0, -10210.564453, -1218.181519, 78.261559)
		player:_AddPathNode(0, -10271.651367, -1171.444336, 66.845184)
		player:_AddPathNode(0, -10325.280273, -1150.715942, 56.874546)
		player:_AddPathNode(0, -10408.930664, -1140.124634, 43.866093)
		player:_AddPathNode(0, -10460.778320, -1179.822144, 31.070591)
		player:_AddPathNode(0, -10506.004883, -1185.933350, 32.717106)
		player:_AddPathNode(0, -10568.238281, -1178.242065, 39.014950)
		player:_AddPathNode(0, -10619.875000, -1185.957520, 40.065113)
		player:_AddPathNode(0, -10688.471680, -1186.771606, 36.509895)
		player:_AddPathNode(0, -10716.261719, -1164.304321, 37.701088)
		player:_AddPathNode(0, -10751.948242, -1133.041382, 36.426483)
		player:_AddPathNode(0, -10774.351563, -1098.619629, 41.450890)
		player:_AddPathNode(0, -10796.779297, -1047.074585, 52.210907)
		player:_AddPathNode(0, -10819.444336, -1037.153320, 57.871368)
		player:_AddPathNode(0, -10848.368164, -1061.535278, 75.642891)
		player:_AddPathNode(0, -10880.451172, -1099.110107, 88.905479)
		player:_AddPathNode(0, -10932.456055, -1114.435547, 73.162491)
		player:_AddPathNode(0, -10960.495117, -1118.726685, 47.151787)
		player:_AddPathNode(0, -11011.892578, -1122.432251, 43.182030)
		player:_AddPathNode(0, -11039.572266, -1143.465942, 39.810349)
		player:_StartTaxi(22471)
	elseif (intid == 607) then -- un goro
		player:GossipComplete()
		player:_CreateTaxi()
		player:_AddPathNode(0, -7456.188477, -1275.544678, 478.891632)
		player:_AddPathNode(0, -7416.223633, -1285.104858, 492.391907)
		player:_AddPathNode(0, -7379.153320, -1249.862793, 510.266418)
		player:_AddPathNode(0, -7375.669922, -1158.937256, 542.404724)
		player:_AddPathNode(0, -7423.099609, -1150.380859, 565.697876)
		player:_AddPathNode(0, -7467.565918, -1196.141479, 613.255493)
		player:_AddPathNode(0, -7528.422363, -1207.703003, 670.156311)
		player:_AddPathNode(0, -7566.945801, -1169.380127, 715.095703)
		player:_AddPathNode(0, -7585.255859, -1113.917847, 765.604553)
		player:_AddPathNode(0, -7574.227539, -1068.529297, 806.634888)
		player:_AddPathNode(0, -7520.676270, -1041.801758, 863.759521)
		player:_AddPathNode(0, -7480.806641, -1049.804077, 905.780334)
		player:_AddPathNode(0, -7464.213867, -1081.040039, 920.198120)
		player:_AddPathNode(1, -6060.316406, -1608.036743, -1.625588)
		player:_AddPathNode(1, -6129.775879, -1582.982788, -71.416840)
		player:_AddPathNode(1, -6186.796875, -1551.467773, -120.790573)
		player:_AddPathNode(1, -6269.976563, -1468.298828, -172.041931)
		player:_AddPathNode(1, -6295.333984, -1389.559326, -194.389664)
		player:_AddPathNode(1, -6254.661133, -1338.681885, -176.488693)
		player:_AddPathNode(1, -6210.280273, -1318.974243, -158.958176)
		player:_AddPathNode(1, -6196.323730, -1273.001343, -150.077255)
		player:_AddPathNode(1, -6186.188965, -1237.826416, -162.571457)
		player:_StartTaxi(22471)
	elseif (intid == 608) then -- CoT
		player:GossipComplete()
		if player:IsInGroup() then
			player:_CreateTaxi()
			player:_AddPathNode(0, -7454.117188, -1278.820801, 467.601593)
			player:_AddPathNode(0, -7413.652344, -1363.966553, 459.075684)
			player:_AddPathNode(0, -7382.563477, -1616.530640, 414.038666)
			player:_AddPathNode(0, -7335.003418, -1799.342407, 401.818542)
			player:_AddPathNode(0, -7277.388672, -1931.441040, 385.638184)
			player:_AddPathNode(0, -7259.562988, -2055.602783, 387.358063)
			player:_AddPathNode(0, -7239.514648, -2208.848633, 340.740997)
			player:_AddPathNode(0, -7214.888672, -2356.868896, 304.248291)
			player:_AddPathNode(0, -7200.654785, -2520.139404, 287.902893)
			player:_AddPathNode(0, -7133.326172, -2664.932129, 274.536407)
			player:_AddPathNode(0, -7024.989746, -2822.388672, 278.912872)
			player:_AddPathNode(0, -7040.900391, -2978.659180, 280.675323)
			player:_AddPathNode(0, -7064.324219, -3136.495117, 279.547607)
			player:_AddPathNode(0, -7045.019043, -3327.999512, 278.179382)
			player:_AddPathNode(0, -6934.642090, -3473.206787, 276.903687)
			player:_AddPathNode(0, -6798.005859, -3544.574463, 275.821930)
			player:_AddPathNode(0, -6748.133789, -3678.765381, 274.675323)
			player:_AddPathNode(0, -6763.777832, -3785.127686, 292.044006)
			player:_AddPathNode(0, -6884.763184, -3888.282959, 322.270111)
			player:_AddPathNode(0, -6911.725586, -4008.990479, 321.345734)
			player:_AddPathNode(0, -6806.494629, -4080.625244, 306.014343)
			player:_AddPathNode(0, -6717.780273, -4106.905762, 276.888184)
			player:_AddPathNode(309, -10786.522461, -1696.541870, 152.510544)
			player:_AddPathNode(309, -10799.827148, -1694.959961, 148.224823)
			player:_StartTaxi(22471)
		else
			pUnit:SendChatMessage(12,0,"You must be with a group "..player:GetName().." if you wish to face these challenges.")
		end
	elseif (intid == 609) then -- Race track
		player:GossipComplete()
		player:_CreateTaxi()
		player:_AddPathNode(0, -7468.852051, -1264.741333, 477.960449)
		player:_AddPathNode(0, -7457.249023, -1289.179199, 477.949951)
		player:_AddPathNode(0, -7400.896484, -1445.037598, 437.573120)
		player:_AddPathNode(0, -7344.703125, -1641.953247, 394.928986)
		player:_AddPathNode(0, -7306.729004, -1748.589600, 387.642090)
		player:_AddPathNode(0, -7151.328125, -1904.313477, 400.125000)
		player:_AddPathNode(0, -7040.641602, -1985.946289, 425.990845)
		player:_AddPathNode(0, -6923.708984, -2101.247559, 396.821289)
		player:_AddPathNode(0, -6800.265137, -2184.661377, 353.566132)
		player:_AddPathNode(0, -6627.541992, -2307.412109, 322.767273)
		player:_AddPathNode(0, -6598.472168, -2462.679932, 312.128296)
		player:_AddPathNode(0, -6624.592773, -2661.993408, 306.501648)
		player:_AddPathNode(0, -6628.816406, -2849.059082, 302.046265)
		player:_AddPathNode(0, -6558.449707, -3011.414063, 310.594727)
		player:_AddPathNode(0, -6488.845215, -3090.915527, 346.062317)
		player:_AddPathNode(0, -6399.859375, -3160.407959, 358.913971)
		player:_AddPathNode(0, -6281.733398, -3312.828369, 358.996185)
		player:_AddPathNode(0, -6144.571289, -3397.494629, 377.420349)
		player:_AddPathNode(0, -5989.255859, -3484.670898, 396.812897)
		player:_AddPathNode(0, -5873.927734, -3664.520996, 417.829468)
		player:_AddPathNode(0, -5782.835938, -3817.822998, 402.283051)
		player:_AddPathNode(0, -5696.945313, -3986.332520, 379.846558)
		player:_AddPathNode(0, -5674.418945, -4137.013184, 465.362366)
		player:_AddPathNode(0, -5700.093262, -4336.089355, 519.844788)
		player:_AddPathNode(0, -5751.889160, -4459.952148, 579.157776)
		player:_AddPathNode(0, -5845.018555, -4570.776855, 484.786255)
		player:_AddPathNode(0, -5973.581543, -4573.522461, 345.151611)
		player:_AddPathNode(0, -6084.203125, -4687.557129, 237.826965)
		player:_AddPathNode(0, -5978.341309, -4855.449219, 150.650757)
		player:_AddPathNode(0, -5861.840332, -5011.950684, 60.596672)
		player:_AddPathNode(0, -5816.614746, -5195.908203, 43.210789)
		player:_AddPathNode(0, -5831.111328, -5339.157227, 35.122414)
		player:_AddPathNode(0, -5819.395020, -5487.485840, 26.814898)
		player:_AddPathNode(1, -6528.198730, -3224.245605, 106.717232)
		player:_AddPathNode(1, -6501.242188, -3335.623535, 32.661839)
		player:_AddPathNode(1, -6463.223145, -3466.655518, -43.891991)
		player:_AddPathNode(1, -6412.630371, -3579.670410, -53.066414)
		player:_AddPathNode(1, -6343.777832, -3759.115723, -29.496117)
		player:_AddPathNode(1, -6287.193848, -3900.032959, -29.609606)
		player:_AddPathNode(1, -6203.552734, -3952.339111, -46.271461)
		player:_AddPathNode(1, -6175.580078, -3961.171387, -58.749947)
		player:_StartTaxi(22471)
	elseif (intid == 610) then
		player:GossipComplete()
		player:_CreateTaxi()	
		for i=0,40 do -- 6*40 = 240, 255 is limit of nodes
			player:_AddPathNode(0, -7453.038574, -1295.917847, 474.934662)
			player:_AddPathNode(0, -7385.471680, -1274.333252, 465.032532)
			player:_AddPathNode(0, -7323.378418, -1304.757324, 461.038391)
			player:_AddPathNode(0, -7369.495117, -1407.055542, 463.528290)
			player:_AddPathNode(0, -7463.610840, -1422.054810, 463.037506)
			player:_AddPathNode(0, -7505.300293, -1355.631470, 482.140961)
		end
		player:_AddPathNode(0, -7479, -1252, 478)
		player:_StartTaxi(22471)
	elseif (intid == 800) then -- Quest areas
		pUnit:GossipCreateMenu(522, player, 0)
		local race = player:GetPlayerRace()
		if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then -- alliance
			pUnit:GossipMenuAddItem(2, "Take me to Morgan's Vigal.", 245, 0)
		else -- horde
			pUnit:GossipMenuAddItem(2, "Take me to Stonewrought Pass.", 246, 0)
		end
		if (player:HasQuest(3000) or player:HasFinishedQuest(3000)) then
			pUnit:GossipMenuAddItem(2, "Take me to Stonewatch.", 260, 0)
		end
		if (player:HasQuest(6500) or player:HasFinishedQuest(6500)) then
			pUnit:GossipMenuAddItem(2, "Take me to Kargath.", 605, 0)
		end
		pUnit:GossipMenuAddItem(2, "Take me to the Race Track.", 609, 0)
		if (player:HasQuest(9029) or player:HasFinishedQuest(9029)) then
			pUnit:GossipMenuAddItem(2, "Take me to Durbra'Jin.", 801, 0)
		end
		pUnit:GossipMenuAddItem(0, "Back.", 300, 0)
		pUnit:GossipSendMenu(player)
	elseif (intid == 801) then
		player:GossipComplete()
		player:_CreateTaxi()
		player:_AddPathNode(0, -7451.642090, -1290.051147, 487.901825)
		player:_AddPathNode(0, -7385.988281, -1303.098877, 472.502747)
		player:_AddPathNode(0, -7291.516602, -1259.046875, 454.916473)
		player:_AddPathNode(0, -7198.766113, -1097.211426, 424.193176)
		player:_AddPathNode(0, -7100.669922, -951.920837, 432.234955)
		player:_AddPathNode(0, -7010.098145, -867.015198, 441.456390)
		player:_AddPathNode(571, 7145.604492, -5172.616699, 605.837952)
		player:_AddPathNode(571, 7013.651367, -4938.669922, 579.631470)
		player:_AddPathNode(571, 6925.617188, -4769.840332, 560.123169)
		player:_AddPathNode(571, 6911.307617, -4600.047852, 536.941772)
		player:_AddPathNode(571, 7025.512695, -4408.654785, 507.455963)
		player:_AddPathNode(571, 7029.311035, -4276.453125, 487.732483)
		player:_AddPathNode(571, 6957.608398, -4200.932617, 514.499878)
		player:_AddPathNode(571, 6926.305176, -4131.512695, 486.698120)
		player:_AddPathNode(571, 6902.274902, -4113.625488, 469.701813)
		player:_AddPathNode(571, 6893.782227, -4117.492188, 467.353149)
		player:_StartTaxi(22471)
	end
end

RegisterUnitGossipEvent(60010, 1, "FlightMaster_OnClick")
RegisterUnitGossipEvent(60010, 2, "FlightMaster_OnGossip")

function arenaflightclick(pUnit, event, player)
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(2, "Transport me to Blackrock Mountain.", 2, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 1, 0)
	pUnit:GossipSendMenu(player)
end

function arenaflightgossip(pUnit, event, player, id, intid, code)
	if (intid == 2) then
		player:Teleport(0, -7478, -1252, 478)
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(191191, 1, "arenaflightclick")
RegisterUnitGossipEvent(191191, 2, "arenaflightgossip")


