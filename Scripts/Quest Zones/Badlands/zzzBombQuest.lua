
local bomb = nil
local canstart = false
local timeleft = 5

local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3

local nax, nay, naz, nao = -6478, -2452, 306.7, 0
local nbx, nby, nbz, nbo = -6456, -2380, 297, 0
local ncx, ncy, ncz, nco = -6536, -2409, 288, 0

function Guy_BadlandsBombOndead(pUnit)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(42,0,"You have failed the event.")
	canstart = true
end

RegisterUnitEvent(361012, 4, "Guy_BadlandsBombOndead")

function BombingQuestBadlandsGossip(pUnit, event, player)
    pUnit:GossipCreateMenu(5577, player, 0)
    if player:HasQuest(6501) == true then
		pUnit:GossipMenuAddItem(9, "Let's do this.", 11, 0)
    end
	pUnit:GossipMenuAddItem(0, "Not yet.", 3, 0)
    pUnit:GossipSendMenu(player)
end

function BombingQuestBadlandsClick(pUnit, event, player, id, intid, code)
	if(intid == 11) then
		player:GossipComplete()
		bomb = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 7915)
		if bomb ~= nil then
			canstart = true
			pUnit:SetNPCFlags(2)
			pUnit:SendChatMessage(12,0,"Let's get it on.")
		end
	end
	if(intid == 3) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(361012, 1, "BombingQuestBadlandsGossip")
RegisterUnitGossipEvent(361012, 2, "BombingQuestBadlandsClick")

function CanStartBombingQuest(pUnit, event)
	pUnit:RegisterEvent("CheckForSTart_bomb", 5000, 0)
end

RegisterUnitEvent(361012, 18, "CanStartBombingQuest")

function CheckForSTart_bomb(pUnit)
	if canstart then
		if bomb ~= nil then
			canstart = false
			pUnit:RemoveEvents()
			pUnit:MoveTo(-6491, -2427, 296, 0)
			pUnit:RegisterEvent("BeginBombingEvent_Badlands", 6000, 1)
		end
	end
end

function BeginBombingEvent_Badlands(pUnit)
	pUnit:SendChatMessage(14,0,"Arm the bomb!")
	bomb:Root()
	pUnit:PlayMusicToSet(17486) -- gnome invasion
	timeleft = 5
	for place, plrs in pairs(pUnit:GetInRangePlayers()) do
		SendStateToPlayers(plrs)
	end
	pUnit:RegisterEvent("UpdateTimeLeft_timeleftBadlands", 60000, 5)
	pUnit:RegisterEvent("SpawnMobs_EveryFewSeconds", 2000, 0)
end

function SpawnMobs_EveryFewSeconds(pUnit)
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
	elseif choice == 2 then
		pUnit:SpawnCreature(65011, nbx, nby, nbz, nbo, 14, 120000)	
	elseif choice == 3 then
		pUnit:SpawnCreature(65011, ncx, ncy, ncz, nco, 14, 120000)
	end
end

function UpdateTimeLeft_timeleftBadlands(pUnit)
	timeleft = timeleft - 1
	for place, plrs in pairs(pUnit:GetInRangePlayers()) do
		SendStateToPlayers(plrs)
	end
	if timeleft == 0 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"Victory is ours! Detonate it!")
		pUnit:RegisterEvent("ResetWorldstates_Bomb", 2000, 1)
	elseif timeleft == 4 then
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		for place, creatures in pairs(pUnit:GetInRangeEnemies()) do
			if creatures ~= nil then
				if creatures:IsInWorld() then
					if (not creatures:IsAlive()) then
						creatures:Despawn(0,0)
					end
				end
			end
		end
		pUnit:PlayMusicToSet(17487) -- gnome invasion
	elseif timeleft == 3 then
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		for place, creatures in pairs(pUnit:GetInRangeEnemies()) do
			if creatures ~= nil then
				if creatures:IsInWorld() then
					if (not creatures:IsAlive()) then
						creatures:Despawn(1,0)
					end
				end
			end
		end
		pUnit:PlayMusicToSet(17485) -- gnome invasion
	elseif timeleft == 2 then
		for place, creatures in pairs(pUnit:GetInRangeEnemies()) do
			if creatures ~= nil then
				if creatures:IsInWorld() then
					if (not creatures:IsAlive()) then
						creatures:Despawn(1,0)
					end
				end
			end
		end
		pUnit:PlayMusicToSet(17487) -- gnome invasion
	elseif timeleft == 1 then
		pUnit:PlayMusicToSet(17486) -- gnome invasion
		for place, creatures in pairs(pUnit:GetInRangeEnemies()) do
			if creatures ~= nil then
				if creatures:IsInWorld() then
					if (not creatures:IsAlive()) then
						creatures:Despawn(1,0)
					end
				end
			end
		end
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
		pUnit:SpawnCreature(65011, nax, nay, naz, nao, 14, 120000)
	end
