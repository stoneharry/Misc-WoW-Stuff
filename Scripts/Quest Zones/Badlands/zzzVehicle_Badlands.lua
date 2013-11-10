
local vehicle = nil
local pointPlayer = nil
local pointUnit = nil

local BadlandsInfo = {}

function BranIronbeard_Gossip(pUnit, event, player)
    pUnit:GossipCreateMenu(5914, player, 0)
	pUnit:GossipMenuAddItem(9, "Transport me to Angor Stronghold.", 11, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 3, 0)
    pUnit:GossipSendMenu(player)
end

function BranIronbeard_Click(pUnit, event, player, id, intid, code)
	if(intid == 11) then
		player:GossipComplete()
		pUnit:SpawnAndEnterVehicle(28312, 1000)
		pointPlayer = player
		pointUnit = pUnit
		CreateLuaEvent("EnterVehicle_Unit", 1500, 1)
		CreateLuaEvent("EnterVehicle_Player", 2000, 1)
	elseif(intid == 3) then
		player:GossipComplete()
	end
end

function EnterVehicle_Unit()
	if pointUnit ~= nil then
		vehicle = pointUnit:GetCreatureNearestCoords(pointUnit:GetX(), pointUnit:GetY(), pointUnit:GetZ(), 28319) -- turret
	end
	pointUnit = nil
end

function EnterVehicle_Player()
	if vehicle ~= nil then
		if pointPlayer ~= nil then
			vehicle:AddPassenger(pointPlayer)
		end
	end
	pointPlayer = nil
end

RegisterUnitGossipEvent(69951, 1, "BranIronbeard_Gossip")
RegisterUnitGossipEvent(69951, 2, "BranIronbeard_Click")


function Badlands_QuestVehicle(pUnit, event)
	pUnit:RegisterEvent("CheckForQuestStartbadlads", 5000, 0)
end

function CheckForQuestStartbadlads(pUnit)
	if vehicle ~= nil and pUnit:GetVehicleBase() ~= nil then
		pUnit:RemoveEvents()
		BadlandsInfo[tostring(pUnit)] = {
			track = 1, 
			racecount = 1,
			player = pUnit:GetClosestPlayer(),
			vehicle = vehicle
		}
		vehicle = nil
		pUnit:RegisterEvent("Balands_TrackGo", 3000, 1)
	end
end

RegisterUnitEvent(69951, 18, "Badlands_QuestVehicle")

BalandsLocations = {-- in format as x, y, z, o, registertime, optional message
	{
		{-6951, -2355, 240.8, 0, 7000, "Don't conserve ammunition; there are much more dangerous things to worry about out here."},
		{-6986, -2390, 240.8, 0, 5000},
		{-6961, -2455, 240.8, 0, 5000},
		{-6920, -2515, 240.8, 0, 7000},
		{-6837, -2580, 240.8, 0, 4500},
		{-6832, -2589, 240.8, 0, 5500},
		{-6785, -2633, 241.12, 0, 5500, "Were entering the Dustbowl, ready the turret!"},
		{-6707, -2685, 241.7, 0, 7000},
		{-6688, -2766, 241.7, 0, 7000},
		{-6661, -2856, 242.7, 0, 8500},
		{-6661, -2908, 241.5, 0, 5500},
		{-6545, -3001, 255.8, 0, 13000},
		{-6549.77, -3016.43, 258.96, 0, 500, "Approaching Angor Fortress now."},
		{-6547.5, -3053.85, 267.3, 0, 3000},
		{-6544, -3107.8, 266.3, 0, 6000},
		{-6553, -3202, 249.7, 0, 8000},
		{-6549, -3214, 247.4, 0, 500},
		{-6550.6, -3210.2, 248.2, 0, 500},
		{-6532.8, -3229, 245.5, 0, 500},
		{-6518, -3230.9, 245.7, 0, 500},
		{-6505, -3224.8, 248.3, 0, 500},
		{-6482.95, -3220.82, 250.7, 0, 2000},
		{-6450, -3208.4, 260, 0, 3000},
		{-6399, -3168, 300, 0, 10000, "We're here!"},
		{1, 1, 1, 1, 1, "Good luck."}
	}
}

function Balands_TrackGo(pUnit)
	-- The message to be sent
	--print(BadlandsInfo[tostring(pUnit)].racecount)
	if BalandsLocations[BadlandsInfo[tostring(pUnit)].track][BadlandsInfo[tostring(pUnit)].racecount][6] ~= nil then
		pUnit:SendChatMessage(12, 0, BalandsLocations[BadlandsInfo[tostring(pUnit)].track][BadlandsInfo[tostring(pUnit)].racecount][6])
	end
	if BadlandsInfo[tostring(pUnit)].racecount == #BalandsLocations[BadlandsInfo[tostring(pUnit)].track] then
		-- Were done
		if BadlandsInfo[tostring(pUnit)].player ~= nil then
			BadlandsInfo[tostring(pUnit)].player:SendBroadcastMessage("Test complete")
		end
		if BadlandsInfo[tostring(pUnit)].vehicle ~= nil then
			BadlandsInfo[tostring(pUnit)].vehicle:EjectAllPassengers()
		end
		pUnit:DismissVehicle()
		pUnit:Despawn(1000, 1000)
		return
	end
	pUnit:GetVehicleBase():MoveTo(BalandsLocations[BadlandsInfo[tostring(pUnit)].track][BadlandsInfo[tostring(pUnit)].racecount][1],BalandsLocations[BadlandsInfo[tostring(pUnit)].track][BadlandsInfo[tostring(pUnit)].racecount][2],BalandsLocations[BadlandsInfo[tostring(pUnit)].track][BadlandsInfo[tostring(pUnit)].racecount][3],BalandsLocations[BadlandsInfo[tostring(pUnit)].track][BadlandsInfo[tostring(pUnit)].racecount][4])
	-- Register the event again (recursion)
	pUnit:RegisterEvent("Balands_TrackGo", BalandsLocations[BadlandsInfo[tostring(pUnit)].track][BadlandsInfo[tostring(pUnit)].racecount][5], 1)
	-- Add to the counter
	BadlandsInfo[tostring(pUnit)].racecount = BadlandsInfo[tostring(pUnit)].racecount + 1
end
