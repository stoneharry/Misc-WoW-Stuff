FS = {}
FS.VAR = {}

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
local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3



function FS.VAR.Desire_Combat(pUnit,Event)
pUnit:GetGameObjectNearestCoords(5299.36, 2512.07, 686.06, 203624):SetByte(GAMEOBJECT_BYTES_1,0,1)
pUnit:SendChatMessage(14,0,"Yes, you'll stay with us now.")
pUnit:PlaySoundToSet(11410)
pUnit:RegisterEvent("FS.VAR.ARCANE_BOMB_VISUAL",math.random(3000,6000),0)
pUnit:RegisterEvent("FS.VAR.INFLUENCE_VISUAL",math.random(8000,18000),0)
end


function FS.VAR.ARCANE_BOMB_VISUAL(pUnit,Event)
	local player = pUnit:GetRandomPlayer(0)
	if player then
		if player:IsDead() == false then
			if pUnit:GetDistanceYards(player) < 40 then
				pUnit:SpawnCreature(41719,player:GetX() ,player:GetY(), player:GetZ(),player:GetO(), 35,0)
			end
		end
	end
end


function FS.VAR.INFLUENCE_VISUAL(pUnit,Event)
	local player = pUnit:GetRandomPlayer(0)
	if player then
		if player:IsDead() == false then
			if pUnit:GetDistanceYards(player) < 40 then
				pUnit:SpawnCreature(333211 ,player:GetX() ,player:GetY(), player:GetZ(),player:GetO(), 14,0)
			end
		end
	end
end


function FS.VAR.Desire_Dead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:GetGameObjectNearestCoords(5299.36, 2512.07, 686.06, 203624):SetByte(GAMEOBJECT_BYTES_1,0,0)
pUnit:SendChatMessage(14,0,"I won't be far...")
pUnit:PlaySoundToSet(11414)
end

function FS.VAR.Desire_Leave(pUnit,Event)
pUnit:RemoveEvents()
pUnit:GetGameObjectNearestCoords(5299.36, 2512.07, 686.06, 203624):SetByte(GAMEOBJECT_BYTES_1,0,0)
end

RegisterUnitEvent(63492, 1, "FS.VAR.Desire_Combat")
RegisterUnitEvent(63492, 2, "FS.VAR.Desire_Leave")
RegisterUnitEvent(63492, 4, "FS.VAR.Desire_Dead")


