--Blackrock Mountain
function DualSpec_On_Gossip(pUnit, event, player)
	if player:HasAchievement(2716) == false then
		pUnit:GossipCreateMenu(564, player, 0)
		pUnit:GossipMenuAddItem(6, "I wish to have a secondary talent spec.", 2, 0)
	else
		pUnit:GossipCreateMenu(14394, player, 0)
	end
	pUnit:GossipMenuAddItem(6, "I would like to reset my talents.", 4, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end

function DualSpec_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if (intid == 3) then
		if player:GetCoinage() >= 150000 then
			pUnit:CastSpellOnTarget(46331,player)
			player:DealGoldCost(150000)
			player:AddAchievement(2716)
			player:CastSpell(63624)
			player:LearnSpell(63644)
			player:LearnSpell(63645)
			player:GossipComplete()
		else
			player:SendAreaTriggerMessage("|cffffff00You do not have enough money.|r")
			player:GossipComplete()
		end
	end
	if (intid == 2) then
		if player:HasAchievement(2716) == false then
			pUnit:GossipCreateMenu(14391, player, 0)
			pUnit:GossipMenuAddItem(6, "(|CFFFFFF01Pay 15 Gold|R)", 3, 0)
			pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
			pUnit:GossipSendMenu(player)
		end
	end
	if (intid == 4) then
		pUnit:GossipCreateMenu(5674, player, 0)
		pUnit:GossipMenuAddItem(6, "I understand, continue.",5, 0)
		pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
		pUnit:GossipSendMenu(player)
	end
	if (intid == 5) then
		if player:GetCoinage() >= 50000 then
			pUnit:CastSpellOnTarget(46331,player)
			player:ResetAllTalents()
			player:DealGoldCost(50000)
		else
			player:SendAreaTriggerMessage("|cffffff00You do not have enough money.|r")
        end
		player:GossipComplete()
	end
	if(intid == 250) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(98733, 1, "DualSpec_On_Gossip")
RegisterUnitGossipEvent(98733, 2, "DualSpec_Gossip_Submenus")
RegisterUnitGossipEvent(440962, 1, "DualSpec_On_Gossip")
RegisterUnitGossipEvent(440962, 2, "DualSpec_Gossip_Submenus")