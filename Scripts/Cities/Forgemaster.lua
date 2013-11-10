--[[
=====dialog===
--
Greetings $C, I am no demon of the legion; only affected by them.
They have changed my appearance and forced me to work on their abberrations,
I have been freed and am ready to forge for you!

Now, what would you like to craft?
--

Misc-11258 What would you like to craft?
Jewelry-10916 What quality jewelry would you like to craft?
Armor-10603  What quality armor would you like to craft?
Weapon-10800 What quality weaponry would you like to craft?


AddItem isn't a method, it's AddItem. Fixed it. Fixed indention too, and cleaned up some code. Just look for the
commented-out blocks. The mining animation doesn't play when you use the vein gameobject either, instead it plays
the regular use animation, and then the looting animation until you close the loot window. //Laurea
P.S: "Decoration" is mainly used for furniture or medals of honor. "Jewelry" is used more often when referring to
metals and/or precious stones worn as a decoration.
P.P.S: The copper vein gameobject still has ores in its loot table, and you don't require a pick to loot it.
P.P.P.S: Error messages should be sent with SendAreaTriggerMessage, so it displays like a real error.
]]

function Forgemaster_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(11258, player, 0)
	pUnit:GossipMenuAddItem(0, "|cff00ff00|TInterface\\icons\\inv_chest_mail_07:30|t|r Armor", 246, 0)
	pUnit:GossipMenuAddItem(0, "|cff00ff00|TInterface\\icons\\inv_sword_58:30|t|r Weapons", 247, 0)
	pUnit:GossipMenuAddItem(0, "|cff00ff00|TInterface\\icons\\item_icecrownringc:30|t|r Jewelry", 248, 0)
	pUnit:GossipMenuAddItem(0, "|cff00ff00|TInterface\\icons\\inv_pick_03:30|t|r Misc.", 249, 0)
	pUnit:GossipMenuAddItem(0, "...Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end

function Forgemaster_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 246) then -- armor
		pUnit:GossipCreateMenu(10603, player, 0)
		pUnit:GossipMenuAddItem(6, "Level 10-14 Armor Craft", 300, 0)
			pUnit:GossipMenuAddItem(6, "Level 15-19 Armor Craft", 301, 0)
			pUnit:GossipMenuAddItem(6, "Level 20-24 Armor Craft", 302, 0)
			pUnit:GossipMenuAddItem(6, "Level 25-29 Armor Craft", 303, 0)
			pUnit:GossipMenuAddItem(6, "Level 30 Armor Craft", 304, 0)
			pUnit:GossipMenuAddItem(6, "Level 30 Superior Armor Craft", 305, 0)
		pUnit:GossipMenuAddItem(0, "Back.", 260, 0)
		pUnit:GossipSendMenu(player)
	elseif(intid == 300) then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(3471,1, 5000)
		pUnit:VendorAddItem(3472,1, 5001)
		pUnit:VendorAddItem(3473,1, 5001)
		pUnit:VendorAddItem(2857,1, 5003)
		pUnit:VendorAddItem(2864,1, 5004)
		pUnit:VendorAddItem(2854,1, 5002)
		pUnit:VendorAddItem(6350,1, 5002)
		pUnit:VendorAddItem(2310,1,6001)
		pUnit:VendorAddItem(2311,1,6002)
		pUnit:VendorAddItem(7281,1,6001)
		pUnit:VendorAddItem(4242,1,6001)
		pUnit:VendorAddItem(2312,1,6001)
		pUnit:VendorAddItem(4246,1,6001)
		pUnit:VendorAddItem(2308,1,6003)
		pUnit:VendorAddItem(4243,1,6007)
		pUnit:VendorAddItem(6709,1,6007)
		pUnit:VendorAddItem(2307,1,6002)
		pUnit:VendorAddItem(7282,1,6004)
		pUnit:VendorAddItem(2300,1,6002)
		pUnit:VendorAddItem(7280,1,6001)
		pUnit:VendorAddItem(2309,1,6002)
		pUnit:VendorAddItem(5781,1,6011)
		pUnit:VendorAddItem(5780,1,6010)
		pUnit:VendorAddItem(4343,1,6013)
		pUnit:VendorAddItem(2572,1,6013)
		pUnit:VendorAddItem(4307,1,6013)
		pUnit:VendorAddItem(6238,1,6013)
		pUnit:VendorAddItem(4309,1,6014)
		pUnit:VendorAddItem(2578,1,6014)
		pUnit:VendorAddItem(4308,1,6014)
		pUnit:VendorAddItem(2580,1,6014)
		pUnit:VendorAddItem(2569,1,6014)
		pUnit:VendorAddItem(10047,1,6014)
		pUnit:VendorAddItem(4312,1,6014)
		pUnit:VendorAddItem(2582,1,6015)
		pUnit:VendorAddItem(4310,1,6015)
		pUnit:VendorAddItem(5542,1,6015)
		pUnit:VendorAddItem(2583,1,6016)
		pUnit:VendorAddItem(14148,1,6017)
		pUnit:VendorAddItem(14150,1,6017)
		pUnit:VendorAddItem(14149,1,6017)
			pUnit:VendorAddItem(14147,1,5004)
		player:SendVendorWindow(pUnit)
		player:GossipComplete()
			elseif(intid == 301) then -- armor 15
					pUnit:VendorRemoveAllItems()
					pUnit:VendorAddItem(7283,1,6003)
					pUnit:VendorAddItem(20575,1,6003)
					pUnit:VendorAddItem(2315,1,6003)
					pUnit:VendorAddItem(2317,1,6003)
					pUnit:VendorAddItem(4244,1,6003)
					pUnit:VendorAddItem(6467,1,6003)
					pUnit:VendorAddItem(5958,1,6003)
					pUnit:VendorAddItem(2316,1,6003)
					pUnit:VendorAddItem(5961,1,6003)
					pUnit:VendorAddItem(6468,1,6005)
					pUnit:VendorAddItem(2314,1,6005)
						pUnit:VendorAddItem(6468,1,6005)
					pUnit:VendorAddItem(3480,1,5003)
						pUnit:VendorAddItem(2865,1,5003)
							pUnit:VendorAddItem(2866,1,5003)
								pUnit:VendorAddItem(6263,1,6022)
									pUnit:VendorAddItem(4311,1,6022)
										pUnit:VendorAddItem(2585,1,6022)
											pUnit:VendorAddItem(4314,1,6022)
												pUnit:VendorAddItem(4316,1,6022)
												pUnit:VendorAddItem(6264,1,6022)
												pUnit:VendorAddItem(4315,1,6022)
							pUnit:VendorAddItem(4320,1,6024)
							pUnit:VendorAddItem(45626,1,6024)
							pUnit:VendorAddItem(14573,1,6038)
							pUnit:VendorAddItem(16793,1,6038)
					player:SendVendorWindow(pUnit)
		player:GossipComplete()
		elseif(intid == 302) then -- armor 20-24
			pUnit:VendorRemoveAllItems()
			pUnit:VendorAddItem(2870,1,6042)
			pUnit:VendorAddItem(4253,1,6042)
			pUnit:VendorAddItem(2800,1,6042)
			pUnit:VendorAddItem(3481,1,6026)
			pUnit:VendorAddItem(3482,1,6026)
			pUnit:VendorAddItem(2869,1,6026)
			pUnit:VendorAddItem(3483,1,6027)
			pUnit:VendorAddItem(3484,1,6027)
				pUnit:VendorAddItem(4251,1,6035)
				pUnit:VendorAddItem(4249,1,6035)
				pUnit:VendorAddItem(7352,1,6035)
				pUnit:VendorAddItem(4252,1,6035)
				pUnit:VendorAddItem(7359,1,6035)
				pUnit:VendorAddItem(4247,1,6035)
				pUnit:VendorAddItem(4249,1,6035)
				pUnit:VendorAddItem(4331,1,6023)
				pUnit:VendorAddItem(4317,1,6023)
				pUnit:VendorAddItem(4318,1,6023)
				pUnit:VendorAddItem(5766,1,6023)
				pUnit:VendorAddItem(7046,1,6023)
				pUnit:VendorAddItem(4321,1,6023)
				pUnit:VendorAddItem(7048,1,6023)
				pUnit:VendorAddItem(4319,1,6023)
				pUnit:VendorAddItem(7047,1,6023)
						player:SendVendorWindow(pUnit)
		player:GossipComplete()
		elseif(intid == 303) then -- armor 24-29
		pUnit:VendorRemoveAllItems()
			pUnit:VendorAddItem(4324,1,6044)
			pUnit:VendorAddItem(5770,1,6044)
			pUnit:VendorAddItem(7049,1,6044)
			pUnit:VendorAddItem(7050,1,6044)
			pUnit:VendorAddItem(4322,1,6044)
			pUnit:VendorAddItem(7065,1,6044)
			pUnit:VendorAddItem(7051,1,6044)
			pUnit:VendorAddItem(4323,1,6044)
			pUnit:VendorAddItem(4254,1,6047)
			pUnit:VendorAddItem(3719,1,6047)
			pUnit:VendorAddItem(4255,1,6047)
			pUnit:VendorAddItem(4257,1,6047)
			pUnit:VendorAddItem(5962,1,6047)
			pUnit:VendorAddItem(7373,1,6047)
			pUnit:VendorAddItem(4456,1,6047)
			pUnit:VendorAddItem(4455,1,6047)
			pUnit:VendorAddItem(5963,1,6047)
			pUnit:VendorAddItem(4258,1,6047)
			pUnit:VendorAddItem(5782,1,6047)
			pUnit:VendorAddItem(18948,1,6048)
			pUnit:VendorAddItem(3485,1,6050)
				pUnit:VendorAddItem(3842,1,6050)
					pUnit:VendorAddItem(10423,1,6050)
						pUnit:VendorAddItem(7914,1,6050)
							pUnit:VendorAddItem(7913,1,6050)
								pUnit:VendorAddItem(3840,1,6050)
									pUnit:VendorAddItem(3835,1,6050)
										pUnit:VendorAddItem(3843,1,6050)
											pUnit:VendorAddItem(3836,1,6050)
						player:SendVendorWindow(pUnit)
		player:GossipComplete()
		elseif(intid == 304) then -- armor 30
			pUnit:VendorRemoveAllItems()
				pUnit:VendorAddItem(32401,1,6063)
				pUnit:VendorAddItem(32402,1,6063)
				pUnit:VendorAddItem(32403,1,6063)
				pUnit:VendorAddItem(32404,1,6063)
				pUnit:VendorAddItem(21648,1,6064)
				pUnit:VendorAddItem(49894,1,6065)
				pUnit:VendorAddItem(50677,1,6065)
			pUnit:VendorAddItem(15138,1,6067)
								player:SendVendorWindow(pUnit)
		player:GossipComplete()
	elseif(intid == 247) then -- weapons
		pUnit:GossipCreateMenu(10800, player, 0)
		pUnit:GossipMenuAddItem(6, "Level 10-14 Weapon Craft", 400, 0)
			pUnit:GossipMenuAddItem(6, "Level 15-19 Weapon Craft", 401, 0)
			pUnit:GossipMenuAddItem(6, "Level 20-25 Weapon Craft", 402, 0)
			pUnit:GossipMenuAddItem(6, "Level 30 Weapon Craft", 404, 0)
			pUnit:GossipMenuAddItem(6, "Level 30 Superior Weapon Craft", 405, 0)
		pUnit:GossipMenuAddItem(0, "Back.", 260, 0)
		pUnit:GossipSendMenu(player)
	elseif(intid == 400) then
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(3488,1, 5001)
		pUnit:VendorAddItem(3489,1, 5000)
		pUnit:VendorAddItem(6214,1, 5003)
		pUnit:VendorAddItem(3487,1, 5004)
		pUnit:VendorAddItem(14151,1, 5004)
		pUnit:VendorAddItem(14145,1, 5004)
		player:SendVendorWindow(pUnit)
		player:GossipComplete()
		elseif(intid == 401) then -- Weapon 15
				pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(5256,1, 6039)
		pUnit:VendorAddItem(11305,1, 6039)
		pUnit:VendorAddItem(3848,1, 5003)
		pUnit:VendorAddItem(2848,1, 5003)
		pUnit:VendorAddItem(5540,1, 5003)
		pUnit:VendorAddItem(2849,1, 5003)
			pUnit:VendorAddItem(2850,1, 5003)
			pUnit:VendorAddItem(9400,1, 5004)
			pUnit:VendorAddItem(1318,1, 5004)
			pUnit:VendorAddItem(5196,1, 5004)
			pUnit:VendorAddItem(5183,1, 5004)
			pUnit:VendorAddItem(2567,1, 5004)
			pUnit:VendorAddItem(1935,1, 5004)
			pUnit:VendorAddItem(7230,1, 5004)
			pUnit:VendorAddItem(1484,1, 5004)
			pUnit:VendorAddItem(1483,1, 5004)
			pUnit:VendorAddItem(12992,1, 5004)
			pUnit:VendorAddItem(5191,1, 5004)
			pUnit:VendorAddItem(20440,1, 5004)
			pUnit:VendorAddItem(10686,1, 5004)
			pUnit:VendorAddItem(10078,1, 5004)
			pUnit:VendorAddItem(25878,1, 5004)
		player:SendVendorWindow(pUnit)
		player:GossipComplete()
			elseif(intid == 402) then -- weapons 20-24
					pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(7956,1, 6028)
		pUnit:VendorAddItem(3490,1, 6028)
		pUnit:VendorAddItem(7957,1, 6028)
		pUnit:VendorAddItem(3491,1, 6028)
		pUnit:VendorAddItem(7958,1, 6028)
		pUnit:VendorAddItem(5541,1, 6028)
					pUnit:VendorAddItem(2941,1, 6040)
			pUnit:VendorAddItem(1976,1, 6041)
			pUnit:VendorAddItem(13041,1, 6041)
			pUnit:VendorAddItem(2098,1, 6041)
		player:SendVendorWindow(pUnit)
		player:GossipComplete()
					elseif(intid == 405) then -- weapons  sup
					pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(50731,1, 6075)
		player:SendVendorWindow(pUnit)
		player:GossipComplete()
	elseif(intid == 248) then -- jewelry
		pUnit:GossipCreateMenu(10916, player, 0)
		pUnit:GossipMenuAddItem(6, "Level 10-14 Jewelry Craft", 500, 0)
			pUnit:GossipMenuAddItem(6, "Level 15-19 Jewelry Craft", 501, 0)
			pUnit:GossipMenuAddItem(6, "Level 20-24 Jewelry Craft", 502, 0)
			pUnit:GossipMenuAddItem(6, "Level 25-29 Jewelry Craft", 503, 0)
			pUnit:GossipMenuAddItem(6, "Level 30 Jewelry Craft", 504, 0)
			pUnit:GossipMenuAddItem(6, "Level 30 Superior Jewelry Craft", 505, 0)
		pUnit:GossipMenuAddItem(0, "Back.", 260, 0)
		pUnit:GossipSendMenu(player)
	elseif(intid == 500) then
		pUnit:VendorRemoveAllItems()
				pUnit:VendorAddItem(20906,1, 5001)
		pUnit:VendorAddItem(21931,1, 5001)
		pUnit:VendorAddItem(21932,1, 5002)
		pUnit:VendorAddItem(25438,1,5002)
		pUnit:VendorAddItem(25439,1, 5002)
		player:SendVendorWindow(pUnit)
		player:GossipComplete()
			elseif(intid == 501) then
					pUnit:VendorRemoveAllItems()
							pUnit:VendorAddItem(20821,1, 5003)
		pUnit:VendorAddItem(21934,1, 5003)
		pUnit:VendorAddItem(20818,1, 5003)
		pUnit:VendorAddItem(20907,1,5003)
		pUnit:VendorAddItem(21933,1, 5003)
		pUnit:VendorAddItem(20820,1, 5003)
		pUnit:VendorAddItem(30804,1, 5003)
		pUnit:VendorAddItem(20823,1, 5003)
		player:SendVendorWindow(pUnit)
		player:GossipComplete()
		elseif(intid == 502) then -- 20/24 jc
			pUnit:VendorRemoveAllItems()
				pUnit:VendorAddItem(1491,1, 6028)
			pUnit:VendorAddItem(20821,1, 6026)
		pUnit:VendorAddItem(30419,1, 6026)
		pUnit:VendorAddItem(20827,1, 6026)
		pUnit:VendorAddItem(20828,1,6026)
		pUnit:VendorAddItem(30420,1, 6026)
		pUnit:VendorAddItem(1076,1, 6026)
		pUnit:VendorAddItem(5029,1, 6027)
		player:SendVendorWindow(pUnit)
		player:GossipComplete()
		elseif(intid == 503) then
			pUnit:VendorRemoveAllItems()
					pUnit:VendorAddItem(20909,1,6049)
						pUnit:VendorAddItem(20955,1,6049)
							pUnit:VendorAddItem(20833,1,6049)
								pUnit:VendorAddItem(5007,1,6049)
						pUnit:VendorAddItem(5180,1,6049)
						pUnit:VendorAddItem(5003,1,6049)
						pUnit:VendorAddItem(5754,1,6049)
						pUnit:VendorAddItem(5002,1,6049)
						pUnit:VendorAddItem(4396,1,6051)
			player:SendVendorWindow(pUnit)
		player:GossipComplete()
				elseif(intid == 504) then -- jewl 30
			pUnit:VendorRemoveAllItems()
					pUnit:VendorAddItem(50644,1,6064)
			player:SendVendorWindow(pUnit)
		player:GossipComplete()
	elseif(intid == 249) then -- misc.
		pUnit:VendorRemoveAllItems()
		pUnit:VendorAddItem(4231,1, 6000)
		pUnit:VendorAddItem(2901,1, 0)
		pUnit:VendorAddItem(70013,1, 6028)
		pUnit:VendorAddItem(2996,1, 6012)
		pUnit:VendorAddItem(2997,1, 6018)
		pUnit:VendorAddItem(4305,1,6043)
		player:SendVendorWindow(pUnit)
		player:GossipComplete()
	elseif(intid == 260) then -- main menu
		Forgemaster_On_Gossip(pUnit, 1, player)
	--[[
		pUnit:GossipCreateMenu(11258, player, 0)
		pUnit:GossipCreateMenu(11258, player, 0)
		pUnit:GossipMenuAddItem(0, "|cff00ff00|TInterface\\icons\\inv_chest_mail_07:30|t|r Armor", 246, 0)
		pUnit:GossipMenuAddItem(0, "|cff00ff00|TInterface\\icons\\inv_sword_58:30|t|r Weapons", 247, 0)
		pUnit:GossipMenuAddItem(0, "|cff00ff00|TInterface\\icons\\item_icecrownringc:30|t|r Jewelry", 248, 0)
		pUnit:GossipMenuAddItem(0, "|cff00ff00|TInterface\\icons\\inv_pick_03:30|t|r Misc.", 249, 0)
		pUnit:GossipMenuAddItem(0, "...Nevermind.", 250, 0)
		pUnit:GossipSendMenu(player)
		]]
	elseif(intid == 250) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(21209, 1, "Forgemaster_On_Gossip")
