local MonGiefCannon_EntryIDZomg = 90515
local LOL = nil

function ZIWQQWQDW_Cannon_EEAOnSpawn(pUnit, event)
	Quezt_ZomgAACannon = pUnit
	Quezt_ZomgAACannon:Root()
end

RegisterUnitEvent(MonGiefCannon_EntryIDZomg, 18, "ZIWQQWQDW_Cannon_EEAOnSpawn")

function CWEIHOCEWW_Cannon_GossipNonUsePewPew(pUnit, event, player, pMisc)
	if (player:HasQuest(90510) == true) then
		if (player:GetQuestObjectiveCompletion(90510, 0) == 1) then
			player:SendAreaTriggerMessage("|CFFff0000Cannon is not loaded!|R")
		else
			Quezt_ZomgAACannon:CastSpellAoF(1218.429321, -2223.625732, 70.249329, 52539)
			player:AdvanceQuestObjective(90510, 0)
			if LOL ~= nil then
				LOL:RegisterEvent("TEST_TEST_TEST_TEST_TESTTEST_TEST_TEST_TEST_TESTTEST_TEST_TEST_TEST_TEST", 2500, 1)
			end
		end
	else
		player:SendAreaTriggerMessage("|CFFff0000Cannon is not loaded!|R")
	end
end

RegisterUnitGossipEvent(MonGiefCannon_EntryIDZomg, 1, "CWEIHOCEWW_Cannon_GossipNonUsePewPew")

function ajutogehjaogheghea_OnSpawn(pUnit, Event)
	LOL = pUnit
end

RegisterUnitEvent(1168611, 18, "ajutogehjaogheghea_OnSpawn")

function TEST_TEST_TEST_TEST_TESTTEST_TEST_TEST_TEST_TESTTEST_TEST_TEST_TEST_TEST(pUnit, Event)
	LOL:CastSpell(46225)
	for k,unit in pairs(LOL:GetInRangeUnits()) do
		if unit:GetDistanceYards(LOL) < 50 then
			local choice = math.random(1,3)
			if choice == 1 then
				unit:MoveKnockback(1215, -2170, 52, 7, 11)
			elseif choice == 2 then
				unit:MoveKnockback(1179, -2171, 52, 6, 10)
			elseif choice == 3 then
				unit:MoveKnockback(1258, -2174, 52, 5, 9)
			end
			unit:Despawn(6000, 20000)
		end
	end
end