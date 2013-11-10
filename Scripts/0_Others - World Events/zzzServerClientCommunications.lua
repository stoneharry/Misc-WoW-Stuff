local _ln = 0

function Tuskarr_OnChat(event, plr, message, mtype, language)
	if message and plr then
		if string.find(message, "[CU-ADDON]", 1, true) or string.find(message, "[EoC-Addon]", 1, true) then
			if mtype == 7 then -- whisper
				if message == "[CU-ADDON] JoinAlliance" then
					plr:CastSpell(11)
					plr:SendBroadcastMessage("You selected Alliance.")
					plr:SendBroadcastMessage("|cFFFF0000Cutscene showing Tuskarr leaving the isle via ship.")
					return false;
				elseif message == "[CU-ADDON] JoinHorde" then
					plr:CastSpell(11)
					plr:SendBroadcastMessage("|cFFFF0000Cutscene showing Tuskarr leaving the isle via ship.")
					plr:SendBroadcastMessage("You selected Horde.")
					return false;
				end
				-- flight path
				-- [CU-ADDON] TakeTaxi : "..tostring(self:GetID())
				local nums = scen_split_2(message)
				if #nums > 4 then
					TransmogItem(nums[3], nums[4], nums[5], plr)
					return false
				else
					nums = scen_split(message)
					if #nums == 1 then
						if nums[1] == "1" then
							flyToMallFromSomewhere(plr)
						elseif nums[1] == "2" or nums[1] == "3" or nums[1] == "4"  or nums[1] == "5" then
							takeFlightPathFromMall(plr, tonumber(nums[1]))
						elseif nums[1] == "6" then -- Stromgardeguy, localize this..
							StormgardetoSilverpine(plr, 1)
						elseif nums[1] == "7" then
							StormgardeToArathi(plr, 1) -- alliance
						elseif nums[1] == "8" then
							StormgardetoSilverpine(plr, 2)
						elseif nums[1] == "9" then
							StormgardeToArathi(plr, 2) -- horde
							elseif nums[1] == "10" then
							plr:Teleport(1,4689.21,-3752.62,946.16)
							elseif nums[1] == "11" then
							plr:Teleport(1,5002.70,-1466.42,1327.94)
								elseif nums[1] == "12" then
							plr:Teleport(1,6783.47,-4661.44,723.31)
								elseif nums[1] == "13" then
							plr:Teleport(1,6550.95,-5097.54,773.48)
							elseif nums[1] == "15" then -- peaks to stromgarde
							plr:Teleport(0,-1651.50,-1776.10,80.100)
						end
						return false;
					end
				end
			end
		end
		-- debug, faction choosing
		if message == "#faction" then
			plr:SendBroadcastMessage("[CU-ADDON] OpenMenuFactionChoose")
			return false
		elseif message == "#memory" then
			plr:SendBroadcastMessage("The scripting engine is using "..tostring((collectgarbage("count")*1024)/1000000).. " MB memory.")
			return false
		elseif message == "#unstuck" then
			if ClickPrevent[plr:GetName()] == "clicked" and ((os.clock()-CooldownTime[plr:GetName()])) <= 60 then
				plr:SendAreaTriggerMessage("|cFFFF0000You can not use this yet. Please try again in a few minutes.")
			else
				ClickPrevent[plr:GetName()] = "clicked"
				CooldownTime[plr:GetName()] = os.clock()
				plr:SetHealth(1)
				plr:CastSpell(11)
				plr:Kill(plr)
			end
			return false
		elseif message == "#debug" then
			plr:SetPlayerLock(false)
			plr:Dismount()
			plr:Land()
			plr:SetPhase(1)
			if plr:HasAura(68085) then
				plr:RemoveAura(68085)
			end
			return false
		elseif message == "[EoC-Addon] HungerGamesOpen" or message == "[EoC-Addon] TESTTESTTEST" or message == "[EoC-Addon] OpenTransmog" then
			if plr:GetName() ~= "Stoneharry" then
				plr:SoftDisconnect()
				return false
			end
		elseif message == "#test" then
			if not plr:IsGm() then
				return true
			end
			-- get item slot = 15
			-- off hand = 16
			local t = plr:GetSelection()
			if not t or not t:IsPlayer() then
				t = plr
			end
			local E = {3789, 3854, 3273, 3225, 3870, 1899, 2674, 2675, 2671, 2672, 3365, 2673, 2343, 425, 3855, 1894, 1103, 1898, 3345, 1743, 3093, 1900, 3846, 1606, 283, 1, 3265, 2, 3, 3266, 1903, 13, 26, 7, 803, 1896, 2666, 25}
			_ln = _ln + 1
			if _ln > #E then
				_ln = 1
			end
			t:SetUInt32Value(284 + (15 * 2), E[_ln])
			plr:SendBroadcastMessage("You changed "..t:GetName().."'s weapon enchant to: "..tostring(E[_ln])..".")
			return false
		elseif message == "#despawn" then
			if not plr:IsGm() then
				return true
			end
			local t = plr:GetSelection()
			if not t then
				return
			end
			if t:IsPlayer() then
				return
			end
			t:Despawn(1,0)
			return false
		elseif message == "#harry" then
			if not plr:IsGm() then
				return true
			end
			local x,y,z,o = plr:GetX(), plr:GetY(), plr:GetZ()-1, plr:GetO()
			local stop = 0
			CreateLuaEvent(function() x = x + 0.8; z = z + 0.3; o = o + 0.03; plr:SpawnGameObject(3260603, x,y,z,o, 5000, 100); end, 100, 60000/100)
			return false
		end
		--[[if message == "#camera" then
			plr:SendCinematic(252)
			return false
		end]]
	end
