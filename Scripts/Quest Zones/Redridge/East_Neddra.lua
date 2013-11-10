

local P_Player
local Com


function Needy(pUnit,Event)
pUnit:DeMorph()
end

RegisterUnitEvent(77024, 18, "Needy")


function NetherSpawns(pUnit,Event)
pUnit:CastSpell(52096)
pUnit:SetMaxHealth(120)
pUnit:SetHealth(120)
end

RegisterUnitEvent(77045, 18, "NetherSpawns")

function Verius_Spawn(pUnit,Event)
pUnit:RegisterEvent("Disguised_Convo", 1000, 1)
end

RegisterUnitEvent(77042, 18, "Verius_Spawn")


function DG_Spawn(pUnit,Event)
pUnit:SetPhase(4)
end

RegisterUnitEvent(11859, 18, "DG_Spawn")


function Disguised_Convo(pUnit, event, player)
pUnit:SendChatMessage(12,0,"What is the meaning of this disruption, Neddra!")
pUnit:Emote(1,4000)
pUnit:RegisterEvent("Disguised_Convoz", 4000, 1)
end

function Disguised_Convoz(pUnit, event, player)
P_Player:PlayerSendChatMessage(1,0,"My Lord, when is the time of the legion's arrival? The enemy is at our doorstep.")
pUnit:RegisterEvent("Disguised_Convozz", 4000, 1) 
end

function Disguised_Convozz(pUnit, event, player)
pUnit:SendChatMessage(12,0,"The time of arrival is soon enough. You are only tools... tools of the legion. I have succeeded where Mannoroth failed!")
pUnit:Emote(1,3000)
pUnit:RegisterEvent("Disguised_Convozx", 4000, 1) 
end

function Disguised_Convozx(pUnit, event, player)
pUnit:SendChatMessageToPlayer(42, 0, "Your disguise is failing!", P_Player)
pUnit:RegisterEvent("Disguised_Convozy", 3000, 1) 
end


function Disguised_Convozy(pUnit, event, player)
local race = P_Player:GetPlayerRace() 
    if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then 
	P_Player:SetFaction(1)
	else
	P_Player:SetFaction(2)
	end
P_Player:DeMorph()
P_Player:RemoveAura(68442)
P_Player:SetPlayerLock(false)
P_Player:AdvanceQuestObjective(3006, 1)
pUnit:SendChatMessage(12,0,"Insolent Whelp! You shall pay for your insolence!")
pUnit:Emote(1,2000)
pUnit:SpawnCreature(77045,-9717.18 , -3105.62, 58.67, 4.64, 14, 45000)
pUnit:SpawnCreature(77045,-9723.90 , -3105.78, 58.67, 4.64, 14, 45000)
pUnit:Despawn(3000,0)
Com:SetNPCFlags(1)
P_Player = nil
end











function CommyDevice_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(43234, player,0)
		if player:HasQuest(3006) == true then
pUnit:GossipMenuAddItem(0, "Attempt to turn on the device.", 246, 0)
end
   pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
   pUnit:GossipSendMenu(player)
end

function CommyDevice_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
if player:IsMounted() == true then
player:Dismount()
end
if player:HasItem(2636) then
pUnit:SetNPCFlags(2)
Com = pUnit
player:Teleport(0,-9720.32,-3107.76,58.67)
player:CastSpell(68442)
player:SetModel(17153)
player:SetFaction(35)
player:SetPlayerLock(true)
player:SetFacing(1.64)
player:RemoveItem(2636,1)
player:SpawnCreature(77042,-9720.81, -3101.71, 60.89, 4.71, 35, 0)
P_Player = player
P_Player:GossipComplete()
 else
player:SendAreaTriggerMessage("|cffffff00Demonic Communication Idol Required!|r")
end
if(intid == 250) then
	player:GossipComplete()
end
end
end

RegisterUnitGossipEvent(77043, 1, "CommyDevice_On_Gossip")
RegisterUnitGossipEvent(77043, 2, "CommyDevice_Gossip_Submenus")


----Nedra AI--


function Neddra_OnCombat(pUnit, Event)
pUnit:SendChatMessage(12,0,"There is only The Legion!")
 pUnit:RegisterEvent("Stun_Target", 10000, 0)
  pUnit:RegisterEvent("Shadow_Bolt", 4000, 0)
 pUnit:RegisterEvent("Health_CheckingNed", 2000, 0)
end

function Stun_Target(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if pUnit:GetDistanceYards(plr) < 20 then
pUnit:CastSpellOnTarget(1714, plr)
end
end

function Shadow_Bolt(pUnit,Event)
pUnit:CancelSpell()
pUnit:FullCastSpellOnTarget(695, pUnit:GetMainTank())
end

function Neddra_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function Health_CheckingNed(pUnit, Event)
	if pUnit:GetHealthPct() < 50 then
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(12,0,"By Verius's Command, You. Will. Die.")
	pUnit:SetModel(25277)
	-- pUnit:RegisterEvent("Void_Bolt", 9000, 0)
	  pUnit:RegisterEvent("Stun_Target", 10000, 0)
  pUnit:RegisterEvent("Shadow_Bolt", 4000, 0)
	end
end

function Void_Bolt(pUnit,Event)
pUnit:FullCastSpellOnTarget(7588, pUnit:GetMainTank())
end


function Neddra_OnDead(pUnit, Event) --INCASE to Prevent people w/o quest to get item and reduce camping spawn. 
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 25 then
  if players:HasQuest(3006) == true then
  if players:HasItem(2636) == false then
  if (players:GetQuestObjectiveCompletion(3006, 1) == 0) then
  players:AddItem(2636,1)
  end
 pUnit:RemoveEvents()
end
end
end
end
end


RegisterUnitEvent(77024, 1, "Neddra_OnCombat")
RegisterUnitEvent(77024, 2, "Neddra_OnLeave")
RegisterUnitEvent(77024, 4, "Neddra_OnDead")