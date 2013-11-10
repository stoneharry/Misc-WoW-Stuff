
local Orc = nil

---------- Captured Orc -----------------------------

function Captured_ORC_OnSpawn(pUnit, Event)
	pUnit:RegisterEvent("ohai_lets_wait_for_Spawn_timer_Againz", 1000, 1)
end

function ohai_lets_wait_for_Spawn_timer_Againz(pUnit, Event)
	Orc = pUnit
	Orc:FullCastSpell(32407)
end

RegisterUnitEvent(171671, 18, "Captured_ORC_OnSpawn")

-----------------------------------------------------

function Some_Archmage_Vangoth_OnCombat(pUnit, Event)
	if Orc ~= nil then
	Orc:ChannelSpell(9373, pUnit)
	else
	pUnit:Despawn(1, 10000)
	end
end

function Some_Archmage_Vangoth_OnLeft(pUnit, Event)
	if Orc ~= nil then
	Orc:StopChannel()
	end
	pUnit:RemoveEvents()
end

function Some_Archmage_Vangoth_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
	if Orc ~= nil then
	Orc:StopChannel()
	Orc:CastSpell(58538)
	Orc:Despawn(1000, 60000)
	end
end

RegisterUnitEvent(194811, 1, "Some_Archmage_Vangoth_OnCombat")
RegisterUnitEvent(194811, 2, "Some_Archmage_Vangoth_OnLeft")
RegisterUnitEvent(194811, 4, "Some_Archmage_Vangoth_OnDead")
