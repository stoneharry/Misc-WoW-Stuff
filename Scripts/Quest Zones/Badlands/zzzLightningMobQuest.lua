
local major = nil

function LeadLightningSpawnMobSpawn(pUnit, event)
	major = pUnit
	pUnit:RegisterEvent("wait_for_spawn_leadlightning", 2500, 1)
end

function wait_for_spawn_leadlightning(pUnit)
	pUnit:CastSpell(50771) -- lightning visual
	major = pUnit
end

RegisterUnitEvent(32958, 18, "LeadLightningSpawnMobSpawn")

function LesserLightningmobspawn(pUnit, event)
	pUnit:RegisterEvent("waitforspawnlesser_minion", math.random(1000, 4000), 0)
end

function waitforspawnlesser_minion(pUnit)
	if major ~= nil then
		pUnit:ChannelSpell(45537, major)
		local plr = major:GetClosestPlayer()
		if plr ~= nil then
			if major:IsAlive() then
				if major:GetDistanceYards(plr) < 40 then
					if math.random(1,4) == 1 then
						major:FullCastSpellOnTarget(28900, plr)
					end
				end
			end
		end
	else
		pUnit:StopChannel()
		pUnit:SpawnCreature(32958, -6748, -2708, 241.7, 1.286567, 21, 0)
	end
	pUnit:CastSpell(52663) -- lightning visual
end

function lesserspirit_ondied(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:StopChannel()
	if major ~= nil then
		major:SetHealth((major:GetHealth()/2))
		major:CastSpell(64785) -- visual
	end
end

RegisterUnitEvent(249621, 18, "LesserLightningmobspawn")
RegisterUnitEvent(249621, 4, "lesserspirit_ondied")
