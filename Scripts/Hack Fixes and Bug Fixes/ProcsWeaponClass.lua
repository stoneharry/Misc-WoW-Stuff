function ClassWeapons_SpellCast(event, pPlayer, spellId)
	if pPlayer:GetEntry() ~= 26166 then
		if pPlayer ~= nil then
			-- yeah... this next condition makes no sense what so ever
			if pPlayer:GetEntry() == 1953 or 5144 or 1449 or 3140 or 2137 or 10 or 122 or 7322 then
				if pPlayer:HasAura(26166) == false then -- prevent from spamming and 100% uptime.
					local class = pPlayer:GetPlayerClass() 
					if class == "Mage" then
						if pPlayer:GetEquippedItemBySlot(15) ~= nil then
							if pPlayer:GetEquippedItemBySlot(15):GetEntryId() == 1607 then
								if math.random(1,25) <= 5 then
									class = nil
									pPlayer:RemoveEvents()
									pPlayer:CastSpell(26166)
								end
							end
						end
					elseif pPlayer:GetEquippedItemBySlot(15) ~= nil then
						if pPlayer:GetEquippedItemBySlot(15):GetEntryId() == 46017 then
							if math.random(1,40) <= 5 then
								class = nil
								pPlayer:RemoveEvents()
								pPlayer:CastSpell(26166)
							end
						end					
					end
				end
			end
		end
	end
end

RegisterServerHook(10, "ClassWeapons_SpellCast")