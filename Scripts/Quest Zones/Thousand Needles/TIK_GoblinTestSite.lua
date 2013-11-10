

function Q3401_GoblinTriggerOnSpawn(pUnit, Event)
	pUnit:RegisterEvent("Q3401_GoblinTriggerSelect", 2000, 0)
	--pUnit:RegisterEvent("Q3401_TemporarySeeTriggers", 2000, 1)  --Debug purposes. Adds a red light to the triggers.
end

function Q301_TemporarySeeTriggers(pUnit,Event)
	pUnit:CastSpell(32839)
	pUnit:SetScale(0.3)
end

RegisterUnitEvent(89001, 18, "Q3401_GoblinTriggerOnSpawn")

function Q3401_GoblinTriggerSelect(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if plr:GetPhase() == 1 then
			if pUnit:GetDistanceYards(plr) < 4 then
			pUnit:Strike(plr, 1, 38043, 200, 300, 1.2)
			Q3401DoRandomBoom(plr)
			local qq = math.random(1,2)
			if qq == 2 then
				local x,y,z,o = pUnit:GetLocation()
				pUnit:SpawnGameObject(89001, x,y,z,o, 30000, 50, 1, 0)
			end
			pUnit:Despawn(1000,5000)
			end
		end
	end
end

function Q3401DoRandomBoom(plr)
	local q = math.random(1,2)
	if q == 1 then
		plr:CastSpell(43418)
	elseif q == 2 then
		plr:CastSpell(47328)
		plr:CastSpell(14621)
	elseif q == 3 then
		plr:CastSpell(54899)
	end
end