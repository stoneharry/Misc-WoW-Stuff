
BFD = {}
BFD.VAR = {} 

local OBJECT_END = 0x0006
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 -- Size: 1, Type: BYTES, Flags: PUBLIC
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit

--[[ 14043 AK_HeraldVolazj_Aggro.wav 

14044 AK_HeraldVolazj_PartyPhase01.wav 

14045 AK_HeraldVolazj_Slay01.wav 

14046 AK_HeraldVolazj_Slay02.wav 

14047 AK_HeraldVolazj_Slay03.wav 

14048 AK_HeraldVolazj_Death01.wav 

14049 AK_HeraldVolazj_Death02.wav 
]]

--[[ Lady Darkscale visuals: 
38464 - She becomes immune to all types of damage and adds come from the sides. Knocks back nearby units
]]
 
function BFD.VAR.COM_CRUSH(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 8 then
			pUnit:CastSpellOnTarget(50234, tank)
		end
	end
end
 
function BFD.VAR.ToxicSlimeDummy(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:SetFaction(14)
	pUnit:FullCastSpell(37615)
end

RegisterUnitEvent(6890, 18, "BFD.VAR.ToxicSlimeDummy")


function BFD.VAR.BOULDERSPAWN(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:CastSpell(55766)
	pUnit:RegisterEvent("BFD.VAR.BOULDERROLE",500,0) 
	pUnit:SetScale(2.5)
end

RegisterUnitEvent(6814, 18, "BFD.VAR.BOULDERSPAWN")
  
function BFD.VAR.BOULDERROLE(pUnit,Event)
	pUnit:CastSpell(55766)
		if pUnit:IsInPhase(1) == true then
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 3.7 then
			if players:IsDead() == false then
				pUnit:CastSpellOnTarget(54899,players)
				pUnit:Strike(players, 2, 70569, 200, 400, 2)
			end
		end
	end
end
end


function BFD.VAR.STEAMSPAWN(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:CastSpell(51920)
	pUnit:RegisterEvent("BFD.VAR.STEAM",100,1) 
end

RegisterUnitEvent(6812, 18, "BFD.VAR.STEAMSPAWN")

function BFD.VAR.Blackholegrowx1damage(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 3.5 then
			if players:IsDead() == false then
				pUnit:CastSpell(37826)
				pUnit:Strike(players,1,37826,130,160,2)
			end
		end
	end
end


function BFD.VAR.STEAM(pUnit,Event)
	pUnit:CastSpell(51920)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 3.5 then
			if players:IsDead() == false then
				pUnit:CastSpellOnTarget(56777,players)
				pUnit:CastSpellOnTarget(10689,players)
				pUnit:Strike(players,1,56777,249,350,2)
			end
		end
	end
end
  
function BFD.VAR.Blackholegrowx2damage(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 6 then
			if players:IsDead() == false then
				pUnit:CastSpell(37826)
				pUnit:Strike(players,1,37826,130,160,2)
			end
		end
	end
end

function BFD.VAR.Blackholegrowx3damage(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 10 then
			if players:IsDead() == false then
				pUnit:CastSpell(37826)
				pUnit:Strike(players,1,37826,130,160,2)
			end
		end
	end
end

function BFD.VAR.Blackholegrowx4damage(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 15 then
			if players:IsDead() == false then
				pUnit:CastSpell(37826)
				pUnit:Strike(players,1,37826,130,160,2)
			end
		end
	end
end
  
function BFD.VAR.Blackhole(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("BFD.VAR.Blackholegrowx1damage",600,0) 
	pUnit:RegisterEvent("BFD.VAR.Blackholegrowx1",3000,1) 
end

function BFD.VAR.Blackholegrowx1(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SetScale(.2)
	pUnit:RegisterEvent("BFD.VAR.Blackholegrowx2damage",600,0) 
	pUnit:RegisterEvent("BFD.VAR.Blackholegrowx2",3000,1) 
end

function BFD.VAR.Blackholegrowx2(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SetScale(.3)
	pUnit:RegisterEvent("BFD.VAR.Blackholegrowx3damage",600,0) 
	pUnit:RegisterEvent("BFD.VAR.Blackholegrowx3",3000,1) 
end

function BFD.VAR.Blackholegrowx3(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SetScale(.4)
	pUnit:RegisterEvent("BFD.VAR.Blackholegrowx4damage",800,0) 
end

RegisterUnitEvent(6810, 18, "BFD.VAR.Blackhole")
RegisterUnitEvent(920060, 18, "BFD.VAR.Blackhole")
 
function BFD.VAR.COM_ENRAGESLOW(pUnit,Event)
	pUnit:CastSpell(42705)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BFD[id] = BFD[id] or {VAR={}}
	if BFD[id].VAR.EnrageStacks == nil then BFD[id].VAR.EnrageStacks = 0 end
	if BFD[id].VAR.EnrageTimes == nil then BFD[id].VAR.EnrageTimes = 0 end
	BFD[id].VAR.EnrageStacks = BFD[id].VAR.EnrageStacks + 1
	if BFD[id].VAR.EnrageStacks == 20 then -- First Enrage, gives achievement
		BFD[id].VAR.EnrageTimes = BFD[id].VAR.EnrageTimes + 1
		BFD[id].VAR.EnrageStacks = 0
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:RemoveAura(42705)
		pUnit:CastSpell(72143)
		pUnit:CastSpell(39082)
		pUnit:PlaySoundToSet(14044)
		pUnit:SendChatMessage(14,0,"Gul'kafh an'shel. Yoq'al shn ky ywaq nuul.")
	end
end
 
function BFD.VAR.COM_OnCombat(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BFD[id] = BFD[id] or {VAR={}}
	pUnit:PlaySoundToSet(14043)
	pUnit:SendChatMessage(14,0,"Shgla'yos plahf mh'naus.")
	pUnit:RegisterEvent("BFD.VAR.COM_SBH",7000,0)
	pUnit:RegisterEvent("BFD.VAR.COM_ENRAGESLOW", 4000,0)
	pUnit:RegisterEvent("BFD.VAR.COM_CRUSH", 13000,0)
	pUnit:RegisterEvent("BFD.VAR.COM_BOLT", 5000,0)
end

function BFD.VAR.COM_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RemoveAura(42705)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BFD[id] = BFD[id] or {VAR={}}
	BFD[id].VAR.EnrageStacks = 0
	BFD[id].VAR.EnrageTimes = 0
	pUnit:Despawn(1000,10000)
end

function BFD.VAR.COM_SBH(pUnit,Event)
	pUnit:CastSpell(37826)
	pUnit:SpawnCreature(6810, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 30000)
end

function BFD.VAR.COM_BOLT(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 30 then
			pUnit:CastSpellOnTarget(705,players)
		end
	end
end

function BFD.VAR.COM_OnSlay(pUnit,Event)
	if math.random(1,3) <= 1 then
		pUnit:PlaySoundToSet(14045)
		pUnit:SendChatMessage(14,0,"Ywaq puul skshgn: on'ma yeh'glu zuq.")
	elseif math.random(1,3) <= 2 then
		pUnit:PlaySoundToSet(14046)
		pUnit:SendChatMessage(14,0,"Ywaq ma phgwa'cul hnakf.")
	elseif math.random(1,3) <= 3 then
		pUnit:PlaySoundToSet(14047)
		pUnit:SendChatMessage(14,0,"Ywaq maq oou; ywaq maq ssaggh. Ywaq ma shg'fhn.")
	end
end

function BFD.VAR.COM_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:PlaySoundToSet(14048)
	pUnit:SendChatMessage(14,0,"Iilth vwah, uhn'agth fhssh za.")
	local object = pUnit:GetGameObjectNearestCoords(-617.65,195.22, -51.64, 146086)
	if object then
		object:Despawn(1000,0)
	end
	if id == nil then id = 1 end
	BFD[id] = BFD[id] or {VAR={}}
	if BFD[id].VAR.EnrageTimes <= 1 then
		local PlayersAllAround = pUnit:GetInRangePlayers()
		for a, players in pairs(PlayersAllAround) do
			if pUnit:GetDistanceYards(players) < 50 then
				if players:HasAchievement(1862) == false then
					players:AddAchievement(1862)
				end
			end
		end
	end
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BFD[id] = BFD[id] or {VAR={}}
	BFD[id].VAR.EnrageStacks = 0
	BFD[id].VAR.EnrageTimes = 0
end

RegisterUnitEvent(6809, 1, "BFD.VAR.COM_OnCombat")
RegisterUnitEvent(6809, 2, "BFD.VAR.COM_OnLeave")
RegisterUnitEvent(6809, 3, "BFD.VAR.COM_OnSlay")
RegisterUnitEvent(6809, 4, "BFD.VAR.COM_OnDead")

function BFD.VAR.DEFENDER_OnCombat(pUnit,Event)
	pUnit:RegisterEvent("BFD.VAR.DEFENDER_REFLECT", 6000,1)
	pUnit:RegisterEvent("BFD.VAR.DEFENDER_SLAM", 9000,0)
end

function BFD.VAR.DEFENDER_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

function BFD.VAR.DEFENDER_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
end

function BFD.VAR.DEFENDER_SLAM(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 8 then
			pUnit:CastSpellOnTarget(15655, tank)
		end
	end
end

function BFD.VAR.DEFENDER_REFLECT(pUnit,Event)
	if pUnit:HasAura(31554) == false then
		pUnit:FullCastSpell(31554)
		pUnit:RegisterEvent("BFD.VAR.DEFENDER_REFLECT", 13000,1)
	end
end


function BFD.VAR.SLAVEHAND_COMBAT(pUnit,Event)
			pUnit:SendChatMessage(16,0,"Blackfanthom Slavehandler beckons a nearby slave to fight.")
			for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 17963 then
	if pUnit:GetDistanceYards(creatures) < 8 then
	creatures:SetFaction(14)
local targetz = pUnit:GetPrimaryCombatTarget()
creatures:MoveTo(targetz:GetX(),targetz:GetY(),targetz:GetZ(),targetz:GetO())
		end
	end
end
end


function BFD.VAR.SLAVEHAND_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
end

function BFD.VAR.SLAVEHAND_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
end

function BFD.VAR.SLAVE_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SetFaction(190)
end

function BFD.VAR.SLAVE_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SetFaction(190)
end


function BFD.VAR.SORC_FROSTBOLT(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 15 then
pUnit:FullCastSpellOnTarget(12675, tank)
end
end
end

function BFD.VAR.SORC_COMBAT(pUnit,Event)
pUnit:RegisterEvent("BFD.VAR.SORC_FROSTBOLT", 4000,0)
pUnit:RegisterEvent("BFD.VAR.SORC_HEAL", 2100,0)
end


function BFD.VAR.SORC_HEAL(pUnit,Event)
if pUnit:IsCasting() == false then
local woundedfriend = nil
for k,v in pairs(pUnit: GetInRangeUnits() ) do
if v:GetEntry() == 17802 or v:GetEntry() == 17722 or v:GetEntry() == 17959 then
   woundedfriend = v
   break
   end
end
   if pUnit:GetDistanceYards(woundedfriend) < 25 then
  if  woundedfriend:GetHealthPct() < 50 then
  if woundedfriend:IsDead() == false then
  pUnit:Root()
  pUnit:FullCastSpellOnTarget(2060,woundedfriend)
  pUnit:RegisterEvent("BFD.VAR.BFDUNROOT_CASTER", 2600, 1)
  elseif pUnit:GetHealthPct() < 50 then
  pUnit:Root()
  pUnit:FullCastSpell(2060)
   pUnit:RegisterEvent("BFD.VAR.BFDUNROOT_CASTER", 2600, 1)
end
end
end
end
end

function BFD.VAR.BFDUNROOT_CASTER(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:Unroot()
end
end
 
function BFD.VAR.SORC_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
end

function BFD.VAR.SORC_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(17963, 2, "BFD.VAR.SLAVE_LEAVE")
RegisterUnitEvent(17963, 4, "BFD.VAR.SLAVE_DEAD")

RegisterUnitEvent(17722, 1, "BFD.VAR.SORC_COMBAT")
RegisterUnitEvent(17722, 2, "BFD.VAR.SORC_LEAVE")
RegisterUnitEvent(17722, 4, "BFD.VAR.SORC_DEAD")

RegisterUnitEvent(17959, 1, "BFD.VAR.SLAVEHAND_COMBAT")
RegisterUnitEvent(17959, 2, "BFD.VAR.SLAVEHAND_LEAVE")
RegisterUnitEvent(17959, 4, "BFD.VAR.SLAVEHAND_DEAD")


RegisterUnitEvent(17958, 1, "BFD.VAR.DEFENDER_OnCombat")
RegisterUnitEvent(17958, 2, "BFD.VAR.DEFENDER_OnLeave")
RegisterUnitEvent(17958, 4, "BFD.VAR.DEFENDER_OnDead")


function BFD.VAR.AKUMAI_DEVOUR(pUnit,Event)
	plr = pUnit:GetRandomPlayer(0)
	if pUnit:GetDistanceYards(plr) < 30 then
		if plr:IsDead() == false then
			if plr:GetHealthPct() < 11 then
				local name = plr:GetName()
				--pUnit:CastSpellOnTarget(28337,plr)
				pUnit:Emote(35,1200)
				pUnit:Kill(plr)
				plr:CastSpell(72313)
				plr:Heal(pUnit,38895, 1200)
				pUnit:CastSpell(55948)
				local PlayersAllAround = pUnit:GetInRangePlayers()
				for a, players in pairs(PlayersAllAround) do
					if pUnit:GetDistanceYards(players) < 30 then
						pUnit:SendChatMessageToPlayer(42,0,"Akumai Devours "..name.."", players)
					end
				end
			end
		end
	end
end


function BFD.VAR.AKUMAI_ENRAGED(pUnit,Event)
	if pUnit:GetHealthPct() < 15 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(28747)
		pUnit:RegisterEvent("BFD.VAR.AKUMAI_DEVOUR", 1000,0)
		pUnit:RegisterEvent("BFD.VAR.AKUMAI_STRIKE", 5000,0)
		pUnit:RegisterEvent("BFD.VAR.AKUMAI_ACIDBREATH", 12000,0)
		pUnit:RegisterEvent("BFD.VAR.AKUMAI_ACIDCLOUD", 7000,0)
		local PlayersAllAround = pUnit:GetInRangePlayers()
		for a, players in pairs(PlayersAllAround) do
			if pUnit:GetDistanceYards(players) < 30 then
				pUnit:SendChatMessageToPlayer(42,0,"Akumai goes into a frenzy!", players)
			end
		end
	end
end

function BFD.VAR.AKUMAI_COMBAT(pUnit,Event)
	pUnit:RegisterEvent("BFD.VAR.AKUMAI_DEVOUR", 1000,0)
	pUnit:RegisterEvent("BFD.VAR.AKUMAI_ENRAGED", 1000,0)
	pUnit:RegisterEvent("BFD.VAR.AKUMAI_STRIKE", 5000,0)
	pUnit:RegisterEvent("BFD.VAR.AKUMAI_ACIDBREATH", 12000,0)
	pUnit:RegisterEvent("BFD.VAR.AKUMAI_ACIDCLOUD", 7000,0)
end

function BFD.VAR.AKUMAI_STRIKE(pUnit,Event)
	local tank = pUnit:GetMainTank()
		if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:FullCastSpellOnTarget(58460, tank)
		end
	end
end


function BFD.VAR.AKUMAI_ACIDBREATH(pUnit,Event)
	pUnit:CastSpell(34268)
end

function BFD.VAR.AKUMAI_ACIDCLOUD(pUnit,Event)
	plr = pUnit:GetRandomPlayer(0)
	if pUnit:GetDistanceYards(plr) < 30 then
		if plr:IsDead() == false then
			pUnit:CastSpellOnTarget(53400,plr)
		end
	end
end

function BFD.VAR.AKUMAI_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SpawnGameObject(4800, -840.10,-474.25, -34.05, 1.78, 0, 100)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 70 and players:HasQuest(6800) then
				if (players:GetQuestObjectiveCompletion(6800, 0) == 0) then
					players:MarkQuestObjectiveAsComplete(6800, 0)
				end
			end
		end
	end

function BFD.VAR.AKUMAI_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Despawn(3000,4000)
end

function BFD.VAR.AKUMAI_SPAWN(pUnit,Event)
	--pUnit:CastSpell(35112)
end

RegisterUnitEvent(4829, 1, "BFD.VAR.AKUMAI_COMBAT")
RegisterUnitEvent(4829, 18, "BFD.VAR.AKUMAI_SPAWN")
RegisterUnitEvent(4829, 2, "BFD.VAR.AKUMAI_LEAVE")
RegisterUnitEvent(4829, 4, "BFD.VAR.AKUMAI_DEAD")

----------------------------------------------------------------------------------------------

-- 38497 cyclone water visual
-- 54399 water bubble - 200-300 damage every 3 seconds, slows
-- 9612 reduce change to hit - ink spay - 1 second cast
-- 48849 roar, instant, reduces size + damage
-- 52061 fear, only use on 1 person
-- 51920 cast instantly, for visual

function BFD.VAR.LADY_COMBAT(pUnit,Event)
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:PlaySoundToSet(11532)
		pUnit:SendChatMessage(14,0,"I'll split you from stem to stern!")
	elseif choice == 2 then
		pUnit:PlaySoundToSet(11534)
		pUnit:SendChatMessage(14,0,"I spit on you, surface filth!")
	elseif choice == 3 then
		pUnit:PlaySoundToSet(11535)
		pUnit:SendChatMessage(14,0,"Death to the outsiders!")
	end
	pUnit:RegisterEvent("BFD.VAR.LADY_PHASEONE", 2500, 0)
	pUnit:RegisterEvent("BFD.VAR.LaDY_WaterBubble", 10000, 0)
	pUnit:RegisterEvent("BFD.VAR.LADY_FEAR", 11000, 0)
	pUnit:RegisterEvent("BFD.VAR.REDUCERE", 6000, 0)
	pUnit:RegisterEvent("BFD.VAR.RoARLady", 20500, 0)
 end
 
function BFD.VAR.LaDY_WaterBubble(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:CastSpellOnTarget(54399, plr)
	end
end
 
function BFD.VAR.LADY_FEAR(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		plr:CancelSpell()
		plr:CastSpell(52061) -- fear
		plr:CastSpell(51920) -- visual
	end
end
 
function BFD.VAR.REDUCERE(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(9612, plr)
	end
end

function BFD.VAR.RoARLady(pUnit)
	pUnit:FullCastSpell(48849)
end

function BFD.VAR.LADY_LEAVE(pUnit,Event)
	pUnit:Despawn(4000,3000)
	pUnit:Unroot()
end

function BFD.VAR.LADY_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
end

function BFD.VAR.LADY_PHASEONE(pUnit)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
		pUnit:Root()
		pUnit:TeleportCreature(-818.58,-154.91,-25.88)
		pUnit:SetFacing(1)
		pUnit:SetOrientation(1.58)
		pUnit:PlaySoundToSet(11539)
		pUnit:SendChatMessage(14,0,"The time is now! Leave none standing!")
		pUnit:CastSpell(36178)
		pUnit:Emote(469,15000)
	end
end

function BFD.VAR.LADY_SLAY(pUnit,Event)
	if math.random(1,3) <= 1 then
		pUnit:PlaySoundToSet(11541)
		pUnit:SendChatMessage(14,0,"Your time ends now!")
	elseif math.random(1,3) <= 2 then
		pUnit:PlaySoundToSet(11542)
		pUnit:SendChatMessage(14,0,"You have failed!")
	elseif math.random(1,3) <= 3 then
		pUnit:PlaySoundToSet(11543)
	end
end

RegisterUnitEvent(6800, 1, "BFD.VAR.LADY_COMBAT")
RegisterUnitEvent(6800, 2, "BFD.VAR.LADY_LEAVE")
RegisterUnitEvent(6800, 3, "BFD.VAR.LADY_SLAY")
RegisterUnitEvent(6800, 4, "BFD.VAR.LADY_DEAD")