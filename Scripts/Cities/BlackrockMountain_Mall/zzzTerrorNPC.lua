--[[
function TerrorsATrollSpawn(pUnit, Event)
	pUnit:RegisterEvent("Attack_Targets_With_da_Bomb_Terror", math.random(1000, 5000), 1)
end

function Attack_Targets_With_da_Bomb_Terror(pUnit)
	if math.random(1,2) == 1 then
		pUnit:CastSpellAoF(-7442, -1232, 477.5, 9143)
	else
		pUnit:CastSpellAoF(-7447, -1236, 477.5, 9143)
	end
	pUnit:RegisterEvent("Attack_Targets_With_da_Bomb_Terror", math.random(1000, 120000), 1)
end

RegisterUnitEvent(45000, 18, "TerrorsATrollSpawn")]]