end

local taxi_path_five =
{
	{-7441, -1288, 475},
	{-7100, -1264, 420},
	{-6818, -1248, 289},
	{-6542, -1174, 368},
	{-6224, -975, 565},
	{-5043, -1175, 769},
	{-4611, -1390, 755},
	{-4123, -1596, 435},
	{-3721, -1392, 155},
	{-3236, -1459, 95},
	{-2823, -2090, 106},
	{-2827, -2417, 140},
	{-2672, -2480, 158},
	{-2508, -2500, 129},
	{-2281, -2503, 112},
	{-2076, -2477, 95},
	{-1865, -2381, 77},
	{-1714, -2257, 127},
	{-1547, -1946, 115},
	{-1546, -1757, 106},
	{-1602, -1686, 107},
	{-1617, -1716, 110},
	{-1637, -1759, 97},
	{-1654, -1776, 80},
}

function takeFlightPathFromMall(plr, num)
	local npc = plr:GetCreatureNearestCoords(plr:GetX(), plr:GetY(), plr:GetZ(), 268421)
	if npc ~= nil then
		if num == 2 then
			--[[plr:_CreateTaxi()
			plr:_AddPathNode(0, -7468.852051, -1264.741333, 477.960449)
			plr:_AddPathNode(0, -7457.249023, -1289.179199, 477.949951)
			plr:_AddPathNode(0, -7400.896484, -1445.037598, 437.573120)
			plr:_AddPathNode(0, -7344.703125, -1641.953247, 394.928986)
			plr:_AddPathNode(0, -7306.729004, -1748.589600, 387.642090)
			plr:_AddPathNode(0, -7151.328125, -1904.313477, 400.125000)
			plr:_AddPathNode(0, -7040.641602, -1985.946289, 425.990845)
			plr:_AddPathNode(0, -6923.708984, -2101.247559, 396.821289)
			plr:_AddPathNode(0, -6800.265137, -2184.661377, 353.566132)
			plr:_AddPathNode(0, -6627.541992, -2307.412109, 322.767273)
			plr:_AddPathNode(0, -6598.472168, -2462.679932, 312.128296)
			plr:_AddPathNode(0, -6624.592773, -2661.993408, 306.501648)
			plr:_AddPathNode(0, -6628.816406, -2849.059082, 302.046265)
			plr:_AddPathNode(0, -6558.449707, -3011.414063, 310.594727)
			plr:_AddPathNode(0, -6488.845215, -3090.915527, 346.062317)
			plr:_AddPathNode(0, -6399.859375, -3160.407959, 358.913971)
			plr:_AddPathNode(0, -6281.733398, -3312.828369, 358.996185)
			plr:_AddPathNode(0, -6144.571289, -3397.494629, 377.420349)
			plr:_AddPathNode(0, -5989.255859, -3484.670898, 396.812897)
			plr:_AddPathNode(0, -5873.927734, -3664.520996, 417.829468)
			plr:_AddPathNode(0, -5782.835938, -3817.822998, 402.283051)
			plr:_AddPathNode(0, -5696.945313, -3986.332520, 379.846558)
			plr:_AddPathNode(0, -5674.418945, -4137.013184, 465.362366)
			plr:_AddPathNode(0, -5700.093262, -4336.089355, 519.844788)
			plr:_AddPathNode(0, -5751.889160, -4459.952148, 579.157776)
			plr:_AddPathNode(0, -5845.018555, -4570.776855, 484.786255)
			plr:_AddPathNode(0, -5973.581543, -4573.522461, 345.151611)
			plr:_AddPathNode(0, -6084.203125, -4687.557129, 237.826965)
			plr:_AddPathNode(0, -5978.341309, -4855.449219, 150.650757)
			plr:_AddPathNode(0, -5861.840332, -5011.950684, 60.596672)
			plr:_AddPathNode(0, -5816.614746, -5195.908203, 43.210789)
			plr:_AddPathNode(0, -5831.111328, -5339.157227, 35.122414)
			plr:_AddPathNode(0, -5819.395020, -5487.485840, 26.814898)
			plr:_AddPathNode(1, -6528.198730, -3224.245605, 106.717232)
			plr:_AddPathNode(1, -6501.242188, -3335.623535, 32.661839)
			plr:_AddPathNode(1, -6463.223145, -3466.655518, -43.891991)
			plr:_AddPathNode(1, -6412.630371, -3579.670410, -53.066414)
			plr:_AddPathNode(1, -6343.777832, -3759.115723, -29.496117)
			plr:_AddPathNode(1, -6287.193848, -3900.032959, -29.609606)
			plr:_AddPathNode(1, -6203.552734, -3952.339111, -46.271461)
			plr:_AddPathNode(1, -6175.580078, -3961.171387, -58.749947)
			plr:_StartTaxi(40104)]]
		elseif num == 3 then
			plr:_CreateTaxi()
			plr:_AddPathNode(0,-7458.630371, -1293.626709, 470.061707)
			plr:_AddPathNode(0,-7516.928711, -1414.140991, 436.686279)
			plr:_AddPathNode(0,-7715.451660, -1518.654053, 278.783997)
			plr:_AddPathNode(0,-7832.617676, -1576.310547, 172.626465)
			plr:_AddPathNode(0,-7881.160645, -1681.575684, 158.794540)
			plr:_AddPathNode(0,-7871.496094, -1824.439697, 151.464493)
			plr:_AddPathNode(0,-7911.747070, -1916.582031, 154.859451)
			plr:_AddPathNode(0,-7899.254883, -2090.159424, 161.357330)
			plr:_AddPathNode(0,-7957.317871, -2259.862305, 159.869980)
			--plr:_AddPathNode(0,-8110.579102, -2384.270264, 166.566772)
			plr:_AddPathNode(0,-8258.665039, -2479.799072, 174.502884)
			plr:_AddPathNode(0,-8351.740234, -2526.649902, 156.691925)
			plr:_AddPathNode(0,-8507.270508, -2554.209961, 181.384171)
			plr:_AddPathNode(0,-8625.625977, -2563.982666, 180.163208)
			plr:_AddPathNode(0,-8876.421875, -2585.375244, 184.883041)
			plr:_AddPathNode(0,-9067.831055, -2618.899902, 141.782883)
			plr:_AddPathNode(0,-9170.679688, -2738.707520, 171.089371)
			plr:_AddPathNode(0,-9207.382813, -2857.506104, 184.368240)
			plr:_AddPathNode(0,-9271.178711, -2955.801758, 164.516144)
			plr:_AddPathNode(0,-9330.302734, -3011.820801, 150.681061)
			plr:_AddPathNode(0,-9376.573242, -3012.984863, 140.102814)
			plr:_AddPathNode(0,-9398.026367, -3015.658691, 136.687576)
			plr:_StartTaxi(40104)
			plr:GossipComplete()
		elseif num == 4  then
			plr:_CreateTaxi()
			plr:_AddPathNode(0, -7452.461914, -1279.253052, 475.036102)
			plr:_AddPathNode(0, -7401.180176, -1381.382690, 436.007843)
			plr:_AddPathNode(0, -7337.440918, -1546.127197, 374.017456)
			plr:_AddPathNode(0, -7289.967285, -1581.487305, 351.656464)
			plr:_AddPathNode(0, -7112.109863, -1635.970215, 280.772186)
			plr:_AddPathNode(0, -6955.700195, -1752.625732, 257.138550)
			plr:_AddPathNode(0, -6904.156250, -1843.487183, 265.313293)
			plr:_AddPathNode(0, -6923.511719, -1934.474243, 311.055481)
			plr:_AddPathNode(0, -6941.145996, -2034.799805, 316.724182)
			plr:_AddPathNode(0, -6913.185059, -2153.158936, 302.866302)
			plr:_AddPathNode(0, -6841.178223, -2201.752930, 294.085480)
			plr:_AddPathNode(0, -6727.727539, -2188.852539, 266.377655)
			plr:_AddPathNode(0, -6642.717285, -2189.419678, 250.487381)
			plr:_AddPathNode(0, -6630.423828, -2177.915771, 244.143723)
			plr:_StartTaxi(40104)
		elseif num == 5 then -- stromgarde
			plr:_CreateTaxi()		
			for i=1,#taxi_path_five do
				plr:_AddPathNode(0, taxi_path_five[i][1], taxi_path_five[i][2], taxi_path_five[i][3])
			end
			plr:_StartTaxi(40104)
		end
	elseif (num == 5) then -- stormgarde
		npc = plr:GetCreatureNearestCoords(-1377, -3027, 41, 28197)
		if npc then
			plr:_CreateTaxi()		
			plr:_AddPathNode(0, -1414, -3069, 57)
			plr:_AddPathNode(0, -1530, -3001, 88)
			plr:_AddPathNode(0, -1630, -2842, 68)
			plr:_AddPathNode(0, -1594, -2430, 143)
			plr:_AddPathNode(0, -1572, -1967, 121)
			plr:_AddPathNode(0, -1626, -1835, 99)
			plr:_AddPathNode(0, -1652, -1774, 80.2)
			plr:_StartTaxi(40104)	
		end
	end
