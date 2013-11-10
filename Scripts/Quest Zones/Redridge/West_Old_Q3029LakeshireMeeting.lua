local Q3029Ready = false
local Guard_A 
local JP 
local Jane 
local Tom 
local Linda 
local Paul 
local Lisa 
local Kendal 
local player = nil
local i = 0


function Jane_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("GhostEffectz",1200,1)
end

RegisterUnitEvent(77111, 18, "Jane_OnSpawn")




function Dummyzzz_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("VariableGossipCheck", 3000, 0)
end

RegisterUnitEvent(77199, 18, "Dummyzzz_OnSpawn")

function Tom_OnSpawn(pUnit,Event)
pUnit:SetFaction(35)
pUnit:SetMovementFlags(1)
pUnit:EquipWeapons(0,0,0)
pUnit:RegisterEvent("GhostEffectz",1200,1)
end

RegisterUnitEvent(79837, 18, "Tom_OnSpawn")




function Lisa_OnSpawn(pUnit,Event)
pUnit:RegisterEvent("GhostEffectz",1200,1)
end

RegisterUnitEvent(79840, 18, "Lisa_OnSpawn")



function GhostEffectz(pUnit,Event)
	pUnit:CastSpell(44816)
end



---Guard Checking for player--



function GuardA_OnSpawn(pUnit,Event)
pUnit:RegisterEvent("CheckingForPlayer",1000,0)
end

RegisterUnitEvent(79832, 18, "GuardA_OnSpawn")


function CheckingForPlayer(pUnit,Event)
player = pUnit:GetClosestPlayer()
if player ~= nil then
if pUnit:GetDistanceYards(player) < 5 then
if player:HasQuest(3029) then
if player:IsInPhase(4) then
pUnit:RemoveEvents()
pUnit:SendChatMessage(12,0,"Halt!")
pUnit:Emote(5,1000)
player:SetPlayerLock(true)
pUnit:RegisterEvent("FoundPlayerStartingScript", 2000, 1)
end
end
end
end
end

function FoundPlayerStartingScript(pUnit,Event)
if player then
pUnit:SendChatMessage(12,0,"Nobody is allowed in or out without permission.")
pUnit:Emote(274,2000)
pUnit:RegisterEvent("PlayerScriptz", 4000, 1)
else
pUnit:RemoveEvents()
pUnit:RegisterEvent("CheckingForPlayer",1200,1)
end
end


function PlayerScriptz(pUnit,Event)
if player then
player:PlayerSendChatMessage(1,0,"I need to see Jane Perenolde, it's urgent!")
player:Emote(5,1000)
pUnit:RegisterEvent("PlayerScriptzz", 4000, 1)
else
pUnit:RemoveEvents()
pUnit:RegisterEvent("CheckingForPlayer",1200,1)
end
end


function PlayerScriptzz(pUnit,Event)
if player then
pUnit:SendChatMessage(12,0,"You're the one that saved Miss Perenolde, forgive me. You have been given access.")
pUnit:Emote(113,1000)
player:SetPlayerLock(false)
player = nil
pUnit:RegisterEvent("GuardA_OnSpawn",12000,1)
else
pUnit:RemoveEvents()
pUnit:RegisterEvent("CheckingForPlayer",1200,1)
end
end


--142342


