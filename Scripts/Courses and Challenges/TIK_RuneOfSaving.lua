--By Tikki

function TIK_RuneOfSaving(item, event, player)
	if player:GetMapId() == 13 then
		player:Teleport(0, -7555, -1200, 477)
	else
		player:SendAreaTriggerMessage("|cFFFF0000You must be inside a maze to use that!")
	end
end

RegisterItemGossipEvent(13815, 1, "TIK_RuneOfSaving")