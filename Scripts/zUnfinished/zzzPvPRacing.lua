
local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044

local Race_System = {
	RACE_STATUS = "Looking For Racers",
	RACERS = {},
	SHOW = {},
	started = false,
	countdown = 10,
	place = 1,
	RACING = {},
	WINORDER = {},
	print_count = 0,
	counted,
	stime = 0,
	outputwinners = false
}

--Checkpoint locations
local Checkpoints = {
[1] = {{-6101.3, -3893.6}, {-6100.1, -3896.8}, {-6098.4, -3901.0}},
[2] = {{-5981.5, -3834.2}, {-5979.1, -3841.7}, {-5976.9, -3848.3}},
[3] = {{-5865.9, -3782.0}, {-5863.8, -3788.6}, {-5862.1, -3794.1}},
[4] = {{-5726.6, -3785.7}, {-5729.8, -3794.4}, {-5733.1, -3802.6}},
[5] = {{-5641.5, -3884.8}, {-5653.0, -3886.0}, {-5661.8, -3887.0}, {-5671.3, -3887.8}},
[6] = {{-5637.5, -4085.0}, {-5649.3, -4081.4}, {-5659.0, -4076.1}},
[7] = {{-5745.7, -4192.3}, {-5748.8, -4183.1}, {-5751.5, -4175.2}},
[8] = {{-5881.5, -4206.2}, {-5882.2, -4196.9}, {-5882.8, -4188.3}},
[9] = {{-5990.3, -4219.0}, {-5990.5, -4207.1}, {-5990.7, -4196.1}, {-5990.9, -4182.3}},
[10] = {{-6105.1, -4207.2}, {-6104.6, -4193.8}, {-6104.0, -4179.6}, {-6103.5, -4166.4}},
[11] = {{-6220.5, -4215.0}, {-6222.3, -4199.3}, {-6224.0, -4185.0}},
[12] = {{-6328.7, -4229.6}, {-6326.4, -4216.8}, {-6323.9, -4202.3}},
[13] = {{-6406.9, -4179.9}, {-6398.5, -4171.7}, {-6391.5, -4164.8}},
[14] = {{-6433.8, -4090.5}, {-6422.5, -4086.0}},
[15] = {{-6432.5, -3987.9}, {-6421.9, -3988.7}},
[16] = {{-6399.7, -3912.8}, {-5395.8, -3923.0}},
[17] = {{-6342.5, -3897.8}, {-6341.3, -3908.8}},
[18] = {{-6200.0, -3894.8}, {-6200.0, -3898.5}, {-6200.1, -3902.4}, {-6200.1, -3906.9}, {-6200.2, -3911.4}}
}

function SetupRacePlayer(player)
	if (player) then
		local q = CharDBQuery("SELECT won, lost, vehicle FROM racestats WHERE name = '"..player:GetName().."';")
		if (q) then
			player:SetValue("race_won", q:GetColumn(0):GetLong())
			player:SetValue("race_lost", q:GetColumn(1):GetLong())
			player:SetValue("race_vehicle", q:GetColumn(2):GetLong())
		else
			player:SetValue("race_won", 0)
			player:SetValue("race_lost", 0)
			player:SetValue("race_vehicle", 33062)
			CharDBQuery("INSERT INTO racestats VALUES ('"..player:GetName().."', 0, 0, 33062);")
		end
		if (not player:GetValue("race_status")) then
			player:SetValue("race_place", 0)
			player:SetValue("race_point", 0)
			player:SetValue("race_status", false) --false = idle, true = waiting/racing
			player:SetValue("race_finished", false) --power-up target checks, bitch
			player:SetValue("race_page", 0)
			player:SetValue("race_vehicle_unit", 0)
		end
	end
end

local VAR = {}

function DisplayRacesWon(player)
	if (player and player:GetValue("race_won")) then
		return player:GetValue("race_won")
	else
		local q = CharDBQuery("SELECT won FROM racestats WHERE name = '"..player:GetName().."';")
		if (q)then
			player:SetValue("race_won", q:GetColumn(0):GetLong())
			return q:GetColumn(0):GetLong()
		else
			player:SetValue("race_won", 0)
			return 0
		end
	end
