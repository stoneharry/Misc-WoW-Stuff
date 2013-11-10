function TheWitch_Spawn(pUnit, Event)
	pUnit:AIDisableCombat(false)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	pUnit:RegisterEvent("Witch_Defeated", 2000, 0)
end

RegisterUnitEvent(432145, 18, "TheWitch_Spawn")

function Witch_Defeated(pUnit,Event)
	if pUnit:GetHealthPct() < 10 then
		pUnit:RemoveEvents()
		pUnit:AIDisableCombat(true)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,2)
		pUnit:Despawn(4000, 2000)
		pUnit:SendChatMessage(12, 0, "ALRIGHT! I'll release the brats.")
		pUnit:Emote(20, 2000)
		pUnit:RegisterEvent("Witch_defeated_part", 3000, 1)
	end
end

function Witch_defeated_part(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for _, players in pairs(PlayersAllAround) do
		if players ~= nil and pUnit:GetDistanceYards(players) < 14 and
		 players:HasQuest(5324) == true and players:GetQuestObjectiveCompletion(5324, 0) ~= 1 then
			players:AdvanceQuestObjective(5324, 0)
			players:SetPhase(1)
		end
	end
end
