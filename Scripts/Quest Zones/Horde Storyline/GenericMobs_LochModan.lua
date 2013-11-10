--[[ Put all your trash mobs here :D ]]--

-- Script variables

OBJECT_END = 0x0006
UNIT_FIELD_FLAGS = OBJECT_END + 0x0035
UNIT_FLAG_NOT_SELECTABLE = 0x02000000
UNIT_FLAG_DEFAULT = 0X00

------- Duke Dan ------------------------------------

function lorddandukedan_z(pUnit, Event)
	pUnit:SendChatMessage(12,0, "Prepare for your end, foul beast!")
	pUnit:RegisterEvent("lorddandukedan", 2001, 0)
end

function lorddandukedan(pUnit, Event)
	local plraaaah = pUnit:GetClosestPlayer()
	if plraaaah ~= nil then
		if math.random(1,4) == 1 then
		pUnit:FullCastSpell(15237)
		else
		pUnit:FullCastSpellOnTarget(591, plraaaah)
		end
	end
end

function lorddandukedan_zz(pUnit, Event)
	pUnit:RemoveEvents()
end

function lorddandukedan_zzz(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(152521, 1, "lorddandukedan_z")
RegisterUnitEvent(152521, 2, "lorddandukedan_zz")
RegisterUnitEvent(152521, 4, "lorddandukedan_zzz")

-----------------------------------------------------

------- Image of Bloodhoof --------------------------

function Bloodhoof_ziopgehz_z(pUnit, Event)
	pUnit:RegisterEvent("Bloodhoof_ziopgehz_zz", 1000, 1)
end

function Bloodhoof_ziopgehz_zz(pUnit, Event)
	pUnit:FullCastSpell(44816)
end

RegisterUnitEvent(297382, 18, "Bloodhoof_ziopgehz_z")

-----------------------------------------------------