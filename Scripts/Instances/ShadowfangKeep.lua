SFK = {}
SFK.VAR = {}

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


SetDBCSpellVar(57688, "c_is_flags", 0x01000)


--[[ Warden Shalox Fight:
447094,447095,447096 = Demonblood Hounds
447092 = Riplimb
447093 = Rageface
447091 = Shalox
]]

function SFK.VAR.WARDEN_SPAWN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	SFK[id].VAR.Warden = pUnit
end

RegisterUnitEvent(447091, 18, "SFK.VAR.WARDEN_SPAWN")

function SFK.VAR.BLOODHOUNDONE_SPAWN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	SFK[id].VAR.HoundOne = pUnit
	pUnit:ModifyRunSpeed(18)
	pUnit:ModifyWalkSpeed(18)
pUnit:RegisterEvent("SFK.VAR.WARDEN_ADD_MOVE",1000,1)
end

function SFK.VAR.BLOODHOUNDTWO_SPAWN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	SFK[id].VAR.HoundTwo = pUnit
	pUnit:ModifyRunSpeed(18)
	pUnit:ModifyWalkSpeed(18)
pUnit:RegisterEvent("SFK.VAR.WARDEN_ADD_MOVE",1000,1)
end

function SFK.VAR.BLOODHOUNDTHREE_SPAWN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	SFK[id].VAR.HoundThree = pUnit
	pUnit:ModifyRunSpeed(18)
	pUnit:ModifyWalkSpeed(18)
pUnit:RegisterEvent("SFK.VAR.WARDEN_ADD_MOVE",1000,1)
end
	

function SFK.VAR.WARDEN_ADD_MOVE(pUnit,Event)
  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 447091 then 
	if creature:IsInCombat() == true then
	pUnit:MoveTo(creature:GetX(),creature:GetY(),creature:GetZ(),creature:GetO())
		end
	end
end
end

RegisterUnitEvent(447094, 18, "SFK.VAR.BLOODHOUNDONE_SPAWN")
RegisterUnitEvent(447095, 18, "SFK.VAR.BLOODHOUNDTWO_SPAWN")
RegisterUnitEvent(447096, 18, "SFK.VAR.BLOODHOUNDTHREE_SPAWN")

function SFK.VAR.WARDEN_COMBAT(pUnit,Event)
pUnit:SendChatMessage(14,0,"Aha! The interlopers... Kill them! EAT THEM!")
pUnit:PlaySoundToSet(18040)
pUnit:RegisterEvent("SFK.VAR.WARDEN_CALLDOGS",9000,1)
pUnit:RegisterEvent("SFK.VAR.WARDEN_EVENTKNOCK",math.random(13000,14000),0)
pUnit:RegisterEvent("SFK.VAR.WARDEN_BURNOUT",28000,1)
end


