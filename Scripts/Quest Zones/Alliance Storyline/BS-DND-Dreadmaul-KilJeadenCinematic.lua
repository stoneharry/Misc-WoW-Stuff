--[[ Cinematic ]]--

local Count = 0
local Dude = nil

function KaelSummon_OnGossip(pUnit, event, player)
    pUnit:GossipCreateMenu(1260722, player, 0)
		if player:HasQuest(10) == true then
			pUnit:GossipMenuAddItem(0, "Kael'thas we are ready.", 4, 0)
		end
    pUnit:GossipMenuAddItem(0, "Nevermind.", 3, 0)
    pUnit:GossipSendMenu(player)
end


function KaelSummon_GossipSubmenus(pUnit, event, player, id, intid, code)
if(intid == 4) then
    pUnit:SendChatMessage(12, 0, "Stand back, mortals. I will summon the Lord and master.")
    pUnit:SetNPCFlags(2)
    Count = 1
    player:GossipComplete()
end


if(intid == 3) then
    player:GossipComplete()
end

end


RegisterUnitGossipEvent(24855, 1, "KaelSummon_OnGossip")
RegisterUnitGossipEvent(24855, 2, "KaelSummon_GossipSubmenus")

function shit_happens_lol(pUnit, Event)
	Dude = pUnit
	pUnit:RegisterEvent("bug", 500, 1)
end

function bug(pUnit, Event)
	pUnit:RegisterEvent("CheckForStuff_shit_happens", 4000, 0)
end

function CheckForStuff_shit_happens(pUnit, Event)
	if Count == 1 then
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("KaelSummon_Initialize", 1, 1)
	end
end

RegisterUnitEvent(24855, 18, "shit_happens_lol")

----------------------------------------------------------------------


function KaelSummon_Initialize(pUnit, Event)
 Count = 0
 pUnit:RegisterEvent("KaelSummon_Cast", 4000, 1)
 pUnit:RegisterEvent("KaelSummon_Summon", 8000, 1)
end

function KaelSummon_Cast(pUnit, Event)
 pUnit:CastSpell(35996)
 pUnit:CastSpell(46853)
end

function KaelSummon_Summon(pUnit, Event)
 pUnit:SendChatMessage(14, 0, "BOW DOWN BEFORE KIL'JAEDEN!")
 pUnit:SpawnCreature(25315, -7926, -2577, 213.5, 4.993, 35, 0)
end


----------------------------------------------------------------------


function KilJaeden_OnSpawn(pUnit, Event)
 pUnit:RegisterEvent("KilJaeden_Emote", 50, 1)
 pUnit:PhaseSet(2)
end

function KilJaeden_Emote(pUnit, Event)
 pUnit:PhaseSet(2)
 pUnit:PlaySoundToSet(12506)
 pUnit:SendChatMessage(14, 0, "Destruction!")
 pUnit:Emote(449, 10000)
 pUnit:RegisterEvent("talktalktalktalk_kil_jeadon", 11000, 1)
 pUnit:RegisterEvent("talktalktalktalk_kil_jeadon_z", 15000, 1)
 pUnit:RegisterEvent("talktalktalktalk_kil_jeadon_zz", 20000, 1)
 pUnit:RegisterEvent("talktalktalktalk_kil_jeadon_zzz", 23500, 1)
 pUnit:RegisterEvent("talktalktalktalk_kil_jeadon_zzzz", 28000, 1)
end

function talktalktalktalk_kil_jeadon(pUnit, Event)
	pUnit:PlaySoundToSet(12495)
	pUnit:SendChatMessage(12,0,"All my plans have led to this..")
	pUnit:Emote(1,3500)
end

function talktalktalktalk_kil_jeadon_z(pUnit, Event)
	pUnit:PlaySoundToSet(12496)
	pUnit:SendChatMessage(12,0,"Stay on task, do not waste time.")
	pUnit:Emote(1,4000)
end

function talktalktalktalk_kil_jeadon_zz(pUnit, Event)
	pUnit:PlaySoundToSet(12497)
	pUnit:SendChatMessage(12,0,"I have waited long enough..")
	pUnit:Emote(1,3000)
end

function talktalktalktalk_kil_jeadon_zzz(pUnit, Event)
	pUnit:PlaySoundToSet(12498)
	pUnit:SendChatMessage(12,0,"Fail me and suffer for eternity.")
	pUnit:Emote(1,4000)
end

function talktalktalktalk_kil_jeadon_zzzz(pUnit, Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		if plr:HasQuest(10) == true then
		plr:MarkQuestObjectiveAsComplete(10, 0)
		end
		plr:SetPhase(1)
		plr:RemoveAura(68085)
	end
	if Dude ~= nil then
		Dude:SetNPCFlags(1)
		Dude:RegisterEvent("CheckForStuff_shit_happens", 4000, 0)
	end
	pUnit:Despawn(1,0)
end

RegisterUnitEvent(25315, 18, "KilJaeden_OnSpawn")

-- 12495 / All my plans have led to this.
-- 12496 / Stay on task, do not waste time.
-- 12497 / I have waited long enough.
-- 12498 / Fail me, and suffer for eternity.
-- 12500 / The extendable have perished, so be it! Now I shall succeed where sargaros could not, I will bleed this wretched world and secure my place as the true master of the burning legion! The end has come! LET THE UNRAVELING OF THIS WORLD COMMENCE!

function tttzGolemoth_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(60051, player, 0)
		if player:HasQuest(10) == true then
		pUnit:GossipMenuAddItem(0, "Mugi, can you show me what has happend...?", 246, 0)
		end
   pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
   pUnit:GossipSendMenu(player)
end


function tttzGolemoth_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
  player:SetPhase(2)
  player:GossipComplete()
end
if(intid == 250) then
	player:GossipComplete()
end
end

RegisterUnitGossipEvent(50012, 1, "tttzGolemoth_On_Gossip")
RegisterUnitGossipEvent(50012, 2, "tttzGolemoth_Gossip_Submenus")