RegisterUnitGossipEvent(21209, 2, "Forgemaster_Gossip_Submenus")
RegisterUnitGossipEvent(25274, 1, "Forgemaster_On_Gossip")
RegisterUnitGossipEvent(25274, 2, "Forgemaster_Gossip_Submenus")
RegisterUnitGossipEvent(26988, 1, "Forgemaster_On_Gossip")
RegisterUnitGossipEvent(26988, 2, "Forgemaster_Gossip_Submenus")

---Nodes

function CopperOre_OnUseObject(pMisc, event, player)
	if player:HasItem(2901) == false then
		player:SendBroadcastMessage("|cffffff00Requires a mining pick!|r")
	else
		player:Emote(233,2000)
		pMisc:Despawn(1000,math.random(20000,35000))
		--local breakchance = math.random(1,10)
		if math.random(1, 10) == 10 then
			player:RemoveItem(2901,1)
			player:SendBroadcastMessage("|cffffff00Your mining pick has broken!|r")
		end
		local itemchoiceone = math.random(1,5)
		if (itemchoiceone < 3) then
			player:AddItem(2770, itemchoiceone)
		end
		local itemchoicetwo = math.random(1,5)
		if (itemchoicetwo < 4) then
			player:AddItem(2835, itemchoicetwo*2)
		end
		--[[
		if itemchoiceone == 1 then
			player:AddItem(2770,1)
		elseif itemchoiceone == 2 then
			player:AddItem(2770,2)
		elseif itemchoiceone == 3 then
			player:AddItem(2770,3)
		end
		if itemchoicetwo == 1 then
			player:AddItem(2835,2)
		elseif itemchoicetwo == 2 then
			player:AddItem(2835,4)
		elseif itemchoicethree == 3 then
			player:AddItem(2835,6)
		end]]
	end
