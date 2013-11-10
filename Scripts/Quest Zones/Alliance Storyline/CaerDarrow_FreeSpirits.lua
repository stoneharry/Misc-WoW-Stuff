CaerDarrowSpiritsFreedQuest = {}

function CaerDarrowSpiritsFreedQuest.CannibalGhoulOnDeath(pUnit, event, pKiller)
	if (pKiller:IsPlayer() == true) then
		if (pKiller:HasQuest(95780) == true) then
			if (pKiller:GetQuestObjectiveCompletion(95780, 0) <= 5) then
				pUnit:SpawnCreature(95790, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 35, 10000, 1727, 6320, 0)
				pKiller:AdvanceQuestObjective(95780, 0)
			end
		end
	end
end

RegisterUnitEvent(95785, 4, "CaerDarrowSpiritsFreedQuest.CannibalGhoulOnDeath")

function CaerDarrowSpiritsFreedQuest.SpiritOfCaerDarrowOnSpawn(pUnit, event)
	pUnit:RegisterEvent("CaerDarrowSpiritsFreedQuest.TalkWithPlayerNowASD", 1000, 1)
	pUnit:CastSpell(37755)
end

function CaerDarrowSpiritsFreedQuest.TalkWithPlayerNowASD(pUnit, event)
	CaerDarrowSpiritsFreedQuest.RandomMessageGBAOU = math.random(1, 5)
		if (CaerDarrowSpiritsFreedQuest.RandomMessageGBAOU == 1) then
			pUnit:SendChatMessage(12, 0, "Oh, thank you! I have been trapped in this nightmare for too long.")
		end
		if (CaerDarrowSpiritsFreedQuest.RandomMessageGBAOU == 2) then
			pUnit:SendChatMessage(12, 0, "Thank you! The battle for Caer Darrow doomed me for eternity, but you have set me free.")
		end
		if (CaerDarrowSpiritsFreedQuest.RandomMessageGBAOU == 3) then
			pUnit:SendChatMessage(12, 0, "You set me free! Thank you!")
		end
		if (CaerDarrowSpiritsFreedQuest.RandomMessageGBAOU == 4) then
			pUnit:SendChatMessage(12, 0, "I thought I would never return! Thanks a lot.")
		end
		if (CaerDarrowSpiritsFreedQuest.RandomMessageGBAOU == 5) then
			pUnit:SendChatMessage(12, 0, "You're my hero! Your deed will not remain unpaid.")
		end
end

RegisterUnitEvent(95790, 18, "CaerDarrowSpiritsFreedQuest.SpiritOfCaerDarrowOnSpawn")