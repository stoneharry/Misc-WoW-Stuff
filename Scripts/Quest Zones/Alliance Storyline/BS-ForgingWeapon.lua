
function zzRuneOfSpawn(item, event, player)
	zzRuneStart(item, player)
end

Weapon_CooldownTime = {}
Weapon_ClickPrevent = {}

function zzRuneStart(item, player)
	if player:HasQuest(43) == true then
		if player:IsInCombat() == false then
			player:SendAreaTriggerMessage("|cFFFF0000You need to be engaged in combat!")
			return
		end -- ending combat not quest
		local PLAYER_TARGET = player:GetPrimaryCombatTarget()
		if PLAYER_TARGET ~= nil and PLAYER_TARGET:GetEntry() == 257005 and PLAYER_TARGET:IsAlive() then
			if PLAYER_TARGET:HasAura(61369) then
				player:SendAreaTriggerMessage("|cFFFF0000You have already extracted this target!")
				return
			end
			player:CastSpellOnTarget(6061, PLAYER_TARGET)
			PLAYER_TARGET:CastSpell(1449)
			PLAYER_TARGET:CastSpell(61369)
			player:AdvanceQuestObjective(43, 0)
		else
			player:SendAreaTriggerMessage("|cFFFF0000Wrong Target!")
		end -- ending target
	elseif player:HasQuest(44) == true then
		if Weapon_ClickPrevent[player:GetName()] == "clicked" and ((os.clock()-Weapon_CooldownTime[player:GetName()])) <= 5 then
			player:SendAreaTriggerMessage("|cFFFF0000You can not use this yet.")
		else
			Weapon_ClickPrevent[player:GetName()] = "clicked"
			Weapon_CooldownTime[player:GetName()] = os.clock()
			player:CastSpell(25938)
		end
	end
end

RegisterItemGossipEvent(6436, 1, "zzRuneOfSpawn")

local Count = 0
local Lava = nil

function Forge_Gossip_A(pUnit, event, player, pMisc)
	pUnit:GossipCreateMenu(37990, player, 0)
	if player:HasQuest(44) then
		pUnit:GossipMenuAddItem(0, "Will you please forge a weapon of purity out of this charged crystal?", 1, 0)
		pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	end
	pUnit:GossipSendMenu(player)
end

function Forge_Gossip_B(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
	local name = player:GetName()
	pUnit:SendChatMessage(12, 0, "Bear with me "..name..".")
	pUnit:MoveTo(-7893.75, -977.06, 130, 0.718894)
	Count = 1
	pUnit:SetNPCFlags(2)
	player:GossipComplete()
	end
	if (intid == 2) then
	player:GossipComplete()
	end
end

RegisterUnitGossipEvent(255911, 1, "Forge_Gossip_A")
RegisterUnitGossipEvent(255911, 2, "Forge_Gossip_B")

function Forge_On_Spawn(pUnit, Event)
	pUnit:RegisterEvent("Test_burn_burn", 5000, 0)
end

RegisterUnitEvent(255911, 18, "Forge_On_Spawn")

function Test_burn_burn(pUnit, Event)
	if Count == 1 then
	Count = 0
	pUnit:RegisterEvent("HangOnAMoment_Z", 1000, 1)
	end
end

function HangOnAMoment_Z(pUnit, Event)
	if Lava == nil then
	pUnit:Despawn(1000, 30000)
	else
	Lava:CastSpell(43113)
	pUnit:ChannelSpell(13540, Lava)
	pUnit:RegisterEvent("Return_Tehe_Tehe", 5000, 1)
	end
end

function Return_Tehe_Tehe(pUnit, Event)
	pUnit:StopChannel()
	pUnit:ReturnToSpawnPoint()
	pUnit:SetNPCFlags(3)
	pUnit:CastSpell(25938)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		if plr:HasQuest(44) == true then
		plr:MarkQuestObjectiveAsComplete(44, 0)
		end
	end
end

function Target_Lava_Wave_On_Spawn(pUnit, Event)
	Lava = pUnit
end

RegisterUnitEvent(116861, 18, "Target_Lava_Wave_On_Spawn")
