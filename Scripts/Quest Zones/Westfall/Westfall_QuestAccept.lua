
local SelectedItem = {}


local FirstMate = nil
local GeneralKvaldir = nil

local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 



function FirstMate_OnSpawn(pUnit,Event)
FirstMate = pUnit
FirstMate:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
FirstMate:SetNPCFlags(2)
FirstMate:SetFaction(1857)
FirstMate:AIDisableCombat(false)
end

RegisterUnitEvent(31789, 18, "FirstMate_OnSpawn")

function Sailor_Guardian_spawn(pUnit,Event)
 pUnit:SetPhase(3)
 pUnit:SetMaxHealth(900)
 pUnit:SetHealth(900)
 pUnit:EquipWeapons(36565,36565,0)
 pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
 pUnit:RegisterEvent("SailrGuardian_GetQuestInfo", 2000, 0)
  pUnit:RegisterEvent("SailorGuardian_OutOfPlace", 4000, 0)
   pUnit:RegisterEvent("SAILORHASSOMETHING_TOSAY", 1000, 1)
    pUnit:RegisterEvent("Sailrguardian_NoQuest", 1000, 0)
end

function SAILORHASSOMETHING_TOSAY(pUnit,Event)
local Owner = pUnit:GetPetOwner()
 if Owner ~= nil then
 if math.random(1,4) <= 1 then
pUnit:SendChatMessageToPlayer(12,0,"Time to kick ass and take names.", Owner)
elseif math.random(1,4) <= 2 then
pUnit:SendChatMessageToPlayer(12,0,"It’s time to kick ass and drink whiskey…and I’m all out of whiskey.", Owner)
elseif math.random(1,4) <= 3 then
pUnit:SendChatMessageToPlayer(12,0,"What are you waiting for? Lets go spill some guts!", Owner)
elseif math.random(1,4) <= 4 then
pUnit:SendChatMessageToPlayer(14,0,"I'm Sailor Picardo. And I'm coming to get the rest of you sea bastards!", Owner)
end
end
end

RegisterUnitEvent(41792, 18, "Sailor_Guardian_spawn")


function Sailrguardian_NoQuest(pUnit,Event)
local Owner = pUnit:GetPetOwner()
if Owner:HasQuest(8012) == false then
pUnit:Despawn(1000,0)
end
end

function SailrGuardian_GetQuestInfo(pUnit,Event)
local Owner = pUnit:GetPetOwner()
 if Owner ~= nil then
 if (Owner:GetQuestObjectiveCompletion(8012, 0) == 15) then
 pUnit:RemoveEvents()
 pUnit:SendChatMessageToPlayer(12,0,"Looks like that's enough ass-kicking for today, meet me back at the camp.", Owner)
 pUnit:Despawn(3000,0)
end
end
end

function SailorGuardian_OutOfPlace(pUnit,Event)
if pUnit:GetAreaId() == 2 or pUnit:GetAreaId() == 916 then
else
pUnit:RemoveEvents()
pUnit:Despawn(2000,0)
local Owner = pUnit:GetPetOwner()
 pUnit:SendChatMessageToPlayer(14,0,"I'm not venturing where you please, stranger.", Owner)
 end
if pUnit:IsInPhase(3) == false then
 pUnit:SetPhase(3)
end
end


function WestFallEvent_OnQuestAccept(event, pPlayer, questId, pQuestGiver)
if (questId == 8011) then -- Making Friends
FirstMate:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
FirstMate:SendChatMessage(12, 0, "Get ready, they approach!")
FirstMate:SetNPCFlags(8)
FirstMate:PlaySoundToSet(10843)
FirstMate:RegisterEvent("Kvaldir_Wave_One", 2000, 1)
elseif (questId == 8012) then -- Sweet Ol' Revenge 
local Sailor = pPlayer:CreateGuardian(41792, 0, 2, 19)
Sailor:SetPetOwner(pPlayer)
end
end



function Kvaldir_Wave_One(pUnit,Event)
if FirstMate:IsDead() == false then
FirstMate:SpawnCreature(35072,-9612.69, 1169.71, 3.01, 5.95, 14, 0)
FirstMate:SpawnCreature(35072 ,-9612.12, 1162.99,3.05, 0.17, 14, 0)
pUnit:RegisterEvent("Kvaldir_Wave_Two", 20000, 1)
end
end

function Kvaldir_Wave_Two(pUnit,Event)
if FirstMate:IsDead() == false then
FirstMate:SpawnCreature(35072 ,-9612.69, 1169.71, 3.01, 5.95, 14, 0)
FirstMate:SpawnCreature(35072 ,-9612.12, 1162.99,3.05, 0.17, 14, 0)
pUnit:RegisterEvent("Kvaldir_Wave_Three", 20000, 1)
end
end

function Kvaldir_Wave_Three(pUnit,Event)
if FirstMate:IsDead() == false then
FirstMate:SpawnCreature(35072 ,-9612.69, 1169.71, 3.01, 5.95, 14, 0)
FirstMate:SpawnCreature(35072 ,-9612.12, 1162.99,3.05, 0.17, 14, 0)
pUnit:RegisterEvent("Kvaldir_Wave_Final", 20000, 1)
end
end

