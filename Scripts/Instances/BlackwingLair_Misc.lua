--[[local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

--Increased time that the event occours a bit due to they appear to often :P Also increased the time between each message, as it was hard to read--Tikki

function TALKERNPC_MallEvent(pUnit,Event)
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
 pUnit:RegisterEvent("Talk_PartOne", 45000, 1)
end

RegisterUnitEvent(77135,18, "TALKERNPC_MallEvent") 

function Talk_PartOne(pUnit,Event)
local lord = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 1748)
lord:SendChatMessage(12,0,"Ah, Jane Perenolde. I have heard much of you from the reports I received at Redridge. Tell me, what brings you here?")
lord:Emote(2,1000)
pUnit:RegisterEvent("Talk_PartTwo", 8000, 1)
end

function Talk_PartTwo(pUnit,Event)
local Jane = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 77130)
Jane:SendChatMessage(12,0,"Thrall, Lord Bolvar. We aren't safe here; something sinister is happening deep inside Blackrock Mountain.") 
Jane:Emote(1,2000)
pUnit:RegisterEvent("Talk_PartThree", 6000, 1)
end

function Talk_PartThree(pUnit,Event)
local thrall = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 4949)
thrall:SendChatMessage(12,0,"The elements tell me that you are correct, yet... I fear there is nothing we can do. We cannot access the depths of Blackrock Mountain at this point in time.") 
thrall:Emote(1,2000)
pUnit:RegisterEvent("Talk_PartFour", 10000, 1)
end

function Talk_PartFour(pUnit,Event)
local Jane = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 77130)
Jane:SendChatMessage(12,0,"You don't understand! If we do not solve this problem now, everyone here and in Redridge will perish. A pit commander is being summoned within this mountain - similiar to that of Mannoroth, we must-") 
Jane:Emote(1,2000)
pUnit:RegisterEvent("Talk_PartFive", 10000, 1)
end

function Talk_PartFive(pUnit,Event)
local grim = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 77032)
grim:SendChatMessage(12,0,"Thrall, my clan and myself are ready to serve under the Horde and fight off the demonic threat. The Darkshield clan has lived in Blackrock mountain for many generations. We will grant the Horde and Alliance entry into Blackwing Lair.") 
grim:Emote(1,2000)
pUnit:RegisterEvent("Talk_PartSix", 12500, 1)
end


function Talk_PartSix(pUnit,Event)
local thrall = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 4949)
thrall:SendChatMessage(12,0,"It is settled then. The Horde shall combat the threat within Blackwing Lair.") 
thrall:Emote(1,2000)
pUnit:RegisterEvent("Talk_PartSeven", 5500, 1)
end

function Talk_PartSeven(pUnit,Event)
local lord = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 1748)
lord:SendChatMessage(12,0,"I will send Alliance aid into Blackwing Lair aswell. They are at your command, Lady Perenolde.")
lord:Emote(1,2000)
pUnit:RegisterEvent("Talk_PartEight", 6000, 1)
end

function Talk_PartEight(pUnit,Event)
local grim = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 77032)
grim:SendChatMessage(12,0,"One more thing, I will have Zurtrogg Darkshield's Head on a pike when I return...") 
grim:Emote(1,2000)
pUnit:RegisterEvent("Talk_PartNine", 5000, 1)
end


function Talk_PartNine(pUnit,Event)
local grim = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 77032)
local Jane = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 77130)
Jane:CastSpell(64446)
grim:CastSpell(64446)
Jane:Despawn(2000,10000)
grim:Despawn(2000,10000)
pUnit:RegisterEvent("Talk_PartOne",1800000, 1)
end
]]