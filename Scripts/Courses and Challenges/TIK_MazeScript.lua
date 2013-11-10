--By Tikki

function maze_obj_OnSpawn(pUnit, Event)
	pUnit:Despawn(math.random(45000,60000),math.random(45000,60000))
end

RegisterGameObjectEvent(50001, 2, "maze_obj_OnSpawn")