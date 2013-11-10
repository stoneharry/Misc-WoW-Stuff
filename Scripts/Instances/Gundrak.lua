GUN = {}
GUN.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000


SetDBCSpellVar(47740, "c_is_flags", 0x01000)
SetDBCSpellVar(28679, "c_is_flags", 0x01000)
SetDBCSpellVar(3609, "c_is_flags", 0x01000)





---First Boss Trash--


function GUN.VAR.BEHEMOTH_COMBAT(pUnit,Event)
pUnit:RegisterEvent("GUN.VAR.BEHEMOTH_MIGHTYBLOW", 8000, 0)
pUnit:RegisterEvent("GUN.VAR.BEHEMOTH_FRENZY", 1000, 0)
 if math.random(1,3) == 1 then
pUnit:SendChatMessage(14,0,"Me gonna carve you and eat you!")
	pUnit:PlaySoundToSet(13185)
elseif math.random(1,3) == 2 then
pUnit:SendChatMessage(14,0,"So hungry! Must feed!")
	pUnit:PlaySoundToSet(13182)
elseif math.random(1,3) == 3 then
pUnit:SendChatMessage(14,0,"More guts. More blood. More food!")
pUnit:PlaySoundToSet(13181)
end
end

function GUN.VAR.BEHEMOTH_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:PlaySoundToSet(13183)
end


function GUN.VAR.BEHEMOTH_FRENZY(pUnit,Event)
if pUnit:GetHealthPct() < 60 then
pUnit:RemoveEvents()
pUnit:CastSpell(28747)
--pUnit:RegisterEvent("GUN.VAR.BEHEMOTH_MIGHTYBLOW", 8000, 0)
--pUnit:RegisterEvent("GUN.VAR.BEHEMOTH_DIRESTOMP", 14000, 0)
end
end

function GUN.VAR.BEHEMOTH_DIRESTOMP(pUnit,Event)
pUnit:CastSpell(54959)
end

function GUN.VAR.BEHEMOTH_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:RemoveAura(28747)
end


function GUN.VAR.BEHEMOTH_MIGHTYBLOW(pUnit,Event)
		local tank = pUnit:GetMainTank()
		if tank then
		if pUnit:GetDistanceYards(tank) < 5 then
pUnit:CastSpellOnTarget(43673,tank)
end
end
end

RegisterUnitEvent(29666, 1, "GUN.VAR.BEHEMOTH_COMBAT")
RegisterUnitEvent(29666, 4, "GUN.VAR.BEHEMOTH_DEAD")
RegisterUnitEvent(29666, 2, "GUN.VAR.BEHEMOTH_LEAVE")


function GUN.VAR.FORGOTTEN_OVERLORD_COMBAT(pUnit,Event)
pUnit:RegisterEvent("GUN.VAR.FORGOTTEN_OVERLORD_FRENZY", 6000, 1)
pUnit:RegisterEvent("GUN.VAR.FORGOTTEN_OVERLORD_WOUND", 8000, 0)
end

