local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

--[[
11344 GRULLAIR_Doom_Aggro01.wav 

11345 GRULLAIR_Doom_Earth01.wav 

11346 GRULLAIR_Doom_Earth02.wav 

11347 GRULLAIR_Doom_Over01.wav 

11348 GRULLAIR_Doom_Over02.wav 

11349 GRULLAIR_Doom_Slay01.wav 

11350 GRULLAIR_Doom_Slay02.wav 

11351 GRULLAIR_Doom_Slay03.wav 

11352 GRULLAIR_Doom_Death01.wav 
]]

function DOOMWALKER_COMBAT(pUnit,Event)
	pUnit:PlaySoundToSet(11344)
	pUnit:SendChatMessage(14,0,"Do not proceed. You will be eliminated.")
pUnit:RegisterEvent("DOOMWALKER_ENRAGE", 360000,1)
pUnit:RegisterEvent("DOOMWALKER_QUAKE", 28000,0)
pUnit:RegisterEvent("DOOMWALKER_CHAINLIGHTNING", math.random(6200,7500),0)
pUnit:RegisterEvent("DOOMWALKER_OVERRUN", math.random(10000,15000),0)
pUnit:RegisterEvent("DOOMWALKER_AURAOFDEATH", 2000,0)
end


function DOOMWALKER_QUAKE(pUnit,Event)
pUnit:Root()
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:FullCastSpell(35565)
if math.random(1,2) <= 1 then
	pUnit:PlaySoundToSet(11345)
	pUnit:SendChatMessage(14,0,"Tectonic disruption commencing.")
elseif math.random(1,2) <= 2 then
	pUnit:PlaySoundToSet(11346)
	pUnit:SendChatMessage(14,0,"Magnitude set. Release.")
end
 pUnit:RegisterEvent("DOOMWALKER_QUAKEOVER", 8000,1)
  pUnit:RegisterEvent("DOOMWALKER_STUNNEARBY", 2000,4)
end

function DOOMWALKER_STUNNEARBY(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 10 then
  if players:IsDead() == false then
			pUnit:CastSpellOnTarget(34510,players)
         end
	end
	end
end
	

function DOOMWALKER_QUAKEOVER(pUnit,Event)
if pUnit:IsCasting() == false then
if pUnit:IsRooted() == true then
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end
end
end

function DOOMWALKER_CHAINLIGHTNING(pUnit,Event)
if pUnit:IsCasting() == false then
local plr = pUnit:GetRandomPlayer(0)
	if pUnit:GetDistanceYards(plr) < 40 then
		if plr:IsDead() == false then
			pUnit:CastSpellOnTarget(930,plr)
end
end
end
end

function DOOMWALKER_ENRAGE(pUnit,Event)
pUnit:CastSpell(33653)
end

function DOOMWALKER_OVERRUN(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:CastSpell(34771)
end
end

function DOOMWALKER_SLAY(pUnit,Event,pDied)
	if math.random(1,3) <= 1 then
	pUnit:PlaySoundToSet(11349)
	pUnit:SendChatMessage(14,0,"Threat level zero.")
	elseif math.random(1,3) <= 2 then
	pUnit:PlaySoundToSet(11350)
	pUnit:SendChatMessage(14,0,"Directive accomplished.")
	elseif math.random(1,3) <= 3 then
		pUnit:PlaySoundToSet(11351)
	pUnit:SendChatMessage(14,0,"Target exterminated.")
end
pDied:CastSpell(37128)
end

function DOOMWALKER_AURAOFDEATH(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 40 then
  if players:IsDead() == false then
  if players:HasAura(37128) == true then
  pUnit:Kill(players)
  end
  end
  end
  end
end

function DOOMWALKER_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:RemoveAura(33653)
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

function DOOMWALKER_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	pUnit:PlaySoundToSet(11352)
	pUnit:SendChatMessage(14,0,"System failure in five, f-o-u-r...")
end

RegisterUnitEvent(17711, 2, "DOOMWALKER_LEAVE")
RegisterUnitEvent(17711, 3, "DOOMWALKER_SLAY")
RegisterUnitEvent(17711, 1, "DOOMWALKER_COMBAT")
RegisterUnitEvent(17711, 4, "DOOMWALKER_DEAD")