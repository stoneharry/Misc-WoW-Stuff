
local Selected = {}

function UldamanDeathRayGnomsi(item, event, player)
	if player:HasQuest(6507) then
		if CooldownCheck(player, 5) then
			return
		else
			CooldownTime[player:GetName()] = os.clock()
			if player:GetSelection() ~= nil then
				local target = player:GetSelection()
				if Selected[player:GetName()] ~= nil then
					if Selected[player:GetName()] == target:GetGUID() then
						player:SendAreaTriggerMessage("|cFFFF0000You have already healed this dwarf!")
						return
					else
						Selected[player:GetName()] = target:GetGUID()
					end
				end
				if target:GetEntry() == 158351 then
					if (player:GetQuestObjectiveCompletion(6507, 0) ~= 5) then
						player:AdvanceQuestObjective(6507, 0)
					end
					player:CastSpellOnTarget(1064, target)
					target:SetHealth(target:GetMaxHealth())
					if target:GetSelection() ~= nil then
						target:GetSelection():Despawn(1,1)
					end
					RegisterTimedEvent("Dwarf_Visual_Shizzle_Itemused", 1000, 1, target)
				else
					player:SendAreaTriggerMessage("|cFFFF0000Wrong target!")
				end
			else
				player:SendAreaTriggerMessage("|cFFFF0000No selection!")
			end
		end
	else
		player:SendAreaTriggerMessage("|cFFFF0000You do not have the required quest!")
	end
end

RegisterItemGossipEvent(4863, 1, "UldamanDeathRayGnomsi")

function Dwarf_Visual_Shizzle_Itemused(pUnit)
	pUnit:FullCastSpell(19135) -- avatar
	if math.random(1,2) == 1 then
		pUnit:SendChatMessage(12,0,"Thank you stranger, to battle!")
	else
		pUnit:SendChatMessage(12,0,"To victory!")
	end
	pUnit:CastSpell(34109) -- whirlwind
end