end

function DisplayRacesLost(player)
	if (player and player:GetValue("race_lost")) then
		return player:GetValue("race_lost")
	else
		local q = CharDBQuery("SELECT lost FROM racestats WHERE name = '"..player:GetName().."';")
		if (q)then
			player:SetValue("race_lost", q:GetColumn(0):GetLong())
			return q:GetColumn(0):GetLong()
		else
			player:SetValue("race_lost", 0)
			return 0
		end
	end
end

function GetPageLength(player, table_length)
	local page = player:GetValue("race_page")
	local counter = (page * 10) + 1
	local length = table_length
	if (table_length - counter > 10) then
		length = counter + 9
	end
	return counter, length
end

function Test_Item_Trigger(item, event, player)
	Test_Item(item, player)
end

function Test_Item(item, player, intid, code)
	if (not player:GetValue("race_page")) then
		SetupRacePlayer(player)
	end
	item:GossipCreateMenu(50, player, 0)
	item:GossipMenuAddItem(4, "|cff3060B5Current status:|r "..Race_System.RACE_STATUS, 1, 0)
	if (Race_System.RACE_STATUS == "Looking For Racers") then
		if (player:GetAreaId() == 2240 or player:GetAreaId() == 3038) then
			if (player:GetValue("race_status")) then
				item:GossipMenuAddItem(9, "Unsign me from this race.", 2, 0)
			else
				item:GossipMenuAddItem(9, "Sign me up for this race!", 2, 0)
			end
		else
			item:GossipMenuAddItem(9, "Go to the race track to sign up.", 1, 0)
		end
	end
	if (#Race_System.RACERS > 0) then
		local a, b = GetPageLength(player, #Race_System.RACERS)
		for i = a, b do
			if (Race_System.RACERS[i]:GetName()) then
				item:GossipMenuAddItem(4, "   > Racer "..i..": "..Race_System.RACERS[i]:GetName(), 100+i, 0)
				if (intid == i+100 and Race_System.SHOW[intid] == true) then
					item:GossipMenuAddItem(4, "|cff095F0B     > Races won: |r"..DisplayRacesWon(Race_System.RACERS[i]), 100+i, 0)
					item:GossipMenuAddItem(4, "|cFFFF0000     > Races lost: |r"..DisplayRacesLost(Race_System.RACERS[i]), 100+i, 0)
				end
			end
		end
		if (b > #Race_System.RACERS) then
			item:GossipMenuAddItem(7, "Next Page.", 4, 0)
		end
		if (player:GetValue("race_page") > 0) then
			item:GossipMenuAddItem(7, "Previous page.", 5, 0)
		end
	end
	item:GossipMenuAddItem(0, "Nevermind.", 99, 0)
	item:GossipSendMenu(player)
end

function Test_Item_Select(item, event, player, id, intid, code)
	if (intid == 1) then
		Test_Item(item, player)
	elseif (intid == 2) then
		if (player:GetValue("race_status")) then
			for k, v in pairs (Race_System.RACERS) do
				if (v:GetName() == player:GetName()) then
					table.remove(Race_System.RACERS, k)
					player:SetValue("race_status", false)
				end
			end
			table.sort(Race_System.RACERS)
		else
			table.insert(Race_System.RACERS, player)
			player:SetValue("race_status", true)
		end
		Test_Item(item, player)
	elseif (intid == 4) then
		player:ModValue("race_page", 1)
		Test_Item(item, player)
	elseif (intid == 5) then
		player:ModValue("race_page", -1)
		Test_Item(item, player)
	elseif (intid == 99) then
		player:GossipComplete()
	end
	for i = 101, (#Race_System.RACERS+100) do
		if (intid == i) then
			if Race_System.SHOW[intid] == true then
				Race_System.SHOW[intid] = false
			else
				Race_System.SHOW[intid] = true
			end
			Test_Item(item, player, intid)
		end
	end
end

RegisterUnitGossipEvent(4507, 1, "Test_Item_Trigger")
RegisterUnitGossipEvent(4507, 2, "Test_Item_Select")

local RacePoint = {
[1] = {-6204, -3911, -60.32},
[2] = {-6204, -3907, -60.32},
[3] = {-6204, -3903,  -60.32},
[4] = {-6202, -3898,  -60.32},
[5] = {-6204, -3894,  -60.32}
}

local DummyRetard

function DummyRetardSpawn(pUnit)
	DummyRetard = pUnit
	pUnit:RegisterEvent(DummyRetardLoop, 400, 0)
end
function DummyRetardLoop(pUnit)
	if (Race_System.started) then
		for k, v in pairs (Checkpoints) do
			CheckPoint_CheckPlace(k)
		end
	end
end
function DummyRetardAction(player, q)
	player:SpawnAndEnterVehicle(q, 1000)
	DummyRetard:RegisterEvent(function() DummyRetardAction2(player, q); end, 1001, 1)
end
function DummyRetardAction2(player, q)
	player:GetVehicleBase():Root()
	player:SetValue("race_vehicle_unit", player:GetVehicleBase())
	if (q == 33062) then
		local x, y, z, o = player:GetLocation()
		local c = player:SpawnCreature(33775, x, y, z, o, 35, 0)
		if (c and player:IsOnVehicle()) then
			c:SetUInt32Value(UNIT_FIELD_FLAGS, 10) -- look like a player
			c:EnterVehicle(player:GetVehicleBase(), 1000)
		end
		c:RegisterEvent(RaceCompanionRemove, 1500, 0)
	end
end
function RaceCompanionRemove(pUnit)
	if (pUnit:IsDead() or (not pUnit:IsOnVehicle())) then
		pUnit:RemoveEvents()
		pUnit:RemoveFromWorld()
	end
end

RegisterUnitEvent(4507, 18, DummyRetardSpawn)

function GetCheckpointDist(player, cp)
	local closest = -1
	if (not Checkpoints[cp]) then
		return -1
	end
	for k, v in pairs (Checkpoints[cp]) do
		local dst = player:CalcToDistance(v[1], v[2], player:GetZ())
		if (closest == -1 or (dst and dst < closest)) then
			closest = dst
		end
	end
	return closest
end

local countdownornot = false

function CheckIfRaceCanStart()
	if (Race_System.RACE_STATUS == "Looking For Racers") then
		if (#Race_System.RACERS > 1) then
			local i = 0
			for k, v in pairs (Race_System.RACERS) do
				if (v:GetName()) then
					i = i + 1
				else
					table.remove(Race_System.RACERS, k)
				end
			end
			if (i > 1) then
				local k = 1
				for _, player in pairs(Race_System.RACERS) do
					if (player and player:GetName()) then
						player:Dismount()
						player:SetPlayerLock(true)
						player:Root()
						if (k > 5) then
							player:SetPlayerLock(false)
							player:Unroot()
							break
						else
							player:Teleport(1, RacePoint[k][1], RacePoint[k][2], RacePoint[k][3])
						end
						local q = player:GetValue("race_vehicle")
						if (not q) then
							q = 33062
						end
						player:SetValue("race_place", k)
						DummyRetard:RegisterEvent(function() DummyRetardAction(player, q); end, 100, 1)
						table.insert(Race_System.RACING, player)
						k = k + 1
					end
				end
				Race_System.RACE_STATUS = "Race in progress..."
				countdownornot = true
				DummyRetard:RegisterEvent("Check_PlayersIfRacing", 1000, 11)
			end
		end
	end
end

CreateLuaEvent(CheckIfRaceCanStart, 30000, 0)

function Check_PlayersIfRacing(pUnit)
	if (countdownornot) then
		Race_System.countdown = Race_System.countdown - 1
		if (Race_System.countdown < 1) then
			Race_System.countdown = 10
			Race_System.started = true
			countdownornot = false
			Race_System.counted = true
			pUnit:SendChatMessage(42, 0, "GO!")
			Race_System.stime = os.clock()
			for _, player in pairs (Race_System.RACING) do
				if (player:IsOnVehicle()) then
					player:Unroot()
					player:SetPlayerLock(false)
					player:GetVehicleBase():Unroot()
				end
			end
		elseif (Race_System.countdown < 6) then
			pUnit:SendChatMessage(42, 0, tostring(Race_System.countdown))
			if (Race_System.countdown == 5) then
				for _, player in pairs (Race_System.RACING) do
					if (player:IsOnVehicle()) then
						local vehicle = player:GetVehicleBase()
						local x, y, z, o = vehicle:GetLocation()
						vehicle:Teleport(1, x, y, z+0.1, o)
					end
				end
			end
		end
	end
	if (Race_System.outputwinners) then
		Race_System.print_count = #Race_System.WINORDER
		pUnit:RegisterEvent(printnamelistorder, 3000, (#Race_System.WINORDER))
		Race_System.outputwinners = false
	end
end

function printnamelistorder(pUnit)
	local zzplace = nil
	if (Race_System.print_count == 5) then
		zzplace = "5th"
	elseif (Race_System.print_count == 4) then
		zzplace = "4th"
	elseif (Race_System.print_count == 3) then
		zzplace = "3rd"
	elseif (Race_System.print_count == 2) then
		zzplace = "2nd"
	elseif (Race_System.print_count == 1) then
		zzplace = "1st"
	end
	local player = Race_System.WINORDER[Race_System.print_count]
	pUnit:SendChatMessage(42, 0, player:GetName().." came in "..zzplace.." place!")
	Race_System.print_count = Race_System.print_count - 1
	if (Race_System.print_count == 0) then
		Race_System.print_count = 5
		Race_System.RACE_STATUS = "Looking For Racers"
		Race_System.RACERS = {}
		Race_System.started = false
		Race_System.countdown = 10
		Race_System.place = 1
		Race_System.counted = false
		for k, v in pairs(Race_System.RACING) do
			table.remove(Race_System.RACING, k)
		end
		for k, v in pairs(Race_System.WINORDER) do
			table.remove(Race_System.WINORDER, k)
		end
		for k, v in pairs (GetPlayersInWorld()) do
			if (v:GetValue("race_page")) then
				v:SetValue("race_page", 0)
			end
		end
		Race_System.SHOW = {}
		player:SetValue("race_place", 0)
		player:SetValue("race_point", 0)
		player:SetValue("race_status", false) --false = idle, true = waiting/racing
		player:SetValue("race_finished", false) --power-up target checks, bitch
	end
end

function CheckPoint_CheckPlace(cp)
	if (Race_System.started) then
		for _, player in pairs (Race_System.RACING) do
			local dist = GetCheckpointDist(player, cp)
			if (player:IsOnVehicle() and dist < 20) then
				local name = player:GetName()
				local point = player:GetValue("race_point")
				local nextpoint = point + 1
				if (cp < #Checkpoints) then
					if (cp > nextpoint) then
						DummyRetard:SendChatMessageToPlayer(42, 0, "You missed checkpoint "..(point+1).."!", player)
					elseif (cp == nextpoint) then
						DummyRetard:SendChatMessageToPlayer(42, 0, "You have passed checkpoint "..cp.."!", player)
						player:SetValue("race_point", cp)
					end
				elseif (cp == #Checkpoints and point == #Checkpoints - 1) then
					if (dist < 7) then
						player:SetValue("race_point", cp)
						if (Race_System.place == #Race_System.RACING) then
							DummyRetard:SendChatMessageToPlayer(42, 0, "You have come last!", player)
							player:ModValue("race_lost", 1)
							CharDBQuery("UPDATE racestats SET lost = lost + 1 WHERE name = '"..name.."';")
						elseif (Race_System.place == 1) then
							DummyRetard:SendChatMessageToPlayer(42, 0, "You have come 1st!", player)
							player:AddItem(37836,2) -- added reward
							if (player:HasQuest(6033)) then -- Daily quest
								if (player:GetQuestObjectiveCompletion(6033, 0) == 0) then -- Daily quest
									player:AdvanceQuestObjective(6033, 0) -- Daily quest
								end
							end
							player:ModValue("race_won", 1)
							CharDBQuery("UPDATE racestats SET won = won + 1 WHERE name = '"..name.."';")
						elseif (Race_System.place == 2) then
							DummyRetard:SendChatMessageToPlayer(42, 0, "You have come 2nd!", player)
						elseif (Race_System.place == 3) then
							DummyRetard:SendChatMessageToPlayer(42, 0, "You have come 3rd!", player)
						elseif (Race_System.place == 4) then
							DummyRetard:SendChatMessageToPlayer(42, 0, "You have come 4th!", player)
						end
						table.insert(Race_System.WINORDER, player)
						player:SetValue("race_finished", true)
						Race_System.place = Race_System.place + 1
						if (#Race_System.WINORDER == #Race_System.RACING) then
							DummyRetard:SendChatMessage(42, 0, "All participants have reached the finish line!")
							Race_System.outputwinners = true
							Race_System.RACE_STATUS = "Announcing winners..."
						end
						player:SetValue("race_point", cp)
						local vehicle = player:GetVehicleBase()
						player:ExitVehicle()
						if (vehicle:GetEntry() == 33062) then
							local x, y, z = player:GetLocation()
							local gnome = player:GetCreatureNearestCoords(x, y, z, 33775)
							if (gnome) then
								gnome:Despawn(1, 0)
							end
						end
						vehicle:Despawn(100, 0)
						player:MoveKnockback(-6176.9, -3886.5, -57, 6, 8)
					end
				end
			end
		end
	end
end

function renametotest()
	if (Race_System.started) then
		for k, player in pairs (Race_System.RACING) do
			if (player == nil) then
				table.remove(Race_System.RACING, k)
			elseif (player:IsOnVehicle() == false or (player:GetAreaId() ~= 2240 and player:GetAreaId() ~= 3038)) then
				local found = false
				for a, v in pairs(Race_System.WINORDER) do
					if (v:GetName() == player:GetName()) then
						found = true
						break
					end
				end
				if (not found) then
					player:SetValue("race_place", 0)
					player:SetValue("race_point", 0)
					player:SetValue("race_status", false)
					player:SetValue("race_finished", false)
					player:SetValue("race_page", 0)
					player:GetValue("race_vehicle_unit"):DismissVehicle()
					player:SetValue("race_vehicle_unit", 0)
					player:SendBroadcastMessage("You have been removed from the race for cheating!")
					--player:Teleport(0, -7482, -1249, 478) -- teleport out of the race because they are not on a vehicle (cheating)
					table.remove(Race_System.RACING, k)
				end
			end
		end
		if (os.clock() - Race_System.stime > (60*5)) then -- race has gone on for more than 5 minutes
			for _, player in pairs(Race_System.RACING) do
				if (player) then
					player:SendBroadcastMessage("The race ended since the time limit was exceeded!")
					player:SendAreaTriggerMessage("The race ended since the time limit was exceeded!")
					player:SetValue("race_place", 0)
					player:SetValue("race_point", 0)
					player:SetValue("race_status", false)
					player:SetValue("race_finished", false)
					player:SetValue("race_page", 0)
					player:SetValue("race_vehicle_unit", 0)
					if (player:IsOnVehicle()) then
						local vehicle = player:GetVehicleBase()
						player:ExitVehicle()
						if (vehicle:GetEntry() == 33062) then
							local x, y, z = player:GetLocation()
							local gnome = player:GetCreatureNearestCoords(x, y, z, 33775)
							if (gnome) then
								gnome:Despawn(1,0)
							end
						end
						vehicle:Despawn(100,0)
					end
				end
			end
			Race_System.print_count = 5
			Race_System.RACE_STATUS = "Looking For Racers"
			Race_System.RACERS = {}
			Race_System.started = false
			Race_System.countdown = 10
			Race_System.place = 1
			Race_System.counted = false
			for k, v in pairs(Race_System.RACING) do
				table.remove(Race_System.RACING, k)
			end
			for k, v in pairs(Race_System.WINORDER) do
				table.remove(Race_System.WINORDER, k)
			end
			for k, v in pairs (GetPlayersInWorld()) do
				if (v:GetValue("race_page")) then
					v:SetValue("race_page", 0)
				end
			end
			Race_System.SHOW = {}
		end
	end
end

CreateLuaEvent(renametotest, 2500, 0)

function GetClosestRacer(pUnit)
	local players = pUnit:GetInRangePlayers()
	for k, v in pairs (players) do
		if (not v or not v:IsOnVehicle() or v:GetValue("race_finished") or v:GetValue("race_status") == false) then
			table.remove(players, k)
		end
	end
	if (not players or #players == 0) then return end
	for i = 1, #players do
		for j = 2, #players do
			if (pUnit:GetDistanceYards(players[j]) < pUnit:GetDistanceYards(players[j-1])) then
				local temp = players[j-1]
				players[j-1] = players[j]
				players[j] = temp
			end
		end
	end
	return players[1]
end

function Speed_Buff_Spawn(pUnit, Event)
	pUnit:RegisterEvent("CheckForVehicleToSpeedUp", 500, 0)
end

function CheckForVehicleToSpeedUp(pUnit)
	local player = GetClosestRacer(pUnit)
	if (player and player:GetDistanceYards(pUnit) <= 5) then
		local vehicle = player:GetVehicleBase()
		if (not vehicle) then return; end
		vehicle:CastSpell(62299) -- speed boost
		vehicle:ModifyRunSpeed(18)
		--the magic of CreateLuaEvent <3 //Alexeng
		CreateLuaEvent(function() if(vehicle and not player:HasAura(62299))then vehicle:ModifyRunSpeed(14);end end, 4100, 1)
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 179871)
		if (object) then
			object:Despawn(1, 30000)
			pUnit:RegisterEvent("Speed_Buff_Spawn", 30000, 1)
		end
	end
end

RegisterUnitEvent(88115, 18, "Speed_Buff_Spawn")

function Rage_Buff_Spawn(pUnit, Event)
	pUnit:RegisterEvent("CheckForVehicleToAttack", 500, 0)
end

function CheckForVehicleToAttack(pUnit)
	local player = GetClosestRacer(pUnit)
	if (player and pUnit:GetDistanceYards(player) <= 5) then
		local vehicle = player:GetVehicleBase()
		local name = player:GetName()
		local point = player:GetValue("race_point")
		if (not point) then point = 0; end
		local place = player:GetValue("race_place")
		if (place == Race_System.place) then
			pUnit:SendChatMessageToPlayer(42, 0, "You have been hit by your own bomb!", player)
			vehicle:CastSpell(71599) -- visual
			vehicle:CastSpell(24647) -- stun
		else
			local targets = {}
			for k, v in pairs (Race_System.RACING) do
				if (v and v:IsOnVehicle() and v:GetValue("race_finished") == false) then
					table.insert(targets, v)
				end
			end
			if (not targets or (#targets) < 2) then return; end
			local temp
			for i = 1, (#targets) do
				for j = 2, (#targets) do
					if (targets[j][2] < targets[j-1][2]) then
						temp = targets[j-1]
						targets[j-1] = targets[j]
						targets[j] = temp
					end
				end
			end
			local n = math.random(1, place) - 1
			if (n == 0) then n = 1; end --First player has a higher chance of being bombed
			local target = targets[n]
			if (not target) then return; end
			target:GetVehicleBase():CastSpell(71599) -- visual
			target:GetVehicleBase():CastSpell(24647) -- stun
			pUnit:SendChatMessageToPlayer(42, 0, "You have been hit by "..player:GetName().."'s bomb!", target)
			pUnit:SendChatMessageToPlayer(42, 0, "You have hit "..target:GetName().." with your bomb!", player)
		end
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 180382)
		if (object) then
			object:Despawn(1, 30000)
			pUnit:RegisterEvent("Rage_Buff_Spawn", 30000, 1)
		end
	end
end

RegisterUnitEvent(88116, 18, "Rage_Buff_Spawn")

function Pull_Buff_Spawn(pUnit, Event)
	pUnit:RegisterEvent("CheckForPlayerToPull", 500, 0)
end

function CheckForPlayerToPull(pUnit)
	local player = GetClosestRacer(pUnit)
	if (player and player:GetDistanceYards(pUnit) <= 5) then
		local place = player:GetValue("race_place")
		if (place == Race_System.place) then
			pUnit:SendChatMessageToPlayer(42, 0, "Your grapple failed!", player)
		else
			local targets = {}
			for k, v in pairs (Race_System.RACING) do
				if (v and v:IsOnVehicle() and player:GetValue("race_finished") == false and v:GetValue("race_finished") == false and player:GetDistanceYards(v) <= 40) then
					table.insert(targets, v)
				end
			end
			if (not targets or (#targets) < 2) then
				pUnit:SendChatMessageToPlayer(42, 0, "No target to grapple!")
				return
			end
			for i = 1, (#targets) do
				for j = 2, (#targets) do
					if (targets[j][2] < targets[j-1][2]) then
						temp = targets[j-1]
						targets[j-1] = targets[j]
						targets[j] = temp
					end
				end
			end
			local n = math.random(1, (place - 1))
			local target = targets[n]
			if (not target) then return; end
			local x, y, z = player:GetLocation()
			target:GetVehicleBase():MoveKnockback(x, y, z, 2, 3)
			pUnit:SendChatMessageToPlayer(42, 0, "You have been grappled by "..player:GetName().."!", target)
			pUnit:SendChatMessageToPlayer(42, 0, "You have grappled "..target:GetName().."!", player)
		end
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 180383)
		if (object) then
			object:Despawn(1, 30000)
			pUnit:RegisterEvent("Pull_Buff_Spawn", 30000, 1)
		end
	end
end

RegisterUnitEvent(88117, 18, "Pull_Buff_Spawn")

-- Crowd stuff

function CHEERINGCROWD_Spawned(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("CHEER_CROWD_CHEER", 5000, 0)
	pUnit:RegisterEvent("LOOP_MUSIC_RACE", 180000, 0)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
	players:PlayMusicToPlayer(16337)
end
end
end

RegisterUnitEvent(477191,18, "CHEERINGCROWD_Spawned")

function LOOP_MUSIC_RACE(pUnit,Event)
		for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
	players:PlayMusicToPlayer(16337)
end
end
end

function CHEER_CROWD_CHEER(pUnit,Event)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 30 then
	local r = math.random(1, 6)
	if (r == 1) then -- alliance 1
		players:PlaySoundToPlayer(13838)
	elseif (r == 2) then -- horde 1
		players:PlaySoundToPlayer(13839)
	elseif (r == 3) then -- alliance 2
		players:PlaySoundToPlayer(13840)
	elseif (r == 4) then -- horde 2
		players:PlaySoundToPlayer(13841)
	elseif (r == 5) then -- alliance finale
		players:PlaySoundToPlayer(13843)
	elseif (r == 6) then -- horde finale
		players:PlaySoundToPlayer(13844)
	end
	end
end
end

function RIZNEK_VENDORADVERTISE(pUnit,Event)
	local r = math.random(1, 3)
		for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
	if (r == 1) then 
		pUnit:SendChatMessageToPlayer(12, 0, "Get your ice cold beverages now, Almost out of stock!",players)
	elseif (r == 2) then 
		pUnit:SendChatMessageToPlayer(12, 0, "Ice cold beverages!",players)
	elseif (r == 3) then 
		pUnit:SendChatMessageToPlayer(12, 0, "Enjoy the excitement with a nice cold beverage!",players)
	end
	end
end
	pUnit:RegisterEvent("RIZNEK_VENDORADVERTISE", math.random(15000, 50000), 1)
end

function REZNIKADV_Spawned(pUnit,Event)
	pUnit:RegisterEvent("RIZNEK_VENDORADVERTISE", math.random(20000, 30000), 1)
end

RegisterUnitEvent(6495,18, "REZNIKADV_Spawned")

function RACE_BOULDERSPAWN(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:CastSpell(55766)
	pUnit:RegisterEvent("RACE_BOULDERROLE", 500, 0) 
end

RegisterUnitEvent(723190, 18, "RACE_BOULDERSPAWN")
  
function RACE_BOULDERROLE(pUnit,Event)
	pUnit:CastSpell(55766)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for k, player in pairs (PlayersAllAround) do
		if (pUnit:GetDistanceYards(player) < 4.6) then
			if (player:IsOnVehicle() and player:GetValue("race_status")) then
				local vehicle = player:GetVehicleBase()
				--pUnit:CastSpellOnTarget(42299, vehicle) --as if stunning wasn't enought *rolls eyes*
			    vehicle:CastSpell(24647)
			end
		end
	end
end

function RACE_UpdatePlaces()
	if (Race_System.started) then
		if (Race_System.RACING and #Race_System.RACING == 0) then
			Race_System.print_count = 5
			Race_System.RACE_STATUS = "Looking For Racers"
			Race_System.RACERS = {}
			Race_System.started = false
			Race_System.countdown = 10
			Race_System.place = 1
			Race_System.counted = false
			for k, v in pairs(Race_System.RACING) do
				table.remove(Race_System.RACING, k)
			end
			for k, v in pairs(Race_System.WINORDER) do
				table.remove(Race_System.WINORDER, k)
			end
			for k, v in pairs (GetPlayersInWorld()) do
				if (v:GetValue("race_page")) then
					v:SetValue("race_page", 0)
				end
			end
			Race_System.SHOW = {}
			return
		end
		local racers = {}
		for k, v in pairs (Race_System.RACING) do
			if (v and v:IsOnVehicle()) then
				local point = v:GetValue("race_point") + 1
				local dist = -1
				if (point == #Checkpoints) then
					dist = GetCheckpointDist(v, point)
				else
					dist = GetCheckpointDist(v, point) + GetCheckpointDist(v, point + 1)
				end
				if (v:GetAreaId() ~= 2240 and v:GetAreaId() ~= 3038) then --cheaters
					v:SetValue("race_place", 0)
					v:SetValue("race_point", 0)
					v:SetValue("race_status", false)
					v:SetValue("race_finished", false)
					v:SetValue("race_page", 0)
					v:SetValue("race_vehicle_unit", 0)
					v:GetVehicleBase():DismissVehicle()
					v:SendBroadcastMessage("You have been removed from the race for cheating!")
					v:Teleport(0, -7482, -1249, 478) -- teleport out of the race because they are not on a vehicle (cheating)
					table.remove(Race_System.RACING, k)
				else
					racers[k] = {point, dist, v}
				end
			end
		end
		--Sort by distance to next checkpoint first, then sort by checkpoint.
		for i = 1, #racers do
			for j = 2, #racers do
				if (racers[j][2] < racers[j-1][2]) then
					local temp = racers[j-1]
					racers[j-1] = racers[j]
					racers[j] = temp
				end
			end
		end
		for i = 1, #racers do
			for j = 2, #racers do
				if (racers[j][1] > racers[j-1][1]) then
					local temp = racers[j-1]
					racers[j-1] = racers[j]
					racers[j] = temp
				end
			end
		end
		local place = 1
		for k, v in pairs (racers) do
			v[3]:SetValue("race_place", place)
			place = place + 1
		end
	end
end

CreateLuaEvent(RACE_UpdatePlaces, 1000, 0)