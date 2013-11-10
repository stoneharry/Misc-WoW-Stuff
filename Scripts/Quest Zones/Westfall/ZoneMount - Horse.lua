


function WhiteSteed_Mount(item, event, player)
	if player:GetZoneId() == 40 then
	player:FullCastSpell(23228)
	else
	player:SendAreaTriggerMessage("|cFFFF0000You need to be in Westfall!")
	player:CancelSpell()
end
end


RegisterItemGossipEvent(18778, 1, "WhiteSteed_Mount")