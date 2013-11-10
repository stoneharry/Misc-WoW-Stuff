ShaInfestedHyjalTiger = {}

function ShaInfestedHyjalTiger.ShaInfestedHyjalTigerOnSpawn(pUnit, event)
	pUnit:SetModel(40014)
end

function ShaInfestedHyjalTiger.ShaInfestedHyjalTigerOnCombat(pUnit, event)
	if pUnit:GetMainTank() then
		pUnit:RegisterEvent("ShaInfestedHyjalTiger.ShaInfestedHyjalTigerAbillities", math.random(2400, 28200), 2)
	end
end

function ShaInfestedHyjalTiger.ShaInfestedHyjalTigerOnDeath(pUnit, event, pKiller)
	if (pKiller ~= nil) then
		pUnit:SpawnCreature(150550, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 60000)
		pUnit:CastSpell(30101)
		pUnit:SetModel(40015)
	end
end

RegisterUnitEvent(150720, 18, "ShaInfestedHyjalTiger.ShaInfestedHyjalTigerOnSpawn")
RegisterUnitEvent(150720, 1, "ShaInfestedHyjalTiger.ShaInfestedHyjalTigerOnCombat")
RegisterUnitEvent(150720, 4, "ShaInfestedHyjalTiger.ShaInfestedHyjalTigerOnDeath")

function ShaInfestedHyjalTiger.ShaInfestedHyjalTigerAbillities(pUnit, event)
	ShaInfestedHyjalTiger.RandomAbilityTiger = math.random(1, 4)
	local tank = pUnit:GetMainTank()
	if tank then
		if (ShaInfestedHyjalTiger.RandomAbilityTiger == 1) then
			pUnit:CastSpellOnTarget(52581, tank)
		else
			pUnit:CastSpellOnTarget(52473, tank)
		end
	end
end

function ShaInfestedHyjalTiger.ShaManifestationOnSpawn(pUnit, event)
	pUnit:RegisterEvent("ShaInfestedHyjalTiger.WaitSecondForSpawn", 1000, 1)
end

function ShaInfestedHyjalTiger.WaitSecondForSpawn(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		--pUnit:MoveJump(plr:GetX(), plr:GetY(), plr:GetZ())
		pUnit:MoveKnockback(plr:GetX()+2, plr:GetY(), plr:GetZ(), 5, 7)
	end
end

RegisterUnitEvent(150550, 18, "ShaInfestedHyjalTiger.ShaManifestationOnSpawn")