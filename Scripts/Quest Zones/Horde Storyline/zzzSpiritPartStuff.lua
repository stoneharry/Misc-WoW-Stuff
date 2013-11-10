
--local Visual = 0

function Trigger_LicH_KIngz(pUnit, Event)
	pUnit:RegisterEvent("laowjyoiahoyheozheorluhs_lichking", math.random(1000,3000), 1)
end

function laowjyoiahoyheozheorluhs_lichking(pUnit, Event)
	local Triggerz = pUnit:GetCreatureNearestCoords(-6480.34, -972.837, 338.5233, 201562)
	if Triggerz ~= nil then
	pUnit:ChannelSpell(689, Triggerz)
	end
end

RegisterUnitEvent(23411, 18, "Trigger_LicH_KIngz")

function LichKIng_REal_Phase_Two(pUnit, Event)
	pUnit:RegisterEvent("eaoyhaoga_lich_kion_phase_two", 2500, 0)
end

function eaoyhaoga_lich_kion_phase_two(pUnit, Event)
	--if Visual == 0 then
	--Visual = 1
	pUnit:FullCastSpell(72523)
	--else
		local zchoice = math.random(1,3)
		if zchoice == 1 then
		pUnit:CastSpell(43759) -- arcane explosion
		end
		if zchoice == 2 then
		pUnit:CastSpell(8609) -- Cyclone visual
		end
		if zchoice == 3 then
		pUnit:CastSpell(60081) -- fire explosion
		end
	--end
end

RegisterUnitEvent(3072112, 18, "LichKIng_REal_Phase_Two")

---------------------------------------------------------------------------------

--60049 gossip id

function Totem_Thing_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(60049, player, 0)
   if player:HasQuest(835) then
	pUnit:GossipMenuAddItem(4, "Activate the totem using your Darkmatter.", 245, 0)
   end
   pUnit:GossipMenuAddItem(4, "Leave the totem alone.", 250, 0)
   pUnit:GossipSendMenu(player)
end

function Totem_Thing_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 245) then
		if player:HasQuest(835) == true then
			if player:HasItem(79001) == true then
			player:RemoveItem(79001, 1)
			player:MarkQuestObjectiveAsComplete(835, 0)
			pUnit:CastSpell(63660)
			player:RemoveAura(61611)
			player:SetPhase(1)
			pUnit:SpawnCreature(3769552, -6487, -1001, 341.2, 4.562202, 15, 120000)
			pUnit:SpawnCreature(3769552, -6495, -1003, 341.2, 5.469336, 15, 120000)
			player:GossipComplete()
			else
			player:SendAreaTriggerMessage("Not enough Darkmatter aquired.")
			player:SendBroadcastMessage("Not enough Darkmatter aquired.")
			player:GossipComplete()
			end
		else
		player:SendAreaTriggerMessage("You need the required quest: 'Delaying the Lich King's Return'.")
		player:SendBroadcastMessage("You need the required quest: 'Delaying the Lich King's Return'.")
		player:GossipComplete()
		end
	end
	if(intid == 250) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(1421111, 1, "Totem_Thing_On_Gossip")
RegisterUnitGossipEvent(1421111, 2, "Totem_Thing_Gossip_Submenus")

----------------------------------------------------------------------------------

function zzDredge_Ghouls_OnSpawn(pUnit, Event)
	pUnit:RegisterEvent("zzTestRootFunctionNextSecond", 1, 1)
end

function zzTestRootFunctionNextSecond(pUnit, Event)
	pUnit:Emote(449, 4500) -- spawn animation
	pUnit:Root() -- Root him while he spawns
	pUnit:RegisterEvent("zzDelay_A_Second_And_See_WhatHappens_Tehe", math.random(1,1000), 1)
	pUnit:RegisterEvent("zzSetFactionToHostileForTheEmote", 5500, 1)
end

function zzDelay_A_Second_And_See_WhatHappens_Tehe(pUnit, Event)
	pUnit:CastSpell(55719)
end

function zzSetFactionToHostileForTheEmote(pUnit, Event)
	pUnit:Unroot() -- let him run free
	pUnit:SetFaction(21) -- hostile
end

RegisterUnitEvent(3769552, 18, "zzDredge_Ghouls_OnSpawn")

-------------------------------------------------------------------------------------------