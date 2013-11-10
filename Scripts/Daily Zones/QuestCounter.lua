--NOTE THIS SCRIPT WILL SEEM UNFINISHED, IT IS. DO NOT TOUCH UNLESS CAUSING ERRORS, WHICH SHOULD NOT.
--|TTexturePath:size1:size2:xoffset:yoffset|t


function QuestCounter_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(907, player, 0)
	pUnit:GossipMenuAddItem(10, "|cff00ff00|TInterface\\icons\\achievement_quests_completed_daily_01:30|t|r Rank 1", 246, 0)
		--pUnit:GossipMenuAddItem(10, "|cff00ff00|TInterface\\icons\\achievement_quests_completed_05:30|t|r Rank 2", 247, 0)
				--pUnit:GossipMenuAddItem(10, "|cff00ff00|TInterface\\icons\\achievement_quests_completed_07:30|t|r Rank 3", 248, 0)
						--pUnit:GossipMenuAddItem(10, "|cff00ff00|TInterface\\icons\\achievement_quests_completed_08:30|t|r Rank 4", 249, 0)
	pUnit:GossipMenuAddItem(0, "...Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end

function QuestCounter_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if (intid == 246) then
	pUnit:GossipCreateMenu(1511, player, 0)
	if not player:HasFinishedQuest(292072) then
	pUnit:GossipMenuAddItem(10, "|cff00ff00|TInterface\\icons\\achievement_quests_completed_07:30|t|r {The Gogomoa}", 300, 0)
	else
		pUnit:GossipMenuAddItem(10, "|cff00ff00|TInterface\\icons\\achievement_quests_completed_07:30|t|r {The Gogomoa} [COMPLETE]", 260, 0)
	end
		if not player:HasFinishedQuest(292073) then
	pUnit:GossipMenuAddItem(10, "|cff00ff00|TInterface\\icons\\achievement_quests_completed_07:30|t|r {Lord of The Sea}", 301, 0)
	else
		pUnit:GossipMenuAddItem(10, "|cff00ff00|TInterface\\icons\\achievement_quests_completed_07:30|t|r {Lord of The Sea} [COMPLETE]", 260, 0)
	end
	pUnit:GossipMenuAddItem(0, "Back.", 260, 0)
	pUnit:GossipSendMenu(player)
	elseif(intid == 260) then
	QuestCounter_On_Gossip(pUnit, 1, player)
	elseif(intid == 300) then --RANK 1 STARTS HERE
		if not player:HasQuest(292072) or player:HasFinishedQuest(292072) then
		player:StartQuest(292072)
		player:SendBroadcastMessage("[EoC-Addon]- -3-3-Quest Accepted-The Gogomoa!")
		player:GossipComplete()
		elseif player:HasQuest(292072) and player:GetQuestObjectiveCompletion(292072, 0) == 1 then
		player:FinishQuest(292072)
		player:SendBroadcastMessage("[EoC-Addon]- -3-3-Quest Complete-The Gogomoa!")
		player:GossipComplete()
		end
			elseif(intid == 301) then --RANK 1 STARTS HERE
		if not player:HasQuest(292073) or player:HasFinishedQuest(292073) then
		player:StartQuest(292073)
		player:SendBroadcastMessage("[EoC-Addon]- -3-3-Quest Accepted-Lord of the Sea!")
		player:GossipComplete()
				elseif player:HasQuest(292072) and player:GetQuestObjectiveCompletion(292072, 0) == 1 then
		player:FinishQuest(292073)
		player:SendBroadcastMessage("[EoC-Addon]- -3-3-Quest Complete-Lord of the Sea!")
		player:GossipComplete()
		end
			elseif(intid == 250) then
				player:GossipComplete()
	end
end



RegisterUnitGossipEvent(335499, 1, "QuestCounter_On_Gossip")
RegisterUnitGossipEvent(335499, 2, "QuestCounter_Gossip_Submenus")