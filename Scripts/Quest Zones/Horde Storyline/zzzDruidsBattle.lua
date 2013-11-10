

function druid_heal_spam_when_alive(pUnit, Event)
	pUnit:RegisterEvent("heal_spam_when_druid", 15000, 0)
	if math.random(1,2) == 1 then
		pUnit:CastSpell(1126) -- mark of the wild
	else
		pUnit:CastSpell(467) -- thorns
	end
end

function heal_spam_when_druid(pUnit, Event)
	pUnit:SetHealth(pUnit:GetMaxHealth())
end

function HEAP_SPAM_WHEN_ALIVE_DRACODARdead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(250791, 18, "druid_heal_spam_when_alive")
RegisterUnitEvent(250791, 4, "druid_heal_spam_when_alive")
RegisterUnitEvent(250790, 18, "druid_heal_spam_when_alive")
RegisterUnitEvent(250790, 4, "druid_heal_spam_when_alive")
