local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local Squadleader = nil
local aq = 0

function SquadLeader_OnSpawn(pUnit)
	Squadleader = pUnit
end

RegisterUnitEvent(412311, 18, "SquadLeader_OnSpawn")


function RabidWolvar_OnSpawn(pUnit,Event)
	pUnit:ModifyRunSpeed(16)
	pUnit:ModifyWalkSpeed(14)
	pUnit:SetMovementFlags(1)
	pUnit:RegisterEvent("RabidWolvar_MoveTo", 1000, 1)
end
	function RabidWolvar_MoveTo(pUnit,Event)
	pUnit:MoveTo(10424.76,664.47,1323.46,1.23)
end


RegisterUnitEvent(261200, 18, "RabidWolvar_OnSpawn")

function Quest_Kaluak(event, pPlayer, questId, pQuestGiver)
if questId == 11007 then
if aq == 0 then
aq = 1
Squadleader:SendChatMessage(12,0,"FOR KALU'AK! WE SHALL NOT FAIL!")
Squadleader:Emote(375,20000)
--pPlayer:PlaySoundToPlayer(30039)
Squadleader:RegisterEvent("SixtySecondsOrLess",68000,1) 
Squadleader:RegisterEvent("Spawn_Wolvar_At_Intervals",8000,7) 
for place,creatures in pairs(Squadleader:GetInRangeUnits()) do 
  if creatures:GetEntry() == 27178 and Squadleader:GetDistanceYards(creatures) < 15 then
  creatures:Emote(375,30000)
			end
		end
	end
end
	end

function Spawn_Wolvar_At_Intervals(pUnit)
Squadleader:SpawnCreature(261200,10415.67,625.09,1322.34,1.28, 14,0)
Squadleader:SpawnCreature(261200,10406.75,619.54,1323.26,1.28, 14,0)
end

function SixtySecondsOrLess(pUnit)
aq = 0
local PlayersAllAround = Squadleader:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if Squadleader:GetDistanceYards(players) < 40 and players:HasQuest(11007) then
			players:MarkQuestObjectiveAsComplete(11007,0)
		end
	end
	for place,creatures in pairs(Squadleader:GetInRangeUnits()) do 
  if creatures:GetEntry() == 261200 and Squadleader:GetDistanceYards(creatures) < 15 then
  creatures:Despawn(2000,0)
  Squadleader:Kill(creatures)
		end
	end
end

RegisterServerHook(14, "Quest_Kaluak")