local i = 0


function Zorbo_OnSpawn(pUnit,Event)
i = 0
	pUnit:RegisterEvent("ZGhostEffectz",1200,1)
end

function ZGhostEffectz(pUnit,Event)
	pUnit:CastSpell(44816)
end

RegisterUnitEvent(78593, 18, "Zorbo_OnSpawn")

function Zorbosaucedgnome_On_Gossip(pUnit, event, player)
		pUnit:GossipCreateMenu(847323, player, 0)
	if player:HasQuest(3031) then
		pUnit:GossipMenuAddItem(0, "No, I've come to kill you.", 246, 0)
	end
	pUnit:GossipMenuAddItem(0, "...Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end


function Zorbosaucedgnome_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
if player ~= nil then
pUnit:GossipCreateMenu(847324, player, 0)
	if player:HasQuest(3030) then
		pUnit:GossipMenuAddItem(9, "No seriously, im going to kill you and take your head.", 248, 0)
	end
	pUnit:GossipMenuAddItem(0, "...Yep I was joking.", 250, 0)
    pUnit:GossipSendMenu(player)
end
end


if(intid == 248) then
pUnit:SendChatMessage(12,0,"HELP!")
pUnit:SetFaction(16)
pUnit:RegisterEvent("Zorboisawesomesauceclearly",3000,1)
player:GossipComplete()
end

if(intid == 250) then
player:GossipComplete()
end
end

function Zorboisawesomesauceclearly(pUnit,Event)
i = i + 1
if i == 1 then
local Guy1 = pUnit:GetCreatureNearestCoords(-9206.45,-2182.49,63.93, 77114)
Guy1:SendChatMessage(12,0,"Not a chance, I am on my smoke break.")
pUnit:RegisterEvent("Zorboisawesomesauceclearly",2000,1)
elseif i == 2 then
local Guy2 = pUnit:GetCreatureNearestCoords(-9191.89,-2171.96,63.93, 77114)
Guy2:SendChatMessage(12,0,"Screw you man, you stole my lunch the other day.")
end
end



function Zorbo_OnCombat(pUnit,Event)
pUnit:RegisterEvent("Gnomish_A",2000,1)
pUnit:RegisterEvent("Gnomish_B",4000,1)
end


function Gnomish_A(pUnit,Event)
pUnit:CastSpellOnTarget(13006,pUnit:GetMainTank())
end

function Gnomish_B(pUnit,Event)
pUnit:CastSpell(23133)
end

function Backstab_Zorbo(pUnit,Event)
pUnit:CastSpellOnTarget(53,pUnit:GetMainTank())
end

function Zorbo_OnSlay(pUnit,Event)
pUnit:SendChatMessage(12,0,"Zorbo has done it again!")
end

function Zorbo_OnDead(pUnit,Event)
pUnit:RemoveEvents()
local unit = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 8836)
if unit then
	unit:Despawn(1,0)
end
pUnit:SetFaction(35)
  for a, players in pairs(pUnit:GetInRangePlayers()) do
  if pUnit:GetDistanceYards(players) < 8 then
  if players:HasQuest(3031) then
  if not players:HasItem(12886) then
  players:AddItem(12886,1)
  end
end
end
end
end

function Zorbo_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetFaction(35)
end


RegisterUnitEvent(78593, 1, "Zorbo_OnCombat")
RegisterUnitEvent(78593, 3, "Zorbo_OnSlay")
RegisterUnitEvent(78593, 2, "Zorbo_OnLeave")
RegisterUnitEvent(78593, 4, "Zorbo_OnDead")





RegisterUnitGossipEvent(78593, 1, "Zorbosaucedgnome_On_Gossip")
RegisterUnitGossipEvent(78593, 2, "Zorbosaucedgnome_Gossip_Submenus")