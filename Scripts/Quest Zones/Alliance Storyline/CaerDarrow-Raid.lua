-- Scourges Ambush - Caer Darrow Latest Quest.
-- You will have to stay alive to complete the quest.

ScourgesAmbush = {} -- Main Table.

-- Creatures Death.

ScourgesAmbush.ScourgesKilled = 0
ScourgesAmbush.ScourgesLordWave = 0
ScourgesAmbush.ScourgesWaveyTwo = 0
ScourgesAmbush.ScourgesWaveyThree = 0

-- Coordonates.

-- First Run: 1262.197876, -2561.500732, 110.228584, 3.629264
-- Second Run: 1264.366333, -2569.398193, 110.228584, 5.192202
-- Third Run: 1271.808838, -2571.046631, 110.228996, 5.988852
-- Fourth Run: 1265.707764, -2575.237549, 110.228996, 5.069932

-- High Captain Justin Barlett.

function ScourgesAmbush.HighCaptainJustinBarlettOnSpawn(pUnit, event)
	ScourgesAmbush.CaptainJustinBarlett = pUnit
	pUnit:RegisterEvent("ScourgesAmbush.HighCaptainHeal", 6000, 0)
end

RegisterUnitEvent(30343, 18, "ScourgesAmbush.HighCaptainJustinBarlettOnSpawn")

function ScourgesAmbush.HighCaptainHeal(pUnit, event)
	ScourgesAmbush.CaptainClosestPlayer = nil
	pUnit:RegisterEvent("ScourgesAmbush.CaptainHealClosestPlayer", 1000, 1)
end

function ScourgesAmbush.CaptainHealClosestPlayer(pUnit, event)
	--[[if (pUnit:GetClosestPlayer() ~= nil) then
		ScourgesAmbush.CaptainClosestPlayer = pUnit:GetClosestPlayer()
		if (ScourgesAmbush.CaptainClosestPlayer:GetPhase() == 2) then
			if (ScourgesAmbush.CaptainClosestPlayer:IsAlive() == true) then
				if (ScourgesAmbush.CaptainClosestPlayer:GetHealthPct() <= 70) then
					pUnit:FullCastSpellOnTarget(1026, ScourgesAmbush.CaptainClosestPlayer)
				end
			end
		end
	end]]
end
	
-- Creatures (Scourges) Functions - Animated Bone Warrior.

function ScourgesAmbush.AnimatedBoneWarriorOnSpawn(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.AnimatedBoneWarrior = tostring(pUnit)
		ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior] = {}
		ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior] = pUnit
		ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior]:SetFaction(14)
		ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior]:SetMovementFlags(1)
		ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior]:MoveTo(1262.197876, -2561.500732, 110.228584, 3.629264)
		ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior]:RegisterEvent("ScourgesAmbush.AnimatedBoneWarriorMoveTwo", 3200, 1)
	end
end

function ScourgesAmbush.AnimatedBoneWarriorMoveTwo(pUnit, event)
		ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior]:MoveTo(1264.366333, -2569.398193, 110.228584, 5.192202)
		ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior]:RegisterEvent("ScourgesAmbush.RunThereOrNo", 3200, 1)
end

function ScourgesAmbush.RunThereOrNo(pUnit, event)
	ScourgesAmbush.RunOrNo = math.random(1, 4)
		if (ScourgesAmbush.RunOrNo == 1) then
			ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior]:MoveTo(1271.808838, -2571.046631, 110.228996, 5.988852)
		end
		if (ScourgesAmbush.RunOrNo == 2) then
			ScourgesAmbush[ScourgesAmbush.AnimatedBoneWarrior]:MoveTo(1265.707764, -2575.237549, 110.228996, 5.069932)
		end
end

RegisterUnitEvent(95710, 18, "ScourgesAmbush.AnimatedBoneWarriorOnSpawn")

-- Animated Bone Warriors on Death.

