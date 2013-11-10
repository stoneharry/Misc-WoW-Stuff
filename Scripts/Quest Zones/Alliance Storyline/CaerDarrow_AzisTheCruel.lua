function AzisTheCruel_AzisOnCombatCD(pUnit, event)
	pUnit:RegisterEvent("AzisTheCruel_RandomAbilityCastCD", 5000, 0)
end

RegisterUnitEvent(95715, 1, "AzisTheCruel_AzisOnCombatCD")

function AzisTheCruel_RandomAbilityCastCD(pUnit, event)
	if (pUnit:GetMainTank() ~= nil) then
	AzisTheCruel_RandomAbility = math.random(1, 4)
		if (AzisTheCruel_RandomAbility == 1) then
			pUnit:FullCastSpellOnTarget(705, pUnit:GetMainTank())
		end
		if (AzisTheCruel_RandomAbility == 2) then
			pUnit:FullCastSpellOnTarget(6222, pUnit:GetMainTank())
		end
		if (AzisTheCruel_RandomAbility == 3) then
			pUnit:FullCastSpellOnTarget(5703, pUnit:GetMainTank())
		end
		if (AzisTheCruel_RandomAbility == 4) then
			pUnit:FullCastSpellOnTarget(16393, pUnit:GetMainTank())
		end
	end
end