
local CinematicsSentTo = {}

function GetNearbyPlayersInitiate(pUnit, Event)
	pUnit:RegisterEvent("CinematicCheckPlayers", 1000, 0)
end

function CinematicCheckPlayers(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		if v:HasQuest(10042) then
			if not CinematicsSentTo[v:GetName()] then
				if v:GetDistanceYards(pUnit) < 10 then
					v:SendCinematic(252)
					CinematicsSentTo[v:GetName()] = 1
					CreateLuaEvent(function() v:SetPlayerLock(0); v:Unroot(); v:Teleport(0, -6649, -647.7, 242); end, 30000, 1)
				end
			end
		end
	end
end

RegisterUnitEvent(411686, 18, "GetNearbyPlayersInitiate")