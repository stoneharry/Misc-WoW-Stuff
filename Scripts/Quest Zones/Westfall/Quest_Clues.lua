  local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 
  
  function GrainClue_OnSpawn(pUnit,Event)
  pUnit:RegisterEvent("GrainClueSearch",1000,0)
  end
  
  function GrainClueSearch(pUnit,Event)
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if players ~= nil then
		if pUnit:GetDistanceYards(players) < 5 then
			if players:HasQuest(8001) then
				if (players:GetQuestObjectiveCompletion(8001, 0) == 0) then
				players:SendAreaTriggerMessage("Clue #1: The grain crates have been poisoned with plague!")
				players:AdvanceQuestObjective(8001, 0)
					end
				end
			end
		end
	end
 end
  
  
RegisterUnitEvent(44488, 18,"GrainClue_OnSpawn")


  function CorpseClue_OnSpawn(pUnit,Event)
  pUnit:RegisterEvent("CorpseClueSearch",1000,0)
  end
  
  
  function CorpseClueSearch(pUnit,Event)
  local player = pUnit:GetClosestPlayer()
	if player ~= nil then
		if pUnit:GetDistanceYards(player) < 4 then
   if player:HasQuest(8001) then
				if (player:GetQuestObjectiveCompletion(8001, 1) == 0) then
			pUnit:RemoveEvents()
			pUnit:SendChatMessageToPlayer(42,0,"A figure appears from the shadows!",player)
			pUnit:RegisterEvent("Waitasectospawn",1100,1)
				end
			end
		end
	end
end
  
  function Waitasectospawn(pUnit,Event)
  pUnit:SpawnCreature(44290, -9847.72, 1034.29,34.011, 2.40, 14, 2200000)	
  end
  
  
RegisterUnitEvent(44489, 18,"CorpseClue_OnSpawn")


function Cult_Leave(pUnit,Event) -- general leave
	pUnit:RemoveEvents()
end


function Cult_Dead(pUnit,Event) -- general dead
	pUnit:RemoveEvents()
	  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 44489 then 
	creature:RegisterEvent("CorpseClueSearch",1000,0)
end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if players ~= nil then
		if pUnit:GetDistanceYards(players) < 15 then
			if players:HasQuest(8001) then
				if (players:GetQuestObjectiveCompletion(8001, 1) == 0) then
				players:AdvanceQuestObjective(8001, 1)
				players:SendAreaTriggerMessage("Clue #2: A dragon cultist was in the residence.")
						end
					end
				end
			end
		end
	end
end


function Cult_Combat(pUnit,Event)
pUnit:CastSpell(24233)
 pUnit:RegisterEvent("Monster_Strike",3000,0)
 pUnit:RegisterEvent("Monster_Numb",6000,0)
end

function Monster_Strike(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 10 then
			pUnit:CastSpellOnTarget(1758,tank)
		end
	end
end

function Monster_Numb(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 12 then
			pUnit:CastSpellOnTarget(25810,tank)
		end
	end
end


function Cult_Spawn(pUnit,Event)
pUnit:EquipWeapons(35793,35793,0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
 pUnit:RegisterEvent("Sayso_FewSeconds",1000,1)
end

function Sayso_FewSeconds(pUnit,Event)
pUnit:SendChatMessage(12,0,"The Black Dragons will rule once again!")
end

RegisterUnitEvent(44290, 1,"Cult_Combat")
RegisterUnitEvent(44290, 18,"Cult_Spawn")
RegisterUnitEvent(44290, 3,"Cult_Leave")
RegisterUnitEvent(44290, 4,"Cult_Dead")