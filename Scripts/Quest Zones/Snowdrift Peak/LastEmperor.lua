local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local em = 0
local Q920074Ready = false

--69859, 70108


function Emperor_OnSpawn(pUnit,Event)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 8)
pUnit:CastSpell(53708)
pUnit:RegisterEvent("TheEmperor_VariableCheck", 1500, 0)
end

RegisterUnitEvent(947041, 18, "Emperor_OnSpawn")


function TheEmperor_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(521, player, 0)
	if player:HasQuest(920074) then
		if (player:GetQuestObjectiveCompletion(920074, 0) == 0) then
			pUnit:GossipMenuAddItem(0, "I seek your wisdom of the sha, Emperor.", 246, 0)
		end
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end



function TheEmperor_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
pUnit:SetNPCFlags(8)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
 Q920074Ready = true
	player:GossipComplete()
elseif(intid == 250) then
player:GossipComplete()
end
end


function TheEmperor_VariableCheck(pUnit,Event)
if Q920074Ready == true then
pUnit:RemoveEvents()
pUnit:CastSpell(52233)
pUnit:RegisterEvent("TheEmperor_Talking", 1500, 1)
em = 0
end
	end
	
	
	function TheEmperor_Talking(pUnit)
	em = em + 1
	if em == 1 then
	pUnit:PlaySoundToSet(50100)
	pUnit:SendChatMessage(12,0,"The realm you see all around you was mine to command.")
pUnit:RegisterEvent("TheEmperor_Talking", 6100, 1)
pUnit:Emote(1,6000)
	elseif em == 2 then
	pUnit:Emote(1,8000)
	pUnit:PlaySoundToSet(50101)
	pUnit:SendChatMessage(12,0,"I conquered my doubts, my fears, my anger... I buried all of it within the land.")
	pUnit:RegisterEvent("TheEmperor_Talking", 8100, 1)
	elseif em == 3 then
	pUnit:Emote(1,8000)
	pUnit:PlaySoundToSet(50102)
		pUnit:SendChatMessage(12,0,"But I held on to one vice. The one sha I never conquered. PRIDE.")
		pUnit:RegisterEvent("TheEmperor_Talking", 8100, 1)
	elseif em == 4 then
	pUnit:Emote(1,8000)
	pUnit:PlaySoundToSet(50103)
		pUnit:SendChatMessage(12,0,"My pride cloaked this land in mists! I thought we were better than the rest of the world.")
		pUnit:RegisterEvent("TheEmperor_Talking", 8100, 1)
	elseif em == 5 then
	pUnit:Emote(1,14000)
	pUnit:PlaySoundToSet(50104)
		pUnit:SendChatMessage(12,0,"I thought we could solve our own problems. But for ten thousand years, we stagnated, our doubts and fears buried in the land, rising up to fester whenever we allowed them.")
			pUnit:RegisterEvent("TheEmperor_Talking", 14100, 1)
			elseif em == 6 then
			pUnit:Emote(1,6000)
		pUnit:SendChatMessage(12,0,"We locked them away in the vaults of Azjol, tasking the Nerubians to watch over them.")
			pUnit:RegisterEvent("TheEmperor_Talking", 6100, 1)
			elseif em == 7 then
			pUnit:Emote(1,12000)
			pUnit:PlaySoundToSet(50105)
		pUnit:SendChatMessage(12,0," Pride. It is the most insidious of sha. It is good until it is bad. And then it is more dangerous than all the others combined.")
			pUnit:RegisterEvent("TheEmperor_Talking", 12100, 1)
			elseif em == 8 then
			pUnit:Emote(1,14000)
			pUnit:PlaySoundToSet(50106)
		pUnit:SendChatMessage(12,0," Beware of Pride! Be humble! The world is plunging into chaos. Old enemies must work together. Proud races must admit they need help.")
			pUnit:RegisterEvent("TheEmperor_Talking", 14100, 1)
			elseif em == 9 then
			pUnit:Emote(1,9000)
			pUnit:PlaySoundToSet(50107)
		pUnit:SendChatMessage(12,0,"Things are going to get worse before they get better. Only by working together can we overcome the darkness.")
			pUnit:RegisterEvent("TheEmperor_Talking", 9100, 1)
					elseif em == 10 then
					pUnit:Emote(1,5000)
					pUnit:PlaySoundToSet(50108)
		pUnit:SendChatMessage(12,0,"All that stands in our way... is pride.")
			pUnit:RegisterEvent("TheEmperor_Talking", 4500, 1)
		elseif em == 11 then
		pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 7)
		pUnit:CastSpell(50805)
		pUnit:Despawn(2000,5000)
		 Q920074Ready = false
			for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 40 and players:HasQuest(920074) then
			players:MarkQuestObjectiveAsComplete(920074,0)
		end
	end
		end
	end



RegisterUnitGossipEvent(947041, 1, "TheEmperor_On_Gossip")
RegisterUnitGossipEvent(947041, 2, "TheEmperor_Gossip_Submenus")