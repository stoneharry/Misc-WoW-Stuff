
HG = {}
HG.VAR = {}

local OBJECT_END = 0x0006
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 -- Size: 1, Type: BYTES, Flags: PUBLIC

function HG.VAR.HGAIEvents(pUnit, Event)
	if Event == 1 then
		pUnit:RemoveEvents()
	else
		if pUnit:GetEntry() == 80051 and Event == 18 then
			pUnit:EquipWeapons(39125, 25091, 0)
			pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
		end
		if Event == 18 then
			pUnit:SetValue("spawn", {pUnit:GetX(), pUnit:GetY()})
		end
		pUnit:RegisterEvent("HG.VAR.HGMoveRandom", 5000, 1)
	end
end

function HG.VAR.HGMoveRandom(pUnit)
	pUnit:RegisterEvent("HG.VAR.HGMoveRandom", math.random(4, 6)*1000, 1)

	local x,y = pUnit:GetX(), pUnit:GetY()

	local start = pUnit:GetValue("spawn")
	if start then
		local a,b = start[1], start[2]
		if a and b then
			if pUnit:CalcToDistance(a, b, 0.1) > 11 then
				pUnit:ReturnToSpawnPoint()
				return
			end
		end
	end

	local choice = math.random(1,4)
	if choice == 1 then
		x = x + math.random(1,5)
		y = y + math.random(1,5)
	elseif choice == 2 then
		x = x + math.random(1,5)
		y = y - math.random(1,5)
	elseif choice == 3 then
		x = x - math.random(1,5)
		y = y + math.random(1,5)
	elseif choice == 4 then
		x = x - math.random(1,5)
		y = y - math.random(1,5)
	end
	local z = pUnit:GetLandHeight(x, y)
	if z < -1 then -- don't move into sea. Won't work while no map data
		pUnit:ReturnToSpawnPoint()
		return
	end
	pUnit:MoveTo(x,y,z,0)
end

RegisterUnitEvent(80050, 1, "HG.VAR.HGAIEvents")
RegisterUnitEvent(80050, 2, "HG.VAR.HGAIEvents")
RegisterUnitEvent(80050, 18, "HG.VAR.HGAIEvents")
RegisterUnitEvent(80051, 1, "HG.VAR.HGAIEvents")
RegisterUnitEvent(80051, 2, "HG.VAR.HGAIEvents")
RegisterUnitEvent(80051, 18, "HG.VAR.HGAIEvents")

function HG.VAR.GreatSharkDeath(pUnit, Event, pLastTarget)
	if pLastTarget then
		pLastTarget:LearnSpell(32011) -- Water bolt
	end
end

RegisterUnitEvent(246371, 4, "HG.VAR.GreatSharkDeath")
