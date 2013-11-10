
function TrapdiTrap(pUnit,Event)
        pUnit:RegisterEvent("Explosion_Start", 1000, 1)
end

function Explosion_Start(pUnit, Event)
        pUnit:RegisterEvent("Explosion_Green_Int", 1000, 1)
end

function Explosion_Green_Int(pUnit, Event)
	local Explosion = math.random(1, 10)
	if Explosion == 1 then
	pUnit:RegisterEvent("ExplosionSpawn1", 1000, 1)
	end
	if Explosion == 2 then
	pUnit:RegisterEvent("ExplosionSpawn2", 1000, 1)
	end
	if Explosion == 3 then
	pUnit:RegisterEvent("ExplosionSpawn3", 1000, 1)
	end
    if Explosion == 4 then
	pUnit:RegisterEvent("ExplosionSpawn4", 1000, 1)
	end
    if Explosion == 5 then
	pUnit:RegisterEvent("ExplosionSpawn5", 1000, 1)
	end
    if Explosion == 6 then
	pUnit:RegisterEvent("ExplosionSpawn6", 1000, 1)
	end
    if Explosion == 7 then
	pUnit:RegisterEvent("ExplosionSpawn7", 1000, 1)
	end
    if Explosion == 8 then
	pUnit:RegisterEvent("ExplosionSpawn8", 1000, 1)
	end
    if Explosion == 9 then
	pUnit:RegisterEvent("ExplosionSpawn9", 1000, 1)
	end
    if Explosion == 10 then
	pUnit:RegisterEvent("ExplosionSpawn10", 1000, 1)
	end
end

function ExplosionSpawn1(pUnit, Event)
        pUnit:SpawnCreature(592722, -8327, -2751, 182, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 20000, 1)
end

function ExplosionSpawn2(pUnit, Event)
        pUnit:SpawnCreature(592722, -8333, -2732, 184, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 11000, 1)
end

function ExplosionSpawn3(pUnit, Event)
        pUnit:SpawnCreature(592722, -8308, -2744, 175, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 18000, 1)
end

function ExplosionSpawn4(pUnit, Event)
        pUnit:SpawnCreature(592722, -8314, -2728, 175, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 24000, 1)
end

function ExplosionSpawn5(pUnit, Event)
        pUnit:SpawnCreature(592722, -8300, -2715, 169, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 59272200, 1)
end

function ExplosionSpawn6(pUnit, Event)
        pUnit:SpawnCreature(592722, -8328, -2740, 180, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 9000, 1)
end

function ExplosionSpawn7(pUnit, Event)
        pUnit:SpawnCreature(592722, -8292, -2736, 183, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 29000, 1)
end

function ExplosionSpawn8(pUnit, Event)
        pUnit:SpawnCreature(592722, -8309, -2763, 185, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 19000, 1)
end

function ExplosionSpawn9(pUnit, Event)
        pUnit:SpawnCreature(592722, -8294, -2696, 181, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 30000, 1)
end

function ExplosionSpawn10(pUnit, Event)
        pUnit:SpawnCreature(592722, -8269, -2715, 153, 1, 35, 0)
        pUnit:RegisterEvent("Explosion_Start", 15927, 1)
end

function ExplosionCreature_OnSpawn(pUnit, Event)
        pUnit:RegisterEvent("ExplosionAndDespawn", 2000, 1)
end



function ExplosionAndDespawn(pUnit, Event)
        pUnit:CastSpell(61126)
        pUnit:Despawn(2000, 0)
end



RegisterUnitEvent(225252, 18, "TrapdiTrap")
RegisterUnitEvent(592722, 18, "ExplosionCreature_OnSpawn")
