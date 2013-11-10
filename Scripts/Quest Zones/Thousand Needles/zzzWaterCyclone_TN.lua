
function OnSpawnPlayVisual_Cyclone(pUnit, Event)
	pUnit:RegisterEvent("PlayVisual_Cyclone_Water", 5000, 0)
	pUnit:RegisterEvent("CheckForPlayer_Cyclone", 1000, 0)
end

function PlayVisual_Cyclone_Water(pUnit)
	pUnit:CastSpell(43119)
end

function CheckForPlayer_Cyclone(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 6 then
			if plr:HasQuest(6331) == true then
				--plr:MarkQuestObjectiveAsComplete(6331, 0)
				plr:AdvanceQuestObjective(6331, 0)
			end
			if plr:IsMounted() then
				plr:Dismount()
			end
			plr:MoveKnockback(-6194, -3899, 319, 3, 5)
		end
	end
end

RegisterUnitEvent(31913, 18, "OnSpawnPlayVisual_Cyclone")

-- Parachute

-- 37897

function PARACHUTE_DEPLOY(item, event, player)
	if math.random(1,5) == 1 then
		--if player:GetLandHeight(player:GetX(), player:GetY()) > player:GetZ()-1 then
			player:CastSpell(37897)
			player:RemoveItem(35946, 1)
			if player:HasQuest(6331) == true then
				--player:MarkQuestObjectiveAsComplete(6331, 1)
				player:AdvanceQuestObjective(6331, 1)
			end
			RegisterTimedEvent("Check_Player_LandHeight", 1000, 10, player)
		--[[else
			player:SendAreaTriggerMessage("|cFFFF0000You are not in the air falling!")
		end]]
	else
		player:SendAreaTriggerMessage("|cFFFF0000The parachute failed to deploy!")
	end
end

function Check_Player_LandHeight(player)
	if player ~= nil then
		if player:IsInWorld() then
			if player:HasAura(37897) then
				if player:GetLandHeight(player:GetX(), player:GetY()) > player:GetZ()-4 then
					player:RemoveAura(37897)
				end
			end
		end
	end
end

RegisterItemGossipEvent(35946, 1, "PARACHUTE_DEPLOY")
