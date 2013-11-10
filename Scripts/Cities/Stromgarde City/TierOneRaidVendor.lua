local ITEM_VENDOR = {
	["Warrior"] = {
	-- Tank set
		{40819, 1, 2684}, -- helm
		{40859, 1, 2684}, -- shoulders
		{40840, 1, 2684}, -- legs
		{40801, 1, 2684}, -- gloves
		{40783, 1, 2684}, -- chest
	-- DPS Set
		{81575, 1, 2684}, -- helm
		{81574, 1, 2684}, -- shoulders
		{81573, 1, 2684}, -- legs
		{81572, 1, 2684}, -- gloves
		{81571, 1, 2684} -- chest
	},
	["Mage"] = {
	-- Spell DPS Set
		{81586, 1, 2684}, -- helm
		{81587, 1, 2684}, -- shoulders
		{81588, 1, 2684}, -- legs
		{81589, 1, 2684}, -- gloves
		{81590, 1, 2684} -- chest
	},
	["Hunter"] = {
	-- Agi DPS Set
		{81582, 1, 2684}, -- helm
		{81584, 1, 2684}, -- shoulders
		{81583, 1, 2684}, -- legs
		{81581, 1, 2684}, -- gloves
		{81585, 1, 2684}, -- chest
	},
	["Warlock"] = {
	-- Spell DPS Set
		{81586, 1, 2684}, -- helm
		{81587, 1, 2684}, -- shoulders
		{81588, 1, 2684}, -- legs
		{81589, 1, 2684}, -- gloves
		{81590, 1, 2684} -- chest
	},
	["Priest"] = {
	-- Spell DPS Set
		{81586, 1, 2684}, -- helm
		{81587, 1, 2684}, -- shoulders
		{81588, 1, 2684}, -- legs
		{81589, 1, 2684}, -- gloves
		{81590, 1, 2684}, -- chest
	-- Healing set
		{81591, 1, 2684}, -- helm
		{81592, 1, 2684}, -- shoulders
		{81593, 1, 2684}, -- legs
		{81594, 1, 2684}, -- gloves
		{81595, 1, 2684} -- chest
	},
	["Shaman"] = {
	-- Agi DPS Set
		{81582, 1, 2684}, -- helm
		{81584, 1, 2684}, -- shoulders
		{81583, 1, 2684}, -- legs
		{81581, 1, 2684}, -- gloves
		{81585, 1, 2684}, -- chest
	-- Spell DPS
		{81601, 1, 2684}, -- helm
		{81602, 1, 2684}, -- shoulders
		{81603, 1, 2684}, -- legs
		{81604, 1, 2684}, -- gloves
		{81605, 1, 2684}, -- chest
	-- Healing
		{81596, 1, 2684}, -- helm
		{81597, 1, 2684}, -- shoulders
		{81598, 1, 2684}, -- legs
		{81599, 1, 2684}, -- gloves
		{81600, 1, 2684}, -- chest
	},
	["Druid"] = {
	-- Agi DPS Set
		{81582, 1, 2684}, -- helm
		{81584, 1, 2684}, -- shoulders
		{81583, 1, 2684}, -- legs
		{81581, 1, 2684}, -- gloves
		{81585, 1, 2684}, -- chest
	-- Spell DPS
		{81601, 1, 2684}, -- helm
		{81602, 1, 2684}, -- shoulders
		{81603, 1, 2684}, -- legs
		{81604, 1, 2684}, -- gloves
		{81605, 1, 2684}, -- chest
	-- Healing
		{81596, 1, 2684}, -- helm
		{81597, 1, 2684}, -- shoulders
		{81598, 1, 2684}, -- legs
		{81599, 1, 2684}, -- gloves
		{81600, 1, 2684}, -- chest
	},
	["Paladin"] = {
	-- Tank set
		{40819, 1, 2684}, -- helm
		{40859, 1, 2684}, -- shoulders
		{40840, 1, 2684}, -- legs
		{40801, 1, 2684}, -- gloves
		{40783, 1, 2684}, -- chest
	-- DPS Set
		{81575, 1, 2684}, -- helm
		{81574, 1, 2684}, -- shoulders
		{81573, 1, 2684}, -- legs
		{81572, 1, 2684}, -- gloves
		{81571, 1, 2684}, -- chest
	-- Healing set
		{81578, 1, 2684}, -- helm
		{81580, 1, 2684}, -- shoulders
		{81579, 1, 2684}, -- legs
		{81577, 1, 2684}, -- gloves
		{81576, 1, 2684} -- chest
	},
	["Rogue"] = {
	-- Agi DPS Set
		{81582, 1, 2684}, -- helm
		{81584, 1, 2684}, -- shoulders
		{81583, 1, 2684}, -- legs
		{81581, 1, 2684}, -- gloves
		{81585, 1, 2684}, -- chest
	},
	["Demon Hunter"] = {
	-- Agi DPS Set
		{81582, 1, 2684}, -- helm
		{81584, 1, 2684}, -- shoulders
		{81583, 1, 2684}, -- legs
		{81581, 1, 2684}, -- gloves
		{81585, 1, 2684}, -- chest
	}
}

function TierOneVendor_On_Gossip(pUnit, event, player)
	pUnit:VendorRemoveAllItems()
	local tbl = ITEM_VENDOR[player:GetPlayerClass()]
	if not tbl then
		player:SendBroadcastMessage("ERROR: TierOneRaidVendor, report to stoneharry.")
		return
	end
	for _,v in ipairs(tbl) do
		pUnit:VendorAddItem(v[1], v[2], v[3])
	end
	player:SendVendorWindow(pUnit)
end

RegisterUnitGossipEvent(33307, 1, "TierOneVendor_On_Gossip")