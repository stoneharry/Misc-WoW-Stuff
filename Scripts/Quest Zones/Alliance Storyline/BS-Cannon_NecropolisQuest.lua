--[[
local Necro = nil
local NecTarget = nil

local resetting = false

local OBJECT_END = 0x0006
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044

-----------------------------------------------------------------------------------------------

function aDeadSailorWep_On_Gossip(pUnit, event, player)
	if player:HasQuest(32) == false then
		player:SendBroadcastMessage("The Necropolis appears to have some sort of shield protecting it.")
	else
		if Necro == nil or resetting then
			player:SendBroadcastMessage("The Necropolis is already destroyed.")
		else
			if NecTarget == nil or NecTarget:IsDead() == true then
				player:SendBroadcastMessage("The Necropolis appears to have some sort of shield protecting it.")
			else
				pUnit:FullCastSpellOnTarget(51235, NecTarget)
				pUnit:CastSpell(13259)
				resetting = true
				player:MarkQuestObjectiveAsComplete(32, 0)
				CreateLuaEvent(Test_DESTROYNECRO, 3000, 1)
			end
		end
	end
end

RegisterUnitGossipEvent(33080, 1, "aDeadSailorWep_On_Gossip")

function PortalAABAANecro(pUnit, event, player)
	player:Teleport(533, 3498.5, -5349.3, 146)
end

RegisterGameObjectEvent(190942, 4, "PortalAABAANecro")

function PortalAABAANecroB(pUnit, event, player)
	player:Teleport(0, -8083.5, -1586, 143)
end

 RegisterGameObjectEvent(190943, 4, "PortalAABAANecroB")

-----------------------------------------------------------------------------------------------

function TEst_oahaoejznhzzzz(pUnit, Event)
	Necro = pUnit
end

RegisterUnitEvent(278031, 18, "TEst_oahaoejznhzzzz")

function TargetOnSpawneahah(pUnit, Event)
	NecTarget = pUnit
end

RegisterUnitEvent(182251, 18, "TargetOnSpawneahah")

function Test_DESTROYNECRO()
	Necro:SetUInt32Value(UNIT_FIELD_BYTES_1, 7)
	CreateLuaEvent(RESET_NECRO_GUY, 60000, 1)
end

function RESET_NECRO_GUY()
	Necro:SetUInt32Value(UNIT_FIELD_BYTES_1, 0)
	resetting = false
end
]]