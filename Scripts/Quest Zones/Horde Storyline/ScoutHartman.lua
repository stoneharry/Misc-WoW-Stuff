local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local UNIT_FIELD_CHARMEDBY = OBJECT_END + 0x0006
local UNIT_FIELD_CHARM = OBJECT_END + 0x0000
local UNIT_FLAG_PVP_ATTACKABLE = 0x00000008
local UNIT_FLAG_PLAYER_CONTROLLED_CREATURE = 0x01000000
local UNIT_END = OBJECT_END + 0x008E
local PLAYER_DUEL_TEAM = UNIT_END + 0x0008
local PLAYER_DUEL_ARBITER = UNIT_END + 0x0000

CAP = {}
CAP.VAR = {}

function CAP.VAR.ScoutHartman_Spawn(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	pUnit:SetMovementFlags(1)
	CAP[id].VAR.SCOUT = pUnit
	pUnit:RegisterEvent("CAP.VAR.ScoutHartman_FoundPlayer_Horde", 1000, 0)
	if CAP[id].VAR.YETI ~= nil and CAP[id].VAR.YETI:IsDead() == true then
		CAP[id].VAR.YETI:Despawn(1000, 1000)
	end
end

RegisterUnitEvent(749582, 18, "CAP.VAR.ScoutHartman_Spawn")

function CAP.VAR.Yeti_Spawn(pUnit, Event)
	pUnit:SetFaction(35)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 3)
	CAP[id].VAR.YETI = pUnit
end

RegisterUnitEvent(24173, 18, "CAP.VAR.Yeti_Spawn")

function CAP.VAR.ScoutHartman_FoundPlayer_Horde(pUnit, Event)
	local player = pUnit:GetClosestPlayer()
	if player and pUnit:GetDistanceYards(player) < 5 and
		player:HasQuest(8700) and player:GetQuestObjectiveCompletion(8700, 0) == 0 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12,0,"Can't catch me, you horde filth!")
		pUnit:SetMovementFlags(1)
		pUnit:RegisterEvent("CAP.VAR.WAITASECONDOKAYSCOUT", 1000, 1)
	end
end

function CAP.VAR.WAITASECONDOKAYSCOUT(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.SCOUT:MoveTo(-6455.20, -2280.12, 255.16, 3.80)
	pUnit:RegisterEvent("CAP.VAR.JumpoffSlide", 2000, 1)
end

function CAP.VAR.JumpoffSlide(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	--CAP[id].VAR.SCOUT:MoveKnockback(-6559.22, -2276.59, 255.41, 6, 13)
	pUnit:RegisterEvent("CAP.VAR.RunUpHill", 2500, 1)
end

function CAP.VAR.RunUpHill(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.SCOUT:MoveTo(-6471.83, -2264.52, 255.07, 3.48)
	pUnit:RegisterEvent("CAP.VAR.RunUpHillV", 2500, 1)
end

function CAP.VAR.RunUpHillV(pUnit,Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.SCOUT:MoveTo(-6477.62, -2289.60, 262.11, 4.53)
	pUnit:RegisterEvent("CAP.VAR.RunUpHillVz", 2500, 1)
end

function CAP.VAR.RunUpHillVz(pUnit,Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.SCOUT:MoveTo(-6462.68, -2309.63, 266.70, 5.20)
	pUnit:RegisterEvent("CAP.VAR.RunUpHillVzz", 2500, 1)
end

function CAP.VAR.RunUpHillVzz(pUnit,Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.SCOUT:MoveTo(-6484.83, -2320.12, 269.01, 2.80)
	pUnit:RegisterEvent("CAP.VAR.RunUpHillVzzz", 2500, 1)
end

function CAP.VAR.RunUpHillVzzz(pUnit,Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.SCOUT:MoveTo(-6511.43, -2305.28, 272.55, 5.9)
	pUnit:RegisterEvent("CAP.VAR.Yeti_Aggro", 1000, 0)
end

function CAP.VAR.Yeti_Aggro(pUnit,Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	local player = pUnit:GetClosestPlayer()
	if player ~= nil and pUnit:GetDistanceYards(player) < 12 and
	 player:HasQuest(8700) and player:GetQuestObjectiveCompletion(8700, 0) == 0 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12, 0, "End of the road huh? No matter, you will still die!")
		pUnit:Emote(45, 7000)
		pUnit:RegisterEvent("CAP.VAR.YETI_EVENT", 3000, 1)
	end
end

function CAP.VAR.YETI_EVENT(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.YETI:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
	pUnit:RegisterEvent("CAP.VAR.YETI_EVENTz", 3000, 1)
end

function CAP.VAR.YETI_EVENTz(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.YETI:CastSpell(58500)
	CAP[id].VAR.YETI:MoveTo(-6515.99, -2302.29, 272.58, 5.95)
	pUnit:RegisterEvent("CAP.VAR.YETI_EVENTzz", 3100, 1)
end

function CAP.VAR.YETI_EVENTzz(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.YETI:Emote(53, 2000)
	pUnit:RegisterEvent("CAP.VAR.YETI_EVENTzzz", 2500, 1)
end

function CAP.VAR.YETI_EVENTzzz(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	pUnit:SendChatMessage(12, 0, "Oh....")
	pUnit:RegisterEvent("CAP.VAR.YETI_EVENTzzzx", 1500, 1)
end

function CAP.VAR.YETI_EVENTzzzx(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.SCOUT:SetFacing(2.62)
	CAP[id].VAR.SCOUT:Emote(431, 5000)
	pUnit:RegisterEvent("CAP.VAR.YETI_EVENTzzzxx", 2000, 1)
end

function CAP.VAR.YETI_EVENTzzzxx(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.YETI:Emote(35, 1000)
	pUnit:RegisterEvent("CAP.VAR.YETI_EVENTSCOUTDEAD", 900, 1)
end

function CAP.VAR.YETI_EVENTSCOUTDEAD(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.YETI:Kill(CAP[id].VAR.SCOUT)
	CAP[id].VAR.YETI:RegisterEvent("CAP.VAR.Fight_Yeti", 2000, 1)
end


function CAP.VAR.Fight_Yeti(pUnit,Event)
	local id = pUnit:GetInstanceID() or 1
	CAP[id] = CAP[id] or {VAR={}}
	CAP[id].VAR.YETI:SetFaction(14)
end
