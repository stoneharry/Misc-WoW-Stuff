
local ready = false
local i = 0

function CrazyGnomeGossip(pUnit, event, player)
    pUnit:GossipCreateMenu(908, player,0)
	pUnit:GossipMenuAddItem(0, "Sure, sign me up.", 246, 0)
    pUnit:GossipMenuAddItem(0, "There is no way you're getting me on that thing.", 250, 0)
    pUnit:GossipSendMenu(player)
end

function CrazyGnomeClick(pUnit, event, player, id, intid, code)
	if(intid == 246) then
		pUnit:SendChatMessage(12,0,"A willing volunteer, fantastic!")
		player:Teleport(0, -9066.14, -2610.57, 140.55)
		player:SetFacing(4.074393)
		player:SetMount(23647)
		player:SetPlayerLock(1)
		pUnit:SetNPCFlags(2)
		ready = true
		player:GossipComplete()
	end
	if(intid == 250) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(129441, 1, "CrazyGnomeGossip")
RegisterUnitGossipEvent(129441, 2, "CrazyGnomeClick")

function CrazyGnomeSpawn(pUnit, event)
	pUnit:RegisterEvent("CheckForCrazyStart", 2500, 0)
end

function CheckForCrazyStart(pUnit)
	if ready then
		pUnit:SendChatMessage(14,0,"Boys, get her loaded up!")
		pUnit:Emote(5, 3000)
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("SendPlayerOff_Crazygnome", 5000, 1)
	end
end

function SendPlayerOff_Crazygnome(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if i == 0 then
			pUnit:SendChatMessageToPlayer(42,0,"5", plr)
			pUnit:Emote(10, 5000)
			pUnit:RegisterEvent("SendPlayerOff_Crazygnome", 1000, 1)
		elseif i == 1 then
			pUnit:SendChatMessageToPlayer(42,0,"4", plr)
			pUnit:RegisterEvent("SendPlayerOff_Crazygnome", 1000, 1)
		elseif i == 2 then
			pUnit:SendChatMessageToPlayer(42,0,"3", plr)
			pUnit:RegisterEvent("SendPlayerOff_Crazygnome", 1000, 1)
		elseif i == 3 then
			pUnit:SendChatMessageToPlayer(42,0,"2", plr)
			pUnit:RegisterEvent("SendPlayerOff_Crazygnome", 1000, 1)
		elseif i == 4 then
			pUnit:SendChatMessageToPlayer(42,0,"1", plr)
			pUnit:RegisterEvent("SendPlayerOff_Crazygnome", 1000, 1)
		elseif i == 5 then
			pUnit:SendChatMessageToPlayer(42,0,"Blast off!", plr)
			pUnit:SendChatMessage(14,0,"There she goes!")
			plr:Dismount()
			i = 0
			ready = false
			plr:SetPlayerLock(0)
			local Taxi = LuaTaxi:CreateTaxi()
			Taxi:AddPathNode(0, -9068.9, -2613.6, 141.6)
			Taxi:AddPathNode(0, -9087, -2627, 159)
			Taxi:AddPathNode(0, -9100, -2646, 218)
			Taxi:AddPathNode(0, -9117, -2671, 351)
			Taxi:AddPathNode(0, -9130, -2690, 551)
			Taxi:AddPathNode(0, -9202, -2747, 542)
			Taxi:AddPathNode(0, -9306, -2753, 447)
			Taxi:AddPathNode(0, -9358, -2702, 313)
			Taxi:AddPathNode(0, -9405, -2679, 134)
			Taxi:AddPathNode(0, -9507, -2648, 61)
			Taxi:AddPathNode(0, -9565, -2626, 54.6)
			Taxi:AddPathNode(0, -9597.9, -2609, 55)
			plr:StartTaxi(Taxi, 23647)
			pUnit:SetNPCFlags(1)
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("CheckForCrazyStart", 2500, 0)
			RegisterTimedEvent("blow_up_plr_crazygnome_fun", 500, 75, plr)
		end
		i = i + 1
	else
		i = 0
		ready = false
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("CheckForCrazyStart", 2500, 0)
	end
end

RegisterUnitEvent(129441, 18, "CrazyGnomeSpawn")

function blow_up_plr_crazygnome_fun(plr)
	if plr ~= nil then
		if math.random(1,2) == 1 then
				plr:CastSpell(71495)
		end
		plr:CastSpell(40162)
	end
end
