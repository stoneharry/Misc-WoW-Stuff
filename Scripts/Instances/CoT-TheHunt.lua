
CM = {}
CM.VAR = {}

-- Format: [ID] = {sound ID, Message, Shout}
local SOUNDS = {
	-- Music
	[1] = {50200, nil, nil}, -- NightElfX1 Music 
	[2] = {50201, nil, nil}, -- Persuit Theme Music
	-- Intro Cinematic
	[3] = {50202, "Nordrassil's roots seem to be healing well. I wish I could say the same for Felwood, I fear the Legion's corruption will scar the glade permanently.", false},
	[4] = {50203, "Your druids will think of something. Perhaps Ysera or Alexstrasza could lend their-", false},
	[5] = {50204, "Your pardon, Shando Stormrage and Priestess Tyrande, but she insisted that she be allowed to see you.", false},
	[6] = {50205, "Who are you girl? What is so urgent?", false},
	[7] = {50206, "I am a servant of the Warden, Maiev Shadowsong, she who pledged to hunt down the Betrayer, Illidan.", false},
	[8] = {50207, "Illidan? Explain yourself.", false},
	[9] = {50208, "Your pardon, Shando. But your brother has raised a dark army from the sea and stolen a powerful demonic artifact. Even now my mistress battles him on the broken isles, she requires immediate reinforcements.", false},
	[10] = {50209, "I will go. I will lead the sentinels there myself.", false},
	[11] = {50210, "No my love. The druids and I can handle-", false},
	[12] = {50211, "I am the one who set him free. The responsibility is mine.", false},
	[13] = {50212, "Then we shall both go. If this girls tale is true, Maiev wil need all the help she can get.", false},
	-- Narrative
	[14] = {50213, "My owls have already scouted ahead of us and found Maiev's location. She and her forces are under attack, but we will need to pass through the jungle to reach her.", false},
	[15] = {50214, "We best make haste, I doubt Maiev's forces can hold out much longer.", false},
	-- Reaching Maiev
	[16] = {50215, "I'm glad we reached you in time, Maiev.", false},
	[17] = {50216, "Elune be praised! I knew you would come, Shando Stormrage.", false},
	[18] = {50217, "Priestess Tyrande, I'm surprised you came in person. Are you here to solve your guilty conscience?", false},
	[19] = {50218, "I did what I had to do, Maiev! You are in no position to judge ME.", true},
	[20] = {50219, "What you did was murder MY watchers and set the Betrayer free! It is you who should be locked in a cage.", false},
	[21] = {50220, "Stop this, both of you! We're not out of danger yet. Maiev, what's the situation here?", false},
	[22] = {50221, "We've wasted too much time. The longer we wait to attack the stronger Illidan's forces become. We must strike soon, Shando.", false},
  	[23] = {50222, "Very well, let's get moving then.", false},
  	-- Illidan Encounter
	[24] = {50223, "Tyrande, what are you doing here? This battle does not concern you.", false},
	[25] = {50224, "I was wrong to set you free, Illidan. I can see that now. You've become a monster.", false},
	[26] = {50225, "Monster? Is that what you think of me? I have -always- cared for you, Tyrande. I sought only to improve my worthiness, my power.", false},
	[27] = {50226, "Raw power is no substitute for true strength, Illidan. That is why I chose your brother over you.", false},
	[28] = {50227, "Still you refuse to see me for what I truly am! You believe me to be a villian, your enemy! But soon now you will see our enemies are the same.", false},
	[29] = {50228, "Brother! What are you doing here?", false},
	[30] = {50229, "I've come to stop you, Illidan. Instead of banishing you, I should have returned you to your cage when I had the chance. I was weak then - but no longer.", false},
	[31] = {50230, "I have sworn allegiance to a new master, brother. I have a great task to perform in his service. I'm sorry, but I cannot allow you to stand in my way.", false},
	[32] = {50231, "I can scarcely believe you survived. You are more resourceful than I imagined, little warden.", false},
	[33] = {50232, "I am the hand of justice, Illidan. Long ago I swore an oath to keep you chained, and by all the gods I shall!", true},
	[34] = {50233, "Not yet, my little priestess. A pity you couldn't see things my way. Now you and the whole world will understand just what I am capable of! ASKAROF!", true},
	-- Outro Cinematic
	[35] = {50234, "Show yourself, Illidan! It's over!", true},
	[36] = {50235, "This battle is far from over, Maiev. Illidan has yet to be accounted for, and I've seen no sign of Tyrande either.", false},
	[37] = {50236, "Victory is ours! It has been an honour to fight at your side, Shando.", false},
	[38] = {50237, "Don't worry my love. We'll find Illidan wherever he runs. We'll find him.", false},
	-- Music
	[39] = {50238, "We'll have to fight our way through the naga to reach Maiev!", false},
	[40] = {50239, "Maiev's forces wont hold out much longer.", false},
	[41] = {50240, "The jungle here is impassable. I'll need to use force of nature to clear a path for us.", false},
	[42] = {50241, "Wretched night elves, we are the naga. We are the future!", true},
	[43] = {50242, "We must move quickly to save Maiev!", false},
	[44] = {50243, "We must reach the warden's base quickly!", false},
	[45] = {50244, "We're running out of time, we must reach Maiev quickly!", false},
	[46] = {50245, "What are these vile serpents?", false},
	-- Illidan voices
	[47] = {50246, "Chaos boils in my veins.", true},
	[48] = {50247, "Demon blood is thicker than... regular blood.", true},
	[49] = {50248, "I like my enemies dead and my blades flaming.", true},
	[50] = {50249, "For Kalimdor!", true},
	[51] = {50250, "None shall survive!", true},
	[52] = {50251, "Your blood is mine!", true},
	[53] = {50252, "Run for your life!", true},
	[54] = {50253, "Revenge.", true},
	[55] = {50254, "I shall fight fire with fire.", true},
}

local function PlayMessage(u, s)
	if not u then
		return
	end
	local m = SOUNDS[s][2]
	if m then
		if SOUNDS[s][3] then
			u:SendChatMessage(14,0,m)
			u:Emote(5,0)
		else
			u:SendChatMessage(12,0,m)
			u:Emote(1,0)
		end
		if SOUNDS[s][1] then
			u:PlaySoundToSet(SOUNDS[s][1])
		end
	else
		if SOUNDS[s][1] then
			u:PlayMusicToSet(SOUNDS[s][1])
		end
	end
end

---------------------------
-- Setup creatures
---------------------------

