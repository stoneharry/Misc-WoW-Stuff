
local start = false
local i = 0
local objectend = 0x0006 + 0x0035
local coords = {4701, 3004, 4702, 3051}

function KeymasterGossip(pUnit, event, player)
	pUnit:GossipCreateMenu(60015, player, 0)
	pUnit:GossipMenuAddItem(9, "Let us begin.", 1, 0)
	pUnit:GossipMenuAddItem(0, "I'm not ready yet.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function KeymasterGossip2(pUnit, event, player, id, intid, code)
	player:GossipComplete()
	if (intid == 1) then
		pUnit:SetNPCFlags(2)
		start = true
	end
end

RegisterUnitGossipEvent(240482, 1, "KeymasterGossip")
RegisterUnitGossipEvent(240482, 2, "KeymasterGossip2")

function KeymasterStart(pUnit, Event)
	pUnit:RegisterEvent("KeymasterCheckStart", 1000, 0)
end

RegisterUnitEvent(240482, 18, "KeymasterStart")

function KeymasterCheckStart(pUnit)
	if start then
		start = false
		pUnit:MoveTo(4703.5, -3024.5, 1074.4, 0.894610)
		pUnit:RegisterEvent("KeymasterAITick", 1000, 0)
	end
end

function KeymasterAITick(pUnit)
	i = i + 1
	if i == 2 then
		pUnit:SendChatMessage(12,0,"This will not be easy. If we are to make it through this, you must protect me at all costs.")
	elseif i == 5 then
		pUnit:ChannelSpell(30946, pUnit)
	elseif i == 7 then
		pUnit:SendChatMessage(12,0,"I'm burning up... inside... the pain...")
	elseif i == 10 then
		pUnit:SpawnCreature(442200, 4715, -3007, 1082.3, 3.946899, 17, 120000)
		pUnit:SpawnCreature(442200, 4719, -3011, 1082.3, 3.9, 17, 120000)
	elseif i == 20 then
		pUnit:RegisterEvent("RandomExplosionsKey", 1000, 1)
	elseif i == 30 then
		pUnit:SendChatMessage(12,0,"I am... making... progress.")
	elseif i == 40 then
		pUnit:SpawnCreature(442200, 4715, -3007, 1082.3, 3.946899, 17, 120000)
		pUnit:SpawnCreature(442200, 4719, -3011, 1082.3, 3.9, 17, 120000)
	elseif i == 90 then
		pUnit:SendChatMessage(14,0,"NO!")
		pUnit:SpawnCreature(442200, 4715, -3007, 1082.3, 3.946899, 17, 120000)
		pUnit:SpawnCreature(442200, 4719, -3011, 1082.3, 3.9, 17, 120000)
		pUnit:SpawnCreature(442200, 4715, -3007, 1082.3, 3.946899, 17, 120000)
		pUnit:SpawnCreature(442200, 4719, -3011, 1082.3, 3.9, 17, 120000)
	elseif i == 120 then
		pUnit:SendChatMessage(12,0,"I am almost there. Just a little longer.")
	elseif i == 150 then
		pUnit:SendChatMessage(12,0,"The legions commander approaches...")
	elseif i == 155 then
		pUnit:SpawnCreature(228331, 4717, -3008, 1082.3, 3.97, 17, 120000, 32374, 0, 0)
	elseif i == 340 then
		pUnit:SendChatMessage(42,0,"Closing the portal failed.")
		pUnit:RemoveEvents()
		i = 0
		pUnit:ReturnToSpawnPoint()
		pUnit:StopChannel()
		pUnit:SetNPCFlags(3)
		pUnit:RegisterEvent("KeymasterCheckStart", 1000, 0)
	end
end

function RandomExplosionsKey(pUnit)
	local nx = math.random(coords[1], coords[3])
	local ny = math.random(coords[2], coords[4])
	pUnit:SpawnCreature(116102, nx, -ny, 1074, 0, 35, 5000)
	pUnit:RegisterEvent("RandomExplosionsKey", math.random(500, 2500), 1)
end

function AddsSpawnKeymaster(pUnit, Event)
	pUnit:RegisterEvent("AddsAttackKeymaster", 800, 1)
end

-- This function is used by scripts accross the zone
function AddsAttackKeymaster(pUnit)
	pUnit:CastSpell(61456) -- spawn visual
	local plr = pUnit:GetClosestPlayer()
	if plr then
		pUnit:AttackReaction(plr, 1, 0)
	end
end

RegisterUnitEvent(442200, 18, "AddsSpawnKeymaster")

function DummyExplosKeySpawn(pUnit, Event)
	pUnit:SetUInt32Value(objectend, 0x02000000)
	pUnit:RegisterEvent("DummyKeyExplode", 1000, 1)
end

function DummyKeyExplode(pUnit)
	pUnit:CastSpell(35426)
end

RegisterUnitEvent(116102, 18, "DummyExplosKeySpawn")

function CommanderLegionEvents(pUnit, Event)
	if Event == 1 then
		pUnit:RegisterEvent("WarbringerStrike", 5000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			if v:HasQuest(41104) then
				v:MarkQuestObjectiveAsComplete(41104, 0)
				v:SetPhase(1)
				v:Teleport(1, 4694.6, -3748.7, 947)
			end
		end
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 240482 then
				v:RemoveEvents()
				i = 0
				v:ReturnToSpawnPoint()
				v:StopChannel()
				v:SetNPCFlags(3)
				v:RegisterEvent("KeymasterCheckStart", 1000, 0)				
				break
			end
		end
	elseif Event == 18 then
		pUnit:RegisterEvent("AddsAttackKeymaster", 800, 1)
	end
end

RegisterUnitEvent(228331, 1, "CommanderLegionEvents")
RegisterUnitEvent(228331, 2, "CommanderLegionEvents")
RegisterUnitEvent(228331, 4, "CommanderLegionEvents")
RegisterUnitEvent(228331, 18, "CommanderLegionEvents")
