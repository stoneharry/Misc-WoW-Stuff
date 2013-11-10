function Ticking_Ember_Spawn(pUnit,Event)
	if Event == 18 then
		pUnit:RegisterEvent("Ticking_Ember_Explode", 500, 0)
		local MageOwner = pUnit:GetPetOwner() 
		pUnit:SetLevel(MageOwner:GetPlayerLevel())
	else
		pUnit:RemoveEvents()
	end
end

function Ticking_Ember_Explode(pUnit)
local MageOwner = pUnit:GetPetOwner() 
	for _, enemies in pairs(MageOwner:GetInRangeEnemies()) do -- might not work on players
		if pUnit:GetDistanceYards(enemies) < 10 then
			if enemies:IsDead() == false then
				pUnit:RemoveEvents()
				pUnit:Strike(enemies,1,1535,MageOwner:GetPlayerLevel()*6.5,MageOwner:GetPlayerLevel()*7.2,1)
				enemies:CastSpell(58438)
				pUnit:Kill(pUnit)
				break;
			end
		end
	end
end

RegisterUnitEvent(7266, 18, "Ticking_Ember_Spawn")
RegisterUnitEvent(7266, 4, "Ticking_Ember_Spawn")