end

function flyToMallFromSomewhere(player)
	local npc = player:GetCreatureNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 60208)
	if npc then
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
	else
		npc = player:GetCreatureNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 2861)
		if npc then
			player:_CreateTaxi()
			player:_AddPathNode(0, -6646, -2187, 257)
			player:_AddPathNode(0, -6859, -2220, 307)
			player:_AddPathNode(0, -6927, -2100, 359)
			player:_AddPathNode(0, -6919, -1863, 321)
			player:_AddPathNode(0, -7108, -1532, 414)
			player:_AddPathNode(0, -7380, -1294, 465)
			player:_AddPathNode(0, -7440, -1253, 458)
			player:_AddPathNode(0, -7458, -1231, 485)
			player:_AddPathNode(0, -7477, -1252, 477.5)
			player:_AddPathNode(0, -7477, -1252, 477.5)
			player:_StartTaxi(40102)
		else
			npc = player:GetCreatureNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 29951)
			if npc then
				player:Teleport(0, -7477, -1256, 478)
			end
		end
	end
end
		
function StormgardetoSilverpine(plr, faction)
	local npc = plr:GetCreatureNearestCoords(plr:GetX(), plr:GetY(), plr:GetZ(), 29951)
	if npc ~= nil then
		plr:_CreateTaxi()
		plr:_AddPathNode(0, -1642, -1763, 108)
		plr:_AddPathNode(0, -1431, -1600, 174)
		plr:_AddPathNode(0, -1110, -1297, 185)
		plr:_AddPathNode(0, -944, -883, 185)
		plr:_AddPathNode(0, -691, -347, 185)
		plr:_AddPathNode(0, -615, 248, 185)
		plr:_AddPathNode(0, -541, 684, 185)
		if faction == 1 then
			plr:_AddPathNode(0, -395, 799, 123)
			plr:_AddPathNode(0, -175, 871, 92)
			plr:_AddPathNode(0, -129, 842, 78)
			plr:_AddPathNode(0, -110, 823, 63.8)
		else
			plr:_AddPathNode(0, -511, 945, 165)
			plr:_AddPathNode(0, -482, 1120, 113)
			plr:_AddPathNode(0, -303, 1198, 98)
			plr:_AddPathNode(0, -43, 1175, 104)
			plr:_AddPathNode(0, 242, 1273, 95)
			plr:_AddPathNode(0, 524, 1363, 190)
			plr:_AddPathNode(0, 548, 1424, 160)
			plr:_AddPathNode(0, 501, 1525, 128)
		end
		plr:_StartTaxi(40104)
	end
