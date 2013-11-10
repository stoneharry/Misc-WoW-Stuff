-- Cinematics will be handled server side

function OnFirstEnterWorld_Script(event, pPlayer)
	-- So Syntax is: EDGEOFCHAOS:SCENARIO-name-0-0-name-description
	-- CHAOTIC:UNITED-  | cannot change, this is for the client to listen for.
	-- Title-           | This is the title of the scenario.
	-- Stage-           | This MUST be the number and is stage number
	-- FinalStage-      | This is the final stage number, and MUST be a number.
	-- StageName-       | Can't remember what this is for
	-- StageDescription | This is the description of the stage.
	if not pPlayer then
		return
	end
	pPlayer:SendBroadcastMessage("[EoC-Addon]- -3-3-Welcome!-The Adventure Begins")
	if not pPlayer:HasItem(6948) then
		pPlayer:AddItem(6948,1)
	end
	if pPlayer:GetPlayerLevel() == 1 then
		local race = pPlayer:GetPlayerRace() -- We get the race of the person that we shall use
		if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then -- THIS IS THE ALLIANCE RACES, change to what you want.
			--pPlayer:StartQuest(1) --This has been commented out, due to new players feeling confusion at what to do next.
		elseif race == 17 then -- tuskar
			pPlayer:SendCinematic(61)
		else -- Horde
			pPlayer:StartQuest(800)
		end
	end
end

RegisterServerHook(3, "OnFirstEnterWorld_Script")

--[[function VETERAN_ACHIEVEMENT_HF(event, pPlayer)
	if not pPlayer then
		return
	end
	if pPlayer:HasAchievement(60016) then
		if  not pPlayer:HasSpell(50036)then
			pPlayer:LearnSpell(50036)
		end
	end
end

RegisterServerHook(4, "VETERAN_ACHIEVEMENT_HF")]]

-- 21602 cannoo displayid