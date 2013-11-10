
function Soultrader_On_Gossip(pUnit, event, player)
local Owner = pUnit:GetPetOwner()
		if Owner then
		pUnit:GossipCreateMenu(3494, player, 0)
		pUnit:GossipMenuAddItem(6, "I wish to use the bank.", 2, 0)
		pUnit:GossipMenuAddItem(6, "I wish to buy or sell.", 3, 0)
				--pUnit:GossipMenuAddItem(6, "I wish to repair my items.(1 gold fee)", 4, 0)
		    pUnit:GossipSendMenu(player)
	else
		player:SendAreaTriggerMessage("|cffffff00You do not own this unit.|r")
	end
end

function Soultrader_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if (intid == 2) then
	player:SendBankWindow(pUnit)
			player:GossipComplete()
			elseif (intid == 3) then
			pUnit:VendorRemoveAllItems()
						pUnit:VendorAddItem(2901,1, 0)
			pUnit:VendorAddItem(4536,5, 0)
			pUnit:VendorAddItem(4539,5, 0)
			pUnit:VendorAddItem(4538,5, 0)
			pUnit:VendorAddItem(117,5, 0)
			pUnit:VendorAddItem(2287,5, 0)
			pUnit:VendorAddItem(3770,5, 0)
			pUnit:VendorAddItem(159,5, 0)
			pUnit:VendorAddItem(1179,5, 0)
			pUnit:VendorAddItem(1205,5, 0)
			pUnit:VendorAddItem(2515,200, 0)
			pUnit:VendorAddItem(2512,200, 0)
						pUnit:VendorAddItem(3464,200, 0)
						pUnit:VendorAddItem(32761,200, 0)
						pUnit:VendorAddItem(5177,1, 0)
						pUnit:VendorAddItem(5178,1, 0)
						pUnit:VendorAddItem(5175,1, 0)
						pUnit:VendorAddItem(5176,1, 0)
						pUnit:VendorAddItem(6947,1, 0)
						pUnit:VendorAddItem(3775,1, 0)
						player:SendVendorWindow(pUnit)
			player:GossipComplete()
			elseif (intid == 4) then
			player:RepairAllPlayerItems()
			player:DealGoldCost(10000)
			player:GossipComplete()
	elseif(intid == 250) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(27914, 1, "Soultrader_On_Gossip")
RegisterUnitGossipEvent(27914, 2, "Soultrader_Gossip_Submenus")