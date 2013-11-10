
--[[ this is not used

function ItemHonorExchangerGossip(pUnit, event, player)
   pUnit:GossipCreateMenu(433122, player, 0)
   pUnit:GossipMenuAddItem(4, "Exchange Warsong Gulch Marks (Enter how many)", 245, 1)
   pUnit:GossipMenuAddItem(4, "Exchange Arathi Basin Marks (Enter how many)", 246, 1)
   pUnit:GossipMenuAddItem(4, "Exchange Eye of the Storm Marks (Enter how many)", 247, 1)
   pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
   pUnit:GossipSendMenu(player)
end

function ItemHonorExchangerGossipSelect(pUnit, event, player, id, intid, code)
	if tonumber(code) ~= nil then
		code = tonumber(code)
		if code > 0 and code < 1000 then
			if(intid == 245) then
				local amount = player:GetItemCount(20558) -- WSG
				if amount ~= nil then
					if tonumber(amount) ~= 0 then
						if tonumber(amount) >= code then
							player:RemoveItem(20558, code)
							player:AddItem(44115, code)
						else
							pUnit:SendAreaTriggerMessage("You do not have enough marks!")
						end
					end
				end
			end
			if(intid == 246) then
				local amount = player:GetItemCount(20559) -- AB
				if amount ~= nil then
					if tonumber(amount) ~= 0 then
						if tonumber(amount) >= code then
							player:RemoveItem(20559, code)
							player:AddItem(44115, code)
						else
							pUnit:SendAreaTriggerMessage("You do not have enough marks!")
						end
					end
				end
			end
			if(intid == 247) then
				local amount = player:GetItemCount(29024) -- EOTS
				if amount ~= nil then
					if tonumber(amount) ~= 0 then
						if tonumber(amount) >= code then
							player:RemoveItem(29024, code)
							player:AddItem(44115, code)
						else
							pUnit:SendAreaTriggerMessage("You do not have enough marks!")
						end
					end
				end
			end
		end
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(47622, 1, "ItemHonorExchangerGossip")
RegisterUnitGossipEvent(47622, 2, "ItemHonorExchangerGossipSelect")

]]