function ScourgesAmbush.AnimatedBoneWarriorOnDeath(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.ScourgesKilled = ScourgesAmbush.ScourgesKilled + 1
	end
end

RegisterUnitEvent(95710, 4, "ScourgesAmbush.AnimatedBoneWarriorOnDeath")

-- Creatures (Scourges) Functions - Risen Abberation.

function ScourgesAmbush.RisenAbberationOnSpawn(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.RisenAbberation = tostring(pUnit)
		ScourgesAmbush[ScourgesAmbush.RisenAbberation] = {}
		ScourgesAmbush[ScourgesAmbush.RisenAbberation] = pUnit
		ScourgesAmbush[ScourgesAmbush.RisenAbberation]:SetFaction(14)
		ScourgesAmbush[ScourgesAmbush.RisenAbberation]:SetMovementFlags(1)
		ScourgesAmbush[ScourgesAmbush.RisenAbberation]:MoveTo(1262.197876, -2561.500732, 110.228584, 3.629264)
		ScourgesAmbush[ScourgesAmbush.RisenAbberation]:RegisterEvent("ScourgesAmbush.RisenAbberationMoveTwo", 3200, 1)
	end
end

function ScourgesAmbush.RisenAbberationMoveTwo(pUnit, event)
		ScourgesAmbush[ScourgesAmbush.RisenAbberation]:MoveTo(1264.366333, -2569.398193, 110.228584, 5.192202)
		ScourgesAmbush[ScourgesAmbush.RisenAbberation]:RegisterEvent("ScourgesAmbush.RunThereOrNoTwo", 3200, 1)
end

function ScourgesAmbush.RunThereOrNoTwo(pUnit, event)
	ScourgesAmbush.RunOrNoTwo = math.random(1, 4)
		if (ScourgesAmbush.RunOrNoTwo == 1) then
			ScourgesAmbush[ScourgesAmbush.RisenAbberation]:MoveTo(1271.808838, -2571.046631, 110.228996, 5.988852)
		end
		if (ScourgesAmbush.RunOrNoTwo == 2) then
			ScourgesAmbush[ScourgesAmbush.RisenAbberation]:MoveTo(1265.707764, -2575.237549, 110.228996, 5.069932)
		end
end

RegisterUnitEvent(96110, 18, "ScourgesAmbush.RisenAbberationOnSpawn")

-- Risen Aberration on Death.

function ScourgesAmbush.RisenAbberationOnDeath(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.ScourgesKilled = ScourgesAmbush.ScourgesKilled + 1
	end
end

RegisterUnitEvent(96110, 4, "ScourgesAmbush.RisenAbberationOnDeath")

-- Creatures (Scourges) Functions - Scholomance Necromancer.

function ScourgesAmbush.ScholomanceNecromancerOnSpawn(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.ScholomanceNecromancer = tostring(pUnit)
		ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer] = {}
		ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer] = pUnit
		ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer]:SetFaction(14)
		ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer]:SetMovementFlags(1)
		ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer]:MoveTo(1262.197876, -2561.500732, 110.228584, 3.629264)
		ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer]:RegisterEvent("ScourgesAmbush.ScholomanceNecromancerMoveTwo", 3200, 1)
	end
end

function ScourgesAmbush.ScholomanceNecromancerMoveTwo(pUnit, event)
		ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer]:MoveTo(1264.366333, -2569.398193, 110.228584, 5.192202)
		ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer]:RegisterEvent("ScourgesAmbush.RunThereOrNoThree", 3200, 1)
end

function ScourgesAmbush.RunThereOrNoThree(pUnit, event)
	ScourgesAmbush.RunOrNoThree = math.random(1, 4)
		if (ScourgesAmbush.RunOrNoThree == 1) then
			ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer]:MoveTo(1271.808838, -2571.046631, 110.228996, 5.988852)
		end
		if (ScourgesAmbush.RunOrNoThree == 2) then
			ScourgesAmbush[ScourgesAmbush.ScholomanceNecromancer]:MoveTo(1265.707764, -2575.237549, 110.228996, 5.069932)
		end
end

RegisterUnitEvent(95850, 18, "ScourgesAmbush.ScholomanceNecromancerOnSpawn")

-- Scholomance Necromancer on Death.