end

function StormgardeToArathi(plr, faction)
	local npc = plr:GetCreatureNearestCoords(plr:GetX(), plr:GetY(), plr:GetZ(), 29951)
	if npc ~= nil then
		plr:_CreateTaxi()
		if faction == 1 then
			plr:_AddPathNode(0, -1639, -1808, 98)
			plr:_AddPathNode(0, -1476, -1820, 105)
			plr:_AddPathNode(0, -1388, -1877, 105)
			plr:_AddPathNode(0, -1273, -2222, 105)
			plr:_AddPathNode(0, -1185, -2416, 105)
			plr:_AddPathNode(0, -1216, -2510, 77)
			plr:_AddPathNode(0, -1256, -2535, 41)
			plr:_AddPathNode(0, -1245, -2505, 21.8)
		else
			plr:_AddPathNode(0, -1620, -1825, 125)
			plr:_AddPathNode(0, -1440, -2237, 177)
			plr:_AddPathNode(0, -1474, -2562, 174)
			plr:_AddPathNode(0, -1458, -2767, 158)
			plr:_AddPathNode(0, -1368, -2991, 89)
			plr:_AddPathNode(0, -1393, -3224, 90)
			plr:_AddPathNode(0, -1369, -3306, 69)
			plr:_AddPathNode(0, -1080, -3390, 122)
			plr:_AddPathNode(0, -965, -3458, 92)
			plr:_AddPathNode(0, -913, -3489, 70.5)
		end
		plr:_StartTaxi(40104)
	end
end

-- This function is used to get the numbers from the flight path message
function scen_split(str)
	local b = {}
	local c = 1
	local d = {}
	string.gsub(str, "[%d]", function(a)
		if (a == "-") then
			c = c + 1
		else
			if (not b[c]) then
				b[c] = {}
			end
			table.insert(b[c], a)
		end
	end)
	for k, v in pairs (b) do
		table.insert(d, table.concat(v))
	end
	return d
end

function scen_split_2(str)
	local b = {}
	local c = 1
	local d = {}
	string.gsub(str, "[%w%s-]", function(a)
		if (a == "-") then
			c = c + 1
		else
			if (not b[c]) then
				b[c] = {}
			end
			table.insert(b[c], a)
		end
	end)
	for k, v in pairs (b) do
		table.insert(d, table.concat(v))
	end
	return d
end

RegisterServerHook(16, "Tuskarr_OnChat")
