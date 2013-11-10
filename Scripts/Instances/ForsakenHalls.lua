
FH = {}
FH.VAR = {}

local points = {
	{3491, 815, 21.8},
	{3502, 816, 21.8},
	{3501, 793, 21.8},
	{3491, 782, 21.8}
}

function FH.VAR.BEvents(pUnit, Event)
	if Event == 1 then
		pUnit:SetMovementFlags(1)
		pUnit:AIDisableCombat(true)
		pUnit:DisableMelee(true)
		pUnit:RegisterEvent("FH.VAR.MoveAround", 100, 1)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 16024 or v:GetEntry() == 162431 then
				v:Despawn(1,0)
			end
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 16024 or v:GetEntry() == 162431 then
				v:Despawn(1,0)
			end
		end
	end
end

function FH.VAR.MoveAround(pUnit)
	local p = math.random(1,4)
	pUnit:MoveTo(points[p][1], points[p][2], points[p][3], 0)
	pUnit:RegisterEvent("FH.VAR.ThrowPotions", 2000, 2)
	pUnit:RegisterEvent("FH.VAR.MoveAround", 10000, 1)
end

function FH.VAR.ThrowPotions(pUnit)
	local x,y,z
	--[[if math.random(1,2) == 1 then
		x = math.random(3494, 3498)
		y = math.random(798, 801)
		z = 23
	else]]
		local plr = pUnit:GetRandomPlayer(0)
		if plr then
			x = plr:GetX()
			y = plr:GetY()
			z = plr:GetZ()
		else
			return
		end
	--end
	if math.random(1,2) == 1 then
		pUnit:CastSpellAoF(x, y, z, 39154)
		pUnit:SpawnCreature(391902, x, y, z, 0, 14, 15000)
	else
		pUnit:CastSpellAoF(x, y, z, 39155)
		pUnit:SpawnCreature(162431, x, y, z, 0, 14, 120000)
	end
end

RegisterUnitEvent(284311, 1, "FH.VAR.BEvents")
RegisterUnitEvent(284311, 2, "FH.VAR.BEvents")
--RegisterUnitEvent(284311, 3, "FH.VAR.BEvents")
RegisterUnitEvent(284311, 4, "FH.VAR.BEvents")

--

function FH.VAR.AEvents(pUnit, Event)
	if Event == 1 then
		pUnit:RegisterEvent("FH.VAR.NearSlimes", 800, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end

function FH.VAR.NearSlimes(pUnit)
	for _,v in pairs(pUnit:GetInRangeUnits()) do
		if v:GetEntry() == 162431 and v:GetDistanceYards(pUnit) < 5 then
			pUnit:SetMaxHealth(pUnit:GetMaxHealth() + v:GetMaxHealth())
			pUnit:SetHealth(pUnit:GetMaxHealth())
			pUnit:CastSpell(74996) -- grow
			v:RemoveEvents()
			v:Despawn(1,0)
		end
	end
end

RegisterUnitEvent(162431, 1, "FH.VAR.AEvents")
RegisterUnitEvent(162431, 2, "FH.VAR.AEvents")
RegisterUnitEvent(162431, 4, "FH.VAR.AEvents")
