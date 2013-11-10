
function PassiveElementalQuestGossip(pUnit, event, player)
    pUnit:GossipCreateMenu(5292, player, 0)
    if player:HasQuest(6503) == true then
		pUnit:GossipMenuAddItem(4, "Anger the spirit.", 11, 0)
    end
	pUnit:GossipMenuAddItem(4, "Leave the spirit alone.", 3, 0)
    pUnit:GossipSendMenu(player)
end

function PassiveElementalQuestClick(pUnit, event, player, id, intid, code)
	if(intid == 11) then
		player:GossipComplete()
		pUnit:Emote(35, 3000)
		player:CastSpell(59551) -- visual
		player:SetFacing(0.391691)
		player:MoveKnockback(-6752, -2394, 387.2, 5, 10)
		RegisterTimedEvent("Remove_visual_whirldwind", 13000, 1, player)
	end
	if(intid == 3) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(30849, 1, "PassiveElementalQuestGossip")
RegisterUnitGossipEvent(30849, 2, "PassiveElementalQuestClick")

function Remove_visual_whirldwind(player)
	if player ~= nil then
		player:RemoveAura(59551) -- visual
	end
end

function MovePlayerBackToSpawnTrololol(pUnit, event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if plr:HasQuest(6503) then
			plr:SetFacing(0.951136)
			plr:MoveKnockback(-6685, -2198, 249, 5, 10)
			plr:CastSpell(59551) -- visual
			RegisterTimedEvent("Remove_visual_whirldwind", 11000, 1, plr)
		end
	end
end

RegisterUnitEvent(5855, 4, "MovePlayerBackToSpawnTrololol")

-- Demon hunter

function DemonHunterOnCombatBadl(pUnit, Event)
	pUnit:CastSpell(35322) -- empower self
end

RegisterUnitEvent(43002,1,"DemonHunterOnCombatBadl")
