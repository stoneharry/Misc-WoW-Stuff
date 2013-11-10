
function Tuskarr_DuelClick(pUnit, event, player)
	pUnit:GossipCreateMenu(5083, player, 0)
	if player:HasQuest(11002) then
		if math.random(1,2) == 1 then
			pUnit:GossipMenuAddItem(9, "I challenge you to a duel.", 1, 0)
		else
			pUnit:GossipMenuAddItem(9, "Face me in a duel, for I challenge you.", 1, 0)
		end
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function Tuskarr_DuelGossip(pUnit, event, player, id, intid, code)
	if intid == 1 then
		pUnit:SetNPCFlags(2)
		if math.random(1,2) == 1 then
			pUnit:SendChatMessageToPlayer(12,0,"I accept, "..player:GetName()..".", player)
		else
			pUnit:SendChatMessageToPlayer(12,0,"You are no match for me, "..player:GetName()..".", player)
		end
		local x, y, z = pUnit:GetLocation()
		pUnit:SetPosition(x, y, z, pUnit:CalcRadAngle(x, y, player:GetX(), player:GetY()))
		pUnit:Emote(1,0)
		pUnit:RegisterEvent("Start_Duel_Tuskarr", 1000, 1)
	end
	player:GossipComplete()
end

function Start_Duel_Tuskarr(pUnit)
	pUnit:SetFaction(21)
	pUnit:RegisterEvent("Check_For_Tuskarr_LostOrPlayer", 1000, 0)
end

function Check_For_Tuskarr_LostOrPlayer(pUnit)
	local plr = pUnit:GetMainTank()
	if plr == nil then
		pUnit:SetFaction(35)
		pUnit:Despawn(1000, 5000)
	else
		if plr:GetHealthPct() < 10 then
			pUnit:Emote(1,500)
			pUnit:RemoveEvents()
			pUnit:SendChatMessageToPlayer(12,0,"A fair duel, but you have lost.", plr)
			pUnit:SetFaction(35)
			pUnit:Despawn(1000, 5000)
		elseif pUnit:GetHealthPct() < 10 then
			pUnit:Emote(1,500)
			pUnit:SetFaction(35)
			pUnit:RemoveEvents()
			if math.random(1,2) == 1 then
				pUnit:SendChatMessageToPlayer(12,0,"Well done.", plr)
			else
				pUnit:SendChatMessageToPlayer(12,0,"A mighty battle was done today.", plr)
			end
			if plr:HasQuest(11002) then
				if plr:GetQuestObjectiveCompletion(11002, 0) ~= 5 then
					plr:AdvanceQuestObjective(11002, 0)
				end
			end
			pUnit:Despawn(1000, 30000)
		end
		if math.random(1,5) == 1 then
			if math.random(1,2) == 1 then
				pUnit:CastSpell(46977)
				pUnit:Strike(plr, 2, 55763, 3, 5, 1)
			else
				pUnit:CastSpell(46400)
				pUnit:Strike(plr, 2, 55763, 3, 5, 1)
			end
		end
	end
end

RegisterUnitGossipEvent(337921, 1, "Tuskarr_DuelClick")
RegisterUnitGossipEvent(337921, 2, "Tuskarr_DuelGossip")

function Tuskarr_Dueler_spawn(pUnit, Event)
	pUnit:SetNPCFlags(1)
end

RegisterUnitEvent(337921, 18, "Tuskarr_Dueler_spawn")

function Tuskarr_Chief_EmoteHandlezz(pUnit, Event)
	pUnit:RegisterEvent("Tusskarr_Emotes_Training", 1000, 1)
end

function Tusskarr_Emotes_Training(pUnit)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:IsInWorld() and unit:GetEntry() == 337921 and unit:GetFaction() == 35 and unit:IsAlive() and unit:IsInCombat() == false then
			unit:Emote(469, 9900)
		end
	end
	pUnit:RegisterEvent("DoAttacKEmote_Tuskarrs", 10000, 1)
end

function DoAttacKEmote_Tuskarrs(pUnit)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:IsInWorld() and unit:GetEntry() == 337921 and unit:GetFaction() == 35 and unit:IsAlive() and unit:IsInCombat() == false then
			unit:Emote(35, 0)
		end
	end
	pUnit:RegisterEvent("Tusskarr_Emotes_Training", 1100, 1)
end

RegisterUnitEvent(26194, 18, "Tuskarr_Chief_EmoteHandlezz")
