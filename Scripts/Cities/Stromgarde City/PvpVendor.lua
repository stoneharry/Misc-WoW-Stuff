function PvpVendor_On_Gossip(pUnit, event, player)
	local class = player:GetPlayerClass()
	if class == "Warrior" then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(22418,1, 2557) -- helm
		pUnit:VendorAddItem(24546,1,2557) -- shoulders
		pUnit:VendorAddItem(24547,1, 2557) -- legs
		pUnit:VendorAddItem(24549,1, 2557)-- gloves
		pUnit:VendorAddItem(24544,1,2557) -- chest
		player:SendVendorWindow(pUnit)
	elseif class == "Mage" then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(25855,1, 2557) -- helm
		pUnit:VendorAddItem(25854,1, 2557) -- legs
		pUnit:VendorAddItem(25858,1,2557) -- shoulders
		pUnit:VendorAddItem(25857,1, 2557)-- gloves
		pUnit:VendorAddItem(25856,1,2557) -- chest
		player:SendVendorWindow(pUnit)
	elseif class == "Hunter" then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(28331,1, 2557) -- helm
		pUnit:VendorAddItem(28332,1, 2557) -- legs
		pUnit:VendorAddItem(28333,1,2557) -- shoulders
		pUnit:VendorAddItem(28335,1, 2557)-- gloves
		pUnit:VendorAddItem(28334,1,2557) -- chest
		player:SendVendorWindow(pUnit)
	elseif class == "Rogue"or class == "Demon Hunter" then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(25830,1, 2557) -- helm
		pUnit:VendorAddItem(25832,1, 2557) -- legs
		pUnit:VendorAddItem(25833,1,2557) -- shoulders
		pUnit:VendorAddItem(25834,1, 2557)-- gloves
		pUnit:VendorAddItem(25831,1,2557) -- chest
		player:SendVendorWindow(pUnit)
	elseif class == "Warlock" then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(24553,1, 2557) -- helm
		pUnit:VendorAddItem(24554,1, 2557) -- legs
		pUnit:VendorAddItem(24555,1,2557) -- shoulders
		pUnit:VendorAddItem(24556,1, 2557)-- gloves
		pUnit:VendorAddItem(24552,1,2557) -- chest
		player:SendVendorWindow(pUnit)
	elseif class == "Priest" then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(27708,1,2557) -- helm
		pUnit:VendorAddItem(27710,1, 2557) -- legs
		pUnit:VendorAddItem(27709,1,2557) -- shoulders
		pUnit:VendorAddItem(27707,1,2557)-- gloves
		pUnit:VendorAddItem(27711,1,2557) -- chest
		player:SendVendorWindow(pUnit)
	elseif class == "Shaman" then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(27471,1, 2557) -- helm
		pUnit:VendorAddItem(31400,1, 2557) -- helm caster
		pUnit:VendorAddItem(27473,1, 2557) -- legs
		pUnit:VendorAddItem(31407,1, 2557) -- legs caster
		pUnit:VendorAddItem(27472,1,2557) -- shoulders
		pUnit:VendorAddItem(31406,1,2557) -- shoulders caster
		pUnit:VendorAddItem(27470,1, 2557)-- gloves
		pUnit:VendorAddItem(31397,1, 2557)-- gloves caster
		pUnit:VendorAddItem(27469,1,2557) -- chest
		pUnit:VendorAddItem(31396,1,2557) -- chest caster
		player:SendVendorWindow(pUnit)
	elseif class == "Druid" then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(42118,1, 2557) -- helm done
		pUnit:VendorAddItem(40810,1, 2557) -- helm caster
		pUnit:VendorAddItem(40790,1, 2557) -- legs done
		pUnit:VendorAddItem(40829,1, 2557) -- legs caster
		pUnit:VendorAddItem(42119 ,1,2557) -- shoulders done
		pUnit:VendorAddItem(40811,1,2557) -- shoulders caster
		pUnit:VendorAddItem(40791 ,1, 2557)-- gloves done
		pUnit:VendorAddItem(40830,1, 2557)-- gloves caster
		pUnit:VendorAddItem(40792,1,2557) -- chest done
		pUnit:VendorAddItem(40812,1,2557) -- chest caster
		player:SendVendorWindow(pUnit)
	elseif class == "Paladin" then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(40831,1, 2557) -- HELM RET
		pUnit:VendorAddItem(40928,1, 2557) -- LEGS RET
		pUnit:VendorAddItem(40890 ,1,2557) -- shoulders RET
		pUnit:VendorAddItem(40910 ,1, 2557)-- gloves RET
		pUnit:VendorAddItem(40883,1,2557) -- chest dRET
		pUnit:VendorAddItem(35061,1, 2557) -- helm caster
		pUnit:VendorAddItem(35062,1, 2557) -- legs caster
		pUnit:VendorAddItem(35063,1,2557) -- shoulders caster
		pUnit:VendorAddItem(35060,1, 2557)-- gloves caster
		pUnit:VendorAddItem(35059,1,2557) -- chest caster
		player:SendVendorWindow(pUnit)
   end
end



RegisterUnitGossipEvent(98321, 1, "PvpVendor_On_Gossip")