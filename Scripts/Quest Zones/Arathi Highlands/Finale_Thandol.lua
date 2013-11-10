function FIRECANNON_VISUALEFFECT(pUnit,Event)
	local CannonOne = pUnit:GetCreatureNearestCoords(-2277.50,-2510.79,78.05, 32795)
	local CannonTwo = pUnit:GetCreatureNearestCoords(-2275.95,-2495.75,78.50, 32795)
	local Deconstructor = pUnit:GetCreatureNearestCoords(-2362.02,-2503.58,88.34, 99001)
	if Deconstructor then
		if Deconstructor:IsInCombat() then
			--pUnit:PlaySoundToSet(2718)
			--pUnit:Emote(5,1000)
			CannonOne:CastSpellOnTarget(49872,Deconstructor)
			CannonTwo:CastSpellOnTarget(49872,Deconstructor)
			pUnit:Strike(Deconstructor,1,1535,180,260,1)
			Deconstructor:CastSpell(71495)
		end
	end
end

function Mountaineer_RandomOrders(pUnit,Event)
	local choice = math.random(1,5)
	if choice == 1 then
		pUnit:SendChatMessage(14,0,"Riflemen, shoot faster!")
		pUnit:PlaySoundToSet(16954)
		pUnit:Emote(5,2000)
	elseif choice == 2 then
		pUnit:SendChatMessage(14,0,"Mortar team, reload!")
		pUnit:PlaySoundToSet(16955)
		pUnit:Emote(5,2000)
	elseif choice == 3 then
		pUnit:SendChatMessage(14,0,"Marines, Sergeants, attack!")
		pUnit:PlaySoundToSet(16956)
		pUnit:Emote(5,2000)
	end
	pUnit:RegisterEvent("Mountaineer_RandomOrders", math.random(8000, 15000), 1)
end

function Mountaineer_spawn_thandol(pUnit,Event)
	pUnit:RegisterEvent("Mountaineer_RandomOrders", 5000, 1)
	pUnit:RegisterEvent("FIRECANNON_VISUALEFFECT", math.random(2000, 4000), 1)
end

RegisterUnitEvent(2105,18, "Mountaineer_spawn_thandol")

function ANTITURRET_SPAWN(pUnit,Event)
	pUnit:RegisterEvent("CANNON_Effect", math.random(2000, 6000), 0)
end


function CANNON_Effect(pUnit,Event)
	local enemy = pUnit:GetRandomEnemy()
	if enemy then
		if enemy:IsDead() == false then
			if pUnit:GetDistanceYards(enemy) < 150 then
				pUnit:CastSpellOnTarget(49872,enemy)
				--pUnit:Strike(enemy,1,1535,480,760,1)
				enemy:CastSpell(71495)
			end
		end
	end
end

RegisterUnitEvent(32795, 18, "ANTITURRET_SPAWN")