function JaneSmithMeeting_On_Gossip(pUnit, event, player)
		pUnit:GossipCreateMenu(142360, player, 0)
	if player:HasQuest(3029) then
		pUnit:GossipMenuAddItem(0, "Do you remember me?", 246, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end


function JaneSmithMeeting_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
if player ~= nil then
pUnit:GossipCreateMenu(142350, player, 0)
	if player:HasQuest(3029) then
		pUnit:GossipMenuAddItem(0, "No, I am from present time and was sent here by a spirit to make sure you survive.", 247, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end
end

if(intid == 247) then
if player ~= nil then
pUnit:GossipCreateMenu(142351, player, 0)
	if player:HasQuest(3029) then
		pUnit:GossipMenuAddItem(0, "There may yet be an event that may occur to lead to your death in the present.", 248, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end
end

if(intid == 248) then
if player ~= nil then
pUnit:GossipCreateMenu(142352, player, 0)
	if player:HasQuest(3029) then
		pUnit:GossipMenuAddItem(4, "<Stay for Meeting>", 249, 0)
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end
end


if(intid == 249) then
Q3029Ready = true
	Jane = pUnit
		local x = Jane:GetX()
        local y = Jane:GetY()
        local z = Jane:GetZ()
        local o = Jane:GetO()
		Jane:SpawnCreature(77199 ,x , y, z, o, 35, 6000)
Jane:SendChatMessage(12,0,"Fellow men and women of Lakeshire, since I do not have any council members to vote with or against, I am ordering an evacuation to Stormwind.")
Jane:Emote(1,3000)
Jane:SetNPCFlags(2)
end

function VariableGossipCheck(pUnit, Event)
	if Q3029Ready ==  true then
		pUnit:RemoveEvents()
		i = 0
	   Jane:RegisterEvent("Meetingz",2000,1) 
	end
end



if(intid == 250) then
	player:GossipComplete()
end
end


function Meetingz(pUnit,Event)
i = i + 1
if i == 1 then
Jane:SendChatMessage(12,0,"A demon threat lurks and I fear they may be striking Lakeshire soon. I will not risk having any casualties.")
Jane:Emote(1,4000)
Linda = Jane:GetCreatureNearestCoords(Jane:GetX(),Jane:GetY(), Jane:GetZ(), 79834)
Paul = Jane:GetCreatureNearestCoords(Jane:GetX(), Jane:GetY(), Jane:GetZ(), 79835)
Dilan = Jane:GetCreatureNearestCoords(Jane:GetX(), Jane:GetY(), Jane:GetZ(), 79836)
Tom = Jane:GetCreatureNearestCoords(Jane:GetX(), Jane:GetY(), Jane:GetZ(), 79837)
Kendal = Jane:GetCreatureNearestCoords(Jane:GetX(), Jane:GetY(), Jane:GetZ(), 79838)
Lisa = Jane:GetCreatureNearestCoords(Jane:GetX(), Jane:GetY(), Jane:GetZ(), 79840)
Jane:RegisterEvent("Meetingz", 4000, 1)
elseif i == 2 then
Linda:SendChatMessage(12,0,"You're as mad as Councilor Luke!")
Linda:Emote(5,2000)
Jane:RegisterEvent("Meetingz", 1000, 1)
elseif i == 3 then
Dilan:SendChatMessage(12,0,"This is an outrage!")
Dilan:Emote(5,2000)
Jane:RegisterEvent("Meetingz", 1000, 1)
elseif i == 4 then
Paul:SendChatMessage(12,0,"So you expect us to pickup and leave everything hard we've worked for?")
Paul:Emote(5,2000)
Jane:RegisterEvent("Meetingz", 1000, 1)
elseif i == 5 then
Lisa:SendChatMessage(12,0,"You'll get your's aswell!")
Lisa:Emote(5,2000)
Jane:RegisterEvent("Meetingz", 1000, 1)
elseif i == 6 then
Kendal:SendChatMessage(12,0,"I don't pay taxes for this!")
Kendal:Emote(5,2000)
Jane:RegisterEvent("Meetingz", 2000, 1)
elseif i == 7 then
Jane:SendChatMessage(12,0,"Everybody calm down! If you choose to stay here then so be it.")
Jane:Emote(5,3000)
Jane:RegisterEvent("Meetingz", 3000, 1)
elseif i == 8 then
Tom:SendChatMessage(12,0,"Sod it all! Death to the council!")
Tom:EquipWeapons(12247,0,0)
Tom:SetMovementFlags(1)
Tom:MoveTo(-9214, -2216.21, 66.18, 4.69)
Jane:RegisterEvent("Meetingz", 2000, 1)
elseif i == 9 then
Tom:SetFaction(14)
Lisa:SendChatMessage(14,0,"He has a knife!")
Lisa:Emote(431,5000)
Paul:Emote(431,5000)
Linda:Emote(431,5000)
Dilan:Emote(431,5000)
Kendal:Emote(431,5000)
Jane:Emote(27,5000)
Jane:RegisterEvent("Meetingz", 5000, 1)
elseif i == 10 then
Jane:SendChatMessage(12,0,"This meeting is dismissed!")
Dilan:Despawn(1000,4000)
Kendal:Despawn(1000,4000)
Tom:Despawn(1000,4000)
Lisa:Despawn(1000,4000)
Linda:Despawn(1000,4000)
Paul:Despawn(1000,4000)
Kendal:Despawn(1000,4000)
Jane:RegisterEvent("Meetingz", 1000, 1)
elseif i == 11 then
local PlayersAllAround = Jane:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if Jane:GetDistanceYards(players) < 20 then
  if players:HasQuest(3029) == true then
players:FinishQuest(3029)
players:StartQuest(3030)
Jane:SetNPCFlags(3)
Jane:RegisterEvent("Meetingz", 5000, 1)
elseif i == 12 then
i = 0
end
end
end
end
end




RegisterUnitGossipEvent(77111, 1, "JaneSmithMeeting_On_Gossip")
RegisterUnitGossipEvent(77111, 2, "JaneSmithMeeting_Gossip_Submenus")

