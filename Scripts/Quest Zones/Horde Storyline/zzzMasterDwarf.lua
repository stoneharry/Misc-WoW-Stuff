
function gfOmen_OnCombat(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:SetScale(3)
	--pUnit:RemoveAura(16245) -- Freeze Animation
	--pUnit:FullCastSpell(10254) -- Awaken Visual
	pUnit:RegisterEvent("gggjjjlorddandukedan", 1500, 1)
end

function gggjjjlorddandukedan(pUnit, Event)
	--pUnit:RemoveAura(70733) -- Stone Look
	--pUnit:RemoveAura(64775) -- Imune to Damage
	--pUnit:Unroot()
	--pUnit:DisableCombat(false)
	pUnit:RegisterEvent("gfOmen_Moonfire", 4900, 0)
	pUnit:RegisterEvent("gfOmen_Visual", 10000, 0)
end

function gfOmen_Moonfire(pUnit, Event)
	if pUnit:GetClosestPlayer() == nil then
	else
	pUnit:CastSpellOnTarget(8924, pUnit:GetClosestPlayer())
	end
end

function gfOmen_Visual(pUnit, Event)
	pUnit:CastSpell(59084)
	pUnit:CastSpell(1449)
end

function gfOmen_OnLeave(pUnit, Event)
	if pUnit:IsAlive() == true then
	pUnit:Despawn(4000, 5000)
	end
	pUnit:RemoveEvents()
end

function gfOmen_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(299791, 1, "gfOmen_OnCombat")
RegisterUnitEvent(299791, 2, "gfOmen_OnLeave")
RegisterUnitEvent(299791, 4, "gfOmen_OnDead")

--[[function zzzjjjBloodhoof_ziopgehz_z(pUnit, Event)
	pUnit:CastSpell(70733) -- Stone Look
	pUnit:CastSpell(16245) -- Freeze Animation
	pUnit:CastSpell(64775) -- Imune to Damage
	pUnit:Root()
	pUnit:DisableCombat(true)
	pUnit:RegisterEvent("zzzjjjBloodhoof_ziopgehz_zz", 10000, 0)
end

function zzzjjjBloodhoof_ziopgehz_zz(pUnit, Event)
	pUnit:CastSpell(70733) -- Stone Look
	pUnit:CastSpell(16245) -- Freeze Animation
	pUnit:CastSpell(64775) -- Imune to Damage
	pUnit:Root()
	pUnit:DisableCombat(true)
	pUnit:SetScale(1)
end

RegisterUnitEvent(299791, 18, "zzzjjjBloodhoof_ziopgehz_z")]]
