

local points = {
	{4631, -2448.9, 1180.15},
	{4644, -2425.2, 1180.15}
}

local c = 1

function MadIkLeaderEvents(pUnit, Event)
	pUnit:RemoveEvents()
	if Event == 1 then
		pUnit:StopChannel()
		pUnit:Root()
		pUnit:SendChatMessage(12,0,"I will purge the sha with the aid of the Burning Legion!")
		pUnit:RegisterEvent("SummonInfernalMadIK", 16500, 0)
		SummonInfernalMadIK(pUnit)
	elseif Event == 2 then
		pUnit:RegisterEvent("KeepUpVisualsLala", 5000, 0)
	elseif Event == 4 then
		local npc = pUnit:GetCreatureNearestCoords(4603, -2418.8, 1184.8, 116103)
		if npc then
			npc:RemoveAura(71994) -- visual
		end
	elseif Event == 18 then
		pUnit:RegisterEvent("KeepUpVisualsLala", 5000, 0)
	end
end


function KeepUpVisualsLala(pUnit)
	local npc = pUnit:GetCreatureNearestCoords(4603, -2418.8, 1184.8, 116103)
	if npc then
		npc:CastSpell(71994) -- visuals
		pUnit:ChannelSpell(76221, npc)
	end
end

function SummonInfernalMadIK(pUnit)
	c = math.random(1,3)
	local npc = pUnit:GetCreatureNearestCoords(4603, -2418.8, 1184.8, 116103)
	if npc then
		if c == 1 or c == 2 then
			npc:CastSpellAoF(points[c][1], points[c][2], points[c][3], 37277)
		else
			for c = 1, 2 do
				npc:CastSpellAoF(points[c][1], points[c][2], points[c][3], 37277)
			end
			c = 3
		end
		pUnit:RegisterEvent("spawnInfMadIK", 2000, 1)
	end
end

function spawnInfMadIK(pUnit)
	if c == 1 or c == 2 then
		pUnit:SpawnCreature(22203, points[c][1], points[c][2], points[c][3], 2.69, 14, 60000)
	elseif c == 3 then
		pUnit:SpawnCreature(22203, points[1][1], points[1][2], points[1][3], 2.69, 14, 60000)
		pUnit:SpawnCreature(22203, points[2][1], points[2][2], points[2][3], 2.69, 14, 60000)
	end
end

RegisterUnitEvent(284111, 1, "MadIkLeaderEvents")
RegisterUnitEvent(284111, 2, "MadIkLeaderEvents")
RegisterUnitEvent(284111, 4, "MadIkLeaderEvents")
RegisterUnitEvent(284111, 18, "MadIkLeaderEvents")

function MadLKInfernal(pUnit, Event)
	pUnit:RegisterEvent("AddsAttackKeymaster", 1000, 1)
end

RegisterUnitEvent(22203, 18, "MadLKInfernal")