function GUN.VAR.SHAMAN_CHAINHEAL(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:Root()
	local FriendsAllAround = pUnit:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if friends   then
   if pUnit:GetDistanceYards(friends) < 15 then
  if friends:GetHealthPct() < 50 then
  if friends:IsDead() == false then
  pUnit:FullCastSpellOnTarget(16367,friends)
  pUnit:RegisterEvent("GUN.VAR.UNROOT_CASTER", 2600, 1)
end
end
end
end
end
end
end

function GUN.VAR.SHAMAN_HEX(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:Root()
local player = pUnit:GetRandomPlayer(0)
if player:HasAura(66054) == false then
if pUnit:GetDistanceYards(player) < 15 then
pUnit:FullCastSpellOnTarget(66054,player)
  pUnit:RegisterEvent("GUN.VAR.UNROOT_CASTER", 1600, 1)
  end
end
end
end

function GUN.VAR.UNROOT_CASTER(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:Unroot()
end
end

function GUN.VAR.SHAMAN_COMBAT(pUnit,Event)
 if math.random(1,10) == 1 then
pUnit:SendChatMessage(12,0,"Ya gonna join da rest!")
elseif math.random(1,10) == 2 then
pUnit:SendChatMessage(12,0,"I be lookin' foward to dissectin' ya!")
end
pUnit:RegisterEvent("GUN.VAR.UNROOT_CASTER", 2000, 0)
pUnit:RegisterEvent("GUN.VAR.SHAMAN_HEX", 6000, 0)
pUnit:RegisterEvent("GUN.VAR.SHAMAN_CHAINHEAL", 3000, 0)
end

function GUN.VAR.SHAMAN_LEAVEANDDEAD(pUnit,Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(29826, 1, "GUN.VAR.SHAMAN_COMBAT")
RegisterUnitEvent(29826, 4, "GUN.VAR.SHAMAN_LEAVEANDDEAD")
RegisterUnitEvent(29826, 2, "GUN.VAR.SHAMAN_LEAVEANDDEAD")

function GUN.VAR.FIRECASTER_COMBAT(pUnit,Event)
pUnit:RegisterEvent("GUN.VAR.FIRECASTER_HASTE", 2000, 1)
pUnit:RegisterEvent("GUN.VAR.FIRECASTER_FIREBALL", 3000, 0)
end

function GUN.VAR.FIRECASTER_FIREBALL(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:Root()
local tank = pUnit:GetMainTank()
if pUnit:GetDistanceYards(tank) < 12 then
pUnit:FullCastSpellOnTarget(35853,tank)
  pUnit:RegisterEvent("GUN.VAR.UNROOT_CASTER", 2600, 1)
  end
end
end

function GUN.VAR.FIRECASTER_HASTE(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:CastSpell(43242)
end
pUnit:RegisterEvent("GUN.VAR.FIRECASTER_HASTE", 30000, 1)
end

RegisterUnitEvent(29822, 1, "GUN.VAR.FIRECASTER_COMBAT")
RegisterUnitEvent(29822, 4, "GUN.VAR.SHAMAN_LEAVEANDDEAD")
RegisterUnitEvent(29822, 2, "GUN.VAR.SHAMAN_LEAVEANDDEAD")

function GUN.VAR.FORGOTTEN_OVERLORD_LEAVEANDDEAD(pUnit,Event)
pUnit:RemoveEvents()
end

function GUN.VAR.FORGOTTEN_OVERLORD_FRENZY(pUnit,Event)
pUnit:CastSpell(53361)
pUnit:RegisterEvent("GUN.VAR.FORGOTTEN_OVERLORD_FRENZY", 12000, 1)
end

function GUN.VAR.FORGOTTEN_OVERLORD_WOUND(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 10 then
			pUnit:CastSpellOnTarget(39215,tank)
end
end
end

RegisterUnitEvent(29214, 1, "GUN.VAR.FORGOTTEN_OVERLORD_COMBAT")
RegisterUnitEvent(29214, 4, "GUN.VAR.FORGOTTEN_OVERLORD_LEAVEANDDEAD")
RegisterUnitEvent(29214, 2, "GUN.VAR.FORGOTTEN_OVERLORD_LEAVEANDDEAD")


-- FIRST BOSS -- 

function GUN.VAR.MOORABI_TRANSFORM_MAMMOTH(pUnit,Event)
pUnit:RemoveEvents()
pUnit:CastSpell(55098)
pUnit:EquipWeapons(0,0,0)
pUnit:SetAttackTimer(2100, 2100)
	pUnit:SendChatMessage(14,0,"Get ready for somethin'... much... BIGGAH!")
		pUnit:PlaySoundToSet(14722)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_MAMMOTH_CHARGE", 8000, 0)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_MAMMOTH_ROAR", 13000, 0)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_MAMMOTH_MANGLE", 6000, 0)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_MAMMOTH_STOMP", 12000, 0)
pUnit:RegisterEvent("GUN.VAR.MOORABI_MAMMOTH_IMPALE", 9000, 0)		
		pUnit:RegisterEvent("GUN.VAR.MOORABI_TRANSFORM", 24000, 1)
end

function GUN.VAR.MOORABI_MAMMOTH_CHARGE(pUnit,Event)
local player = pUnit:GetRandomPlayer(0)
if player then
if pUnit:GetDistanceYards(player) < 25 then
pUnit:CastSpellOnTarget(29320,player)
end
end
end

function GUN.VAR.MOORABI_MAMMOTH_STOMP(pUnit,Event)
pUnit:CastSpell(38045)
end

function GUN.VAR.MOORABI_MAMMOTH_MANGLE(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 10 then
		if tank:HasAura(71925) == false then
			pUnit:CastSpellOnTarget(71925,tank)
end
end
end
end

function GUN.VAR.MOORABI_WOUND(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 10 then
		if tank:HasAura(15583) == false then
			pUnit:CastSpellOnTarget(15583,tank)
end
end
end
end

function GUN.VAR.MOORABI_GORE(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 10 then
		if tank:HasAura(52873) == false then
			pUnit:CastSpellOnTarget(52873,tank)
end
end
end
end

function GUN.VAR.MOORABI_MAMMOTH_IMPALE(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 10 then
		if tank:HasAura(24332) == false then
			pUnit:CastSpellOnTarget(24332,tank)
end
end
end
end

function GUN.VAR.MOORABI_MAMMOTH_ROAR(pUnit,Event)
pUnit:CastSpell(55100)
pUnit:PlaySoundToSet(14724)
end

function GUN.VAR.MOORABI_SHOUT(pUnit,Event)
pUnit:CastSpell(55106)
end

function GUN.VAR.MOORABI_TRANSFORM(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetAttackTimer(1200,1200)
pUnit:RemoveAura(55098)
pUnit:EquipWeapons(33389,33389,0)
	pUnit:SendChatMessage(14,0,"Da ground gonna swallow you up!")
		pUnit:PlaySoundToSet(14723)
				pUnit:RegisterEvent("GUN.VAR.MOORABI_SHOUT", 7000, 0)
					pUnit:RegisterEvent("GUN.VAR.MOORABI_GORE", 5000, 0)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_WOUND", 10000, 0)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_TRANSFORM_MAMMOTH", 24000, 1)
end

function GUN.VAR.MOORABI_COMBAT(pUnit,Event)
	pUnit:SendChatMessage(14,0,"We fought back da Scourge! What chance you thinkin' YOU got?")
		pUnit:PlaySoundToSet(14721)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_SHOUT", 7000, 0)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_GORE", 5000, 0)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_WOUND", 10000, 0)
		pUnit:RegisterEvent("GUN.VAR.MOORABI_TRANSFORM_MAMMOTH", 24000, 1)
		pUnit:GetGameObjectNearestCoords(1773.36, 878.36, 124.43, 192632):SetByte(GAMEOBJECT_BYTES_1,0,1)
end

function GUN.VAR.MOORABI_DEAD(pUnit,Event)
pUnit:RemoveEvents()
	pUnit:SendChatMessage(14,0,"If our gods can die... den so can we...")
		pUnit:PlaySoundToSet(14728)
pUnit:GetGameObjectNearestCoords(1706.16,842.01, 129.43, 180322):Despawn(1000,0)
pUnit:GetGameObjectNearestCoords(1773.36, 878.36, 124.43, 192632):SetByte(GAMEOBJECT_BYTES_1,0,0)
pUnit:GetGameObjectNearestCoords(1724.38, 852.42, 129.19, 193208):SetByte(GAMEOBJECT_BYTES_1,0,0)
end

function GUN.VAR.MOORABI_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Despawn(2000,5000)
pUnit:EquipWeapons(33389,33389,0)
pUnit:GetGameObjectNearestCoords(1773.36, 878.36, 124.43, 192632):SetByte(GAMEOBJECT_BYTES_1,0,0)
end


RegisterUnitEvent(29305, 1, "GUN.VAR.MOORABI_COMBAT")
RegisterUnitEvent(29305, 4, "GUN.VAR.MOORABI_DEAD")
RegisterUnitEvent(29305, 2, "GUN.VAR.MOORABI_LEAVE")

---First Boss Done ---

--Second Boss Trash--

function GUN.VAR.BLOODRINKER_LEECH(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 10 then
			pUnit:CastSpellOnTarget(11898,tank)
end
end
end

function GUN.VAR.BLOODDRINKER_FEAR(pUnit,Event)
local player = pUnit:GetRandomPlayer(0)
if player then
if pUnit:GetDistanceYards(player) < 25 then
if player:HasAura(65809) == false then
pUnit:CastSpellOnTarget(65809,player)
end
end
end
end

function GUN.VAR.BLOODDRINKER_COMBAT(pUnit,Event)
pUnit:RegisterEvent("GUN.VAR.BLOODDRINKER_FEAR", 6000, 0)
pUnit:RegisterEvent("GUN.VAR.BLOODRINKER_LEECH", 8000, 0)	
end

function GUN.VAR.BLOODDRINKER_DEADLEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(29654, 1, "GUN.VAR.BLOODDRINKER_COMBAT")
RegisterUnitEvent(29654, 4, "GUN.VAR.BLOODDRINKER_DEADLEAVE")
RegisterUnitEvent(29654, 2, "GUN.VAR.BLOODDRINKER_DEADLEAVE")

--Second Boss--
--[[PROPHET THARONJA

SPELL VISUAL DISPLAY IDS:

28450 == Black Acid Puddle
47767 == spirit beam channel
70571 == HOLY ZONE VISUAL, use as escape from spirit world.]]



function GUN.VAR.THARONJA_SPIRITWORLD_PHASE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetModel(25460)
pUnit:SetScale(1.1)
pUnit:CastSpell(9617)
pUnit:Root()
pUnit:TeleportCreature(1673.19,743.57,142.78)
pUnit:AIDisableCombat(true)
 if math.random(1,2) == 1 then
    pUnit:SendChatMessage(14,0,"Your flesh serves Tharon'ja now!")
pUnit:PlaySoundToSet(13865)
  elseif math.random(1,2) == 2 then
      pUnit:SendChatMessage(14,0,"Tharon'ja has a use for your mortal shell!")
pUnit:PlaySoundToSet(13866)
end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 50 then
  if players:IsDead() == false then
  players:CastSpell(47740)
    players:CastSpell(9617)
	--players:SetPhase(32)
	 if math.random(1,2) == 1 then
	   players:CastSpell(65686)
	  elseif math.random(1,2) == 2 then
	    players:CastSpell(65684)
		end
end
end
end
	pUnit:RegisterEvent("GUN.VAR.THARONJA_LIFEDRAIN", 5500, 0)
	pUnit:RegisterEvent("GUN.VAR.THARONJA_CHECKING_FOR_PLAYERS", 1000, 0)
	pUnit:RegisterEvent("GUN.VAR.THARONJA_ADDSPIRIT", 2000, 1)
	pUnit:RegisterEvent("GUN.VAR.SPIRIT_PHASE_OVER", 60000, 1)
end





function GUN.VAR.THARONJA_CHECKING_FOR_PLAYERS(pUnit)
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
			if creatures:GetEntry() == 14513 or creatures:GetEntry() == 67192 then 
				creatures:Despawn(1,0)
			end
		end
		pUnit:Despawn(2000,5000)
	end
end


function GUN.VAR.SPIRIT_PHASE_OVER(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetScale(1)
pUnit:DeMorph()
pUnit:AIDisableCombat(false)
pUnit:Unroot()
pUnit:RemoveAura(9617)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  players:RemoveAura(65684)
  players:RemoveAura(65686)
  players:RemoveAura(9617)
    players:RemoveAura(47740)
  players:SetPhase(1)
    if math.random(1,2) == 1 then
    pUnit:SendChatMessage(14,0,"No! A taste...all too brief!")
pUnit:PlaySoundToSet(13867)
  elseif math.random(1,2) == 2 then
      pUnit:SendChatMessage(14,0,"Agghh! Tharon'ja will have more!")
pUnit:PlaySoundToSet(13868)
end
end
end
 for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 14513 then
	pUnit:CastSpell(28679)
	creatures:Despawn(1,0)
 pUnit:CastSpell(69131)
	else
	local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  players:CastSpell(69391)
	end
	end
	end
	end
pUnit:RegisterEvent("GUN.VAR.THARONJA_DEFILE", 8000, 0)
pUnit:RegisterEvent("GUN.VAR.THARONJA_ANCIENTCURSE", 3000, 1)
pUnit:RegisterEvent("GUN.VAR.THARONJA_BREATH", 10000, 1)
pUnit:RegisterEvent("GUN.VAR.THARONJA_SPIRITWORLD_PHASE", 42000, 1)
end

function GUN.VAR.THARONJA_LIFEDRAIN(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  if players:IsDead() == false then
  pUnit:CastSpellOnTarget(11699,players)
   players:Strike(pUnit,1,5679,100,150,1)
end
end
end
end


function GUN.VAR.THARONJA_COMBAT(pUnit,Event)
    pUnit:SendChatMessage(14,0,"Tharon'ja sees all! The work of mortals shall not end the eternal dynasty!")
pUnit:PlaySoundToSet(13862)
pUnit:GetGameObjectNearestCoords(1651.09, 743.78, 142.78, 192568):SetByte(GAMEOBJECT_BYTES_1,0,1)
	pUnit:RegisterEvent("GUN.VAR.THARONJA_SPIRITWORLD_PHASE", 42000, 1)
	pUnit:RegisterEvent("GUN.VAR.THARONJA_DEFILE", 8000, 0)
	pUnit:RegisterEvent("GUN.VAR.THARONJA_ANCIENTCURSE", 3000, 1)
	pUnit:RegisterEvent("GUN.VAR.THARONJA_BREATH", 10000, 1)
end

function GUN.VAR.THARONJA_BREATH(pUnit,Event)
pUnit:Root()
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetOrientation(pUnit:GetO())
pUnit:SendChatMessage(42,0,"Prophet Tharonja Begins to spew an \124cff71d5ff\124Hspell:56524\124h[Acidic Breath]\124h\124r")
pUnit:RegisterEvent("GUN.VAR.THARONJA_BREATH_CAST", 3000, 1)
end

function GUN.VAR.THARONJA_BREATH_CAST(pUnit,Event)
pUnit:CastSpell(34268)
pUnit:SetOrientation(pUnit:GetO())
pUnit:RegisterEvent("GUN.VAR.THARONJA_BREATH_UNROOT", 1000, 1)
end

function GUN.VAR.THARONJA_BREATH_UNROOT(pUnit,Event)
pUnit:Unroot()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:AIDisableCombat(false)
pUnit:RegisterEvent("GUN.VAR.THARONJA_BREATH", 10000, 1)
end

function GUN.VAR.THARONJA_ANCIENTCURSE(pUnit,Event)
pUnit:CastSpell(60121)
pUnit:RegisterEvent("GUN.VAR.THARONJA_ANCIENTCURSE", 30000, 1)
end

function GUN.VAR.THARONJA_DEAD(pUnit,Event)
    pUnit:SendChatMessage(14,0,"Im...impossible! Tharon'ja is eternal! Tharon'ja...is...")
pUnit:PlaySoundToSet(13869)
pUnit:SetScale(1)
pUnit:DeMorph()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(9617)
pUnit:GetGameObjectNearestCoords(1651.09, 743.78, 142.78, 192568):SetByte(GAMEOBJECT_BYTES_1,0,0)
pUnit:GetGameObjectNearestCoords(1624.30, 711.68, 142.78, 193208):SetByte(GAMEOBJECT_BYTES_1,0,0)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  players:RemoveAura(65684)
  players:RemoveAura(47740)
  players:RemoveAura(9617)
  players:RemoveAura(65686)
  players:SetPhase(1)
  end
  end
  for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 14513 or creatures:GetEntry() == 67192 then 
	creatures:Despawn(1,0)
end
end
end

function GUN.VAR.THARONJA_ADDSPIRIT(pUnit,Event)
local player = pUnit:GetRandomPlayer(0)
if player then
if player:IsDead() == false then
pUnit:SpawnCreature(14513,player:GetX() , player:GetY(), player:GetZ(),player:GetO(), 14,320000)
end
end
pUnit:RegisterEvent("GUN.VAR.THARONJA_ADDSPIRIT", 22000, 1)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 14513 then
	if creatures:HasAura(65686) or creatures:HasAura(65684) == false then
		  if math.random(1,2) == 1 then
creatures:CastSpell(65686)
  elseif math.random(1,2) == 2 then
creatures:CastSpell(65684)
end
end
end
end
end

function GUN.VAR.THARONJA_DEFILE(pUnit,Event)
local player = pUnit:GetRandomPlayer(0)
if player then
if player:IsDead() == false then
pUnit:SpawnCreature(67192,player:GetX() , player:GetY(), player:GetZ(),player:GetO(), 35,20000)
end
end
end




function GUN.VAR.THARONJA_LEAVE(pUnit,Event)
pUnit:SetScale(1)
pUnit:DeMorph()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(9617)
pUnit:Despawn(2000,4000)
pUnit:GetGameObjectNearestCoords(1651.09, 743.78, 142.78, 192568):SetByte(GAMEOBJECT_BYTES_1,0,0)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  players:RemoveAura(65684)
  players:RemoveAura(65686)
  players:RemoveAura(9617)
   players:RemoveAura(47740)
     players:SetPhase(1)
end
end
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 14513 or creatures:GetEntry() == 67192 then 
	creatures:Despawn(1,0)
end
end
end


function GUN.VAR.THARONJA_SLAY(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  if players:IsDead() == true then
  players:RemoveAura(65684)
  players:RemoveAura(65686)
end
end
end
    if math.random(1,2) == 1 then
    pUnit:SendChatMessage(14,0,"As Tharon'ja predicted!")
pUnit:PlaySoundToSet(13863)
  elseif math.random(1,2) == 2 then
      pUnit:SendChatMessage(14,0,"As it was written!")
pUnit:PlaySoundToSet(13864)
end
end

RegisterUnitEvent(26632, 1, "GUN.VAR.THARONJA_COMBAT")
RegisterUnitEvent(26632, 4, "GUN.VAR.THARONJA_DEAD")
RegisterUnitEvent(26632, 2, "GUN.VAR.THARONJA_LEAVE")
RegisterUnitEvent(26632, 3, "GUN.VAR.THARONJA_SLAY")


function GUN.VAR.LightOrb_Check(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 3.5 then
  if players:IsDead() == false then
    if players:IsInCombat() == true then
  if players:IsInPhase(32) == true then
  if players:HasAura(65686) == true then
  players:CastSpell(67243)
  pUnit:Despawn(1000,2000)
  elseif players:HasAura(65686) == false then
  pUnit:Strike(players,1,5679,50,75,1)
  pUnit:Despawn(1000,2000)
end
end
end
end
end
end
end

function GUN.VAR.DarkOrb_Check(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 3.5 then
  if players:IsDead() == false then
  if players:IsInCombat() == true then
  if players:IsInPhase(32) == true then
  if players:HasAura(65684) == true then
  players:CastSpell(67243)
  pUnit:Despawn(1000,2000)
  else
  pUnit:Strike(players,1,5679,50,75,1)
  pUnit:Despawn(1000,2000)
end
end
end
end
end
end
end

function GUN.VAR.Defile_Check(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 6 then
  if players:IsDead() == false then
  if players:IsInPhase(1) == true then
 pUnit:Strike(players,1,39376,280,320,1)
  end
  end
  end
  end
  end

  
  function GUN.VAR.THARONJA_SPAWN(pUnit,Event)
  pUnit:SetScale(1)
pUnit:DeMorph()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(9617)
    for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 14513 or creatures:GetEntry() == 67192 then 
	creatures:Despawn(1,0)
  end
  end
  end
  
  RegisterUnitEvent(26632, 18, "GUN.VAR.THARONJA_SPAWN")
  
function GUN.VAR.Defile_spawn(pUnit,Event)
	pUnit:RegisterEvent("GUN.VAR.Defile_Check", 1000, 0)
	pUnit:SetPhase(1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end


RegisterUnitEvent(67192, 18, "GUN.VAR.Defile_spawn")

function GUN.VAR.LightOrb_spawn(pUnit,Event)
	pUnit:RegisterEvent("GUN.VAR.LightOrb_Check", 500, 0)
	pUnit:SetPhase(32)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end


RegisterUnitEvent(684924, 18, "GUN.VAR.LightOrb_spawn")




function GUN.VAR.HatefulSpirit_spawn(pUnit,Event)
	pUnit:SetPhase(32)
	pUnit:RegisterEvent("GUN.VAR.GIVEGHOSTSTHINGIES", 1000, 1)
end

function GUN.VAR.GIVEGHOSTSTHINGIES(pUnit,Event)
if pUnit:HasAura(65686) or pUnit:HasAura(65684) == false then
	  if math.random(1,2) == 1 then
pUnit:CastSpell(65686)
  elseif math.random(1,2) == 2 then
pUnit:CastSpell(65684)
end
end
end


RegisterUnitEvent(14513, 18, "GUN.VAR.HatefulSpirit_spawn")


function GUN.VAR.WHITEPORTAL_TICK(pUnit,Event)
	local tbl = pUnit:GetInRangeUnits()
	if tbl then
for place,creatures in pairs(tbl) do 
	if creatures:GetEntry() == 14513 then 
	if pUnit:GetDistanceYards(creatures) < 8 then
	if creatures:HasAura(65684) == true then
	if creatures:GetHealthPct() < 10 then
	creatures:Despawn(1,0)
end
end
end
end
end
end
end


function GUN.VAR.DARKPORTAL_TICK(pUnit,Event)
	local tbl = pUnit:GetInRangeUnits()
	if tbl then
		for place,creatures in pairs(tbl) do
			if creatures:GetEntry() == 14513 then 
				if pUnit:GetDistanceYards(creatures) < 8 then
					if creatures:HasAura(65686) == true then
						if creatures:GetHealthPct() < 10 then
							creatures:Despawn(1,0)
						end
					end
				end
			end
		end
	end
end

function GUN.VAR.UNIT_STOP_CHANNEL(pUnit,Event)
pUnit:StopChannel()
end

function GUN.VAR.DARKPORTAL_spawn(pUnit,Event)
	pUnit:RegisterEvent("GUN.VAR.DARKPORTAL_TICK", 500, 0)
	pUnit:SetPhase(32)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end


RegisterUnitEvent(67191, 18, "GUN.VAR.DARKPORTAL_spawn")


function GUN.VAR.WHITEPORTAL_spawn(pUnit,Event)
	pUnit:RegisterEvent("GUN.VAR.WHITEPORTAL_TICK", 500, 0)
	pUnit:SetPhase(32)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end


RegisterUnitEvent(67190, 18, "GUN.VAR.WHITEPORTAL_spawn")

function GUN.VAR.DarkOrb_spawn(pUnit,Event)
	pUnit:RegisterEvent("GUN.VAR.DarkOrb_Check", 500, 0)
	pUnit:SetPhase(32)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end


RegisterUnitEvent(684923, 18, "GUN.VAR.DarkOrb_spawn")



--Third Boss Trash --

--Third Boss--
--[[ COSMETIC VISUALS
45212 GIGANTIC AOE SLIME SPILL, GROUND
70876 == caster visual
]]


function GUN.VAR.Sladran_spawn(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GUN[id] = GUN[id] or {VAR={}}
	GUN[id].VAR.Sladran = pUnit
	GUN[id].VAR.Sladran:Unroot()
	GUN[id].VAR.Sladran:StopChannel()
	GUN[id].VAR.Sladran:AIDisableCombat(false)
end

RegisterUnitEvent(29304, 18, "GUN.VAR.Sladran_spawn")


function GUN.VAR.SLADRAN_MOVETO_ADDS(pUnit,Event)
pUnit:MoveTo(1775.04,631.20,124.44,4.26)
end

RegisterUnitEvent(444797, 18, "GUN.VAR.SLADRAN_MOVETO_ADDS")
RegisterUnitEvent(29713, 18, "GUN.VAR.SLADRAN_MOVETO_ADDS")


function GUN.VAR.PhaseTwo_Sladran(pUnit,Event)
pUnit:RemoveEvents()
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GUN[id] = GUN[id] or {VAR={}}
GUN[id].VAR.SpawnOne = pUnit:SpawnCreature(444797, 1784.66, 647.22, 124.46, 4.0, 14, 0)
GUN[id].VAR.SpawnTwo = pUnit:SpawnCreature(444797, 1765.04, 647.45, 124.46, 5.099, 14, 0)
GUN[id].VAR.SpawnThree = pUnit:SpawnCreature(444797, 1774.80, 605.14, 124.47, 1.42, 14, 0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
	pUnit:SendChatMessage(14,0,"Minionsss of the scale, heed my call!")
	pUnit:PlaySoundToSet(14444)
	pUnit:Root()
	pUnit:CastSpell(70876)
	pUnit:ChannelSpell(60303,pUnit)
	pUnit:TeleportCreature(1775.19,666.51,129.22)
	pUnit:AIDisableCombat(true)
	GUN[id].VAR.SpawnOne:MoveTo(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO())
	GUN[id].VAR.SpawnTwo:MoveTo(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO())
	GUN[id].VAR.SpawnThree:MoveTo(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO())
	pUnit:RegisterEvent("GUN.VAR.GASVISUALS", 1200, 1)
	pUnit:RegisterEvent("GUN.VAR.ORIENTATION_FIX", 1000, 1)
	pUnit:RegisterEvent("GUN.VAR.SPAWNSLIMEPOOL", 3500, 1)
	pUnit:RegisterEvent("GUN.VAR.SPAWNCONSTRICTORS", 10000, 0)
	pUnit:RegisterEvent("GUN.VAR.PHASEOVER", 1000, 0)
	pUnit:RegisterEvent("GUN.VAR.SLADRAN_CHECKING_FOR_PLAYERS", 100, 0)	
end


function GUN.VAR.PHASEOVER(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GUN[id] = GUN[id] or {VAR={}}
if GUN[id].VAR.SpawnOne:IsDead() and GUN[id].VAR.SpawnTwo:IsDead() and GUN[id].VAR.SpawnThree:IsDead() == true then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"A thousssand fangs gonna rend your flesh!")
	pUnit:PlaySoundToSet(14445)
		GUN[id].VAR.Sladran:Unroot()
	GUN[id].VAR.Sladran:StopChannel()
	GUN[id].VAR.Sladran:RemoveAura(70876)
	GUN[id].VAR.Sladran:AIDisableCombat(false)
	pUnit:RegisterEvent("GUN.VAR.PhaseTwo_Sladran", 32000, 0)
		pUnit:RegisterEvent("GUN.VAR.POISONSPITVOLLEY", 10000, 0)
		pUnit:RegisterEvent("GUN.VAR.SLADRAN_BITE", 6000, 0)
	for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 323667 then
	creatures:Despawn(1,0)
end
end
end
end

function GUN.VAR.ORIENTATION_FIX(pUnit,Event)
pUnit:SetFacing(4.67)
end

function GUN.VAR.GASVISUALS(pUnit,Event)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 32366 then 
	 creatures:FullCastSpell(62415)
end
end
end

function GUN.VAR.SPAWNSLIMEPOOL(pUnit,Event)
pUnit:SpawnCreature(323667, 1775.11, 631.56, 124.43, 4.71, 35, 0)
end

function GUN.VAR.SPAWNCONSTRICTORS(pUnit,Event)
if math.random(1,6) <= 1 then
pUnit:SpawnCreature(29713, 1788.82, 642.99, 124.47, 3.7, 14, 0)
elseif math.random(1,6) <= 2 then
pUnit:SpawnCreature(29713, 1760.57, 642.08, 124.47, 5.6, 14, 0)
elseif math.random(1,6) <= 3 then
pUnit:SpawnCreature(29713, 1759.32, 626.32, 124.47, 0.11, 14, 0)
elseif math.random(1,6) <= 4 then
pUnit:SpawnCreature(29713, 1766.13, 610.46, 124.47, 0.46, 14, 0)
elseif math.random(1,6) <= 5 then
pUnit:SpawnCreature(29713, 1782.72, 610.68, 124.47,2.15, 14, 0)
elseif math.random(1,6) <= 6 then
pUnit:SpawnCreature(29713, 1788.07, 623.03, 124.47,2.61, 14, 0)
end
end

function GUN.VAR.poisongas_spawn(pUnit,Event)
	pUnit:RegisterEvent("GUN.VAR.PoisonGas_Damage", 1000, 0)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(323666, 18, "GUN.VAR.poisongas_spawn")


function GUN.VAR.WGA_spawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:SetScale(2.2)
	pUnit:SetModel(11686)
end

RegisterUnitEvent(32366, 18, "GUN.VAR.WGA_spawn")

function GUN.VAR.PoisonGas_Damage(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GUN[id] = GUN[id] or {VAR={}}
if GUN[id].VAR.Sladran   then
if GUN[id].VAR.Sladran:IsInCombat() == true then
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 7 then
GUN[id].VAR.Sladran:Strike(players,1,69508,800,1000,2)
end
end
end
end
end


function GUN.VAR.Slimepool_spawn(pUnit,Event)
pUnit:CastSpell(45212)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("GUN.VAR.Slimepool_Damage", 1000, 0)
end

RegisterUnitEvent(323667, 18, "GUN.VAR.Slimepool_spawn")


function GUN.VAR.Slimepool_Damage(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GUN[id] = GUN[id] or {VAR={}}
	pUnit:CastSpell(45212)
if GUN[id].VAR.Sladran   then
if GUN[id].VAR.Sladran:IsInCombat() == true then
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 15 then
GUN[id].VAR.Sladran:Strike(players,1,69508,240,260,2)
end
end
end
end
end

function GUN.VAR.SLADRAN_COMBAT(pUnit,Event)
	pUnit:SendChatMessage(14,0,"Drakkari gonna kill anybody who tressspasss on these landsss!")
	pUnit:PlaySoundToSet(14443)
	pUnit:RegisterEvent("GUN.VAR.PhaseTwo_Sladran", 30000, 0)
	pUnit:RegisterEvent("GUN.VAR.POISONSPITVOLLEY", 10000, 0)
	pUnit:RegisterEvent("GUN.VAR.SLADRAN_BITE", 6000, 0)
	pUnit:GetGameObjectNearestCoords(1724.37, 633.27, 129.19, 193208):SetByte(GAMEOBJECT_BYTES_1,0,1)
end


function GUN.VAR.SLADRAN_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Despawn(2000,5000)
pUnit:GetGameObjectNearestCoords(1724.37, 633.27, 129.19, 193208):SetByte(GAMEOBJECT_BYTES_1,0,0)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 29713 or creatures:GetEntry() == 323667 or creatures:GetEntry() == 444797  then 
	creatures:Despawn(1,0)
		end
	end
end

function GUN.VAR.SLADRAN_DEAD(pUnit,Event)
pUnit:RemoveEvents()
	pUnit:SendChatMessage(14,0,"I sssee now... Ssscourge wasss not... our greatessst enemy...")
	pUnit:PlaySoundToSet(14449)
	pUnit:SendChatMessage(42,0,"The Inner Room has shifted.")
	pUnit:GetGameObjectNearestCoords(1724.37, 633.27, 129.19, 193208):Despawn(1,0)
pUnit:GetGameObjectNearestCoords(1775.34, 744.19, 119.43, 192564):SetByte(GAMEOBJECT_BYTES_1,0,1)
pUnit:GetGameObjectNearestCoords(1775.34, 744.19, 119.43, 192565):SetByte(GAMEOBJECT_BYTES_1,0,1)
pUnit:GetGameObjectNearestCoords(1775.34, 744.19, 119.43, 192566):SetByte(GAMEOBJECT_BYTES_1,0,1)
pUnit:GetGameObjectNearestCoords(1775.34, 744.19, 119.43, 192567):SetByte(GAMEOBJECT_BYTES_1,0,1)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  players:CastSpell(36455)
    end
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 29713 or creatures:GetEntry() == 323667 or creatures:GetEntry() == 444797  then 
	creatures:Despawn(1,0)
		end
	end
			pUnit:GetGameObjectNearestCoords(1696.89, 743.35, 142.77, 192568):SetByte(GAMEOBJECT_BYTES_1,0,0)
pUnit:GetGameObjectNearestCoords(1682.49, 806.80, 91.81, 192569):SetByte(GAMEOBJECT_BYTES_1,0,0) -- grate
pUnit:GetGameObjectNearestCoords(1696.89, 743.35, 142.77, 192520):SetByte(GAMEOBJECT_BYTES_1,0,0)
pUnit:GetGameObjectNearestCoords(1752.46,742.49, 118.98, 3267530):Despawn(1000,0)
end




function GUN.VAR.POISONSPITVOLLEY(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 40 then
		if players:IsDead() == false then
		pUnit:CastSpellOnTarget(17158,players)
			end
		end
	end
end


function GUN.VAR.SLADRAN_BITE(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank   then
		if pUnit:GetDistanceYards(tank) < 10 then
		if tank:HasAura(48287) == false then
			pUnit:CastSpellOnTarget(48287,tank)
end
end
end
end



function GUN.VAR.SLADRAN_CHECKING_FOR_PLAYERS(pUnit)
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
			if creatures:GetEntry() == 29713 or creatures:GetEntry() == 323667 or creatures:GetEntry() == 444797  then 
				creatures:Despawn(1,0)
			end
		end
		pUnit:Despawn(2000,5000)
	end
end

RegisterUnitEvent(29304, 1, "GUN.VAR.SLADRAN_COMBAT")
RegisterUnitEvent(29304, 4, "GUN.VAR.SLADRAN_DEAD")
RegisterUnitEvent(29304, 2, "GUN.VAR.SLADRAN_LEAVE")


--[[GALDRAH

14430 GD_Galdarah_Aggro.wav 

14431 GD_Galdarah_Transform01.wav CAT PHASE(LYNX FORM) 42607

14432 GD_Galdarah_Transform02.wav SNAKE PHASE(setscale 1.3)(EAGLE) 42606

14433 GD_Galdarah_SummonRhino01.wav Adds

14434 GD_Galdarah_SummonRhino02.wav Adds

14435 GD_Galdarah_SummonRhino03.wav RHINO PHASE(BEAR) 42594

14436 GD_Galdarah_Slay01.wav 

14437 GD_Galdarah_Slay02.wav -- final phase 25634 MORPH

14438 GD_Galdarah_Slay03.wav 

14439 GD_Galdarah_Death.wav ]]



function GUN.VAR.GALDRAH_EVENTS(pUnit,Event)
if Event == 1 then
	pUnit:SendChatMessage(14,0,"I'm gonna spill your guts, mon!")
	pUnit:PlaySoundToSet(14430)
	pUnit:RegisterEvent("GUN.VAR.RHINO_PHASE", 2000, 0)
	pUnit:RegisterEvent("GUN.VAR.GRIEVOUS_SLASH", 7000, 0)
	pUnit:RegisterEvent("GUN.VAR.DRAKKARI_ADDS", 17000, 0)
		local object = pUnit:GetGameObjectNearestCoords(1947.5, 813.5, 135.2, 166666)
	if object then
		object:SetByte(0x0006+0x000B,0,1)
		end
	elseif Event == 2 then
	pUnit:RemoveEvents()
pUnit:DeMorph()
pUnit:Unroot()
pUnit:EquipWeapons(33478,0,0)
 pUnit:AIDisableCombat(false) 
--pUnit:GetGameObjectNearestCoords(1891.38, 745.04, 136.14, 3267531):SetPhase(2)
pUnit:Despawn(2000,5000)
pUnit:RemoveAura(41337)
pUnit:RemoveAura(42607) -- cat
pUnit:RemoveAura(42594) -- rhino
pUnit:RemoveAura(42606) -- snake
pUnit:SetScale(1.1)
 for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
if creatures:GetEntry() == 39967 or creatures:GetEntry() == 249254 then
creatures:Despawn(1,0)
end
end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
		players:Unroot()
	players:SetPlayerLock(0)
end
end
		local object = pUnit:GetGameObjectNearestCoords(1947.5, 813.5, 135.2, 166666)
	if object then
		object:SetByte(0x0006+0x000B,0,0)
		end
	elseif Event == 3 then
	if math.random(1,2) <= 1 then
	pUnit:SendChatMessage(14,0,"What a rush!")
	pUnit:PlaySoundToSet(14436)
elseif math.random(1,2) <= 2 then
	pUnit:SendChatMessage(14,0,"I told ya so!")
	pUnit:PlaySoundToSet(14438)
end
	local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	if players:IsDead() == true then
			players:Unroot()
	players:SetPlayerLock(0)
end
end
end
	elseif Event == 4 then
	pUnit:RemoveEvents()
--pUnit:SetScale(1.1)
--pUnit:DeMorph()
pUnit:EquipWeapons(33478,0,0)
pUnit:RemoveAura(42607) -- cat
pUnit:RemoveAura(42594) -- rhino
pUnit:RemoveAura(42606) -- snake
	pUnit:SendChatMessage(14,0,"Even the mighty... can fall.")
	pUnit:PlaySoundToSet(14439)
	--pUnit:GetGameObjectNearestCoords(1891.38, 745.04, 136.14, 3267531):SetPhase(2)
			local object = pUnit:GetGameObjectNearestCoords(1947.5, 813.5, 135.2, 166666)
	if object then
		object:SetByte(0x0006+0x000B,0,0)
		end
					local objectx = pUnit:GetGameObjectNearestCoords(1947.5, 813.5, 135.2, 193208)
	if objectx then
		objectx:SetByte(0x0006+0x000B,0,0)
		end
	--pUnit:GetGameObjectNearestCoords(1947.5, 813.5, 135.2, 193208):SetByte(GAMEOBJECT_BYTES_1,0,0)
	--pUnit:GetGameObjectNearestCoords(1947.5, 813.5, 135.2, 166666):SetByte(GAMEOBJECT_BYTES_1,0,0)
	local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
		players:Unroot()
	players:SetPlayerLock(0)
		if players:HasAchievement(484) == false then
					players:AddAchievement(484)
					end
	end
	end
end
	end


function GUN.VAR.GRIEVOUS_SLASH(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player   then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 20 then
pUnit:CastSpellOnTarget(48286,player)
end
end
end
end

function GUN.VAR.DRAKKARI_ADDS(pUnit,Event)
pUnit:SpawnCreature(39967, 1939.78, 705.85, 135.10, 2.19, 14, 0)
pUnit:SpawnCreature(39967, 1939.78, 705.85, 135.10, 2.19, 14, 0)
pUnit:SpawnCreature(39967, 1933.77, 778.48, 135.01, 3.97, 14, 0)
pUnit:SpawnCreature(39967, 1933.77, 778.48, 135.01, 3.97, 14, 0)
if math.random(1,2) <= 1 then
	pUnit:SendChatMessage(14,0,"Gut them! Impale them!")
	pUnit:PlaySoundToSet(14433)
elseif math.random(1,2) <= 2 then
	pUnit:SendChatMessage(14,0,"KILL THEM ALL!")
	pUnit:PlaySoundToSet(14434)
end
end

function GUN.VAR.RHINO_PHASE(pUnit,Event)
if pUnit:GetHealthPct() < 80 then
pUnit:RemoveEvents()
pUnit:EquipWeapons(0,0,0)
pUnit:CastSpell(42594) -- Form
pUnit:SendChatMessage(14,0,"Say hello to my BIG friend!")
	pUnit:PlaySoundToSet(14435)
	pUnit:RegisterEvent("GUN.VAR.CAT_PHASE", 2000, 0)
	pUnit:RegisterEvent("GUN.VAR.RHINO_IMPALE_SETUP", 15000, 1)
	pUnit:RegisterEvent("GUN.VAR.RHINO_ROAR", 8000, 1)
end
end

function GUN.VAR.RHINO_ROAR(pUnit,Event)
pUnit:SendChatMessage(42,0,"Gal'darah begins to cast \124cff71d5ff\124Hspell:42708\124h[Staggering Roar]\124h\124r")
pUnit:Root()
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetOrientation(pUnit:GetO())
pUnit:FullCastSpell(42708)
pUnit:RegisterEvent("GUN.VAR.RHINO_ROAR_CAST", 1800, 1)
end

function GUN.VAR.RHINO_ROAR_CAST(pUnit,Event)
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

function GUN.VAR.RHINO_IMPALE_SETUP(pUnit,Event)
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
pUnit:RegisterEvent("GUN.VAR.RHINO_IMPALE", 4000, 1)
pUnit:RegisterEvent("GUN.VAR.ROOT_PLAYERS", 2800, 1)
end

function GUN.VAR.ROOT_PLAYERS(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	players:Root()
	players:SetPlayerLock(1)
end
end
end

function GUN.VAR.RHINO_IMPALE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GUN[id] = GUN[id] or {VAR={}}
GUN[id].VAR.Impaletarget = pUnit:GetRandomPlayer(0)
if pUnit:GetDistanceYards(GUN[id].VAR.Impaletarget) < 30 then
if GUN[id].VAR.Impaletarget:IsDead() == false then
pUnit:SendChatMessageToPlayer(42,0,"Gal'darah begins to charge at YOU!", GUN[id].VAR.Impaletarget)
local name = GUN[id].VAR.Impaletarget:GetName()
pUnit:SendChatMessage(42,0,"Gal'darah begins to fixate on "..name.."")
pUnit:SetOrientation(GUN[id].VAR.Impaletarget:GetO())
end
end
pUnit:RegisterEvent("GUN.VAR.RHINO_IMPALE_CHARGE", 2000, 1)
end



function GUN.VAR.RHINO_IMPALE_CHARGE(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GUN[id] = GUN[id] or {VAR={}}
	pUnit:Unroot()
	pUnit:SetOrientation(GUN[id].VAR.Impaletarget:GetO())
	pUnit:ModifyRunSpeed(18)
	pUnit:ModifyWalkSpeed(18)
	pUnit:MoveTo(GUN[id].VAR.Impaletarget:GetX(),GUN[id].VAR.Impaletarget:GetY(),GUN[id].VAR.Impaletarget:GetZ(),GUN[id].VAR.Impaletarget:GetO())
	pUnit:RegisterEvent("GUN.VAR.RHINO_STUNNED", 4000, 1)
	pUnit:RegisterEvent("GUN.VAR.UNROOT_PLAYERS", 200, 1)
	pUnit:RegisterEvent("GUN.VAR.RHINO_CRASH", 1500, 0)
end


function GUN.VAR.RHINO_CRASH(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 4 then
	if players:IsDead() == false then
	pUnit:CastSpellOnTarget(66770,players)
	end
	end
	end
end

function GUN.VAR.UNROOT_PLAYERS(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	players:Unroot()
	players:SetPlayerLock(0)
end
end
end

function GUN.VAR.RHINO_STUNNED(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Emote(64,5000)
pUnit:SendChatMessage(42,0,"Gal'darah is stunned!")
pUnit:RegisterEvent("GUN.VAR.RHINO_UNSTUNNED", 5100, 1)
end

function GUN.VAR.RHINO_UNSTUNNED(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GUN[id] = GUN[id] or {VAR={}}
pUnit:AIDisableCombat(false)
	pUnit:ModifyRunSpeed(14)
	pUnit:ModifyWalkSpeed(2.5)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
GUN[id].VAR.Impaletarget = nil
pUnit:RegisterEvent("GUN.VAR.CAT_PHASE", 2000, 0)
pUnit:RegisterEvent("GUN.VAR.RHINO_IMPALE_SETUP", 25000, 0)
pUnit:RegisterEvent("GUN.VAR.RHINO_ROAR", 10000, 0)
end

function GUN.VAR.CAT_PHASE(pUnit,Event)
if pUnit:GetHealthPct() < 60 then
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(42594)
pUnit:CastSpell(42607) -- Form
pUnit:SendChatMessage(14,0,"Ain't gonna be nottin' left after this!")
	pUnit:PlaySoundToSet(14431)
	pUnit:RegisterEvent("GUN.VAR.SNAKE_PHASE", 2000, 0)
	pUnit:RegisterEvent("GUN.VAR.CAT_CHARGE", 6000, 1)
	pUnit:RegisterEvent("GUN.VAR.CAT_RAKE", 4000, 0)
	pUnit:RegisterEvent("GUN.VAR.CAT_FRENZY", 12000, 0)
end
end

function GUN.VAR.CAT_CHARGE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("GUN.VAR.CAT_CHARGE_MULTI", 1000, 6)
pUnit:RegisterEvent("GUN.VAR.SNAKE_PHASE", 1000, 0)
pUnit:RegisterEvent("GUN.VAR.CAT_RAKE", 10000, 0)
pUnit:RegisterEvent("GUN.VAR.CAT_CHARGE", 20000, 1) -- 14 seconds
pUnit:RegisterEvent("GUN.VAR.CAT_FRENZY", 18000, 0) -- 12 seconds
end

function GUN.VAR.CAT_FRENZY(pUnit,Event)
pUnit:CastSpell(53361)
end

function GUN.VAR.CAT_CHARGE_MULTI(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player   then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 50 then
pUnit:CastSpellOnTarget(51492,player)
if player:HasAura(27638) == false then
pUnit:CastSpellOnTarget(27638,player)
end
end
end
end
end

	function GUN.VAR.GALDRAH_Leash(pUnit,Event)
  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 29306 then 
if pUnit:GetDistanceYards(creature) < 4.5 and creature:IsAlive() then
creature:Despawn(1000,10000)
end
	end
     	end
	end
			
			
function GUN.VAR.GALDRAH_Leasher(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
 pUnit:RegisterEvent("GUN.VAR.GALDRAH_Leash", 1000, 0)
	end
	
	
		RegisterUnitEvent(445622,18, "GUN.VAR.GALDRAH_Leasher")

function GUN.VAR.CAT_RAKE(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank then
	if tank:HasAura(27638) == false then
		if pUnit:GetDistanceYards(tank) < 20 then
		pUnit:CastSpellOnTarget(27638,tank)
		end
end
end
end


function GUN.VAR.SNAKE_PHASE(pUnit,Event)
if pUnit:GetHealthPct() < 40 then
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(42607)
pUnit:CastSpell(42606) -- Form
pUnit:SetScale(1.3)
pUnit:SendChatMessage(14,0,"You wanna see power? I'm gonna show you power!")
	pUnit:PlaySoundToSet(14432)
	pUnit:RegisterEvent("GUN.VAR.BLOODGOD_PHASE", 2000, 0)
	pUnit:RegisterEvent("GUN.VAR.SNAKE_POISONSHIELD", 3000, 0)
	pUnit:RegisterEvent("GUN.VAR.SNAKE_HEALINGREDUC", 10000, 1)
	pUnit:RegisterEvent("GUN.VAR.SNAKE_PARALYZE", 32000, 0)
	pUnit:RegisterEvent("GUN.VAR.SNAKE_BIND", 24000, 0)
end
end

function GUN.VAR.SNAKE_POISONSHIELD(pUnit,Event)
if pUnit:HasAura(34355) == false then
pUnit:CastSpell(34355)
end
end

function GUN.VAR.SNAKE_HEALINGREDUC(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	if players:IsDead() == false then
	pUnit:CastSpellOnTarget(54121,players)
end
end
end
pUnit:RegisterEvent("GUN.VAR.SNAKE_HEALINGREDUC", 35000, 1)
end

function GUN.VAR.SNAKE_PARALYZE(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	if players:IsDead() == false then
	pUnit:CastSpellOnTarget(3609,players)
end
end
end
end

function GUN.VAR.SNAKE_BIND(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		local snakebind = pUnit:GetCreatureNearestCoords(plr:GetX(), plr:GetY(), plr:GetZ(), 249252)
		if snakebind then
			if plr:GetDistanceYards(snakebind) < 3 then
				-- Re-register?
			else
				pUnit:SendChatMessage(42,0, plr:GetName().." is constricted!")
				plr:Root()
				plr:SetScale(0.5)
				plr:SetPlayerLock(true)
				pUnit:SpawnCreature(249254, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 21, 120000)
			end
		else
			pUnit:SendChatMessage(42,0, plr:GetName().." is constricted!")
			plr:Root()
			plr:SetScale(0.5)
			plr:SetPlayerLock(true)
			pUnit:SpawnCreature(249254, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 21, 120000)
		end
	end
end


function GUN.VAR.SNAKEBINDSPAWNHANDLER(pUnit, Event)
	pUnit:RegisterEvent("GUN.VAR.SNAKEBINDSPAWNHANDLE", 1000, 0)
end

function GUN.VAR.SNAKEBINDSPAWNHANDLE(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if ((pUnit:GetHealthPct() < 5) or (not plr:IsAlive())) then
			pUnit:RemoveEvents()
			plr:Unroot()
			plr:SetScale(1)
			plr:SetPlayerLock(false)
			pUnit:Emote(387, 1000)
			pUnit:Despawn(100, 0)
		else
			pUnit:Strike(plr, 2, 70569, 140, 170, 1.2)
			pUnit:TeleportCreature(plr:GetX(),plr:GetY(),plr:GetZ())
		end
	end
end

RegisterUnitEvent(249254, 18, "GUN.VAR.SNAKEBINDSPAWNHANDLER")


function GUN.VAR.BLOODGOD_PHASE(pUnit,Event)
if pUnit:GetHealthPct() < 20 then
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:RemoveAura(42606)
pUnit:SetModel(40093)
pUnit:SetScale(4)
pUnit:CastSpell(41337)
pUnit:CastSpell(61613)
pUnit:SendChatMessage(14,0,"Who needs gods, when WE ARE GODS!")
	pUnit:PlaySoundToSet(14437)
	pUnit:RegisterEvent("GUN.VAR.BLOODGOD_ENRAGE_IN_FORTYFIVE", 1000, 1)
	pUnit:RegisterEvent("GUN.VAR.BLOODGOD_STRIKE", 2000, 0)
end
end


function GUN.VAR.BLOODGOD_ENRAGE_IN_FORTYFIVE(pUnit,Event)
pUnit:SendChatMessage(42,0,"\124cff71d5ff\124Hspell:35354\124h[Hand of Death]\124h\124r in 45 seconds.")
pUnit:RegisterEvent("GUN.VAR.BLOODGOD_ENRAGE_IN_TWENTYFIVE", 20000, 1)
end

function GUN.VAR.BLOODGOD_ENRAGE_IN_TWENTYFIVE(pUnit,Event)
pUnit:SendChatMessage(42,0,"\124cff71d5ff\124Hspell:35354\124h[Hand of Death]\124h\124r in 25 seconds.")
pUnit:RegisterEvent("GUN.VAR.BLOODGOD_ENRAGE_IN_TEN", 15000, 1)
end

function GUN.VAR.BLOODGOD_ENRAGE_IN_TEN(pUnit,Event)
pUnit:SendChatMessage(42,0,"\124cff71d5ff\124Hspell:35354\124h[Hand of Death]\124h\124r in 10 seconds.")
pUnit:RegisterEvent("GUN.VAR.BLOODGOD_ENRAGE_HIT", 10000, 1)
end


function GUN.VAR.BLOODGOD_ENRAGE_HIT(pUnit,Event)
pUnit:CastSpell(35354)
end


function GUN.VAR.BLOODGOD_STRIKE(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	if players:IsDead() == false then
	pUnit:CastSpellOnTarget(49762,players)
pUnit:Strike(players, 2, 70569, 250, 380, 1.2)
end
end
end
end








RegisterUnitEvent(29306, 1, "GUN.VAR.GALDRAH_EVENTS")
RegisterUnitEvent(29306, 4, "GUN.VAR.GALDRAH_EVENTS")
RegisterUnitEvent(29306, 2, "GUN.VAR.GALDRAH_EVENTS")
RegisterUnitEvent(29306, 3, "GUN.VAR.GALDRAH_EVENTS")


function GUN.VAR.Drakkari_MoveTo(pUnit,Event)
pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 29306 then 
	if creature:IsInCombat() == true then
	pUnit:MoveTo(creature:GetX(),creature:GetY(),creature:GetZ(),creature:GetO())
		end
	end
end
end

function GUN.VAR.Drakkari_Warrior_Spawn(pUnit,Event)
if math.random(1,4) <= 1 then
pUnit:EquipWeapons(45204,45204,0)
elseif math.random(1,4) <= 2 then
pUnit:EquipWeapons(45204,33326,0)
elseif math.random(1,4) <= 3 then
pUnit:EquipWeapons(45204,0,0)
elseif math.random(1,4) <= 4 then
pUnit:EquipWeapons(35618,0,0)
end
pUnit:RegisterEvent("GUN.VAR.Drakkari_MoveTo", 2000, 1)
end

RegisterUnitEvent(39967, 18, "GUN.VAR.Drakkari_Warrior_Spawn")


function GUN.VAR.GALDRAH_Spawn(pUnit,Event)
pUnit:EquipWeapons(33478,0,0)
pUnit:SetMaxPower(1000,1)
pUnit:SetPower(1000,1)	
pUnit:SetPowerType(1)	
pUnit:SetScale(1)
pUnit:SetModel(27061)
if pUnit:GetMapId() == 604 then
pUnit:Emote(0,1000)
end
end

function GUN.VAR.MOORABI_Spawn(pUnit,Event)
pUnit:SetMaxPower(100,3)
pUnit:SetPower(100,3)	
pUnit:SetPowerType(3)	
end

RegisterUnitEvent(29306, 18, "GUN.VAR.GALDRAH_Spawn")
RegisterUnitEvent(29305, 18, "GUN.VAR.MOORABI_Spawn")

