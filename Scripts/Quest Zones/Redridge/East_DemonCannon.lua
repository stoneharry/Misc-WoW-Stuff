
local Fel = nil

function FelCannon_OnSpawn(pUnit, Event)
	pUnit:RegisterEvent("RegisterSpawnIDToVar", 1000, 1)
end

function RegisterSpawnIDToVar(pUnit)
	Fel = pUnit
end

RegisterUnitEvent(19399, 18, "FelCannon_OnSpawn")

function feloperatoroncombat(pUnit, Event)
	pUnit:RegisterEvent("CastSpellsLikeOwned", 10000, 0)
end

function CastSpellsLikeOwned(pUnit)
	if math.random(1,2) == 1 then
		local plr = pUnit:GetClosestPlayer()
		pUnit:FullCastSpellOnTarget(35853, plr)
	else
		pUnit:CastSpellAoF(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 4629)
	end
end

function feloperatorondeath(pUnit, Event)
	pUnit:RemoveEvents()
	if Fel ~= nil then
		Fel:CastSpell(45796)
		Fel:RegisterEvent("KillSelf_FelCannon", 1000, 1)
	end
end

function KillSelf_FelCannon(pUnit)
	pUnit:Kill(pUnit)
end

function feloperatoronleave(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(205331, 1, "feloperatoroncombat")
RegisterUnitEvent(205331, 2, "feloperatoronleave")
RegisterUnitEvent(205331, 4, "feloperatorondeath")

function Imp_Combat_Felcannontarget(pUnit, Event)
	if Fel ~= nil then
		local player = pUnit:GetClosestPlayer()
		if player ~= nil and Fel:IsAlive() then
			Fel:SendChatMessage(14,0,"Target acquired.")
			Fel:FullCastSpellOnTarget(66963, player)
		end
	end
end

RegisterUnitEvent(44491, 1, "Imp_Combat_Felcannontarget")