function Kvaldir_Wave_Final(pUnit,Event)
if FirstMate:IsDead() == false then
FirstMate:SpawnCreature(42705 ,-9615.10, 1164.90, 3.75, 0.08, 14, 0)
end
end


function KvaldirGeneral_LastWords(pUnit,Event)
if GeneralKvaldir:GetHealthPct() < 50 then
GeneralKvaldir:RemoveEvents()
GeneralKvaldir:AIDisableCombat(true)
FirstMate:AIDisableCombat(true)
FirstMate:SetFacing(GeneralKvaldir:GetO())
GeneralKvaldir:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
GeneralKvaldir:Emote(68,11000)
	GeneralKvaldir:SetByteValue(UNIT_FIELD_BYTES_1, 0, 8)
	 --FirstMate:MoveTo(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO())
	FirstMate:SendChatMessage(12, 0, "Any last words, sea filth, before I send you to Davy Jones himself!?")
	FirstMate:RegisterEvent("KvaldirGeneral_LastWordsz", 4000, 1)
end
end


function KvaldirGeneral_LastWordsz(pUnit,Event)
GeneralKvaldir:SendChatMessage(12, 0, "This is only a small taste of what comes landwalker, Neptulon will reign the lands. WE are NOT finished. My death means very little. ")
FirstMate:RegisterEvent("KvaldirGeneral_LastWordszz", 6000, 1)
end


function KvaldirGeneral_LastWordszz(pUnit,Event)
FirstMate:Emote(36,1000)
FirstMate:SendChatMessage(16, 0, "First Mate Fitzgerald executes the Kvaldir General.")
FirstMate:Kill(GeneralKvaldir)
FirstMate:RegisterEvent("KvaldirGeneral_LastWordszzz", 3000, 1)
end

function KvaldirGeneral_LastWordszzz(pUnit,Event)
FirstMate:SendChatMessage(12, 0, "Pity, I expected more from him. Thank you for your assistance, I might not be alive if not for you. I will return to camp soon.")
FirstMate:Despawn(8000,10000)
 for place,creature in pairs(FirstMate:GetInRangeUnits()) do 
	if creature:GetEntry() == 35072 then 
	creature:Despawn(1,0)
	end
	end
	local PlayersAllAround = FirstMate:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if players ~= nil then
		if FirstMate:GetDistanceYards(players) < 15 then
			if players:HasQuest(8011) then
				if (players:GetQuestObjectiveCompletion(8011, 0) == 0) then
				players:AdvanceQuestObjective(8011, 0)
end
end
end
end
end
end


function Despawn_NPC_Events(pUnit,Event)
if FirstMate:IsDead() == true then
pUnit:Despawn(1,0)
elseif FirstMate == nil then
pUnit:Despawn(1,0)
end
end

function AngryKvaldir_Spawn(pUnit,Event)
pUnit:RegisterEvent("Despawn_NPC_Events", 2000, 0)
pUnit:MoveTo(FirstMate:GetX(),FirstMate:GetY(),FirstMate:GetZ(),FirstMate:GetO())
end

function KvaldirGeneral_Spawn(pUnit,Event)
GeneralKvaldir = pUnit
pUnit:SendChatMessage(12, 0, "You shall pay for this insult, human!")
pUnit:PlaySoundToSet(13406)
pUnit:EquipWeapons(37811,0,0)
pUnit:MoveTo(FirstMate:GetX(),FirstMate:GetY(),FirstMate:GetZ(),FirstMate:GetO())
pUnit:RegisterEvent("Despawn_NPC_Events", 2000, 0)
end


function KvaldirGeneral_Combat(pUnit,Event)
pUnit:RegisterEvent("KvaldirGeneral_LastWords", 2000, 0)
end

function KvaldirGeneral_Dead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:EquipWeapons(0,0,0)
end

function KvaldirGeneral_Leave(pUnit,Event)
pUnit:RemoveEvents()
end




RegisterUnitEvent(42705, 1, "KvaldirGeneral_Combat")
RegisterUnitEvent(42705, 3, "KvaldirGeneral_Leave")
RegisterUnitEvent(42705, 4, "KvaldirGeneral_Dead")
--RegisterUnitEvent(31789, 4, "FirstMate_Dead")

RegisterUnitEvent(35072, 18, "AngryKvaldir_Spawn")
RegisterUnitEvent(42705, 18, "KvaldirGeneral_Spawn")



RegisterServerHook(14, "WestFallEvent_OnQuestAccept")



function Wyrm_Hookshot(item, event, player)
	if player:HasQuest(8005) then
		if CooldownCheck(player, 10) then
			return
		else
			CooldownTime[player:GetName()] = os.clock()
			if player:GetSelection() ~= nil then
				local target = player:GetSelection()
				if SelectedItem[player:GetName()] ~= nil then
					if SelectedItem[player:GetName()] == target:GetGUID() then
						player:SendAreaTriggerMessage("|cFFFF0000Not ready yet!")
						return
					else
						SelectedItem[player:GetName()] = target:GetGUID()
					end
				end
				if target:GetEntry() == 23687 then
					player:CastSpellOnTarget(59395, target) -- hook visual
					target:CastSpell(43401) -- BloodVisual
      target:MoveKnockback(player:GetX(), player:GetY(), player:GetZ(), 10, 10)
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


RegisterItemGossipEvent(41361, 1, "Wyrm_Hookshot")