
function zzzTrapdiTrap(pUnit,Event)
    pUnit:RegisterEvent("zzzExplosion_Start", 1000, 1)
end

function zzzExplosion_Start(pUnit, Event)
	pUnit:RegisterEvent("zzzExplosion_Green_Int", 1000, 1)
end

function zzzExplosion_Green_Int(pUnit, Event)
	local Explosion = math.random(1, 10)
	if Explosion == 1 then
	pUnit:RegisterEvent("zExplosionSpawn1", 1000, 1)
	end
	if Explosion == 2 then
	pUnit:RegisterEvent("zExplosionSpawn2", 1000, 1)
	end
	if Explosion == 3 then
	pUnit:RegisterEvent("zExplosionSpawn3", 1000, 1)
	end
    if Explosion == 4 then
	pUnit:RegisterEvent("zExplosionSpawn4", 1000, 1)
	end
    if Explosion == 5 then
	pUnit:RegisterEvent("zExplosionSpawn5", 1000, 1)
	end
    if Explosion == 6 then
	pUnit:RegisterEvent("zExplosionSpawn6", 1000, 1)
	end
    if Explosion == 7 then
	pUnit:RegisterEvent("zExplosionSpawn7", 1000, 1)
	end
end

function zExplosionSpawn1(pUnit, Event)
        pUnit:SpawnCreature(592723, -6511, -1122, 310, 5, 35, 0)
        pUnit:RegisterEvent("zzzExplosion_Start", 5000, 1)
end

function zExplosionSpawn2(pUnit, Event)
        pUnit:SpawnCreature(592723, -6443, -1115, 311, 1, 35, 0)
        pUnit:RegisterEvent("zzzExplosion_Start", 2000, 1)
end

function zExplosionSpawn3(pUnit, Event)
        pUnit:SpawnCreature(592723, -6493, -1136.7, 307, 1, 35, 0)
        pUnit:RegisterEvent("zzzExplosion_Start", 1000, 1)
end

function zExplosionSpawn4(pUnit, Event)
        pUnit:SpawnCreature(592723, -6519, -1142, 313, 1, 35, 0)
        pUnit:RegisterEvent("zzzExplosion_Start", 5000, 1)
end

function zExplosionSpawn5(pUnit, Event)
        pUnit:SpawnCreature(592723, -6517, -1181, 311, 1, 35, 0)
        pUnit:RegisterEvent("zzzExplosion_Start", 4000, 1)
end

function zExplosionSpawn6(pUnit, Event)
        pUnit:SpawnCreature(592723, -6556, -1169, 311, 1, 35, 0)
        pUnit:RegisterEvent("zzzExplosion_Start", 3000, 1)
end

function zExplosionSpawn7(pUnit, Event)
        pUnit:SpawnCreature(592723, -6464, -1101, 307, 1, 35, 0)
        pUnit:RegisterEvent("zzzExplosion_Start", 2000, 1)
end

-------------------------------------------------------------------------------

function zzzExplosionCreature_OnSpawn(pUnit, Event)
        pUnit:RegisterEvent("zzzExplosionAndDespawn", 2000, 1)
end

function zzzExplosionAndDespawn(pUnit, Event)
        pUnit:CastSpell(46225)
        pUnit:Despawn(3000, 0)
end

RegisterUnitEvent(592724, 18, "zzzTrapdiTrap")
RegisterUnitEvent(592723, 18, "zzzExplosionCreature_OnSpawn")
