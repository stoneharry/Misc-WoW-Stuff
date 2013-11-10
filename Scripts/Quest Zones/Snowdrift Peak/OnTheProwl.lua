
local points = {
	[1] = {4284.5, -2681.7, 1106.3, "Follow me."},
	[5] = {4303, -2642, 1111},
	[12] = {4352, -2601, 1119, "This way!"},
	[21] = {4387.7, -2650, 1114.2},
	[31] = {4508, -2666, 1127.7, "Just a little further."},
	[45] = {4585, -2687, 1137},
	[60] = {0}
}

function SpiritWolfSpawns(pUnit, Event)
	pUnit:RegisterEvent("LetsGetMovingAndFindPlayer", 1000, 1)
end

RegisterUnitEvent(311231, 18, "SpiritWolfSpawns")

function LetsGetMovingAndFindPlayer(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if plr:HasQuest(41108) then
			pUnit:SetPetOwner(plr)
			pUnit:SetValue("plr", plr)
			-- found plr
		end
		-- doesn't matter too much if we don't find
	end
	pUnit:SetMovementFlags(1)
	pUnit:SetValue("point", 0)
	pUnit:RegisterEvent("MoveThroughPointsWolf", 1000, 0)
end

function MoveThroughPointsWolf(pUnit)
	local p = pUnit:GetValue("point")
--[[ DEBUG
local plr = pUnit:GetClosestPlayer()
if plr then
plr:SendBroadcastMessage(tostring(p))
end
--]]
	if points[p] then
--[[ DEBUG
local plr = pUnit:GetClosestPlayer()
if plr then
plr:SendBroadcastMessage(tostring(points[p][1])..", "..tostring(points[p][2])..", "..tostring(points[p][3]))
end
--]]
		if points[p][4] then
			local plr = pUnit:GetValue("plr")
			if plr then
				pUnit:SendChatMessageToPlayer(12,0,points[p][4], plr)
			end
		end
		if points[p][1] == 0 then
			pUnit:RemoveEvents()
			pUnit:Despawn(1, 0)
		else
			pUnit:MoveTo(points[p][1], points[p][2], points[p][3], 0)
		end
	end
	pUnit:SetValue("point", p+1)
end