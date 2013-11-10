
 
 
 
 function NetherTear_Spawn(pUnit,Event)
  pUnit:RegisterEvent("TeleportPlayer_Finale",1000,0) 
  end
  
  RegisterUnitEvent(39842, 18, "NetherTear_Spawn")
  
  
 function TeleportPlayer_Finale(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
if plr:IsInPhase(1) then
if plr:HasQuest(98932) then
plr:Teleport(544, 189.90,5.07,69.96)
end
end
end
end
end


 function KnockbackKid_Spawn(pUnit,Event)
  pUnit:RegisterEvent("KnockbackKid_Barrier",5000,0) 
  end
  
  RegisterUnitEvent(39833, 18, "KnockbackKid_Spawn")
  
  
 function KnockbackKid_Barrier(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
if players ~= nil then
if pUnit:GetDistanceYards(players) < 20 then
if players:IsInPhase(1) then
if players:IsDead() == false then
if players:HasItem(31944) == false then
players:CastSpell(39180)
pUnit:Kill(players)
end
end
end
end
end
end
end


function Husk_OnDead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:CastSpell(32343)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 10 then
if plr:HasQuest(3034) then
Spirit = pUnit:SpawnCreature(77113 ,pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(),35,4000)
Spirit:SetModel(25731)
if math.random(1,5) <= 1 then
Spirit:SendChatMessage(12,0,"Thank you for freeing me..")
elseif math.random(1,5) <= 2 then
Spirit:SendChatMessage(12,0,"I can see the light!")
elseif math.random(1,5) <= 3 then
Spirit:SendChatMessage(12,0,"They are creating something monsterous!")
end
end
end
end
end


RegisterUnitEvent(39845, 4, "Husk_OnDead")