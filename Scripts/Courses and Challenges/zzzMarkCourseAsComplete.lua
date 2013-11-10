------------------------------
----------COURSE A------------
------------------------------

function RewardCourseAClick(pUnit, event, player)
	local amount = CharDBQuery("SELECT * FROM character_coursecomplete WHERE name = '"..player:GetName().."';")
	if amount == nil then
		CharDBQuery("INSERT INTO character_coursecomplete VALUES ('"..player:GetName().."', '1', '0', '0', '0');")
		pUnit:SendChatMessageToPlayer(42,0,"You have received 5 \124cffa335ee\124Hitem:29434:0:0:0:0:0:0:0:0\124h[Badge of Justice]\124h\124r for completing this course!", player)
		player:AddItem(29434, 5)
		player:CastSpell(47292) -- Level up visual
	elseif amount:GetColumn(1):GetString() == "0" then
		CharDBQuery("UPDATE character_coursecomplete SET CourseA = '1' WHERE name = '"..player:GetName().."';")
		pUnit:SendChatMessageToPlayer(42,0,"You have received 5 \124cffa335ee\124Hitem:29434:0:0:0:0:0:0:0:0\124h[Badge of Justice]\124h\124r for completing this course!", player)
		player:AddItem(29434, 5)
		player:CastSpell(47292) -- Level up visual
	end
	amount = CharDBQuery("SELECT * FROM character_coursecomplete WHERE name = '"..player:GetName().."';")
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
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(4, "You have completed "..count.."/3 courses.", 2, 0)
	pUnit:GossipMenuAddItem(2, "Return me to Blackrock Mountain.", 1, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function RewardCourseAGossip(pUnit, event, player, id, intid, code)
	if (intid == 1) then
		player:GossipComplete()
		player:Teleport(0, -7555, -1200, 477)
	elseif (intid == 2) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(60011, 1, "RewardCourseAClick")
RegisterUnitGossipEvent(60011, 2, "RewardCourseAGossip")

------------------------------
----------COURSE B------------
------------------------------
function RewardCourseBClick(pUnit, event, player)
	local amount = CharDBQuery("SELECT * FROM character_coursecomplete WHERE name = '"..player:GetName().."';")
	if amount == nil then
		CharDBQuery("INSERT INTO character_coursecomplete VALUES ('"..player:GetName().."', '0', '1', '0', '0');")
		pUnit:SendChatMessageToPlayer(42,0,"You have received 20 \124cffa335ee\124Hitem:29434:0:0:0:0:0:0:0:0\124h[Badge of Justice]\124h\124r for completing this course!", player)
		player:AddItem(29434, 20)
		player:CastSpell(47292) -- Level up visual
	elseif amount:GetColumn(2):GetString() == "0" then
		CharDBQuery("UPDATE character_coursecomplete SET CourseB = '1' WHERE name = '"..player:GetName().."';")
		pUnit:SendChatMessageToPlayer(42,0,"You have received 20 \124cffa335ee\124Hitem:29434:0:0:0:0:0:0:0:0\124h[Badge of Justice]\124h\124r for completing this course!", player)
		player:AddItem(29434, 20)
		player:CastSpell(47292) -- Level up visual
	end
	amount = CharDBQuery("SELECT * FROM character_coursecomplete WHERE name = '"..player:GetName().."';")
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
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(4, "You have completed "..count.."/3 courses.", 2, 0)
	pUnit:GossipMenuAddItem(2, "Return me to Blackrock Mountain.", 1, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function RewardCourseBGossip(pUnit, event, player, id, intid, code)
	if (intid == 1) then
		player:GossipComplete()
		player:Teleport(0, -7555, -1200, 477)
	elseif (intid == 2) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(60013, 1, "RewardCourseBClick")
RegisterUnitGossipEvent(60013, 2, "RewardCourseBGossip")


------------------------------
----------COURSE C------------
------------------------------

function RewardCourseCClick(pUnit, event, player)
	local amount = CharDBQuery("SELECT * FROM character_coursecomplete WHERE name = '"..player:GetName().."';")
	if amount == nil then
		CharDBQuery("INSERT INTO character_coursecomplete VALUES ('"..player:GetName().."', '0', '0', '1', '0');")
		pUnit:SendChatMessageToPlayer(42,0,"You have received 25 \124cffa335ee\124Hitem:29434:0:0:0:0:0:0:0:0\124h[Badge of Justice]\124h\124r for completing this course!", player)
		player:AddItem(29434, 25)
		player:CastSpell(47292) -- Level up visual
	elseif amount:GetColumn(3):GetString() == "0" then
		CharDBQuery("UPDATE character_coursecomplete SET CourseC = '1' WHERE name = '"..player:GetName().."';")
		pUnit:SendChatMessageToPlayer(42,0,"You have received 25 \124cffa335ee\124Hitem:29434:0:0:0:0:0:0:0:0\124h[Badge of Justice]\124h\124r for completing this course!", player)
		player:AddItem(29434, 25)
		player:CastSpell(47292) -- Level up visual
	end
	amount = CharDBQuery("SELECT * FROM character_coursecomplete WHERE name = '"..player:GetName().."';")
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
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(4, "You have completed "..count.."/3 courses.", 2, 0)
	pUnit:GossipMenuAddItem(2, "Return me to Blackrock Mountain.", 1, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function RewardCourseCGossip(pUnit, event, player, id, intid, code)
	if (intid == 1) then
		player:GossipComplete()
		player:Teleport(0, -7555, -1200, 477)
	elseif (intid == 2) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(60012, 1, "RewardCourseCClick")
RegisterUnitGossipEvent(60012, 2, "RewardCourseCGossip")