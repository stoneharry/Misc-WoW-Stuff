-- Caer Darrow Escort Quest. (Quest Starter: Danny Wilson)
-- Danny Wilson need to be rescued to Michael Marshall.

DannyWilsonEscort = {} -- Main Table.

function DannyWilsonEscort.MichaelRegisterFunctionOnSpawn(pUnit, event)
	DannyWilsonEscort.MichaelMarshall = pUnit
end

RegisterUnitEvent(95700, 18, "DannyWilsonEscort.MichaelRegisterFunctionOnSpawn")

-- Danny On Spawn Event.

function DannyWilsonEscort.DannyWilsonEscortOnSpawn(pUnit, event)
	pUnit:SetNPCFlags(3)
	DannyWilsonEscort.EscortPlayer = nil
end

RegisterUnitEvent(95750, 18, "DannyWilsonEscort.DannyWilsonEscortOnSpawn")

-- Danny On Quest Accept Server Hook.

function DannyWilsonEscort.OnDannyEscortQuestAccept(event, Player, QuestID, QuestGiver)
		if (QuestID == 95750) then
			if (QuestGiver ~= nil) then
				QuestGiver:SetNPCFlags(2)
				QuestGiver:CastSpell(10290)
				QuestGiver:RegisterEvent("DannyWilsonEscort.DistanceMichaelCheck", 5000, 0)
					if (Player ~= nil) then
						QuestGiver:StopMovement(1)
						QuestGiver:SetUnitToFollow(Player, 1, 1)
						QuestGiver:SendChatMessageToPlayer(12, 0, "I will follow you, "..Player:GetName()..".", Player)
					end
				DannyWilsonEscort.EscortPlayer = Player
			end
		end
end

RegisterServerHook(14, "DannyWilsonEscort.OnDannyEscortQuestAccept")

function DannyWilsonEscort.DistanceMichaelCheck(pUnit, event)
	if (DannyWilsonEscort.MichaelMarshall ~= nil) then
		if (pUnit:GetDistanceYards(DannyWilsonEscort.MichaelMarshall) <= 35) then
			pUnit:RemoveEvents()
			pUnit:StopMovement(1)
			pUnit:SetUnitToFollow(pUnit, 0, 0)
			pUnit:RegisterEvent("DannyWilsonEscort.DannyWilsonMoveToMichael", 3400, 1)
				if (DannyWilsonEscort.EscortPlayer ~= nil) then
					pUnit:SendChatMessageToPlayer(12, 0, "Thanks for help, "..DannyWilsonEscort.EscortPlayer:GetName()..", I can make it from here by myself!", DannyWilsonEscort.EscortPlayer)
						if (DannyWilsonEscort.EscortPlayer:HasQuest(95750) == true) then
							DannyWilsonEscort.EscortPlayer:AdvanceQuestObjective(95750, 0)
						end
				end
			pUnit:Despawn(6000, 12000)
			pUnit:Emote(1, 2180)
		end
	end
end

function DannyWilsonEscort.DannyWilsonMoveToMichael(pUnit, event)
	pUnit:MoveTo(1093.620972, -2570.379395, 59.117954, 3.580185)
end

-- Danny On Combat.

function DannyWilsonEscort.DannyWilsonEscortOnCombat(pUnit, event)
	pUnit:RegisterEvent("DannyWilsonEscort.RandomDannyAbility", math.random(1600, 3800), 1)
end

function DannyWilsonEscort.RandomDannyAbility(pUnit, event)
	DannyWilsonEscort.RandomAbilityChoose = math.random(1, 10)
		if (DannyWilsonEscort.RandomAbilityChoose == 1) then
			if (pUnit:GetMainTank() ~= nil) then
				pUnit:CastSpellOnTarget(14517, pUnit:GetMainTank())
			end
		end
		if (DannyWilsonEscort.RandomAbilityChoose == 2) then
			if (pUnit:HasAura(20154) == false) then
				pUnit:CastSpellOnTarget(20154, pUnit)
			end
		end
		if (DannyWilsonEscort.RandomAbilityChoose == 3) then
			if (pUnit:GetMainTank() ~= nil) then
				pUnit:CastSpellOnTarget(853, pUnit:GetMainTank())
			end
		end
		if (DannyWilsonEscort.RandomAbilityChoose == 4) then
			if (pUnit:GetMainTank() ~= nil) then
				pUnit:CastSpellOnTarget(20271, pUnit:GetMainTank())
			end
		end
		if (DannyWilsonEscort.RandomAbilityChoose == 6) then
			pUnit:CastSpellOnTarget(19940, pUnit:GetMainTank())
		end
end

RegisterUnitEvent(95750, 1, "DannyWilsonEscort.DannyWilsonEscortOnCombat")

function DannyWilsonEscort.DannyWilsonEscortOnLeaveCombat(pUnit, event)
	if (DannyWilsonEscort.EscortPlayer ~= nil) then
		pUnit:SetUnitToFollow(DannyWilsonEscort.EscortPlayer, 1, 1)
	end
	DannyWilsonEscort.RandomEmoteDanny = math.random(1, 4)
		if (DannyWilsonEscort.RandomEmoteDanny == 1) then	
			pUnit:CastSpell(63599)
		end
end

RegisterUnitEvent(95750, 2, "DannyWilsonEscort.DannyWilsonEscortOnLeaveCombat")

function DannyWilsonEscort.DannyWilsonEscortOnDeath(pUnit, event)
	DannyWilsonEscort.EscortPlayer = nil
	pUnit:RemoveEvents()
end

RegisterUnitEvent(95750, 4, "DannyWilsonEscort.DannyWilsonEscortOnDeath")