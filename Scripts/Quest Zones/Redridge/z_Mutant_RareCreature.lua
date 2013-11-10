
function MUtant_Redridgeoncombat(pUnit, event)
	pUnit:PlaySoundToSet(416) -- murloc aggro
	pUnit:CastSpellOnTarget(4286, pUnit:GetClosestPlayer()) -- poison spit
	pUnit:FullCastSpell(71603)
	pUnit:RegisterEvent("SPAM_CURSE_MURLOCMAN", 15000, 0)
	pUnit:RegisterEvent("checkforhealth_mutant", 1000, 0)
end

function SPAM_CURSE_MURLOCMAN(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		if pUnit:GetHealthPct() < 25 then
			pUnit:CastSpellOnTarget(37054, plr)
		else
			pUnit:FullCastSpellOnTarget(17738, plr)
		end
	end
end

function checkforhealth_mutant(pUnit)
	if pUnit:GetHealthPct() < 25 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(7383) -- immune!
		pUnit:PlaySoundToSet(416) -- murloc aggro
		pUnit:CastSpellOnTarget(4286, pUnit:GetClosestPlayer()) -- poison spit
		pUnit:FullCastSpell(71603)
		pUnit:CastSpell(28315) -- fear aura
		pUnit:RegisterEvent("SPAM_CURSE_MURLOCMAN", 4000, 0)
	end
end

function MUtant_Redridgeonleave(pUnit, event)
	pUnit:RemoveEvents()
end

function MUtant_Redridgeondeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(192481, 1, "MUtant_Redridgeoncombat")
RegisterUnitEvent(192481, 2, "MUtant_Redridgeonleave")
RegisterUnitEvent(192481, 4, "MUtant_Redridgeondeath")
