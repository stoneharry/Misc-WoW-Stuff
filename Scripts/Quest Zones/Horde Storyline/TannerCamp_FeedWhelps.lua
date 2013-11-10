
function FeedWhelpling_On_Gossip(pUnit, event, player)
	if player:HasQuest(8601) and player:HasItem(12623) and (player:GetQuestObjectiveCompletion(8601, 0) ~= 5) and pUnit:HasAura(19872) == false then
		player:RemoveItem(12623,1)
		player:AdvanceQuestObjective(8601, 0)
		pUnit:CastSpell(19872)
		local choice = math.random(1,3)
		if choice == 1 then
			pUnit:SendChatMessageToPlayer(12,0,"Nom nom nom nom.",player)
		elseif choice == 2 then
			pUnit:SendChatMessageToPlayer(12,0,"Finally, so hungry!",player)
		elseif choice == 3 then
			pUnit:SendChatMessageToPlayer(12,0,"Mmmm!",player)
		end
	else
		pUnit:SendChatMessageToPlayer(12,0,"You bring me food?",player)
	end
end

RegisterUnitGossipEvent(39406, 1, "FeedWhelpling_On_Gossip")