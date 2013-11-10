local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

function BlackrockMountainPortal_Spawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("BlackrockMountainPortal_Entry", 100, 0) 
end

RegisterUnitEvent(371901, 18, "BlackrockMountainPortal_Spawn")

function BlackrockMountainPortal_Entry(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if pUnit:GetDistanceYards(plr) < 2 then
			plr:Teleport(0, -7555.64, -1200.70, 476.41)
		end
	end
end

function SilverpinePortal_Spawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("SilverpinePortal_Entry", 100, 0) 
end

RegisterUnitEvent(371902, 18, "SilverpinePortal_Spawn")

function SilverpinePortal_Entry(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if plr:HasFinishedQuest(5505) then
			if pUnit:GetDistanceYards(plr) < 2 then
				plr:Teleport(0, -379.94, 1633.23, 17.43)
			end
		elseif plr:HasQuest(5504) then
			if pUnit:GetDistanceYards(plr) < 2 then
				plr:Teleport(0, 737.27, 730.23, 36.55)
			end
		end
	end
end

function IoC_Portal_Gos(pUnit, event, player)
	-- Tuskarr is not handled here
	local race = player:GetPlayerRace() 
	if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
		player:Teleport(628,301.01,-832.82,48.91)
	else
		player:Teleport(628,1264.27,-767.13,48.91)
	end
end

RegisterUnitGossipEvent(920080, 1, "IoC_Portal_Gos")
