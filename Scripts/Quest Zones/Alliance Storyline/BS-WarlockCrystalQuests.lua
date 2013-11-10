--[[ Destroy the Crystal! ]]--

function WarlockCrystal_OnGossip(pUnit, event, player)
	pUnit:GossipCreateMenu(2511, player, 0)
	if player:HasQuest(22) then
		pUnit:GossipMenuAddItem(0, "Destroy the Warlock Crystal!", 8, 0)
		pUnit:GossipMenuAddItem(0, "Don't destroy the Crystal.", 3, 0)
	else
		pUnit:GossipMenuAddItem(0, "Don't destroy the Crystal.", 3, 0)
		pUnit:GossipMenuAddItem(0, "Nevermind.", 3, 0)
	end
	pUnit:GossipSendMenu(player)
end

function WarlockCrystal_GossipSubmenus(pUnit, event, player, id, intid, code)
	if(intid == 8) then
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			if v:HasQuest(22) and v:GetDistanceYards(pUnit) < 20 then
				v:MarkQuestObjectiveAsComplete(22, 0)
			end
		end
		player:GossipComplete()
		pUnit:SetHealth(1)
		pUnit:CastSpell(11)
	elseif(intid == 3) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(50025, 1, "WarlockCrystal_OnGossip")
RegisterUnitGossipEvent(50025, 2, "WarlockCrystal_GossipSubmenus")

function WarlockTwilight_Gnome(pUnit, Event)
	if Event == 1 then
		pUnit:RegisterEvent("castAGeneralWarlockSpell", math.random(4000,12000), 1)
	else
		pUnit:RemoveEvents()
	end
end

function castAGeneralWarlockSpell(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		if math.random(1,2) == 1 then
			pUnit:FullCastSpellOnTarget(348, plr)
		else
			pUnit:FullCastSpellOnTarget(686, plr)
		end
	end
end

RegisterUnitEvent(326211, 1, "WarlockTwilight_Gnome")
RegisterUnitEvent(326211, 2, "WarlockTwilight_Gnome")
RegisterUnitEvent(326211, 4, "WarlockTwilight_Gnome")