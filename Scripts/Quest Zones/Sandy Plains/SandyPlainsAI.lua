SP = {}
SP.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000


function Pterrodax_Temp_OnCombat(pUnit,Event)
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 40 then
	players:PlayMusicToPlayer(50059)
	end
		end
	pUnit:RegisterEvent("Pterrodax_Temp_Breath",12000,0)
	pUnit:RegisterEvent("Pterrodax_Temp_FlameBuffet",6000,1)
	pUnit:RegisterEvent("Pterrodax_Temp_TerrifyingRoar",15000,1)
end

function Pterrodax_Temp_Breath(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:FullCastSpellOnTarget(51219, tank)
	end
end


function Pterrodax_Temp_TerrifyingRoar(pUnit,Event)
	pUnit:CastSpell(14100)
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:RegisterEvent("Pterrodax_Temp_TerrifyingRoar",15000,1)
	elseif choice == 2 then
		pUnit:RegisterEvent("Pterrodax_Temp_TerrifyingRoar",12000,1)
	elseif choice == 3 then
		pUnit:RegisterEvent("Pterrodax_Temp_TerrifyingRoar",18000,1)
	end
end

function Pterrodax_Temp_FlameBuffet(pUnit,Event)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
			pUnit:CastSpellOnTarget(23341,players)
		end
	end
end

function Pterrodax_Temp_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
	 local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	if pUnit:IsAlive() then
	players:PlayMusicToPlayer(4754)
	end
	end
		end
end


function PTRODX_TEMP_DEAD(pUnit,Event)
pUnit:RemoveEvents()
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	players:PlayMusicToPlayer(50084)
	end
		end
end


RegisterUnitEvent(9165, 1, "Pterrodax_Temp_OnCombat")
RegisterUnitEvent(9165, 2, "Pterrodax_Temp_OnLeave")
RegisterUnitEvent(9165, 4, "PTRODX_TEMP_DEAD")


function Fossilz_Events(pUnit,Event)
	if Event == 1 then
local i = 0
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	players:PlayMusicToPlayer(50059)
	end
		end
		pUnit:RegisterEvent("Fossilz_Summon_LesserRaptors", math.random(18000,24000), 0)
		pUnit:RegisterEvent("Fossilz_Check_Grouping", 2000, 0)
		pUnit:RegisterEvent("Fossilz_FuriousEnrage_Slam_Followup", math.random(16000,25000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	players:PlayMusicToPlayer(4754)
	end
		end
		for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 920705 then 
			creatures:Despawn(1,0)
			end
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		  		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	players:PlayMusicToPlayer(50084)
	end
		end
				for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 920705 then 
			creatures:Despawn(1,0)
			end
		end
	elseif Event == 18 then
		local choice = math.random(1,20)
	if choice == 1 and not pUnit:IsInCombat() then
	pUnit:Despawn(1000,2700000)
	end
end
	end


function Fossilz_Check_Grouping(pUnit)
	local PlayersAllAround = pUnit:GetInRangePlayers()
		local i = 0
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	if players:IsInCombat() and players:IsInGroup()  then	
	i = i + 1
	if i ~= 1 then
	pUnit:Strike(players,1,71203,6120,7104,1)
	end
	end
	end
	end
	end
	

function Fossilz_Summon_LesserRaptors(pUnit)
	local x = pUnit:GetX()-math.random(1,6)
	local y = pUnit:GetY()-math.random(1,6)
	pUnit:SpawnCreature(920705, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 14, 45000)
	pUnit:SpawnCreature(920705, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 14, 45000)
end
	

function Fossilz_FuriousEnrage_Slam_Followup(pUnit,Event)
	pUnit:CastSpell(35491)
	pUnit:RegisterEvent("Fossilz_GREATSLAMFOLLOWUP", 5000, 1)
end

function Fossilz_GREATSLAMFOLLOWUP(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(0) 
	if plr then
		pUnit:CastSpellOnTarget(46968, plr) 
	end
end

function Fossilz_LASHOUT(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		if pUnit:GetDistanceYards(plr) < 10 then
			pUnit:CastSpellOnTarget(6607, plr)
		end
	end
end

RegisterUnitEvent(920704, 1, "Fossilz_Events")
RegisterUnitEvent(920704, 2, "Fossilz_Events")
RegisterUnitEvent(920704, 4, "Fossilz_Events")
RegisterUnitEvent(920704, 18, "Fossilz_Events")


function GreaterPlainsRaptor_Events(pUnit,Event)
	if Event == 1 then
   pUnit:PlayMusicToSet(50059)
		pUnit:RegisterEvent("GPR_Summon_MatureRaptors", math.random(32000,40000), 0)
		pUnit:RegisterEvent("GPR_Summon_LesserRaptors", math.random(25000,28000), 0)
		pUnit:RegisterEvent("GPR_FuriousEnrage_Slam_Followup", math.random(25000,38000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		   pUnit:PlayMusicToSet(4754)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		   pUnit:PlayMusicToSet(4754)
	end
end
	
function GPR_Summon_MatureRaptors(pUnit)
	local x = pUnit:GetX()-math.random(1,6)
	local y = pUnit:GetY()-math.random(1,6)
	pUnit:SpawnCreature(20634, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 14, 45000)
end
	
function GPR_Summon_LesserRaptors(pUnit)
	local x = pUnit:GetX()-math.random(1,6)
	local y = pUnit:GetY()-math.random(1,6)
	pUnit:SpawnCreature(1015, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 14, 45000)
	pUnit:SpawnCreature(1015, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 14, 45000)
end
	

function GPR_FuriousEnrage_Slam_Followup(pUnit,Event)
	pUnit:CastSpell(35491)
	pUnit:RegisterEvent("GPR_GREATSLAMFOLLOWUP", 5000, 1)
end

function GPR_GREATSLAMFOLLOWUP(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(0) 
	if plr then
		pUnit:CastSpellOnTarget(46968, plr) 
	end
end

function GPR_LASHOUT(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		if pUnit:GetDistanceYards(plr) < 10 then
			pUnit:CastSpellOnTarget(6607, plr)
		end
	end
end

RegisterUnitEvent(20728, 1, "GreaterPlainsRaptor_Events")
RegisterUnitEvent(20728, 2, "GreaterPlainsRaptor_Events")
RegisterUnitEvent(20728, 4, "GreaterPlainsRaptor_Events")
	
function LAJ_EVENTS(pUnit,Event)
	if Event == 1 then
		pUnit:SendChatMessage(12,0,"You will share the same fate as the tauren!")
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:Despawn(1,1)
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end
		
RegisterUnitEvent(17980, 1, "LAJ_EVENTS")
RegisterUnitEvent(17980, 2, "LAJ_EVENTS")
RegisterUnitEvent(17980, 4, "LAJ_EVENTS")
	
function PB_Events(pUnit,Event)
	if Event == 18 then
		pUnit:SetMount(25871)
	--elseif Event == 1 then
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end
	
RegisterUnitEvent(419997, 18, "PB_Events")

function Voldu_Shaman_Events(pUnit,Event)
	if Event == 1 then
		pUnit:RegisterEvent("Voldush_CastEventOne", math.random(5000,10000), 0)
		pUnit:RegisterEvent("Voldush_CastEventTwo", math.random(15000,16000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end
		
function Voldush_CastEventOne(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:FullCastSpellOnTarget(9532,tank)
		end
	end
end

function Voldush_CastEventTwo(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:CastSpellOnTarget(66054,tank)
		end
	end
end

RegisterUnitEvent(900208, 1, "Voldu_Shaman_Events")
RegisterUnitEvent(900208, 2, "Voldu_Shaman_Events")
RegisterUnitEvent(900208, 4, "Voldu_Shaman_Events")

function Lokoko_Events(pUnit,Event)
	if Event == 1 then
		pUnit:CastSpell(57622)
		pUnit:SendChatMessage(12,0,"You want face ol' Lokoko? Me pee in your skull!")
		pUnit:RegisterEvent("Lokoko_FireShock", math.random(6000,15000), 0)
		pUnit:RegisterEvent("Lokoko_EarthShock", math.random(6000,12000), 0)
		pUnit:RegisterEvent("Lokoko_SearingTotem", 6000, 1)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12,0,"Me... wanted... to...")
	end
end
		
function Lokoko_EarthShock(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:CastSpellOnTarget(10412,tank)
		end
	end
end
				
function Lokoko_FireShock(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:CastSpellOnTarget(10447,tank)
		end
	end
end

function Lokoko_SearingTotem(pUnit)
	pUnit:CastSpell(58699)
	pUnit:RegisterEvent("Lokoko_SearingTotem", 15000, 1)
end

RegisterUnitEvent(900207, 1, "Lokoko_Events")
RegisterUnitEvent(900207, 2, "Lokoko_Events")
RegisterUnitEvent(900207, 4, "Lokoko_Events")
			
-- Longrunner Brist...

function LongrunnerSpawn(pUnit, Event)
	pUnit:RegisterEvent("DO_NOT_REGEN_HEALTH_LONG", 5000, 0)
end

function DO_NOT_REGEN_HEALTH_LONG(pUnit)
	pUnit:SetHealth(508) -- Max health around 8k
end

RegisterUnitEvent(25658, 18, "LongrunnerSpawn")


---
function SP.VAR.DIREAULIS_EV(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("SP.VAR.DIREAULIS_IMPALE_SETUP", 15000, 1)
	pUnit:RegisterEvent("SP.VAR.DIREAULIS_ROAR", 8000, 1)
	 pUnit:PlayMusicToSet(50059)
elseif Event == 2 then
pUnit:RemoveEvents()
 pUnit:AIDisableCombat(false) 
 pUnit:Unroot()
 pUnit:RemoveAura(40714)
  pUnit:PlayMusicToSet(4754)
elseif Event == 4 then
pUnit:RemoveEvents()
 pUnit:AIDisableCombat(false) 
 pUnit:Unroot()
  pUnit:PlayMusicToSet(4754)
 pUnit:RemoveAura(40714)
end
end

RegisterUnitEvent(920040, 1, "SP.VAR.DIREAULIS_EV")
RegisterUnitEvent(920040, 2, "SP.VAR.DIREAULIS_EV")
RegisterUnitEvent(920040, 4, "SP.VAR.DIREAULIS_EV")


function SP.VAR.DIREHORN_EV(pUnit,Event)
if Event == 1 then
	pUnit:RegisterEvent("SP.VAR.DIREAULIS_ROAR", 8000, 1)
elseif Event == 2 then
pUnit:RemoveEvents()
 pUnit:AIDisableCombat(false) 
 pUnit:Unroot()
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
   local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
players:Unroot()
players:SetPlayerLock(0)
	end
		end
elseif Event == 4 then
pUnit:RemoveEvents()
 pUnit:AIDisableCombat(false) 
 pUnit:Unroot()
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
   local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
players:Unroot()
players:SetPlayerLock(0)
	end
		end
end
end

RegisterUnitEvent(920041, 1, "SP.VAR.DIREHORN_EV")
RegisterUnitEvent(920041, 2, "SP.VAR.DIREHORN_EV")
RegisterUnitEvent(920041, 4, "SP.VAR.DIREHORN_EV")

function SP.VAR.DIREAULIS_ROAR(pUnit,Event)
for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
local name = pUnit:GetName()
pUnit:SendChatMessageToPlayer(42,0,""..name.." begins to cast \124cff71d5ff\124Hspell:42708\124h[Staggering Roar]\124h\124r",players)
end
	end
pUnit:Root()
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetOrientation(pUnit:GetO())
pUnit:FullCastSpell(42708)
pUnit:RegisterEvent("SP.VAR.DIREAULIS_ROAR_CAST", 1700, 1)
end

function SP.VAR.DIREAULIS_ROAR_CAST(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	if players:GetCurrentSpellId()   then
	players:CancelSpell()
	pUnit:CastSpellOnTarget(65542,players)
	pUnit:Strike(players, 2, 70569, 340, 375, 1.2)
	end
	end
	end
pUnit:Unroot()
pUnit:CancelSpell()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

function SP.VAR.DIREAULIS_IMPALE_SETUP(pUnit,Event)
pUnit:RemoveEvents()
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:Root()
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 20 then
	pUnit:CastSpellOnTarget(54899,players)
end
end
pUnit:RegisterEvent("SP.VAR.DIREAULIS_IMPALE", 4000, 1)
pUnit:RegisterEvent("SP.VAR.ROOT_PLAYERS", 2800, 1)
end

function SP.VAR.ROOT_PLAYERS(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 20 then
	players:Root()
	players:SetPlayerLock(1)
	players:Emote(64,4000)
players:CastSpell(40714)
end
end
end

function SP.VAR.DIREAULIS_IMPALE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SP[id] = SP[id] or {VAR={}}
SP[id].VAR.Impaletarget = pUnit:GetRandomPlayer(0)
if pUnit:GetDistanceYards(SP[id].VAR.Impaletarget) < 15 then
if SP[id].VAR.Impaletarget:IsDead() == false then
pUnit:SendChatMessageToPlayer(42,0,"Direaulis begins to charge at YOU!", SP[id].VAR.Impaletarget)
local name = SP[id].VAR.Impaletarget:GetName()
for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
local name = pUnit:GetName()
pUnit:SendChatMessageToPlayer(42,0,"Direaulis begins to fixate on "..name.."",players)
end
	end
pUnit:SendChatMessage(42,0,"Direaulis begins to fixate on "..name.."")
pUnit:SetOrientation(SP[id].VAR.Impaletarget:GetO())
end
end
pUnit:RegisterEvent("SP.VAR.DIREAULIS_IMPALE_CHARGE", 2000, 1)
end



function SP.VAR.DIREAULIS_IMPALE_CHARGE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SP[id] = SP[id] or {VAR={}}
	pUnit:Unroot()
	pUnit:SetOrientation(SP[id].VAR.Impaletarget:GetO())
	pUnit:ModifyRunSpeed(18)
	pUnit:ModifyWalkSpeed(18)
	pUnit:MoveTo(SP[id].VAR.Impaletarget:GetX(),SP[id].VAR.Impaletarget:GetY(),SP[id].VAR.Impaletarget:GetZ(),SP[id].VAR.Impaletarget:GetO())
	pUnit:RegisterEvent("SP.VAR.DIREAULIS_STUNNED", 4000, 1)
	pUnit:RegisterEvent("SP.VAR.UNROOT_PLAYERS", 200, 1)
	pUnit:RegisterEvent("SP.VAR.DIREAULIS_CRASH", 1200, 0)
end


function SP.VAR.DIREAULIS_CRASH(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 4.8 then
	if players:IsDead() == false then
	pUnit:CastSpellOnTarget(66770,players)
	end
	end
	end
end

function SP.VAR.UNROOT_PLAYERS(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	players:Unroot()
	players:SetPlayerLock(0)
		players:Emote(0,1000)
players:RemoveAura(40714)
end
end
end

function SP.VAR.DIREAULIS_STUNNED(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Emote(64,5000)
pUnit:CastSpell(40714)
for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 25 then
local name = pUnit:GetName()
pUnit:SendChatMessageToPlayer(42,0,"Direaulis is stunned!",players)
end
	end
pUnit:RegisterEvent("SP.VAR.DIREAULIS_UNSTUNNED", 5100, 1)
end

function SP.VAR.DIREAULIS_UNSTUNNED(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SP[id] = SP[id] or {VAR={}}
pUnit:AIDisableCombat(false)
	pUnit:ModifyRunSpeed(14)
	pUnit:ModifyWalkSpeed(2.5)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
SP[id].VAR.Impaletarget = nil
pUnit:RemoveAura(40714)
pUnit:RegisterEvent("SP.VAR.DIREAULIS_IMPALE_SETUP", 25000, 0)
pUnit:RegisterEvent("SP.VAR.DIREAULIS_ROAR", 10000, 0)
end



function SP.VAR.DEVILSAUR_EV(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("SP.VAR.DEVILSAUR_LEAP_SETUP", 15000, 1)
pUnit:RegisterEvent("SP.VAR.DEVILSAUR_BREATH", 8000, 1)
	 pUnit:PlayMusicToSet(50083)
elseif Event == 2 then
pUnit:RemoveEvents()
 pUnit:AIDisableCombat(false) 
 pUnit:Unroot()
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
 pUnit:RemoveAura(40714)
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
players:Unroot()
players:SetPlayerLock(0)
players:SetStandState(0)
if pUnit:IsAlive() then
	players:PlayMusicToPlayer(4754)
	end
	end
		end
		elseif Event == 3 then
		 local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	if players:IsDead() then
players:Unroot()
players:SetPlayerLock(0)
players:SetStandState(0)
	end
	end
		end
elseif Event == 4 then
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
 pUnit:AIDisableCombat(false) 
 pUnit:Unroot()
  pUnit:PlayMusicToSet(50084)
 pUnit:RemoveAura(40714)
   local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
players:Unroot()
players:SetStandState(0)
players:SetPlayerLock(0)
	end
		end
end
end

function SP.VAR.DEVILSAUR_BREATH(pUnit,Event)
pUnit:SetOrientation(pUnit:GetO())
pUnit:FullCastSpell(74806)
pUnit:RegisterEvent("SP.VAR.DEVILSAUR_BREATH_CAST", 1700, 1)
end

function SP.VAR.DEVILSAUR_BREATH_CAST(pUnit,Event)
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

RegisterUnitEvent(6500, 1, "SP.VAR.DEVILSAUR_EV")
RegisterUnitEvent(6500, 2, "SP.VAR.DEVILSAUR_EV")
RegisterUnitEvent(6500, 4, "SP.VAR.DEVILSAUR_EV")
RegisterUnitEvent(6500, 3, "SP.VAR.DEVILSAUR_EV")

function SP.VAR.DEVILSAUR_LEAP_SETUP(pUnit,Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("SP.VAR.DEVILSAUR_LEAP", 1000, 1)
end



function SP.VAR.DEVILSAUR_LEAP(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SP[id] = SP[id] or {VAR={}}
SP[id].VAR.Cannibalizetarget = pUnit:GetRandomPlayer(0)
if SP[id].VAR.Cannibalizetarget ~= nil then
if pUnit:GetDistanceYards(SP[id].VAR.Cannibalizetarget) < 30 then
if SP[id].VAR.Cannibalizetarget:IsDead() == false then
local name = SP[id].VAR.Cannibalizetarget:GetName()
for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 25 then
pUnit:SendChatMessageToPlayer(42,0,"Tyrant Devilsaur leaps on "..name.."",players)
end
	end
			pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:Root()
pUnit:SetOrientation(SP[id].VAR.Cannibalizetarget:GetO())
SP[id].VAR.Cannibalizetarget:SetStandState(7)
SP[id].VAR.Cannibalizetarget:Root()
SP[id].VAR.Cannibalizetarget:SetPlayerLock(1)
end
end
end
pUnit:RegisterEvent("SP.VAR.DEVILSAUR_LEAP_CHARGE", 1000, 1)
end




function SP.VAR.DEVILSAUR_LEAP_CHARGE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SP[id] = SP[id] or {VAR={}}
	pUnit:Unroot()
	if SP[id].VAR.Cannibalizetarget then
		pUnit:CastSpellOnTarget(64942,SP[id].VAR.Cannibalizetarget)
		pUnit:MoveKnockback(SP[id].VAR.Cannibalizetarget:GetX(), SP[id].VAR.Cannibalizetarget:GetY(), SP[id].VAR.Cannibalizetarget:GetZ(), 6, 13)
		pUnit:Emote(35,30000)
		pUnit:RegisterEvent("SP.VAR.DEVILSAUR_STUNNED", 7100, 1)
		pUnit:RegisterEvent("SP.VAR.DEVILSAUR_LEAP_DAMAGE", 1000, 7)
	end
end

function SP.VAR.DEVILSAUR_LEAP_DAMAGE(pUnit)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SP[id] = SP[id] or {VAR={}}
	pUnit:CastSpell(54350)
	pUnit:Strike(SP[id].VAR.Cannibalizetarget, 2, 70569, 180, 230, 1.2)
end



function SP.VAR.DEVILSAUR_STUNNED(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SP[id] = SP[id] or {VAR={}}
pUnit:RemoveEvents()
SP[id].VAR.Cannibalizetarget:Unroot()
SP[id].VAR.Cannibalizetarget:SetPlayerLock(0)
SP[id].VAR.Cannibalizetarget:SetStandState(0)
SP[id].VAR.Cannibalizetarget = nil
pUnit:AIDisableCombat(false)
	pUnit:ModifyRunSpeed(14)
	pUnit:ModifyWalkSpeed(2.5)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:CastSpell(53361)
pUnit:RegisterEvent("SP.VAR.DEVILSAUR_LEAP_SETUP", 15000, 1)
	pUnit:RegisterEvent("SP.VAR.DEVILSAUR_BREATH", 8000, 1)
end



------SCAR-SHELL_RAIDBOSSQUEST----


function SP.VAR.SCARSHELL_EVENTS(pUnit,Event)
if Event == 1 then
	pUnit:ModifyRunSpeed(4)
	pUnit:ModifyWalkSpeed(2.5)
		pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:RegisterEvent("SP.VAR.SCARSHELL_STOMP", 28000, 1)
pUnit:RegisterEvent("SP.VAR.SCARSHELL_BERSERK", 420000, 1)
pUnit:RegisterEvent("SP.VAR.SCARSHELL_CHECKRANGE", 5000, 0)
pUnit:RegisterEvent("SP.VAR.SCARSHELL_GREVIOUSBITE", math.random(8000,10000), 0)
pUnit:RegisterEvent("SP.VAR.SCARSHELL_VOLATILESPAWNINGS", math.random(15000,17000), 0)
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	players:PlayMusicToPlayer(50085)
	end
		end
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:Despawn(1000,7000)
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	if pUnit:IsAlive() then
	players:PlayMusicToPlayer(4754)
	end
	end
		end
elseif Event == 4 then
pUnit:RemoveEvents()
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	players:PlayMusicToPlayer(50084)
	end
		end
elseif Event == 18 then
	pUnit:ModifyRunSpeed(4)
	pUnit:ModifyWalkSpeed(2.5)
		pUnit:Unroot()
pUnit:AIDisableCombat(false)
end
	end
	
	
RegisterUnitEvent(13896, 1, "SP.VAR.SCARSHELL_EVENTS")
RegisterUnitEvent(13896, 2, "SP.VAR.SCARSHELL_EVENTS")
RegisterUnitEvent(13896, 4, "SP.VAR.SCARSHELL_EVENTS")
RegisterUnitEvent(13896, 18, "SP.VAR.SCARSHELL_EVENTS")

function SP.VAR.SCARSHELL_CHECKRANGE(pUnit)
 local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) > 20 and players:IsAlive() then
	pUnit:CastSpell(26662)
	pUnit:CastSpell(56354)
	end
		end
			end
	
	function SP.VAR.SCARSHELL_GREVIOUSBITE(pUnit)
	pUnit:Root()
pUnit:AIDisableCombat(true)
local plr = pUnit:GetMainTank()
	if plr then
		if pUnit:GetDistanceYards(plr) < 10 then
			pUnit:FullCastSpellOnTarget(48920, plr)
		end
	end
pUnit:RegisterEvent("SP.VAR.DEVILSAUR_BREATH_CAST", 1100, 1)
end


function SP.VAR.SCARSHELL_BERSERK(pUnit)
pUnit:CastSpell(26662)
end

function SP.VAR.SCARSHELL_VOLATILE_DUMMY_SPELLONE(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:CastSpell(66969)
pUnit:RegisterEvent("SP.VAR.SCARSHELL_VOLATILE_DUMMY_SPELLTWO", 1500, 1)
end
	


function SP.VAR.SCARSHELL_VOLATILE_DUMMY_SPELLTWO(pUnit,Event)
pUnit:CastSpell(63547)
pUnit:RegisterEvent("SP.VAR.SCARSHELL_DEALDAMAGE_VOLATILEDUMMY", 500, 1)
end

function SP.VAR.SCARSHELL_DEALDAMAGE_VOLATILEDUMMY(pUnit)
local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 5.4 then
			if players:IsDead() == false then
				players:CastSpell(54899)
				pUnit:Strike(players, 2, 70569, 200, 400, 2)
			end
		end
	end
end

RegisterUnitEvent(920792, 18, "SP.VAR.SCARSHELL_VOLATILE_DUMMY_SPELLONE")

function SP.VAR.SCARSHELL_VOLATILESPAWNINGS(pUnit)
	local x = pUnit:GetX()-math.random(1,15)
	local y = pUnit:GetY()-math.random(1,15)
	pUnit:SpawnCreature(920792, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 35, 4000)
	pUnit:SpawnCreature(920792, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 35, 4000)
		pUnit:SpawnCreature(920792, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 35, 4000)
			pUnit:SpawnCreature(920792, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 35, 4000)
				pUnit:SpawnCreature(920792, x, y, pUnit:GetLandHeight(x, y), math.random(0,6), 35, 4000)
		local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 30 then
		pUnit:SpawnCreature(920792, players:GetX(), players:GetY(), players:GetZ(), 0, 35, 4000)
			if players:IsAlive() then
				end
			end
	end
end


function SP.VAR.SCARSHELL_STOMP(pUnit,Event)
pUnit:Root()
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetOrientation(pUnit:GetO())
pUnit:FullCastSpell(53634)
pUnit:RegisterEvent("SP.VAR.SCARSHELL_STOMP_CAST", 1100, 1)
end

function SP.VAR.SCARSHELL_STOMP_CAST(pUnit,Event)
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:RegisterEvent("SP.VAR.SCARSHELL_STOMP", 22000, 1)
end
