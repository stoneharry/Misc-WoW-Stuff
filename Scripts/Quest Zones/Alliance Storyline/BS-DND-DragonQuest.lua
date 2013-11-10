--[[ Kalaran the Black and Archmage Dalira Sunblade ]]--

-- locals

local Kalaran
local Dalira
local Alasgor
local AlasgorTrigger

local CinCd = 0

-------------------------------------------------------

function Kalaran_OnSpawn(pUnit, Event)
 Kalaran=pUnit
 pUnit:RegisterEvent("Kalaran_Shadowform", 1000, 1)
 pUnit:RegisterEvent("Kalaran_Speak", 145000, 1)
end

function Kalaran_Speak(pUnit, Event)
 local speak= math.random(1,3)
 if speak== 1 then
 pUnit:SendChatMessage(12, 0, "Let me free!")
 end
 if speak== 2 then
 pUnit:SendChatMessage(12, 0, "You will not win!")
 end
 if speak== 3 then
 pUnit:SendChatMessage(12, 0, "Let me free, and I will serve you with a quick death.")
 end
end


function Kalaran_Shadowform(pUnit, Event)
 pUnit:ChannelSpell(43395, Kalaran)
end


function Dalira_OnSpawn(pUnit, Event)
 Dalira=pUnit
 pUnit:RegisterEvent("Dalira_Channel", 1000, 1)
end

function Dalira_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
 pUnit:SendChatMessage(12, 0, "No! This can't be...")
end

function Dalira_Channel(pUnit, Event)
 CineCd= 0
 pUnit:ChannelSpell(54142, Kalaran)
end

RegisterUnitEvent(50035, 18, "Kalaran_OnSpawn")
RegisterUnitEvent(50037, 18, "Dalira_OnSpawn")
RegisterUnitEvent(50037, 4, "Dalira_OnDead")


--[[ Force Field ]]--

local OBJECT_END=0x0006
local UNIT_FIELD_FLAGS= OBJECT_END+0x0034
local UNIT_FLAG_NOT_SELECTABLE= 0x02000000

function AlasgorTrigger_OnSpawn(pUnit, Event)
 AlasgorTrigger=pUnit
 pUnit:RegisterEvent("AlasgorTrigger_Channel", 1000, 1)
end

function AlasgorTrigger_Channel(pUnit, Event)
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
 pUnit:ChannelSpell(47346, AlasgorTrigger)
end

RegisterUnitEvent(50042, 18, "AlasgorTrigger_OnSpawn")

-------------------------------------------------------




--[[ Cinematic on top of Orc Tower ]]--

function RuneOfSpawn(item, event, player)
	RuneStart(item, player)
end

function RuneStart(item, player)
   if CineCd==0 then
             if CooldownCheck(player, 30) == true then 
             return
             end
	        CooldownTime[player:GetName()] = os.clock()
		  if player:GetDistanceYards(player:GetCreatureNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 50037)) <= 10 and player:HasQuest(50) then
	          Dalira:SpawnCreature(50040, -8091, -1888, 182.51, 0.304153, 35, 0)
		  else
	          player:SendAreaTriggerMessage("|cFFFF0000You need to be on top of the Orc Tower!")
                  end
   end
end

RegisterItemGossipEvent(78050, 1, "RuneOfSpawn")



---------------------------------------------------------


--[[ Alysgor Event ]]--


function Alasgor_Tower_OnSpawn(pUnit, Event)
 Alasgor = pUnit
 pUnit:RegisterEvent("Alasgor_Tower_Visual", 500, 1)
 pUnit:RegisterEvent("Alasgor_Tower_Destroy", 2000, 1)
 pUnit:RegisterEvent("Alasgor_Tower_StartEvent", 4000, 1)
end

RegisterUnitEvent(50040, 18, "Alasgor_Tower_OnSpawn")




function Alasgor_Tower_Destroy(pUnit, Event)
 pUnit:CastSpell(25046)
 AlasgorTrigger:Despawn(500, 70000)
end

function Alasgor_Tower_Visual(pUnit, Event)
 CineCd= CineCd + 1
 pUnit:CastSpell(64446)
end

