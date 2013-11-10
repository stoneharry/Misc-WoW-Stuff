

function rabbit_teleporter_on_spawn_te(pUnit, Event)
	pUnit:RegisterEvent("rabbit_teleporter_on_spawn_te_te", 3000, 0)
end

function rabbit_teleporter_on_spawn_te_te(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistance(plr) < 5 then
			if plr:HasFinishedQuest(818) == true then
			plr:Teleport(0, -6850, -1539, 243)
			plr:CastSpell(64446)
			else
				if plr:HasQuest(818) == true then
				plr:Teleport(0, -6850, -1539, 243)
				plr:CastSpell(64446)
				plr:AdvanceQuestObjective(818, 0)
				end
			end
		end
	end

end

RegisterUnitEvent(78041, 18, "rabbit_teleporter_on_spawn_te")

function zrabbit_teleporter_on_spawn_te(pUnit, Event)
	pUnit:RegisterEvent("zrabbit_teleporter_on_spawn_te_te", 3000, 0)
end

function zrabbit_teleporter_on_spawn_te_te(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistance(plr) < 5 then
			if plr:HasFinishedQuest(818) == true then
			plr:Teleport(0, -6705, -1511, 248)
			plr:CastSpell(64446)
			else
				if plr:HasQuest(818) == true then
				plr:Teleport(0, -6705, -1511, 248)
				plr:CastSpell(64446)
				plr:AdvanceQuestObjective(818, 1)
				end
			end
		end
	end

end

RegisterUnitEvent(78042, 18, "zrabbit_teleporter_on_spawn_te")