function ScourgesAmbush.ScholomanceNecromancerOnDeath(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.ScourgesKilled = ScourgesAmbush.ScourgesKilled + 1
	end
end

RegisterUnitEvent(95850, 4, "ScourgesAmbush.ScholomanceNecromancerOnDeath")

-- Creatures (Scourges) Functions - Haunted Servitor.

function ScourgesAmbush.HauntedServitorOnSpawn(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.HauntedServitor = tostring(pUnit)
		ScourgesAmbush[ScourgesAmbush.HauntedServitor] = {}
		ScourgesAmbush[ScourgesAmbush.HauntedServitor] = pUnit
		ScourgesAmbush[ScourgesAmbush.HauntedServitor]:SetFaction(14)
		ScourgesAmbush[ScourgesAmbush.HauntedServitor]:SetMovementFlags(1)
		ScourgesAmbush[ScourgesAmbush.HauntedServitor]:MoveTo(1262.197876, -2561.500732, 110.228584, 3.629264)
		ScourgesAmbush[ScourgesAmbush.HauntedServitor]:RegisterEvent("ScourgesAmbush.HauntedServitorMoveTwo", 3200, 1)
	end
end

function ScourgesAmbush.HauntedServitorMoveTwo(pUnit, event)
		ScourgesAmbush[ScourgesAmbush.HauntedServitor]:MoveTo(1264.366333, -2569.398193, 110.228584, 5.192202)
		ScourgesAmbush[ScourgesAmbush.HauntedServitor]:RegisterEvent("ScourgesAmbush.RunThereOrNoFour", 3200, 1)
end

function ScourgesAmbush.RunThereOrNoFour(pUnit, event)
	ScourgesAmbush.RunOrNoFour = math.random(1, 4)
		if (ScourgesAmbush.RunOrNoFour == 1) then
			ScourgesAmbush[ScourgesAmbush.HauntedServitor]:MoveTo(1271.808838, -2571.046631, 110.228996, 5.988852)
		end
		if (ScourgesAmbush.RunOrNoFour == 2) then
			ScourgesAmbush[ScourgesAmbush.HauntedServitor]:MoveTo(1265.707764, -2575.237549, 110.228996, 5.069932)
		end
end

RegisterUnitEvent(3875, 18, "ScourgesAmbush.HauntedServitorOnSpawn")

-- Haunted Servitor on Death.

function ScourgesAmbush.HauntedServitorOnDeath(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.ScourgesKilled = ScourgesAmbush.ScourgesKilled + 1
	end
end

RegisterUnitEvent(3875, 4, "ScourgesAmbush.HauntedServitorOnDeath")

-- Creatures (Scourges) Functions - Cannibal Ghoul.

function ScourgesAmbush.CannibalGhoulOnSpawn(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.CannibalGhoul = tostring(pUnit)
		ScourgesAmbush[ScourgesAmbush.CannibalGhoul] = {}
		ScourgesAmbush[ScourgesAmbush.CannibalGhoul] = pUnit
		ScourgesAmbush[ScourgesAmbush.CannibalGhoul]:SetFaction(14)
		ScourgesAmbush[ScourgesAmbush.CannibalGhoul]:SetMovementFlags(1)
		ScourgesAmbush[ScourgesAmbush.CannibalGhoul]:MoveTo(1262.197876, -2561.500732, 110.228584, 3.629264)
		ScourgesAmbush[ScourgesAmbush.CannibalGhoul]:RegisterEvent("ScourgesAmbush.CannibalGhoulMoveTwo", 3200, 1)
	end
end

function ScourgesAmbush.CannibalGhoulMoveTwo(pUnit, event)
		ScourgesAmbush[ScourgesAmbush.CannibalGhoul]:MoveTo(1264.366333, -2569.398193, 110.228584, 5.192202)
		ScourgesAmbush[ScourgesAmbush.CannibalGhoul]:RegisterEvent("ScourgesAmbush.RunThereOrNoFive", 3200, 1)
end

function ScourgesAmbush.RunThereOrNoFive(pUnit, event)
	ScourgesAmbush.RunOrNoFive = math.random(1, 4)
		if (ScourgesAmbush.RunOrNoFive == 1) then
			ScourgesAmbush[ScourgesAmbush.CannibalGhoul]:MoveTo(1271.808838, -2571.046631, 110.228996, 5.988852)
		end
		if (ScourgesAmbush.RunOrNoFive == 2) then
			ScourgesAmbush[ScourgesAmbush.CannibalGhoul]:MoveTo(1265.707764, -2575.237549, 110.228996, 5.069932)
		end
end

RegisterUnitEvent(95780, 18, "ScourgesAmbush.HauntedServitorOnSpawn")

-- Cannibal Ghoul on Death.

function ScourgesAmbush.CannibalGhoulOnDeath(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.ScourgesKilled = ScourgesAmbush.ScourgesKilled + 1
	end
end

RegisterUnitEvent(95780, 4, "ScourgesAmbush.CannibalGhoulOnDeath")

-- Creatures (Scourges) Functions - Lord Alexei Barov.

function ScourgesAmbush.LordAlexeiBarovOnSpawn(pUnit, event)
	if (pUnit:GetPhase() == 2) then
		ScourgesAmbush.LordAlexeiBarov = tostring(pUnit)
		ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov] = {}
		ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov] = pUnit
		ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov]:EquipWeapons(14541, 0, 0)
		ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov]:SetFaction(14)
		ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov]:SetMovementFlags(1)
		ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov]:MoveTo(1262.197876, -2561.500732, 110.228584, 3.629264)
		ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov]:RegisterEvent("ScourgesAmbush.LordAlexeiBarovMoveTwo", 3200, 1)
	end
