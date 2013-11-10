
function Proffesion_ONClick(pUnit, event, player)
	proffesionmenu(pUnit, player)
end

function proffesionmenu(pUnit, player)
if pUnit:GetDisplay() == 7834 then
pUnit:GossipCreateMenu(565, player, 0)
else
	pUnit:GossipCreateMenu(3802, player, 0)
	end
	local amount = CharDBQuery("SELECT * FROM character_proffesion WHERE name = '"..player:GetName().."';")
	if amount == nil then
		pUnit:GossipMenuAddItem(7, "What's the difference between a miner and a lumberjack?", 5, 0)
		pUnit:GossipMenuAddItem(3, "I would like to become a miner.", 2, 0)
		pUnit:GossipMenuAddItem(3, "I would like to become a lumberjack.", 3, 0)
	else
		if (not player:HasAchievement(116)) then
			player:AddAchievement(116)
		end
		if amount:GetColumn(0):GetString() == "miner" then
			pUnit:GossipMenuAddItem(7, "How does being a miner work?", 9, 0)
			pUnit:GossipMenuAddItem(3, "Unlearn current proffesion.", 6, 0)
			if (not player:HasItem(40893)) then
				player:AddItem(40893,1)
			end
			if (not player:HasItem(5956)) then
				player:AddItem(5956, 1)
			end
			pUnit:GossipMenuAddItem(3, "Convert 3 [Dark Iron Ore] into 1 [Dark Iron Bar].", 100, 0)
			pUnit:GossipMenuAddItem(3, "Convert 5 [Dark Iron Ore] into 1 [Bronze Bar].", 101, 0)
			--[[
			pUnit:GossipMenuAddItem(3, "Your skill in mining is: "..amount:GetColumn(2):GetString()..".", 4, 0)
			pUnit:GossipMenuAddItem(3, "Show me the items I can create at my current skill level.", 10, 0)
			--pUnit:GossipMenuAddItem(4, "Create the miner's dream.", 30, 0)]]
		else
			pUnit:GossipMenuAddItem(7, "How does being a lumberjack work?", 11, 0)
			pUnit:GossipMenuAddItem(3, "Unlearn current proffesion.", 6, 0)
			pUnit:GossipMenuAddItem(3, "Convert 10 [Wood] into 1 [Bolt of Mageweave].", 200, 0)
			pUnit:GossipMenuAddItem(3, "Convert 4 [Wood] into 1 [Wildvine].", 201, 0)
			pUnit:GossipMenuAddItem(3, "Convert 2 [Wood] into 1 [Heart of the Wild].", 202, 0)
			pUnit:GossipMenuAddItem(3, "Convert 5 [Wood] into 1 [Heavy Silken Thread].", 203, 0)
			pUnit:GossipMenuAddItem(3, "Convert 25 [Badges of Justice] into 1 [Truesilver Bar] and 1 [Jade].", 204, 0)
			--[[pUnit:GossipMenuAddItem(3, "Your skill in wood cutting is: "..amount:GetColumn(2):GetString()..".", 4, 0)
			pUnit:GossipMenuAddItem(3, "Show me the items I can create at my current skill level.", 12, 0)
			--pUnit:GossipMenuAddItem(4, "Create the lumberjack's dream.", 31, 0)]]
		end
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 1, 0)
	pUnit:GossipSendMenu(player)
end

