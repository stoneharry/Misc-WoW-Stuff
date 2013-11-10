
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035

local coordsX = {-7204, -7151, -7085, -7091, -7131, -7187, -7226, -7216}
local coordsY = {-2449, -2454, -2420, -2342, -2308, -2318, -2376, -2340}

local pointsA = nil
local pointsB = nil
local pointsC = nil
local pointsD = nil
local pointsE = nil
local pointsF = nil
local pointsG = nil
local pointsH = nil
local ai = nil
local bi = nil
local ci = nil
local di = nil
local ei = nil
local fi = nil
local gi = nil
local hi = nil

function On_Spawn_Set_In_AIR_BadBoss(pUnit, Event)
	pUnit:RegisterEvent("But_we_need_Payer_fisrt", 1000, 0)
end

function But_we_need_Payer_fisrt(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:RemoveEvents()
		pUnit:CastSpell(61883) -- lightning
		pUnit:SetPosition(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+5, pUnit:GetO())
		pUnit:RegisterEvent("Keep_Visual_UP_BadGuy", 2000, 0)
	end
end

function Keep_Visual_UP_BadGuy(pUnit)
	pUnit:CastSpell(61883) -- lightning
end

--RegisterUnitEvent(180781, 18, "On_Spawn_Set_In_AIR_BadBoss")

function BadGuyBosLands_Eventys(pUnit, Event)
	if Event == 1 then
		pUnit:PlaySoundToSet(15873) -- music
		pUnit:RemoveEvents()
		--pUnit:AIDisableCombat(true)
		pUnit:Root()
		--pUnit:DisableMelee(true)
		pUnit:SendChatMessage(14,0,"I am not afraid of you!")
		pUnit:PlaySoundToSet(15471)
		pointsA = {}
		pointsB = {}
		pointsC = {}
		pointsD = {}
		pointsE = {}
		pointsF = {}
		pointsG = {}
		pointsH = {}
		ai = 0
		bi = 0
		ci = 0
		di = 0
		ei = 0
		fi = 0
		gi = 0
		hi = 0
		local y = 2386
 		for i=1,4 do
			y = y + 2
			pUnit:SpawnCreature(187117, -7166, -y, pUnit:GetLandHeight(-7166, -y), 0, 35, 0):SetUInt32Value(UNIT_FIELD_FLAGS, 33554434)
		end
		pUnit:RegisterEvent("Random_Spells_Visuals_BadGuyLands", 12000, 0)
		pUnit:RegisterEvent("CastRandomSpellsETc", 5000, 0)
		pUnit:RegisterEvent("Check_Health_FoR_Badboss", 2000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		--pUnit:SetPosition(-7173, -2390, pUnit:GetLandHeight(-7173, -2390), pUnit:GetO())
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			if unit:GetEntry() == 187117 or unit:GetEntry() == 293521 then
				unit:RemoveEvents()
				unit:Despawn(1,0)
			end
		end
		--pUnit:RegisterEvent("But_we_need_Payer_fisrt", 2000, 0)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			if unit:GetEntry() == 187117 or unit:GetEntry() == 293521 then
				unit:RemoveEvents()
				unit:Despawn(1,0)
			end
		end
		pUnit:CastSpell(63660)
		pUnit:SpawnCreature(180751, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 120000)
	end
end

function Random_Spells_Visuals_BadGuyLands(pUnit)
	local plr = pUnit:GetMainTank()
	if plr ~= nil then
		plr:CastSpell(24240) -- lightning
		pUnit:CastSpellOnTarget(28608, plr) -- curse of agony
		pUnit:FullCastSpellOnTarget(26108, plr) -- run around in fear
		if math.random(1,2) == 1 then
			if math.random(1,2) == 1 then
				pUnit:SendChatMessage(16,0,"Demonarc screams in obvious agony.")
				pUnit:PlaySoundToSet(15470)
			else
				pUnit:SendChatMessage(14,0,"I am not afraid of you!")
				pUnit:PlaySoundToSet(15471)
			end
		end
	end
end

function CastRandomSpellsETc(pUnit)
	if math.random(1,2) == 1 then
		pUnit:FullCastSpell(36225) -- chaos nova
	else
		local plr = pUnit:GetRandomPlayer(0)
		if plr then
			if plr:GetDistanceYards(pUnit) < 50 then
				pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 53721)
			end
		end
	end
end

function OrbsOfPower_Spawn(pUnit, Event)
	pUnit:AIDisableCombat(true)
	local x = -7173
	local y = -2390
	local r = math.pi / 180
	if #pointsA == 0 then
		local distance = 4
		for i = 1, 360 do
			local nx = x + (distance * math.cos(i*r))
			local ny = y + (distance * math.sin(i*r))
			pointsA[i] = {nx, ny}
		end
		pUnit:RegisterEvent("Move_Points_OrbOfPower_A", 100, 0)
	elseif #pointsB == 0 then
		local distance = 6
		for i = 1, 360 do
			local nx = x + (distance * math.cos(i*r))
			local ny = y + (distance * math.sin(i*r))
			pointsB[i] = {nx, ny}
		end
		pUnit:RegisterEvent("Move_Points_OrbOfPower_B", 100, 0)
	elseif #pointsC == 0 then
		local distance = 8
		for i = 1, 360 do
			local nx = x + (distance * math.cos(i*r))
			local ny = y + (distance * math.sin(i*r))
			pointsC[i] = {nx, ny}
		end	
		pUnit:RegisterEvent("Move_Points_OrbOfPower_C", 100, 0)
	elseif #pointsD == 0 then
		local distance = 10
		for i = 1, 360 do
			local nx = x + (distance * math.cos(i*r))
			local ny = y + (distance * math.sin(i*r))
			pointsD[i] = {nx, ny}
		end
		pUnit:RegisterEvent("Move_Points_OrbOfPower_D", 100, 0)
	elseif #pointsE == 0 then
		local distance = 12
		for i = 1, 360 do
			local nx = x + (distance * math.cos(i*r))
			local ny = y + (distance * math.sin(i*r))
			pointsE[i] = {nx, ny}
		end
		pUnit:RegisterEvent("Move_Points_OrbOfPower_E", 100, 0)
	elseif #pointsF == 0 then
		local distance = 14
		for i = 1, 360 do
			local nx = x + (distance * math.cos(i*r))
			local ny = y + (distance * math.sin(i*r))
			pointsF[i] = {nx, ny}
		end
		pUnit:RegisterEvent("Move_Points_OrbOfPower_F", 100, 0)
	elseif #pointsG == 0 then
		local distance = 16
		for i = 1, 360 do
			local nx = x + (distance * math.cos(i*r))
			local ny = y + (distance * math.sin(i*r))
			pointsG[i] = {nx, ny}
		end
		pUnit:RegisterEvent("Move_Points_OrbOfPower_G", 100, 0)
	elseif #pointsH == 0 then
		local distance = 18
		for i = 1, 360 do
			local nx = x + (distance * math.cos(i*r))
			local ny = y + (distance * math.sin(i*r))
			pointsH[i] = {nx, ny}
		end
		pUnit:RegisterEvent("Move_Points_OrbOfPower_H", 100, 0)
	end
	pUnit:RegisterEvent("CheckForDamage_nearplayers", 1000, 0)
end

function CheckForDamage_nearplayers(pUnit)
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:GetDistanceYards(pUnit) < 3 then
			if plrs:IsAlive() then
				pUnit:CastSpell(62003)
				pUnit:Strike(plrs, 2, 59743, 80, 120, 1)
			end
		end
	end
end

function Move_Points_OrbOfPower_A(pUnit)
	ai = ai + 6
	if ai > 359 then
		ai = 1
	end
	pUnit:MoveTo(pointsA[ai][1], pointsA[ai][2], pUnit:GetLandHeight(pointsA[ai][1], pointsA[ai][2]), 0)
end

function Move_Points_OrbOfPower_B(pUnit)
	bi = bi + 4
	if bi > 359 then
		bi = 1
	end
	pUnit:MoveTo(pointsB[bi][1], pointsB[bi][2], pUnit:GetLandHeight(pointsB[bi][1], pointsB[bi][2]), 0)
end

function Move_Points_OrbOfPower_C(pUnit)
	ci = ci + 3
	if ci > 359 then
		ci = 1
	end
	pUnit:MoveTo(pointsC[ci][1], pointsC[ci][2], pUnit:GetLandHeight(pointsC[ci][1], pointsC[ci][2]), 0)
end

function Move_Points_OrbOfPower_D(pUnit)
	if math.random(1,2) == 1 then
		di = di + 3
	else
		di = di + 2
	end
	if di > 359 then
		di = 1
	end
	pUnit:MoveTo(pointsD[di][1], pointsD[di][2], pUnit:GetLandHeight(pointsD[di][1], pointsD[di][2]), 0)
end

function Move_Points_OrbOfPower_E(pUnit)
	ei = ei + 3
	if ei > 359 then
		ei = 1
	end
	pUnit:MoveTo(pointsE[ei][1], pointsE[ei][2], pUnit:GetLandHeight(pointsE[ei][1], pointsE[ei][2]), 0)
end

function Move_Points_OrbOfPower_F(pUnit)
	fi = fi + 2
	if fi > 359 then
		fi = 1
	end
	pUnit:MoveTo(pointsF[fi][1], pointsF[fi][2], pUnit:GetLandHeight(pointsF[fi][1], pointsF[fi][2]), 0)
end

function Move_Points_OrbOfPower_G(pUnit)
	gi = gi + 2
	if gi > 359 then
		gi = 1
	end
	pUnit:MoveTo(pointsG[gi][1], pointsG[gi][2], pUnit:GetLandHeight(pointsG[gi][1], pointsG[gi][2]), 0)
end

function Move_Points_OrbOfPower_H(pUnit)
	hi = hi + 2
	if hi > 359 then
		hi = 1
	end
	pUnit:MoveTo(pointsH[hi][1], pointsH[hi][2], pUnit:GetLandHeight(pointsH[hi][1], pointsH[hi][2]), 0)
end

function Check_Health_FoR_Badboss(pUnit)
	if pUnit:GetHealthPct() < 70 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Random_Spells_Visuals_BadGuyLands", 12000, 0)
		pUnit:RegisterEvent("CastRandomSpellsETc", 5000, 0)
		for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(plrs) < 41 then
				pUnit:FullCastSpellOnTarget(72313, plrs)
				pUnit:CastSpellOnTarget(32361, plrs) -- freeze
			end
		end
		local y = 2386
 		for i=1,4 do
			y = y + 2
			pUnit:SpawnCreature(187117, -7166, -y, pUnit:GetLandHeight(-7166, -y), 0, 35, 0):SetUInt32Value(UNIT_FIELD_FLAGS, 33554434)
		end
		pUnit:RegisterEvent("CHeckForlighorbsphase", 2000, 0)
	end
end

function CHeckForlighorbsphase(pUnit)
	if pUnit:GetHealthPct() < 40 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Random_Spells_Visuals_BadGuyLands", 12000, 0)
		pUnit:RegisterEvent("CastRandomSpellsETc", 5000, 0)
		for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(plrs) < 41 then
				pUnit:FullCastSpellOnTarget(72313, plrs)
				pUnit:CastSpellOnTarget(32361, plrs) -- freeze
			end
		end
		pUnit:RegisterEvent("SpawnRandomLightOrbsTTT", 4000, 0)
	end
end

function SpawnRandomLightOrbsTTT(pUnit)
	local choice = math.random(1,8)
	pUnit:SpawnCreature(293521, coordsX[choice], coordsY[choice], pUnit:GetLandHeight(coordsX[choice], coordsY[choice]), 0, 15, 0):SetUInt32Value(UNIT_FIELD_FLAGS, 33554434)
end

RegisterUnitEvent(187117, 18, "OrbsOfPower_Spawn")

RegisterUnitEvent(180781, 1, "BadGuyBosLands_Eventys")
RegisterUnitEvent(180781, 2, "BadGuyBosLands_Eventys")
RegisterUnitEvent(180781, 4, "BadGuyBosLands_Eventys")

-- light orbs

function LightorbSpawnBad(pUnit, Event)
	pUnit:RegisterEvent("Wait_Before_MOVING_badguy", 1500, 1)
end

function Wait_Before_MOVING_badguy(pUnit)
	pUnit:MoveTo(-7173, -2390, pUnit:GetLandHeight(-7166, -2386), 0)
	pUnit:RegisterEvent("Check_For_NearbyStuffZZ", 1000, 0)
end

function Check_For_NearbyStuffZZ(pUnit)
	if near_boss(pUnit) then
		pUnit:Despawn(1000, 0)
	elseif near_player(pUnit) then
		pUnit:Despawn(1000, 0)
	end
end

function near_boss(pUnit)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:GetEntry() == 180781 then
			if unit:GetDistanceYards(pUnit) < 4 then
				pUnit:RemoveEvents()
				pUnit:CastSpell(52770) -- visual
				pUnit:CastSpell(15237) -- visual
				for _,plrs in pairs(pUnit:GetInRangePlayers()) do
					local distance = unit:GetDistanceYards(plrs)
					if distance < 60 and distance > 4 then
						unit:FullCastSpellOnTarget(72313, plrs)
						plrs:MoveKnockback(unit:GetX(), unit:GetY(), unit:GetZ(), 5, 7)
					end
				end
				return true
			end
		end
	end
	return false
end

function near_player(pUnit)
	for _,plr in pairs(pUnit:GetInRangePlayers()) do
		if plr:IsAlive() then
			if plr:GetDistanceYards(pUnit) < 4 then
				pUnit:RemoveEvents()
				plr:CastSpell(65828) -- surge of speed
				pUnit:CastSpell(52770) -- visual
				pUnit:CastSpell(15237) -- visual
				return true
			end
		end
	end
	return false
end

RegisterUnitEvent(293521, 18, "LightorbSpawnBad")

function Teleport_Creature_Spawn_Register(pUnit, Event)
	pUnit:RegisterEvent("Check_ForNearbToheslport", 2000, 0)
end

function Check_ForNearbToheslport(pUnit)
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:GetDistanceYards(pUnit) < 5 then
			plrs:CastSpell(62003) -- visual
			plrs:Teleport(349, 28, 61, -123.5)
		end
	end
end

RegisterUnitEvent(180751, 18, "Teleport_Creature_Spawn_Register")

-- Maraudon

function Boss_Portal_State_Spawn(pUnit, Event)
	pUnit:RegisterEvent("Boss_Portal_Visual_State", 1000, 0)
end

function Boss_Portal_Visual_State(pUnit)
	pUnit:CastSpell(42050)
end

RegisterUnitEvent(420501, 18, "Boss_Portal_State_Spawn")
