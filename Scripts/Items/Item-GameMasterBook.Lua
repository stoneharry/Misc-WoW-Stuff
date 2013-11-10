-- Credits: RakorZ - ZxOxZ.

LordaeronGamingGameMasterBook = {}

function LordaeronGamingGameMasterBook.OnItemTrigger(pItem, event, player)
	if (player:GetGmRank() == 'az') then
		LordaeronGamingGameMasterBook.OnItemMenu(pItem, player)
	else
		player:SendBroadcastMessage("You are not allowed to use that Item. |CFFFF000000(You are not a GM)|R.")
		player:RemoveItem(7295, 1)
	end
end

function LordaeronGamingGameMasterBook.OnItemMenu(pItem, player)
	pItem:GossipCreateMenu(1, player, 0)
	pItem:GossipMenuAddItem(4, "|cff00ff00|TInterface\\icons\\INV_Misc_EngGizmos_31:30|t|r Hand over the resources required.", 100, 0)
	pItem:GossipMenuAddItem(5, "Crate Vehicle.", 510, 1)
	pItem:GossipMenuAddItem(5, "Jump here, Creature.", 480, 0)
	pItem:GossipMenuAddItem(5, "Channel Spells Page.", 10, 0)
	pItem:GossipMenuAddItem(5, "Cast Spells Page.", 20, 0)
	pItem:GossipMenuAddItem(5, "Teleport X Y Z Page.", 30, 0)
	pItem:GossipMenuAddItem(5, "Teleport to Target Page.", 40, 0)
	pItem:GossipMenuAddItem(5, "Other Commands Page.", 50, 0)
	pItem:GossipMenuAddItem(5, "Turn 180 Degrees around.", 150, 0)
	pItem:GossipMenuAddItem(5, "Turn 90 Degrees around.", 160, 0)
	pItem:GossipMenuAddItem(5, "Set Orientation.", 170, 1)
	pItem:GossipMenuAddItem(5, "Spawn Units.", 190, 0)
	pItem:GossipMenuAddItem(5, "Advance Quest Objective.", 350, 1)
	pItem:GossipMenuAddItem(5, "Teleport to X, Y, Z Coords.", 480, 0)
	pItem:GossipMenuAddItem(5, "Distance between you and target.", 550, 0)
	pItem:GossipMenuAddItem(5, "Close Game Master Book.", 100, 0)
	pItem:GossipSendMenu(player)
end

