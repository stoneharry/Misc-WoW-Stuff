local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local playa = nil
local crone = nil

local function re()
	if (crone) then
		crone:RegisterEvent("Crone_findnubz", 2000, 0)
	end
	playa = nil
end

function Crone_questz_Spawn(pUnit, Event)
	crone = pUnit
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:StopChannel()
	pUnit:RegisterEvent("Crone_findnubz", 2000, 0)
end

RegisterUnitEvent(43987, 18, "Crone_questz_Spawn")

function Crone_findnubz(pUnit, Event)
	local player = pUnit:GetClosestPlayer()
	if player ~= nil and pUnit:GetDistanceYards(player) < 10 and
	 70 < player:GetZ() and player:HasQuest(5504) == true then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12, 0, "Persistant aren't you my pretty? You will surely pay for being nosey.")
		pUnit:ChannelSpell(66256, player)
		player:SetPlayerLock(1)
		player:Root()
		player:Emote(473, 8000)
		playa = player
		pUnit:RegisterEvent("Crone_nubtransforming", 4000, 1)
	end
end

function Crone_nubtransforming(pUnit, Event)
	local player = playa or pUnit:GetClosestPlayer()
	if (not player) then re(); return; end
	pUnit:SendChatMessage(12, 0, "Find me in Shadowfang Keep when you've learned your place, my pretty.")
	player:CastSpell(63752)
	player:PlaySoundToSet(14375)
	pUnit:RegisterEvent("Crone_Nubtransformed", 4000, 1)
end


function Crone_Nubtransformed(pUnit, Event)
	local player = playa or pUnit:GetClosestPlayer()
	if (not player) then re(); return; end
	pUnit:StopChannel()
	player:CastSpell(64490)
	player:SetPlayerLock(0)
	player:Unroot()
	player:FinishQuest(5504)
	player:StartQuest(5505)
	player:Teleport(0, -378.05, 1658.62, 10.26)
	pUnit:Despawn(1000, 5000)
	crone = nil
end

