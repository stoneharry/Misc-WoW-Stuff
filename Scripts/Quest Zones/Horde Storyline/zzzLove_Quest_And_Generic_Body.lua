
--[[function Dead_Guy_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(60042, player, 0)
	pUnit:GossipMenuAddItem(4, "Poke the body.", 246, 0)
	pUnit:GossipMenuAddItem(4, "Forget it.", 247, 0)
   pUnit:GossipSendMenu(player)
end


function Dead_Guy_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 246) then
	player:CastSpell(56525)
	player:GossipComplete()
	end
	if(intid == 247) then
	player:GossipComplete()
	end
end

RegisterUnitGossipEvent(293951, 1, "Dead_Guy_On_Gossip")
RegisterUnitGossipEvent(293951, 2, "Dead_Guy_Submenus")]]

------------------------------------------------------------------------------------

function Love_Person_On_Gossip(pUnit, event, player)
   pUnit:FullCastSpell(20372)
   pUnit:GossipCreateMenu(60029, player, 0)
   		if player:HasQuest(838) == true then
		pUnit:GossipMenuAddItem(0, "I know what you are, fiend!", 200, 0)
		end
   pUnit:GossipMenuAddItem(0, "Greetings lady, what brings you to these barren lands?", 240, 0)
   pUnit:GossipMenuAddItem(0, "Nevermind.", 247, 0)
   pUnit:GossipSendMenu(player)
end


function Love_Person_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 200) then
	pUnit:SpawnCreature(1863, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 22, 120000)
	player:GossipComplete()
	pUnit:Despawn(1, 120000)
	end
	if(intid == 240) then
	pUnit:GossipCreateMenu(60030, player, 0)
	pUnit:GossipMenuAddItem(0, "I was wondering what sort of services you offer?", 241, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 247, 0)
    pUnit:GossipSendMenu(player)
	end
	if(intid == 241) then
	pUnit:GossipCreateMenu(60031, player, 0)
	pUnit:GossipMenuAddItem(0, "Ah... I see. Now if you excuse me I must be off!", 242, 0)
	pUnit:GossipMenuAddItem(0, "Remind me, why are you here?", 240, 0)
    pUnit:GossipSendMenu(player)
	end
	if(intid == 242) then
		if player:HasQuest(837) == true then
		player:MarkQuestObjectiveAsComplete(837, 0)
		end
	pUnit:SendChatMessageToPlayer(12,0,"Drop by anytime you need my.. services.. "..player:GetName()..".", player)
	pUnit:SendChatMessageToPlayer(15,0,"You know you want it.", player)
	player:GossipComplete()
	end
	if(intid == 247) then
	player:GossipComplete()
	end
end

RegisterUnitGossipEvent(65, 1, "Love_Person_On_Gossip")
RegisterUnitGossipEvent(65, 2, "Love_Person_Submenus")

function Peasent_On_Spawn_Love(pUnit, Event)
	pUnit:RegisterEvent("wait_a_sec_then___SPAM", 2500, 1)
end

function wait_a_sec_then___SPAM(pUnit, Event)
	pUnit:FullCastSpell(20372)
end

RegisterUnitEvent(65, 18, "Peasent_On_Spawn_Love")

function Succubus_On_Spawn_Love(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "It's spanking time!")
end

RegisterUnitEvent(1863, 1, "Succubus_On_Spawn_Love")


