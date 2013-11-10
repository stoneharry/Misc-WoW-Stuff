
local NPCA = 900000 -- ID of npc A
local NPCB = 900001 -- ID of npc A

function some_dude_just_spawnedzzz(pUnit, Event)
	pUnit:RegisterEvent("Checker_Tehe_TEHE_TEHE_TEHE_TEHE", 5000, 0)
end

function Checker_Tehe_TEHE_TEHE_TEHE_TEHE(pUnit, Event)
	if math.random(1,10) == 1 then
	local plr = pUnit:GetClosestPlayer()
		if plr ~= nil then
		plr:CastSpell(33271)
		pUnit:SpawnCreature(NPCB, pUnit:GetX()+2, pUnit:GetY(), pUnit:GetZ(), 0, 15, 120000)
		pUnit:SpawnCreature(NPCB, pUnit:GetX()-2, pUnit:GetY(), pUnit:GetZ(), 0, 15, 120000)
		end
	end
end

RegisterUnitEvent(NPCA, 18, "some_dude_just_spawnedzzz")

function ghouls_are_spawning_tehe_tehe_tehe(pUnit, Event)
	pUnit:RegisterEvent("SEK_WERE_SPAWNING_STILL", 1, 1)
end

function SEK_WERE_SPAWNING_STILL(pUnit, Event)
	pUnit:Emote(449, 4500)
	pUnit:RegisterEvent("Ohai_lets_get_that_playerrrrz", 4500, 1)
end

function Ohai_lets_get_that_playerrrrz(pUnit, Event)
	local pla = pUnit:GetClosestPlayer()
	if pla ~= nil then
	pUnit:SetFaction(2)
	pUnit:SetMovementFlags(1)
	pUnit:MoveTo(pla:GetX(), pla:GetY(), pla:GetZ(), 0)
	else
	pUnit:Despawn(1,0)
	end
end

RegisterUnitEvent(NPCB, 18, "ghouls_are_spawning_tehe_tehe_tehe")