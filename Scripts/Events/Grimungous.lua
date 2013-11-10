GRIM = {}
GRIM.VAR = {}


function GRIM.VAR.Grimungous_Events(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GRIM[id] = GRIM[id] or {VAR={}}
if Event == 18 then
pUnit:SetFaction(58)
pUnit:RegisterEvent("GRIM.VAR.Grimungous_MoveTo_OnSpawn", 1000, 1)
elseif Event == 1 then
pUnit:AIDisableCombat(true)
pUnit:CastSpell(69926)
  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	players:PlayMusicToPlayer(50086)
	end
		end
		pUnit:RegisterEvent("GRIM.VAR.Grimungous_SPAWNDAMAGED", math.random(35000,42000),0)
		pUnit:RegisterEvent("GRIM.VAR.GrimungousLegs_CHECKING_FOR_PLAYERS",  1000,0)
pUnit:RegisterEvent("GRIM.VAR.Grimungous_ThrowRocks",  math.random(24000,25000),0)
pUnit:RegisterEvent("GRIM.VAR.Grimungous_zzzVOLATILESPAWNINGS",  math.random(22000,25000),0)
pUnit:RegisterEvent("GRIM.VAR.Grimungous_CastEarthShield",  math.random(30000,32000),0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
GRIM[id].VAR.MarkCreditGrim:AddItem(50493,1)
GRIM[id].VAR.MarkCreditGrim:CastSpell(47292)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 97091 then
		creatures:Despawn(1,0)
		end
			end
					local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	players:PlayMusicToPlayer(50084)
	end
		end
end
	end
	
	function GRIM.VAR.MARKPLAYERS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GRIM[id] = GRIM[id] or {VAR={}}
	  local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	if players:IsInCombat() then
	 GRIM[id].VAR.MarkCreditGrim = players
	end
		end
		end
	end
	
	RegisterUnitEvent(8215, 1, "GRIM.VAR.Grimungous_Events")
RegisterUnitEvent(8215, 2, "GRIM.VAR.Grimungous_Events")
RegisterUnitEvent(8215, 4, "GRIM.VAR.Grimungous_Events")
RegisterUnitEvent(8215, 18, "GRIM.VAR.Grimungous_Events")
	
	
	function GRIM.VAR.Grimungous_MoveTo_OnSpawn(pUnit,Event)
	local choice = math.random(1,3)
	if choice == 1 then
	pUnit:MoveTo(-267.22, -590.77, 59.46, 1.8)
	elseif choice == 2 then
	pUnit:MoveTo(-638.24,-508.97,31.89,0.91)
	elseif choice == 3 then
	pUnit:MoveTo(-217.51,158.01,70.04)
	end
	pUnit:RegisterEvent("GRIM.VAR.Grimungous_MoveTo_OnSpawn", 8000, 1)
		end
		
		function GRIM.VAR.Grimungous_SPAWNDAMAGED(pUnit)
		pUnit:SpawnCreature(97091,pUnit:GetX()+math.random(1,5), pUnit:GetY()+math.random(1,5),pUnit:GetZ(),pUnit:GetO(), 14, 45000)
	end



function GRIM.VAR.GrimungousLegs_STOMP(pUnit,Event)
pUnit:FullCastSpell(53634)
end

function GRIM.VAR.Grimungous_ThrowRocks(pUnit,Event)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 25 then
		pUnit:CastSpellOnTarget(58283,players)
		end
		end
end

function GRIM.VAR.Grimungous_zzzVOLATILESPAWNINGS(pUnit)
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
					if players:IsAlive() then
		pUnit:SpawnCreature(920792, players:GetX(), players:GetY(), players:GetZ(), 0, 35, 4000)
				end
			end
	end
end

function GRIM.VAR.Grimungous_CastEarthShield(pUnit,Event)
pUnit:CastSpell(69926)
end

function GRIM.VAR.GrimungousLegs_Events(pUnit,Event)
if Event == 1 then
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 8215 then
		creatures:SetFaction(14)
		end
	end
pUnit:RegisterEvent("GRIM.VAR.GrimungousLegs_STOMP",  math.random(20000,21000),0)
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 8215 then
		creatures:Root()
	creatures:SendChatMessage(42, 0, "Grimungous has become immobilized!")
		creatures:RemoveAura(53634)
		creatures:RemoveEvents()
		creatures:RegisterEvent("GRIM.VAR.Grimungous_MoveTo_OnSpawn", 1000, 1)
		creatures:RegisterEvent("GRIM.VAR.GrimungousLegs_STOMP",  math.random(20000,21000),0)
		creatures:RegisterEvent("GRIM.VAR.Grimungous_SPAWNDAMAGED",  math.random(35000,42000),0)
		creatures:RegisterEvent("GRIM.VAR.GrimungousLegs_CHECKING_FOR_PLAYERS",  1000,0)
creatures:RegisterEvent("GRIM.VAR.Grimungous_ThrowRocks",  math.random(8000,15000),0)
creatures:RegisterEvent("GRIM.VAR.Grimungous_zzzVOLATILESPAWNINGS",  math.random(14000,18000),0)
creatures:RemoveAura(53634)
			end
			end
end
end


function GRIM.VAR.GrimungousLegs_CHECKING_FOR_PLAYERS(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	GRIM[id] = GRIM[id] or {VAR={}}
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
		pUnit:SpawnCreature(8215, -394.81,-300.03, 59.73, 0, 58,0)
pUnit:Despawn(1000,0)
pUnit:Unroot()
GRIM[id].VAR.MarkCreditGrim = nil
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 97091 then
		creatures:Despawn(1,0)
		end
			end
	end
end

	RegisterUnitEvent(790841, 1, "GRIM.VAR.GrimungousLegs_Events")
RegisterUnitEvent(790841, 2, "GRIM.VAR.GrimungousLegs_Events")
RegisterUnitEvent(790841, 4, "GRIM.VAR.GrimungousLegs_Events")