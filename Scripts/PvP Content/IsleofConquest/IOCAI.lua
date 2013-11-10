function IoC_Soldier_Events(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("IOC_SOLDIER_BLOCK", math.random(8000,12000), 0)
elseif Event == 2 or Event == 4 then
pUnit:RemoveEvents()
end	
	end
	
	function IOC_SOLDIER_BLOCK(pUnit)
	pUnit:CastSpell(38031)
	end
	
RegisterUnitEvent(92068, 1, "IoC_Soldier_Events")
RegisterUnitEvent(92068, 2, "IoC_Soldier_Events")
RegisterUnitEvent(92068, 4, "IoC_Soldier_Events")
RegisterUnitEvent(92067, 1, "IoC_Soldier_Events")
RegisterUnitEvent(92067, 2, "IoC_Soldier_Events")
RegisterUnitEvent(92067, 4, "IoC_Soldier_Events")


function Conquest_CrocE(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("Conquest_Croc_Tendon_Rip", math.random(8000,12000), 0)
elseif Event == 2 or Event == 4 then
pUnit:RemoveEvents()
end
	end
	
	function Conquest_Croc_Tendon_Rip(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		if pUnit:GetDistanceYards(plr) < 5 then
			pUnit:CastSpellOnTarget(53575, plr)
			end
		end
	end
	
	RegisterUnitEvent(92069, 1, "Conquest_CrocE")
RegisterUnitEvent(92069, 2, "Conquest_CrocE")
RegisterUnitEvent(92069, 4, "Conquest_CrocE")