function ProffesionOnGossip(pUnit, event, player, id, intid, code)
	if (intid == 1) then
		player:GossipComplete()
	elseif intid == 2 then
		pUnit:CastSpellOnTarget(66390,player)
	    player:SendBroadcastMessage("|cffffff00You have learned Mining! Check your spell book and the 'Blacksmithing' button.|r")
		CharDBQuery("INSERT INTO character_proffesion VALUES ('miner','"..player:GetName().."','0');")
		player:AddSkill(164, 1, 100)
		player:AddSkill(186, 1, 1)
		player:UnlearnSpell(2663)
		player:UnlearnSpell(12260)
		player:UnlearnSpell(2657)
		player:LearnSpell(2018)
		player:LearnSpell(34979) -- thick bronze darts
		player:LearnSpell(3320) -- rough grinding stone
		player:LearnSpell(43549) -- heavy copper longsword
		proffesionmenu(pUnit, player)
	elseif intid == 3 then
		player:AddSkill(197, 1, 100)
		player:LearnSpell(3908) -- tailoring
		pUnit:CastSpellOnTarget(66390,player)
		player:LearnSpell(54705)
		player:LearnSpell(12092) -- titan dismantler
		player:UnlearnSpell(3915)
		player:UnlearnSpell(12044)
		player:UnlearnSpell(2387)
		player:UnlearnSpell(2963)
		player:SendBroadcastMessage("|cffffff00You have learned Woodcutting!|r")
		CharDBQuery("INSERT INTO character_proffesion VALUES ('lumber','"..player:GetName().."','0');")
		proffesionmenu(pUnit, player)
	elseif intid == 4 then
		proffesionmenu(pUnit, player)
	elseif intid == 5 then
		pUnit:GossipCreateMenu(7363, player, 0)
		if pUnit == nil then
			pUnit:GossipMenuAddItem(0, "debug.", 4, 0)
		end
		pUnit:GossipMenuAddItem(0, "Alright.", 4, 0)
		pUnit:GossipSendMenu(player)
	elseif intid == 6 then
		pUnit:GossipCreateMenu(3802, player, 0)
		pUnit:GossipMenuAddItem(4, "Are you sure you wish to unlearn your current proffesion? (You will loose your skill level and it cannot be recovered!)", 6, 0)
		pUnit:GossipMenuAddItem(0, "Yes.", 7, 0)
		pUnit:GossipMenuAddItem(0, "No.", 4, 0)
		pUnit:GossipSendMenu(player)
	elseif intid == 7 then
		local amount = CharDBQuery("SELECT * FROM character_proffesion WHERE name = '"..player:GetName().."';")
		if amount:GetColumn(0):GetString() == "miner" then
			player:UnlearnSpell(2018)
			player:RemoveSkill(164)
			player:RemoveSkill(186)
			player:RemoveSkill(2656)
		else
			player:RemoveSkill(197, 1, 100)
			player:UnlearnSpell(3908) -- tailoring
		end
		CharDBQuery("DELETE FROM character_proffesion WHERE name = '"..player:GetName().."';")
		pUnit:CastSpellOnTarget(46331,player)
		proffesionmenu(pUnit, player)
	elseif intid == 100 then
		-- convert to dark iron bar
		if player:GetItemCount(2835) > 2 then
			player:CastSpell(32990)
			player:RemoveItem(2835, 3)
			player:AddItem(2840, 1)
		else
			player:SendBroadcastMessage("You do not have enough [Dark Iron Ore]!")
		end
		player:GossipComplete()
	elseif intid == 101 then
		-- convert to bronze bar
		if player:GetItemCount(2835) > 4 then
			player:CastSpell(32990)
			player:RemoveItem(2835, 5)
			player:AddItem(2841, 1)
		else
			player:SendBroadcastMessage("You do not have enough [Dark Iron Ore]!")
		end
		player:GossipComplete()
	elseif intid == 200 then
		if player:GetItemCount(11291) > 9 then -- bolt of mageweave
			player:CastSpell(32990)
			player:RemoveItem(11291, 10)
			player:AddItem(4339, 1)
		else
			player:SendBroadcastMessage("You do not have enough [Wood]!")
		end
		player:GossipComplete()	
	elseif intid == 201 then
		if player:GetItemCount(11291) > 3 then -- Wildvine
			player:CastSpell(32990)
			player:RemoveItem(11291, 4)
			player:AddItem(8153, 1)
		else
			player:SendBroadcastMessage("You do not have enough [Wood]!")
		end
		player:GossipComplete()		
	elseif intid == 202 then
		if player:GetItemCount(11291) > 1 then -- Heart of the wild
			player:CastSpell(32990)
			player:RemoveItem(11291, 2)
			player:AddItem(10286, 1)
		else
			player:SendBroadcastMessage("You do not have enough [Wood]!")
		end
		player:GossipComplete()		
	elseif intid == 203 then
		if player:GetItemCount(11291) > 4 then -- Heavy silken Thread
			player:CastSpell(32990)
			player:RemoveItem(11291, 5)
			player:AddItem(8343, 1)
		else
			player:SendBroadcastMessage("You do not have enough [Wood]!")
		end
		player:GossipComplete()
	elseif intid == 204 then
		if player:GetItemCount(29434) > 24 then -- Heavy silken Thread
			player:CastSpell(32990)
			player:RemoveItem(29434, 25)
			player:AddItem(6037, 1)
			player:AddItem(1529, 1)
		else
			player:SendBroadcastMessage("You do not have enough [Badge of Justice]!")
		end
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(122921, 1, "Proffesion_ONClick")
RegisterUnitGossipEvent(122921, 2, "ProffesionOnGossip")

