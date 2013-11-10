
function TwilightChieften_Combat(pUnit, Event)
	if Event == 1 then
		local event = false
		for _,plr in pairs(pUnit:GetInRangePlayers()) do
			if plr:HasQuest(10) and pUnit:GetDistanceYards(plr) < 35 then
				if plr:GetQuestObjectiveCompletion(10, 2) == 3 then
					pUnit:SendChatMessageToPlayer(14,0,"You again?!", plr)
				else
					pUnit:SendChatMessageToPlayer(14,0,"Meddlesome whelp! I will banish you from my home!", plr)
					event = true
				end
			end
		end
		if event then
			pUnit:RegisterEvent("CheckForLowHealth_Chief", 1000, 0)
		end
		pUnit:RegisterEvent("CastSpells_ShadowBolt_Chief", 8000, 0)
	else
		pUnit:RemoveEvents()
	end
end

function CheckForLowHealth_Chief(pUnit)
	if pUnit:GetHealthPct() < 50 then
		for k,v in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(v) < 10 and v:GetPhase() == 1 and v:HasQuest(10) then
				v:CastSpell(200020)
				v:SetPhase(2)
			end
		end
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"Enough! I'll let my warlocks deal with you!")
		pUnit:CancelSpell()
	end
end

function CastSpells_ShadowBolt_Chief(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(686, plr) -- shadow bolt
	end
end

RegisterUnitEvent(20958, 1, "TwilightChieften_Combat")
RegisterUnitEvent(20958, 2, "TwilightChieften_Combat")
RegisterUnitEvent(20958, 4, "TwilightChieften_Combat")

function warlock_onSpawn_ogre(pUnit, Event)
	if Event == 1 then
		pUnit:RemoveEvents()
		pUnit:StopChannel()
		pUnit:FullCastSpell(696) -- demon skin
		pUnit:RegisterEvent("CastSpells_ShadowBolt_Chief", 6000, 0)
	elseif Event == 18 then
		pUnit:RegisterEvent("Channel_DependingOnGUID_OGre", 1000, 1)
	elseif Event == 2 then
	pUnit:RemoveEvents()
		pUnit:RegisterEvent("Channel_DependingOnGUID_OGre", 5000, 1)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		for _,plr in pairs(pUnit:GetInRangePlayers()) do
			if plr:HasQuest(10) and plr:GetPhase() == 2 and plr:GetDistanceYards(pUnit) < 35 then
				if plr:GetQuestObjectiveCompletion(10, 2) ~= 3 then
					plr:AdvanceQuestObjective(10, 2)
				end
				if plr:GetQuestObjectiveCompletion(10, 2) == 3 then
					plr:RemoveAura(200020)
					plr:SetPhase(1)
				end
			end
		end
	end
end

function Channel_DependingOnGUID_OGre(pUnit)
	if pUnit:IsAlive() then
		local self = pUnit:GetUnitBySqlId(9278570)
		local found = false
		if self then
			if self:GetX() == pUnit:GetX() then
				local target = pUnit:GetUnitBySqlId(9278585)
				if target then
					found = true
					pUnit:ChannelSpell(61942, target)
				end
			end
		end
		if not found then
			self = pUnit:GetUnitBySqlId(9278569)
			if self then
				if self:GetX() == pUnit:GetX() then
					local target = pUnit:GetUnitBySqlId(9278584)
					if target then
						pUnit:ChannelSpell(61942, target)
					end
				end
			end
		end
	end
end

RegisterUnitEvent(20957, 18, "warlock_onSpawn_ogre")
RegisterUnitEvent(20957, 1, "warlock_onSpawn_ogre")
RegisterUnitEvent(20957, 2, "warlock_onSpawn_ogre")
RegisterUnitEvent(20957, 4, "warlock_onSpawn_ogre")

function DEATH_WARLORD(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		plr:CastSpell(65640)
	end
end

RegisterUnitEvent(50020, 4, "DEATH_WARLORD")

function DREADMAUL_CHECKSPAWN(pUnit,Event)
	pUnit:RegisterEvent("DREADMAUL_CHECKPLR", 1000, 0)
end

function DREADMAUL_CHECKPLR(pUnit,Event)
	local player = pUnit:GetClosestPlayer()
	if player and pUnit:GetDistanceYards(player) < 10 and player:HasQuest(10) and (player:GetQuestObjectiveCompletion(10, 0) == 0) then
		player:AdvanceQuestObjective(10, 0)
	end
end

RegisterUnitEvent(33742, 18, "DREADMAUL_CHECKSPAWN")