function SFK.VAR.WARDEN_CALLDOGS(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
if math.random(1,3) <= 1 then
pUnit:SendChatMessage(14,0,"KILL!")
pUnit:PlaySoundToSet(18044)
elseif math.random(1,3) <= 2 then
pUnit:SendChatMessage(14,0,"Sic 'em!")
pUnit:PlaySoundToSet(18045)
elseif math.random(1,3) <= 3 then
pUnit:SendChatMessage(14,0,"Fetch your supper!")
pUnit:PlaySoundToSet(18046)
end
pUnit:SpawnCreature(447094,-244.06 , 2134.35, 81.17, 2.82, 14, 0)
pUnit:SpawnCreature(447095,-248.00 , 2125.26, 81.17, 2.81, 14, 0)
pUnit:SpawnCreature(447096,-251.43 , 2116.37, 81.17, 2.78, 14,0)
pUnit:RegisterEvent("SFK.VAR.WARDEN_ALLDOGSDEAD_REREGISTER",1000,0)
pUnit:RegisterEvent("SFK.VAR.WARDEN_KILLCOMMAND",math.random(15000,18000),0)
pUnit:RegisterEvent("SFK.VAR.WARDEN_ENRAGE",240000,1)
end

function SFK.VAR.WARDEN_ALLDOGSDEAD_REREGISTER(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	if SFK[id].VAR.HoundOne ~= nil and SFK[id].VAR.HoundOne:IsDead() then
	SFK[id].VAR.HoundOne:Despawn(1,0)
	SFK[id].VAR.HoundOne = nil
	pUnit:RegisterEvent("SFK.VAR.WARDEN_DOG_ONE_RESPAWN",13000,1)
	elseif SFK[id].VAR.HoundTwo ~= nil and SFK[id].VAR.HoundTwo:IsDead() then
		SFK[id].VAR.HoundTwo:Despawn(1,0)
	SFK[id].VAR.HoundTwo = nil
	pUnit:RegisterEvent("SFK.VAR.WARDEN_DOG_TWO_RESPAWN",14000,1)
	elseif SFK[id].VAR.HoundThree ~= nil and SFK[id].VAR.HoundThree:IsDead() then
	SFK[id].VAR.HoundThree:Despawn(1,0)
	SFK[id].VAR.HoundThree = nil
	pUnit:RegisterEvent("SFK.VAR.WARDEN_DOG_THREE_RESPAWN",15000,1)
end
end

function SFK.VAR.WARDEN_DOG_THREE_RESPAWN(pUnit,Event)
if math.random(1,3) <= 1 then
pUnit:SendChatMessage(14,0,"KILL!")
pUnit:PlaySoundToSet(18044)
elseif math.random(1,3) <= 2 then
pUnit:SendChatMessage(14,0,"Sic 'em!")
pUnit:PlaySoundToSet(18045)
elseif math.random(1,3) <= 3 then
pUnit:SendChatMessage(14,0,"Fetch your supper!")
pUnit:PlaySoundToSet(18046)
end
pUnit:SpawnCreature(447096,-251.43 , 2116.37, 81.17, 2.78, 14, 0)
end

function SFK.VAR.WARDEN_DOG_TWO_RESPAWN(pUnit,Event)
if math.random(1,3) <= 1 then
pUnit:SendChatMessage(14,0,"KILL!")
pUnit:PlaySoundToSet(18044)
elseif math.random(1,3) <= 2 then
pUnit:SendChatMessage(14,0,"Sic 'em!")
pUnit:PlaySoundToSet(18045)
elseif math.random(1,3) <= 3 then
pUnit:SendChatMessage(14,0,"Fetch your supper!")
pUnit:PlaySoundToSet(18046)
end
pUnit:SpawnCreature(447095,-248.00 , 2125.26, 81.17, 2.81, 14,0)
end


function SFK.VAR.WARDEN_DOG_ONE_RESPAWN(pUnit,Event)
if math.random(1,3) <= 1 then
pUnit:SendChatMessage(14,0,"KILL!")
pUnit:PlaySoundToSet(18044)
elseif math.random(1,3) <= 2 then
pUnit:SendChatMessage(14,0,"Sic 'em!")
pUnit:PlaySoundToSet(18045)
elseif math.random(1,3) <= 3 then
pUnit:SendChatMessage(14,0,"Fetch your supper!")
pUnit:PlaySoundToSet(18046)
end
pUnit:SpawnCreature(447094,-244.06 , 2134.35, 81.17, 2.82, 14, 0)
end

function SFK.VAR.WARDEN_KILLCOMMAND(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
if math.random(1,2) <= 1 then
pUnit:SendChatMessage(14,0,"Go for the throat!")
pUnit:PlaySoundToSet(18042)
elseif math.random(1,2) <= 2 then
pUnit:SendChatMessage(14,0,"Tear them down!")
pUnit:PlaySoundToSet(18043)
end
if math.random(1,3) <= 1 then
if SFK[id].VAR.HoundOne ~= nil then
SFK[id].VAR.HoundOne:CastSpell(38371)
 local player = SFK[id].VAR.HoundThree:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if SFK[id].VAR.HoundThree:GetDistanceYards(player) < 50 then
SFK[id].VAR.HoundThree:CastSpellOnTarget(51492,player)
	end
		end
	end
end
elseif math.random(1,3) <= 2 then
if SFK[id].VAR.HoundTwo ~= nil then
SFK[id].VAR.HoundTwo:CastSpell(38371)
 local player = SFK[id].VAR.HoundThree:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if SFK[id].VAR.HoundThree:GetDistanceYards(player) < 50 then
SFK[id].VAR.HoundThree:CastSpellOnTarget(51492,player)
	end
		end
	end
end
elseif math.random(1,3) <= 3 then
if SFK[id].VAR.HoundThree ~= nil then
SFK[id].VAR.HoundThree:CastSpell(38371)
 local player = SFK[id].VAR.HoundThree:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if SFK[id].VAR.HoundThree:GetDistanceYards(player) < 50 then
SFK[id].VAR.HoundThree:CastSpellOnTarget(51492,player)
end
end
end
end
end
end


function SFK.VAR.WARDEN_BURNOUT(pUnit,Event)
pUnit:Root()
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetFacing(pUnit:GetO())
pUnit:Emote(468,7100)
if math.random(1,2) <= 1 then
pUnit:SendChatMessage(14,0,"Now you BURN!!")
pUnit:PlaySoundToSet(18049)
elseif math.random(1,2) <= 2 then
pUnit:SendChatMessage(14,0,"Twist in flames, interlopers!")
pUnit:PlaySoundToSet(18050)
end
pUnit:SendChatMessage(42,0,"Warden Shalox drives his sword into the ground!")
pUnit:RegisterEvent("SFK.VAR.WARDEN_BURNOUTCAST",1000,7)
pUnit:RegisterEvent("SFK.VAR.WARDEN_BURNOUTCAST_OVER",7100,1)
end

function SFK.VAR.WARDEN_BURNOUTCAST(pUnit,Event)
pUnit:CastSpell(19823)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 100 then
  if players:IsDead() == false then
 pUnit:Strike(players,1,1535,100,140,1)
end
end
end
end

function SFK.VAR.WARDEN_BURNOUTCAST_OVER(pUnit,Event)
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:RegisterEvent("SFK.VAR.WARDEN_BURNOUT",28000,1)
end

function SFK.VAR.WARDEN_ENRAGE(pUnit,Event)
pUnit:PlaySoundToSet(18055)
pUnit:CastSpell(48142)
end

function SFK.VAR.WARDEN_EVENTKNOCK(pUnit,Event)
if math.random(1,2) <= 1 then
pUnit:SendChatMessage(14,0,"Step off!")
pUnit:PlaySoundToSet(18056)
elseif math.random(1,2) <= 2 then
pUnit:SendChatMessage(14,0,"Back, filth!")
pUnit:PlaySoundToSet(18057)
end
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 5 then
player:CastSpell(61508)
end
end
end
end

function SFK.VAR.WARDEN_KILLPLR(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
if math.random(1,3) <= 1 then
SFK[id].VAR.Warden:SendChatMessage(14,0,"Yes... oh yes!")
pUnit:PlaySoundToSet(18051)
elseif math.random(1,3) <= 2 then
SFK[id].VAR.Warden:SendChatMessage(14,0,"Now you stay dead!")
pUnit:PlaySoundToSet(18053)
elseif math.random(1,3) <= 3 then
SFK[id].VAR.Warden:SendChatMessage(14,0,"Dog food!")
pUnit:PlaySoundToSet(18054)
end
end

function SFK.VAR.WARDEN_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:GetGameObjectNearestCoords(-241.09, 2158.14, 90.62, 3266627):Despawn(1,0)
   for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
  if creatures:GetEntry() == 447094 or creatures:GetEntry() == 447095 or creatures:GetEntry() == 447096 then
  creatures:Despawn(1,0)
end
end
end

function SFK.VAR.WARDEN_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:RemoveAura(48142)
   for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
  if creatures:GetEntry() == 447094 or creatures:GetEntry() == 447095 or creatures:GetEntry() == 447096 then
  creatures:Despawn(1,0)
end
end
end

RegisterUnitEvent(447091, 4, "SFK.VAR.WARDEN_DEAD")
RegisterUnitEvent(447091, 1, "SFK.VAR.WARDEN_COMBAT")
RegisterUnitEvent(447091, 3, "SFK.VAR.WARDEN_KILLPLR")
RegisterUnitEvent(447091, 2, "SFK.VAR.WARDEN_LEAVE")
RegisterUnitEvent(447094, 3, "SFK.VAR.WARDEN_KILLPLR")
RegisterUnitEvent(447095, 3, "SFK.VAR.WARDEN_KILLPLR")
RegisterUnitEvent(447096, 3, "SFK.VAR.WARDEN_KILLPLR")

function SFK.VAR.RAGEFACE_DIES(pUnit,Event)
pUnit:RemoveEvents()
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
SFK[id].VAR.Warden:SendChatMessage(14,0,"You murderers! Why... why would you kill such a noble animal?!")
pUnit:PlaySoundToSet(18048)
end



function SFK.VAR.RIPLIMB_DIES(pUnit,Event)
pUnit:RemoveEvents()
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
SFK[id].VAR.Warden:SendChatMessage(14,0,"Riplimb! No... no! Oh, you terrible little beasts! HOW COULD YOU?!")
pUnit:PlaySoundToSet(18047)
end

function SFK.VAR.RIPLIMB_FLAMETHROWER(pUnit,Event)
pUnit:RemoveEvents()
pUnit:CastSpell(45466)
pUnit:Root()
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:RegisterEvent("SFK.VAR.RIPLIMB_FLAMETHROWER_OVER",8100,1)
end

function SFK.VAR.RIPLIMB_FLAMETHROWER_OVER(pUnit,Event)
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:RegisterEvent("SFK.VAR.RIPLIMB_FLAMETHROWER",17000,1)
pUnit:RegisterEvent("SFK.VAR.RIPLIMB_RIP",7000,1)
end

function SFK.VAR.RIPLIMB_RIP(pUnit,Event)
local tank = pUnit:GetMainTank()
if pUnit:GetDistanceYards(tank) < 12 then
pUnit:CastSpellOnTarget(36590,tank)
end
pUnit:RegisterEvent("SFK.VAR.RIPLIMB_RIP",12000,1)
end


function SFK.VAR.RIPLIMB_COMBAT(pUnit,Event)
pUnit:RegisterEvent("SFK.VAR.RIPLIMB_FLAMETHROWER",17000,1)
pUnit:RegisterEvent("SFK.VAR.RIPLIMB_RIP",7000,1)
end

function SFK.VAR.RIPLIMB_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(447092, 4, "SFK.VAR.RIPLIMB_DIES")
RegisterUnitEvent(447092, 1, "SFK.VAR.RIPLIMB_COMBAT")
RegisterUnitEvent(447092, 2, "SFK.VAR.RIPLIMB_LEAVE")
RegisterUnitEvent(447093, 4, "SFK.VAR.RAGEFACE_DIES")


--[[WORGEN BOSS
3914 = Commander Reth
]]


function SFK.VAR.COMMANDER_COMBAT(pUnit,Event)
pUnit:SendChatMessage(14,0,"Ah, fresh meat!")
pUnit:PlaySoundToSet(18058)
pUnit:RegisterEvent("SFK.VAR.COMMANDER_FOG",15000,1)
pUnit:RegisterEvent("SFK.VAR.COMMANDER_FRENZY",math.random(8700,11000),0)
--pUnit:RegisterEvent("SFK.VAR.COMMANDER_INFECT",math.random(14000,17000),0) heroic only
pUnit:RegisterEvent("SFK.VAR.MORTALWOUND",math.random(10000,12000),0)
end

function SFK.VAR.COMMANDER_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(37803)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:SendChatMessage(14,0,"You will... NOT find her... until it is too late...")
pUnit:PlaySoundToSet(18059)
 for place,fog in pairs(pUnit:GetInRangeObjects()) do 
  if fog:GetEntry() == 3266618 then
  fog:Despawn(1,0)
  end
  end
  for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 26111 or creatures:GetEntry() == 394821 then 
	creatures:Despawn(1,0)
	end
	end
end

function SFK.VAR.COMMANDER_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(37803)
  for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 394821 then
	creatures:Despawn(1,0)
end
end
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 26111 then 
	creatures:SetPhase(2)
	end
	end
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
 for place,fog in pairs(pUnit:GetInRangeObjects()) do 
  if fog:GetEntry() == 3266618 then
  fog:SetPhase(2)
  end
  end
end

function SFK.VAR.COMMANDER_SLAY(pUnit,Event)
pUnit:SendChatMessage(14,0,"Your blood only increases my hunger!")
pUnit:PlaySoundToSet(18060)
end

function SFK.VAR.COMMANDER_FOG(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"Do you feel that chill running up your spine? The fog is rolling in...")
pUnit:CastSpell(37803) -- invisiblity
pUnit:AIDisableCombat(true)
pUnit:CastSpell(24222)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:PlaySoundToSet(18061)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 26111 then 
	creatures:SetPhase(1)
	end
	end
 for place,fog in pairs(pUnit:GetInRangeObjects()) do 
  if fog:GetEntry() == 3266618 then
  fog:SetPhase(3)
  end
  end
  pUnit:RegisterEvent("SFK.VAR.COMMANDER_CHECKING_FOR_PLAYERS",100,0)
  pUnit:RegisterEvent("SFK.VAR.COMMANDER_FOG_WHISPER",10000,1)
  pUnit:RegisterEvent("SFK.VAR.COMMANDER_FOGDONE",21000,1)
  pUnit:RegisterEvent("SFK.VAR.SPAWNVAPOR",10000,2)
end

function SFK.VAR.COMMANDER_FOG_WHISPER(pUnit,Event)
pUnit:SendChatMessage(14,0,"I can smell your fear...")
pUnit:PlaySoundToSet(18063)
end

function SFK.VAR.COMMANDER_INFECT(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 40 then
pUnit:CastSpellOnTarget(53094,player)
end
end
end
end

function SFK.VAR.SPAWNVAPOR(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 40 then
 pUnit:SpawnCreature(394821,player:GetX() ,player:GetY(), player:GetZ(),player:GetO(), 14,0)
end
end
end
end

function SFK.VAR.COMMANDER_FRENZY(pUnit,Event)
pUnit:CastSpell(32714)
end

function SFK.VAR.COMMANDER_CHECKING_FOR_PLAYERS(pUnit)
	local numPlayers = pUnit:GetInRangePlayers()
	local i = 0
	for _,players in pairs(numPlayers) do
		--if pUnit:GetDistanceYards(players) < 40 then
			if players:IsDead() then
				i = i + 1
			end
		--end
	end
	if i == #numPlayers then
		pUnit:AIDisableCombat(false) -- random 323 was here
		 for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 394821 then
	creatures:Despawn(1,0)
end
end
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 26111 then 
	creatures:SetPhase(2)
	end
	end
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
 for place,fog in pairs(pUnit:GetInRangeObjects()) do 
  if fog:GetEntry() == 3266618 then
  fog:SetPhase(2)
  end
  end
		pUnit:Despawn(2000,5000)
		pUnit:AIDisableCombat(false)
pUnit:RemoveAura(37803)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
	end
end


function SFK.VAR.COMMANDER_FOGDONE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(37803)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
if math.random(1,2) <= 1 then
pUnit:SendChatMessage(14,0,"I will rip your heart from your chest!")
pUnit:PlaySoundToSet(18064)
elseif math.random(1,2) <= 2 then
pUnit:PlaySoundToSet(18062)
end
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 35 then
--pUnit:CastSpellOnTarget(60894,player)
pUnit:MoveKnockback(player:GetX(), player:GetY(), player:GetZ(), 10, 20)
pUnit:Strike(player,1,1535,700,700,1)
end
end
end
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 26111 then 
	creatures:SetPhase(2)
	end
	end
 for place,fog in pairs(pUnit:GetInRangeObjects()) do 
  if fog:GetEntry() == 3266618 then
  fog:SetPhase(2)
  end
  end
pUnit:RegisterEvent("SFK.VAR.COMMANDER_FOG",30000,1)
pUnit:RegisterEvent("SFK.VAR.COMMANDER_FRENZY",math.random(8700,11000),0)
--pUnit:RegisterEvent("SFK.VAR.COMMANDER_INFECT",math.random(14000,17000),0) HEROIC ONLY
pUnit:RegisterEvent("SFK.VAR.MORTALWOUND",math.random(10000,12000),0)
end

function SFK.VAR.MORTALWOUND(pUnit,Event)
local tank = pUnit:GetMainTank()
if pUnit:GetDistanceYards(tank) < 12 then
pUnit:CastSpellOnTarget(48137,tank)
end
end

RegisterUnitEvent(3914, 4, "SFK.VAR.COMMANDER_DEAD")
RegisterUnitEvent(3914, 1, "SFK.VAR.COMMANDER_COMBAT")
RegisterUnitEvent(3914, 3, "SFK.VAR.COMMANDER_SLAY")
RegisterUnitEvent(3914, 2, "SFK.VAR.COMMANDER_LEAVE")


function SFK.VAR.SPIRITWOLF_SPAWN(pUnit,Event)
pUnit:SetScale(2)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:RegisterEvent("SFK.VAR.SPIRITWOLF_STRIKE",1000,0)
end



function SFK.VAR.SPIRITWOLF_STRIKE(pUnit,Event)
if pUnit:IsInPhase(1) == true then
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 3.5 then
  if players:IsDead() == false then
 pUnit:Strike(players,1,1535,40,50,1)
  end
  end
  end
  end
  end
  
  RegisterUnitEvent(26111, 18, "SFK.VAR.SPIRITWOLF_SPAWN")
  
  function SFK.VAR.VAPOR_SELFDESTRUCT(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Root()
pUnit:CastSpell(67751)
pUnit:FullCastSpell(29973)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SendChatMessage(16,0,"Vapor begins to explode!")
pUnit:RegisterEvent("SFK.VAR.VAPOR_SELFDESTRUCT_TRIGGER", 11000, 1)
end

function SFK.VAR.VAPOR_SELFDESTRUCT_TRIGGER(pUnit,Event)
pUnit:Kill(pUnit)
pUnit:Despawn(1000,0)
end

  
  function SFK.VAR.VAPOR_spawn(pUnit,Event)
pUnit:Unroot()
	pUnit:RegisterEvent("SFK.VAR.VAPOR_SELFDESTRUCT", math.random(10000,17000), 1)
end

function SFK.VAR.VAPOR_LEAVEORDEAD(pUnit,Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(394821,18,"SFK.VAR.VAPOR_spawn")

RegisterUnitEvent(394821,2,"SFK.VAR.VAPOR_LEAVEORDEAD") 
RegisterUnitEvent(394821,4,"SFK.VAR.VAPOR_LEAVEORDEAD") 


--[[
Crone:
18168 = cronenpc
428921 = MIRROR1
428922 = MIRROR2
428923 = MIRROR3
]]

function SFK.VAR.CRONE_SPAWN(pUnit,Event)
pUnit:EquipWeapons(18609,0,0)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
if pUnit:GetDisplay() == 17550 then
pUnit:SetScale(.8)
pUnit:RegisterEvent("SFK.VAR.EVENTTRANSFORM", 1000, 0)
pUnit:RegisterEvent("SFK.VAR.SETFLAG", 100, 1)
else
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:SetScale(1)
end
end


function SFK.VAR.SETFLAG(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
end

RegisterUnitEvent(18168,18,"SFK.VAR.CRONE_SPAWN")

function SFK.VAR.EVENTTRANSFORM(pUnit,Event)
local player = pUnit:GetClosestPlayer()
if player ~= nil then
if pUnit:GetDistanceYards(player) < 7 then
pUnit:RemoveEvents()
pUnit:Emote(69,3100)
pUnit:RegisterEvent("SFK.VAR.EVENTONE", 3000, 1)
end
end
end


function SFK.VAR.EVENTONE(pUnit,Event)
pUnit:SetModel(30867)
pUnit:CastSpell(24222)
pUnit:Emote(0,4000)
pUnit:SetScale(1)
pUnit:SetFacing(4.3)
pUnit:RegisterEvent("SFK.VAR.EVENTTWO", 1100, 1)
end

function SFK.VAR.EVENTTWO(pUnit,Event)
pUnit:SendChatMessage(14,0," ...and with that out of the way, you and your flock of fumbling friends are next on my list. Mmm, I thought you'd never get here!")
pUnit:PlaySoundToSet(18102)
pUnit:Emote(1,12000)
pUnit:RegisterEvent("SFK.VAR.EVENT_COMBATENTER", 12000, 1)
end

function SFK.VAR.EVENT_COMBATENTER(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

function SFK.VAR.CRONE_COMBAT(pUnit,Event)
pUnit:SendChatMessage(14,0,"Let's get to work, shall we?")
pUnit:PlaySoundToSet(18100)
pUnit:RegisterEvent("SFK.VAR.CRONE_POLYMORPH", math.random(8000,12000), 0)
pUnit:RegisterEvent("SFK.VAR.CRONE_MIRROR_IMAGE",15000, 0)
pUnit:RegisterEvent("SFK.VAR.CRONE_FROSTBOLT", 6000, 0)
--pUnit:RegisterEvent("SFK.VAR.CRONE_GRAVITY", 12000, 1)
local object = pUnit:GetGameObjectNearestCoords(-115.12, 2160.84, 155.67, 193995)
	if object then
		object:SetByte(0x0006+0x000B,0,1)
		end
end

function SFK.VAR.CRONE_GRAVITY(pUnit,Event)
pUnit:FullCastSpell(47756)
end

function SFK.VAR.CRONE_FROSTBOLT(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 35 then
		if players:IsDead() == false then
pUnit:FullCastSpellOnTarget(46987,players)
end
end
end
end


function SFK.VAR.CRONE_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"You're much... better... than I thought...")
pUnit:PlaySoundToSet(18101)
	local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
		if players:HasAchievement(59382) == false then
					players:AddAchievement(59382)
					end
	end
	end
	local object = pUnit:GetGameObjectNearestCoords(-115.12, 2160.84, 155.67, 193995)
	if object then
		object:SetByte(0x0006+0x000B,0,0)
		end
end

function SFK.VAR.CRONE_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"Well, that was even easier than I thought.")
pUnit:PlaySoundToSet(18109)
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(37803)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
local object = pUnit:GetGameObjectNearestCoords(-115.12, 2160.84, 155.67, 193995)
	if object then
		object:SetByte(0x0006+0x000B,0,0)
		end
end

function SFK.VAR.CRONE_POLYMORPH(pUnit,Event)
 local player = pUnit:GetRandomPlayer(7)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 45 then
pUnit:CastSpellOnTarget(61025,player)
pUnit:SendChatMessage(14,0,"Where do you think you're going, little lizard?")
pUnit:PlaySoundToSet(18104)
end
end
end
end

function SFK.VAR.CRONE_MIRROR_IMAGE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"Now you see me...")
pUnit:PlaySoundToSet(18103)
pUnit:CastSpell(37803) -- invisiblity
pUnit:AIDisableCombat(true)
pUnit:CastSpell(57555)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:RegisterEvent("SFK.VAR.CRONE_CHECKING_FOR_PLAYERS", 100, 0)	
pUnit:RegisterEvent("SFK.VAR.MIRRORS", 1000, 1)	
pUnit:RegisterEvent("SFK.VAR.CRONE_MIRRORS_DEAD", 1000, 0)	
pUnit:SpawnCreature(428921,-93.68,2154.48,144.92, 4.3, 16, 0)
pUnit:SpawnCreature(428922, -100.54,2155.88, 144.92, 4.7, 16, 0)
pUnit:SpawnCreature(428923, -85.47, 2150.04, 144.92, 3.83, 16, 0)
end

function SFK.VAR.MIRRORS(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
SFK[id].VAR.MirrorONE:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(),pUnit:GetO())
SFK[id].VAR.MirrorTWO:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(),pUnit:GetO())
SFK[id].VAR.MirrorTHREE:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(),pUnit:GetO())
end

function SFK.VAR.CRONE_MIRRORS_DEAD(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
if SFK[id].VAR.MirrorONE:IsDead() and SFK[id].VAR.MirrorTWO:IsDead() and SFK[id].VAR.MirrorTHREE:IsDead() == true then
pUnit:RemoveEvents()
SFK[id].VAR.MirrorONE:Despawn(1,0)
SFK[id].VAR.MirrorTWO:Despawn(1,0)
SFK[id].VAR.MirrorTHREE:Despawn(1,0)
SFK[id].VAR.MirrorONE = nil
SFK[id].VAR.MirrorTWO = nil
SFK[id].VAR.MirrorTHREE = nil
--MIRRORS HANDLED
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(37803)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:SendChatMessage(14,0,"Surprise.")
pUnit:PlaySoundToSet(18108)
pUnit:RegisterEvent("SFK.VAR.CRONE_POLYMORPH", math.random(14000,17000), 0)
pUnit:RegisterEvent("SFK.VAR.CRONE_MIRROR_IMAGE",30000, 0)
pUnit:RegisterEvent("SFK.VAR.CRONE_FROSTBOLT", 6000, 0)
--pUnit:RegisterEvent("SFK.VAR.CRONE_GRAVITY", 12000, 1)
end
end

function SFK.VAR.CRONE_CHECKING_FOR_PLAYERS(pUnit)
	local numPlayers = pUnit:GetInRangePlayers()
	local i = 0
	for _,players in pairs(numPlayers) do
		--if pUnit:GetDistanceYards(players) < 40 then
			if players:IsDead() then
				i = i + 1
			end
		--end
	end
	if i == #numPlayers then
		pUnit:AIDisableCombat(false) -- random 323 was here
		for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 428923 or creatures:GetEntry() == 428922 or creatures:GetEntry() == 428921  then 
				creatures:Despawn(1,0)
			end
		end
		pUnit:Despawn(2000,5000)
		pUnit:AIDisableCombat(false)
pUnit:RemoveAura(37803)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
local object = pUnit:GetGameObjectNearestCoords(-115.12, 2160.84, 155.67, 193995)
	if object then
		object:SetByte(0x0006+0x000B,0,0)
		end
	end
end

function SFK.VAR.CRONE_SLAY(pUnit,Event)
if math.random(1,3) <= 1 then
pUnit:SendChatMessage(14,0,"So soon.")
pUnit:PlaySoundToSet(18105)
elseif math.random(1,3) <= 2 then
pUnit:SendChatMessage(14,0,"I hope your friends can do better!")
pUnit:PlaySoundToSet(18107)
elseif math.random(1,3) <= 3 then
pUnit:SendChatMessage(14,0,"Good night.")
pUnit:PlaySoundToSet(18106)
end
end

RegisterUnitEvent(18168, 4, "SFK.VAR.CRONE_DEAD")
RegisterUnitEvent(18168, 1, "SFK.VAR.CRONE_COMBAT")
RegisterUnitEvent(18168, 2, "SFK.VAR.CRONE_LEAVE")
RegisterUnitEvent(18168, 3, "SFK.VAR.CRONE_SLAY")


---Mirror images

function SFK.VAR.IMAGEONE(pUnit,Event) -- arcane
pUnit:EquipWeapons(18609,0,0)
pUnit:CastSpell(6117)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	SFK[id].VAR.MirrorONE = pUnit
end

RegisterUnitEvent(428921, 18, "SFK.VAR.IMAGEONE")

function SFK.VAR.IMAGETWO(pUnit,Event) -- fire
pUnit:EquipWeapons(18609,0,0)
pUnit:CastSpell(30482)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	SFK[id].VAR.MirrorTWO = pUnit
end

RegisterUnitEvent(428922, 18, "SFK.VAR.IMAGETWO")

function SFK.VAR.IMAGETHREE(pUnit,Event) -- frost
pUnit:EquipWeapons(18609,0,0)
pUnit:CastSpell(7302)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	SFK[id].VAR.MirrorTHREE = pUnit
end

RegisterUnitEvent(428923, 18, "SFK.VAR.IMAGETHREE")


function SFK.VAR.IMAGEONE_COMBAT(pUnit,Event)
pUnit:RegisterEvent("SFK.VAR.IMAGEONE_MASSSLOW", math.random(8000,15000), 0)
pUnit:RegisterEvent("SFK.VAR.IMAGEONE_BLINK", math.random(7000,12000), 0)
pUnit:RegisterEvent("SFK.VAR.IMAGEONE_COUNTERSPELL", math.random(5000,8000), 0)
pUnit:RegisterEvent("SFK.VAR.IMAGEONE_ARCANEBLAST", math.random(3000,4000), 0)
end

function SFK.VAR.IMAGEONE_MASSSLOW(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 20 then
	if players:IsDead() == false then
	pUnit:CastSpellOnTarget(31589,players)
	end
	end
	end
	end
	
	function SFK.VAR.IMAGEONE_BLINK(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 5 then
pUnit:CastSpell(1953)
end
end
end
end


function SFK.VAR.IMAGEONE_COUNTERSPELL(pUnit,Event)
local player = pUnit:GetRandomPlayer(4)
if player ~= nil then
if player:GetCurrentSpellId() ~= nil then
pUnit:CastSpellOnTarget(2139,player)
end
end
end





function SFK.VAR.IMAGEONE_ARCANEBLAST(pUnit,Event)
pUnit:Root()
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 30 then
pUnit:FullCastSpellOnTarget(5144,tank)
end
end
end

function SFK.VAR.zUNROOT_CASTER(pUnit,Event)
if pUnit:GetCurrentSpellId() ~= nil then
else
if pUnit:IsRooted() == true then
pUnit:Unroot()
end
end
end

function SFK.VAR.IMAGE_LEAVEDEAD(pUnit,Event)
pUnit:RemoveEvents()
end


	function SFK.VAR.IMAGETWO_DRAGONBREATH(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 8 then
pUnit:CastSpell(31661)
end
end
end
end


function SFK.VAR.IMAGETWO_FIREBALL(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 30 then
pUnit:FullCastSpellOnTarget(69570,tank)
end
end
end

function SFK.VAR.IMAGETWO_BLAST(pUnit,Event)
local plr = pUnit:GetRandomPlayer(0)
	if pUnit:GetDistanceYards(plr) < 30 then
		if plr:IsDead() == false then
			pUnit:CastSpellOnTarget(13342,plr)
end
end
end


function SFK.VAR.IMAGETWO_COMBAT(pUnit,Event)
pUnit:RegisterEvent("SFK.VAR.IMAGETWO_FIREBALL", math.random(4000,7000), 0)
pUnit:RegisterEvent("SFK.VAR.IMAGETWO_BLAST", math.random(6000,8000), 0)
pUnit:RegisterEvent("SFK.VAR.IMAGETWO_DRAGONBREATH", math.random(10000,11000), 0)
end

function SFK.VAR.IMAGETHREE_ICELANCE(pUnit,Event)
local plr = pUnit:GetRandomPlayer(0)
	if pUnit:GetDistanceYards(plr) < 30 then
		if plr:IsDead() == false then
			pUnit:CastSpellOnTarget(30455,plr)
end
end
end

	function SFK.VAR.IMAGETHREE_FROSTNOVA(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 8 then
pUnit:CastSpell(865)
end
end
end
end

function SFK.VAR.IMAGETHREE_FROSTBOLT(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 30 then
pUnit:FullCastSpellOnTarget(15530,tank)
end
end
end

function SFK.VAR.IMAGETHREE_ICETOMB(pUnit,Event)
if pUnit:GetHealthPct() < 25 then
pUnit:RemoveEvents()
pUnit:CastSpell(45438)
pUnit:RegisterEvent("SFK.VAR.IMAGETHREE_FROSTBOLT", math.random(4000,7000), 0)
--pUnit:RegisterEvent("SFK.VAR.IMAGETHREE_ICELANCE", math.random(6000,8000), 0)
pUnit:RegisterEvent("SFK.VAR.IMAGETHREE_FROSTNOVA", math.random(9000,11000), 0)
end
end

function SFK.VAR.IMAGETHREE_COMBAT(pUnit,Event)
pUnit:RegisterEvent("SFK.VAR.IMAGETHREE_ICETOMB", 1000, 0)
pUnit:RegisterEvent("SFK.VAR.IMAGETHREE_FROSTBOLT", math.random(4000,7000), 0)
--pUnit:RegisterEvent("SFK.VAR.IMAGETHREE_ICELANCE", math.random(6000,8000), 0)
pUnit:RegisterEvent("SFK.VAR.IMAGETHREE_FROSTNOVA", math.random(9000,11000), 0)
end



RegisterUnitEvent(428921, 1, "SFK.VAR.IMAGEONE_COMBAT")
RegisterUnitEvent(428922, 1, "SFK.VAR.IMAGETWO_COMBAT")
RegisterUnitEvent(428923, 1, "SFK.VAR.IMAGETHREE_COMBAT")

RegisterUnitEvent(428921, 2, "SFK.VAR.IMAGE_LEAVEDEAD")
RegisterUnitEvent(428921, 4, "SFK.VAR.IMAGE_LEAVEDEAD")
RegisterUnitEvent(428922, 2, "SFK.VAR.IMAGE_LEAVEDEAD")
RegisterUnitEvent(428922, 4, "SFK.VAR.IMAGE_LEAVEDEAD")
RegisterUnitEvent(428923, 2, "SFK.VAR.IMAGE_LEAVEDEAD")
RegisterUnitEvent(428923, 4, "SFK.VAR.IMAGE_LEAVEDEAD")

--trash events
--[[
16289 - DO NOT LET THEM PASS MINIONS
16290 - KILL THEM, MY WORK MUST NO BE INTERRUPTED
16293 - PROFESSOR SLAY1
16294 - PHASE CHANGE/EVENT/SPELL
16295 - EVENT/SPELL/ADDS
16296 - PROFESSOR FAIL/EVENT/LOWHP
16292 - EVENT02
16291 - AGGRO]]



---trash--

function  SFK.VAR.HungryHound_Combat(pUnit,Event)
pUnit:RegisterEvent("SFK.VAR.Hound_Bite", math.random(6000,10000),0)
--pUnit:RegisterEvent("SFK.VAR.HOUND_JUMP", 100,1) no animation, looks bad sadly
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
if pUnit:GetDistanceYards(creatures) < 5 then
			if creatures:GetEntry() == 441229 then 
			creatures:Despawn(1,0)
			end
		end
	end
end

function SFK.VAR.HOUND_JUMP(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 15 then
pUnit:MoveKnockback(tank:GetX(), tank:GetY(), tank:GetZ(), 10, 20)
end
end
end

function SFK.VAR.Hound_Bite(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 12 then
pUnit:CastSpellOnTarget(30639,tank)
end
end
end

function SFK.VAR.CreatureAI_LeaveDead(pUnit,Event)
pUnit:RemoveEvents()
end

function SFK.VAR.hungrhound_spwn(pUnit,Event)
pUnit:RegisterEvent("SFK.VAR.hungrhound_ss", 1000,1)
end

function SFK.VAR.hungrhound_ss(pUnit)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
if creatures:GetEntry() == 441229 then 
if pUnit:GetDistanceYards(creatures) < 5 then
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 3)
end
end
end
end


 RegisterUnitEvent(447097, 1, "SFK.VAR.HungryHound_Combat")
  RegisterUnitEvent(447097, 18, "SFK.VAR.hungrhound_spwn")
  RegisterUnitEvent(447097, 3, "SFK.VAR.CreatureAI_LeaveDead")
   RegisterUnitEvent(447097, 4, "SFK.VAR.CreatureAI_LeaveDead")
   
          function SFK.VAR.FLESHGOLEM_Combat(pUnit,Event)
	   pUnit:RegisterEvent("SFK.VAR.FG_LIGHTNINGFURY", math.random(5000,12000),0)
	   --pUnit:RegisterEvent("SFK.VAR.FG_THUNDERCLAP", math.random(8000,10000),0)
	     pUnit:RegisterEvent("SFK.VAR.FG_ROAR", math.random(15000,23000),0)

end


function MobileAlertSystem_Events(pUnit,Event)
if Event == 18 then
--pUnit:CastSpell(72054)
pUnit:RegisterEvent("AlertSystem_foundplayer", 2000,0)
end
end

function AlertSystem_foundplayer(pUnit,Event)
local player = pUnit:GetClosestPlayer()
if player ~= nil then
if pUnit:GetDistanceYards(player) < 4 then
pUnit:RemoveEvents()
pUnit:Kill(pUnit)
	pUnit:SendChatMessage(12, 0, "WARNING, WARNING! INTRUDER ALERT! INTRUDER ALERT!")
		pUnit:PlaySoundToSet(5805)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
if pUnit:GetDistanceYards(creatures) < 25 then
			if creatures:GetEntry() == 447097 then 
				creatures:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
				creatures:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
				--creatures:MoveTo(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),0)
				creatures:SetMovementFlags(1)
					elseif creatures:GetEntry() == 441229 then 
					creatures:Despawn(1,0)
					end
					end
				end
end
end
end

RegisterUnitEvent(7849, 18, "MobileAlertSystem_Events")


function SFK.VAR.FG_LIGHTNINGFURY(pUnit,Event)
local tank = pUnit:GetMainTank()
if pUnit:GetDistanceYards(tank) < 8 then
pUnit:CastSpellOnTarget(61561,tank)
end
end

function SFK.VAR.FG_ROAR(pUnit,Event)
pUnit:CastSpell(29685)
end

function SFK.VAR.FG_THUNDERCLAP(pUnit,Event)
pUnit:CastSpell(8732)
end


 RegisterUnitEvent(394813, 1, "SFK.VAR.FLESHGOLEM_Combat")
  RegisterUnitEvent(394813, 3, "SFK.VAR.CreatureAI_LeaveDead")
   RegisterUnitEvent(394813, 4, "SFK.VAR.CreatureAI_LeaveDead")

   --[[ 449833 = shade of anger
   449832 = husk/instructor
18130	10	Shade_Anger_Aggro	
18131	10	Shade_Anger_Death	
18132	10	Shade_Anger_Kill_01	
18133	10	Shade_Anger_Kill_02	
18134	10	Shade_Anger_Kill_03	
18135	10	Shade_Anger_Kill_04	
18136	10	Shade_Anger_Skeleton01	
18137	10	Shade_Anger_Spawning_01	
18138	10	Shade_Anger_Spawning_02	
18139	10	Shade_Anger_Spawning_03	
18140	10	Shade_Anger_Spawning_04	
18141	10	Shade_Anger_Spell_01	
18142	10	Shade_Anger_Spell_02	

]]

function SFK.VAR.SHADEANGER_COMBAT(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
SFK[id].VAR.ShadeHpCount = 0
pUnit:SendChatMessage(14,0,"Yes, yes! Bring your rage to bear, try to strike me down!")
pUnit:PlaySoundToSet(18130)
  pUnit:RegisterEvent("SFK.VAR.SHADEANGER_PHASE_RELEASE_ONE", 1000, 0)
  pUnit:RegisterEvent("SFK.VAR.PHASE_ANGERSHADE_STRANGULATE", math.random(8000,14000), 0)
  pUnit:RegisterEvent("SFK.VAR.SHADEANGER_SPAWNCREATURE", math.random(10000,16000), 0)
   pUnit:RegisterEvent("SFK.VAR.SHADE_BLOODSTRIKE", math.random(6000,12000), 0)
end

function SFK.VAR.SHADE_BLOODSTRIKE(pUnit)
local tank = pUnit:GetMainTank()
if pUnit:GetDistanceYards(tank) < 8 then
pUnit:CastSpellOnTarget(59130,tank)
end
end


function SFK.VAR.SHADEANGER_PHASE_RELEASE_ONE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
if pUnit:GetHealthPct() < 75 then
pUnit:RemoveEvents()
SFK[id].VAR.ShadeHpCount = SFK[id].VAR.ShadeHpCount + 1
	SFK[id].VAR.ANGERSHADE = pUnit:SpawnCreature(449833,pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 7)
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
--pUnit:RegisterEvent("SFK.VAR.MindControlAPlayer", 5000, 1)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_SPEAK_SPAWN", 1000, 1)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_PHASE_WITHDRAWL", 1000, 0)
pUnit:RegisterEvent("SFK.VAR.SHADE_CHECKING_FOR_PLAYERS", 1000, 0)
end
end

function SFK.VAR.SHADEANGER_PHASE_RELEASE_TWO(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	if pUnit:GetHealthPct() < 50 then
	pUnit:RemoveEvents()
	SFK[id].VAR.ShadeHpCount = SFK[id].VAR.ShadeHpCount + 1
	SFK[id].VAR.ANGERSHADE = pUnit:SpawnCreature(449833,pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 7)
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
--pUnit:RegisterEvent("SFK.VAR.MindControlAPlayer", 5000, 1)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_SPEAK_SPAWN", 1000, 1)
pUnit:RegisterEvent("SFK.VAR.SHADE_CHECKING_FOR_PLAYERS", 1000, 0)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_PHASE_WITHDRAWL", 1000, 0)
end
end

function SFK.VAR.SHADEANGER_PHASE_RELEASE_THREE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
if pUnit:GetHealthPct() < 30 then
pUnit:RemoveEvents()
SFK[id].VAR.ShadeHpCount = SFK[id].VAR.ShadeHpCount + 1
	SFK[id].VAR.ANGERSHADE = pUnit:SpawnCreature(449833,pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 7)
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
--pUnit:RegisterEvent("SFK.VAR.MindControlAPlayer", 5000, 1)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_SPEAK_SPAWN", 1000, 1)
pUnit:RegisterEvent("SFK.VAR.SHADE_CHECKING_FOR_PLAYERS", 1000, 0)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_PHASE_WITHDRAWL", 1000, 0)
end
end

function SFK.VAR.SHADEANGER_PHASE_RELEASE_FOUR(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
if pUnit:GetHealthPct() < 10 then
pUnit:RemoveEvents()
	SFK[id].VAR.ANGERSHADE = pUnit:SpawnCreature(449833,pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 7)
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
--pUnit:RegisterEvent("SFK.VAR.MindControlAPlayer", 5000, 1)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_SPEAK_SPAWN", 1000, 1)
pUnit:RegisterEvent("SFK.VAR.SHADE_CHECKING_FOR_PLAYERS", 1000, 0)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_PHASE_WITHDRAWL", 1000, 0)
end
end


function SFK.VAR.SHADEANGER_SPEAK_SPAWN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
if math.random(2,4) <= 2 then
SFK[id].VAR.ANGERSHADE:SendChatMessage(14,0,"MY FURY IS UNLEASHED!")
SFK[id].VAR.ANGERSHADE:PlaySoundToSet(18142)
elseif math.random(2,4) <= 3 then
SFK[id].VAR.ANGERSHADE:SendChatMessage(14,0,"Your rage sustains me!")
SFK[id].VAR.ANGERSHADE:PlaySoundToSet(18139)
elseif math.random(2,4) <= 4 then
SFK[id].VAR.ANGERSHADE:SendChatMessage(14,0,"My wrath flows freely.")
SFK[id].VAR.ANGERSHADE:PlaySoundToSet(18140)
end
end

function SFK.VAR.SHADEANGER_PHASE_WITHDRAWL(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
if SFK[id].VAR.ANGERSHADE:IsDead() then
pUnit:RemoveEvents()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
SFK[id].VAR.ANGERSHADE:SendChatMessage(14,0,"You will not bury me again!")
SFK[id].VAR.ANGERSHADE:PlaySoundToSet(18136)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_MISC", 1000, 1)
pUnit:RegisterEvent("SFK.VAR.PHASE_ANGERSHADE_STRANGULATE", math.random(8000,14000), 0)
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_SPAWNCREATURE", math.random(10000,16000), 0)
 pUnit:RegisterEvent("SFK.VAR.SHADE_BLOODSTRIKE", math.random(6000,12000), 0)
if SFK[id].VAR.ShadeHpCount == 1 then
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_PHASE_RELEASE_TWO", 1000, 0)
elseif SFK[id].VAR.ShadeHpCount == 2 then
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_PHASE_RELEASE_THREE", 1000, 0)
elseif SFK[id].VAR.ShadeHpCount == 3 then
pUnit:RegisterEvent("SFK.VAR.SHADEANGER_PHASE_RELEASE_FOUR", 20000, 0)
end
end
end

function SFK.VAR.SHADEANGER_MISC(pUnit)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
SFK[id].VAR.ANGERSHADE:Despawn(1,0)
SFK[id].VAR.ANGERSHADE = nil
end


function SFK.VAR.SHADEANGER_SPAWNCREATURE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
	local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 40 then
if player:IsDead() == false then
SFK[id].VAR.PLAYERLOCATIONX = player:GetX()
SFK[id].VAR.PLAYERLOCATIONY = player:GetY()
SFK[id].VAR.PLAYERLOCATIONZ = player:GetZ()
pUnit:SpawnCreature(743123,pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 35, 2000)
pUnit:RegisterEvent("SFK.VAR.SPAWNCREATURE_FEWSECONDSLATER", 1500, 1)
pUnit:RegisterEvent("SFK.VAR.CRASHDUMMYz_VISUAL", 500, 1)
end
end
end
end

function SFK.VAR.CRASHDUMMYSPAWN(pUnit)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
SFK[id].VAR.CRASHDUMMYz = pUnit
SFK[id].VAR.CRASHDUMMYz:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(743123, 18, "SFK.VAR.CRASHDUMMYSPAWN")

function SFK.VAR.CRASHDUMMYz_VISUAL(pUnit)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
SFK[id].VAR.CRASHDUMMYz:CastSpellAoF(SFK[id].VAR.PLAYERLOCATIONX, SFK[id].VAR.PLAYERLOCATIONY,SFK[id].VAR.PLAYERLOCATIONZ , 63722)
SFK[id].VAR.CRASHDUMMYz = nil
end

function SFK.VAR.SPAWNCREATURE_FEWSECONDSLATER(pUnit)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
pUnit:SpawnCreature(449787,SFK[id].VAR.PLAYERLOCATIONX , SFK[id].VAR.PLAYERLOCATIONY, SFK[id].VAR.PLAYERLOCATIONZ, pUnit:GetO(), 14, 0)
pUnit:SpawnCreature(743124,SFK[id].VAR.PLAYERLOCATIONX, SFK[id].VAR.PLAYERLOCATIONY,SFK[id].VAR.PLAYERLOCATIONZ,0, 35, 22000)
SFK[id].VAR.PLAYERLOCATIONX = nil
SFK[id].VAR.PLAYERLOCATIONY = nil
SFK[id].VAR.PLAYERLOCATIONZ = nil
end

function SFK.VAR.SHADEANGER_DEATH(pUnit,Event)
pUnit:RemoveEvents()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
--pUnit:SendChatMessage(14,0,"AHHHHHHHHHHHHHHHHHHH! Hehehahahahaha...")
pUnit:PlaySoundToSet(18131)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
  if creatures:GetEntry() == 449833 or creatures:GetEntry() == 449787 or creatures:GetEntry() == 743124 then
  creatures:Despawn(1,0)
 end
 end
end

function SFK.VAR.SHADEANGER_SLAY(pUnit,Event)
if math.random(1,2) <= 1 then
pUnit:SendChatMessage(14,0,"Extinguished! Muhahahahahaha!")
pUnit:PlaySoundToSet(18132)
elseif math.random(1,2) <= 2 then
pUnit:SendChatMessage(14,0,"Does that make you angry? Muhaha!")
pUnit:PlaySoundToSet(18133)
end
end


function SFK.VAR.SHADEANGER_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
  if creatures:GetEntry() == 449833 or creatures:GetEntry() == 449787 or creatures:GetEntry() == 743124 then 
  creatures:Despawn(1,0)
 end
 end
end

 RegisterUnitEvent(449832, 1, "SFK.VAR.SHADEANGER_COMBAT")
  RegisterUnitEvent(449832, 2, "SFK.VAR.SHADEANGER_LEAVE")
   RegisterUnitEvent(449832, 3, "SFK.VAR.SHADEANGER_SLAY")
      RegisterUnitEvent(449832, 4, "SFK.VAR.SHADEANGER_DEATH")


function SFK.VAR.PHASE_ANGERSHADE_COMBAT(pUnit,Event)
pUnit:RegisterEvent("SFK.VAR.PHASE_ANGERSHADE_MARKANGER", math.random(6000,10000), 0)
pUnit:RegisterEvent("SFK.VAR.PHASE_ANGERSHADE_SHADOWVOLLEY", math.random(3000,8000), 0)
--pUnit:RegisterEvent("SFK.VAR.PHASE_ANGERSHADE_SOULSCREAM", math.random(14000,16000), 0)
end

function SFK.VAR.VOIDDamage(pUnit,Event)
pUnit:CastSpell(73525)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 5 then
  if players:IsDead() == false then
 pUnit:Strike(players,1,1535,120,145,1)
  end
  end
  end
  end
  
  function SFK.VAR.VOIDZONESpawn(pUnit,Event)
  pUnit:CastSpell(73525)
  pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("SFK.VAR.VOIDDamage",1000,0) 
  --pUnit:SetScale(.6)
  end
  
  RegisterUnitEvent(743124, 18, "SFK.VAR.VOIDZONESpawn")
  
function SFK.VAR.PHASE_ANGERSHADE_DEAD(pUnit,Event)
pUnit:RemoveEvents()
end

function SFK.VAR.PHASE_ANGERSHADE_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

 RegisterUnitEvent(449833, 1, "SFK.VAR.PHASE_ANGERSHADE_COMBAT")
  RegisterUnitEvent(449833, 2, "SFK.VAR.PHASE_ANGERSHADE_LEAVE")
   RegisterUnitEvent(449833, 3, "SFK.VAR.SHADEANGER_SLAY")
      RegisterUnitEvent(449833, 4, "SFK.VAR.PHASE_ANGERSHADE_DEAD")
	  RegisterUnitEvent(449833, 18, "SFK.VAR.SHADEANGER_SPEAK_SPAWN")

function SFK.VAR.PHASE_ANGERSHADE_STRANGULATE(pUnit,Event)
local player = pUnit:GetRandomPlayer(4)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 40 then
if player:IsDead() == false then
pUnit:CastSpellOnTarget(67823)
end
end
end
end

function SFK.VAR.PHASE_ANGERSHADE_SHADOWVOLLEY(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 40 then
  if players:IsDead() == false then
  pUnit:CastSpellOnTarget(15232,players)
  end
  end
  end
end

function SFK.VAR.PHASE_ANGERSHADE_MARKANGER(pUnit,Event)
local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 40 then
if player:IsDead() == false then
pUnit:CastSpellOnTarget(67882,player)
end
end
end
end

function SFK.VAR.PHASE_ANGERSHADE_SOULSCREAM(pUnit,Event) -- disable and leave for heroic if too much
pUnit:CastSpell(41545)
end


function SFK.VAR.SHADE_CHECKING_FOR_PLAYERS(pUnit)
	local numPlayers = pUnit:GetInRangePlayers()
	local i = 0
	for _,players in pairs(numPlayers) do
		--if pUnit:GetDistanceYards(players) < 40 then
			if players:IsDead() then
				i = i + 1
			end
		--end
	end
	if i == #numPlayers then
			pUnit:Despawn(2000,5000)
	pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
  if creatures:GetEntry() == 449833 then
  creatures:Despawn(1,0)
 end
 end
	end
end


function SFK.VAR.MANIFESTATION_SPAWN(pUnit,Event)
if math.random(1,4) <= 1 then
pUnit:SetScale(.9)
elseif math.random(1,4) <= 2 then
pUnit:SetScale(1.1)
elseif math.random(1,4) <= 3 then
pUnit:SetScale(1.2)
elseif math.random(1,4) <= 4 then
end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if players ~= nil then
  if players:IsAlive() == true then
if pUnit:GetDistanceYards(players) < 15 then
  pUnit:Strike(players, 1, 72620, 200, 300, 1.2)
end
end
end
end
end

RegisterUnitEvent(449787, 18, "SFK.VAR.MANIFESTATION_SPAWN")

function SFK.VAR.MINDCONTROLTEST(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SFK[id] = SFK[id] or {VAR={}}
local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 40 then
if player:IsDead() == false then
player:CastSpell(38771)
end
end
end
if math.random(1,3) <= 1 then
SFK[id].VAR.ANGERSHADE:SendChatMessage(14,0,"Muhahaha! Feel your rage...")
SFK[id].VAR.ANGERSHADE:PlaySoundToSet(18134)
elseif math.random(1,3) <= 1 then
SFK[id].VAR.ANGERSHADE:SendChatMessage(14,0,"Let your rage consume you.")
SFK[id].VAR.ANGERSHADE:PlaySoundToSet(18135)
elseif math.random(1,3) <= 3 then
SFK[id].VAR.ANGERSHADE:SendChatMessage(14,0,"Give in to your anger.")
SFK[id].VAR.ANGERSHADE:PlaySoundToSet(18137)
end
end