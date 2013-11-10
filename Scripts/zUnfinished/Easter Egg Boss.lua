--[[
local map = 616
local x = 754
local y = 1315.6
local z = 312.15 --311.05
local steps = 18
local o = ((math.pi * 2) - 0.025) / steps
local dist = 31

function CreateRing(x, y, z, o, steps, dist)
	local tbl = {}
	for i = 1, steps do
		local nx = x + (dist * math.cos(o*i))
		local ny = y + (dist * math.sin(o*i))
		tbl[i] = {nx, ny, z, ((o * i) + math.pi)}
	end
	return tbl
end
]]

local Portals = {}
local num = 1

function MiscPortal_OnSpawn(go)
	if (go:GetMapId() ~= 616) then
		table.insert(Portals, go)
		go:SetValue("MiscPortal_Number", num)
		num = num + 1
	end
end

function MiscPortal_OnUse(go, event, player)
	if (player:GetMapId() == 616) then
		player:Teleport(0, -7483.22, -1244.22, 477.42, 5.51) --Mall
	else
		if (#Portals < 2) then return; end
		local r = math.random(1, (#Portals))
		local this = go:GetValue("MiscPortal_Number")
		if (not this) then return; end
		while (r == this) do
			r = math.random(1, (#Portals))
		end
		local tar = Portals[r]
		if (not tar) then return; end
		if (math.random(1, 50) == 25) then
			player:Teleport(616, 704.35, 1325.15, 313.11, 6.094) --Eye of Eternity
		else
			local map = tar:GetMapId()
			local x, y, z, o = tar:GetLocation()
			player:Teleport(map, x, y, z, o)
		end
	end
end

RegisterGameObjectEvent(175500, 2, MiscPortal_OnSpawn)
RegisterGameObjectEvent(175500, 4, MiscPortal_OnUse)

function MiscPortalGroup_OnUse(go, event, player)
	if (player:IsInGroup() and not player:IsInCombat()) then
		for k, v in pairs (player:GetGroupPlayers()) do
			if (v:IsInWorld() and not v:IsInCombat() and
				v:GetName() ~= player:GetName()) then
				v:Teleport(616, 704.35, 1325.15, 313.11, 6.094)
			end
		end
	end
end

RegisterGameObjectEvent(175501, 4, MiscPortalGroup_OnUse)

SetDBCSpellVar(38086, "Attributes", GetDBCSpellVar(38087, "Attributes"))

