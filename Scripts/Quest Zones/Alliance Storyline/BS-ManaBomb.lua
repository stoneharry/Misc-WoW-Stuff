
function Bomb_Goes_Boom_Chika_Chow_WoW(pUnit, Event)
	for _, plr in pairs(pUnit:GetInRangePlayers()) do
		if plr:HasQuest(25) then
			plr:MarkQuestObjectiveAsComplete(25, 0)
		end
	end
	pUnit:Root()
	pUnit:DisableCombat(true)
	pUnit:SendChatMessage(42, 0, "The Mana Bomb has been activated and will detonate in 15 seconds. Escape the building!")
	pUnit:RegisterEvent("OhaiATimer_Bomb_B", 5000, 1)
end

RegisterUnitEvent(265331, 1, "Bomb_Goes_Boom_Chika_Chow_WoW")

function OhaiATimer_Bomb_B(pUnit, Event)
		pUnit:SendChatMessage(42, 0, "The Mana Bomb will detonate in 10 seconds!")
	pUnit:RegisterEvent("OhaiATimer_Bomb_C", 5000, 1)
end

function OhaiATimer_Bomb_C(pUnit, Event)
		pUnit:SendChatMessage(42, 0, "The Mana Bomb will detonate in 5 seconds!")
	pUnit:RegisterEvent("OhaiATimer_Bomb_D", 1000, 1)
end

function OhaiATimer_Bomb_D(pUnit, Event)
		pUnit:SendChatMessage(42, 0, "The Mana Bomb will detonate in 4 seconds!")
	pUnit:RegisterEvent("OhaiATimer_Bomb_E", 1000, 1)
end

function OhaiATimer_Bomb_E(pUnit, Event)
		pUnit:SendChatMessage(42, 0, "The Mana Bomb will detonate in 3 seconds!")
	pUnit:RegisterEvent("OhaiATimer_Bomb_F", 1000, 1)
end

function OhaiATimer_Bomb_F(pUnit, Event)
		pUnit:SendChatMessage(42, 0, "The Mana Bomb will detonate in 2 seconds!")
	pUnit:RegisterEvent("OhaiATimer_Bomb_G", 1000, 1)
end

function OhaiATimer_Bomb_G(pUnit, Event)
		pUnit:SendChatMessage(42, 0, "The Mana Bomb will detonate in 1 seconds!")
	pUnit:RegisterEvent("OhaiATimer_Bomb_H", 1000, 1)
end

function OhaiATimer_Bomb_H(pUnit, Event)
	pUnit:SendChatMessage(42, 0, "The Mana Bomb detonates!")
	for _, plr in pairs(pUnit:GetInRangePlayers()) do
		plr:CastSpell(45849) --Camera Shake, for the extra drama
		if pUnit:GetDistanceYards(plr) < 48 then
			pUnit:CastSpellOnTarget(11, plr)
		end
		plr:SetPhase(1)
	end
	pUnit:CastSpell(63660)
	pUnit:SetHealth(1)
	pUnit:CastSpell(11)
end
