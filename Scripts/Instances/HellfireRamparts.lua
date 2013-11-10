
SURVIVAL = {}
SURVIVAL.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000


function SURVIVAL.VAR.TRIGGERCHECKER_SURV_SPAWN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	SURVIVAL[id].VAR.TriggerGuy = pUnit
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end



RegisterUnitEvent(217190,18, "SURVIVAL.VAR.TRIGGERCHECKER_SURV_SPAWN") 


function SURVIVAL.VAR.StartHordeMode_On_Gossip(pUnit, event, player)
pUnit:GossipCreateMenu(1059, player,0)
pUnit:GossipMenuAddItem(0, "I am ready to fight.", 242, 0)
pUnit:GossipSendMenu(player)
end




function SURVIVAL.VAR.StartHordeMode_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 242) then
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	SURVIVAL[id].VAR.BossKill = 0
	SURVIVAL[id].VAR.Waves = 0
player:GossipComplete()
pUnit:SetNPCFlags(2)
pUnit:SendChatMessage(14,0,"Be ready heroes, they approach!")
pUnit:Emote(45,25000)
RegisterTimedEvent("SURVIVAL.VAR.StartFunctionsandWaveOne", 1800, 1, player)
end
end

RegisterUnitGossipEvent(21928, 1, "SURVIVAL.VAR.StartHordeMode_On_Gossip")
RegisterUnitGossipEvent(21928, 2, "SURVIVAL.VAR.StartHordeMode_Gossip_Submenus")


function SURVIVAL.VAR.StartFunctionsandWaveOne(pUnit,Event,player)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	SURVIVAL[id].VAR.TriggerGuy:RegisterEvent("SURVIVAL.VAR.SURVIVAL_CHECKING_FOR_PLAYERS",1000,0) 
	SURVIVAL[id].VAR.TriggerGuy:RegisterEvent("SURVIVAL.VAR.SURVIVAL_WAVE_ONE",1500,1)
end

function SURVIVAL.VAR.SURVIVAL_WAVE_ONE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	SURVIVAL[id].VAR.Waves = 0 + 1
	--SURVIVAL[id].VAR.TriggerGuy:SendChatMessage(42,0,"Wave "..SURVIVAL[id].VAR.Waves.."")
	local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	players:SendBroadcastMessage("CHAOTIC:SCENARIO--3-3--Wave "..SURVIVAL[id].VAR.Waves.."")
	end
	SURVIVAL[id].VAR.Waves = 0
	SURVIVAL[id].VAR.TriggerGuy:PlaySoundToSet(3439)
	pUnit:SpawnCreature(16700,-1268.73,1597.62,91.76,2.55, 14,0) -- center is always main subboss who handles the waves
	pUnit:SpawnCreature(17259,-1267.17,1592.62,91.71,2.50, 14,0) -- left
	pUnit:SpawnCreature(17259,-1263,1598.32,91.71,2.50, 14,0)  -- right
end

