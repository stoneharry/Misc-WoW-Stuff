
function Rakzinnoth_Combat(pUnit,Event)
   pUnit:RegisterEvent("Forked_Lightning_Chimaera", 6000, 0)
   pUnit:RegisterEvent("CycloneStrike_Chimeara", 8000, 0)
   pUnit:RegisterEvent("Arc_Wield_Chimaera", 13000, 0)
end

function Forked_Lightning_Chimaera(pUnit,Event)
	local tank = pUnit:GetMainTank()
				if tank ~= nil then
				if pUnit:GetDistanceYards(tank) < 20 then
				pUnit:CastSpellOnTarget(16921,tank)
end
end
end


function Arc_Wield_Chimaera(pUnit,Event)
player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 20 then
pUnit:CastSpellOnTarget(21992,player)
end
end
end

function CycloneStrike_Chimeara(pUnit,Event)
pUnit:CastSpell(32849)
end

function Rakzinnoth_DeadOrLeave(pUnit,Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(44797, 4, "Rakzinnoth_DeadOrLeave")
RegisterUnitEvent(44797, 3, "Rakzinnoth_DeadOrLeave")
	RegisterUnitEvent(44797, 1, "Rakzinnoth_Combat")