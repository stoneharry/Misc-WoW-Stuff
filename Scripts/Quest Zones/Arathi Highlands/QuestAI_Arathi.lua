HL = {}
HL.VAR = {}


function Nerubian_Captive_Spawn(pUnit,Event)
	if pUnit:GetDisplay() == 25269 then
		pUnit:SetScale(0.3)
	elseif pUnit:GetDisplay() == 23984 then
		pUnit:SetScale(0.5)
	end
end

RegisterUnitEvent(442981, 18, "Nerubian_Captive_Spawn")

function ShadowMaifestGarden_Spawn(pUnit,Event)
	pUnit:SetScale(.85)
end

RegisterUnitEvent(549862, 18, "ShadowMaifestGarden_Spawn")

function TwilightFrostblade_Spawn(pUnit,Event)
	pUnit:EquipWeapons(47898,47898,0)
end

RegisterUnitEvent(26223, 18, "TwilightFrostblade_Spawn")

function RedeemedEarth_Spwn(pUnit,Event)
	pUnit:RegisterEvent("RedeemedEarth_Throw_Rock", math.random(7000,10000),0)
end

RegisterUnitEvent(21739, 18, "RedeemedEarth_Spwn")

function RedeemedEarth_Throw_Rock(pUnit,Event)
	local enemy = pUnit:GetRandomEnemy()
	if enemy ~= nil then
		if enemy:IsDead() == false then
			if pUnit:GetDistanceYards(enemy) < 100 then
				pUnit:CastSpellOnTarget(59464,enemy)
			end
		end
	end
end


function BearAvatar_Combat(pUnit,Event)
	pUnit:AIDisableCombat(false)
	pUnit:Unroot()
	pUnit:SendChatMessage(12,0,"Another trophy for my collection!")
	pUnit:RegisterEvent("BearAvatar_PercentObj", 1000, 0)
	pUnit:RegisterEvent("BearAvatar_Surge", math.random(9700,15000), 0)
end

