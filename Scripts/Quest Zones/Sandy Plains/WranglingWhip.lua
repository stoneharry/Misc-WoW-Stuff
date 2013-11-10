local SelectedItem = {}

function WranglingWhip_Sandyplains(item, event, player)
	if player:HasQuest(52011) and (player:GetQuestObjectiveCompletion(52011, 0) ~= 5) then
		if CooldownCheck(player, 2) then
			return
		else
			CooldownTime[player:GetName()] = os.clock()
			local target = player:GetSelection()
			if target then
				if not target:IsAlive() then
					player:SendAreaTriggerMessage("|cFFFF0000Target is dead!")
					return
				end
				if SelectedItem[player:GetName()] then
					if SelectedItem[player:GetName()] == target:GetGUID() then
						player:SendAreaTriggerMessage("|cFFFF0000Not ready yet!")
						return
					else
						SelectedItem[player:GetName()] = target:GetGUID()
					end
				end
				if target:GetEntry() ~= 900202 then		  
					player:SendAreaTriggerMessage("|cFFFF0000Wrong target!")
					return
				end
				if target:GetHealthPct() < 40 then
					--player:FullCastSpellOnTarget(48722, target) -- hook visual
					target:Despawn(1, 15000)
					local SubduedTurtle = player:CreateGuardian(900204, 0, math.random(2,6), 19)
					SubduedTurtle:SetPetOwner(player)
					player:FullCastSpellOnTarget(48722, SubduedTurtle)
					SubduedTurtle:Despawn(360000,0)
				else
					player:SendAreaTriggerMessage("|cFFFF0000Target not weakened enough!")
				end
			else
				player:SendAreaTriggerMessage("|cFFFF0000No selection!")
			end
		end
	else
		player:SendAreaTriggerMessage("|cFFFF0000You do not have the required quest!")
	end
end

RegisterItemGossipEvent(32733, 1, "WranglingWhip_Sandyplains")

function WranglingWhip_quest_Dummy_Spawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("FindSnapper_Rawr", 1000, 0)
end

function FindSnapper_Rawr(pUnit)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 900204 then 
			if pUnit:GetDistanceYards(creatures) < 10 then
				local Owner = creatures:GetPetOwner()
				creatures:Despawn(1,0)
				if Owner then
					if Owner:HasQuest(52011) and (Owner:GetQuestObjectiveCompletion(52011, 0) ~= 5) then
						Owner:AdvanceQuestObjective(52011, 0)
					end
				end
			end
		end
	end
end
		
RegisterUnitEvent(900205, 18, "WranglingWhip_quest_Dummy_Spawn")
		
function dunesnapper_passive(pUnit,Event)
	pUnit:AIDisableCombat(true)
end
		
RegisterUnitEvent(900204, 18, "dunesnapper_passive")
