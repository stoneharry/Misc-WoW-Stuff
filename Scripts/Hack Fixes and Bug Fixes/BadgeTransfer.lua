
function Badge_Transfer(item, event, player)
	player:AddItem(29434,5)
	player:CastSpell(8596)
	player:RemoveItem(item,1)
end

RegisterItemGossipEvent(20801, 1, "Badge_Transfer")