
function OnSpawnPlayVisual_Typhoon(pUnit, Event)
	pUnit:RegisterEvent("PlayVisual_Typhoon_Water", 5000, 0)
	pUnit:RegisterEvent("CheckForPlayer_Typhoon", 1000, 0)
end

function PlayVisual_Typhoon_Water(pUnit)
	pUnit:CastSpell(43119)
end

function CheckForPlayer_Typhoon(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 6 then
			plr:MoveKnockback(336.8, -16.8, 18.13, 3, 5)
			plr:SetPhase(2)
		end
	end
end

RegisterUnitEvent(131913, 18, "OnSpawnPlayVisual_Typhoon")

function TuskarrTyphoonMessage(pUnit, Event)
	pUnit:RegisterEvent("TuskarrTyphoonSendMessage", 1000, 0)
end

function TuskarrTyphoonSendMessage(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if plr:HasQuest(11001) then
			if plr:GetDistanceYards(pUnit) < 10 then
				pUnit:SendChatMessageToPlayer(12,0,"Your skills are growing daily, "..plr:GetName().."!", plr)
				pUnit:RemoveEvents()
				pUnit:Emote(25,0)
				pUnit:RegisterEvent("TuskarrTyphoonMessage", 20000, 1)
			end
		end
	end
end

RegisterUnitEvent(240551, 18, "TuskarrTyphoonMessage")