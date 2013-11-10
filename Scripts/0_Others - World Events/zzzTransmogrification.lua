
function Transmog_OpenMenu(pUnit, event, plr)
	if plr then
		plr:SendBroadcastMessage("[EoC-Addon] OpenTransmog")
	end
end

RegisterUnitGossipEvent(18335, 1, "Transmog_OpenMenu")

function TransmogItem(item, slot, original, plr)
	if not item or not slot or not original or not plr then
		return
	end
	if plr:GetCoinage() < 400000 then
		plr:SendBroadcastMessage("Error: Not enough gold.")
	end
	plr:DealGoldCost(400000)
	AddTransmog(slot, plr, item, original)
end

-- Executes quite some code. Delay in milliseconds. (applies transmogs)
local DELAY = 1000

-- Transmog table and functions.
local Transmogs

-- Key0 is the key for inv_slots table, which contains the slotID. Key0 is also used for the inv_slot_names table
local inv_slots =					{0,			2,				4,			5,			6,		7,		8,		
									9,			14,		15,				16,			17}
local inv_slot_names =				{"Head",	"Shoulders",	"Chest",	"Waist",	"Legs",	"Feet",	"Wrists",
									"Hands",	"Back",	"Main hand",	"Off hand",	"Ranged"}

local INV_BAG, INV_START, INV_END = 255, 1, #inv_slots
local VISIBLE_ITEM_ENTRY_0 = 283
local BAGS =
{
	{BAG = INV_BAG, START = 23, END = 38},
	{BAG = 19, START = 0, END = 35},
	{BAG = 20, START = 0, END = 35},
	{BAG = 21, START = 0, END = 35},
	{BAG = 22, START = 0, END = 35},
}

-- bags -1 inventory and backpack, 19-22 other bags
-- slots 0-18 equipment
-- slots 19-22 bags
-- slots 23-38 backpack
-- slots 0-35 other bags

function checkItemValid(fake, player)
	for i = 0, 38 do
		local item = player:GetInventoryItem(-1, i)
		if item and tonumber(item:GetEntryId()) == tonumber(fake) then
			return item
		end
	end
	for i=19,22 do
		for k = 0,35 do
			local item = player:GetInventoryItem(i, k)
			if item and tonumber(item:GetEntryId()) == tonumber(fake) then
				return item
			end
		end
	end
	return nil
end

function AddTransmog(slot, player, fake, original)
	local item = checkItemValid(fake, player)
	local original = checkItemValid(original, player)
	slot = slot - 1
	if (item and validItem(item, player) and original and validItem(original, player)) then
		local pGUID, iGUID = tostring(player:GetGUID()), tostring(original:GetGUID())
		--player:SetUInt32Value(VISIBLE_ITEM_ENTRY_0+(slot * 2), fake) -- this will auto update when you equip the item
		if (not Transmogs[pGUID]) then
			Transmogs[pGUID] = {}
		end
		if (not Transmogs[pGUID][slot]) then
			Transmogs[pGUID][slot] = {}
		end
		Transmogs[pGUID][slot][iGUID] = fake
		CharDBQuery('REPLACE INTO Transmog_items (player_GUID, item_GUID, slot, fake) VALUES ("'..pGUID..'", "'..iGUID..'", '..slot..', '..fake..')')
		return true
	end
	return false
end

function validItem(item, plr)
	--[[if item:GetDurability() < item:GetMaxDurability() then
		return false
	end]]
	local str = item:GetItemLink()
	if string.find(str, "cff0070dd", 1, true) or string.find(str, "cffa335ee", 1, true) then -- rare or epic
		return true
	end
	plr:SendBroadcastMessage("Do not try to cheat the system. Only rare or epic items can be transmog'd.")
	return false
end

function RemoveTransmog(slot, player)
	slot = slot - 1
	local pGUID = tostring(player:GetGUID())
	if (Transmogs[pGUID] and Transmogs[pGUID][slot]) then
		local item = player:GetInventoryItem(INV_BAG, slot)
		if (item) then
			local iGUID = tostring(item:GetGUID())
			if (Transmogs[pGUID][slot][iGUID]) then
				player:SetUInt32Value(VISIBLE_ITEM_ENTRY_0+(slot * 2), item:GetEntryId())
				Transmogs[pGUID][slot][iGUID] = nil
				CharDBQuery('DELETE FROM Transmog_items WHERE item_GUID = "'..iGUID..'"')
				return true
			end
		end
	end
	return false
end

function LoadTransmogs()
	Transmogs = {}
	-- CharDBQuery("DELETE FROM transmog_items WHERE NOT EXISTS (SELECT 1 FROM playeritems WHERE item_GUID = guid) OR NOT EXISTS (SELECT 1 FROM characters WHERE player_GUID = guid)") -- cleanup before load
	local Q = CharDBQuery("SELECT player_GUID, item_GUID, slot, fake FROM Transmog_items")
	if (Q) then
		for i = 1, Q:GetRowCount() do
			local pGUID, iGUID, slot, fake = Q:GetColumn(0):GetString(), Q:GetColumn(1):GetString(), Q:GetColumn(2):GetULong(), Q:GetColumn(3):GetULong()
			if (not Transmogs[pGUID]) then
				Transmogs[pGUID] = {}
			end
			if (not Transmogs[pGUID][slot]) then
				Transmogs[pGUID][slot] = {}
			end
			Transmogs[pGUID][slot][iGUID] = fake
			Q:NextRow()
		end
	end
end

function ApplyTransmogs() -- minimum looping and checking
	local players = GetPlayersInWorld()
	for _,player in ipairs(players) do -- loop players
		if (player and player:IsInWorld()) then -- player exists
			local pGUID = player:GetGUID()
			if not pGUID then
				return
			else
				pGUID = tostring(pGUID)
			end
			if (Transmogs[pGUID]) then -- has transmogs
				for slot, Data in pairs(Transmogs[pGUID]) do -- looop transmog slots
					local item = player:GetInventoryItem(-1, slot)
					if (item) then -- has item in slot
						local iGUID = tostring(item:GetGUID())
						if(Data[iGUID]) then -- check if item has transmog saved
							player:SetUInt32Value(283+(slot * 2), Data[iGUID]) -- apply transmog
						end
					end
				end
			end
		end
	end
end

LoadTransmogs()
CreateLuaEvent(ApplyTransmogs, DELAY, 0)