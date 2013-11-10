local Crystal
local Marshal
local Dreadlord
local Portal
local BeamDummy
local BeamDirector

local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 


--Fixed bug where players were not getting their objective marked as complete after killing boss
--Fixed phasing bug
--Fixed Nether beam damage
--Added range checkers
--Fixed Crashing On Teleport due to RegisterTimedEvents.


function BeamDummySpawn(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
 BeamDummy = pUnit
 BeamDummy:SetScale(.1)
 BeamDummy:SetFaction(35)
 BeamDummy:Unroot()
 local plr = BeamDummy:GetRandomPlayer(0)
if plr ~= nil then
if plr:IsDead() == false then
if BeamDummy:GetDistanceYards(plr) < 40 then
local name = plr:GetName()
BeamDummy:SendChatMessage(42,0,"Nether Beam is following "..name.."")
BeamDummy:SetUnitToFollow(plr, 1, 2) 
BeamDummy:SetUnitToFollow(plr, 1, 1) 
end
end
end
end

RegisterUnitEvent(77167,18, "BeamDummySpawn")

function Dummyvoice(pUnit,Event)
 Dreadlord = pUnit
end

RegisterUnitEvent(77169,18, "Dummyvoice")


function Beam_DirectorSpawn(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
 BeamDirector = pUnit
 BeamDirector:StopChannel()
end

RegisterUnitEvent(77174,18, "Beam_DirectorSpawn")

function PORTALDUMMY(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
 Portal = pUnit
Portal:StopChannel()
end

RegisterUnitEvent(77166,18, "PORTALDUMMY")


function LordJ_Spawn(pUnit,Event)
 pUnit:EquipWeapons(48023,0,0)
pUnit:ModifyWalkSpeed(7)
pUnit:SetMovementFlags(0)
pUnit:RegisterEvent("StopChannelingPortal", 1000, 1)
end

RegisterUnitEvent(77073,18, "LordJ_Spawn")


function RisenGhoul_Spawn(pUnit,Event)
pUnit:ChannelSpell(60857,Portal)
pUnit:ModifyWalkSpeed(7)
pUnit:SetMovementFlags(0)
pUnit:RegisterEvent("StopChannelingPortal", 1000, 1)
end


RegisterUnitEvent(77070 ,18, "RisenGhoul_Spawn")

function RisenAbom_Spawn(pUnit,Event)
pUnit:ChannelSpell(60857,Portal)
pUnit:ModifyWalkSpeed(7)
pUnit:SetMovementFlags(0)
pUnit:RegisterEvent("StopChannelingPortal", 1000, 1)
end


RegisterUnitEvent(77071 ,18, "RisenAbom_Spawn")

function RisenFootman_Spawn(pUnit,Event)
pUnit:ChannelSpell(60857,Portal)
pUnit:ModifyWalkSpeed(7)
pUnit:SetScale(1.2)
pUnit:EquipWeapons(15212,6320,0)
pUnit:SetMovementFlags(0)
pUnit:RegisterEvent("StopChannelingPortal", 1000, 1)
end


RegisterUnitEvent(77072 ,18, "RisenFootman_Spawn")

function StopChannelingPortal(pUnit,Event)
pUnit:StopChannel()
pUnit:MoveTo(1569.38,-5606.13,114.18, 1.09)
end

function TeleportDebug(pUnit,Event)
pUnit:RegisterEvent("Channel_P", 2000, 1)
end

RegisterUnitEvent(77189,18, "TeleportDebug")

--sindra music 17288
function MysteriousCrystalx_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(65423, player,0)
		if player:HasQuest(3012) or player:HasQuest(3013) == true then
pUnit:GossipMenuAddItem(4, "Touch the crystal.", 246, 0)
end
   pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
   pUnit:GossipSendMenu(player)
end

function MysteriousCrystalx_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
pUnit:SetNPCFlags(2)
Crystal = pUnit
local x = Crystal:GetX()
 local y = Crystal:GetY()
  local z = Crystal:GetZ()
   local o = Crystal:GetO()
		Crystal:SpawnCreature(77189 ,x , y, z, o, 35, 10000)
player:GossipComplete()
end
if(intid == 250) then
	player:GossipComplete()
end
end


function Channel_P(pUnit,Event)
if Crystal ~= nil then
SetDBCSpellVar(57400, "c_is_flags", 0x01000)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if players:IsInPhase(8) == true then
  if players:HasQuest(3012) or players:HasQuest(3013) == true then
  if pUnit:GetDistanceYards(players) < 10 then
  players:ChannelSpell(60857, Crystal)
  players:Dismount()
  pUnit:SendChatMessageToPlayer(42, 0, "You begin to fade from existence!", players)
  players:CastSpell(57400)
  players:CastSpell(61029)
  players:Emote(473,7100)
  players:SetPlayerLock(true)
  end
pUnit:RegisterEvent("ChannelPlayersz", 6000, 1)
  end
  end
  end
  end
  end
  
  
function ChannelPlayersz(pUnit,Event)
if Crystal ~= nil then
local PlayersAllAround = Crystal:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if players:IsInPhase(8) == true then
  if players:HasQuest(3012) or players:HasQuest(3013) == true then
  if pUnit:GetDistanceYards(players) < 10 then
  players:StopChannel()
  players:SetPlayerLock(false)
  players:RemoveAura(57400)
  players:CastSpell(52096)
  players:CastSpell(68085)
  end
  pUnit:RegisterEvent("ChannelPlayerszz", 1000, 1)
  end
  end
  end
  end
  end
  
function ChannelPlayerszz(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if players:IsInPhase(8) == true then
  if players:HasQuest(3012) or players:HasQuest(3013) == true then
  if pUnit:GetDistanceYards(players) < 10 then
  players:Teleport(0, 1569.38,-5606.13,114.18)
  end
  if Crystal ~= nil then
  Crystal:SetNPCFlags(1)
  Crystal = nil
 end
 end
 end
 end
 end
 
 
 
 function StartVisionEvent_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(487321, player,0)
pUnit:GossipMenuAddItem(9, "I'm Ready", 246, 0)
   pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
   pUnit:GossipSendMenu(player)
end

function StartVisionEvent_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
pUnit:SetNPCFlags(2)
Marshal = pUnit
Marshal:RegisterEvent("WaveOneinafew", 1000, 1)
player:GossipComplete()
end
if(intid == 250) then
	player:GossipComplete()
end
end

function WaveOneinafew(pUnit,Event)
Marshal:SendChatMessage(42,0,"You must protect Marshal Keller for 8 waves.")
Marshal:SendChatMessage(12,0,"Look alive comrades, we must protect the civillians!")
Marshal:RegisterEvent("WaveOne", 6000, 1)
end


function WaveOne(pUnit,Event)
Marshal:SendChatMessage(12,0,"For Lordaeron!")
Dreadlord:PlaySoundToSet(17283)
  Dreadlord:PlaySoundToSet(14417)
  Marshal:RegisterEvent("WaveTwo", 30000, 1)
if math.random(1,3) <= 1 then
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
elseif math.random(1,3) <= 2 then
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
elseif math.random(1,3) <= 3 then
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
end
local PlayersAllAround = Marshal:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
			Marshal:SendChatMessageToPlayer(42, 0, "Wave 1", players)
  Dreadlord:SendChatMessageToPlayer(15, 0, "The dark lord is displeased with your interference.", players)
 end
end

function WaveTwo(pUnit,Event)
if Marshal ~= nil then
if Marshal:IsDead() == true then
else
local enemy = Marshal:GetClosestEnemy()
if enemy ~= nil then
if Marshal:GetDistanceYards(enemy) < 30 then
if enemy:IsDead() == false then
Marshal:RegisterEvent("WaveTwo", 10000, 1)
else
Marshal:SendChatMessage(12,0,"Here come more of them!")
Marshal:SendChatMessage(42,0,"Wave 2")
if math.random(1,3) <= 1 then
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
elseif math.random(1,3) <= 2 then
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
elseif math.random(1,3) <= 3 then
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
end
Marshal:RegisterEvent("WaveThree", 30000, 1)
end
end
end
end
end
end


function WaveThree(pUnit,Event)
if Marshal ~= nil then
if Marshal:IsDead() == true then
else
local enemy = Marshal:GetClosestEnemy()
if enemy ~= nil then
if Marshal:GetDistanceYards(enemy) < 30 then
if enemy:IsDead() == false then
Marshal:RegisterEvent("WaveThree", 10000, 1)
else
Marshal:SendChatMessage(42,0,"Wave 3")
if math.random(1,3) <= 1 then
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
elseif math.random(1,3) <= 2 then
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
elseif math.random(1,3) <= 3 then
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
end
Marshal:RegisterEvent("WaveFour", 30000, 1)
end
end
end
end
end
end


function WaveFour(pUnit,Event)
if Marshal ~= nil then
if Marshal:IsDead() == true then
else
local enemy = Marshal:GetClosestEnemy()
if enemy ~= nil then
if Marshal:GetDistanceYards(enemy) < 30 then
if enemy:IsDead() == false then
Marshal:RegisterEvent("WaveFour", 10000, 1)
else
Marshal:SendChatMessage(42,0,"Wave 4")
if math.random(1,3) <= 1 then
Marshal:SpawnCreature(77071 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
elseif math.random(1,3) <= 2 then
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
elseif math.random(1,3) <= 3 then
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
end
Marshal:RegisterEvent("WaveFive", 30000, 1)
end
end
end
end
end
end


function WaveFive(pUnit,Event)
if Marshal ~= nil then
if Marshal:IsDead() == true then
else
local enemy = Marshal:GetClosestEnemy()
if enemy ~= nil then
if Marshal:GetDistanceYards(enemy) < 30 then
if enemy:IsDead() == false then
Marshal:RegisterEvent("WaveFive", 10000, 1)
else
Marshal:SendChatMessage(42,0,"Wave 5")
if math.random(1,5) <= 1 then
Marshal:SpawnCreature(77071 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
elseif math.random(1,5) <= 2 then
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
elseif math.random(1,5) <= 3 then
Marshal:SpawnCreature(77072 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
elseif math.random(1,5) <= 4 then
Marshal:SpawnCreature(77072 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
elseif math.random(1,5) <= 5 then
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
end
Marshal:RegisterEvent("WaveSix", 35000, 1)
end
end
end
end
end
end

function WaveSix(pUnit,Event)
if Marshal ~= nil then
if Marshal:IsDead() == true then
else
local enemy = Marshal:GetClosestEnemy()
if enemy ~= nil then
if Marshal:GetDistanceYards(enemy) < 30 then
if enemy:IsDead() == false then
Marshal:RegisterEvent("WaveSix", 10000, 1)
else
Dreadlord:PlaySoundToSet(17283)
Marshal:SendChatMessage(42,0,"Wave 6")
if math.random(1,5) <= 1 then
Marshal:SpawnCreature(77071 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
elseif math.random(1,5) <= 2 then
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
elseif math.random(1,5) <= 3 then
Marshal:SpawnCreature(77072 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
elseif math.random(1,5) <= 4 then
Marshal:SpawnCreature(77072 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
elseif math.random(1,5) <= 5 then
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
end
Marshal:RegisterEvent("WaveSeven", 35000, 1)
end
end
end
end
end
end

function WaveSeven(pUnit,Event)
if Marshal ~= nil then
if Marshal:IsDead() == true then
else
local enemy = Marshal:GetClosestEnemy()
if enemy ~= nil then
if Marshal:GetDistanceYards(enemy) < 30 then
if enemy:IsDead() == false then
Marshal:RegisterEvent("WaveSeven", 10000, 1)
else
Marshal:SendChatMessage(42,0,"Wave 7")
if math.random(1,5) <= 1 then
Marshal:SpawnCreature(77071 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
elseif math.random(1,5) <= 2 then
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
elseif math.random(1,5) <= 3 then
Marshal:SpawnCreature(77072 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
elseif math.random(1,5) <= 4 then
Marshal:SpawnCreature(77072 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
elseif math.random(1,5) <= 5 then
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
end
Marshal:RegisterEvent("WaveEight", 40000, 1)
end
end
end
end
end
end

function WaveEight(pUnit,Event)
if Marshal ~= nil then
if Marshal:IsDead() == true then
else
local enemy = Marshal:GetClosestEnemy()
if enemy ~= nil then
if Marshal:GetDistanceYards(enemy) < 30 then
if enemy:IsDead() == false then
Marshal:RegisterEvent("WaveEight", 10000, 1)
else
Marshal:SendChatMessage(42,0,"Wave 8")
if math.random(1,5) <= 1 then
Marshal:SpawnCreature(77071 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
elseif math.random(1,5) <= 2 then
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
elseif math.random(1,5) <= 3 then
Marshal:SpawnCreature(77072 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
elseif math.random(1,5) <= 4 then
Marshal:SpawnCreature(77072 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77071 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
elseif math.random(1,5) <= 5 then
Marshal:SpawnCreature(77070 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1594.80, -5562.05, 111.171, 4.24, 14, 0)
Marshal:SpawnCreature(77070 ,1593.17, -5561.22, 111.17, 4.24, 14, 0)
Marshal:SpawnCreature(77072 ,1589.73, -5567.77, 111.17, 4.21, 14, 0)
end
Marshal:RegisterEvent("BossSpawn", 40000, 1)
end
end
end
end
end
end

function BossSpawn(pUnit,Event)
if Marshal ~= nil then
if Marshal:IsDead() == true then
else
end
Dreadlord:PlaySoundToSet(17288)
Marshal:SpawnCreature(77073 ,1590.95, -5560.08, 111.17, 4.24, 14, 0)
Marshal:SendChatMessage(12,0,"What in blight's name is that!")
end
local PlayersAllAround = Marshal:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if Marshal:GetDistanceYards(players) < 40 then
Marshal:SendChatMessageToPlayer(42, 0, "You feel a cold demonic presence nearby.", players)
end
end
end





--Combat Scripts--

function Abom_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
end

function Abom_OnDead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

function Abom_OnCombat(pUnit,Event)
pUnit:RegisterEvent("Abom_Cleave", 7000, 0)
pUnit:RegisterEvent("Poisonbolt", 9000, 0)
pUnit:RegisterEvent("Despawn_Timer", 2000, 0)
end

function Abom_Cleave(pUnit,Event)
pUnit:CastSpellOnTarget(40505, pUnit:GetMainTank())
end

function Poisonbolt(pUnit,Event)
local enemy = pUnit:GetClosestEnemy()
if enemy ~= nil then
if pUnit:GetDistanceYards(enemy) < 15 then
local EnemiesAllAround = pUnit:GetInRangeEnemies()
  for a, enemies in pairs(EnemiesAllAround) do
  enemies:RemoveAura(21067)
pUnit:CastSpellOnTarget(21067, enemies)
end
end
end
end


RegisterUnitEvent(77071, 1, "Abom_OnCombat")
RegisterUnitEvent(77071, 2, "Abom_OnLeave")
RegisterUnitEvent(77071, 4, "Abom_OnDead")


function Ghoul_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
end

function Ghoul_OnDead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end


function Ghoul_OnCombat(pUnit,Event)
pUnit:CastSpellOnTarget(70150, pUnit:GetMainTank())
pUnit:RegisterEvent("Ghoul_Rend", 2000, 0)
pUnit:RegisterEvent("Despawn_Timer", 2000, 0)
end


function Ghoul_Rend(pUnit, Event)
 pUnit:CastSpellOnTarget(772, pUnit:GetMainTank())
end

function Despawn_Timer(pUnit, Event)
if Marshal ~= nil then
if Marshal:IsDead() == false then
else
 pUnit:Despawn(1000,0)
end
end
end






RegisterUnitEvent(77070, 1, "Ghoul_OnCombat")
RegisterUnitEvent(77070, 2, "Ghoul_OnLeave")
RegisterUnitEvent(77070, 4, "Ghoul_OnDead")

function RisenFootman_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
end

function RisenFootman_OnDead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

function RisenFootman_OnCombat(pUnit,Event)
pUnit:RegisterEvent("Despawn_Timer", 2000, 0)
end




RegisterUnitEvent(77072, 1, "RisenFootman_OnCombat")
RegisterUnitEvent(77072, 2, "RisenFootman_OnLeave")
RegisterUnitEvent(77072, 4, "RisenFootman_OnDead")



RegisterUnitGossipEvent(77064, 1, "StartVisionEvent_On_Gossip")
RegisterUnitGossipEvent(77064, 2, "StartVisionEvent_Gossip_Submenus")



RegisterUnitGossipEvent(77060, 1, "MysteriousCrystalx_On_Gossip")
RegisterUnitGossipEvent(77060, 2, "MysteriousCrystalx_Gossip_Submenus")


--Boss AI--

function LordJ_OnCombat(pUnit,Event)
pUnit:SendChatMessage(12,0,"You face Jaraxxus, eredar lord of the Burning Legion!")
pUnit:PlaySoundToSet(16144)
pUnit:RegisterEvent("Lazerz", 21000, 0)
pUnit:RegisterEvent("CorruptionAE", 12000, 0)
pUnit:RegisterEvent("FearAE", 30000, 0)
pUnit:RegisterEvent("LordJDespawn_Timer", 2000, 0) 
end


function Lazerz(pUnit,Event)
BeamDirector:StopChannel()
Portal:StopChannel()
pUnit:SpawnCreature(77167 ,1589.73, -5567.77, 111.17, 4.21, 14, 18000)
if math.random(1,2) <= 1 then
pUnit:SendChatMessage(16,0,"Lord Jaraxxus Laughs Maniacally")
pUnit:PlaySoundToSet(16148)
elseif math.random(1,2) <= 2 then
pUnit:SendChatMessage(12,0,"INFERNO!")
pUnit:PlaySoundToSet(16151)
end
if BeamDummy then
Portal:ChannelSpell(60857,BeamDirector)
BeamDirector:ChannelSpell(60857,BeamDummy)
BeamDummy:RegisterEvent("Lazerztoggle", 1000, 0)
end
end

function CorruptionAE(pUnit,Event)
local enemy = pUnit:GetClosestEnemy()
if enemy ~= nil then
if pUnit:GetDistanceYards(enemy) < 35 then
local EnemiesAllAround = pUnit:GetInRangeEnemies()
  for a, enemies in pairs(EnemiesAllAround) do
  enemies:RemoveAura(21067)
  pUnit:CastSpellOnTarget(6222, enemies)
  end
  end
  end
  end
  
 function FearAE(pUnit,Event)
local enemy = pUnit:GetClosestEnemy()
if enemy ~= nil then
if pUnit:GetDistanceYards(enemy) < 35 then
local EnemiesAllAround = pUnit:GetInRangeEnemies()
  for a, enemies in pairs(EnemiesAllAround) do
  enemies:RemoveAura(21067)
  pUnit:CastSpellOnTarget(1106, enemies)
  end
  end
  end
  end

function Lazerztoggle(pUnit,Event)
pUnit:CastSpell(39180)
local PlayersAllAround = BeamDummy:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if BeamDummy:GetDistanceYards(players) < 3.2 then
BeamDummy:Strike(players,1,37826,130,200,2)
end
end
end
  
 function LordJDespawn_Timer(pUnit, Event)
if Marshal ~= nil then
if Marshal:IsDead() == false then
else
BeamDummy:StopChannel()
BeamDummy:Despawn(1000,1000)
BeamDirector:StopChannel()
Portal:Despawn(1000,1000)
pUnit:Despawn(1000,0)
end
end
end

 function LordJ_OnLeave(pUnit, Event)
pUnit:RemoveEvents()
BeamDummy:StopChannel()
BeamDirector:StopChannel()
Portal:StopChannel()
end


function LordJ_OnDead(pUnit, Event)
pUnit:RemoveEvents()
if BeamDummy ~= nil then
BeamDummy:RemoveEvents()
BeamDummy:StopChannel()
end
if BeamDirector ~= nil then
BeamDirector:StopChannel()
end
if Portal ~= nil then
Portal:StopChannel()
end
pUnit:Despawn(8000,0)
pUnit:SendChatMessage(12,0,"Another will take my place. Your world is doomed.")
pUnit:PlaySoundToSet(16147)
if Marshal ~= nil then
Marshal:RegisterEvent("Teleportplayers", 12000, 1)
end
end

function Teleportplayers(pUnit,Event)
Marshal:Despawn(3000,4000)
Marshal:SetNPCFlags(1)
local PlayersAllAround = Marshal:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if Marshal:GetDistanceYards(players) < 40 then
  if players:HasQuest(3012) == true then
 players:MarkQuestObjectiveAsComplete(3012, 0)
 elseif players:HasQuest(3013) == true then
  players:MarkQuestObjectiveAsComplete(3013, 0)
  end
  players:RemoveAura(68085)
  players:Teleport(0,-9787.92, -3232.56, 58.80)
  end
  end
  end



function LordJ_OnKill(pUnit, Event)
if math.random(1,2) <= 1 then
pUnit:PlaySoundToSet(16145)
pUnit:SendChatMessage(12,0,"Insignificant gnat!")
elseif math.random(1,2) <= 2 then
pUnit:PlaySoundToSet(16146)
pUnit:SendChatMessage(12,0,"Banished to the Nether!")
end
end

  
 RegisterUnitEvent(77073, 1, "LordJ_OnCombat")
RegisterUnitEvent(77073, 2, "LordJ_OnLeave")
RegisterUnitEvent(77073, 3, "LordJ_OnKill")
RegisterUnitEvent(77073, 4, "LordJ_OnDead")

function EventStarterMarshal_OnDead(pUnit, Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(51,0,"You have failed the event.")
pUnit:Despawn(1000,4000)
end


RegisterUnitEvent(77064, 4, "EventStarterMarshal_OnDead")



function CathTeleport_On_Gossip(pUnit, event, player)
		pUnit:GossipCreateMenu(46669, player, 0)
		pUnit:GossipMenuAddItem(0, "Take me back.", 246, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end

function CathTeleport_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
if player:IsInCombat() == false then
 player:RemoveAura(68085)
 player:CastSpell(70860)
 player:Teleport(0,-9787.92, -3232.56, 58.80)
player:GossipComplete()
else
player:SendAreaTriggerMessage("|cFFFF0000You are in combat.|r")
player:GossipComplete()
end


if(intid == 250) then
player:GossipComplete()
end
end
end






RegisterUnitGossipEvent(98732, 1, "CathTeleport_On_Gossip")
RegisterUnitGossipEvent(98732, 2, "CathTeleport_Gossip_Submenus")
  