end

RegisterGameObjectEvent(78291, 4, "CopperOre_OnUseObject")

function TinOre_OnUseObject(pMisc, event, player)
	if player:HasItem(2901) == false then
		player:SendBroadcastMessage("|cffffff00Requires a mining pick!|r")
	else
		player:Emote(233,2000)
		pMisc:Despawn(1000,math.random(20000,35000))
		--local breakchance = math.random(1,10)
		if math.random(1, 10) == 10 then
			player:RemoveItem(2901,1)
			player:SendBroadcastMessage("|cffffff00Your mining pick has broken!|r")
		end
		local itemchoiceone = math.random(1,5)
		if (itemchoiceone < 3) then
			player:AddItem(2771, itemchoiceone)
		end
		local itemchoicetwo = math.random(1,5)
		if (itemchoicetwo < 4) then
			player:AddItem(2771, itemchoicetwo*2)
		end
		--[[
		if itemchoiceone == 1 then
			player:AddItem(2770,1)
		elseif itemchoiceone == 2 then
			player:AddItem(2770,2)
		elseif itemchoiceone == 3 then
			player:AddItem(2770,3)
		end
		if itemchoicetwo == 1 then
			player:AddItem(2835,2)
		elseif itemchoicetwo == 2 then
			player:AddItem(2835,4)
		elseif itemchoicethree == 3 then
			player:AddItem(2835,6)
		end]]
	end