end

function SendStateToPlayers(plrs)
	local pack = LuaPacket:CreatePacket(SMSG_INIT_WORLD_STATES, 18)
	pack:WriteULong(489) -- Map
	pack:WriteULong(3277) -- Zone
	pack:WriteULong(0)
	pack:WriteUShort(2)
	pack:WriteULong(4247) -- ID
	pack:WriteULong(1) -- Value
	plrs:SendPacketToPlayer(pack)
	pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
	pack:WriteULong(4248) -- ID, minutes remaining
	pack:WriteULong(timeleft) -- Value
	plrs:SendPacketToPlayer(pack)
end

function ResetWorldstates_Bomb(pUnit)
	for place, plrs in pairs(pUnit:GetInRangePlayers()) do
		local pack = LuaPacket:CreatePacket(SMSG_INIT_WORLD_STATES, 18)
		pack:WriteULong(0) -- Map
		pack:WriteULong(0) -- Zone
		pack:WriteULong(0)
		pack:WriteUShort(0)
		pack:WriteULong(0) -- ID
		pack:WriteULong(0) -- Value
		plrs:SendPacketToPlayer(pack)
		pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
		pack:WriteULong(0) -- ID, minutes remaining
		pack:WriteULong(0) -- Value
		plrs:SendPacketToPlayer(pack)
		if plrs:HasQuest(6501) then
			plrs:MarkQuestObjectiveAsComplete(6501, 0)
		end
	end
	for place, creatures in pairs(pUnit:GetInRangeEnemies()) do
		if creatures ~= nil then
			if creatures:IsInWorld() then
				creatures:CastSpell(34602)
				if creatures:IsAlive() then
					pUnit:Kill(creatures)
				end
			end
		end
	end
	bomb:CastSpell(46995) -- stomp
	bomb:CastSpell(46225) -- huge fire
	pUnit:PlayMusicToSet(17484) -- explosion
	pUnit:SetNPCFlags(1)
	pUnit:RegisterEvent("CheckForSTart_bomb", 5000, 0)
end

-------------------------

function DisruptionInvader(pUnit,Event)
	if pUnit:GetDisplay() == 21234 then
		pUnit:RegisterEvent("DisEarthz_Rend",9000,0)
	elseif pUnit:GetDisplay() == 171 then
		pUnit:RegisterEvent("DisEarth_Earthshock",6000,0)
	elseif pUnit:GetDisplay() == 11010 then
		pUnit:RegisterEvent("DisEarth_Acidic",8000,0)
	end
end

function DisEarth_Earthshock(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target ~= nil then
		if pUnit:GetDistanceYards(target) < 12 then
			pUnit:CastSpellOnTarget(8044,target)
		end
	end
end

function DisEarth_Acidic(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target ~= nil then
		if pUnit:GetDistanceYards(target) < 5 then
			pUnit:CastSpellOnTarget(18070,target)
		end
	end
end

function DisEarthz_Rend(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target ~= nil then
		if pUnit:GetDistanceYards(target) < 5 then
			pUnit:CastSpellOnTarget(772,target)
		end
	end
end

function Disrupterbomber(pUnit,Event)
	pUnit:RemoveEvents()
end

function Disruptionspawn(pUnit)
	pUnit:RegisterEvent("bomb_chancetospawn", 1000, 1)
end

function bomb_chancetospawn(pUnit)
	pUnit:SetMovementFlags(1)
	pUnit:MoveTo(-6490, -2418, 293.67, 0)
end

RegisterUnitEvent(65011, 2, "Disrupterbomber")
RegisterUnitEvent(65011, 1, "DisruptionInvader")
RegisterUnitEvent(65011, 18, "Disruptionspawn")
