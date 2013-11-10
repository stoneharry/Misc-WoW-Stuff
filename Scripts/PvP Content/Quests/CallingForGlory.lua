--[[
PVP KILL 10 PLAYERS IN BATTLEGROUND
UNTESTED. PLEASE TEST.

~ Eclipse
]]



function CallingForGlory_Quest(event,pKiller,pVictim)
if pKiller:GetMapId() == 489 or pKiller:GetMapId() == 529 or pKiller:GetMapId() == 566 then
if pKiller:HasQuest(2040) and pVictim:GetFaction() == 1 and pKiller:GetQuestObjectiveCompletion(2040, 0) ~= 10 then
pKiller:AdvanceQuestObjective(2040, 0)
elseif pKiller:HasQuest(2041) and pVictim:GetFaction() == 2 and pKiller:GetQuestObjectiveCompletion(2041, 0) ~= 10 then
pKiller:AdvanceQuestObjective(2041, 0)
		end
	end
end

RegisterServerHook(2, "CallingForGlory_Quest")