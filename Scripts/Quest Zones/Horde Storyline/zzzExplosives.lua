local plr = nil

function Harpoon_Used_Ha(pMisc, Event, player)
	player:CastSpell(16716)
	player:MovePlayerTo(-6737, -1117.9, 259, 0, 12288, 10)
	plr = player
	RegisterTimedEvent("Test_A_TEST_ETSTES_TESJYHSOJH", 100, 3)
end

function Test_A_TEST_ETSTES_TESJYHSOJH(pMisc, Event, player)
	plr:CastSpell(16716)
end

RegisterGameObjectEvent(2905282, 4, "Harpoon_Used_Ha")


function zzHarpoon_Used_Ha(pMisc, Event, player)
	if player:HasQuest(824) == true then
	player:AdvanceQuestObjective(824, 0)
	end
end

RegisterGameObjectEvent(1823000, 4, "zzHarpoon_Used_Ha")