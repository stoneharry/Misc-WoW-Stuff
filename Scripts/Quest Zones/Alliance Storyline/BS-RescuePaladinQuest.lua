
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000

local Count = 0
local Dude = nil

function zzggggKaelSummon_OnGossip(pUnit, event, player)
    pUnit:GossipCreateMenu(23522, player, 0)
		if player:HasQuest(45) == true then
		pUnit:GossipMenuAddItem(9, "I am here to save you!", 4, 0)
		end
    pUnit:GossipMenuAddItem(0, "Nevermind.", 3, 0)
    pUnit:GossipSendMenu(player)
end

function zzggggKaelSummon_GossipSubmenus(pUnit, event, player, id, intid, code)
if(intid == 4) then
    pUnit:SendChatMessage(12, 0, "I thank you, but there is no time to delay, they are already coming!")
    pUnit:SetNPCFlags(2)
    Count = 1
	pUnit:SetFaction(1)
    player:GossipComplete()
end
if(intid == 3) then
    player:GossipComplete()
end
end

RegisterUnitGossipEvent(246961, 1, "zzggggKaelSummon_OnGossip")
RegisterUnitGossipEvent(246961, 2, "zzggggKaelSummon_GossipSubmenus")

function zzggggshit_happens_lol(pUnit, Event)
    pUnit:SetNPCFlags(1)
	Dude = pUnit
	pUnit:RegisterEvent("zzggggbug", 500, 1)
end

function zzggggbug(pUnit, Event)
	pUnit:RegisterEvent("zzggggCheckForStuff_shit_happens", 4000, 0)
end

function zzggggCheckForStuff_shit_happens(pUnit, Event)
	if Count == 1 then
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("zzggggKaelSummon_Initialize", 1, 1)
	end
end

RegisterUnitEvent(246961, 18, "zzggggshit_happens_lol")

function zzggggshit_dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(246961, 4, "zzggggshit_dead")

----------------------------------------------------------------------


function zzggggKaelSummon_Initialize(pUnit, Event)
 Count = 0
 pUnit:SpawnCreature(14081, -8110, -739, 135, 0.181512, 35, 0)
 pUnit:RegisterEvent("STOP_RESET_HELP_PLAYERS_HE", 36000, 1)
end

function someportal_on_spawn(pUnit, Event)
	if Dude == nil then
	else
	pUnit:ChannelSpell(45735, Dude)
	pUnit:RegisterEvent("Spawn_ATTACKERS", 5000, 4)
	pUnit:RegisterEvent("STOP_RESET_HELP_PLAYERS_HE_Z", 35050, 1)
	end
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

function Spawn_ATTACKERS(pUnit, Event)
	pUnit:SpawnCreature(426012, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 2, 45000)
end

function STOP_RESET_HELP_PLAYERS_HE_Z(pUnit, Event)
	pUnit:StopChannel()
	pUnit:Despawn(1000,0)
end

RegisterUnitEvent(14081, 18, "someportal_on_spawn")

function someguy_on_spawn(pUnit, Event)
	pUnit:RegisterEvent("delay_lols_ztg", 500, 1)
end

function delay_lols_ztg(pUnit, Event)
	if Dude == nil then
	pUnit:Despawn(1000,0)
	else
	pUnit:EquipWeapons(19346,47287,0)
	pUnit:MoveTo(Dude:GetX(), Dude:GetY(), Dude:GetZ(), Dude:GetO())
	end
end

RegisterUnitEvent(426012, 18, "someguy_on_spawn")

function STOP_RESET_HELP_PLAYERS_HE(pUnit, Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		if plr:HasQuest(45) == true then
		plr:MarkQuestObjectiveAsComplete(45, 0)
		end
	end
	pUnit:SendChatMessage(12,0,"That's the last of 'em. I can make it out from here, thank you for your assistance!")
	pUnit:RegisterEvent("Hangonasek_Tehe", 2500, 1)
end

function Hangonasek_Tehe(pUnit, Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		if plr:HasQuest(45) == true then
		plr:SetPhase(1)
		plr:Teleport(0, -7914, -1015, 135)
		plr:CastSpell(64446)
		end
	end
	pUnit:CastSpell(64446)
	pUnit:SetFaction(35)
	pUnit:Despawn(2000, 30000)
end
