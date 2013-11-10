
local i = 0
local can_start = false
local obja = nil
local objb = nil

local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit

function ThoradinWall_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(205820, player, 0)
	pUnit:GossipMenuAddItem(4, "|cff00ff00|TInterface\\icons\\INV_Misc_EngGizmos_31:30|t|r Hand over the resources required.", 1, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function ThoradinWall_GossipClick(pUnit, event, player, id, intid, code)
	if intid == 1 then
		pUnit:SetNPCFlags(2)
		pUnit:SendChatMessage(12,0,"Fantastic work, "..player:GetName().."! Time to show those gnomes what goblin technology can achieve.")
		can_start = true
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(205820, 1, "ThoradinWall_Gossip")
RegisterUnitGossipEvent(205820, 2, "ThoradinWall_GossipClick")

function Goblin_ThoradinSpawn(pUnit, Event)
	pUnit:RegisterEvent("Thoradin_StartEvent", 3000, 0)
end

RegisterUnitEvent(205820, 18, "Goblin_ThoradinSpawn")

function Thoradin_StartEvent(pUnit)
	if can_start then
		can_start = false
		pUnit:MoveTo(-842.5, -1597.9, 53.8, 0.934246)
		pUnit:RegisterEvent("Thoradin_Events_Handle", 1000, 0)
	end
end

function Thoradin_Events_Handle(pUnit)
	i = i + 1
	if i == 6 then
		pUnit:SendChatMessage(12,0,"Let's see...")
		pUnit:Emote(69, 2500)
	elseif i == 8 then
		objb = pUnit:SpawnGameObject(690377, -841.65, -1596.6, 53.5, 0, 0, 100)
		pUnit:SpawnCreature(18392, -841.65, -1596.6, 54, 1, 35, 0):SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		pUnit:MoveTo(-846.6, -1594.5, 53.6, 0.890507)
	elseif i == 11 then
		pUnit:Emote(69, 2500)
	elseif i == 13 then
		obja = pUnit:SpawnGameObject(690377, -845.5, -1593.2, 53.5, 1, 0, 100)
		pUnit:SpawnCreature(18392, -845.5, -1593.2, 54, 1, 35, 0):SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	elseif i == 15 then
		pUnit:SendChatMessage(12,0,"Right. Time for plan Beta-Bravo-Brandy!")
		pUnit:Emote(15, 0)
	elseif i == 19 then
		pUnit:Emote(60, 0)
	elseif i == 20 then
		pUnit:SendChatMessage(14,0,"Run! Run for your lives!")
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(-862.4, -1617.5, 52.8, 0.924264)
	elseif i == 29 then
		pUnit:Emote(4,0)
		local npc = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 205821)
		if npc then
			npc:SendChatMessage(12,0,"Oh my.")
		end
		local a = pUnit:GetCreatureNearestCoords(-841.65, -1596.6, 54, 18392)
		local b = pUnit:GetCreatureNearestCoords(-845.5, -1593.2, 54, 18392)
		if a then
			a:CastSpell(60852)
			a:Despawn(15000, 0)
		end
		if b then
			b:CastSpell(60852)
			b:Despawn(15000, 0)
		end
		local gate = pUnit:GetGameObjectNearestCoords(-841.2, -1592.44, 54.1486, 690376)
		if gate then
			gate:SetUInt32Value(0x0006+0x0003,0x200) -- damaged
		end
		if obja then
			obja:Despawn(1,0)
		end
		if objb then
			objb:Despawn(1,0)
		end
	elseif i == 33 then
		pUnit:SendChatMessage(12,0,"It didn't go down, but we can soon fix that.")
		pUnit:SetMovementFlags(0)
		pUnit:MoveTo(-845.8, -1597.8, 53.6, 0.887626)
	elseif i == 45 then
		pUnit:SendChatMessage(12,0,"...and this is why I'm called Mr. Smith.")
		pUnit:Emote(69, 5000)
	elseif i == 49 then
		obja = pUnit:SpawnGameObject(690377, -843, -1595, 53.6, 2, 0, 200)
	elseif i == 51 then
		pUnit:Emote(60, 0)
	elseif i == 52 then
		pUnit:Emote(60, 0)
	elseif i == 53 then
		pUnit:Emote(60, 0)
	elseif i == 54 then
		pUnit:SendChatMessage(14,0,"Time to run!")
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(-862.4, -1617.5, 52.8, 0.924264)
		pUnit:SpawnCreature(18392, -843, -1595, 54, 0, 35, 0):SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	elseif i == 63 then
		pUnit:Emote(11,0)
		local a = pUnit:GetCreatureNearestCoords(-843, -1595, 54, 18392)
		if a then
			a:CastSpell(60852)
			a:Despawn(15000, 0)
		end
		local b = pUnit:GetGameObjectNearestCoords(-843, -1595, 53.6, 690377)
		if b then
			b:Despawn(1,0)
		end
		local gate = pUnit:GetGameObjectNearestCoords(-841.2, -1592.44, 54.1486, 690376)
		if gate then
			gate:SetUInt32Value(0x0006+0x0003,0x400) -- destroyed
		end
		pUnit:SetMovementFlags(0)
	elseif i == 66 then
		pUnit:SendChatMessage(12,0,"Come on honey, we're going on an adventure. The profits will be wonderful, we can live how we want as we want. Nobody tells the Smith's what to do...")
		pUnit:MoveTo(-811.4, -1553.8, 54.2, 1.174046)
	elseif i == 72 then
		local npc = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 205821)
		if npc then
			npc:SendChatMessage(12,0,"It sounds so wonderful.")
		end
	elseif i == 75 then
		pUnit:SendChatMessage(12,0,"You bet! The rabbits of Southshore are said to be the fluffiest in all of Azeroth.")
	elseif i == 120 then
		pUnit:ReturnToSpawnPoint()
	elseif i == 160 then
		local gate = pUnit:GetGameObjectNearestCoords(-841.2, -1592.44, 54.1486, 690376)
		if gate then
			gate:RemoveFlag(0x0006+0x0003,0x400)
			gate:RemoveFlag(0x0006+0x0003,0x200)
		end
		pUnit:RemoveEvents()
		i = 0
		pUnit:SetNPCFlags(3)
	end
end