
local PlayerClassToInt = {["Warrior"] = 1, ["Paladin"] = 2, ["Hunter"] = 3, ["Rogue"] = 4, ["Priest"] = 5,
["Death Knight"] = 6, ["Shaman"] = 7, ["Mage"] = 8, ["Warlock"] = 9, ["Druid"] = 11, ["Demon Hunter"] = 12}

local RADIAN_START = 0.5*math.pi -- WoW works in radians
local OBJECT_END = 0x006
local UNIT_FIELD_MOUNTDISPLAYID = OBJECT_END + 0x094

RaceStringTable = {"Human", "Orc", "Night Elf", "Undead", "Tauren", "Gnome", "Troll", "NULL", "Blood Elf", "Draenei"} -- RaceStringTable[player:GetPlayerRace()]

CooldownTime = {}

function CooldownCheck(player, COOLDOWN_TIME)
	if CooldownTime[player:GetName()] ~= nil and ((os.clock()-CooldownTime[player:GetName()])) <= COOLDOWN_TIME then
		player:SendAreaTriggerMessage("|cFFFF0000You cannot use this yet.")
		return true
	else
		return false
	end
end

function MoveBasedOnOrientation(pUnit, orientation, yards)
	local UNIT_RADIANS = RADIAN_START + orientation -- WoW's orientation is a radian, because WoW's circle starts at the top we need the radian_start to make sure we're counting from the top
	local UNIT_Y = math.cos(UNIT_RADIANS)*-yards -- WoW has switched the x and y axis, x is from bottom to top, y from right to left
	local UNIT_X = math.sin(UNIT_RADIANS)*yards -- meaning y counts up if going to left, counts down if going to right, x counts up top, bottom: down
	-- multiply by the yards we want to move as it'll return a number based on a circle which consists of 1 to each side (unit circle?)
	pUnit:MoveTo(pUnit:GetX()+UNIT_X, pUnit:GetY()+UNIT_Y, pUnit:GetLandHeight(pUnit:GetX()+UNIT_X, pUnit:GetY()+UNIT_Y), pUnit:GetO())
	-- moving to new location, use GetLandHeight to get the height of the new location to prevent clipping (going through the ground)	
end

--[[function Mount(unit, displayid, time) -- This was kept implemented even though hypersniper said he would remove, uneeded function
	unit:SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, displayid)
	if (time) then
		RegisterTimedEvent("DismountUnit", time, 1, unit)
	end
end

function DismountUnit(unit) -- This was kept implemented even though hypersniper said he would remove, uneeded function
	unit:SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0)
end]]

--[[ GET UNIT WITH LOWEST HEALTH ]] -- UNTESTED USE WITH CAUTION

function GetUnitLowestHealth(units) -- units is a table
	if units == nil then return end
	if type(units) ~= "table" then print("ERROR GetUnitLowestHealth: expected table, got " ..type(units)) return end
	
	--local UnitHealth = {}
	units.health = {}
	
	for k,v in pairs(units) do
		local HealthPct = v:GetHealthPct()
		units[k] = {v, HealthPct}
		table.insert(units.health, HealthPct) -- table.insert(UnitHealth, HealthPct) 
	end
	
	table.sort(units.health)
	
	for k,v in pairs(units) do
		if k[2] == units.health[1] then -- if k[2] == UnitHealth[1] then
			return k[1]
		end
	end
end
