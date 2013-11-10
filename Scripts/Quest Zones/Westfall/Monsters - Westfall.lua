local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 

function ThrashingPumpkin_OnSpawn(pUnit, Event)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 9)
	pUnit:RegisterEvent("ThrashingPumpkin_Emote_Raise", 1000, 0)
end

function ThrashingPumpkin_Emote_Raise(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	local player = pUnit:GetClosestPlayer()
	if player then
		if pUnit:GetDistanceYards(player) < 8 then
			pUnit:RemoveEvents()
			pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
			pUnit:RegisterEvent("ThrashingPumpkin_SetFactionAfterEmote",900,1)
		end
	end
end

function ThrashingPumpkin_SetFactionAfterEmote(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end


function ThrashingPumpkin_Leave(pUnit,Events)
	pUnit:RemoveEvents()
	pUnit:Despawn(500,1000)
end

function ThrashingPumpkin_DEAD(pUnit,Events)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(44487, 3,"ThrashingPumpkin_Leave")
RegisterUnitEvent(44487, 4,"ThrashingPumpkin_DEAD")
RegisterUnitEvent(44487, 18,"ThrashingPumpkin_OnSpawn")
RegisterUnitEvent(35144, 18,"ThrashingPumpkin_OnSpawn")

RegisterUnitEvent(17980, 18,"ThrashingPumpkin_OnSpawn")
 
function seventhLegionRifleman_OnSpawn(pUnit,Event)
	pUnit:Root()
	pUnit:RegisterEvent("RandomKill_Target",500,0)
end
 
function RandomKill_Target(pUnit,Event)
	local target = pUnit:GetRandomEnemy()
	if target ~= nil then
		if pUnit:GetDistanceYards(target) < 15 then
			if target:IsDead() == false then
				pUnit:CastSpellOnTarget(50092,target)
				pUnit:Kill(target)
			end
		end
	end
end
 
 
RegisterUnitEvent(27791, 18,"seventhLegionRifleman_OnSpawn")
  
function CrazedWestFallFarmer_OnSpawn(pUnit,Event)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
	pUnit:DeMorph()
	if math.random(1,2) <= 1 then
		pUnit:EquipWeapons(2901,0,0)
	elseif math.random(1,2) <= 2 then
		pUnit:EquipWeapons(39202,0,0)
	end
end
  
function CrazedWestFallFarmer_Combat(pUnit,Event)
	pUnit:RegisterEvent("Monster_Disarm",10000,0)
	pUnit:RegisterEvent("CrazedWestFallFarmer_Zombified",1000,0)
end
  
function CrazedWestFallFarmer_Zombified(pUnit,Event)
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(43401)
		pUnit:SetModel(25001)
		pUnit:RegisterEvent("Monster_Disarm",10000,0)
	end
end
  
function Monster_Disarm(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 10 then
			pUnit:CastSpellOnTarget(6713,tank)
		end
	end
end

function Monster_Leave(pUnit,Event) -- general leave
	pUnit:RemoveEvents()
	pUnit:DeMorph()
end


function Monster_Dead(pUnit,Event) -- general dead
	pUnit:RemoveEvents()
end
  
RegisterUnitEvent(20433, 18,"CrazedWestFallFarmer_OnSpawn")
RegisterUnitEvent(20433, 1,"CrazedWestFallFarmer_Combat")
RegisterUnitEvent(20433, 3,"Monster_Leave")
RegisterUnitEvent(20433, 4,"Monster_Dead")


function KvaldirRaider_Spawn(pUnit,Event)
pUnit:EquipWeapons(36579,36579,0)
end

function KvaldirRaider_Dead(pUnit,Event)
pUnit:EquipWeapons(0,0,0)
end


function KvaldirCaster_Dead(pUnit,Event)
pUnit:EquipWeapons(0,0,0)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if pUnit:GetDistanceYards(players) < 15 then
	if players:HasQuest(8012) == true then
	if players:GetQuestObjectiveCompletion(8012, 0) ~= 15 then
players:AdvanceQuestObjective(8012,0)
end
end
end
end
end

RegisterUnitEvent(25760, 18,"KvaldirRaider_Spawn")
RegisterUnitEvent(25479, 4,"KvaldirCaster_Dead")
RegisterUnitEvent(25760, 4,"KvaldirRaider_Dead")