end

function ScourgesAmbush.LordAlexeiBarovMoveTwo(pUnit, event)
		ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov]:MoveTo(1264.366333, -2569.398193, 110.228584, 5.192202)
		ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov]:RegisterEvent("ScourgesAmbush.RunThereOrNoLord", 3200, 1)
end

function ScourgesAmbush.RunThereOrNoLord(pUnit, event)
	ScourgesAmbush.RunOrNoLord = math.random(1, 4)
		if (ScourgesAmbush.RunOrNoLord == 1) then
			ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov]:MoveTo(1271.808838, -2571.046631, 110.228996, 5.988852)
		end
		if (ScourgesAmbush.RunOrNoLord == 2) then
			ScourgesAmbush[ScourgesAmbush.LordAlexeiBarov]:MoveTo(1265.707764, -2575.237549, 110.228996, 5.069932)
		end
end

RegisterUnitEvent(10504, 18, "ScourgesAmbush.LordAlexeiBarovOnSpawn")

-- Lord Alexei Barov on Death.

function ScourgesAmbush.LordAlexeiBarovOnDeath(pUnit, event)
	pUnit:SendChatMessage(14, 0, "I promise I will return!")
	pUnit:SetPhase(6)
		if (ScourgesAmbush.MarshalThery ~= nil) then
			ScourgesAmbush.MarshalThery:RegisterEvent("ScourgesAmbush.EndOfAmbush", 1800, 1)
		end
end

RegisterUnitEvent(10504, 4, "ScourgesAmbush.LordAlexeiBarovOnDeath")

-- Players on the same Quest.

ScourgesAmbush.PlayerOne = nil
ScourgesAmbush.PlayerTwo = nil
ScourgesAmbush.PlayerThree = nil
ScourgesAmbush.PlayerFour = nil
ScourgesAmbush.PlayerFive = nil

-- On Script Load.

ScourgesAmbush.EventInProgress = 0

-- We have to register the second Marshal Thery from Phase 2.

function ScourgesAmbush.MarshalTheryOnSpawn(pUnit, event)
	ScourgesAmbush.MarshalThery = pUnit
	ScourgesAmbush.MarshalThery:CastSpell(7294)
end

-- Register Unit Event of Marshal Thery.

RegisterUnitEvent(96065, 18, "ScourgesAmbush.MarshalTheryOnSpawn")

-- Now, we will start the event on Quest Accept.
-- Once you get the "Scourges Ambush" quest, you will go to Phase 2.
-- If there is already an Ambush started, you will take part of it.

