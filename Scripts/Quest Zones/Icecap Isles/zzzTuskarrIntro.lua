
function Tuskar_SpawnGuy(pUnit, Event)
	pUnit:RegisterEvent("CheckForNearbyPlayer_Tuskarr", 500, 0)
end

function CheckForNearbyPlayer_Tuskarr(pUnit)
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:GetPhase() == 2 then
			if plrs:GetDistanceYards(pUnit) < 10 and (not plrs:IsOnTaxi()) then
				plrs:SetPhase(4)
				pUnit:RemoveEvents()
				pUnit:RegisterEvent("SendMessage_Tuskarr_SpawnGuy", 1000, 1)
			end
		end
	end
end

function SendMessage_Tuskarr_SpawnGuy(pUnit)
	pUnit:SendChatMessage(12,0,"The spirits are pleased with our hunt. Tonight we feast.")
	pUnit:Emote(1, 2000)
	pUnit:RegisterEvent("MoveToCenter_Tuskarrr", 2500, 1)
end

function MoveToCenter_Tuskarrr(pUnit)
	pUnit:MoveTo(416.33, -168.77, 0, 0)
	pUnit:RegisterEvent("Reset_Creature_ETC_Tuskarr", 4000, 1)
end

function Reset_Creature_ETC_Tuskarr(pUnit)
	pUnit:ReturnToSpawnPoint()
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:GetPhase() == 4 then
			if plrs:GetDistanceYards(plrs) < 20 and (not plrs:IsOnTaxi()) then
				plrs:SetPhase(1)
			end
		end
	end
	pUnit:RegisterEvent("Tuskar_SpawnGuy", 4000, 1)
end

RegisterUnitEvent(21358, 18, "Tuskar_SpawnGuy")
