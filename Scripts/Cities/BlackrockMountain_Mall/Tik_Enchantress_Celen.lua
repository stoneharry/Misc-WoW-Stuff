--[[ NOT USED

function TIK_enchantress_OnGossip(pUnit,event,player)
	pUnit:VendorRemoveAllItems()
		if player:HasItem(18154) == true then  --GM only, for now.
		pUnit:GossipCreateMenu(57017, player, 0)
		pUnit:GossipMenuAddItem(1,"Cloth",2,0)
		pUnit:GossipMenuAddItem(1,"Mail",3,0)
		pUnit:GossipMenuAddItem(1,"Leather",5,0)
		--pUnit:GossipMenuAddItem(1,"Weapons",4,0)  --For use at a later date :P
		pUnit:GossipMenuAddItem(0,"Nevermind",999,0)
		pUnit:GossipSendMenu(player)
		else
		pUnit:GossipCreateMenu(57023, player, 0)
		pUnit:GossipMenuAddItem(0,"Goodbye then...",999,0)
		if player:HasItem(18154) == true then
		pUnit:GossipMenuAddItem(4,"DEBUG BUTTON",999,0)
		end
	pUnit:GossipSendMenu(player)
	player:SendBroadcastMessage("Celen's shop is not open yet.")
	end
end

function TIK_enchantress_OnSelect(pUnit,event,player,id,intid,code)


if (intid == 2) then --Cloth
	pUnit:VendorRemoveAllItems() --Removes any previous items, so if one player opens Leather, and another Cloth it will not show both.
	pUnit:VendorAddItem(22667,1,2708) --Item ID, Quantity, Special cost (This case, 75 Emblem of Triumph)
	pUnit:VendorAddItem(4197,1,2708)
	pUnit:VendorAddItem(25711,1,2708)
	pUnit:VendorAddItem(31461,1,2708)
	player:SendVendorWindow(pUnit)
end

if (intid == 3) then -- Mail
	pUnit:VendorRemoveAllItems()
	pUnit:VendorAddItem(30951,1,2708)
	pUnit:VendorAddItem(30019,1,2708)
	pUnit:VendorAddItem(18421,1,2708)
	pUnit:VendorAddItem(12945,1,2708)
	pUnit:VendorAddItem(12588,1,2708)
	player:SendVendorWindow(pUnit)
end

if (intid == 4) then --Weapons
	pUnit:VendorRemoveAllItems()
	pUnit:VendorAddItem(2169,1,0)
	player:SendVendorWindow(pUnit)
end


if (intid == 5) then --Leather
	pUnit:VendorRemoveAllItems()
	pUnit:VendorAddItem(29340,1,2708)
	pUnit:VendorAddItem(20216,1,2708)
	pUnit:VendorAddItem(30369,1,2708)
	pUnit:VendorAddItem(25790,1,2708)
	pUnit:VendorAddItem(22112,1,2708)
	pUnit:VendorAddItem(22668,1,2708)
	player:SendVendorWindow(pUnit)
end



if (intid == 999) then
	player:GossipComplete()
	end
end

RegisterUnitGossipEvent(60006, 1, "TIK_enchantress_OnGossip")
RegisterUnitGossipEvent(60006, 2, "TIK_enchantress_OnSelect")

]]