function ScourgesAmbush.ScourgesAmbushOnQuestAccept(Event, Player, QuestID, QuestGiver)
	
	-- We first gonna check for Quest ID.
	
		if (QuestID == 96100) then
		
			-- Teleport the player to Phase 2 and QuestGiver start the Event.
			
				Player:SetPhase(2)
				
				-- Players.
				
				if (ScourgesAmbush.PlayerOne == nil) then
					ScourgesAmbush.PlayerOne = Player
				else
					if (ScourgesAmbush.PlayerTwo == nil) then
						ScourgesAmbush.PlayerTwo = Player
					else
						if (ScourgesAmbush.PlayerThree == nil) then
							ScourgesAmbush.PlayerThree = Player
						else
							if (ScourgesAmbush.PlayerFour == nil) then
								ScourgesAmbush.PlayerFour = Player
							else
								if (ScourgesAmbush.PlayerFive == nil) then
									ScourgesAmbush.PlayerFive = Player
								end
							end
						end
					end
				end
				
					-- Check for Event Progress.
					
						--if (ScourgesAmbush.EventInProgress == 0) then
							if (ScourgesAmbush.MarshalThery ~= nil) then
								ScourgesAmbush.ScourgesWaveyTwo = 0
								ScourgesAmbush.ScourgesWaveyThree = 0
								ScourgesAmbush.ScourgesLordWave = 0
								ScourgesAmbush.MarshalThery:RegisterEvent("ScourgesAmbush.StartTheAmbush", 1800, 1)
							end
						--end
					
					-- Ends.
					
		end

	-- Even more Ends!

end

-- Latest End.

-- Here we gonna Register Server Hook.

RegisterServerHook(14, "ScourgesAmbush.ScourgesAmbushOnQuestAccept")

-- Scourges Ambush Starts!

function ScourgesAmbush.StartTheAmbush(pUnit, event)
	ScourgesAmbush.EventInProgress = 1

		ScourgesAmbush.MarshalThery:SendChatMessage(12, 0, "Stand ready, they are approaching!")
			
		-- Emote Roar!
		
			ScourgesAmbush.MarshalThery:CastSpell(34999)
			ScourgesAmbush.MarshalThery:PlaySoundToSet(6077)
			
		-- Thery Function to Spawn Creatures!
		
			ScourgesAmbush.MarshalThery:RegisterEvent("ScourgesAmbush.ScourgesWaveOne", 3400, 1)
			ScourgesAmbush.MarshalThery:RegisterEvent("ScourgesAmbush.CheckForScourgesKills", 3000, 0)
end

-- Check for Scourges Kills.

function ScourgesAmbush.CheckForScourgesKills(pUnit, event)
	if (ScourgesAmbush.ScourgesKilled >= 3) then
		if (ScourgesAmbush.ScourgesWaveyTwo == 0) then
			pUnit:RegisterEvent("ScourgesAmbush.ScourgesWaveTwo", 2200, 1)
		end
	end
	if (ScourgesAmbush.ScourgesKilled >= 8) then
		if (ScourgesAmbush.ScourgesWaveyThree == 0) then
			pUnit:RegisterEvent("ScourgesAmbush.ScourgesWaveThree", 2200, 1)
		end
	end
	if (ScourgesAmbush.ScourgesKilled >= 9) then
		if (ScourgesAmbush.ScourgesLordWave == 0) then
			pUnit:RegisterEvent("ScourgesAmbush.ScourgesLordAlexeiBarovWave", 3000, 1)
		end
	end
end

-- Creatures List:

-- Animated Bone Warrior - 95710.
-- Risen Aberration - 96110.
-- Scholomance Necromancer - 95850.
-- Haunted Servitor - 3875.
-- Cannibal Ghoul - 95780.

-- Lord Alexei Barov (Boss) - 10504.

-- Wave One.

function ScourgesAmbush.ScourgesWaveOne(pUnit, event)
	ScourgesAmbush.MarshalThery:SpawnCreature(95710, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 120000, 0, 0, 0, 2, 0)
	ScourgesAmbush.MarshalThery:SpawnCreature(96110, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 120000, 0, 0, 0, 2, 0)
	ScourgesAmbush.MarshalThery:SpawnCreature(95780, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 120000, 0, 0, 0, 2, 0)
end

-- Wave Two.

function ScourgesAmbush.ScourgesWaveTwo(pUnit, event)
	ScourgesAmbush.ScourgesWaveyTwo = 1
	ScourgesAmbush.MarshalThery:SendChatMessage(14, 0, "More scourges are coming, take care!")
	ScourgesAmbush.MarshalThery:SpawnCreature(95710, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 120000, 0, 0, 0, 2, 0)
	ScourgesAmbush.MarshalThery:SpawnCreature(96110, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 120000, 0, 0, 0, 2, 0)
	ScourgesAmbush.MarshalThery:RegisterEvent("ScourgesAmbush.ThreeMoreScourges", 4800, 1)
