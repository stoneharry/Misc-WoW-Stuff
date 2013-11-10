-- Sack of Relics

function SackOfRelicsOnClick(pUnit, event, player)
	if player:HasQuest(1301) then
		if player:GetQuestObjectiveCompletion(1301, 0) ~= 8 then
			player:AddItem(23779, 1)
			pUnit:Despawn(1, 90000)
		end
	elseif player:HasQuest(1104) then
		if player:GetQuestObjectiveCompletion(1104, 0) ~= 8 then
			player:AddItem(23779, 1)
			pUnit:Despawn(1, 90000)
		end
	end
end

RegisterUnitGossipEvent(24439, 1, "SackOfRelicsOnClick")