function FS.VAR.MADNESSVOICE(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("FS.VAR.WZHISPERING_VOICE", math.random(8000,22000), 0)
end
		
RegisterUnitEvent(14190,18, "FS.VAR.MADNESSVOICE")
		
function FS.VAR.WZHISPERING_VOICE(pUnit,Event)
	local player = pUnit:GetRandomPlayer(0)
	if player ~= nil then
		if math.random(1,4) == 1 then
			player:PlaySoundToPlayer(8873)
		elseif math.random(1,4) == 2 then
			player:PlaySoundToPlayer(8874)
		elseif math.random(1,4) == 3 then
			player:PlaySoundToPlayer(8875)
		elseif math.random(1,4) == 4 then
			player:PlaySoundToPlayer(8876)

		end
	end
end





function FS.VAR.VARIABLEBRAIN_CHECK(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	FS[id] = FS[id] or {VAR={}}
	pUnit:AIDisableCombat(true)
FS[id].VAR.Brain = pUnit
pUnit:RegisterEvent("FS.VAR.BRAIN_HURT_PHASE_HPA",1000,0)
end

RegisterUnitEvent(449861, 18, "FS.VAR.VARIABLEBRAIN_CHECK")

function FS.VAR.SHADOWDOUBT_Combat(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	FS[id] = FS[id] or {VAR={}}
	if Event == 1 then
pUnit:AIDisableCombat(true)
pUnit:ChannelSpell(1120,FS[id].VAR.Brain)
pUnit:SendChatMessage(14,0,"Die...or surrender...you cannot defeat me..")
pUnit:PlaySoundToSet(40082)
pUnit:RegisterEvent("FS.VAR.INFLUENCE_VISUAL",math.random(8000,12000),0)
pUnit:RegisterEvent("FS.VAR.PLAYERCHECK_IFDEAD",2000,0)
pUnit:RegisterEvent("FS.VAR.SHADOWDOUBT_LOW",1000,0)
pUnit:RegisterEvent("FS.VAR.SHADOWDOUBT_HURTBRAIN",2000,0)
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:StopChannel()
elseif Event == 18 then
pUnit:AIDisableCombat(false)
	FS[id].VAR.Doubt = pUnit
pUnit:Root()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:ChannelSpell(1120,FS[id].VAR.Brain)
			pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
pUnit:SetModel(50204)
	end
end

function FS.VAR.PLAYERCHECK_IFDEAD(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	if players ~= nil then
		if pUnit:GetDistanceYards(players) < 80 then
			if players:IsDead() then
				pUnit:Despawn(1,3000)
				players:Teleport(0,-1331.39,-3024.10,35.29)
					for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
if creatures:GetEntry() == 333211 then 
creatures:Despawn(1,0)
		end
end
			end
		end
	end
end



function FS.VAR.ARCANE_BOMB_VISUAL(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 40 then
 pUnit:SpawnCreature(41719,player:GetX() ,player:GetY(), player:GetZ(),player:GetO(), 35,0)
end
end
end
end

function DARKINFLUENCE_EVENTS(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	FS[id] = FS[id] or {VAR={}}
if Event == 18 then
pUnit:RegisterEvent("FS.VAR.SHADOWDOUBT_HURTBRAIN",2000,0)
pUnit:ChannelSpell(1120,FS[id].VAR.Brain)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
end
end

RegisterUnitEvent(333211, 18, "DARKINFLUENCE_EVENTS")
RegisterUnitEvent(333211, 2, "DARKINFLUENCE_EVENTS")
RegisterUnitEvent(333211, 4, "DARKINFLUENCE_EVENTS")

function FS.VAR.SHADOWDOUBT_HURTBRAIN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	FS[id] = FS[id] or {VAR={}}
	if FS[id].VAR.Brain and FS[id].VAR.Brain:IsAlive() then
	if pUnit:GetDistanceYards(FS[id].VAR.Brain) < 50 then
 pUnit:Strike(FS[id].VAR.Brain,1,1535,120,145,1)
end
end
end


function FS.VAR.INFLUENCE_VISUAL(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 40 then
player:SpawnCreature(333211 ,player:GetX() ,player:GetY(), player:GetZ(),0, 14,0)
end
end
end
end



function FS.VAR.SHADOWDOUBT_LOW(pUnit)
	if pUnit:GetHealthPct() < 2 then
pUnit:RemoveEvents()
pUnit:AIDisableCombat(true)
pUnit:SendChatMessage(14,0,"You cannot escape me...I..am..in...every...prayer..")
pUnit:PlaySoundToSet(40083)
pUnit:StopChannel()
pUnit:Despawn(1500,3000)
			pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 7)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
if creatures:GetEntry() == 333211 then 
creatures:Despawn(1,0)
		end
end
local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
 if pUnit:GetDistanceYards(players) < 70 and not players:IsDead() then
  	players:Teleport(0,-1331.39,-3024.10,35.29)
  players:MarkQuestObjectiveAsComplete(40043, 0)
	end
	end
end
end

RegisterUnitEvent(349991, 1, "FS.VAR.SHADOWDOUBT_Combat")
RegisterUnitEvent(349991, 2, "FS.VAR.SHADOWDOUBT_Combat")
RegisterUnitEvent(349991, 18, "FS.VAR.SHADOWDOUBT_Combat")


function FS.VAR.BRAIN_HURT_PHASE_HPA(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	FS[id] = FS[id] or {VAR={}}
if pUnit:GetHealthPct() < 80 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(42,0,"Your mind is being corrupted!")
pUnit:PlaySoundToSet(40085)
FS[id].VAR.Doubt:SendChatMessage(14,0,"Succumb to the darkness inside your soul!")
pUnit:RegisterEvent("FS.VAR.BRAIN_HURT_PHASE_HPB",1000,0)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 70 then
  if players:IsDead() == false then
  players:CastSpell(69235)
  end
  end
  end
  end
end



function FS.VAR.BRAIN_HURT_PHASE_HPB(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	FS[id] = FS[id] or {VAR={}}
if pUnit:GetHealthPct() < 60 then
pUnit:RemoveEvents()
pUnit:RegisterEvent("FS.VAR.BRAIN_HURT_PHASE_HPC",1000,0)
FS[id].VAR.Doubt:SendChatMessage(14,0,"See how effortlessly you become unraveled!")
pUnit:PlaySoundToSet(40084)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 70 then
  if players:IsDead() == false then
  players:CastSpell(69235)
  end
  end
  end
  end
end


function FS.VAR.BRAIN_HURT_PHASE_HPC(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	FS[id] = FS[id] or {VAR={}}
if pUnit:GetHealthPct() < 40 then
pUnit:RemoveEvents()
pUnit:RegisterEvent("FS.VAR.BRAIN_HURT_PHASE_HPD",1000,0)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 70 then
  if players:IsDead() == false then
  players:CastSpell(69235)
  end
  end
  end
  end
end


function FS.VAR.BRAIN_HURT_PHASE_HPD(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	FS[id] = FS[id] or {VAR={}}
if pUnit:GetHealthPct() < 20 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(42,0,"You are losing your mind!")
pUnit:RegisterEvent("FS.VAR.BRAIN_HURT_PHASE_HPE",1000,0)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 70 then
  if players:IsDead() == false then
  players:CastSpell(69235)
  end
  end
  end
  end
end


function FS.VAR.BRAIN_HURT_PHASE_HPE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	FS[id] = FS[id] or {VAR={}}
if pUnit:GetHealthPct() < 10 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(42,0,"Your mind has been fully corrupted by shadow!")
pUnit:PlaySoundToSet(40086)
FS[id].VAR.Doubt:SendChatMessage(14,0,"All is lost!")
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 70 then
  if players:IsDead() == false then
   players:Teleport(0,-1331.39,-3024.10,35.29)
   players:Kill(players)
  end
  end
  end
  end
end



