--[[339472 rommath
12397 kazzak
322427 -- Skystorm]]
-- -2087.98 7125.76 34.58
--UNFINISHED SCRIPT

local Rom
local Kaz
local Ymiron
local GossiperDP
local i = 0
local DarkPortalEvent = false

local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local OBJECT_END = 0x0006



function Keller_KazSpawn(pUnit,Event)
pUnit:SetFaction(14)
Kaz = pUnit
Kaz:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
Kaz:RegisterEvent("Kazzak_tqalkBS",1000,1) 
end


function Kazzak_tqalkBS(pUnit,Event)
pUnit:SendChatMessage(14,0,"I remember well the sting of defeat at the conclusion of the Third War. I have waited far too long for my revenge. Now the shadow of the Legion falls over this world. It is only a matter of time until all of your failed creation... is undone.")
pUnit:PlaySoundToSet(11332)
end


RegisterUnitEvent(12397, 18,"Keller_KazSpawn")

function Move_AfterSpawnKaz(pUnit,Event)
Kaz:MoveTo(-2071.62,7125.61,30.58, 6.20)
end

function Ymiron_Spawn(pUnit,Event)
Ymiron = pUnit
end

RegisterUnitEvent(24321, 18,"Ymiron_Spawn")

function Rommath_Spawn(pUnit,Event)
Rom = pUnit
Rom:StopChannel()
end

RegisterUnitEvent(339472, 18,"Rommath_Spawn")


function GossipStartDP_Spawn(pUnit,Event)
pUnit:RegisterEvent("DarkPortalEvent_Trigger",2000,0)
pUnit:RegisterEvent("CheckingForUnit",1000,0)
end

RegisterUnitEvent(322427, 18,"GossipStartDP_Spawn")



function CheckingForUnit(pUnit,Event)
    local plr = pUnit:GetRandomPlayer(0)
    if plr ~= nil then
        if plr:IsDead() == false then
			if pUnit:GetDistanceYards(plr) < 30 then
				DarkPortalEvent =  true
			end
		end
	end
end


function DarkPortalEvent_Trigger(pUnit,Event)
	if DarkPortalEvent then
		pUnit:RemoveEvents()
		GossiperDP = pUnit
		GossiperDP:RegisterEvent("DarkPortalGossipQueue",1000,1) 
	end
end

function DarkPortalGossipQueue(pUnit,Event)
	i = i + 1
	if i == 1 then
		Ymiron:SendChatMessage(12,0,"This better work elf, I will see your skull on a pike if you have brought me here for nonsense!")
		Ymiron:Emote(4,1000)
        Ymiron:RegisterEvent("DarkPortalGossipQueue",2000,1) 
	elseif i == 2 then
        Rom:SendChatMessage(12,0,"You will see Kazzak for yourself, the powers the dark lord has given me. I will not fail.")
        Rom:ChannelSpell(70634,Rom)
        Ymiron:RegisterEvent("DarkPortalGossipQueue",3000,1) 
	elseif i == 3 then
		Rom:SendChatMessage(15,0,"Welcome... Pest. Do you think that I do not know what you are capable of? No...this will be your demise.")
        Rom:RegisterEvent("DarkPortalGossipQueue",4000,1) 
	elseif i == 4 then
		Rom:CastSpell(40647)
        Rom:SendChatMessage(42,0,"Rommath has encased you within a time stasis!")
		Ymiron:SendChatMessage(14,0,"Brothers and Sisters, today marks a new day for the Vrykul race. Our gods have abandoned us, no more shall they do so. They will regret the very day as the we have found a new being, much more powerful than they could ever imagine!")
		Ymiron:Emote(53,2000)
		local PlayersAllAround = Rom:GetInRangePlayers()
		for a, players in pairs(PlayersAllAround) do
			players:CastSpell(69235)
            players:SetPlayerLock(1)
		end
		Ymiron:RegisterEvent("DarkPortalGossipQueue",8000,1) 
	end
	if i == 5 then
		Rom:SendChatMessage(14,0,"Vengeance burns!")
		Rom:PlaySoundToSet(12415)
		Rom:StopChannel()
		Rom:SpawnCreature(12397, -2087.98,7125.76,34.58, 0, 35, 0)
        Rom:Emote(2,1500)
        Rom:RegisterEvent("DarkPortalGossipQueue",20000,1) 
	elseif i == 6 then
		GossiperDP:SendChatMessage(12,0,"We must leave at once!")
		local PlayersAllAround = GossiperDP:GetInRangePlayers()
		for a, players in pairs(PlayersAllAround) do
			players:MoveCharge(GossiperDP:GetX(), GossiperDP:GetY(), GossiperDP:GetZ())
			--GossiperDP:CastSpellOnTarget(28337,players)
		end
		GossiperDP:RegisterEvent("DarkPortalGossipQueue",1500,1) 
	end
	if i == 7 then
		i = 0
		DarkPortalEvent =  false
		GossiperDP:CastSpell(52096)
		GossiperDP:Despawn(3000,8000)
		Rom:Despawn(2000,3000)
		Kaz:Despawn(2000,3000)
		Ymiron:Despawn(2000,3000)
		local PlayersAllAround = GossiperDP:GetInRangePlayers()
		for a, players in pairs(PlayersAllAround) do
		    players:SetPlayerLock(0)
		    players:CastSpell(52096)
			players:RemoveAura(40647)
			if players:HasQuest(4231) then
				players:MarkQuestObjectiveAsComplete(4231,0)
			end
			players:Teleport(0, -9787.92,-2205.34,63.65)
		end
	end
end 


  