function Alasgor_Tower_StartEvent(pUnit, Event)
 pUnit:Emote(1, 2000)
 Dalira:StopChannel()
 pUnit:SetFacing(0.48)
 pUnit:SendChatMessage(12, 0, "Stop this Archmage Dalira.")
 Dalira:RegisterEvent("Alasgor_Tower_Continue1", 2500, 1)
end


function Alasgor_Tower_Continue1(pUnit, Event)
 Dalira:SetFacing(3.43)
 pUnit:Emote(1, 3000)
 pUnit:SendChatMessage(12, 0, "How did you pass my shield, Alasgor!?")
 Alasgor:RegisterEvent("Alasgor_Tower_Continue2", 4000, 1)
end


function Alasgor_Tower_Continue2(pUnit, Event)
 pUnit:SendChatMessage(12, 0, "With the help of these mortals, Dalira. Now take down your weapon and prepare to get your punishment!")
 Dalira:RegisterEvent("Alasgor_Tower_Continue3", 7000, 1)
end


function Alasgor_Tower_Continue3(pUnit, Event)
 pUnit:SendChatMessage(12, 0, "Ha ha...You can't stop us, Alasgor. No one can. NOW PREPARE TO DIE!")
 Alasgor:RegisterEvent("Alasgor_Tower_Continue4", 6000, 1)
 Dalira:RegisterEvent("Dalira_Tower_Cast", 5000, 1)
end

function Dalira_Tower_Cast(pUnit, Event)
 pUnit:FullCastSpellOnTarget(61924, Alasgor)
end

function Alasgor_Tower_Continue4(pUnit, Event)
 pUnit:CastSpell(3651)
 Alasgor:RegisterEvent("Alasgor_Tower_Continue5", 2000, 1)
end

function Alasgor_Tower_Continue5(pUnit, Event)
 pUnit:RemoveAllAuras()
 pUnit:SendChatMessage(12, 0, "I am the Hand of Nozdormu. You can't kill me that easily...")
 pUnit:RegisterEvent("Alasgor_Tower_FreeStart", 5000, 1)
end

function Alasgor_Tower_FreeStart(pUnit, Event)
 Alasgor:MoveTo(-8084, -1886, 182.543, 0.80)
 pUnit:RegisterEvent("Alasgor_Tower_FreeStart2", 4000, 1)
end

function Alasgor_Tower_FreeStart2(pUnit, Event)
 pUnit:SetFacing(0.80)
 Kalaran:StopChannel()
 pUnit:SendChatMessage(12, 0, "Kalaran you are free. Without the help of these mortals, you would still be banished by Dalira.")
 Kalaran:RegisterEvent("Alasgor_Tower_KalaranTalk", 7000, 1)
end

function Alasgor_Tower_KalaranTalk(pUnit, Event)
 pUnit:SendChatMessage(12, 11, "Thank you for your help, Alasgor. I see potential in these mortals...maybe you should watch after them.")
 pUnit:RegisterEvent("Alasgor_Tower_AlasgorTalk", 8000, 1)
end

function Alasgor_Tower_AlasgorTalk(pUnit, Event)
 Alasgor:Emote(1, 3000)
 Alasgor:SendChatMessage(12, 0, "Understood. Be prepared Kalaran.")
 Alasgor:RegisterEvent("Alasgor_Tower_Last", 4000, 1)
 Kalaran:RegisterEvent("Alasgor_Tower_KalaranMove", 1000, 1)
end

function Alasgor_Tower_KalaranMove(pUnit, Event)
 pUnit:MoveTo(-8039, -1800, 181, 1.41)
 pUnit:Despawn(2000, 20000)
end






function Alasgor_Tower_Last(pUnit, Event)
 local PlayersAllAround = pUnit:GetInRangePlayers()
 for a, plr in pairs(PlayersAllAround) do
	if plr:HasQuest(50) == true then
	plr:MarkQuestObjectiveAsComplete(50, 0)
        end
 pUnit:SetFacing(3.43)
 pUnit:Emote(1, 3000)
 pUnit:SendChatMessage(12, 0, "Thank you for your help mortals...You will be rewarded for sure. Meet me in the near of the giant statue.")
 Alasgor:RegisterEvent("Alasgor_Tower_Despawn", 8000, 1)
 end
end



function Alasgor_Tower_Despawn(pUnit, Event)
 pUnit:CastSpell(64446)
 pUnit:Despawn(800, 0)
 Dalira:Despawn(2000, 12000)
end
