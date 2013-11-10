local Ziuashg_GargoyleEntryID = 90550
local EMOTE_STATE_SUBMERGEDZOMGLOLZ = 429

function ASDASD_Gargoyle_OnLoadSpawnWhatever(pUnit, Event)
	pUnit:RegisterEvent("wait_a_second_So_it_has_a_chance_to_load_zogk", 750, 1)
end

RegisterUnitEvent(Ziuashg_GargoyleEntryID, 18, "ASDASD_Gargoyle_OnLoadSpawnWhatever")

function wait_a_second_So_it_has_a_chance_to_load_zogk(pUnit, Event)
	pUnit:RegisterEvent("Zomgiusf_CheckforPlayers_asdiusa", 3000, 0)
end

function Zomgiusf_CheckforPlayers_asdiusa(pUnit, Event)
	local BIOZEFVE = pUnit:GetClosestPlayer()
	if (BIOZEFVE ~= nil) then
		if (pUnit:GetDistanceYards(BIOZEFVE) <= 12) then
			if (BIOZEFVE:IsAlive() == true) then
				pUnit:RemoveEvents()
				--pUnit:SendChatMessage(12, 0, "Damn you!") -- lolwut, blizzlike? Not really :( Be more mature!
				pUnit:AttackReaction(BIOZEFVE, 100, 6603)
			end
		end
	else
		pUnit:Emote(429, 2999)
	end
end

function ASIDHASD_oasihdaoisd_asOnLeavecombat(pUnit, event)
	pUnit:Despawn(500, 2000)
end

RegisterUnitEvent(Ziuashg_GargoyleEntryID, 2, "ASIDHASD_oasihdaoisd_asOnLeavecombat")