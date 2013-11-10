
local elune = nil

function Elunes_Priestess_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(758, player, 0)
   		if player:HasQuest(855) == true then
		pUnit:GossipMenuAddItem(0, "I come with an offering to elune.", 200, 0)
		end
   pUnit:GossipMenuAddItem(0, "I was just leaving.", 247, 0)
   pUnit:GossipSendMenu(player)
end


function Elunes_Priestess_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 200) then
	elune = pUnit
	elune:PlaySoundToSet(14884)
	elune:SpawnCreature(363963, 7849.9, -2213, 472, 4.166296, 35, 90000)
	elune:SendChatMessage(12,0,"This is no offering, you slay the protectors of the forest!")
	player:GossipComplete()
	end
	if(intid == 247) then
	player:GossipComplete()
	end
end

RegisterUnitGossipEvent(12116, 1, "Elunes_Priestess_On_Gossip")
RegisterUnitGossipEvent(12116, 2, "Elunes_Priestess_Submenus")

function elune_invisible_trigger_Spawn(pUnit, Event)
	pUnit:SetFaction(35)
	pUnit:RegisterEvent("elune_lolcake", 1000, 1)
end

function elune_lolcake(pUnit, Event)
	pUnit:SetScale(1)
	pUnit:SetFaction(20)
	pUnit:CastSpell(32475)
	pUnit:RegisterEvent("elune_lolcakelolcake", 1000, 3)
end

function elune_lolcakelolcake(pUnit, Event)
	pUnit:CastSpell(32475)
end

RegisterUnitEvent(363963, 18, "elune_invisible_trigger_Spawn")


