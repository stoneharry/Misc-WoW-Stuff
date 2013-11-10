
function jjjlorddandukedan_z(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:RemoveAura(16245) -- Freeze Animation
	pUnit:FullCastSpell(10254) -- Awaken Visual
	pUnit:SetScale(2)
	pUnit:RegisterEvent("jjjlorddandukedan", 1500, 1)
end

function jjjlorddandukedan(pUnit, Event)
	pUnit:RemoveAura(70733) -- Stone Look
	pUnit:RemoveAura(64775) -- Imune to Damage
	pUnit:Unroot()
	pUnit:DisableCombat(false)
	if math.random(1,10) == 1 then
		local pflr = pUnit:GetClosestPlayer()
		if pflr ~= nil then
		pUnit:FullCastSpellOnTarget(603, pflr)
		end
	end
end

function jjjlorddandukedan_zzzzz(pUnit, Event)
	if pUnit:IsAlive() == true then
	pUnit:Despawn(4000, 5000)
	end
end

RegisterUnitEvent(1051, 1, "jjjlorddandukedan_z")
RegisterUnitEvent(1051, 2, "jjjlorddandukedan_zzzzz")

function jjjBloodhoof_ziopgehz_z(pUnit, Event)
	pUnit:CastSpell(70733) -- Stone Look
	pUnit:CastSpell(16245) -- Freeze Animation
	pUnit:CastSpell(64775) -- Imune to Damage
	pUnit:Root()
	pUnit:DisableCombat(true)
	pUnit:SetScale(1)
	pUnit:RegisterEvent("jjjBloodhoof_ziopgehz_zz", 5000, 0)
end

function jjjBloodhoof_ziopgehz_zz(pUnit, Event)
	pUnit:CastSpell(70733) -- Stone Look
	pUnit:CastSpell(16245) -- Freeze Animation
	pUnit:CastSpell(64775) -- Imune to Damage
	pUnit:Root()
	pUnit:DisableCombat(true)
	pUnit:SetScale(1)
end

RegisterUnitEvent(1051, 18, "jjjBloodhoof_ziopgehz_z")
