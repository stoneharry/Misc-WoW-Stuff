--Made by Laurea (the Insane)

local DataValue = {
	_player = {},
	_creature = {},
	_gameobject = {},
	_map = {},
	_instance = {},
};
PLAYER = LCF.PlayerMethods;
UNIT = LCF.CreatureMethods;
GOBJ = LCF.GOMethods;
assert(PLAYER);
assert(UNIT);
assert(GOBJ);

function err(val, exp, func, arg, lvl)
	if (exp == type(val)) then
		return true;
	end
	local tmp = {"Bad argument #", arg, " to ", func, " (", exp, " expected, got ", type(val), ")."};
	error(table.concat(tmp), lvl or 3);
end
-----------------------------------------------------------------------------------------------------
local function Set(tbl, field, value, obj, extra)
	if (type(field) ~= "string" and type(field) ~= "number") then
		local pos = 1;
		local func = "SetValue";
		if (extra == 1) then
			pos = 2;
			func = "SetMapValue";
		elseif (extra == 2) then
			pos = 2;
			func = "SetInstanceValue";
		end
		err(field, "string or number", func, pos, 4);
		return nil;
	end
	if (tbl[obj] == nil) then
		tbl[obj] = {};
	end
	tbl[obj][field] = value;
	return 1;
end
--Set PLAYER
function PLAYER:SetValue(field, value)
	return Set(DataValue._player, field, value, tostring(self));
end
function PLAYER:SetMapValue(field, value)
	return Set(DataValue._map, field, value, self:GetMapId(), 1);
end
function PLAYER:SetInstanceValue(field, value)
	return Set(DataValue._instance, field, value, self:GetInstanceID(), 2);
end
--Set UNIT
function UNIT:SetValue(field, value)
	return Set(DataValue._creature, field, value, tostring(self));
end
function UNIT:SetMapValue(field, value)
	return Set(DataValue._map, field, value, self:GetMapId(), 1);
end
function UNIT:SetInstanceValue(field, value)
	return Set(DataValue._instance, field, value, self:GetInstanceID(), 2);
end
--Set GOBJ
function GOBJ:SetValue(field, value)
	return Set(DataValue._gameobject, field, value, tostring(self));
end
function GOBJ:SetMapValue(field, value)
	return Set(DataValue._map, field, value, self:GetMapId(), 1);
end
function GOBJ:SetInstanceValue(field, value)
	return Set(DataValue._instance, field, value, self:GetInstanceID(), 2);
end
--Set Global
function SetMapValue(map, field, value)
	if (type(map) ~= "number") then err(map, "number", "SetMapValue", 1, 3); end
	return Set(DataValue._map, field, value, map, 1);
end
function SetInstanceValue(instance, field, value)
	if (type(instance) ~= "number") then err(instance, "number", "SetInstanceValue", 1, 3); end
	return Set(DataValue._instance, field, value, instance, 2);
end
-----------------------------------------------------------------------------------------------------
local function Get(tbl, field, obj, extra)
	if (type(field) ~= "string" and type(field) ~= "number") then
		local pos = 1;
		local func = "GetValue";
		if (extra == 1) then
			pos = 2;
			func = "GetMapValue";
		elseif (extra == 2) then
			pos = 2;
			func = "GetInstanceValue";
		end
		err(field, "string or number", func, pos, 4);
		return nil;
	end
	if (tbl[obj] == nil) then
		return nil;
	end
	return tbl[obj][field];
end
--Get PLAYER
function PLAYER:GetValue(field)
	return Get(DataValue._player, field, tostring(self));
end
function PLAYER:GetMapValue(field)
	return Get(DataValue._map, field, self:GetMapId(), 1);
end
function PLAYER:GetInstanceValue(field)
	return Get(DataValue._instance, field, self:GetInstanceID(), 2);
end
--Get UNIT
function UNIT:GetValue(field)
	return Get(DataValue._creature, field, tostring(self));
end
function UNIT:GetMapValue(field)
	return Get(DataValue._map, field, self:GetMapId(), 1);
end
function UNIT:GetInstanceValue(field)
	return Get(DataValue._instance, field, self:GetInstanceID(), 2);