RegisterUnitGossipEvent(440963, 1, "Proffesion_ONClick")
RegisterUnitGossipEvent(440963, 2, "ProffesionOnGossip")

-- Mining
-- Use vein 147516, item 40893

local CooldownTime = {}
local ClickPrevent = {}

function Pickaxe_Proffesion(item, event, player)
	local target = player:GetGameObjectNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 147516)
	if target ~= nil then
		if player:GetDistanceYards(target) < 6.5 then
			if ClickPrevent[player:GetName()] == "clicked" and ((os.clock()-CooldownTime[player:GetName()])) <= 3 then
				player:SendAreaTriggerMessage("|cFFFF0000You have already mined this.")
			else
				ClickPrevent[player:GetName()] = "clicked"
				CooldownTime[player:GetName()] = os.clock()
				--[[local amount = CharDBQuery("SELECT `skill` FROM character_proffesion WHERE name = '"..player:GetName().."';")
				if amount ~= nil then
					amount = amount:GetColumn(0):GetString()
					if tonumber(amount) < 26 or tonumber(amount) == 0 then
						CharDBQuery("UPDATE character_proffesion SET `skill` = skill+1 WHERE `name` = '"..player:GetName().."';")
					end
				end]]
				player:FullCastSpell(2575)
				player:SpawnCreature(77190 ,target:GetX(), target:GetY(), target:GetZ(), 0, 35, 3500)
				target:Despawn(2600, math.random(190000, 2960000))
			end
		else
			player:SendAreaTriggerMessage("|cFFFF0000You need to be closer!")
		end
	else
		player:SendAreaTriggerMessage("|cFFFF0000There is no vein nearby!")
	end
end

function additem_toplayer(pUnit,Event)
	local player = pUnit:GetClosestPlayer()
	if player ~= nil then
		player:AddItem(2835, math.random(1,2)) -- Dark Iron Ore
		--local amount = CharDBQuery("SELECT `skill` FROM character_proffesion WHERE name = '"..player:GetName().."';"):GetColumn(0):GetString()
		--player:AdvanceSkill(164, 1)
		--player:SendBroadcastMessage("|cff3e3effYour skill in Mining has increased to "..tostring(player:GetCurrentSkill(164))..".")
		--player:SendBroadcastMessage("|cffffff00Your skill in mining has increased to "..amount..".")
	end
end


RegisterItemGossipEvent(40893, 1, "Pickaxe_Proffesion")

function OreDummy(pUnit,Event) -- for every node, sadly you need a dummy =(
	pUnit:RegisterEvent("additem_toplayer", 2600, 1)
end

RegisterUnitEvent(77190, 18, "OreDummy")

-- Lumbering
-- Use westfall trees

ClickLumberPrevent = {}
CooldownLumberTime = {}

function Proffesion_ChopTreeSmall(pUnit, event, player)
	if player:IsMounted() then
		player:Dismount()
	end
	if ClickLumberPrevent[player:GetName()] == "clicked" and ((os.clock()-CooldownLumberTime[player:GetName()])) <= 3 then
		player:SendAreaTriggerMessage("|cFFFF0000You are already chopping this.")
	else
		ClickLumberPrevent[player:GetName()] = "clicked"
		CooldownLumberTime[player:GetName()] = os.clock()
		local amount = CharDBQuery("SELECT * FROM character_proffesion WHERE name = '"..player:GetName().."';")
		if amount:GetColumn(0):GetString() ~= "lumber" then
			player:FullCastSpell(62854)
			pUnit:Kill(pUnit)
		else
			player:FullCastSpell(62854)
			pUnit:SetNPCFlags(2)
			pUnit:SpawnCreature(108292, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 6000)
		end
	end
end

RegisterUnitGossipEvent(169772, 1, "Proffesion_ChopTreeSmall")

function Proffesion_TreeSpawn(pUnit, event)
	pUnit:SetNPCFlags(1)
end

RegisterUnitEvent(169772, 18, "Proffesion_TreeSpawn")

function Proffesion_LumberTrigger(pUnit, event)
	pUnit:RegisterEvent("AdvancedProffesionLumberskill", 1500, 1)
end

function AdvancedProffesionLumberskill(pUnit)
	local player = pUnit:GetClosestPlayer()
	if player ~= nil then
		player:AddItem(11291, 1) -- wood
		--player:AdvanceSkill(197, 1)
		local creature = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 169772)
		if creature ~= nil then
			creature:Kill(creature)
		end
	end
end

RegisterUnitEvent(108292, 18, "Proffesion_LumberTrigger")

--