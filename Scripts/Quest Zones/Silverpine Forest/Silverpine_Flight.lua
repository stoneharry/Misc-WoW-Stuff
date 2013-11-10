local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

function Pyrewood_Flightmaster_Main(pUnit, event, player)
	pUnit:GossipCreateMenu(7778, player, 0)
	local team = player:GetTeam() + 1
	local txt = team == 1 and "Ambermill." or "The Sepulcher."
	pUnit:GossipMenuAddItem(2, txt, team, 0)
	pUnit:GossipMenuAddItem(2, "Stromgarde.", 3, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 80, 0)
	pUnit:GossipSendMenu(player)
end

function Pyrewood_Flightmaster_Sub(pUnit, event, player, id, intid, code)
	if (intid == 1) then -- Alliance
		player:_CreateTaxi()
		player:_AddPathNode(0, -390.73, 1542.30, 16.85)
		player:_AddPathNode(0, -388.15, 1534.64, 19.92)
		player:_AddPathNode(0, -354.32, 1453.24, 30.90)
		player:_AddPathNode(0, -350.32, 1421.54, 32.003807)
		player:_AddPathNode(0, -341.047, 1387.57, 42.99)
		player:_AddPathNode(0, -273.25, 1186.17, 90.92)
		player:_AddPathNode(0, -139.55, 1122.79, 89.09)
		player:_AddPathNode(0, -129.63, 833.34, 81.68)
		player:_AddPathNode(0, -106.28, 829.85, 63.85)
		player:_StartTaxi(25679) -- ally taxi
	elseif (intid == 2) then -- Horde
		player:_CreateTaxi()
		player:_AddPathNode(0, -390.73, 1542.30, 16.85)
		player:_AddPathNode(0, -388.15, 1534.64, 19.92)
		player:_AddPathNode(0, -354.32, 1453.24, 30.90)
		player:_AddPathNode(0, -350.32, 1421.54, 32.003807)
		player:_AddPathNode(0, -341.047, 1387.57, 42.99)
		player:_AddPathNode(0, -89.23, 1227.23, 87.92)
		player:_AddPathNode(0, 102.01, 1230.31, 104.56)
		player:_AddPathNode(0, 399.63, 1299.76, 101.88)
		player:_AddPathNode(0, 564.08, 1373.67, 123.77)
		player:_AddPathNode(0, 513.35, 1499.92, 144.55)
		player:_AddPathNode(0, 483.74, 1529.47, 130.82)
		player:_StartTaxi(17719) 
	elseif (intid == 3) then
		player:Teleport(0, -1651, -1774, 81)
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(28674, 1, "Pyrewood_Flightmaster_Main")
RegisterUnitGossipEvent(28674, 2, "Pyrewood_Flightmaster_Sub")

function Sepulcher_Flightmaster_Main(pUnit, event, player)
	pUnit:GossipCreateMenu(7778, player, 0)
	if player:HasQuest(5504) then
		pUnit:GossipMenuAddItem(2, "Send me to Fenris Isle", 10, 0)
	end
	--pUnit:GossipMenuAddItem(2, "Pyrewood Village", 11, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 80, 0)
	pUnit:GossipSendMenu(player)
end

function Sepulcher_Flightmaster_Sub(pUnit, event, player, id, intid, code)
	if (intid == 10) then 
		player:_CreateTaxi()
		player:_AddPathNode(0, 497.98, 1518.43, 132.81)
		player:_AddPathNode(0, 663.17, 1292.80, 101.09)
		player:_AddPathNode(0, 1117.36, 101.09, 65.75)
		player:_AddPathNode(0, 1123.39, 721.29, 72.50)
		player:_AddPathNode(0, 1069.84, 720.23, 59.20)
		player:_AddPathNode(0, 1052.59, 721.45, 51.43)
		player:_StartTaxi(17719)
	elseif (intid == 11) then
		player:_CreateTaxi()
		player:_AddPathNode(0, 483.74, 1529.47, 130.82)
		player:_AddPathNode(0, 513.35, 1499.92, 144.55)
		player:_AddPathNode(0, 564.08, 1373.67, 123.77)
		player:_AddPathNode(0, 399.63, 1299.76, 101.88)
		player:_AddPathNode(0, 102.01, 1230.31, 104.56)
		player:_AddPathNode(0, -89.23, 1227.23, 87.92)
		player:_AddPathNode(0, -341.047, 1387.57, 42.99)
		player:_AddPathNode(0, -350.32, 1421.54, 32.003807)
		player:_AddPathNode(0, -354.32, 1453.24, 30.90)
		player:_AddPathNode(0, -388.15, 1534.64, 19.92)
		player:_AddPathNode(0, -390.73, 1542.30, 16.85)
		player:_StartTaxi(17719) 
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(2226, 1, "Sepulcher_Flightmaster_Main")
RegisterUnitGossipEvent(2226, 2, "Sepulcher_Flightmaster_Sub")

function Ambermill_Flightmaster_Main(pUnit, event, player)
	pUnit:GossipCreateMenu(7778, player, 0)
	if player:HasQuest(5504) then
		pUnit:GossipMenuAddItem(2, "Send me to Fenris Isle", 10, 0)
	end
	--pUnit:GossipMenuAddItem(2, "Pyrewood Village", 11, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 80, 0)
	pUnit:GossipSendMenu(player)
end

function Ambermill_Flightmaster_Sub(pUnit, event, player, id, intid, code)
	if (intid == 10) then 
		player:_CreateTaxi()
		player:_AddPathNode(0, -103.51, 825.14, 64.63)
		player:_AddPathNode(0, -94.81, 821.26, 70.09)
		player:_AddPathNode(0, -60.51, 801.42, 83.28)
		player:_AddPathNode(0, 227.79, 636.92, 102.41)
		player:_AddPathNode(0, 619.03, 702.12, 70.88)
		player:_AddPathNode(0, 703.37, 751.54, 49.30)
		player:_AddPathNode(0, 721.12, 760.79, 36.55)
		player:_StartTaxi(25679)
	elseif (intid == 11) then
		player:_CreateTaxi()
		player:_AddPathNode(0, -106.28, 829.85, 63.85)
		player:_AddPathNode(0, -129.63, 833.34, 81.68)
		player:_AddPathNode(0, -139.55,1122.79, 89.09)
		player:_AddPathNode(0, -273.25, 1186.17, 90.92)
		player:_AddPathNode(0, -341.047, 1387.57, 42.99)
		player:_AddPathNode(0, -350.32, 1421.54, 32.003807)
		player:_AddPathNode(0, -354.32, 1453.24, 30.90)
		player:_AddPathNode(0, -388.15, 1534.64, 19.92)
		player:_AddPathNode(0, -390.73, 1542.30, 16.85)
		player:_StartTaxi(25679) -- ally taxi
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(4321, 1, "Ambermill_Flightmaster_Main")
RegisterUnitGossipEvent(4321, 2, "Ambermill_Flightmaster_Sub")
