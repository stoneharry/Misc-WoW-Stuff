
UnitCollisionOldIF = {}
StorePlayersEmotedTo = {}

function UnitCollisionOldIF.OldIFSPawn(pUnit, event)
	pUnit:RegisterEvent("UnitCollisionOldIF.PlayerEmoteOlDIF", 1000, 0)
end

RegisterUnitEvent(16976, 18, "UnitCollisionOldIF.OldIFSPawn")

function UnitCollisionOldIF.PlayerEmoteOlDIF(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		if (pUnit:GetDistanceYards(plr) <= 8) and not table.find(StorePlayersEmotedTo, tostring(pUnit)..plr:GetName()) then
			if math.random(1,3) == 1 then
				pUnit:Emote(66, 1200)
				pUnit:SendChatMessageToPlayer(16, 0, "The Denizen salutes "..plr:GetName().." with respect.", plr)
			else
				pUnit:Emote(2, 2500)
				pUnit:SendChatMessageToPlayer(16, 0, "The Denizen bows before "..plr:GetName()..".", plr)
			end
			table.insert(StorePlayersEmotedTo, tostring(pUnit)..plr:GetName())
		end
	end
end

function table.find(t, v)
	if type(t) == "table" and v then
		for k, val in pairs(t) do
			if (v == val) then
				return k
			end
		end
	end
	return false
end