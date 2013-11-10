function StormwindInfantryman_RestoreHpRarely(pUnit, event)
	pUnit:RegisterEvent("StormwindInfantryMan_RestoreHPToFull", 21000, 0)
end

RegisterUnitEvent(15858, 1, "StormwindInfantryman_RestoreHpRarely")

function StormwindInfantryMan_RestoreHPToFull(pUnit, event)
	pUnit:SetHealthPct(100)
end

function TatteredAbomination_RestoreHpRarelyWW(pUnit, event)
	pUnit:RegisterEvent("TatteredAbomination_RestoreHPToFullASDF", 21000, 0)
end

RegisterUnitEvent(27797, 1, "TatteredAbomination_RestoreHpRarelyWW")

function TatteredAbomination_RestoreHPToFullASDF(pUnit, event)
	pUnit:SetHealthPct(100)
end

function Selina_CDOnSpawn(pUnit, event)
	pUnit:RegisterEvent("Selina_CDStealthSpell", 1000, 1)
end

RegisterUnitEvent(95755, 18, "Selina_CDOnSpawn")

function Selina_CDStealthSpell(pUnit, event)
	pUnit:CastSpell(1784)
end

function InjuredInfantryman_OnSpawnCDH(pUnit, event)
	pUnit:RegisterEvent("InjuredInfantryman_LowHPAgainOH", 21000, 0)
end

RegisterUnitEvent(16865, 18, "InjuredInfantryman_OnSpawnCDH")

function InjuredInfantryman_LowHPAgainOH(pUnit, event)
	pUnit:SetHealthPct(10)
end