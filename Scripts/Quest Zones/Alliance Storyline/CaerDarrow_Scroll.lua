function ScrollOfNecromancersMagic_OnUseObject(pMisc, event, player)
	if (player:HasQuest(95985) == true) then
		if (player:HasItem(5731) == false) then
			player:AddItem(5731, 1)
			player:CastSpell(53708)
		else
			player:SendBroadcastMessage("The Scroll is empty.")
		end
	else
		player:SendBroadcastMessage("The Scroll is empty.")
	end
end

RegisterGameObjectEvent(95985, 4, "ScrollOfNecromancersMagic_OnUseObject")