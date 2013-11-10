
local Count = 0
local Dude = nil

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000


function gggKaelSummon_OnGossip(pUnit, event, player)
    pUnit:GossipCreateMenu(12522, player, 0)
		if player:HasQuest(34) == true then
		pUnit:GossipMenuAddItem(9, "Summon The God!", 4, 0)
		end
    pUnit:GossipMenuAddItem(0, "Nevermind.", 3, 0)
    pUnit:GossipSendMenu(player)
end

function gggKaelSummon_GossipSubmenus(pUnit, event, player, id, intid, code)
if(intid == 4) then
    pUnit:SendChatMessage(12, 0, "I will summon the God.")
    pUnit:SetNPCFlags(2)
    Count = 1
    player:GossipComplete()
end
if(intid == 3) then
    player:GossipComplete()
end
end

RegisterUnitGossipEvent(258411, 1, "gggKaelSummon_OnGossip")
RegisterUnitGossipEvent(258411, 2, "gggKaelSummon_GossipSubmenus")

function gggshit_happens_lol(pUnit, Event)
	Dude = pUnit
	pUnit:RegisterEvent("gggbug", 500, 1)
end

function gggbug(pUnit, Event)
	pUnit:RegisterEvent("gggCheckForStuff_shit_happens", 4000, 0)
end

function gggCheckForStuff_shit_happens(pUnit, Event)
	if Count == 1 then
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("gggKaelSummon_Initialize", 1, 1)
	end
end

RegisterUnitEvent(258411, 18, "gggshit_happens_lol")

----------------------------------------------------------------------


function gggKaelSummon_Initialize(pUnit, Event)
 Count = 0
 pUnit:RegisterEvent("gggKaelSummon_Cast", 4000, 1)
 pUnit:RegisterEvent("gggKaelSummon_Summon", 8000, 1)
end

function gggKaelSummon_Cast(pUnit, Event)
 pUnit:CastSpell(35996)
 pUnit:CastSpell(46853)
end

function gggKaelSummon_Summon(pUnit, Event)
 pUnit:SendChatMessage(14, 0, "Behold Ragnaros, THE FIRE LORD!")
 pUnit:SpawnCreature(115021, -8165, -1298, 132, 0.181512, 35, 0)
end


----------------------------------------------------------------------


function gggKilJaeden_OnSpawn(pUnit, Event)
 pUnit:RegisterEvent("gggKilJaeden_Emote", 1000, 1)
end

function gggKilJaeden_Emote(pUnit, Event)
 pUnit:SetScale(1)
 pUnit:FullCastSpell(20568)
 pUnit:CastSpell(9617)
 pUnit:SetFaction(14)
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
 pUnit:RegisterEvent("Ragnaros_Is_Not_A_Happy_Bunny", 3000, 1)
end

function Ragnaros_Is_Not_A_Happy_Bunny(pUnit, Event)
	pUnit:PlaySoundToSet(8043)
	pUnit:SendChatMessage(14,0,"TOO SOON... YOU HAVE AWAKENED ME TOO SOON EXECUTUS, WHAT IS THE MEANING OF THIS INTRUSION?")
	pUnit:RegisterEvent("Ragnaros_Is_Not_A_Happy_Bunny_z", 8000, 1)
end

function Ragnaros_Is_Not_A_Happy_Bunny_z(pUnit, Event)
	pUnit:ChannelSpell(46219, Dude)
	Dude:CastSpell(32475)
	pUnit:RegisterEvent("Old_dude_zikehoe", 1000, 0)
	pUnit:RegisterEvent("Ragnaros_Departs", 5001, 1)
end

function Old_dude_zikehoe(pUnit, Event)
	Dude:CastSpell(32475)
end

function Ragnaros_Departs(pUnit, Event)
	pUnit:StopChannel()
	pUnit:RemoveEvents()
	Dude:SetHealth(1)
	for a, plr in pairs(pUnit:GetInRangePlayers()) do
		if plr:HasQuest(34) then
			plr:CastSpell(13874)
		end
	end
	pUnit:CastSpellOnTarget(31263, Dude)
	pUnit:RegisterEvent("Despawn_Ragnaros_Now", 2000, 1)
end

function Despawn_Ragnaros_Now(pUnit, Event)
	for a, plr in pairs(pUnit:GetInRangePlayers()) do
		if plr:HasQuest(34) == true then
			plr:MarkQuestObjectiveAsComplete(34, 0)
			pUnit:FullCastSpellOnTarget(11027, plr)
		end
	end
	pUnit:RegisterEvent("Despawn_Ragnaros_Now_Now", 500, 1)
end

function Despawn_Ragnaros_Now_Now(pUnit, Event)
	pUnit:SetScale(0.01)
	Dude:Despawn(1,1000)
	pUnit:Despawn(2000,0)
end

RegisterUnitEvent(115021, 18, "gggKilJaeden_OnSpawn")
