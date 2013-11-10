local general
local escortA
local escortB
local alliance
local i = 0

function AllianceNegotiationTrigger(pUnit, Event)
	pUnit:RegisterEvent("CheckForPlayerNegotiation", 2000, 0)
end

function CheckForPlayerNegotiation(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		if v:HasQuest(551) and v:IsAlive() and v:GetDistanceYards(pUnit) < 25 and v:GetQuestObjectiveCompletion(551, 0) == 0 then
			pUnit:RemoveEvents()
			local npc = pUnit:GetCreatureNearestCoords(-8062, -791, 133, 143221)
			if npc then
				npc:Emote(5, 0)
				npc:SendChatMessage(14,0,"Horde spotted! Small scouting party - threat is neglibible - take caution.")
			end
			general = pUnit:SpawnCreature(90210, -7992, -823, 131, 2.623134, 35, 0, 25537, 0, 0, 2)
			escortA = pUnit:SpawnCreature(90211, -7990, -817, 130, 2.759851, 35, 0, 38237, 0, 0, 2)
			escortB = pUnit:SpawnCreature(90211, -7995, -828, 132, 2.543866, 35, 0, 38237, 0, 0, 2)
			pUnit:RegisterEvent("NegCinHandler", 1000, 0)
		end
	end
end

function NegCinHandler(pUnit)
	i = i + 1
	if i == 1 then
		general:SetPhase(1)
		general:SetMount(40007)
		general:SetMovementFlags(1)
		escortA:SetPhase(1)
		escortA:SetMovementFlags(1)
		escortA:SetMount(14334)
		escortB:SetPhase(1)
		escortB:SetMovementFlags(1)
		escortB:SetMount(14334)
	elseif i == 2 then
		general:MoveTo(-8049, -786, 131.9, 2.784141)
		escortA:MoveTo(-8046, -784, 131.3, 2.755138)
		escortB:MoveTo(-8047, -790, 132.3, 2.861167)
	elseif i == 6 then
		local npc = pUnit:GetCreatureNearestCoords(-8062, -791, 133, 143221)
		if npc then
			npc:Emote(375, 30000)
		end
		npc = pUnit:GetCreatureNearestCoords(-8058, -771.4, 131.4, 143221)
		if npc then
			npc:Emote(375, 30000)
		end
	elseif i == 12 then
		general:SendChatMessage(14, 0, "Dwarfs, I enter your domain with the intent to secure a moment of talks with your leader. Allow me to speak with your leader.")
		general:Emote(1,0)
		alliance = pUnit:SpawnCreature(90212, -8098, -753, 135, 5.7, 35, 0, 4977, 22819, 0, 1)
	elseif i == 13 then
		alliance:SetMount(28918)
		alliance:SetMovementFlags(1)
		alliance:MoveTo(-8061, -781, 132, 5.875503)
	elseif i == 17 then
		npc = pUnit:GetCreatureNearestCoords(-8058, -771.4, 131.4, 143221)
		if npc then
			npc:SendChatMessage(14,0,"Your kind has no place in these lands, Orc. Leave now or suffer our fury!")
		end
	elseif i == 20 then
		alliance:SendChatMessage(12,0, "Wait, master dwarf. I have been indirectly informed of this arrival.")
		alliance:Emote(1,0)
	elseif i == 24 then
		general:SendChatMessage(12,0,"You have?")
		general:Emote(6,0)
	elseif i == 26 then
		alliance:Emote(1,0)
		alliance:SendChatMessage(12,0,"Yes. You are not the only one who has made contact with this new threat - the presence that is becoming more potent with each passing day. And I assume you have come to the same conclusion I have, which is why you are here now.")
	elseif i == 36 then
		general:Emote(1,0)
		general:SendChatMessage(12,0,"You assume a lot; some might even say too much. Be careful with your words-")
	elseif i == 40 then
		alliance:Emote(5,0)
		alliance:SendChatMessage(12,0,"Let us cut the politics and move into negotiations! I will come to your secured Tanner Camp as an act of trust at dawn. We can talk more then.")
	elseif i == 45 then
		general:Emote(1,0)
		general:SendChatMessage(12,0,"Agreed.")
	elseif i == 47 then
		general:ReturnToSpawnPoint()
		escortA:ReturnToSpawnPoint()
		escortB:ReturnToSpawnPoint()
	elseif i == 49 then
		local plr = alliance:GetClosestPlayer()
		if plr then
			alliance:SetFacing(math.pi+plr:GetO()) -- face the player, math.pi = half a circle, so half a circle + way player is facing = facing player (180* turn)
			alliance:SendChatMessage(12,0,"Ah, "..plr:GetName()..". You should return to the one in charge here. Thank you for inadvertently alerting me.")
		end
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			if v:HasQuest(551) then
				v:MarkQuestObjectiveAsComplete(551, 0)
			end
		end
	elseif i == 55 then
		general:SetPhase(2)
		escortA:SetPhase(2)
		escortB:SetPhase(2)
		alliance:ReturnToSpawnPoint()
	elseif i == 60 then
		general:Despawn(1,0)
		escortA:Despawn(1,0)
		escortB:Despawn(1,0)
		alliance:Despawn(1,0)
		alliance = nil
		general = nil
		escortA = nil
		escortB = nil
		i = 0
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("AllianceNegotiationTrigger", 10000, 1)
	end
end

RegisterUnitEvent(22867, 18, "AllianceNegotiationTrigger")