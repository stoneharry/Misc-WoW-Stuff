function SnatchHatchling_On_Gossip(pUnit, event, player)
	if player:IsMounted() then
		player:Dismount()
	end
	if player:HasQuest(9033) == false then
	else
		if player:GetItemCount(46362) == 8 then
			player:SendAreaTriggerMessage("|cffffff00You have enough hatchlings!|r")
		else
		pUnit:SetNPCFlags(2)
		player:AddItem(46362,1)
		pUnit:Emote(35,1000)
		player:PlaySoundToPlayer(704)
		pUnit:Despawn(100,13000)
		for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 29334 then 
		if creature:IsDead() == false then
	if creature:IsInCombat() == false then
	if pUnit:GetDistanceYards(creature) < 12 then
	creature:MoveTo(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO())
	creature:CastSpell(41305)
		pUnit:ModifyRunSpeed(14)
	pUnit:ModifyWalkSpeed(8)
	creature:SendChatMessageToPlayer(42,0,"The hatchling's mother spotted you!",player)
		end
	end
end
	end
		end
			end
		end
	end
	
	function Hatchling_Spawn(pUnit,Event)
pUnit:SetNPCFlags(1)
end

RegisterUnitEvent(35400, 18, "Hatchling_Spawn")




RegisterUnitGossipEvent(35400, 1, "SnatchHatchling_On_Gossip")