function SURVIVAL.VAR.SURVIVAL_WAVE_TWO(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	SURVIVAL[id].VAR.Waves = 1 + 1
	SURVIVAL[id].VAR.TriggerGuy:SendChatMessage(42,0,"Wave "..SURVIVAL[id].VAR.Waves.."")
	SURVIVAL[id].VAR.Waves = 1
pUnit:SpawnCreature(16700,-1268.73,1597.62,91.76,2.55, 14,0) -- center is always main subboss who handles the waves
	pUnit:SpawnCreature(17259,-1267.17,1592.62,91.71,2.50, 14,0) -- left
	pUnit:SpawnCreature(19415,-1263,1598.32,91.71,2.50, 14,0)  -- right
end

function SURVIVAL.VAR.SURVIVAL_WAVE_THREE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	SURVIVAL[id].VAR.Waves = 2 + 1
	SURVIVAL[id].VAR.TriggerGuy:SendChatMessage(42,0,"Wave "..SURVIVAL[id].VAR.Waves.."")
	SURVIVAL[id].VAR.Waves = 2
pUnit:SpawnCreature(16700,-1268.73,1597.62,91.76,2.55, 14,0) -- center is always main subboss who handles the waves
	pUnit:SpawnCreature(17259,-1267.17,1592.62,91.71,2.50, 14,0) -- left
		if math.random(1,2) <= 1 then
	pUnit:SpawnCreature(17259,-1263,1598.32,91.71,2.50, 14,0)  -- right
	elseif math.random(1,2) <= 2 then
	pUnit:SpawnCreature(19415,-1263,1598.32,91.71,2.50, 14,0)
end
end


function SURVIVAL.VAR.SURVIVAL_WAVE_FOUR(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	SURVIVAL[id].VAR.Waves = 3 + 1
	SURVIVAL[id].VAR.TriggerGuy:SendChatMessage(42,0,"Wave "..SURVIVAL[id].VAR.Waves.."")
	SURVIVAL[id].VAR.Waves = 3
pUnit:SpawnCreature(16700,-1268.73,1597.62,91.76,2.55, 14,0) -- center is always main subboss who handles the waves
	pUnit:SpawnCreature(17259,-1267.17,1592.62,91.71,2.50, 14,0) -- left
		pUnit:SpawnCreature(19415,-1263,1598.32,91.71,2.50, 14,0)
	---SOUTH EAST ENTRANCE
pUnit:SpawnCreature(17259,-1317.63,1652.56,91.62,5.33, 14,0) 
			pUnit:SpawnCreature(19415,-1320.86,1650.22,91.62,5.3, 14,0)
			--SOUTH WEST ENTRANCE
end






function SURVIVAL.VAR.SURVIVAL_CHECKING_FOR_PLAYERS(pUnit)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	local numPlayers = pUnit:GetInRangePlayers()
	local i = 0
	for _,players in pairs(numPlayers) do
			if players:IsDead() then
				i = i + 1
			end
	end
	if i == #numPlayers then
		pUnit:RemoveEvents() 
		for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 21928 or creatures:GetEntry() == 16700 or creatures:GetEntry() == 17259 or creatures:GetEntry() == 19415 then 
				creatures:Despawn(1,0)
			end
		end
		pUnit:SendChatMessage(42,0,"You have been defeated! You have slain "..SURVIVAL[id].VAR.BossKill.." bosses and defeated "..SURVIVAL[id].VAR.Waves.." waves.")
	end
end



---AI---

--[[
10192 HELL_Legion01_Formwor01.wav 

10193 HELL_Legion01_Formwor02.wav 

10194 HELL_Legion01_Formwor03.wav 

10195 HELL_Legion01_Formwor04.wav 

10196 HELL_Legion01_Formwor05.wav ]]

function SURVIVAL.VAR.LEGIONAIRRE_COMBAT(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	if math.random(1,5) <= 1 then
	pUnit:PlaySoundToSet(10192)
	pUnit:SendChatMessage(14,0,"Lok-Narash! Defensive positions!")
	elseif math.random(1,5) <= 2 then
		pUnit:PlaySoundToSet(10193)
	pUnit:SendChatMessage(14,0,"Hold the line! They must not get through!")
		elseif math.random(1,5) <= 3 then
			pUnit:PlaySoundToSet(10194)
	pUnit:SendChatMessage(14,0,"Ga'karah ma!")
		elseif math.random(1,5) <= 4 then
			pUnit:PlaySoundToSet(10195)
	pUnit:SendChatMessage(14,0,"Hold them back at all costs!")
		elseif math.random(1,5) <= 5 then
			pUnit:PlaySoundToSet(10196)
	pUnit:SendChatMessage(14,0,"We must halt their advance! Take your positions!")
end
pUnit:CastSpell(30472)
if SURVIVAL[id].VAR.Waves == 0 then
elseif SURVIVAL[id].VAR.Waves == 2 then
pUnit:RegisterEvent("SURVIVAL.VAR.LEGIONAIRRE_BLEED", math.random(9800,14000),0)
end
pUnit:RegisterEvent("SURVIVAL.VAR.LEGIONAIRRE_ENRAGE",1000,0)
end

function SURVIVAL.VAR.LEGIONAIRRE_BLEED(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank ~= nil then
	if player:HasAura(36023) == false then
		if pUnit:GetDistanceYards(tank) < 20 then
		pUnit:CastSpellOnTarget(36023,tank)
end
end
end
end



function SURVIVAL.VAR.LEGIONAIRRE_ENRAGE(pUnit,Event)
if pUnit:GetHealthPct() < 30 then
pUnit:RemoveEvents()
pUnit:CastSpell(30485)
pUnit:SendChatMessage(8,0,"The Shattered Hand Legionnaire becomes enraged!")
end
end


function SURVIVAL.VAR.LEGIONAIRRE_DEAD(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
pUnit:RemoveEvents()
if SURVIVAL[id].VAR.Waves == 0 then
SURVIVAL[id].VAR.TriggerGuy:RegisterEvent("SURVIVAL.VAR.SURVIVAL_WAVE_TWO",5000,1)
elseif SURVIVAL[id].VAR.Waves == 1 then
SURVIVAL[id].VAR.TriggerGuy:RegisterEvent("SURVIVAL.VAR.SURVIVAL_WAVE_THREE",5000,1)
elseif SURVIVAL[id].VAR.Waves == 2 then
SURVIVAL[id].VAR.TriggerGuy:RegisterEvent("SURVIVAL.VAR.SURVIVAL_WAVE_FOUR",5000,1)
elseif SURVIVAL[id].VAR.Waves == 3 then
SURVIVAL[id].VAR.TriggerGuy:RegisterEvent("SURVIVAL.VAR.SURVIVAL_WAVE_FIVE",5000,1)
elseif SURVIVAL[id].VAR.Waves == 4 then
--SURVIVAL[id].VAR.TriggerGuy:RegisterEvent("SURVIVAL.VAR.SURVIVAL_BOSS_ONE",10000,1)
end
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
if creatures:GetEntry() == 16700 or creatures:GetEntry() == 17259 or creatures:GetEntry() == 19415  then 
if creatures:IsDead() == true then
creatures:Despawn(1,0)
end
end
end
end


function SURVIVAL.VAR.SURVIVAL_UNIVERSAL_DEATHLEAVE(pUnit,Event)
pUnit:RemoveEvents()
end


function SURVIVAL.VAR.GENERIC_SURVIVAL_MOB_SPAWN(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
if pUnit:GetDisplay() == 17052 then
pUnit:EquipWeapons(35017,23139,0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
elseif pUnit:GetDisplay() == 18857 then
pUnit:EquipWeapons(27769,0,0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
else
end
if SURVIVAL[id].VAR.Waves == 0 then
pUnit:SetHealth(pUnit:GetHealth() + 2000)
pUnit:SetMaxHealth(pUnit:GetMaxHealth() + 2000)
elseif SURVIVAL[id].VAR.Waves == 1 then
pUnit:SetHealth(pUnit:GetHealth() + 4000)
pUnit:SetMaxHealth(pUnit:GetMaxHealth() + 4000)
pUnit:CastSpell(40723) -- Damage done increased
elseif SURVIVAL[id].VAR.Waves == 2 then
pUnit:SetHealth(pUnit:GetHealth() + 6000)
pUnit:SetMaxHealth(pUnit:GetMaxHealth() + 6000)
pUnit:CastSpell(40723) -- Damage done
pUnit:CastSpell(40723)
elseif SURVIVAL[id].VAR.Waves == 3 then
pUnit:SetHealth(pUnit:GetHealth() + 8000)
pUnit:SetMaxHealth(pUnit:GetMaxHealth() + 8000)
pUnit:CastSpell(40723) -- Damage done
pUnit:CastSpell(40723)
pUnit:CastSpell(40723)
elseif SURVIVAL[id].VAR.Waves == 4 then
pUnit:SetHealth(pUnit:GetHealth() + 10000)
pUnit:SetMaxHealth(pUnit:GetMaxHealth() + 10000)
pUnit:CastSpell(40723) -- Damage done
pUnit:CastSpell(40723)
pUnit:CastSpell(40723)
pUnit:CastSpell(40723)
end
pUnit:RegisterEvent("SURVIVAL.VAR.SURVIVAL_MONSTER_PATHING",1000,1)
end

function SURVIVAL.VAR.SURVIVAL_MONSTER_PATHING(pUnit,Event)
pUnit:MoveTo(-1293.57,1616.19,91.76, 5.6)
end

function SURVIVAL.VAR.HUNGERER_COMBAT(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
if SURVIVAL[id].VAR.Waves == 0 or SURVIVAL[id].VAR.Waves == 1 or SURVIVAL[id].VAR.Waves == 2 then
else
pUnit:RegisterEvent("SURVIVAL.VAR.HUNGERER_CHARGE_WAVE", math.random(6000,12000),0)
end
end

function SURVIVAL.VAR.HUNGERER_CHARGE_WAVE(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 50 then
pUnit:CastSpellOnTarget(51492,player)
end
end
end
end




RegisterUnitEvent(16700, 1, "SURVIVAL.VAR.LEGIONAIRRE_COMBAT")
RegisterUnitEvent(16700, 18, "SURVIVAL.VAR.GENERIC_SURVIVAL_MOB_SPAWN")
RegisterUnitEvent(16700, 4, "SURVIVAL.VAR.LEGIONAIRRE_DEAD")
RegisterUnitEvent(16700, 2, "SURVIVAL.VAR.SURVIVAL_UNIVERSAL_DEATHLEAVE")


RegisterUnitEvent(17259, 1, "SURVIVAL.VAR.HUNGERER_COMBAT")
RegisterUnitEvent(17259, 18, "SURVIVAL.VAR.GENERIC_SURVIVAL_MOB_SPAWN")
RegisterUnitEvent(17259, 2, "SURVIVAL.VAR.SURVIVAL_UNIVERSAL_DEATHLEAVE")
RegisterUnitEvent(17259, 4, "SURVIVAL.VAR.SURVIVAL_UNIVERSAL_DEATHLEAVE")


function SURVIVAL.VAR.ACOLYTE_COMBAT(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
	pUnit:RegisterEvent("SURVIVAL.VAR.ACOLYTE_MINDFLAY", math.random(4000,8000),0)
pUnit:RegisterEvent("SURVIVAL.VAR.ACOLYTE_HEAL", math.random(3500,10000),0)
if SURVIVAL[id].VAR.Waves == 0 or SURVIVAL[id].VAR.Waves == 1 or SURVIVAL[id].VAR.Waves == 2 then
else
pUnit:RegisterEvent("SURVIVAL.VAR.ACOLYTE_SHIELD", math.random(8200,12000),0)
end
end

function SURVIVAL.VAR.ACOLYTE_SHIELD(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
if pUnit:GetCurrentSpellId() ~= nil then
	local FriendsAllAround = pUnit:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if friends ~= nil then
   if pUnit:GetDistanceYards(friends) < 45 then
  if friends:GetHealthPct() < 80 then
  if friends:IsDead() == false then
  if friends:HasAura(11647) == false then
    pUnit:CastSpellOnTarget(11647,friends)
end
end
end
end
end
end
end
end

function SURVIVAL.VAR.ACOLYTE_MINDFLAY(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
if pUnit:GetCurrentSpellId() ~= nil then
	local player = pUnit:GetRandomPlayer(0)
	if player ~= nil then
		if player:IsAlive() == true then
		if SURVIVAL[id].VAR.Waves == 4 or SURVIVAL[id].VAR.Waves == 5 or SURVIVAL[id].VAR.Waves == 6 or SURVIVAL[id].VAR.Waves == 7 or SURVIVAL[id].VAR.Waves == 8
or SURVIVAL[id].VAR.Waves == 9 then
pUnit:FullCastSpellOnTarget(60006,player)
		elseif SURVIVAL[id].VAR.Waves == 11 or SURVIVAL[id].VAR.Waves == 10 or SURVIVAL[id].VAR.Waves == 12 then
			pUnit:FullCastSpellOnTarget(26044,player)
			else
			pUnit:FullCastSpellOnTarget(42396,player)
				end
			end
		end
	end
end
	
	function SURVIVAL.VAR.ACOLYTE_HEAL(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SURVIVAL[id] = SURVIVAL[id] or {VAR={}}
if pUnit:GetCurrentSpellId() ~= nil then
pUnit:Root()
	local FriendsAllAround = pUnit:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if friends ~= nil then
   if pUnit:GetDistanceYards(friends) < 45 then
  if friends:GetHealthPct() < 50 then
  if friends:IsDead() == false then
  if SURVIVAL[id].VAR.Waves == 4 or SURVIVAL[id].VAR.Waves == 5 or SURVIVAL[id].VAR.Waves == 6 or SURVIVAL[id].VAR.Waves == 7 or SURVIVAL[id].VAR.Waves == 8
or SURVIVAL[id].VAR.Waves == 9 then
  pUnit:FullCastSpellOnTarget(24947,friends)
 pUnit:RegisterEvent("SURVIVAL.VAR.UNROOT_CASTER_YO", 2600, 1)
		elseif SURVIVAL[id].VAR.Waves == 11 or SURVIVAL[id].VAR.Waves == 10 or SURVIVAL[id].VAR.Waves == 12 then
  pUnit:FullCastSpellOnTarget(41455,friends)
  else
    pUnit:FullCastSpellOnTarget(8812,friends)
  pUnit:RegisterEvent("SURVIVAL.VAR.UNROOT_CASTER_YO", 2600, 1)
end
end
end
end
end
end
end
end

	function SURVIVAL.VAR.UNROOT_CASTER_YO(pUnit,Event)
if pUnit:GetCurrentSpellId() == nil then
pUnit:Unroot()
end
end
	
	RegisterUnitEvent(19415, 1, "SURVIVAL.VAR.ACOLYTE_COMBAT")
RegisterUnitEvent(19415, 18, "SURVIVAL.VAR.GENERIC_SURVIVAL_MOB_SPAWN")
RegisterUnitEvent(19415, 2, "SURVIVAL.VAR.SURVIVAL_UNIVERSAL_DEATHLEAVE")
RegisterUnitEvent(19415, 4, "SURVIVAL.VAR.SURVIVAL_UNIVERSAL_DEATHLEAVE")