

function Krendal_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("ZGhostEffectz",1200,1)
end

function ZGhostEffectz(pUnit,Event)
	pUnit:CastSpell(44816)
end

RegisterUnitEvent(78963, 18, "Krendal_OnSpawn")

function Zorbosaucedgnome_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(847331, player, 0)
	if player:HasQuest(3030) then
		if player:HasFinishedQuest(3031) == false then
			if player:HasQuest(3031) == false then
				pUnit:GossipMenuAddItem(0, "Lakeshire residents need to be evacuated and Jane needs your help.", 249, 0)
			end
			if player:HasItem(24428) == true then
				pUnit:GossipMenuAddItem(0, "I have the elixir you wanted.", 246, 0)
			end
		end
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
    pUnit:GossipSendMenu(player)
end

function Zorbosaucedgnome_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
if player:HasQuest(3030) then
	player:RemoveItem(24428,1)
	player:AdvanceQuestObjective(3030,0) -- complete
	player:FinishQuest(3031)
	player:GossipComplete()
end
end


if(intid == 249) then
player:StartQuest(3031)
pUnit:GossipCreateMenu(847330, player, 0)
pUnit:GossipMenuAddItem(0, "Ok.", 250, 0)
pUnit:GossipSendMenu(player)
end

if(intid == 250) then
player:GossipComplete()
end
end






RegisterUnitGossipEvent(78963, 1, "Zorbosaucedgnome_On_Gossip")
RegisterUnitGossipEvent(78963, 2, "Zorbosaucedgnome_Gossip_Submenus")