
local SelectedItem = {}

function BlastedLandsHORDE_OnQuestAccept(event, pPlayer, questId, pQuestGiver)
if (questId == 4468) then
pPlayer:SetPhase(3)
local Pitlord = pPlayer:GetCreatureNearestCoords(-11034.83,-2787.60,4.9, 44877)
	if Pitlord ~= nil then
		if Pitlord:IsDead() == true then
Pitlord:SendChatMessageToPlayer(14, 0, "Abandon all hope! The legion has returned to finish what was begun so many years ago. This time there will be no escape!", pPlayer)
Pitlord:Despawn(1,1)
pPlayer:PlaySoundToSet(10999)
pPlayer:PlaySoundToSet(15877)
pPlayer:CastSpell(69235)
	else
Pitlord:SendChatMessageToPlayer(14, 0, "Abandon all hope! The legion has returned to finish what was begun so many years ago. This time there will be no escape!", pPlayer)
pPlayer:PlaySoundToSet(10999)
pPlayer:PlaySoundToSet(15877)
pPlayer:CastSpell(69235)
end
end
end
end


RegisterServerHook(14, "BlastedLandsHORDE_OnQuestAccept")


function BlastedLandsALLIANCE_OnQuestAccept(event, pPlayer, questId, pQuestGiver)
if (questId == 4368) then
	pPlayer:SetPhase(3)
local Dreadlordzz = pPlayer:GetCreatureNearestCoords(-10977.51,-3246.74,6.9, 14506)
	if Dreadlordzz ~= nil then
		if Dreadlordzz:IsDead() == true then
Dreadlordzz:SendChatMessageToPlayer(14, 0, "You are defenders of a doomed world. Flee here and perhaps you will prolong your pathetic lives.", pPlayer)
pPlayer:PlaySoundToSet(10977)
Dreadlordzz:Despawn(1,1)
pPlayer:CastSpell(69235)
	else
Dreadlordzz:SendChatMessageToPlayer(14, 0, "You are defenders of a doomed world. Flee here and perhaps you will prolong your pathetic lives.", pPlayer)
pPlayer:PlaySoundToSet(10977)
pPlayer:CastSpell(69235)
end
end
end
end

RegisterServerHook(14, "BlastedLandsALLIANCE_OnQuestAccept")



function BlastedLandsTemperedSword(item, event, player)
	if player:HasQuest(4468) then
		if CooldownCheck(player, 60) then
			return
		else
			CooldownTime[player:GetName()] = os.clock()
			if player:GetSelection() ~= nil then
				local target = player:GetSelection()
				if SelectedItem[player:GetName()] ~= nil then
					if SelectedItem[player:GetName()] == target:GetGUID() then
						player:SendAreaTriggerMessage("|cFFFF0000You have already used the sword's power!")
						return
					else
						SelectedItem[player:GetName()] = target:GetGUID()
					end
				end
				if target:GetEntry() == 44877 then
					player:CastSpellOnTarget(53317, target)
					target:SendChatMessageToPlayer(14, 0, "Suffer you despicable insect!", player)
						target:CastSpell(43401) -- BloodVisual
player:PlaySoundToPlayer(11000)
				else
					player:SendAreaTriggerMessage("|cFFFF0000Wrong target!")
				end
			else
				player:SendAreaTriggerMessage("|cFFFF0000No selection!")
			end
		end
	else
		player:SendAreaTriggerMessage("|cFFFF0000You do not have the required quest!")
	end
end


RegisterItemGossipEvent(11136, 1, "BlastedLandsTemperedSword")





function PITLORD_QUEST_DEAD(pUnit,Event)
pUnit:RemoveEvents()
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 15 then
  	if players:HasQuest(4468) then
	if players:IsInPhase(3) == true then
pUnit:SendChatMessageToPlayer(14, 0, "Your time is almost... up.",players)
players:PlaySoundToSet(11002)
players:MarkQuestObjectiveAsComplete(4468, 0)
end
end
end
end
end



RegisterUnitEvent(44877,4,"PITLORD_QUEST_DEAD") 