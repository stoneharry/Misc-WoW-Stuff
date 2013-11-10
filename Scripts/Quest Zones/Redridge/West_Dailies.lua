
function TIKLake_Cocoon_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
	--pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE)
	--pUnit:SetScale(0.01)
	--pUnit:Despawn(1000,3000) -- Not working for some weird weird reason.
	local TIK_x = pUnit:GetX()
	local TIK_y = pUnit:GetY()
	local TIK_z = pUnit:GetZ()
	local TIK_o = pUnit:GetO()
	if math.random(1,4) == 1 then
		pUnit:SpawnCreature(77200, TIK_x ,TIK_y ,TIK_z ,TIK_o , 35, 7000)
	else
		pUnit:SpawnCreature(77197, TIK_x ,TIK_y ,TIK_z ,TIK_o , 22, 360000)
	end
end

RegisterUnitEvent(77198, 4, "TIKLake_Cocoon_OnDeath")

function sghushg_miner_spawned(pUnit,Event)
	pUnit:RegisterEvent("tgesoihgos_get_player_to_do",1000,1)
end

function sghushg_spider_spawned(pUnit,Event)
	pUnit:RegisterEvent("tgesoihgos_despawn_cocoons_yay",1000,1)
end

function tgesoihgos_despawn_cocoons_yay(pUnit)
	for k,cacoon in pairs(pUnit:GetInRangeUnits()) do
		if cacoon:GetEntry() == 77198 then
			if not cacoon:IsAlive() then
				cacoon:Despawn(0, 30000)
			end
		end
	end
end

function tgesoihgos_get_player_to_do(pUnit)
	for k,cacoon in pairs(pUnit:GetInRangeUnits()) do
		if cacoon:GetEntry() == 77198 then
			if not cacoon:IsAlive() then
				cacoon:Despawn(0, 30000)
			end
		end
	end
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 30 then
			if plr:IsInPhase(16) then
				if plr:HasQuest(2504) then
					if (player:GetQuestObjectiveCompletion(2504, 0) ~= 4) then
						plr:AdvanceQuestObjective(2504, 0)
					end
				end
			end
		end
	end
	local x = pUnit:GetX()+20
	local y = pUnit:GetY()+math.random(0,10)
	pUnit:MoveTo(x, y, pUnit:GetLandHeight(x,y), 0)
	local TIKLake_MSG = math.random(1,4)
	if TIKLake_MSG == 1 then
		pUnit:SendChatMessage(12,0,"Thank you! Thank you for saving my life!")
	elseif TIKLake_MSG == 2 then
		pUnit:SendChatMessage(12,0,"It was getting boring anyway.")
	elseif TIKLake_MSG == 3 then
		pUnit:SendChatMessage(12,0,"Is this real life? You have four eyes... I have two fingers...")
	elseif TIKLake_MSG == 4 then
		pUnit:SendChatMessage(12,0,"I AM GONNA SUE THAT BAS-! Letting me live in a cocoon for A WHOLE DAY! Bloody...")
	end
end

RegisterUnitEvent(77200, 18, "sghushg_miner_spawned")
RegisterUnitEvent(77197, 18, "sghushg_spider_spawned")

--[[function TIKLake_Cocoon_OnSpawn(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:SetScale(1)
end

RegisterUnitEvent(77200, 18, "TIKLake_Cocoon_OnSpawn")]]