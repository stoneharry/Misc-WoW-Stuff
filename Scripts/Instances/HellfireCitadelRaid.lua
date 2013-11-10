HC = {}
HC.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000



function HC.VAR.Omrogg_Events(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("HC.VAR.SwitchWeapon", 4000, 1)
pUnit:RegisterEvent("HC.VAR.OMROGG_VOLATILESPAWNINGS", math.random(1000,3000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:Despawn(2000,5000)
elseif Event == 3 then
elseif Event == 4 then
pUnit:RemoveEvents()
elseif Event == 18 then
pUnit:EquipWeapons(29348,0,0)
end
	end

	RegisterUnitEvent(16809, 1, "HC.VAR.Omrogg_Events")
		RegisterUnitEvent(16809, 2, "HC.VAR.Omrogg_Events")
			RegisterUnitEvent(16809, 4, "HC.VAR.Omrogg_Events")
				RegisterUnitEvent(16809, 18, "HC.VAR.Omrogg_Events")
					RegisterUnitEvent(16809, 3, "HC.VAR.Omrogg_Events")
	
	
function HC.VAR.OMROGG_VOLATILESPAWNINGS(pUnit)
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

	
	function HC.VAR.SwitchWeapon(pUnit,Event)
		pUnit:SendChatMessage(42,0,"Warbringer O'mrogg switches weapons!")
			pUnit:RemoveAura(31534)
	pUnit:RemoveAura(40653)
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:RegisterEvent("HC.VAR.SwordBoard", 500, 1)
	elseif choice == 2 then
		pUnit:RegisterEvent("HC.VAR.TwoHander", 500, 1)
		elseif choice == 3 then
		pUnit:RegisterEvent("HC.VAR.Dualwield", 500, 1)
	end
	end
	
	function HC.VAR.TwoHander(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:CastSpell(2458)
	pUnit:CastSpell(40653)
	pUnit:EquipWeapons(2523,0,0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_VOLATILESPAWNINGS", math.random(2000,4000), 0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_Whirlwind", math.random(6000,13000), 0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_ROAR", math.random(10000,16000), 0)
	pUnit:RegisterEvent("HC.VAR.SwitchWeapon", 34000, 1)
	end
	
		function HC.VAR.SwordBoard(pUnit,Event)
		pUnit:RemoveEvents()
		pUnit:CastSpell(71)
	pUnit:EquipWeapons(29348,30889,0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_VOLATILESPAWNINGS", math.random(4000,5000), 0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_SHIELDBLOCK", math.random(10000,14000), 0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_SPELLREFLECT", math.random(14000,17000), 0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_SHATTERTHROW", math.random(11000,12000), 0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_THUNDERCLAP", math.random(6000,12000), 0)
	pUnit:RegisterEvent("HC.VAR.SwitchWeapon", 34000, 1)
	end
	
	function HC.VAR.Dualwield(pUnit,Event)
		pUnit:RemoveEvents()
		pUnit:CastSpell(2457)
	pUnit:EquipWeapons(28794,28794,0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_VOLATILESPAWNINGS", math.random(8000,10000), 0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_FLURRYBLOWS", math.random(7000,8000), 0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_BLADEFLURRY", math.random(10000,12000), 0)
	pUnit:RegisterEvent("HC.VAR.OMROGG_RENDFLESH", math.random(8000,13000), 0)
	pUnit:RegisterEvent("HC.VAR.SwitchWeapon", 34000, 1)
	end
	
	function HC.VAR.OMROGG_SHIELDBLOCK(pUnit)
	pUnit:CastSpell(37414)
	end
	
	function HC.VAR.OMROGG_FLURRYBLOWS(pUnit)
	pUnit:CastSpell(67233)
	end
	
	function HC.VAR.OMROGG_BLADEFLURRY(pUnit)
	pUnit:CastSpell(51211)
	end
	
	
	function HC.VAR.OMROGG_THUNDERCLAP(pUnit)
	pUnit:CastSpell(8078)
	end
	
		function HC.VAR.OMROGG_SPELLREFLECT(pUnit)
	pUnit:CastSpell(31534)
	end
	
	function HC.VAR.OMROGG_SHATTERTHROW(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(64382,tank)
		end
	end
	
		function HC.VAR.OMROGG_RENDFLESH(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(3147,tank)
		end
	end
	
	
		function HC.VAR.OMROGG_Whirlwind(pUnit)
	pUnit:CastSpell(40653)
end

function HC.VAR.OMROGG_ROAR(pUnit)
pUnit:CastSpell(16508)
end
	
	

function HC.VAR.ZURTROGG_EVENTS(pUnit,Event)
if Event == 1 then
pUnit:PlaySoundToSet(50062)
		pUnit:SendChatMessage(14,0,"So, you wish to face off against a real orc warchief. So be it. ")
		pUnit:RegisterEvent("HC.VAR.ZUTROGG_SWEEPINGSTRIKES", math.random(10000,15000), 1)
				pUnit:RegisterEvent("HC.VAR.ZUTROGG_SUMMON_WARBRINGERS", math.random(8000,10000), 1)
		pUnit:RegisterEvent("HC.VAR.ZURTROGG_ROOMOFFIRE", 45000, 1)
		pUnit:RegisterEvent("HC.VAR.ZURTROGG_PHASETWO", 1000, 0)
elseif Event == 2 then
pUnit:RemoveEvents()
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 17623 or creatures:GetEntry() == 21234 or creatures:GetEntry() == 920060 or creatures:GetEntry() == 6805 then
			creatures:Despawn(1,0)
				elseif creatures:GetEntry() == 68940 or creatures:GetEntry() == 920061 then
			creatures:SetPhase(2)
			end
	end
elseif Event == 3 then
local choice = math.random(1,3)
	if choice == 1 then
		pUnit:PlaySoundToSet(50063)
		pUnit:SendChatMessage(14,0,"Weak.")
	elseif choice == 2 then
		pUnit:PlaySoundToSet(50064)
		pUnit:SendChatMessage(14,0,"Hah. Pitiful.")
	elseif choice == 3 then
		pUnit:SendChatMessage(14,0,"Now you know your place, in MY new world.")
		pUnit:PlaySoundToSet(50065)
		end
elseif Event == 4 then
pUnit:RemoveEvents()
pUnit:RegisterEvent("HC.VAR.ZUTROGG_SENTENCEAFTERDEATH", 11000, 1)
pUnit:SendChatMessage(14,0,"No, it cannot end like this. What I…what I have seen?")
pUnit:PlaySoundToSet(50060)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 17623 or creatures:GetEntry() == 21234 or creatures:GetEntry() == 920060 or creatures:GetEntry() == 6805 then
			creatures:Despawn(1,0)
			elseif creatures:GetEntry() == 68940 or creatures:GetEntry() == 920061 then
			creatures:SetPhase(2)
			end
	end
end
	end
	
	function HC.VAR.ZUTROGG_SENTENCEAFTERDEATH(pUnit)
	pUnit:SendChatMessage(14,0,"Nooooo! This world, is my destiny! My, destiny.")
	pUnit:PlaySoundToSet(50061)
	end
	
	--PHASE ONE ABILITIES--
	function HC.VAR.ZUTROGG_SWEEPINGSTRIKES(pUnit)
	pUnit:CastSpell(18765)
	pUnit:RegisterEvent("HC.VAR.ZUTROGG_SWEEPINGSTRIKES", math.random(28000,30000), 1)
	end
	
	function HC.VAR.ZUTROGG_SUMMON_WARBRINGERS(pUnit)
	local choice = math.random(1,2)
	if choice == 1 then
pUnit:PlaySoundToSet(50076)
	pUnit:SendChatMessage(14,0,"Warbringers, bloody your blades.")
	end
	pUnit:SpawnCreature(17623,-1760.43, 1556.11, 252.24, 2.97, 14, 0)
	pUnit:SpawnCreature(17623,-1758.22 , 1569.15, 252.21, 2.97, 14, 0)
	pUnit:RegisterEvent("HC.VAR.ZUTROGG_SUMMON_WARBRINGERS", math.random(25000,30000), 1)
	end
	
	function HC.VAR.ZURTROGG_ROOMOFFIRE(pUnit,Event)
	pUnit:CastSpell(26789)
	pUnit:SendChatMessage(14,0,"We will cleanse this world in steel and FIRE!")
	pUnit:PlaySoundToSet(50077)
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 68940 then
			creatures:SetPhase(1)
			end
		end
		pUnit:RegisterEvent("HC.VAR.ZURTROGG_Fireisputout", 10000, 1)
	end
	
	function HC.VAR.ZURTROGG_Fireisputout(pUnit,Event)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 68940 then
				creatures:SetPhase(2)
			end
		end
		pUnit:RegisterEvent("HC.VAR.ZURTROGG_ROOMOFFIRE", 45000, 1)
	end
	---
	
	-- PHASE TWO ABILITIES--
	
	function HC.VAR.ZURTROGG_PHASETWO(pUnit,Event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
			pUnit:SendChatMessage(14,0,"Anger, hatred, fear, they are weapons of war. The tools of a Warchief.")
	pUnit:PlaySoundToSet(50066)
		pUnit:RegisterEvent("HC.VAR.ZUTROGG_SWEEPINGSTRIKES", math.random(11000,15000), 1)
		pUnit:RegisterEvent("HC.VAR.ZURTROGG_NETHERPOWER", math.random(8000,10000), 1)
		pUnit:RegisterEvent("HC.VAR.ZURTROGG_ROOMOFGLAIVE", math.random(15000,20000), 1)
				pUnit:RegisterEvent("HC.VAR.ZURTROGG_LEGIONFLAME", math.random(8000,10000), 0)
				pUnit:RegisterEvent("HC.VAR.ZURTROGG_DEFILE", math.random(12000,16000), 0)
				pUnit:RegisterEvent("HC.VAR.ZUTROGG_SUMMON_WARBRINGERS", math.random(8000,10000), 1)
	end
end
	
	
	function HC.VAR.ZURTROGG_NETHERPOWER(pUnit)
	pUnit:CastSpell(67009)
		pUnit:RegisterEvent("HC.VAR.ZURTROGG_NETHERPOWER", math.random(15000,21000), 1)
	end
	
	function HC.VAR.ZURTROGG_DEFILE(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		if plr:IsAlive() then
			if pUnit:GetDistanceYards(plr) < 40 then
			pUnit:CastSpellOnTarget(43647,plr)
			pUnit:SpawnCreature(21234, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 15, 45000)
			pUnit:SpawnCreature(920060, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 15, 45000)
			end
		end
	end
end
	
	
	function HC.VAR.ZURTROGG_LEGIONFLAME(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	HC[id] = HC[id] or {VAR={}}
	HC[id].VAR.LegionFlame = pUnit:GetRandomPlayer(0)
	if pUnit:GetDistanceYards(HC[id].VAR.LegionFlame) < 30 then
		if HC[id].VAR.LegionFlame:IsAlive() then
			pUnit:CastSpellOnTarget(66197,HC[id].VAR.LegionFlame)
			pUnit:RegisterEvent("HC.VAR.ZURTROGG_SPAWNLEGIONFIRE", 500, 4)
		end
		end
	end

	
	function HC.VAR.ZURTROGG_SPAWNLEGIONFIRE(pUnit,Event)
		local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	HC[id] = HC[id] or {VAR={}}
	if not HC[id].VAR.LegionFlame == nil then
	if HC[id].VAR.LegionFlame:HasAura(66200) then
	pUnit:SpawnCreature(6805, HC[id].VAR.LegionFlame:GetX(), HC[id].VAR.LegionFlame:GetY(), HC[id].VAR.LegionFlame:GetZ(), HC[id].VAR.LegionFlame:GetO(), 35, 0)
		end
			end
	end
	
	
function HC.VAR.GLAIVESPAWN(pUnit,Event)
pUnit:SetFlying()
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("HC.VAR.GLAIVEROLE",800,0)
end

RegisterUnitEvent(920061, 18, "HC.VAR.GLAIVESPAWN")
  
function HC.VAR.GLAIVEROLE(pUnit,Event)
		if pUnit:IsInPhase(1) == true then
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 5.2 then
			if players:IsDead() == false then
				pUnit:CastSpellOnTarget(54899,players)
				pUnit:Strike(players, 2, 70569, 200, 400, 2)
			end
		end
	end
end
end


	function HC.VAR.ZURTROGG_ROOMOFGLAIVE(pUnit,Event)
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 920061 then
			creatures:SetPhase(1)
			end
		end
		pUnit:RegisterEvent("HC.VAR.ZURTROGG_GLAIVEisputout", 30000, 1)
	end
	
	function HC.VAR.ZURTROGG_GLAIVEisputout(pUnit,Event)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 920061 then
				creatures:SetPhase(2)
			end
		end
		pUnit:RegisterEvent("HC.VAR.ZURTROGG_ROOMOFGLAIVE", 35000, 1)
	end
	--
	
RegisterUnitEvent(900040,1, "HC.VAR.ZURTROGG_EVENTS") 
RegisterUnitEvent(900040,2, "HC.VAR.ZURTROGG_EVENTS")
RegisterUnitEvent(900040,3, "HC.VAR.ZURTROGG_EVENTS")
RegisterUnitEvent(900040,4, "HC.VAR.ZURTROGG_EVENTS")


--PHASE ONE TRASH--
function HC.VAR.DARKSHIELDWARBRINGER_Events(pUnit,Event)
if Event == 18 then
pUnit:ModifyRunSpeed(14)
pUnit:ModifyWalkSpeed(14)
pUnit:EquipWeapons(6975,0,0)
pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0,1)
pUnit:RegisterEvent("HC.VAR.ZURTROGGADDENCOUNTER_MOVETOAREA", math.random(1000,2000), 1)
elseif Event == 1 then
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
end
	end
	
	function HC.VAR.ZURTROGGADDENCOUNTER_MOVETOAREA(pUnit)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 900040 then
			pUnit:MoveTo(creatures:GetX(), creatures:GetY(), creatures:GetZ(), 3)
		end
			end
	end

	RegisterUnitEvent(17623,1, "HC.VAR.DARKSHIELDWARBRINGER_Events") 
RegisterUnitEvent(17623,2, "HC.VAR.DARKSHIELDWARBRINGER_Events")
RegisterUnitEvent(17623,3, "HC.VAR.DARKSHIELDWARBRINGER_Events")
RegisterUnitEvent(17623,4, "HC.VAR.DARKSHIELDWARBRINGER_Events")
RegisterUnitEvent(17623,18, "HC.VAR.DARKSHIELDWARBRINGER_Events")
----


--HC.VAR.ZTOK THE BLOODTHIRSTY-- 37776 BLEEDING OUT, CHASES A TARGET WITH THIS DEBUFF, IF REACHES TARGET
-- THEN KILLS THE TARGET AND HEALS FOR A % ASWELL AS GETTING A BUFF, LOSES HUNGER BUFF THOUGH.



function HC.VAR.ZTOK_EVENTS(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("HC.VAR.ZTOK_SCREECH", math.random(25000,32000), 0)
pUnit:RegisterEvent("HC.VAR.ZTOK_WITHERINGROAR", math.random(22000,25000), 0)
pUnit:RegisterEvent("HC.VAR.ZTOK_RENDFLESH", math.random(8000,10000), 1)
pUnit:RegisterEvent("HC.VAR.ZTOK_CRAZEDHUNGER", math.random(5000,8000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
end
	end
	
	function HC.VAR.ZTOK_SCREECH(pUnit)
	pUnit:CastSpell(64422)
	pUnit:PlaySoundToSet(40052)
	end
	
	function HC.VAR.ZTOK_WITHERINGROAR(pUnit)
	pUnit:CastSpell(48256)
	end
	
	function HC.VAR.ZTOK_CRAZEDHUNGER(pUnit)
local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
			if pUnit:GetDistanceYards(players) < 25 then
			if players:IsDead() == false then
			if players:GetHealthPct() < 50 then
			if not pUnit:HasAura(3151) then
	pUnit:CastSpell(3151)
	end
	end
end
	end
end
	end
	
	function HC.VAR.ZTOK_RENDFLESH(pUnit,Event)
	local tank = pUnit:GetMainTank()
		if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:FullCastSpellOnTarget(70435, tank)
		end
	end
	pUnit:RegisterEvent("HC.VAR.ZTOK_RENDFLESH", math.random(12000,18000), 1)
end

	RegisterUnitEvent(940815,1, "HC.VAR.ZTOK_EVENTS") 
RegisterUnitEvent(940815,2, "HC.VAR.ZTOK_EVENTS")
RegisterUnitEvent(940815,4, "HC.VAR.ZTOK_EVENTS")