end

RegisterGameObjectEvent(78292, 4, "TinOre_OnUseObject")

function SilverOre_OnUseObject(pMisc, event, player)
	if player:HasItem(70013) == false then
		player:SendBroadcastMessage("|cffffff00Requires a superior mining pick!|r")
	else
		player:Emote(233,2000)
		pMisc:Despawn(1000,math.random(20000,35000))
		--local breakchance = math.random(1,10)
		if math.random(1, 10) == 10 or math.random(1, 10) == 8 or math.random(1, 10) == 3 then
			player:RemoveItem(70013,1)
			player:SendBroadcastMessage("|cffffff00Your mining pick has broken!|r")
		end
		local itemchoiceone = math.random(1,5)
		if (itemchoiceone < 3) then
			player:AddItem(2775, itemchoiceone)
		end
		local itemchoicetwo = math.random(1,5)
		if (itemchoicetwo < 4) then
			player:AddItem(2775, itemchoicetwo*2)
		end
		--[[
		if itemchoiceone == 1 then
			player:AddItem(2770,1)
		elseif itemchoiceone == 2 then
			player:AddItem(2770,2)
		elseif itemchoiceone == 3 then
			player:AddItem(2770,3)
		end
		if itemchoicetwo == 1 then
			player:AddItem(2835,2)
		elseif itemchoicetwo == 2 then
			player:AddItem(2835,4)
		elseif itemchoicethree == 3 then
			player:AddItem(2835,6)
		end]]
	end
end

RegisterGameObjectEvent(78293, 4, "SilverOre_OnUseObject")

function SupplyBag_OnUseObject(pMisc, event, player)
		if player:HasAchievement(60003) == false then
					player:AddAchievement(60003)
					end
end

RegisterGameObjectEvent(78295, 4, "SupplyBag_OnUseObject")