end
--Get GOBJ
function GOBJ:GetValue(field)
	return Get(DataValue._gameobject, field, tostring(self));
end
function GOBJ:GetMapValue(field)
	return Get(DataValue._map, field, self:GetMapId(), 1);
end
function GOBJ:GetInstanceValue(field)
	return Get(DataValue._instance, field, self:GetInstanceID(), 2);
end
--Get Global
function GetMapValue(map, field)
	if (type(map) ~= "number") then err(map, "number", "GetMapValue", 1, 3); end
	return Get(DataValue._map, field, map, 1);
end
function GetInstanceValue(instance, field)
	if (type(instance) ~= "number") then err(instance, "number", "GetInstanceValue", 1, 3); end
	return Get(DataValue._instance, field, instance, 2);
end
-----------------------------------------------------------------------------------------------------
local function Mod(tbl, field, value, obj, extra)
	if (value == nil) then return nil; end
	local t = type(value);
	if (type(field) ~= "string" and type(field) ~= "number") then
		local pos = 1;
		local func = "ModValue";
		if (extra == 1) then
			pos = 2;
			func = "ModMapValue";
		elseif (extra == 2) then
			pos = 2;
			func = "ModInstanceValue";
		end
		err(field, "string or number", func, pos, 4);
		return nil;
	elseif (t ~= "string" and t ~= "number" and t ~= "table") then
		local pos = 2;
		local func = "ModValue";
		if (extra == 1) then
			pos = 3;
			func = "ModMapValue";
		elseif (extra == 2) then
			pos = 3;
			func = "ModInstanceValue";
		elseif (extra == 3) then
			func = "ModMemberValue";
		end
		err(field, "string, number or table", func, pos, 4);
		return nil;
	end
	if (tbl[obj] == nil) then
		tbl[obj] = {};
	end
	if (t ~= type(tbl[obj][field])) then
		tbl[obj][field] = value;
	else
		local val = tbl[obj][field];
		if (t == "number") then
			tbl[obj][field] = val + value;
		elseif (t == "string") then
			tbl[obj][field] = val..value;
		elseif (t == "table") then
			for k, v in pairs (value) do
				tbl[obj][field][k] = v;
			end
		end
	end
	return tbl[obj][field];
end
--Mod PLAYER
function PLAYER:ModValue(field, value)
	return Mod(DataValue._player, field, value, tostring(self));
end
function PLAYER:ModMapValue(field, value)
	return Mod(DataValue._map, field, value, self:GetMapId(), 1);
end
function PLAYER:ModInstanceValue(field, value)
	return Mod(DataValue._instance, field, value, self:GetInstanceID(), 2);
end
--Mod UNIT
function UNIT:ModValue(field, value)
	return Mod(DataValue._creature, field, value, tostring(self));
end
function UNIT:ModMapValue(field, value)
	return Mod(DataValue._map, field, value, self:GetMapId(), 1);
end
function UNIT:ModInstanceValue(field, value)
	return Mod(DataValue._instance, field, value, self:GetInstanceID(), 2);
end
--Mod GOBJ
function GOBJ:ModValue(field, value)
	return Mod(DataValue._gameobject, field, value, tostring(self));
end
function GOBJ:ModMapValue(field, value)
	return Mod(DataValue._map, field, value, self:GetMapId(), 1);
end
function GOBJ:ModInstanceValue(field, value)
	return Mod(DataValue._instance, field, value, self:GetInstanceID(), 2);
end
--Mod Global
function ModMapValue(map, field, value)
	if (type(map) ~= "number") then err(map, "number", "ModMapValue", 1, 3); end
	return Mod(DataValue._map, field, value, map, 1);
end
function ModInstanceValue(instance, field, value)
	if (type(instance) ~= "number") then err(instance, "number", "ModInstanceValue", 1, 3); end
	return Mod(DataValue._instance, field, value, instance, 2);
end
-----------------------------------------------------------------------------------------------------
function SetDataValue()
	error("SetDataValue has been removed.", 3);
end
function GetDataValue()
	error("GetDataValue has been removed.", 3);
end
function ModDataValue()
	error("ModDataValue has been removed.", 3);
end