
function Omen_OnCombat(pUnit, Event)
 pUnit:RegisterEvent("Omen_Moonfire", 3500, 0)
 pUnit:RegisterEvent("Omen_Visual", 20000, 0)
end

function Omen_Moonfire(pUnit, Event)
 if pUnit:GetRandomPlayer(0) == nil then
 else
 pUnit:CastSpellOnTarget(8924, pUnit:GetRandomPlayer(0))
 end
end

function Omen_Visual(pUnit, Event)
	pUnit:CastSpell(59084)
	pUnit:CastSpell(1449)
end

function Omen_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function Omen_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

RegisterUnitEvent(15467, 1, "Omen_OnCombat")
RegisterUnitEvent(15467, 2, "Omen_OnLeave")
RegisterUnitEvent(15467, 4, "Omen_OnDead")
