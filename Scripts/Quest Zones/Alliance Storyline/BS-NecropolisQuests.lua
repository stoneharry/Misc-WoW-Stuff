
local Shield

function zzzrsjhMogash_OnCombatzz(pUnit, Event)
	Shield = pUnit
end

RegisterUnitEvent(296371, 18, "zzzrsjhMogash_OnCombatzz")

function ewazzzrsjhMogash_OnCombatzz(pUnit, Event)
	pUnit:RegisterEvent("ChannelSpellAtShieldGenerater", 1000, 1)
end

function ChannelSpellAtShieldGenerater(pUnit, Event)
	if Shield ~= nil then
		pUnit:ChannelSpell(29172, Shield)
	end
end

function ewazzzrsjhMogash_OnCombatzzz(pUnit, Event)
	pUnit:StopChannel()
	pUnit:FullCastSpell(168)
	pUnit:RegisterEvent("Frostbolt_lich_necro", 7000, 0)
end

function Frostbolt_lich_necro(pUnit, Event)
	pUnit:FullCastSpell(122)
end

function ewazzzrsjhMogash_OnCombatzzzz(pUnit, Event)
	pUnit:RemoveEvents()
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		if plr:HasQuest(31) == true then
			plr:MarkQuestObjectiveAsComplete(31, 0)
			plr:SetPhase(1)
		end
	end
end

function zewazzzrsjhMogash_OnCombatzzzz(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(159451, 18, "ewazzzrsjhMogash_OnCombatzz")
RegisterUnitEvent(159451, 1, "ewazzzrsjhMogash_OnCombatzzz")
RegisterUnitEvent(159451, 3, "zewazzzrsjhMogash_OnCombatzzzz")
RegisterUnitEvent(159451, 4, "ewazzzrsjhMogash_OnCombatzzzz")