function CM.VAR.VariableiseCreatures(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CM[id] = CM[id] or {VAR={}}
	if Event == 18 then
		if pUnit:GetEntry() == 153621 then
			CM[id].VAR.MALFURION = pUnit
			if CM[id].VAR.Ending then
				pUnit:RegisterEvent("CM.VAR.EndingTyrande", 1000, 0)
			else
				pUnit:RegisterEvent("CM.VAR.StartEvent", 4000, 0)
			end
		else
			CM[id].VAR.TYRANDE = pUnit
		end
	else
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(42,0,pUnit:GetName().." has died!")
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			v:RemoveEvents()
			v:Despawn(1,0)
		end
	end
end

RegisterUnitEvent(153621, 18, "CM.VAR.VariableiseCreatures")
RegisterUnitEvent(153622, 18, "CM.VAR.VariableiseCreatures")
RegisterUnitEvent(153621, 4, "CM.VAR.VariableiseCreatures")
RegisterUnitEvent(153622, 4, "CM.VAR.VariableiseCreatures")

---------------------------
-- Gossip Start & Intro
---------------------------

function CM.VAR.GossipStartZ1(pUnit, event, player)
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(9, "Let us begin.", 424, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 526, 0)
	pUnit:GossipSendMenu(player)
end


function CM.VAR.GossipStartZ2(pUnit, event, player, id, intid, code)
	player:GossipComplete()
	if(intid == 424) then
		local id = pUnit:GetInstanceID() or 1
		CM[id] = CM[id] or {VAR={}}
		if CM[id].VAR.MALFURION and CM[id].VAR.TYRANDE then
			pUnit:SetNPCFlags(2)
			CM[id].VAR.start = true
		end
	end
end

RegisterUnitGossipEvent(90191, 1, "CM.VAR.GossipStartZ1")
RegisterUnitGossipEvent(90191, 2, "CM.VAR.GossipStartZ2")

function CM.VAR.StartEvent(pUnit)
	local id = pUnit:GetInstanceID() or 1
	CM[id] = CM[id] or {VAR={}}
	if CM[id].VAR.start then
		CM[id].VAR.start = false
		CM[id].VAR.i = 0
		pUnit:RemoveEvents()
		PlayMessage(CM[id].VAR.MALFURION, 1)
		pUnit:RegisterEvent("CM.VAR.CinematicIntro", 1000, 0)
	elseif CM[id].VAR.start2 and not CM[id].VAR.IEZ then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("CM.VAR.AI_COMBAT", 1000, 0)
	end
end

function CM.VAR.CinematicIntro(pUnit)
	local id = pUnit:GetInstanceID() or 1
	CM[id] = CM[id] or {VAR={}}
	CM[id].VAR.i = CM[id].VAR.i + 1
	if CM[id].VAR.i == 1 then
		PlayMessage(CM[id].VAR.MALFURION, 3)
	elseif CM[id].VAR.i == 9 then
		CM[id].VAR.druid = pUnit:SpawnCreature(134092, -14, 193.4, -3.3, 1.686005, 35, 54000, 1484, 0, 0)
		CM[id].VAR.sent = pUnit:SpawnCreature(32074, -19, 196, -3.3, 1.686005, 35, 54000)
	elseif CM[id].VAR.i == 10 then
		PlayMessage(CM[id].VAR.TYRANDE, 4)
		CM[id].VAR.druid:MoveTo(-15, 213, -4.9, 1.553163)
		CM[id].VAR.sent:MoveTo(-19, 215, -4.9, 1.553163)
		CM[id].VAR.sent:SetScale(1.5)
	elseif CM[id].VAR.i == 15 then
		PlayMessage(CM[id].VAR.druid, 5)
		CM[id].VAR.TYRANDE:SetFacing(5.295580)
		CM[id].VAR.MALFURION:SetFacing(4.266711)
	elseif CM[id].VAR.i == 24 then
		PlayMessage(CM[id].VAR.TYRANDE, 6)
	elseif CM[id].VAR.i == 28 then
		PlayMessage(CM[id].VAR.sent, 7)
	elseif CM[id].VAR.i == 33 then
		PlayMessage(CM[id].VAR.MALFURION, 8)
	elseif CM[id].VAR.i == 38 then
		PlayMessage(CM[id].VAR.sent, 9)
	elseif CM[id].VAR.i == 50 then
		PlayMessage(CM[id].VAR.TYRANDE, 10)
		CM[id].VAR.TYRANDE:SetFacing(6.241991)
		CM[id].VAR.sent:MoveTo(-17, 178, -3.45, 0)
		CM[id].VAR.druid:MoveTo(-17, 178, -3.45, 0)
		CM[id].VAR.sent = nil
		CM[id].VAR.druid = nil
	elseif CM[id].VAR.i == 56 then
		PlayMessage(CM[id].VAR.MALFURION, 11)
		CM[id].VAR.MALFURION:SetFacing(3.123958)
	elseif CM[id].VAR.i == 59 then
		PlayMessage(CM[id].VAR.TYRANDE, 12)
	elseif CM[id].VAR.i == 63 then
		PlayMessage(CM[id].VAR.MALFURION, 13)
	elseif CM[id].VAR.i == 65 then
		local plr = pUnit:GetClosestPlayer()
		if not plr then
			CM[id].VAR.i = CM[id].VAR.i - 1
		else
			pUnit:RemoveEvents()
			CM[id].VAR.MALFURION:SetUnitToFollow(plr, 2, 1)
			CM[id].VAR.TYRANDE:SetUnitToFollow(plr, 4, 5)
			CM[id].VAR.MALFURION:SetFaction(plr:GetFaction())
			CM[id].VAR.TYRANDE:SetFaction(plr:GetFaction())
			pUnit:RegisterEvent("CM.VAR.AI_COMBAT", 1000, 0)
			pUnit:RegisterEvent("CM.VAR.MoreMessages", 6000, 1)
			pUnit:RegisterEvent("CM.VAR.MoreMessage2s", 15000, 1)
			CM[id].VAR.start2 = true
		end
	end
end

function CM.VAR.MoreMessages(pUnit)
	local id = pUnit:GetInstanceID() or 1
	PlayMessage(CM[id].VAR.TYRANDE, 14)
end

function CM.VAR.MoreMessage2s(pUnit)
	local id = pUnit:GetInstanceID() or 1
	PlayMessage(CM[id].VAR.TYRANDE, 15)
end

---------------------------
-- AI
---------------------------

function CM.VAR.AI_COMBAT(pUnit)
	local id = pUnit:GetInstanceID() or 1
	AI_HANDLE(CM[id].VAR.MALFURION)
	AI_HANDLE(CM[id].VAR.TYRANDE)
	if CM[id].VAR.MAIEV then
		AI_HANDLE(CM[id].VAR.MAIEV)
	end
end

function AI_HANDLE(pUnit)
	local found = false
	local plrs = pUnit:GetInRangePlayers()
	if plrs and #plrs ~= 0 then
		for _, v in pairs(pUnit:GetInRangePlayers()) do
			if v:IsAlive() then
				found = true
				break
			end
		end
	end
	if not found then
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:IsAlive() and v:GetDistanceYards(pUnit) < 50 then
				v:RemoveEvents()
				v:Despawn(1,1)
			end
		end
		pUnit:Despawn(1,1)
		return
	end
	if pUnit:IsInCombat() then
		if pUnit:IsCasting() then
			return
		end
		if pUnit:GetEntry() == 153621 then
			local id = pUnit:GetInstanceID() or 1
			if not CM[id].VAR.IEZ then
				if math.random(1,40) == 1 then
					local choice = math.random(1,3)
					if choice == 1 then
						PlayMessage(pUnit, 39)
					elseif choice == 2 then
						PlayMessage(pUnit, 43)
					elseif choice == 3 then
						PlayMessage(pUnit, 44)
					end
				end
			end
			for _,v in pairs(pUnit:GetInRangePlayers()) do
				if not v:HasAura(48469) and v:IsAlive() then
					v:FullCastSpellOnTarget(48469,v)
					return
				elseif v:GetHealthPct() < 75 and v:IsAlive() then
					pUnit:FullCastSpellOnTarget(5189, v)
					return
				end
			end
		else
			local id = pUnit:GetInstanceID() or 1
			if not CM[id].VAR.IEZ then
				if math.random(1,40) == 1 then
					if math.random(1,2) == 1 then
						PlayMessage(pUnit, 45)
					else
						PlayMessage(pUnit, 40)
					end
				end
			end
			local t = pUnit:GetSelection()
			if t and not t:IsPlayer() then
				if math.random(1,2) == 1 then
					pUnit:FullCastSpellOnTarget(9912, t)
				else
					pUnit:FullCastSpellOnTarget(8951, t)
				end
			end
		end
	else
		local p = pUnit:GetUnitToFollow()
		if p then
			if p:IsInCombat() then
				local t = p:GetSelection()
				if t and not t:IsPlayer() and not t:GetEntry() == 153621 and not t:GetEntry() == 153622 then
					pUnit:AttackReaction(t, 1, 0)
				end
			end
		else
			local plr = pUnit:GetClosestPlayer()
			if plr then
				if pUnit:GetEntry() == 153621 then
					pUnit:SetUnitToFollow(plr, 2, 1)
				else
					pUnit:SetUnitToFollow(plr, 4, 5)
				end
			end
		end
	end
end

---------------------------
-- Maiev
---------------------------

function CM.VAR.Maiev(pUnit, Event)
	pUnit:RegisterEvent("CM.VAR.MaievC", 1000, 0)
end

function CM.VAR.MaievC(pUnit)
	local id = pUnit:GetInstanceID() or 1
	CM[id] = CM[id] or {VAR={}}
	if CM[id].VAR.IEZ then
		return
	end
	if CM[id].VAR.MALFURION ~= nil and CM[id].VAR.MALFURION:GetName() and CM[id].VAR.TYRANDE ~= nil and CM[id].VAR.TYRANDE:GetName() and pUnit then -- added extra checks because odd errors
		if CM[id].VAR.TYRANDE:GetDistanceYards(pUnit) < 20 and CM[id].VAR.MALFURION:GetDistanceYards(pUnit) < 20 then
			pUnit:RemoveEvents()
			CM[id].VAR.IEZ = true
			pUnit:SetFacing(1.6)
			CM[id].VAR.MALFURION:RemoveEvents()
			CM[id].VAR.TYRANDE:RemoveEvents()
			PlayMessage(CM[id].VAR.MALFURION, 16)
			CM[id].VAR.MAIEV = pUnit
			CM[id].VAR.MAIEV:EquipWeapons(32425, 0, 0)
			CM[id].VAR.MAIEV:SetUInt32Value(0x0006 + 0x0074, 1)
			CM[id].VAR.i = 0
			pUnit:RegisterEvent("CM.VAR.MaievCin", 1000, 0)
		end
	end
end

RegisterUnitEvent(231971, 18, "CM.VAR.Maiev")

function CM.VAR.MaievCin(pUnit)
	local id = pUnit:GetInstanceID() or 1
	CM[id].VAR.i = CM[id].VAR.i + 1
	if CM[id].VAR.i == 4 then
		PlayMessage(pUnit, 17)
	elseif CM[id].VAR.i == 9 then
		PlayMessage(pUnit, 18)
	elseif CM[id].VAR.i == 16 then
		PlayMessage(CM[id].VAR.TYRANDE, 19)
	elseif CM[id].VAR.i == 24 then
		PlayMessage(pUnit, 20)
	elseif CM[id].VAR.i == 32 then
		PlayMessage(CM[id].VAR.MALFURION, 21)
	elseif CM[id].VAR.i == 38 then
		PlayMessage(pUnit, 22)
	elseif CM[id].VAR.i == 46 then
		PlayMessage(CM[id].VAR.MALFURION, 23)
	elseif CM[id].VAR.i == 48 then
		pUnit:SendChatMessage(42,0,"Maiev, Malfurion and Tyrande are now hunting Illidan. You have been commanded to destroy the Naga.")
		CM[id].VAR.MALFURION:RemoveEvents()
		CM[id].VAR.TYRANDE:RemoveEvents()
		CM[id].VAR.MALFURION:Despawn(1,0)
		CM[id].VAR.TYRANDE:Despawn(1,0)
	elseif CM[id].VAR.i == 50 then
		pUnit:RemoveEvents()
		pUnit:Despawn(1,0)
	end
end

---------------------------
-- Illidan Cinematic
---------------------------

function CM.VAR.DummySpawnIllidan(pUnit, Event)
	pUnit:RegisterEvent("CM.VAR.CheckStartEventI", 1000, 0)
end

function CM.VAR.CheckStartEventI(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if not plr then
		return
	end
	if plr:GetDistanceYards(pUnit) > 30 then
		return
	end
	pUnit:RemoveEvents()
	pUnit:SpawnCreature(500911, 828.3, 483, 37.4, 6.2226, 14, 0, 18584, 18583, 0) -- illidan
	pUnit:SpawnCreature(791111, 826.63, 495.266, 37.4, 4.04938, 14, 0, 25237, 0, 0)-- sea1
	pUnit:SpawnCreature(791111, 830.5, 465.2, 37.4, 2.62309, 14, 0, 25237, 0, 0)-- sea2
	pUnit:Despawn(1000,0)
end

RegisterUnitEvent(1168652, 18, "CM.VAR.DummySpawnIllidan")

function CM.VAR.IllidanCinematic(pUnit, Event)
	pUnit:SetUInt32Value(0x0006 + 0x0035, 2)
	pUnit:RegisterEvent("CM.VAR.WFAUS", 2000, 0) -- wait for all units
end

function CM.VAR.WFAUS(pUnit)
	local id = pUnit:GetInstanceID() or 1
	CM[id] = CM[id] or {VAR={}}
	local plr = pUnit:GetClosestPlayer()
	if plr and plr:GetDistanceYards(pUnit) < 30 and plr:IsAlive() then
		--if CM[id].VAR.MALFURION and CM[id].VAR.TYRANDE and CM[id].VAR.MAIEV then
		--if CM[id].VAR.TYRANDE:GetDistanceYards(pUnit) < 40 and CM[id].VAR.MALFURION:GetDistanceYards(pUnit) < 40 and CM[id].VAR.MAIEV:GetDistanceYards(pUnit) < 40 then
			pUnit:RemoveEvents()
			CM[id].VAR.IEZ = true
			if CM[id].VAR.MAIEV then
				CM[id].VAR.MAIEV:RemoveEvents()
				CM[id].VAR.MAIEV:Despawn(1,0)
			end
			if CM[id].VAR.TYRANDE then
				CM[id].VAR.TYRANDE:RemoveEvents()
				CM[id].VAR.TYRANDE:Despawn(1,0)
			end
			if CM[id].VAR.MALFURION then
				CM[id].VAR.MALFURION:RemoveEvents()
				CM[id].VAR.MALFURION:Despawn(1,0)
			end
			CM[id].VAR.i = 0
			CM[id].VAR.TYRANDE = pUnit:SpawnCreature(153622, 789, 475, 37.4, 0.2, 35, 0)
			pUnit:RegisterEvent("CM.VAR.IECine", 1000, 0)
		--end
	end
end

function CM.VAR.IECine(pUnit)
	local id = pUnit:GetInstanceID() or 1
	CM[id].VAR.i = CM[id].VAR.i + 1
	if CM[id].VAR.i == 1 then
		CM[id].VAR.TYRANDE:MoveTo(810.2, 479, 37.4, 0.204502)
		pUnit:SetFacing(0.204502 + math.pi)
	elseif CM[id].VAR.i == 2 then
		PlayMessage(pUnit, 24)
	elseif CM[id].VAR.i == 8 then
		PlayMessage(CM[id].VAR.TYRANDE, 25)
	elseif CM[id].VAR.i == 14 then
		PlayMessage(pUnit, 26)
	elseif CM[id].VAR.i == 25 then
		PlayMessage(CM[id].VAR.TYRANDE, 27)
	elseif CM[id].VAR.i == 32 then
		PlayMessage(pUnit, 28)
		CM[id].VAR.MALFURION = pUnit:SpawnCreature(153621, 791, 488, 37.4, 6.1, 35, 0)
	elseif CM[id].VAR.i == 33 then
		CM[id].VAR.MALFURION:MoveTo(809, 484, 37.4, 6.271404)
	elseif CM[id].VAR.i == 42 then
		PlayMessage(pUnit, 29)
		pUnit:SetFacing(6.27 - math.pi)
	elseif CM[id].VAR.i == 46 then
		PlayMessage(CM[id].VAR.MALFURION, 30)
	elseif CM[id].VAR.i == 58 then
		PlayMessage(pUnit, 31)
	elseif CM[id].VAR.i == 61 then
		CM[id].VAR.MAIEV = pUnit:SpawnCreature(231971, 796, 455, 37.4, 0.720997, 35, 0)
	elseif CM[id].VAR.i == 62 then
		CM[id].VAR.MAIEV:EquipWeapons(32425, 0, 0)
		CM[id].VAR.MAIEV:SetUInt32Value(0x0006 + 0x0074, 1)
		CM[id].VAR.MAIEV:MoveTo(811.8, 473, 37.4, 0.581194)
	elseif CM[id].VAR.i == 68 then
		PlayMessage(pUnit, 32)
		pUnit:SetFacing(0.581194 + math.pi)
	elseif CM[id].VAR.i == 74 then
		PlayMessage(CM[id].VAR.MAIEV, 33)
	elseif CM[id].VAR.i == 84 then
		PlayMessage(pUnit, 34)
	elseif CM[id].VAR.i == 96 then
		PlayMessage(pUnit, 2) -- music
		pUnit:CastSpell(39180)
		CM[id].VAR.MAIEV:MoveKnockback(797, 464, 37.4, 2, 3)
		CM[id].VAR.MALFURION:MoveKnockback(810, 479, 37.4, 2, 3)
		CM[id].VAR.TYRANDE:MoveKnockback(809, 484, 37.4, 2, 3)
	elseif CM[id].VAR.i == 97 then
		pUnit:Emote(45, 5000)
		CM[id].VAR.MAIEV:Emote(45, 2000)
		CM[id].VAR.MALFURION:Emote(45, 2000)
		CM[id].VAR.TYRANDE:Emote(45, 2000)
	elseif CM[id].VAR.i == 98 then
		CM[id].VAR.N1 = pUnit:GetCreatureNearestCoords(826, 495, 37, 791111)--pUnit:SpawnCreature(112571, 824, 504, 37.4, 4.074484, 14, 0)
		CM[id].VAR.N2 = pUnit:GetCreatureNearestCoords(830, 465, 37, 791111)--pUnit:SpawnCreature(112571, 835, 461, 37.4, 2.546881, 14, 0)
	elseif CM[id].VAR.i == 99 then
		pUnit:RemoveEvents()
		pUnit:SetUInt32Value(0x0006 + 0x0035, 0)
		pUnit:SetUInt32Value(0x0006 + 0x0074, 1)
		CM[id].VAR.N1:SetUInt32Value(0x0006 + 0x0035, 0)
		CM[id].VAR.N2:SetUInt32Value(0x0006 + 0x0035, 0)
		CM[id].VAR.MAIEV:AttackReaction(pUnit, 100, 0)
		CM[id].VAR.MALFURION:AttackReaction(CM[id].VAR.N1, 100, 0)
		CM[id].VAR.TYRANDE:AttackReaction(CM[id].VAR.N2, 100, 0)
		--pUnit:RegisterEvent("CM.VAR.AI_COMBAT", 1000, 0)
		--pUnit:RegisterEvent("CM.VAR.AI_ILLIDAN_COMBATCHECK", 5000, 0)
		pUnit:AttackReaction(CM[id].VAR.MAIEV, 100, 0)
	end
end

RegisterUnitEvent(500911, 18, "CM.VAR.IllidanCinematic")

---------------------------
-- Illidan Boss
---------------------------

function CM.VAR.AI_ILLIDAN_COMBATCHECK(pUnit)
	local found = false
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		if v:IsAlive() and v:GetDistanceYards(pUnit) < 50 then
			found = true
			if v:GetZ() < 36.8 then
				v:Teleport(429, 815, 478, 37.4)
				v:CastSpell(64446)
			end
		end
	end
	if not found then
		local id = pUnit:GetInstanceID() or 1
		CM[id] = CM[id] or {VAR={}}
		pUnit:RemoveEvents()
		CM[id].VAR.MAIEV:RemoveEvents()
		CM[id].VAR.MALFURION:RemoveEvents()
		CM[id].VAR.TYRANDE:RemoveEvents()
		CM[id].VAR.MAIEV:Despawn(1,0)
		CM[id].VAR.MALFURION:Despawn(1,0)
		CM[id].VAR.TYRANDE:Despawn(1,0)
		CM[id].VAR.MALFURION = pUnit:SpawnCreature(153621, 791, 488, 37.4, 6.1, 35, 0)
		CM[id].VAR.MAIEV = pUnit:SpawnCreature(231971, 796, 455, 37.4, 0.720997, 35, 0, 32425, 0, 0)
		CM[id].VAR.MAIEV:SetUInt32Value(0x0006 + 0x0074, 1)
		CM[id].VAR.TYRANDE = pUnit:SpawnCreature(153622, 789, 475, 37.4, 0.2, 35, 0)
		if CM[id].VAR.N1 then
			CM[id].VAR.N1:Despawn(1,0)
			CM[id].VAR.N1 = pUnit:SpawnCreature(791111, 826, 495, 37, 4.04, 21, 0, 25237, 0, 0)
		end
		if CM[id].VAR.N2 then
			CM[id].VAR.N2:Despawn(1,0)
			CM[id].VAR.N2 = pUnit:SpawnCreature(791111, 830, 465, 37, 2.62, 21, 0, 25237, 0, 0)
		end
		pUnit:SpawnCreature(500911, 828.3, 483, 37.4, 6.2226, 14, 0, 18584, 18583, 0)
		pUnit:Despawn(1,0)
	end
end

---------------------------
-- Illidan Combat
---------------------------

function CM.VAR.IllidanCombat(pUnit, Event)
	pUnit:RegisterEvent("CM.VAR.AI_COMBAT", 1000, 0)
	pUnit:RegisterEvent("CM.VAR.AI_ILLIDAN_COMBATCHECK", 5000, 0)
	pUnit:RegisterEvent("CM.VAR.Immolates", 8000, 0)
	pUnit:RegisterEvent("CM.VAR.FelLightning", 11000, 0)
	pUnit:RegisterEvent("CM.VAR.CheckPHase2", 2000, 0)
end

function CM.VAR.Immolates(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		if v:IsAlive() and v:GetDistanceYards(v) < 6 then
			pUnit:CastSpellOnTarget(50059, v)
		end
	end
end

function CM.VAR.FelLightning(pUnit)
	--PlayMessage(pUnit, math.random(47,55))
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(46479, plr)
	end
end

RegisterUnitEvent(500911, 1, "CM.VAR.IllidanCombat")

function CM.VAR.CheckPHase2(pUnit)
	local id = pUnit:GetInstanceID() or 1
	CM[id] = CM[id] or {VAR={}}
	if (CM[id].VAR.N1 and CM[id].VAR.N1:IsAlive()) or (CM[id].VAR.N2 and CM[id].VAR.N2:IsAlive()) then
		return
	end
	local plr = pUnit:GetClosestPlayer()
	if plr then
		pUnit:AttackReaction(plr, 1, 0)
	end
	pUnit:SetHealth(pUnit:GetMaxHealth())
	pUnit:RemoveEvents()
	CM[id].VAR.MAIEV:RemoveEvents()
	CM[id].VAR.MALFURION:RemoveEvents()
	CM[id].VAR.TYRANDE:RemoveEvents()
	CM[id].VAR.MAIEV:AIDisableCombat(true)
	CM[id].VAR.TYRANDE:AIDisableCombat(true)
	CM[id].VAR.MALFURION:AIDisableCombat(true)
	CM[id].VAR.MAIEV:SetMovementFlags(1)
	CM[id].VAR.MALFURION:SetMovementFlags(1)
	CM[id].VAR.TYRANDE:SetMovementFlags(1)
	CM[id].VAR.MALFURION:MoveTo(749, 481, 28.2, 0)
	CM[id].VAR.TYRANDE:MoveTo(749, 481, 28.2, 0)
	CM[id].VAR.MAIEV:MoveTo(749, 481, 28.2, 0)
	CM[id].VAR.MALFURION:SendChatMessage(14,0,"The naga are attacking from behind! Fight on without us, we shall deal with the naga.")
	CM[id].VAR.MALFURION:Despawn(7000,0)
	CM[id].VAR.TYRANDE:Despawn(1000,0)
	CM[id].VAR.MAIEV:Despawn(7000,0)
	PlayMessage(pUnit, 53)
	PlayMessage(pUnit, 2) -- Repeat music
	pUnit:CastSpell(42459) -- dual weild
	pUnit:RegisterEvent("CM.VAR.AI_ILLIDAN_COMBATCHECK", 5000, 0)
	pUnit:RegisterEvent("CM.VAR.Immolates", 8000, 0)
	pUnit:RegisterEvent("CM.VAR.FelLightning", 11000, 0)
	pUnit:RegisterEvent("CM.VAR.CheckIfIllidanLost", 5000, 0)
	pUnit:RegisterEvent("CM.VAR.PHASETWOREAL", 1000, 0)
	pUnit:RegisterEvent("CM.VAR.BURNINGWINDSRAWR", 31000, 0)
end

function CM.VAR.BURNINGWINDSRAWR(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		pUnit:FullCastSpellOnTarget(17293, plr)
	end
end

function CM.VAR.PHASETWOREAL(pUnit)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		PlayMessage(pUnit, 47)
		pUnit:AIDisableCombat(true)
		pUnit:DisableMelee(true)
		pUnit:MoveTo(811.33, 478.1, 37.4, 0.099697)
		pUnit:RegisterEvent("CM.VAR.LAZORFRIKENBEMS", 5000, 1)
	end
end

function CM.VAR.LAZORFRIKENBEMS(pUnit)
	local u = pUnit:GetCreatureNearestCoords(834.8, 481.4, 39, 1168998)
	if not u then
		print("FATAL ERROR GOD DAMN IT ILLIDAN IN DIRE MAUL!")
		pUnit:Despawn(1,0)
	else
		u:ChannelSpell(52388, pUnit)
		pUnit:ChannelSpell(48048, u)
		pUnit:RegisterEvent("CM.VAR.SPAWNMOARSKULLZ", 7500, 0)
		pUnit:RegisterEvent("CM.VAR.RETURNTONORMAL", 46000, 0)
	end
end

function CM.VAR.SPAWNMOARSKULLZ(pUnit)
	pUnit:SetHealth(pUnit:GetHealth() + 1000)
	local plr = nil
	for i=1,5 do
		plr = pUnit:GetRandomPlayer(0)
		if plr then
			pUnit:SpawnCreature(1168529, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 14, 30000) -- plr:GetLandHeight(plr:GetX()+5, plr:GetY())
		end
	end
end

function CM.VAR.RETURNTONORMAL(pUnit)
	pUnit:RemoveEvents()
	pUnit:AIDisableCombat(false)
	pUnit:DisableMelee(false)
	pUnit:StopChannel()
	PlayMessage(pUnit, 52)
	local u = pUnit:GetCreatureNearestCoords(834.8, 481.4, 39, 1168998)
	if u then
		u:StopChannel()
	end
	pUnit:SetUInt32Value(0x0006 + 0x0037, 500) -- attack speed
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		v:RemoveAura(52388)
	end
	pUnit:RegisterEvent("CM.VAR.AI_ILLIDAN_COMBATCHECK", 5000, 0)
	pUnit:RegisterEvent("CM.VAR.Immolates", 8000, 0)
	pUnit:RegisterEvent("CM.VAR.FelLightning", 11000, 0)
	pUnit:RegisterEvent("CM.VAR.CheckIfIllidanLost", 5000, 0)
	pUnit:RegisterEvent("CM.VAR.PHASE3A", 1000, 0)
	pUnit:RegisterEvent("CM.VAR.BURNINGWINDSRAWR", 31000, 0)
end

function CM.VAR.PHASE3A(pUnit)
	if pUnit:GetHealthPct() < 40 then
		pUnit:RemoveEvents()
		PlayMessage(pUnit, 55)
		pUnit:AIDisableCombat(true)
		pUnit:DisableMelee(true)
		pUnit:MoveTo(811.33, 478.1, 37.4, 0.099697)
		pUnit:RegisterEvent("CM.VAR.ILLIFIRE", 5000, 1)
	end
end

function CM.VAR.ILLIFIRE(pUnit)
	local u = pUnit:GetCreatureNearestCoords(834.8, 481.4, 39, 1168998)
	if not u then
		print("FATAL ERROR GOD DAMN IT ILLIDAN IN DIRE MAUL!")
		pUnit:Despawn(1,0)
	else
		u:ChannelSpell(52388, pUnit)
		pUnit:ChannelSpell(48048, u)
		pUnit:RegisterEvent("CM.VAR.RETURNTONORMAL2", 46000, 0)
		pUnit:RegisterEvent("CM.VAR.DamageNearbyPlayers", 4000, 0)
		pUnit:SetPhase(3)
		pUnit:CastSpell(63364)
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 1168999 then
				v:SetUInt32Value(0x0006 + 0x0035, 33554432)
				v:SetPhase(1)
			end
		end
	end
end

function CM.VAR.DamageNearbyPlayers(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		if v:IsAlive() then
			if v:GetZ() < 37.2 then
				v:CastSpell(11)
			end
		end
	end
end

function CM.VAR.BlazeSpawn(pUnit)
	pUnit:RegisterEvent("CM.VAR.BlazeVisual", 1500, 0)
	pUnit:AIDisableCombat(true)
end

function CM.VAR.BlazeVisual(pUnit)
	if pUnit:GetPhase() == 2 then
		return
	end
	pUnit:CastSpell(40610)
	pUnit:SetMovementFlags(1)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(v) < 8 then
			pUnit:Strike(v, 2, 695, 150, 150, 0.1)
		end
	end
end

RegisterUnitEvent(1168999, 18, "CM.VAR.BlazeSpawn")

function CM.VAR.RETURNTONORMAL2(pUnit)
	pUnit:RemoveEvents()
	for _,v in pairs(pUnit:GetInRangeUnits()) do
		if v:GetEntry() == 1168999 then
			v:SetPhase(2)
		end
	end
	pUnit:RemoveAura(63364)
	pUnit:AIDisableCombat(false)
	pUnit:DisableMelee(false)
	pUnit:StopChannel()
	PlayMessage(pUnit, 49)
	local u = pUnit:GetCreatureNearestCoords(834.8, 481.4, 39, 1168998)
	if u then
		u:StopChannel()
	end
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		v:RemoveAura(52388)
	end
	pUnit:RegisterEvent("CM.VAR.AI_ILLIDAN_COMBATCHECK", 5000, 0)
	pUnit:RegisterEvent("CM.VAR.Immolates", 8000, 0)
	pUnit:RegisterEvent("CM.VAR.FelLightning", 11000, 0)
	pUnit:RegisterEvent("CM.VAR.CheckIfIllidanLost", 5000, 0)
	pUnit:RegisterEvent("CM.VAR.BURNINGWINDSRAWR", 28000, 0)
end

function CM.VAR.CheckIfIllidanLost(pUnit)
	if pUnit:GetHealthPct() < 10 then
		pUnit:RemoveEvents()
		local id = pUnit:GetInstanceID() or 1
		CM[id].VAR.Ending = true
		CM[id].VAR.i = 0
		CM[id].VAR.MALFURION = pUnit:SpawnCreature(153621, 791, 488, 37.4, 6.1, 35, 0)
		CM[id].VAR.MAIEV = pUnit:SpawnCreature(231971, 796, 455, 37.4, 0.720997, 35, 0, 32425, 0, 0)
		pUnit:CastSpell(71400)
		pUnit:Despawn(1000, 0)
	end
end

---------------------------
-- Outro
---------------------------

function CM.VAR.EndingTyrande(pUnit)
	local id = pUnit:GetInstanceID() or 1
	CM[id].VAR.i = CM[id].VAR.i + 1
	if CM[id].VAR.i == 1 then
		PlayMessage(CM[id].VAR.MAIEV, 35)
	elseif CM[id].VAR.i == 5 then
		PlayMessage(pUnit, 36)
	elseif CM[id].VAR.i == 12 then
		PlayMessage(CM[id].VAR.MAIEV, 37)
	elseif CM[id].VAR.i == 17 then
		PlayMessage(pUnit, 38)
	elseif CM[id].VAR.i == 19 then
		pUnit:RemoveEvents()
		pUnit:SpawnGameObject(191349, 816, 482, 37.2, 3.132372, 0, 140)
	end
end

---------------------------
-- Sea Giant
---------------------------

function CM.VAR.SeaGiant(pUnit, Event)
	if Event == 1 then
		pUnit:RegisterEvent("CM.VAR.SeaGiantAI", math.random(6000, 8000), 0)
	elseif Event == 18 then
		pUnit:SetUInt32Value(0x0006 + 0x0035, 2)
		pUnit:SetUInt32Value(0x0006 + 0x0074, 1)
	else
		pUnit:RemoveEvents()
	end
end

function CM.VAR.SeaGiantAI(pUnit)
	local id = pUnit:GetInstanceID() or 1
	CM[id] = CM[id] or {VAR={}}
	if CM[id].VAR.N1 and CM[id].VAR.N2 and CM[id].VAR.N1:IsAlive() and CM[id].VAR.N2:IsAlive() then
		if not CM[id].VAR.N1:HasAura(39872) and not CM[id].VAR.N2:HasAura(39872) then
			if math.random(1,2) == 1 then
				CM[id].VAR.N1:CastSpell(39872)
			else
				CM[id].VAR.N2:CastSpell(39872)
			end
		end
	end
	local chance = math.random(1,3)
	if chance == 1 then
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			if v:GetDistanceYards(pUnit) < 7 then
				v:CastSpell(38353)
			end
		end
	elseif chance == 2 then
		local t = pUnit:GetMainTank()
		if t then
			pUnit:FullCastSpellOnTarget(835, t)
		end
	elseif chance == 3 then
		pUnit:FullCastSpell(73795)
	end
	local t = CM[id].VAR.N1
	if tostring(CM[id].VAR.N1) == tostring(pUnit) then
		t = CM[id].VAR.N2
	end
	if t and t:IsAlive() and t:GetDistanceYards(pUnit) < 20 then
		pUnit:CastSpell(72148)
		t:CastSpell(72148)
		if math.random(1,4) == 1 then
			pUnit:SendChatMessage(14,0,"Brother, I see you are wounded! We shall prevail!")
		end
	end
end

RegisterUnitEvent(791111, 1, "CM.VAR.SeaGiant")
RegisterUnitEvent(791111, 2, "CM.VAR.SeaGiant")
RegisterUnitEvent(791111, 4, "CM.VAR.SeaGiant")
RegisterUnitEvent(791111, 18, "CM.VAR.SeaGiant")

---------------------------
-- First Boss Crystals
---------------------------

function CM.VAR.CrystalActivate(obj, ev, plr)
	if not plr then
		print("Attempt to index plr a nil value: zzzCoTDM.lua")
		return
	end
	local id = plr:GetInstanceID() or 1
	CM[id] = CM[id] or {VAR={}}
	if not CM[id].VAR.DownBarrier then
		CM[id].VAR.DownBarrier = obj:GetEntry()
	else
		if obj:GetEntry() ~= CM[id].VAR.DownBarrier then
			CM[id].VAR.DownBarrier = nil
			local ob = plr:GetGameObjectNearestCoords(-39, 813.8, -27.3, 179503)
			if ob then
				ob:SetByte(0x0006 + 0x000B, 0, 0) -- open
				ob:Despawn(5000, 0)
			end
		end
	end
	obj:SetUInt32Value(0x0006 + 0x0003, 0x1) -- untargetable
	obj:Despawn(10000, 0)
end

RegisterGameObjectEvent(179504, 4, "CM.VAR.CrystalActivate")
RegisterGameObjectEvent(179505, 4, "CM.VAR.CrystalActivate")

---------------------------
-- First Boss
---------------------------

function CM.VAR.FBEvs(pUnit, Event)
	if Event == 1 then
		pUnit:RegisterEvent("CM.VAR.RAWRb", 20000, 0)
		pUnit:RegisterEvent("CM.VAR.CrunchArmor", 15000, 0)
		pUnit:RegisterEvent("CM.VAR.StingR", 8000, 0)
		pUnit:RegisterEvent("CM.VAR.SpawnSkulls", 9000, 0)
	else
		pUnit:RemoveEvents()
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 1168529 then
				v:RemoveEvents()
				v:Despawn(1,0)
			end
		end
	end
end

function CM.VAR.SpawnSkulls(pUnit)
	local plr = nil
	for i=1,5 do
		plr = pUnit:GetRandomPlayer(7)
		if not plr then
			plr = pUnit:GetRandomPlayer(0)
		end
		if plr then
			pUnit:SpawnCreature(1168529, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 14, 60000) -- plr:GetLandHeight(plr:GetX()+5, plr:GetY())
		end
	end
end

function CM.VAR.RAWRb(pUnit)
	pUnit:FullCastSpell(6605)
end

function CM.VAR.CrunchArmor(pUnit)
	local t = pUnit:GetMainTank()
	if t then
		t:CastSpell(64002)
	end
	if pUnit:GetHealthPct() < 10 and not pUnit:HasAura(70371) then
		pUnit:FullCastSpell(70371) -- ENRAGE
	else
		pUnit:FullCastSpell(59197)
	end
end

function CM.VAR.StingR(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		pUnit:FullCastSpellOnTarget(36659, v)
	end
end

RegisterUnitEvent(11496, 1, "CM.VAR.FBEvs")
RegisterUnitEvent(11496, 2, "CM.VAR.FBEvs")
RegisterUnitEvent(11496, 4, "CM.VAR.FBEvs")

function CM.VAR.SkullSpawn(pUnit, Event)
	if Event == 18 then
		pUnit:RegisterEvent("CM.VAR.SetupSkull", 1000, 1)
		pUnit:RegisterEvent("CM.VAR.DMEOJSVL", 1000, 0)
	else
		pUnit:RemoveEvents()
		pUnit:Despawn(1,0)
	end
end

function CM.VAR.SetupSkull(pUnit)
	pUnit:CastSpell(69663) -- visual
	pUnit:AIDisableCombat(true)
end

function CM.VAR.DMEOJSVL(pUnit)
	local t = pUnit:GetClosestPlayer()
	if t and t:IsAlive() then
		pUnit:MoveTo(t:GetX()+10, t:GetY(), t:GetZ(), 0)
		pUnit:FullCastSpellOnTarget(38989, t)
	end
end

RegisterUnitEvent(1168529, 18, "CM.VAR.SkullSpawn")
RegisterUnitEvent(1168529, 2, "CM.VAR.SkullSpawn")
RegisterUnitEvent(1168529, 4, "CM.VAR.SkullSpawn")

---------------------------
-- Third Boss
---------------------------

function CM.VAR.TBossEs(pUnit, Event)
	if Event == 1 then
		pUnit:SendChatMessage(14,0,"Flood of the Deep, take you!")
		pUnit:PlaySoundToSet(11321)
		pUnit:RegisterEvent("CM.VAR.SummonAddsTB", 21000, 0)
		pUnit:RegisterEvent("CM.VAR.StompTav", 10000, 0)
		pUnit:RegisterEvent("CM.VAR.MassiveStomp", 60000, 0)
		pUnit:RegisterEvent("CM.VAR.bFearRandomPlayers", 8000, 0)
		pUnit:RegisterEvent("CM.VAR.RandomMessagesB", 18000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 3 then
		pUnit:CastSpell(72148) -- enrage
		pUnit:CastSpell(70371) -- enrage 2
	elseif Event == 4 then
		pUnit:RemoveEvents()
		local obj = pUnit:GetGameObjectNearestCoords(385.327, 374.232, -1.34314, 177219)
		if obj then
			obj:SetByte(0x0006+0x000B,0,0)
		end
		pUnit:SendChatMessage(14,0,"Great... currents of... Ageon.")
		pUnit:PlaySoundToSet(11329)
	end
end

function CM.VAR.RandomMessagesB(pUnit)
	local c = math.random(1,3)
	if c == 1 then
		pUnit:SendChatMessage(14,0,"Struggling only makes it worse.")
		pUnit:PlaySoundToSet(11327)
	elseif c == 2 then
		pUnit:SendChatMessage(14,0,"It is done!")
		pUnit:PlaySoundToSet(11326)
	elseif c == 3 then
		pUnit:SendChatMessage(14,0,"By the Tides!")
		pUnit:PlaySoundToSet(11322)
	end
end

function CM.VAR.bFearRandomPlayers(pUnit)
	local t = pUnit:GetRandomPlayer(7)
	if t then
		t:CastSpell(62628)
	end
end

function CM.VAR.MassiveStomp(pUnit)
	pUnit:SendChatMessage(42,0,"Morogrim prepares to do a massive \124cffffd000\124Hspell:41534\124h[War Stomp]\124h\124r!")
	pUnit:RegisterEvent("CM.VAR.MassActuallyHappens", 5000, 1)
end

function CM.VAR.MassActuallyHappens(pUnit)
	pUnit:FullCastSpell(41534)
	pUnit:SendChatMessage(14,0,"Only the strong survive.")
	pUnit:PlaySoundToSet(11328)
end

function CM.VAR.StompTav(pUnit)
	local t = pUnit:GetMainTank()
	if t then
		pUnit:FullCastSpellOnTarget(55196, t)
	end
end

function CM.VAR.SummonAddsTB(pUnit)
	local c = math.random(1,3)
	if c == 1 then
		pUnit:SendChatMessage(14,0,"Destroy them my subjects!")
		pUnit:PlaySoundToSet(11323)
	elseif c == 2 then
		pUnit:SendChatMessage(14,0,"Soon it will be finished!")
		pUnit:PlaySoundToSet(11325)
	elseif c == 3 then
		pUnit:SendChatMessage(14,0,"There is nowhere to hide!")
		pUnit:PlaySoundToSet(11324)
	end
	local plr = pUnit:GetRandomPlayer(7)
	if not plr then
		plr = pUnit:GetRandomPlayer(0)
	end
	if plr then
		local x,y,z = plr:GetX(), plr:GetY(), plr:GetZ()
		local r = math.pi/2
		pUnit:SpawnCreature(542681, x+10, y, z, 0, 35, 20000)
		pUnit:SpawnCreature(542681, x, y+10, z, r, 35, 20000)
		pUnit:SpawnCreature(542681, x-10, y, z, math.pi, 35, 20000)
		pUnit:SpawnCreature(542681, x, y-10, z, math.pi+r, 35, 20000)
	end
end

RegisterUnitEvent(21213, 1, "CM.VAR.TBossEs")
RegisterUnitEvent(21213, 2, "CM.VAR.TBossEs")
RegisterUnitEvent(21213, 3, "CM.VAR.TBossEs")
RegisterUnitEvent(21213, 4, "CM.VAR.TBossEs")

function CM.VAR.WaterGobduleSpawn(pUnit, Event)
	pUnit:SetUInt32Value(0x0006 + 0x0035, 33554432)
	pUnit:RegisterEvent("CM.VAR.WalkTowardsNearestPlayer", 1000, 0)
	pUnit:RegisterEvent("CM.VAR.VisualSpawne", 1000, 1)
end

function CM.VAR.VisualSpawne(pUnit)
	pUnit:CastSpell(54268)
	pUnit:SetMovementFlags(1)
end

function CM.VAR.WalkTowardsNearestPlayer(pUnit)
	local t = pUnit:GetClosestPlayer()
	if not t then
		pUnit:RemoveEvents()
		pUnit:Despawn(1,0)
	end
	if not t:IsAlive() then
		t = pUnit:GetRandomPlayer(0)
	end
	if t then
		pUnit:MoveTo(t:GetX(), t:GetY(), t:GetZ(), 0)
		if pUnit:GetDistanceYards(t) < 3.7 then
			pUnit:SetFaction(14)
			pUnit:Strike(t, 2, 695, 150, 200, 0.1)
			pUnit:RemoveEvents()
			pUnit:Kill(pUnit)
		end
	end
end

RegisterUnitEvent(542681, 18, "CM.VAR.WaterGobduleSpawn")

---------------------------
-- Trash
---------------------------

--[[function CM.VAR.IntroNaga(pUnit)
	PlayMessage(pUnit, 42)
end

function CM.VAR.ExtraNagaMessage(pUnit)
	local id = pUnit:GetInstanceID() or 1
	PlayMessage(CM.VAR.TYRANDE, 39)
end]]

function CM.VAR.NagaEvents(pUnit, Event)
	if Event == 1 then
		--[[local id = pUnit:GetInstanceID() or 1
		CM[id] = CM[id] or {VAR={}}
		if not CM.VAR.pn then
			local p = pUnit:GetClosestPlayer()
			if p and p:GetDistanceYards(pUnit) < 50 then
				CM.VAR.pn = true
				PlayMessage(CM.VAR.TYRANDE, 46)
				pUnit:RegisterEvent("CM.VAR.IntroNaga", 4000, 1)
				pUnit:RegisterEvent("CM.VAR.ExtraNagaMessage", 10000, 1)
			end
		end]]
		if pUnit:GetEntry() == 112571 then -- warrior
			--[[local t = pUnit:GetSelection()
			if t and not t:IsPlayer() then
				if t:GetEntry() == 133271 then
					return
				end
			end]]
			if math.random(1,80) == 1 then
				PlayMessage(pUnit, 42)
			end
			if math.random(1,2) == 1 then
				for _,v in pairs(pUnit:GetInRangeUnits()) do
					if not v:IsInCombat() then
						if v:GetDistanceYards(pUnit) < 30 then
							v:AttackReaction(pUnit:GetSelection(), 1, 0)
						end
					end
				end
			end
			if math.random(1,2) == 1 then
				local t = pUnit:GetMainTank()
				if t then
					pUnit:FullCastSpellOnTarget(40602, t) -- charge
				else
					pUnit:CastSpell(27578)
				end
			end
			pUnit:RegisterEvent("CM.VAR.MeleeAI", 7000, 0)
		else
			if math.random(1,10) == 1 then
				pUnit:SendChatMessage(14,0,"You cannot harm us!")
			end
			if math.random(1,2) == 1 then
				pUnit:FullCastSpell(12544)
			else
				pUnit:FullCastSpell(35064)
			end
			pUnit:RegisterEvent("CM.VAR.CasterNaga", 6000, 0)
		end
	else
		pUnit:RemoveEvents()
	end
end

function CM.VAR.CasterNaga(pUnit)
	if pUnit:IsCasting() then
		return
	end
	for _,v in pairs(pUnit:GetInRangeUnits()) do
		if v:GetHealthPct() < 70 then
			pUnit:FullCastSpellOnTarget(48894,v)
			return
		end
	end
	local t = pUnit:GetMainTank()
	if t then
		pUnit:FullCastSpellOnTarget(16799,t)
	end
end

function CM.VAR.MeleeAI(pUnit)
	local t = pUnit:GetMainTank()
	if not t then
		return
	end
	if t:GetDistanceYards(pUnit) > 6 then
		return
	end
	if math.random(1,2) == 1 then
		pUnit:FullCastSpellOnTarget(69651, t)
	else
		pUnit:FullCastSpellOnTarget(60590, t)
	end
end

RegisterUnitEvent(112571, 1, "CM.VAR.NagaEvents")
RegisterUnitEvent(112571, 2, "CM.VAR.NagaEvents")
RegisterUnitEvent(112571, 4, "CM.VAR.NagaEvents")
RegisterUnitEvent(112572, 1, "CM.VAR.NagaEvents")
RegisterUnitEvent(112572, 2, "CM.VAR.NagaEvents")
RegisterUnitEvent(112572, 4, "CM.VAR.NagaEvents")

function CM.VAR.SentinelS(pUnit, Event)
	pUnit:RegisterEvent("CM.VAR.AttNeaNaga", 1000, 0)
end

function CM.VAR.AttNeaNaga(pUnit)
	if pUnit:IsInCombat() then
		local plr = pUnit:GetClosestPlayer()
		if plr and pUnit:GetDistanceYards(plr) < 40 then
			pUnit:RemoveEvents()
			return
		end
		local t = pUnit:GetSelection()
		if t then
			if t:GetHealthPct() < 50 then
				t:SetHealth(t:GetMaxHealth())
			end
		end
		if pUnit:GetHealthPct() < 50 then
			pUnit:SetHealth(pUnit:GetMaxHealth())
		end
	else
		local distance = 5000
		local t = nil
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 112571 or v:GetEntry() == 112572 and not v:IsInCombat() then
				local d = pUnit:GetDistanceYards(v)
				if d < distance then
					distance = d
					t = v
				end
			end
		end
		if t then
			pUnit:AttackReaction(t, 1, 0)
			t:AttackReaction(pUnit, 1, 0)
		end
	end
end

RegisterUnitEvent(133271, 18, "CM.VAR.SentinelS")

---------------------------
-- More generic naga trash
---------------------------

function CM.VAR.GenericTrash(pUnit, Event)
	if Event == 1 then
		local entry = pUnit:GetEntry()
		if entry == 21218 then -- shield
			pUnit:RegisterEvent("CM.VAR.ShieldSlam", 8000, 0)
			pUnit:RegisterEvent("CM.VAR.ShieldSlamStun", 10000, 0)
		elseif entry == 21873 then -- polearm
			pUnit:RegisterEvent("CM.VAR.CrippleT", 9000, 0)
			pUnit:RegisterEvent("CM.VAR.SuperWeakRip", 12000, 0)
		elseif entry == 22055 then -- two 1h
			pUnit:RegisterEvent("CM.VAR.BashT", 10000, 0)
			pUnit:RegisterEvent("CM.VAR.CrushT", 14000, 0)
		end
	else
		pUnit:RemoveEvents()
	end
end

function CM.VAR.ShieldSlam(pUnit)
	local t = pUnit:GetMainTank()
	if t then
		pUnit:CastSpellOnTarget(23922, t)
	end
end

function CM.VAR.ShieldSlamStun(pUnit)
	local t = pUnit:GetMainTank()
	if t then
		pUnit:CastSpellOnTarget(8242, t)
	end
end

function CM.VAR.CrippleT(pUnit)
	local t = pUnit:GetMainTank()
	if t then
		pUnit:FullCastSpellOnTarget(31406, t)
	end
end

function CM.VAR.SuperWeakRip(pUnit)
	local t = pUnit:GetMainTank()
	if t then
		pUnit:FullCastSpellOnTarget(33912, t)
	end
end

function CM.VAR.BashT(pUnit)
	local t = pUnit:GetMainTank()
	local p = pUnit:GetRandomPlayer(7)
	if p and t then
		pUnit:FullCastSpellOnTarget(25515, t)
		pUnit:WipeThreatList()
		pUnit:AttackReaction(p, 100000, 0)
	end
end

function CM.VAR.CrushT(pUnit)
	local t = pUnit:GetMainTank()
	if t then
		pUnit:FullCastSpellOnTarget(59330, t)
	end
end

RegisterUnitEvent(21873, 1, "CM.VAR.GenericTrash")
RegisterUnitEvent(21873, 2, "CM.VAR.GenericTrash")
RegisterUnitEvent(21873, 4, "CM.VAR.GenericTrash")
RegisterUnitEvent(22055, 1, "CM.VAR.GenericTrash")
RegisterUnitEvent(22055, 2, "CM.VAR.GenericTrash")
RegisterUnitEvent(22055, 4, "CM.VAR.GenericTrash")
RegisterUnitEvent(21218, 1, "CM.VAR.GenericTrash")
RegisterUnitEvent(21218, 2, "CM.VAR.GenericTrash")
RegisterUnitEvent(21218, 4, "CM.VAR.GenericTrash")
