function Cellar_Guardian_Events(pUnit,Event)
if Event == 1 then
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:Despawn(1,5000)
elseif Event == 4 then
pUnit:RemoveEvents()
elseif Event == 18 then
pUnit:SetFaction(35)
pUnit:RegisterEvent("CellarGuardian_ScanPlayers", 2000, 0)
end
end


function CellarGuardian_ScanPlayers(pUnit,Event)
local player = pUnit:GetClosestPlayer()
	if player then 
if pUnit:GetDistanceYards(player) < 12 and player:HasQuest(90001) and player:GetQuestObjectiveCompletion(90001, 0) == 0 then
pUnit:RemoveEvents()
pUnit:SendChatMessageToPlayer(42, 0, "The guardian begins to scan your life signatures.", player)
pUnit:CastSpellOnTarget(55224,player)
pUnit:RegisterEvent("CellarGuardian_Dialogue_One", 7000, 1)
		end
	end
end

function CellarGuardian_Dialogue_One(pUnit,Event)
pUnit:SendChatMessage(12, 0, "You are not the master, I await the master's return.")
pUnit:RegisterEvent("CellarGuardian_Dialogue_Two", 5000, 1)
end

function CellarGuardian_Dialogue_Two(pUnit,Event)
pUnit:SendChatMessage(12, 0, "SCANNING - Master Orlanth Location: Unknown")
pUnit:RegisterEvent("CellarGuardian_Dialogue_Three", 4000, 1)
end

function CellarGuardian_Dialogue_Three(pUnit,Event)
pUnit:SendChatMessage(12, 0, "SCANNING- Last Sighting: Aegwyth Dynasty.")
pUnit:RegisterEvent("CellarGuardian_Dialogue_Four", 4000, 1)
end

function CellarGuardian_Dialogue_Four(pUnit,Event)
pUnit:SendChatMessage(12, 0, "ALERT! You are intruding upon the master's domain, I will be forced to terminate you.")
pUnit:RegisterEvent("CellarGuardian_ChangeFct", 4000, 1)
end

function CellarGuardian_ChangeFct(pUnit,Event)
pUnit:SetFaction(14)
end


RegisterUnitEvent(700983, 1, "Cellar_Guardian_Events")
RegisterUnitEvent(700983, 2, "Cellar_Guardian_Events")
RegisterUnitEvent(700983, 4, "Cellar_Guardian_Events")
RegisterUnitEvent(700983, 18, "Cellar_Guardian_Events")

function AdarrahSpawn(pUnit,Event)
pUnit:RegisterEvent("Adarrah_Yell", math.random(25000,55000), 0)
end

function Adarrah_Yell(pUnit)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
	local choice = math.random(1,4)
if choice == 1 then
pUnit:SendChatMessageToPlayer(12,0,"You are a dissapointment.",players)
elseif choice == 2 then
pUnit:SendChatMessageToPlayer(12,0,"Cowards.",players)
elseif choice == 4 then
pUnit:SendChatMessageToPlayer(12,0,"You call yourselves 'warriors'?",players)
end
end
end
end

RegisterUnitEvent(24405, 18, "AdarrahSpawn")