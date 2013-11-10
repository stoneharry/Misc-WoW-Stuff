-- Disabled script due to conflict with ToA

--[[
local Jones = nil
local VoiceD = nil
local Rock = nil
local q = 0 -- set to 0 if quest complete

local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 


function HarrisonJones_OnSpawn(pUnit,Event)
Jones = pUnit
Jones:Unroot()
Jones:SetNPCFlags(2)
Jones:SetCombatTargetingCapable(true) -- debug 
Jones:SetCombatCapable(true)
end

RegisterUnitEvent(26814, 18, "HarrisonJones_OnSpawn")

function BadlandsEvent_OnQuestAccept(event, pPlayer, questId, pQuestGiver)
if (questId == 6470) then
if q == 0 then
q = 1
Jones:SendChatMessage(12, 0, "Listen, kid. This is no place for you to be playin' around, stick with me and we might make it out alive.")
Jones:SetNPCFlags(8)
Jones:RegisterEvent("Jones_MoveTozz",500,1) 
end
end
end

function Jones_MoveToz(pUnit,event,pPlayer)
Jones:MoveTo(-6554.45,-3467.91,299.07, 6.20)
Jones:RegisterEvent("Jones_MoveTozz",12000,1) 
end

function Jones_MoveTozz(pUnit,event,pPlayer)
Jones:MoveTo(-6554.48,-3487.94,292.67, 4.7)
Jones:RegisterEvent("Jones_EventStart",21000,1) 
end

function Jones_EventStart(pUnit,event,pPlayer)
Jones:SendChatMessage(12, 0, "We've found it! Now..to open it.")
Jones:Emote(69,5000)
Jones:RegisterEvent("Jones_EventStartz",5100,1) 
end


function Jones_EventStartz(pUnit,event,pPlayer)
Jones:SendChatMessage(12, 0, "We've done it kid, I have the lost treasure. Now lets get of he-")
Jones:GetGameObjectNearestCoords(-6554.50,-3489.03, 294.20, 3261387):SetByte(GAMEOBJECT_BYTES_1,0,0)
Jones:Emote(4,1200)
Jones:SetFacing(1.5)
Jones:RegisterEvent("Jones_EventStartzz",1500,1) 
end

function Jones_EventStartzz(pUnit,event,pPlayer)
Jones:GetGameObjectNearestCoords(-6554.50,-3489.03, 294.20, 3261387):SetByte(GAMEOBJECT_BYTES_1,0,1)
VoiceD = Jones:GetCreatureNearestCoords(Jones:GetX(),Jones:GetY(), Jones:GetZ(), 29881)
if VoiceD ~= nil then
VoiceD:PlaySoundToSet(5844)
VoiceD:SendChatMessage(14, 0, "We hunger for vengeance.")
Jones:RegisterEvent("Jones_EventStartzzz",2000,1) 
end
end

function Jones_EventStartzzz(pUnit,event,pPlayer)
Jones:SendChatMessage(12, 0, "Did you hear that? Looks like we got trouble!")
Jones:Emote(433,6000)
Jones:PlaySoundToSet(8887)
Jones:Root()
Jones:RegisterEvent("Jones_EventCombat",3000,1) 
Jones:RegisterEvent("CollapsedArea",1000,1) 
local PlayersAllAround = Jones:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if Jones:GetDistanceYards(players) < 14 then
players:CastSpell(69235)
	end
Jones:SpawnGameObject(3262230, -6554.43,-3478.87, 293.688, 1.63231, 0, 70)
end
end

function CollapsedArea(pUnit,Event)
RockCollapser = Jones:GetCreatureNearestCoords(Jones:GetX(),Jones:GetY(), Jones:GetZ(), 72191)
local PlayersAllAround = RockCollapser:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if RockCollapser:GetDistanceYards(players) < 3 then
	RockCollapser:Kill(players)
end
end
end

function DespawnEventz_NPCS(pUnit,Event)
if Jones:IsDead() == true then
pUnit:Despawn(1,0)
elseif Jones == nil then
pUnit:Despawn(1,0)
end
end


function Jones_EventCombat(pUnit,event,pPlayer)
Jones:SendChatMessage(12, 0, "I can't move! Looks like you are on your own kid.")
Jones:CastSpell(58042)
Jones:Emote(431,43000)
if math.random(1,2) <= 1 then
Jones:SpawnCreature(36789 ,-6565.92, -3484.89, 292.86, .6, 14, 0)
Jones:SpawnCreature(36789 ,-6542.56, -3493.12, 292.86, 2.50, 14, 0)
elseif math.random(1,2) <= 2 then
Jones:SpawnCreature(36789 ,-6566.39, -3493.27, 292.86, 0.45, 14, 0)
Jones:SpawnCreature(36789 ,-6542.85, -3484.70, 292.86, 3.15, 14, 0)
end
Jones:RegisterEvent("Jones_EventCombatz",21000,1) 
end


function Jones_EventCombatz(pUnit,event,pPlayer)
if Jones:IsDead() == false then
if math.random(1,2) <= 1 then
Jones:SpawnCreature(36789 ,-6565.92, -3484.89, 292.86, .6, 14, 0)
Jones:SpawnCreature(36789 ,-6542.56, -3493.12, 292.86, 2.50, 14, 0)
elseif math.random(1,2) <= 2 then
Jones:SpawnCreature(36789 ,-6566.39, -3493.27, 292.86, 0.45, 14, 0)
Jones:SpawnCreature(36789 ,-6542.85, -3484.70, 292.86, 3.15, 14, 0)
end
Jones:RegisterEvent("Jones_EventCombatzz",21000,1) 
end
end

function Jones_EventCombatzz(pUnit,event,pPlayer)
if Jones:IsDead() == false then
if VoiceD ~= nil then
VoiceD:PlaySoundToSet(5846)
VoiceD:SendChatMessage(14, 0, "No rest, for the angry dead.")
Jones:RegisterEvent("Jones_EventCombatzzz",21000,1) 
if math.random(1,2) <= 1 then
Jones:SpawnCreature(36789 ,-6565.92, -3484.89, 292.86, .6, 14, 0)
Jones:SpawnCreature(36789 ,-6542.56, -3493.12, 292.86, 2.50, 14, 0)
elseif math.random(1,2) <= 2 then
Jones:SpawnCreature(36789 ,-6566.39, -3493.27, 292.86, 0.45, 14, 0)
Jones:SpawnCreature(36789 ,-6542.85, -3484.70, 292.86, 3.15, 14, 0)
end
local PlayersAllAround = Jones:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if Jones:GetDistanceYards(players) < 14 then
players:CastSpell(69235)
end
end
end
end
end

function Jones_EventCombatzzz(pUnit,event,pPlayer)
if Jones:IsDead() == false then
Jones:PlaySoundToSet(8887)
Jones:RegisterEvent("Jones_EventCombatzzzz",21000,1) 
if math.random(1,2) <= 1 then
Jones:SpawnCreature(36789 ,-6565.92, -3484.89, 292.86, .6, 14, 0)
Jones:SpawnCreature(36789 ,-6542.56, -3493.12, 292.86, 2.50, 14, 0)
elseif math.random(1,2) <= 2 then
Jones:SpawnCreature(36789 ,-6566.39, -3493.27, 292.86, 0.45, 14, 0)
Jones:SpawnCreature(36789 ,-6542.85, -3484.70, 292.86, 3.15, 14, 0)
end
end
end


function Jones_EventCombatzzzz(pUnit,event,pPlayer)
if Jones:IsDead() == false then
if VoiceD ~= nil then
VoiceD:PlaySoundToSet(5845)
Jones:SpawnCreature(52772 ,-6554.73, -3500.76, 293.81, 1.46, 16, 0)
VoiceD:SendChatMessage(14, 0, "More... More souls.")
local PlayersAllAround = Jones:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if Jones:GetDistanceYards(players) < 14 then
players:CastSpell(69235)
end
end
end
end
end




function AwakenedHorror_OnSpawn(pUnit, Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
		pUnit:EquipWeapons(41187,0,0)
			--	pUnit:RegisterEvent("DespawnEventz_NPCS", 2000, 0)
		pUnit:RegisterEvent("AwakenedHorror_Emote_Raise", 200, 1)
end

function AwakenedHorror_Emote_Raise(pUnit,Event)
pUnit:Emote(449, 4000)
pUnit:RegisterEvent("AwakenedHorror_SetFactionAfterEmote",4200,1)
end

function AwakenedHorror_SetFactionAfterEmote(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:RegisterEvent("AwakenedHorror_MoveTo", 1000, 1)
end

function AwakenedHorror_MoveTo(pUnit,Event)
local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 70 then
if player:IsDead() == false then
pUnit:MoveTo(player:GetX(), player:GetY(),player:GetZ(),0)
end
end
end
end

function BarbarianKing_OnSpawn(pUnit, Event)
		pUnit:EquipWeapons(9511,36579,0)
end
 
 

function AwakenedHorror_OnDead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:CastSpell(32966)
VoiceD:ChannelSpell(60309,pUnit)
Jones:RegisterEvent("StopChannelplz", 1000, 1)
local EnemiesAllAround = Jones:GetInRangeEnemies()
  for a, enemies in pairs(EnemiesAllAround) do
    if Jones:GetDistanceYards(enemies) < 14 then
	if enemies:IsDead() == true then
	enemies:Despawn(1,0)
end
end
end
end

function StopChannelplz(pUnit,Event)
VoiceD:StopChannel()
end

function Jones_OnDead(pUnit,Event)
Jones:GetGameObjectNearestCoords(-6554.50,-3489.03, 294.20, 3262230):Despawn(1000,0)
Jones:Despawn(3000,5000)
q = 0 
VoiceD = nil
end


function BarbarianKing_OnDead(pUnit,Event)
Jones:GetGameObjectNearestCoords(-6554.50,-3489.03, 294.20, 3262230):Despawn(1000,0)
Jones:SendChatMessage(12, 0, "You did it kid! The collapse vanished...")
Jones:Unroot()
Jones:MoveTo(-6554.45,-3467.91,299.07, 6.20)
Jones:RegisterEvent("Jones_GiveCreditz",3000,1) 
for place,creatures in pairs(Jones:GetInRangeUnits()) do 
	if creatures:GetEntry() == 36789 then 
	Jones:Kill(creatures)
		end
	end
end

function Jones_GiveCreditz(pUnit,Event)
Jones:SendChatMessage(12, 0, "Tell Dwarfowitz to give you your share of the cut, tell him I sent you.")
Jones:Despawn(3000,5000)
Jones:SetNPCFlags(2)
q = 0 
VoiceD = nil
local PlayersAllAround = Jones:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if Jones:GetDistanceYards(players) < 22 then
	if players:HasQuest(6470) == true then
		players:MarkQuestObjectiveAsComplete(6470,0)
end
end
end
end


function SKELETONKING_DUMMYSPAWN(pUnit,Event)
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end


 RegisterUnitEvent(36789, 18, "AwakenedHorror_OnSpawn")
RegisterUnitEvent(52772, 18, "BarbarianKing_OnSpawn")
RegisterUnitEvent(72190, 18, "SKELETONKING_DUMMYSPAWN")

RegisterUnitEvent(52772, 4, "BarbarianKing_OnDead")
RegisterUnitEvent(36789, 4, "AwakenedHorror_OnDead")
RegisterUnitEvent(26814, 4, "Jones_OnDead")
 

RegisterServerHook(14, "BadlandsEvent_OnQuestAccept")]]