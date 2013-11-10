
local Count = 0

function zzzTotem_Thing_On_Gossip(pUnit, event, player)
	if Count == 0 then
   pUnit:GossipCreateMenu(60048, player, 0)
   pUnit:GossipMenuAddItem(4, "Activate the crystal.", 245, 0)
   pUnit:GossipMenuAddItem(4, "Leave the crystal alone.", 250, 0)
   pUnit:GossipSendMenu(player)
   else
   pUnit:GossipCreateMenu(60048, player, 0)
   pUnit:GossipMenuAddItem(4, "The Crystal is in use and can not be used.", 250, 0)
   pUnit:GossipMenuAddItem(4, "Leave the crystal alone.", 250, 0)
   pUnit:GossipSendMenu(player)
   end
end

function zzzTotem_Thing_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 245) then
		if player:HasQuest(852) == true then
		pUnit:CastSpell(49825)
		pUnit:CastSpell(73078)
		Count = 1
		pUnit:SpawnCreature(31239, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 6.1, 35, 0)
		player:GossipComplete()
		else
		player:SendAreaTriggerMessage("You need the required quest: 'Visions: Part Two'.")
		player:SendBroadcastMessage("You need the required quest: 'Visions: Part Two'.")
		player:GossipComplete()
		end
	end
	if(intid == 250) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(29127, 1, "zzzTotem_Thing_On_Gossip")
RegisterUnitGossipEvent(29127, 2, "zzzTotem_Thing_Gossip_Submenus")

----------------------------------------------------------------------------------

function Dragonhawk_God_OnPSAWNSpawn(pUnit, Event)
	pUnit:RegisterEvent("Testtesthsohgorshgroushgosurhgouhosrhgos", 2500, 1)
end

function Testtesthsohgorshgroushgosurhgouhosrhgos(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
	pUnit:SendChatMessage(12,0,"I must thank you "..plr:GetName().." for releasing me from this prison. I will reward you by taking you to a place that shall aid you in your journey.")
	pUnit:RegisterEvent("Now_We_Go_For_A_RIDE__RIEAEAJIE_EAIKNGHIEXNHE_S", 8000, 1)
	else
	pUnit:Despawn(1,0)
	Count = 0
	end
end

function Now_We_Go_For_A_RIDE__RIEAEAJIE_EAIKNGHIEXNHE_S(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
	plr:SetPhase(2)
	local Taxi = LuaTaxi:CreateTaxi()
	Taxi:AddPathNode(0, -9279, -3299, 176)
	Taxi:AddPathNode(1, 7553, -2645, 683)
	Taxi:AddPathNode(1, 7718, -2688, 561)
	Taxi:AddPathNode(1, 7769, -2573, 530)
	Taxi:AddPathNode(1, 7614, -2469, 474)
	Taxi:AddPathNode(1, 7535, -2298, 487)
	Taxi:AddPathNode(1, 7458, -2202, 537)
	Taxi:AddPathNode(1, 7384.7, -2201.6, 534)
	Taxi:AddPathNode(1, 7384.7, -2201.6, 534)
	plr:StartTaxi(Taxi, 27525)
	end
	pUnit:Despawn(1,0)
	Count = 0
end

RegisterUnitEvent(31239, 18, "Dragonhawk_God_OnPSAWNSpawn")