function BearAvatar_Surge(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 8 then
			pUnit:CastSpellOnTarget(59881, tank)
		end
	end
end

function BearAvatar_PercentObj(pUnit,Event)
	if pUnit:GetHealthPct() < 10 then
		pUnit:RemoveEvents()
		pUnit:AIDisableCombat(true)
		pUnit:Root()
		pUnit:SendChatMessage(12,0,"You had your chance, now it be too' late!")
		pUnit:RegisterEvent("BearAvatar_TeleportToZA", 2000, 1)
	end
end

function BearAvatar_TeleportToZA(pUnit,Event)
	pUnit:CastSpell(60427)
	pUnit:Despawn(1200,10000)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if players:HasQuest(45025) then
			if pUnit:GetDistanceYards(players) < 40 then
				players:MarkQuestObjectiveAsComplete(45025, 0)
			end
		end
	end
end

function BearAvatar_Leave(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23576, 1, "BearAvatar_Combat")
RegisterUnitEvent(23576, 2, "BearAvatar_Leave")

function TheivingHawk_Dead(pUnit,Event,pLastTarget) -- not sure if people are able to steal credit or not. please test.
	pUnit:RemoveEvents()
	if pLastTarget:HasQuest(444921) then
		if pLastTarget:GetQuestObjectiveCompletion(45015, 1) ~= 10 then
			pUnit:SpawnGameObject(444921, pUnit:GetX(),pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(),45000, 100)
		end
	end
end

RegisterUnitEvent(549969, 4, "TheivingHawk_Dead")

function FACELESSHORROR_Dead(pUnit,Event,pLastTarget)
	pUnit:RemoveEvents()
	pUnit:CastSpell(39180)
	local choice = math.random(1,4)
	if choice == 1 then
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
	elseif choice == 2 then
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
	elseif choice == 3 then
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
	elseif choice == 4 then
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
		pUnit:SpawnCreature(33981,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 3600000)
	end
end

RegisterUnitEvent(333291, 4, "FACELESSHORROR_Dead")

----Horde Mines--

function OgreSlave_Events(pUnit,Event)
	if Event == 1 then
		local choice = math.random(1,6)
		if choice == 1 then
			pUnit:SendChatMessage(12,0,"Cultist say he free us!")
		elseif choice == 2 then
			pUnit:SendChatMessage(12,0,"Me slave no more!")
		elseif choice == 3 then
			pUnit:SendChatMessage(12,0,"New boss show us the way!")
		end
	elseif Event == 2 or Event == 4 then
		pUnit:RemoveEvents()
	elseif Event == 18 then
		pUnit:CastSpell(32582)
	end
end

RegisterUnitEvent(419823, 18, "OgreSlave_Events")
RegisterUnitEvent(419823, 1, "OgreSlave_Events")
RegisterUnitEvent(419823, 2, "OgreSlave_Events")
RegisterUnitEvent(419823, 4, "OgreSlave_Events")

function TwilightInfluencer_Events(pUnit,Event)
	if Event == 1 then
		pUnit:SendChatMessage(12,0,"Foolish Horde, your world is doomed!")
		pUnit:RegisterEvent("Twilight_Drain_soul", 1000, 1)
		--pUnit:RegisterEvent("Twilight_Drain_curse", math.random(3000,12000), 0)
		pUnit:RegisterEvent("Twilight_Drain_corr", math.random(5000,16000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:StopChannel()
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:StopChannel()
		pUnit:SendChatMessage(12,0,"Fool, don't you see? It has already begun - you cannot stop it!")
	end
end

function Twilight_Drain_soul(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:CastSpellOnTarget(8288, tank)
			if not pUnit:HasAura(8288) then
				pUnit:StopChannel()
			else
				pUnit:ChannelSpell(8288,tank)
			end
		end
		pUnit:RegisterEvent("Twilight_Drain_soul", 15000, 1)
	end
end

function Twilight_Drain_curse(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			if not tank:HasAura(1010) then
				pUnit:CastSpellOnTarget(1010, tank)
			end
		end
	end
end

function Twilight_Drain_corr(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			if not tank:HasAura(7648) then
				pUnit:CastSpellOnTarget(7648, tank)
			end
		end
	end
end

RegisterUnitEvent(419824, 1, "TwilightInfluencer_Events")
RegisterUnitEvent(419824, 2, "TwilightInfluencer_Events")
RegisterUnitEvent(419824, 4, "TwilightInfluencer_Events")

function WitherbarkDarkShaman_Events(pUnit,Event,pLastTarget)
	if Event == 1 then
		pUnit:RegisterEvent("WitherbarkShaman_CastEventOne", math.random(5000,10000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
		if pLastTarget then
			if pLastTarget:HasQuest(45019) then
				if pLastTarget:GetQuestObjectiveCompletion(45019, 0) ~= 10 then
					pLastTarget:AdvanceQuestObjective(45019, 0)
				end
			end
		end
	end
end

function WitherbarkShaman_CastEventOne(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:FullCastSpellOnTarget(9532,tank)
		end
	end
end

RegisterUnitEvent(176492, 4, "WitherbarkDarkShaman_Events")
RegisterUnitEvent(176492, 1, "WitherbarkDarkShaman_Events")



RegisterUnitEvent(176492, 2, "WitherbarkDarkShaman_Events")
--
function ShaofAgony_Events(pUnit,Event)
if Event == 1 then
pUnit:SendChatMessage(12,0,"Suffer in Agony!")
pUnit:RegisterEvent("ShaCast_Atrophy", math.random(10000,15000), 0)
pUnit:RegisterEvent("ShaCast_Absorb", math.random(8000,12000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(12,0,"You can not extinguish agony! I will always be here..")
end
end

function ShaCast_Absorb(pUnit)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:CastSpellOnTarget(32076,tank)
		end
	end
end

function ShaCast_Atrophy(pUnit)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:CastSpellOnTarget(40327,tank)
		end
	end
end

RegisterUnitEvent(549863, 1, "ShaofAgony_Events")
RegisterUnitEvent(549863, 2, "ShaofAgony_Events")
RegisterUnitEvent(549863, 4, "ShaofAgony_Events")

function BoundWaterLord_Events(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("BoundLord_Frostshock", math.random(8000,12000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
end
end


function BoundLord_Frostshock(pUnit)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:CastSpellOnTarget(21030,tank)
		end
	end
end

RegisterUnitEvent(30877, 1, "BoundWaterLord_Events")
RegisterUnitEvent(30877, 2, "BoundWaterLord_Events")
RegisterUnitEvent(30877, 4, "BoundWaterLord_Events")

function TwilightCyromancer_Events(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("TwilightCyromancer_Frostfire", math.random(3000,5000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
end
end

function TwilightCyromancer_Frostfire(pUnit)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 20 then
			pUnit:FullCastSpellOnTarget(51779,tank)
		end
	end
end


RegisterUnitEvent(26222, 1, "TwilightCyromancer_Events")
RegisterUnitEvent(26222, 2, "TwilightCyromancer_Events")
RegisterUnitEvent(26222, 4, "TwilightCyromancer_Events")

function TwilightEttin_Events(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("TwilightEttin_ThrowRock", math.random(3000,6000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
end
end

function TwilightEttin_ThrowRock(pUnit)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) >= 15 then
			pUnit:FullCastSpellOnTarget(36645,tank)
		end
	end
end

RegisterUnitEvent(700091, 1, "TwilightEttin_Events")
RegisterUnitEvent(700091, 2, "TwilightEttin_Events")
RegisterUnitEvent(700091, 4, "TwilightEttin_Events")

function TheAscended_Events(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("TheAscended_Fireball", math.random(3000,6000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
end
end

function TheAscended_Fireball(pUnit)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 15 then
			pUnit:FullCastSpellOnTarget(3140,tank)
			pUnit:SpawnCreature(6805, tank:GetX(), tank:GetY(), tank:GetZ(), 0, 35, 15000)
		end
	end
end

RegisterUnitEvent(700094, 1, "TheAscended_Events")
RegisterUnitEvent(700094, 2, "TheAscended_Events")
RegisterUnitEvent(700094, 4, "TheAscended_Events")

function FarmerGRiffithSpawn(pUnit,Event)
pUnit:RegisterEvent("FarmerGriffith_Yell", math.random(45000,95000), 0)
end

function FarmerGriffith_Yell(pUnit)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 32 then
	local choice = math.random(1,4)
if choice == 1 then
pUnit:SendChatMessageToPlayer(12,0,"COME OUT AND FACE ME YOU BASTARDS, YOU WILL PAY FOR RUINING MY FARM!",players)
elseif choice == 2 then
pUnit:SendChatMessageToPlayer(12,0,"YOU STOLE MY CARROTS, COME OUT LIKE THE VERMIN YOU ARE!",players)
elseif choice == 4 then
pUnit:SendChatMessageToPlayer(12,0,"IM GOING TO KILL YOU ALL, PESKY VERMIN!",players)
end
end
end
end

RegisterUnitEvent(20123, 18, "FarmerGRiffithSpawn")

function Jeninya_Events(pUnit,Event)
if Event == 1 then
pUnit:SendChatMessage(12,0,"Eek! Go away, farm man scary! we kill you!")
pUnit:RegisterEvent("Vermin_Whirlwind", math.random(3000,7000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
end
end

function Vermin_Whirlwind(pUnit,Event)
pUnit:FullCastSpell(54797)
end

RegisterUnitEvent(700099, 1, "Jeninya_Events")
RegisterUnitEvent(700099, 2, "Jeninya_Events")
RegisterUnitEvent(700099, 4, "Jeninya_Events")


function OverSeerVermin_Events(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("Vermin_Whirlwind", math.random(2000,5000), 0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
end
end



RegisterUnitEvent(700098, 1, "OverSeerVermin_Events")
RegisterUnitEvent(700098, 2, "OverSeerVermin_Events")
RegisterUnitEvent(700098, 4, "OverSeerVermin_Events")


---
function HL.VAR.Gogomoa_Events(pUnit,Event)
if Event == 1 then
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	if players:GetAreaId() == 616 then
		players:PlayMusicToPlayer(50109)
	else
	players:PlayMusicToPlayer(50086)
	end
		end
		end
		pUnit:RegisterEvent("HL.VAR.Gogomoa_Fart_Charge_SETUP", 15000, 1)
		pUnit:RegisterEvent("highlands_BANNANA_BOMB", math.random(4000,6000),0)
		pUnit:RegisterEvent("HL.VAR.GOGOMOA_PARALYZE", math.random(11000,12000),0)
		pUnit:RegisterEvent("HL.VAR.GOGOMOA_FARTTT", math.random(8000,12000),0)
		elseif Event == 18 then
		if pUnit:GetDisplay() == 8129 then
		pUnit:SetScale(2.5)
		end
		elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:SetFaction(58)
		elseif Event == 4 then
		pUnit:RemoveEvents()
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
	players:PlayMusicToPlayer(50084)
	end
		end
		end
			end
			
			function highlands_BANNANA_BOMB(pUnit,Event)
local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 40 then
player:CastSpellOnTarget(51935,pUnit)
pUnit:Strike(player, 2, 70569, 400, 450, 2)
end
end
end
			
			RegisterUnitEvent(14491, 1, "HL.VAR.Gogomoa_Events")
RegisterUnitEvent(14491, 2, "HL.VAR.Gogomoa_Events")
RegisterUnitEvent(14491, 4, "HL.VAR.Gogomoa_Events")
RegisterUnitEvent(14491, 18, "HL.VAR.Gogomoa_Events")


function HL.VAR.Gogomoa_Baby(pUnit,Event)
if Event == 1 then
 for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
  if creatures:GetEntry() == 14491 then
  if pUnit:GetDistanceYards(creatures) < 40 then
  creatures:SetFaction(14)
  end
  end
	end
	elseif Event == 4 then
	 for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
  if creatures:GetEntry() == 14491 then
    if pUnit:GetDistanceYards(creatures) < 40 then
  creatures:CastSpell(8599)
  end
	end
	end
	end
end

RegisterUnitEvent(1557, 1, "HL.VAR.Gogomoa_Baby")
RegisterUnitEvent(1557, 4, "HL.VAR.Gogomoa_Baby")

function HL.VAR.Gogomoa_Fart_Charge_SETUP(pUnit,Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("HL.VAR.Gogomoa_Fart_Charge", 1000, 1)
end

function HL.VAR.GOGOMOA_FARTTT(pUnit)
pUnit:CastSpell(21909)
end

function HL.VAR.GOGOMOA_PARALYZE(pUnit)
pUnit:CastSpell(40184)
end



function HL.VAR.Gogomoa_Fart_Charge(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	HL[id] = HL[id] or {VAR={}}
HL[id].VAR.FartTarget = pUnit:GetRandomPlayer(0)
if HL[id].VAR.FartTarget ~= nil then
if pUnit:GetDistanceYards(HL[id].VAR.FartTarget) < 30 then
if HL[id].VAR.FartTarget:IsDead() == false then
pUnit:MoveKnockback(HL[id].VAR.FartTarget:GetX(), HL[id].VAR.FartTarget:GetY(), HL[id].VAR.FartTarget:GetZ(), 6, 13)
pUnit:CastSpellOnTarget(22592,HL[id].VAR.FartTarget)
end
end
end
pUnit:RegisterEvent("HL.VAR.Gogomoa_STUNNED", 7100, 1)
end





function HL.VAR.Gogomoa_STUNNED(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	HL[id] = HL[id] or {VAR={}}
pUnit:RemoveEvents()
HL[id].VAR.FartTarget = nil
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:CastSpell(53361)
pUnit:RegisterEvent("HL.VAR.Gogomoa_Fart_Charge_SETUP", 15000, 1)
pUnit:RegisterEvent("highlands_BANNANA_BOMB", math.random(4000,6000),0)
end