local SelectedItem = {}

function BanishingCrystal_ArathiHighlands(item, event, player)
	if player:HasQuest(45011) and (player:GetQuestObjectiveCompletion(45011, 0) ~= 4) then
		if CooldownCheck(player, 2) then
			return
		else
			CooldownTime[player:GetName()] = os.clock()
			if player:GetSelection() ~= nil then
				local target = player:GetSelection()
				if SelectedItem[player:GetName()] ~= nil then
					if SelectedItem[player:GetName()] == target:GetGUID() then
						player:SendAreaTriggerMessage("|cFFFF0000Not ready yet!")
						return
					else
						SelectedItem[player:GetName()] = target:GetGUID()
					end
				end
				if target:GetEntry() == 549862 then		  
				else
					player:SendAreaTriggerMessage("|cFFFF0000Wrong target!")
					return
				end
				if target:GetHealthPct() < 40 then
					player:CastSpellOnTarget(59395, target) -- hook visual
					target:Kill(target)
					target:Despawn(2000, 60000)
					player:AdvanceQuestObjective(45011, 0)
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

RegisterItemGossipEvent(32696, 1, "BanishingCrystal_ArathiHighlands")

function Highlands_ShadowPurify(item, event, player)
	if player:HasQuest(45020) and (player:GetQuestObjectiveCompletion(45020, 0) ~= 5) then
		if CooldownCheck(player, 5) then
			return
		else
			CooldownTime[player:GetName()] = os.clock()
			for _, creatures in pairs(player:GetInRangeUnits()) do 
				if creatures:GetEntry() == 549867 and (player:GetDistanceYards(creatures) < 2) then
					player:CastSpell(17155)
					for _,crystal in pairs(creatures:GetInRangeObjects()) do -- jesus this line is going to be resource intensive 
						if crystal:GetEntry() == 184664 and (creatures:GetDistanceYards(crystal) < 4) then
							crystal:Despawn(1,60000)
							creatures:Despawn(1,60000)
							creatures:SpawnCreature(449682,creatures:GetX() , creatures:GetY(),creatures:GetZ(), creatures:GetO(), 14, 60000)
						end
					end
				end
			end
		end
	end
end

RegisterItemGossipEvent(12642, 1, "Highlands_ShadowPurify")