function LordaeronGamingGameMasterBook.OnItemSelect(pItem, event, player, id, intid, Code)

	if (intid == 510) then
	
		player:SpawnAndEnterVehicle(tonumber(Code), 0)
		player:GossipComplete()
		
	end

	if (intid == 550) then
		if (player:GetSelection() ~= nil) then
			player:SendBroadcastMessage("The distance between you and target is: "..tonumber(player:GetDistanceYards(player:GetSelection())).." yards!")
			player:GossipComplete()
		else
			player:SendAreaTriggerMessage("You have no target!")
			player:GossipComplete()
		end
	end

	if (intid == 480) then
		if (player:GetSelection() ~= nil) then
			player:GetSelection():MoveJump(player:GetX(), player:GetY(), player:GetZ())
			player:GossipComplete()
		else
			player:SendAreaTriggerMessage("You have no target!")
			player:GossipComplete()
		end
	end

	if (intid == 190) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(5, "Spawn Creature - Z.", 195, 1)
		pItem:GossipMenuAddItem(5, "Spawn Game Object - Z.", 200, 1)
		pItem:GossipMenuAddItem(5, "Back to Main Menu.", 110, 0)
		pItem:GossipMenuAddItem(5, "Close Game Master Book.", 100, 0)
		pItem:GossipSendMenu(player)
	end
	
	if (intid == 195) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
			player:SpawnCreature(85553, player:GetX(), player:GetY(), player:GetZ() - (tonumber(Code)), player:GetO(), 35, 0, 0, 0, 0, player:GetPhase(), 1)
			player:GossipComplete()
		end
	end

	if (intid == 200) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
			player:SpawnGameObject(193211, player:GetX(), player:GetY(), player:GetZ() - (tonumber(Code)), player:GetO(), 0, 100, 1, 1)
			player:GossipComplete()
		end
	end

	if (intid == 350) then		
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:AdvanceQuestObjective(tonumber(Code), 0)
		player:GossipComplete()
		end
	end

	if (intid == 170) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:SetFacing(tonumber(Code))
		player:GossipComplete()
		end
	end

	if (intid == 150) then
		player:SetFacing(player:GetO() + math.pi)
		player:GossipComplete()
	end
	
	if (intid == 160) then
		player:SetFacing(player:GetO() + math.pi / 2)
		player:GossipComplete()
	end

	if (intid == 110) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(5, "Channel Spells Page.", 10, 0)
		pItem:GossipMenuAddItem(5, "Cast Spells Page.", 20, 0)
		pItem:GossipMenuAddItem(5, "Teleport X Y Z Page.", 30, 0)
		pItem:GossipMenuAddItem(5, "Teleport to Target Page.", 40, 0)
		pItem:GossipMenuAddItem(5, "Other Commands Page.", 50, 0)
		pItem:GossipMenuAddItem(5, "Turn 180 Degrees around.", 150, 0)
		pItem:GossipMenuAddItem(5, "Turn 90 Degrees around.", 160, 0)
		pItem:GossipMenuAddItem(5, "Set Orientation.", 170, 1)
		pItem:GossipMenuAddItem(5, "Advance Quest Objective.", 350, 1)
		pItem:GossipMenuAddItem(5, "Close Game Master Book.", 100, 0)
		pItem:GossipSendMenu(player)
	end
	
	if (intid == 10) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(5, "Channel Spell on Target.", 11, 1)
		pItem:GossipMenuAddItem(5, "Stop Channel any Spell.", 12, 0)
		pItem:GossipMenuAddItem(5, "Unit Channel on Unit.", 13, 1)
		pItem:GossipMenuAddItem(5, "Unit Channel Stop.", 14, 1)
		pItem:GossipMenuAddItem(5, "Back to Main Menu.", 110, 0)
		pItem:GossipMenuAddItem(5, "Close Game Master Book.", 100, 0)
		pItem:GossipSendMenu(player)
	end
	
	if (intid == 20) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(5, "Cast Spell.", 21, 1)
		pItem:GossipMenuAddItem(5, "Cast Spell on Target.", 22, 1)
		pItem:GossipMenuAddItem(5, "Target Cast Spell On Target.", 122, 1)
		pItem:GossipMenuAddItem(5, "Target Full Cast Spell On Target.", 123, 1)
		pItem:GossipMenuAddItem(5, "Target Cast Spell on Self.", 124, 1)
		pItem:GossipMenuAddItem(5, "Target Full Cast Spell.", 125, 1)
		pItem:GossipMenuAddItem(5, "Full Cast Spell.", 23, 1)
		pItem:GossipMenuAddItem(5, "Full Cast Spell on Target.", 24, 1)
		pItem:GossipMenuAddItem(5, "Cast Spell on Target Location.", 25, 1)
		pItem:GossipMenuAddItem(5, "Back to Main Menu.", 110, 0)
		pItem:GossipMenuAddItem(5, "Close Game Master Book.", 100, 0)
		pItem:GossipSendMenu(player)
	end
	
	if (intid == 25) then
		if (player:GetSelection() ~= nil) then
			if (player:GetSelection():IsAlive() == true) then
				player:CastSpellAoF(player:GetSelection():GetX(), player:GetSelection():GetY(), player:GetSelection():GetZ(), tonumber(Code))
				player:GossipComplete()
			else
				player:SendBroadcastMessage("Target is dead!")
				player:GossipComplete()
			end
		else
			player:SendBroadcastMessage("You have no target!")
			player:GossipComplete()
		end
	end
	
	if (intid == 13) then
		if (player:GetSelection() ~= nil) then
			if (player:GetSelection():IsAlive() == true) then
				player:GetSelection():ChannelSpell(tonumber(Code), player:GetSelection())
				player:GossipComplete()
			else
				player:SendBroadcastMessage("Target is dead!")
				player:GossipComplete()
			end
		else
			player:SendBroadcastMessage("You have no target!")
			player:GossipComplete()
		end
	end
	
	if (intid == 14) then
		if (player:GetSelection() ~= nil) then
			if (player:GetSelection():IsAlive() == true) then
				player:GetSelection():StopChannel()
				player:GossipComplete()
			else
				player:SendBroadcastMessage("Target is dead!")
				player:GossipComplete()
			end
		else
			player:SendBroadcastMessage("You have no target!")
			player:GossipComplete()
		end
	end
	
	if (intid == 125) then
		if (player:GetSelection() ~= nil) then
			if (player:GetSelection():IsAlive() == true) then
				player:GetSelection():FullCastSpell(tonumber(Code))
				player:GossipComplete()
			else
				player:SendBroadcastMessage("Target is dead!")
				player:GossipComplete()
			end
		else
			player:SendBroadcastMessage("You have no target!")
			player:GossipComplete()
		end
	end
	
	if (intid == 122) then
		if (player:GetSelection() ~= nil) then	
			if (player:GetSelection():GetMainTank() ~= nil) then
			player:GetSelection():CastSpellOnTarget(tonumber(Code), player:GetSelection():GetMainTank())
			player:GossipComplete()
			else
			player:SendBroadcastMessage("Your Target's Target is nil!")
			player:GossipComplete()
			end
		else
			player:GossipComplete()
			player:SendBroadcastMessage("You have no target!")
		end
	end
	
	if (intid == 123) then
		if (player:GetSelection() ~= nil) then	
			if (player:GetSelection():GetSelection() ~= nil) then
			player:GetSelection():FullCastSpellOnTarget(tonumber(Code), player:GetSelection():GetSelection())
			player:GossipComplete()
			else
			player:SendBroadcastMessage("Target's Target is nil!")
			player:GossipComplete()
			end
		else
			player:GossipComplete()
			player:SendBroadcastMessage("You have no target!")
		end
	end
	
	if (intid == 124) then
		if (player:GetSelection() ~= nil) then	
			player:GetSelection():CastSpellOnTarget(tonumber(Code), player:GetSelection())
			player:GossipComplete()
		else
			player:GossipComplete()
			player:SendBroadcastMessage("You have no target!")
		end
	end
	
	if (intid == 30) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(5, "Teleport +X.", 31, 1)
		pItem:GossipMenuAddItem(5, "Teleport +Y.", 32, 1)
		pItem:GossipMenuAddItem(5, "Teleport +Z.", 33, 1)
		pItem:GossipMenuAddItem(5, "Teleport -X.", 34, 1)
		pItem:GossipMenuAddItem(5, "Teleport -Y.", 35, 1)
		pItem:GossipMenuAddItem(5, "Teleport -Z.", 36, 1)
		pItem:GossipMenuAddItem(5, "Back to Main Menu.", 110, 0)
		pItem:GossipMenuAddItem(5, "Close Game Master Book.", 100, 0)
		pItem:GossipSendMenu(player)
	end
		
	if (intid == 40) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(5, "Teleport to my Target.", 41, 0)
		pItem:GossipMenuAddItem(5, "Teleport to my Target + 180 Degrees.", 42, 0)
		pItem:GossipMenuAddItem(5, "Target Orientation.", 43, 0)
		pItem:GossipMenuAddItem(5, "Back to Main Menu.", 110, 0)
		pItem:GossipMenuAddItem(5, "Close Game Master Book.", 100, 0)
		pItem:GossipSendMenu(player)
	end
	
	if (intid == 50) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(5, "Play Sound to Player.", 51, 1)
		pItem:GossipMenuAddItem(5, "Play Sound to Server.", 52, 1)
		pItem:GossipMenuAddItem(5, "Play Movie with ID.", 53, 1)
		pItem:GossipMenuAddItem(5, "Back to Main Menu.", 110, 0)
		pItem:GossipMenuAddItem(5, "Close Game Master Book.", 100, 0)
		pItem:GossipSendMenu(player)
	end
	
	if (intid == 100) then
		player:GossipComplete()
	end
	
	if (intid == 43) then
		if (player:GetSelection() ~= nil) then
			player:SetFacing(player:GetSelection():GetO())
			player:GossipComplete()
		else
			player:SendBroadcastMessage("|CFFFF0000You have no Target!|R")
			player:GossipComplete()
		end
	end

	if (intid == 51) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:PlaySoundToPlayer(tonumber(Code))
		player:GossipComplete()
		end
	end
	
	if (intid == 52) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:PlaySoundToSet(tonumber(Code))
		player:GossipComplete()
		end
	end
	
	if (intid == 53) then
	if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		LordaeronGamingGameMasterBook.Packet = LuaPacket:CreatePacket(0x0FA, 4)
		LordaeronGamingGameMasterBook.Packet:WriteULong(tonumber(Code))
		player:SendPacketToPlayer(LordaeronGamingGameMasterBook.Packet)
	end
	end
	
	if (intid == 41) then
		LordaeronGamingGameMasterBook.TeleportTargetZ = player:GetSelection()
			if (LordaeronGamingGameMasterBook.TeleportTargetZ == nil) then
				player:SendAreaTriggerMessage("|CFFff0000You have no Target!|R")
				player:GossipComplete()
			else
				LordaeronGamingGameMasterBook.TeleportTargetZMapID = LordaeronGamingGameMasterBook.TeleportTargetZ:GetMapId()
				LordaeronGamingGameMasterBook.TeleportTargetZX = LordaeronGamingGameMasterBook.TeleportTargetZ:GetX()
				LordaeronGamingGameMasterBook.TeleportTargetZY = LordaeronGamingGameMasterBook.TeleportTargetZ:GetY()
				LordaeronGamingGameMasterBook.TeleportTargetZZ = LordaeronGamingGameMasterBook.TeleportTargetZ:GetZ()
				LordaeronGamingGameMasterBook.TeleportTargetZOrientation = LordaeronGamingGameMasterBook.TeleportTargetZ:GetO()
					player:Teleport(LordaeronGamingGameMasterBook.TeleportTargetZMapID, LordaeronGamingGameMasterBook.TeleportTargetZX, LordaeronGamingGameMasterBook.TeleportTargetZY, LordaeronGamingGameMasterBook.TeleportTargetZZ)
					player:SetFacing(LordaeronGamingGameMasterBook.TeleportTargetZOrientation)
					player:GossipComplete()
			end
	end
	
	if (intid == 42) then
		LordaeronGamingGameMasterBook.TeleportTargetJJ = player:GetSelection()
			if (LordaeronGamingGameMasterBook.TeleportTargetJJ == nil) then
				player:SendAreaTriggerMessage("|CFFff0000You have no Target!|R")
				player:GossipComplete()
			else
				LordaeronGamingGameMasterBook.TeleportTargetJJMapID = LordaeronGamingGameMasterBook.TeleportTargetJJ:GetMapId()
				LordaeronGamingGameMasterBook.TeleportTargetJJX = LordaeronGamingGameMasterBook.TeleportTargetJJ:GetX()
				LordaeronGamingGameMasterBook.TeleportTargetJJY = LordaeronGamingGameMasterBook.TeleportTargetJJ:GetY()
				LordaeronGamingGameMasterBook.TeleportTargetJJZ = LordaeronGamingGameMasterBook.TeleportTargetJJ:GetZ()
				LordaeronGamingGameMasterBook.TeleportTargetJJOrientation = LordaeronGamingGameMasterBook.TeleportTargetJJ:GetO()
					player:Teleport(LordaeronGamingGameMasterBook.TeleportTargetJJMapID, LordaeronGamingGameMasterBook.TeleportTargetJJX, LordaeronGamingGameMasterBook.TeleportTargetJJY, LordaeronGamingGameMasterBook.TeleportTargetJJZ)
					player:SetFacing(LordaeronGamingGameMasterBook.TeleportTargetJJOrientation + math.pi)
					player:GossipComplete()
			end
	end
	
	if (intid == 31) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:Teleport(player:GetMapId(), player:GetX() + tonumber(Code), player:GetY(), player:GetZ(), player:GetO())
		player:GossipComplete()
		end
	end
	
	if (intid == 32) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:Teleport(player:GetMapId(), player:GetX(), player:GetY() + tonumber(Code), player:GetZ(), player:GetO())
		player:GossipComplete()
		end
	end
	
	if (intid == 33) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:Teleport(player:GetMapId(), player:GetX(), player:GetY(), player:GetZ() + tonumber(Code), player:GetO())
		player:GossipComplete()
		end
	end
	
	if (intid == 34) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:Teleport(player:GetMapId(), player:GetX() - tonumber(Code), player:GetY(), player:GetZ(), player:GetO())
		player:GossipComplete()
		end
	end
	
	if (intid == 35) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:Teleport(player:GetMapId(), player:GetX(), player:GetY() - tonumber(Code), player:GetZ(), player:GetO())
		player:GossipComplete()
		end
	end
	
	if (intid == 36) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:Teleport(player:GetMapId(), player:GetX(), player:GetY(), player:GetZ() - tonumber(Code), player:GetO())
		player:GossipComplete()
		end
	end

	if (intid == 11) then
		LordaeronGamingGameMasterBook.ChannelTarget = player:GetSelection()
			if (LordaeronGamingGameMasterBook.ChannelTarget == nil) then
				player:SendAreaTriggerMessage("|CFFff0000You have no Target!|R")
				player:GossipComplete()
			else
			if (tonumber(Code) == nil) then
				player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
				player:GossipComplete()
			else
				player:ChannelSpell(tonumber(Code), LordaeronGamingGameMasterBook.ChannelTarget)
				player:GossipComplete()
			end
			end
	end
	
	if (intid == 12) then
		player:StopChannel()
		player:GossipComplete()
	end
	
	if (intid == 21) then
		if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:CastSpell(tonumber(Code))
		player:GossipComplete()
		end
	end
	
	if (intid == 22) then
		LordaeronGamingGameMasterBook.CastSpellTarget = player:GetSelection()
			if (LordaeronGamingGameMasterBook.CastSpellTarget == nil) then
				player:SendAreaTriggerMessage("|CFFff0000You have no Target!|R")
				player:GossipComplete()
			else
			if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
			else
				player:CastSpellOnTarget(tonumber(Code), LordaeronGamingGameMasterBook.CastSpellTarget)
				player:GossipComplete()
			end
			end
	end
	
	if (intid == 23) then
	if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
		player:FullCastSpell(tonumber(Code))
		player:GossipComplete()
	end
	end
	
	if (intid == 24) then
		LordaeronGamingGameMasterBook.FullCastSpellTarget = player:GetSelection()
			if (LordaeronGamingGameMasterBook.FullCastSpellTarget == nil) then
				player:SendAreaTriggerMessage("|CFFff0000You have no Target!|R")
				player:GossipComplete()
			else
			if (tonumber(Code) == nil) then
			player:SendBroadcastMessage("|CFFff0000Code should be a Number!|R")
			player:GossipComplete()
		else
				player:FullCastSpellOnTarget(tonumber(Code), LordaeronGamingGameMasterBook.FullCastSpellTarget)
				player:GossipComplete()
			end
			end
	end
end

RegisterItemGossipEvent(7295, 1, "LordaeronGamingGameMasterBook.OnItemTrigger")
RegisterItemGossipEvent(7295, 2, "LordaeronGamingGameMasterBook.OnItemSelect")