end

function ScourgesAmbush.ThreeMoreScourges(pUnit, event)
	ScourgesAmbush.MarshalThery:SpawnCreature(95850, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 120000, 0, 0, 0, 2, 0)
	ScourgesAmbush.MarshalThery:SpawnCreature(95710, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 120000, 0, 0, 0, 2, 0)
	ScourgesAmbush.MarshalThery:SpawnCreature(96110, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 120000, 0, 0, 0, 2, 0)
end

-- Wave Three.

function ScourgesAmbush.ScourgesWaveThree(pUnit, event)
	ScourgesAmbush.ScourgesWaveyThree = 1
	ScourgesAmbush.MarshalThery:SendChatMessage(14, 0, "We shall triumph! Keep fighting!")
	ScourgesAmbush.MarshalThery:SpawnCreature(3875, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 220000, 0, 0, 0, 2, 0)
end

-- Scourges Lord Alexei Barov Wave.

function ScourgesAmbush.ScourgesLordAlexeiBarovWave(pUnit, event)
	ScourgesAmbush.ScourgesLordWave = 1
		if (ScourgesAmbush.CaptainJustinBarlett ~= nil) then
			ScourgesAmbush.CaptainJustinBarlett:SendChatMessage(14, 0, "How is that possible?")
		end
		ScourgesAmbush.MarshalThery:RemoveEvents()
	ScourgesAmbush.MarshalThery:SpawnCreature(10504, 1277.598022, -2553.204590, 102.947639, 3.617483, 14, 420000, 0, 0, 0, 2, 0)
end

-- End of the Ambush!

function ScourgesAmbush.EndOfAmbush(pUnit, event)
	ScourgesAmbush.MarshalThery:SendChatMessage(14, 0, "You have proven yourself today, champions!")
	ScourgesAmbush.MarshalThery:RegisterEvent("ScourgesAmbush.MarshalTheryGiveReward", 4400, 1)
end

function ScourgesAmbush.MarshalTheryGiveReward(pUnit, event)
			if (ScourgesAmbush.PlayerOne ~= nil) then
					ScourgesAmbush.PlayerOne:AdvanceQuestObjective(96100, 0)
					ScourgesAmbush.PlayerOne:SetPhase(4)
			end
					if (ScourgesAmbush.PlayerTwo ~= nil) then
						ScourgesAmbush.PlayerTwo:AdvanceQuestObjective(96100, 0)
						ScourgesAmbush.PlayerTwo:SetPhase(4)
					end
						if (ScourgesAmbush.PlayerThree ~= nil) then
							ScourgesAmbush.PlayerThree:AdvanceQuestObjective(96100, 0)
							ScourgesAmbush.PlayerThree:SetPhase(4)
						end
							if (ScourgesAmbush.PlayerFour ~= nil) then
								ScourgesAmbush.PlayerFour:AdvanceQuestObjective(96100, 0)
								ScourgesAmbush.PlayerFour:SetPhase(4)
							end
								if (ScourgesAmbush.PlayerFive ~= nil) then
									ScourgesAmbush.PlayerFive:AdvanceQuestObjective(96100, 0)
									ScourgesAmbush.PlayerFive:SetPhase(4)
								end
	ScourgesAmbush.MarshalThery:RegisterEvent("ScourgesAmbush.ResetEverything", 1000, 1)
end

function ScourgesAmbush.ResetEverything(pUnit, event)
	ScourgesAmbush.ScourgesWaveyTwo = 0
	ScourgesAmbush.ScourgesWaveyThree = 0
	ScourgesAmbush.ScourgesLordWave = 0
	ScourgesAmbush.ScourgesKilled = 0
	ScourgesAmbush.PlayerOne = nil
	ScourgesAmbush.PlayerTwo = nil
	ScourgesAmbush.PlayerThree = nil
	ScourgesAmbush.PlayerFour = nil
	ScourgesAmbush.PlayerFive = nil
end

-- End of the Scourges Ambush Script!