
ZG = {}
ZG.VAR = {}

OBJECT_END = 0x0006
GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 -- Size: 1, Type: BYTES, Flags: PUBLIC

--[[
11250	A_TEMPEST_Zerek_Aggro01
11251	A_TEMPEST_Zerek_Slay01
11252	A_TEMPEST_Zerek_Slay02
11253	A_TEMPEST_Zerek_ShadowHell01
11254	A_TEMPEST_Zerek_ShadowHell02
11255	A_TEMPEST_Zerek_Death01
]]

-- Main boss

function ZG.VAR.MainBossSpawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2) -- unattackable
	pUnit:RegisterEvent("ZG.VAR.WaitForBossToLoad", 1000, 1)
end

function ZG.VAR.WaitForBossToLoad(pUnit)
--	pUnit:SetPosition(-11121.9, -2013.3, 147, 2.857928)
	pUnit:SetScale(1.5)
	pUnit:ChannelSpell(70358, pUnit) -- visual
	pUnit:RegisterEvent("ZG.VAR.CheckForPlayers", 2500, 0)
end

function ZG.VAR.CheckForPlayers(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 40 and plr:IsAlive() then
			pUnit:RemoveEvents()
			pUnit:StopChannel()
			pUnit:SetPosition(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0.111894)
			pUnit:SendChatMessage(14,0,"Life energy, to consume...")
			pUnit:PlaySoundToSet(11250)
			pUnit:RegisterEvent("ZG.VAR.BeginEventMainBoss", 3000, 1)
		end
	end
end

function ZG.VAR.BeginEventMainBoss(pUnit)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0) -- Attackable
end

RegisterUnitEvent(20738, 18, "ZG.VAR.MainBossSpawn")

--------------------------------------------------------

function ZG.VAR.MainBossHnadler(pUnit, Event)
	if Event == 1 then
		-- entered combat
		pUnit:SetScale(1)
		pUnit:RegisterEvent("ZG.VAR.MainRandomVisuals", 7500, 0)
		pUnit:RegisterEvent("ZG.VAR.MainShadowCleave", 7000, 0)
		pUnit:RegisterEvent("ZG.VAR.MainTimeFreeze", 8000, 0)
		pUnit:RegisterEvent("ZG.VAR.MainGrowAndPwnStuff", 10000, 1)
		pUnit:RegisterEvent("ZG.VAR.CheckForPhaseTwoMain", 2000, 0)
	elseif Event == 2 then
		-- Left combat
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("ZG.VAR.MainBossSpawn", 6000, 1)
	elseif Event == 3 then
		-- killed someone
	elseif Event == 4 then
		-- Got killed
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(11252)
		pUnit:SendChatMessage(14,0,"No more life...")
	end
end

function ZG.VAR.MainGrowAndPwnStuff(pUnit)
	pUnit:CastSpell(72679) -- Grow and shizzle
	if math.random(1,2) == 1 then
		pUnit:SendChatMessage(14,0,"Darkness consumes all.")
		pUnit:PlaySoundToSet(11254)
	else
		pUnit:SendChatMessage(14,0,"The shadow will in cone you.")
		pUnit:PlaySoundToSet(11253)
	end
	pUnit:RegisterEvent("ZG.VAR.MainGrowAndPwnStuff", math.random(18000, 35000), 1)
end

function ZG.VAR.MainRandomVisuals(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:CastSpellOnTarget(73539, plr) -- random visual
	end
end

function ZG.VAR.MainShadowCleave(pUnit)
	local plr = pUnit:GetMainTank()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(31629, plr)
	end
end

function ZG.VAR.MainTimeFreeze(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(40951, plr)
	end
end

function ZG.VAR.CheckForPhaseTwoMain(pUnit)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"No more life.")
		pUnit:PlaySoundToSet(11252)
		pUnit:AIDisableCombat(true) -- Requires custom patch to work
		pUnit:MoveTo(-11101, -2021, 147, 0)
		pUnit:RegisterEvent("ZG.VAR.BringItOnMainBoss", 6000, 1)
	end
end

function ZG.VAR.BringItOnMainBoss(pUnit)
	pUnit:ChannelSpell(12380, pUnit)
	pUnit:RegisterEvent("ZG.VAR.MainRandomVisuals", 1000, 0)
	if pUnit:GetHealthPct() < 35 then
		pUnit:RegisterEvent("ZG.VAR.MainEndVisualfinal", 15500, 1)
	else
		pUnit:RegisterEvent("ZG.VAR.MainEndVisual", 15500, 1)
	end
end

function ZG.VAR.MainEndVisual(pUnit)
	pUnit:RemoveEvents()
	pUnit:StopChannel()
	pUnit:AIDisableCombat(false) -- Requires custom patch to work
	-- Time to troll
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(40251, plr) -- kills them after 55 seconds
	end
	pUnit:RegisterEvent("ZG.VAR.MainRandomVisuals", 7500, 0)
	pUnit:RegisterEvent("ZG.VAR.MainShadowCleave", 7000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainDisoreitnate", 12000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainShroudGuys", 6000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainDeathGrip", 8000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainGrowAndPwnStuff", 20000, 1)
	pUnit:RegisterEvent("ZG.VAR.CheckForNextMainPhase", 2000, 0)
end

function ZG.VAR.MainDisoreitnate(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(26108, plr) -- cause to run around randomly for 3 seconds
	end
end

function ZG.VAR.MainShroudGuys(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		plr:CastSpell(40251) -- shroud of darkness
	end
end

function ZG.VAR.MainDeathGrip(pUnit)
	local plr = pUnit:GetRandomPlayer2(0)
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(64429, plr) -- visual
		plr:MoveKnockback(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 10, 20)
	end
end

function ZG.VAR.CheckForNextMainPhase(pUnit)
	if pUnit:GetHealthPct() < 35 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"No more life.")
		pUnit:PlaySoundToSet(11252)
		pUnit:AIDisableCombat(true) -- Requires custom patch to work
		pUnit:MoveTo(-11101, -2021, 147, 0)
		pUnit:RegisterEvent("ZG.VAR.BringItOnMainBoss", 6000, 1)
	end
end

function ZG.VAR.MainEndVisualfinal(pUnit)
	pUnit:RemoveEvents()
	pUnit:StopChannel()
	pUnit:AIDisableCombat(false) -- Requires custom patch to work
	-- Time to troll
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(40251, plr) -- kills them after 55 seconds
	end
	pUnit:RegisterEvent("ZG.VAR.MainRandomVisuals", 9000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainShadowCleave", 8000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainDisoreitnate", 10000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainShroudGuys", 6000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainDeathGrip", 6000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainTimeFreeze", 10000, 0)
	pUnit:RegisterEvent("ZG.VAR.MainGrowAndPwnStuff", 10000, 1)
end

RegisterUnitEvent(20738, 1, "ZG.VAR.MainBossHnadler")
RegisterUnitEvent(20738, 2, "ZG.VAR.MainBossHnadler")
RegisterUnitEvent(20738, 3, "ZG.VAR.MainBossHnadler")
RegisterUnitEvent(20738, 4, "ZG.VAR.MainBossHnadler")

-- Void zones -- spawned from the spell impact

function ZG.VAR.VoidZoneSpawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- unselectable
	pUnit:Root()
	pUnit:SetCombatCapable(false)
	pUnit:RegisterEvent("ZG.VAR.SendVisualVoidZone", 250, 1)
	pUnit:RegisterEvent("ZG.VAR.DamageNearbyZone", 1000, 0)
end

function ZG.VAR.DamageNearbyZone(pUnit)
	for k,plrs in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(plrs) < 6 then
			pUnit:Strike(plrs, 2, 695, 90, 100, 1)
		end
	end
end

function ZG.VAR.SendVisualVoidZone(pUnit)
	pUnit:FullCastSpell(73525) -- portal visual
	pUnit:CastSpell(45999) -- darkness visual
	if pUnit:GetMapId() ~= 37 then
		pUnit:RegisterEvent("ZG.VAR.VoidZoneDespawn", 25500, 1)
	end
end

function ZG.VAR.VoidZoneDespawn(pUnit)
	pUnit:RemoveEvents()
	pUnit:RemoveAura(73525)
	pUnit:Despawn(1000, 0)
end

RegisterUnitEvent(39137, 18, "ZG.VAR.VoidZoneSpawn")


 --[[ FIRST BOSS
 
 11238 TEMPEST_WrthScryr_Aggro01.wav 

11239 TEMPEST_WrthScryr_Slay01.wav 

11240 TEMPEST_WrthScryr_Slay02.wav 

11241 TEMPEST_WrthScryr_FireChrg01.wav 

11242 TEMPEST_WrthScryr_FireChrg02.wav 

11243 TEMPEST_WrthScryr_Death01.wav 
 ]]
 
 function ZG.VAR.EXECUTIONER_WHIRLWIND(pUnit,Event)
 pUnit:RemoveEvents()
 pUnit:CastSpell(40653)
 pUnit:AIDisableCombat(true)
 	if math.random(1,2) <= 1 then
		pUnit:PlaySoundToSet(11241)
		pUnit:SendChatMessage(14,0,"On guard!")
		elseif math.random(1,2) <= 2 then
		pUnit:PlaySoundToSet(11242)
		pUnit:SendChatMessage(14,0,"Defend yourself, for all the good it will do...")
		end
 pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_MOVERANDOMSPOT", 3000, 3)
  pUnit:RegisterEvent("ZG.VAR.SETAICOMBAT", 9000, 1)
 end
 
 function ZG.VAR.SETAICOMBAT(pUnit,Event)
 pUnit:AIDisableCombat(false)
 pUnit:CancelSpell()
 pUnit:RegisterEvent("ZG.VAR.EXECUTIONHANDLE", 3000, 0)
  pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_WHIRLWIND", 16000, 0)
    pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_NoOneInRange", 2000, 0)
	pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_BLACKCLEAVE", 7000, 0)
 end
 
 function ZG.VAR.EXECUTIONER_MOVERANDOMSPOT(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 20 then
 pUnit:MoveTo(player:GetX(),player:GetY(),player:GetZ(),player:GetO())
		end
	end
end
 
 function ZG.VAR.EXECUTIONER_NoOneInRange(pUnit,Event)
 local player = pUnit:GetClosestPlayer()
 if pUnit:GetDistanceYards(player) > 22 then
 local PlayersAllAround = pUnit:GetInRangePlayers()
				for a, players in pairs(PlayersAllAround) do
				 if pUnit:GetDistanceYards(players) > 22 then
 	pUnit:FullCastSpellOnTarget(64429, players) -- visual
		players:MoveKnockback(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 10, 20)
			end
		 end
	 end
 end
 
 function ZG.VAR.EXECUTIONHANDLE(pUnit,Event) -- Boss charges to the player, taking advantage of their low health and executes them quickly.
 	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	ZG[id].VAR.ExecutedPlayer = pUnit:GetRandomPlayer(0)
	if ZG[id].VAR.ExecutedPlayer ~= nil then
	if pUnit:GetDistanceYards(ZG[id].VAR.ExecutedPlayer) < 30 then
		if ZG[id].VAR.ExecutedPlayer:IsDead() == false then
			if ZG[id].VAR.ExecutedPlayer:GetHealthPct() < 25 then
			pUnit:RemoveEvents()
				local name = ZG[id].VAR.ExecutedPlayer:GetName()
				--pUnit:CastSpellOnTarget(100,ZG[id].VAR.ExecutedPlayer)
				 pUnit:AIDisableCombat(true)
				  pUnit:MoveTo(ZG[id].VAR.ExecutedPlayer:GetX(),ZG[id].VAR.ExecutedPlayer:GetY(),ZG[id].VAR.ExecutedPlayer:GetZ(),ZG[id].VAR.ExecutedPlayer:GetO())
				  ZG[id].VAR.ExecutedPlayer:Root()
				  ZG[id].VAR.ExecutedPlayer:DisableSpells(1)
				  ZG[id].VAR.ExecutedPlayer:DisableMelee(1)
				  ZG[id].VAR.ExecutedPlayer:DisableRanged(1)
				  ZG[id].VAR.ExecutedPlayer:CastSpell(68442)
				   pUnit:RegisterEvent("ZG.VAR.EXEUCTION", 4000, 1)
				local PlayersAllAround = pUnit:GetInRangePlayers()
				for a, players in pairs(PlayersAllAround) do
					if pUnit:GetDistanceYards(players) < 30 then
						pUnit:SendChatMessageToPlayer(42,0,"Rathorian Begins To Execute "..name.."", players)
				   end
				end
	        end
		end
	end
end
	end
	
	
	function ZG.VAR.EXEUCTION(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	pUnit:AIDisableCombat(false)
    pUnit:Emote(38,1500)
				  ZG[id].VAR.ExecutedPlayer:Root()
				  ZG[id].VAR.ExecutedPlayer:DisableSpells(0)
				  ZG[id].VAR.ExecutedPlayer:DisableMelee(0)
				  ZG[id].VAR.ExecutedPlayer:DisableRanged(0)
				  ZG[id].VAR.ExecutedPlayer:RemoveAura(68442)
				  pUnit:CastSpell(70304)
				  pUnit:ChannelSpell(42889, ZG[id].VAR.ExecutedPlayer)
				     pUnit:Strike(ZG[id].VAR.ExecutedPlayer,1,61140,2800,3950,1)
					 if pUnit:GetDistanceYards(ZG[id].VAR.ExecutedPlayer) > 10 then
					 pUnit:CastSpellOnTarget(59209,ZG[id].VAR.ExecutedPlayer)
					 end
					  pUnit:RegisterEvent("ZG.VAR.EXECUTIONHANDLE", 3000, 0)
					   pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_WHIRLWIND", 16000, 0)
					    pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_NoOneInRange", 2000, 0)
						pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_BLACKCLEAVE", 7000, 0)
						pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_STOPCHANNEL", 1000, 1)
	end
	
	function ZG.VAR.EXECUTIONER_STOPCHANNEL(pUnit,Event)
	pUnit:StopChannel()
	end
	
	
	function ZG.VAR.EXECUTIONER_BLACKCLEAVE(pUnit,Event) -- deals dot + cleave
		local tank = pUnit:GetMainTank()
				if tank ~= nil then
	pUnit:CastSpellOnTarget(33480,tank)
	end
	end
	
	function ZG.VAR.Executioner_Kill(pUnit,Event)
	 	if math.random(1,2) <= 1 then
		pUnit:PlaySoundToSet(11239)
		pUnit:SendChatMessage(14,0,"Yes, that was quite satisfying.")
		elseif math.random(1,2) <= 2 then
		pUnit:PlaySoundToSet(11240)
		pUnit:SendChatMessage(14,0,"Ah, much better!")
		end
	end
	
	
	function ZG.VAR.Executioner_Combat(pUnit,Event)
	pUnit:PlaySoundToSet(11238)
		pUnit:SendChatMessage(14,0,"At last, a target for my frustrations!")
		 pUnit:RegisterEvent("ZG.VAR.EXECUTIONHANDLE", 3000, 0)
		  pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_NoOneInRange", 2000, 0)
  pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_WHIRLWIND", 16000, 0)
  pUnit:RegisterEvent("ZG.VAR.EXECUTIONER_BLACKCLEAVE", 7000, 0)
	end
	
	function ZG.VAR.Executioner_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RemoveAura(70304)
	pUnit:Despawn(1000,5000)
	end
	
		function ZG.VAR.Executioner_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(11243)
		pUnit:SendChatMessage(14,0,"Knew this was... the only way out.")
	end
	
	
		RegisterUnitEvent(40848, 2, "ZG.VAR.Executioner_LEAVE")
RegisterUnitEvent(40848, 4, "ZG.VAR.Executioner_DEAD")
	RegisterUnitEvent(40848, 1, "ZG.VAR.Executioner_Combat")
	RegisterUnitEvent(40848, 3, "ZG.VAR.Executioner_Kill")
	
	function ZG.VAR.EXEUCTIONER_Leash(pUnit,Event)
  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 40848 then 
if pUnit:GetDistanceYards(creature) < 4.5 and creature:IsAlive() then
creature:Despawn(1000,5000)
end
	end
     	end
	end
			
			
function ZG.VAR.EXEUCTIONER_Leasher(pUnit,Event)
 pUnit:RegisterEvent("ZG.VAR.EXEUCTIONER_Leash", 1000, 0)
	end
	
	
		RegisterUnitEvent(40849,18, "ZG.VAR.EXEUCTIONER_Leasher")

-- Trash, jumping spiders ---------------------------------------------------

function ZG.VAR.JumpingSpiderSpawn(pUnit, Event)
	pUnit:RegisterEvent("ZG.VAR.JumpWhenREadySpider", 3000, 0)
end

function ZG.VAR.JumpWhenREadySpider(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if plr:GetDistanceYards(pUnit) < 40 then
			pUnit:RemoveEvents()
			pUnit:CastSpell(69986) -- web visual
			pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2) -- unattackable
			pUnit:MoveKnockback(plr:GetX(), plr:GetY(), plr:GetZ(), 6, 13)
			pUnit:RegisterEvent("ZG.VAR.SpiderSetHostileHurpaDerp", 5000, 1)
			--pUnit:RegisterEvent("ZG.VAR.StopSpawnResetSpider", 500, 0)
		end
	end
end

--[[function ZG.VAR.StopSpawnResetSpider(pUnit)
	if pUnit:GetZ() < (pUnit:GetLandHeight(pUnit:GetX(), pUnit:GetY()) + 5) then
		pUnit:Root()
	end
end]]

function ZG.VAR.SpiderSetHostileHurpaDerp(pUnit)
	pUnit:RemoveEvents()
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0) -- attackable
	pUnit:Unroot()
end

function ZG.VAR.JumpingSpideEvent(pUnit, Event)
	if Event == 2 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("ZG.VAR.JumpWhenREadySpider", 3000, 0)
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end

RegisterUnitEvent(74444, 18, "ZG.VAR.JumpingSpiderSpawn")
RegisterUnitEvent(74444, 2, "ZG.VAR.JumpingSpideEvent")
RegisterUnitEvent(74444, 4, "ZG.VAR.JumpingSpideEvent")

-- Second Boss ---------------------------------------------------------------

function ZG.VAR.SecondBossHandlerEvent(pUnit, Event)
	if Event == 1 then
		-- entered
		pUnit:RegisterEvent("ZG.VAR.SecondCurseOne", 1000, 1)
		pUnit:RegisterEvent("ZG.VAR.SecondCurseTwo", 5000, 0)
		pUnit:RegisterEvent("ZG.VAR.SecondCurseThree", 15000, 0)
		pUnit:RegisterEvent("ZG.VAR.BurnAllSecond", 22000, 0)
		pUnit:RegisterEvent("ZG.VAR.SEcondFireShield", 39000, 0)
		pUnit:RegisterEvent("ZG.VAR.RandomisePlayersSecond", 15000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:Despawn(3500, 4000)
	elseif Event == 3 then
		pUnit:FullCastSpell(22428) -- enrage
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end

function ZG.VAR.SecondCurseOne(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(6946, plr)
	end
end

function ZG.VAR.SecondCurseTwo(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(16871, plr)
	end
end

function ZG.VAR.SecondCurseThree(pUnit)
	pUnit:CastSpell(11988)
end

function ZG.VAR.BurnAllSecond(pUnit)
	pUnit:StopMovement(3500)
	pUnit:FullCastSpell(51768)
end

function ZG.VAR.SEcondFireShield(pUnit)
	pUnit:CastSpell(11350) -- fire shield
end

function ZG.VAR.RandomisePlayersSecond(pUnit)
	-- Store players & amount
	local index = {}
	local count = 0
	-- Get all players in this area, and add them to our encounter
	for place,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs ~= nil then
			index[place] = plrs
			count = count + 1
		end
	end
	-- If we have more than one player
	if count > 1 then
		-- Set up variables
		local x,y,z = 0,0,0
		if index[1] ~= nil and index[2] ~= nil then
			x,y,z = index[1]:GetX(), index[1]:GetY(), index[1]:GetZ()
			index[1]:CancelSpell()
			index[2]:CancelSpell()
			index[1]:MoveKnockback(index[2]:GetX(), index[2]:GetY(), index[2]:GetZ(), 7, 14)
			pUnit:FullCastSpellOnTarget(64429, index[2]) -- visual
			pUnit:FullCastSpellOnTarget(64429, index[1]) -- visual
			index[2]:MoveKnockback(x,y,z, 10, 20)
		end
		if index[3] ~= nil and index[4] ~= nil then
			x,y,z = index[3]:GetX(), index[3]:GetY(), index[3]:GetZ()
			index[3]:CancelSpell()
			index[4]:CancelSpell()
			pUnit:FullCastSpellOnTarget(64429, index[3]) -- visual
			pUnit:FullCastSpellOnTarget(64429, index[4]) -- visual
			index[3]:MoveKnockback(index[4]:GetX(), index[4]:GetY(), index[4]:GetZ(),7,14)
			index[4]:MoveKnockback(x,y,z,10,20)
		end
		if index[5] ~= nil then
			index[5]:CancelSpell()
			pUnit:FullCastSpellOnTarget(64429, index[5]) -- visual
			index[5]:MoveKnockback(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(),7,14)
		end
	end
end

RegisterUnitEvent(218331, 1, "ZG.VAR.SecondBossHandlerEvent")
RegisterUnitEvent(218331, 2, "ZG.VAR.SecondBossHandlerEvent")
RegisterUnitEvent(218331, 3, "ZG.VAR.SecondBossHandlerEvent")
RegisterUnitEvent(218331, 4, "ZG.VAR.SecondBossHandlerEvent")

-- The bridge event ----------------------------------------------------------

function ZG.VAR.BridgeEventSpawn(pUnit, Event)
	pUnit:RegisterEvent("ZG.VAR.BridgeEventCheck", 1000, 0)
end

function ZG.VAR.BridgeEventCheck(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 10 then
			pUnit:RemoveEvents()
			pUnit:SendChatMessage(42,0,"The ground begins to quake!")
			for _,plrs in pairs(pUnit:GetInRangePlayers()) do
				plrs:Dismount()
				plrs:Root()
				plrs:SetPlayerLock(true)
				plrs:CastSpell(43328) -- stun visual
				plrs:CastSpell(36455) -- shake camera - long
			end
			local id = pUnit:GetInstanceID()
			if id == nil then id = 1 end
			ZG[id] = ZG[id] or {VAR={}}
			ZG[id].VAR.inferno = true
			pUnit:RegisterEvent("ZG.VAR.InfernalReverseStun", 1000, 0)
		end
	end
end

function ZG.VAR.InfernalReverseStun(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	if not ZG[id].VAR.inferno then
		pUnit:RemoveEvents()
		for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			plrs:Unroot()
			plrs:SetPlayerLock(false)
			plrs:RemoveAura(43328) -- stun visual
		end
	end
end

RegisterUnitEvent(88880, 18, "ZG.VAR.BridgeEventSpawn")

function ZG.VAR.BridgeEventVisualSpawn(pUnit)
	pUnit:RegisterEvent("ZG.VAR.BridgeEventVisualCheck", 1000, 0)
end

function ZG.VAR.BridgeEventVisualCheck(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	if ZG[id].VAR.inferno then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("ZG.VAR.incomingInfernalZ", 4000, 1)
	end
end

function ZG.VAR.incomingInfernalZ(pUnit)
	pUnit:CastSpellAoF(-11091, -1855, 63.27, 32148) -- infernal
	pUnit:CastSpellAoF(-11096, -1833, 67.9, 32148) -- infernal
	pUnit:CastSpellAoF(-11103, -1876, 72.5, 32148) -- infernal
	pUnit:RegisterEvent("ZG.VAR.InfernalImpactSpawn", 4500, 1)
end

function ZG.VAR.InfernalImpactSpawn(pUnit)
	pUnit:SpawnCreature(89, -11091, -1855, 63.27, 0, 21, 120000)
	pUnit:SpawnCreature(89, -11096, -1833, 67.9, 0, 21, 120000)
	pUnit:SpawnCreature(89, -11103, -1876, 72.5, 0, 21, 120000)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	ZG[id].VAR.inferno = false
end

RegisterUnitEvent(88881, 18, "ZG.VAR.BridgeEventVisualSpawn")

function ZG.VAR.InfernalOnSpawn(pUnit)
	pUnit:RegisterEvent("ZG.VAR.InfernalRunToPlayers", 500, 1)
end

function ZG.VAR.InfernalRunToPlayers(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
	end
end

RegisterUnitEvent(89, 18, "ZG.VAR.InfernalOnSpawn")

-- Trash ---------------------------------------------------------------------

function ZG.VAR.BrokenKodoCombat(pUnit)
	pUnit:FullCastSpell(16096)
	pUnit:RegisterEvent("ZG.VAR.kodostomp", math.random(4000, 12000), 0)
end

function ZG.VAR.kodostomp(pUnit)
	pUnit:FullCastSpell(28125)
end

function ZG.VAR.BrokenKodoDeath(pUnit) -- it seems that spawning mobs bugs movementmaps
	--[[local d = math.random(1,4)
	local i = 0
	while i ~= d do
		pUnit:SpawnCreature(40847, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 21, 120000)
		i = i + 1
	end]]
	pUnit:RemoveEvents()
end

RegisterUnitEvent(109161, 4, "ZG.VAR.BrokenKodoDeath")
RegisterUnitEvent(109161, 2, "ZG.VAR.BrokenKodoDeath")
RegisterUnitEvent(109161, 1, "ZG.VAR.BrokenKodoCombat")
 
-- Satyr Trash ---------------------------------------------------------------

function ZG.VAR.SatyrTrashOnEvent(pUnit, Event)
	if Event == 1 then
		if pUnit:GetEntry() == 3758 then -- Tank
			if math.random(1,2) == 1 then
				pUnit:FullCastSpell(8713)
			else
				pUnit:StopMovement(1200)
				pUnit:FullCastSpell(72143)
				pUnit:RegisterEvent("ZG.VAR.SatyrTankCharge", 1500, 1)
				pUnit:RegisterEvent("ZG.VAR.SatyrTankCastRandom", 6500, 0)
			end
		elseif pUnit:GetEntry() == 6125 then -- Rogue
			pUnit:RegisterEvent("ZG.VAR.SatyrRogueStrike", 2000, 0)
			pUnit:RegisterEvent("ZG.VAR.SatyrRogueEnergy", 500, 0)
		elseif pUnit:GetEntry() == 6200 then -- Caster
			pUnit:RegisterEvent("ZG.VAR.SatyrHealerHeal", 1000, 1)
		end
	elseif Event == 2 or Event == 4 then
		pUnit:RemoveEvents()
		if pUnit:GetEntry() == 6125 then
			pUnit:SetPower(100, 3)
		end
		if pUnit:HasAura(8713) then
			pUnit:RemoveAura(8713)
		end
	elseif Event == 18 then
		pUnit:SetMaxPower(100, 3)
		pUnit:SetPower(100, 3)
		pUnit:SetPowerType(3)
	end
end

function ZG.VAR.SatyrRogueEnergy(pUnit)
	if pUnit:GetPower(3) < 100 then
		pUnit:SetPower(pUnit:GetPower(3)+5, 3)
	end
end

function ZG.VAR.SatyrRogueStrike(pUnit)
	local plr = pUnit:GetMainTank()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(11294, plr) -- sinister strike
	end
	if math.random(1,10) == 5 then
		pUnit:FullCastSpell(6434)
	end
end

function ZG.VAR.SatyrTankCharge(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(55317, plr)
	end
end

function ZG.VAR.SatyrTankCastRandom(pUnit)
	if math.random(1,2) == 1 then
		local target = pUnit:GetMainTank()
		if target ~= nil then
			pUnit:FullCastSpellOnTarget(21949, target) -- rend
		end
	else
		pUnit:FullCastSpell(3143) -- roar
	end
end

function ZG.VAR.SatyrHealerHeal(pUnit)
	local found = false
	for _,target in pairs(pUnit:GetInRangeUnits()) do
		if target:IsAlive() then
			if not target:IsPlayer() then
				if target:GetHealthPct() < 60 then
					if target:GetDistanceYards(pUnit) < 30 then
						pUnit:StopMovement(3000)
						pUnit:FullCastSpellOnTarget(10623, target)
						found = true
						break
					end
				end
			end
		end
	end
	if not found then
		local plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			if plr:GetDistanceYards(pUnit) < 30 then
				pUnit:StopMovement(3500)
				pUnit:FullCastSpellOnTarget(39054, plr)
			end
		end
	end
	pUnit:RegisterEvent("ZG.VAR.SatyrHealerHeal", 7000, 1)
end

RegisterUnitEvent(3758, 1, "ZG.VAR.SatyrTrashOnEvent") -- Tank
RegisterUnitEvent(3758, 2, "ZG.VAR.SatyrTrashOnEvent")
RegisterUnitEvent(3758, 4, "ZG.VAR.SatyrTrashOnEvent")
RegisterUnitEvent(6125, 1, "ZG.VAR.SatyrTrashOnEvent") -- Rogue
RegisterUnitEvent(6125, 2, "ZG.VAR.SatyrTrashOnEvent")
RegisterUnitEvent(6125, 4, "ZG.VAR.SatyrTrashOnEvent")
RegisterUnitEvent(6125, 18, "ZG.VAR.SatyrTrashOnEvent")
RegisterUnitEvent(6200, 1, "ZG.VAR.SatyrTrashOnEvent") -- Caster
RegisterUnitEvent(6200, 2, "ZG.VAR.SatyrTrashOnEvent")
RegisterUnitEvent(6200, 4, "ZG.VAR.SatyrTrashOnEvent")

-- Final Dragon Boss ---------------------------------------------------------

function ZG.VAR.DragonBossEvent_COT(pUnit, Event)
	if Event == 4 then
		pUnit:RemoveEvents()
	elseif Event == 18 then
		pUnit:RegisterEvent("ZG.VAR.SetUpCreatures_Dragon", 1000, 1)
	end
end

RegisterUnitEvent(115831, 4, "ZG.VAR.DragonBossEvent_COT")
RegisterUnitEvent(115831, 18, "ZG.VAR.DragonBossEvent_COT")

function ZG.VAR.SetUpCreatures_Dragon(pUnit)
	pUnit:SetMaxPower(100, 2)
	pUnit:SetPower(100, 2)
	pUnit:SetPowerType(2)
	--pUnit:SetPosition(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+6, pUnit:GetO())
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	ZG[id].VAR.leader = pUnit:SpawnCreature(36544, -11062, -2306, 145.9, 1.290404, 35, 0, 50429) -- Leader
	ZG[id].VAR.addA = pUnit:SpawnCreature(4052, -11075, -2307, 145, 1.058709, 35, 0, 45212)
	ZG[id].VAR.addB = pUnit:SpawnCreature(4052, -11066, -2311, 145.9, 1.184373, 35, 0, 45212)
	ZG[id].VAR.addC = pUnit:SpawnCreature(4052, -11057, -2314, 147.3, 1.549583, 35, 0, 45212)
	ZG[id].VAR.addD = pUnit:SpawnCreature(4052, -11049, -2311, 146.3, 2, 35, 0, 45212)
	pUnit:RegisterEvent("ZG.VAR.WhileNoPlayer_DoVisual", 1500, 1)
	pUnit:RegisterEvent("ZG.VAR.CheckForPlayers_ToStart", 1000, 0)
end

function ZG.VAR.WhileNoPlayer_DoVisual(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	ZG[id].VAR.leader:ChannelSpell(48185, pUnit)
	ZG[id].VAR.addA:ChannelSpell(49128, ZG[id].VAR.leader)
	ZG[id].VAR.addB:ChannelSpell(49128, ZG[id].VAR.leader)
	ZG[id].VAR.addC:ChannelSpell(49128, ZG[id].VAR.leader)
	ZG[id].VAR.addD:ChannelSpell(49128, ZG[id].VAR.leader)
end

function ZG.VAR.CheckForPlayers_ToStart(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	local plr = ZG[id].VAR.leader:GetClosestPlayer()
	if plr ~= nil then
		if ZG[id].VAR.leader:GetDistanceYards(plr) < 10 then
			if plr:IsAlive() then
				pUnit:SetMovementFlags(2)
				ZG[id].VAR.leader:SendChatMessage(12,0,"Hurry mortals, I cannot hold the beast back for long!")
				pUnit:RemoveEvents()
				pUnit:RegisterEvent("ZG.VAR.HEREWEGO_DRAGON", 4000, 1)
			end
		end
	end
end

function ZG.VAR.HEREWEGO_DRAGON(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	pUnit:SendChatMessage(14,0,"ENOUGH! Now you vermin shall feel the force of my birthright: The Fury of the Earth itself!")
	pUnit:SpawnGameObject(146086, -11095.85, -2318.86, 147.5, 6.154612, 900000, 100) -- cave in
	ZG[id].VAR.leader:PlaySoundToSet(8289)
	ZG[id].VAR.leader:StopChannel()
	ZG[id].VAR.addA:StopChannel()
	ZG[id].VAR.addB:StopChannel()
	ZG[id].VAR.addC:StopChannel()
	ZG[id].VAR.addD:StopChannel()
	pUnit:RegisterEvent("ZG.VAR.WaitForVisualsToPlayDURP", 250, 1)
	ZG[id].VAR.e = 0
	ZG[id].VAR.hpCount = 1
	ZG[id].VAR.hpList = {90,80,70,60,50,40,30,20,10}
	pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 7000, 1)
	pUnit:RegisterEvent("ZG.VAR.DrainDragonBossHealth", 500, 0)
	pUnit:RegisterEvent("ZG.VAR.DragonBossCheckForWipe_Astarot", 2000, 0)
	pUnit:RegisterEvent("ZG.VAR.DragonDespawnDeadTrash", 10000, 0)
end

function ZG.VAR.WaitForVisualsToPlayDURP(pUnit)
	-- commented out as knockdown visual is broke
	--[[local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	ZG[id].VAR.leader:CastSpell(68848)
	ZG[id].VAR.addA:CastSpell(68848) -- knockdown visual
	ZG[id].VAR.addB:CastSpell(68848)
	ZG[id].VAR.addC:CastSpell(68848)
	ZG[id].VAR.addD:CastSpell(68848)]]
end

function ZG.VAR.DrainDragonBossHealth(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	if pUnit:GetHealthPct() > ZG[id].VAR.hpList[ZG[id].VAR.hpCount] then
		pUnit:SetHealth(pUnit:GetHealth()-200)
	end
	--[[if pUnit:GetPower() < pUnit:GetMaxPower() then
		pUnit:SetPower(pUnit:GetPower(2)+1, 2)
	end]]
end

function ZG.VAR.BeginZeEventZZ(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	ZG[id].VAR.e = ZG[id].VAR.e + 1
	if ZG[id].VAR.e == 1 then
		ZG[id].VAR.leader:SendChatMessage(12,0,"Mortals, you must defend us while we attempt to destroy this being, or all hope is lost!")
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 3000, 1)
	elseif ZG[id].VAR.e == 2 then
		ZG[id].VAR.addA:ChannelSpell(49128, ZG[id].VAR.leader)
		ZG[id].VAR.addB:ChannelSpell(49128, ZG[id].VAR.leader)
		ZG[id].VAR.addC:ChannelSpell(49128, ZG[id].VAR.leader)
		ZG[id].VAR.addD:ChannelSpell(49128, ZG[id].VAR.leader)		
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 1000, 1)
	elseif ZG[id].VAR.e == 3 then
		ZG[id].VAR.leader:ChannelSpell(48185, pUnit)
		--ZG[id].VAR.e = 15 -- DEBUG -------------------------------------------------------------------------
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 1000, 1)
	elseif ZG[id].VAR.e == 4 then
		pUnit:CastSpellAoF(-11062.66, -2297.34, 146, 68926)
		pUnit:SpawnCreature(21234, -11062.66, -2297.34, 146, 0, 15, 300000)
		ZG[id].VAR.dragons = 0
		pUnit:RegisterEvent("ZG.VAR.SpawnMoreDamnDragonLords", 5000, 2)
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 20000, 1)
	elseif ZG[id].VAR.e == 5 then
		local found = false
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			local entry = unit:GetEntry()
			if entry == 871111 or entry == 497111 then
				if unit:IsAlive() then
					found = true
					break
				end
			end
		end
		if not found then
			ZG[id].VAR.leader:PlaySoundToSet(8291)
			pUnit:SendChatMessage(14,0,"Impossible! Rise my minions! Serve your master once more!")
			ZG[id].VAR.hpCount = ZG[id].VAR.hpCount + 1
		else
			ZG[id].VAR.e = ZG[id].VAR.e - 1
		end
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 1000, 1)
	elseif ZG[id].VAR.e == 6 then
		ZG[id].VAR.dragons = 0
		pUnit:RegisterEvent("ZG.VAR.SpawnMoreDamnDragonLords", 5000, 3)
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 20000, 1)		
	elseif ZG[id].VAR.e == 7 then
		local found = false
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			local entry = unit:GetEntry()
			if entry == 871111 or entry == 497111 then
				if unit:IsAlive() then
					found = true
					break
				end
			end
		end
		if not found then
			ZG[id].VAR.hpCount = ZG[id].VAR.hpCount + 1
			ZG[id].VAR.leader:PlaySoundToSet(8290)
			pUnit:SendChatMessage(14,0,"Burn, you wretches! Burn!")
			ZG[id].VAR.hpCount = ZG[id].VAR.hpCount + 1
			local trigger = pUnit:GetCreatureNearestCoords(ZG[id].VAR.leader:GetX(),ZG[id].VAR.leader:GetY(),ZG[id].VAR.leader:GetZ(),27942)
			trigger:SetScale(0.8)
			trigger:CastSpell(63894) -- shield
		else
			ZG[id].VAR.e = ZG[id].VAR.e - 1
		end
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 1000, 1)
	elseif ZG[id].VAR.e == 8 then
		ZG[id].VAR.leader:SendChatMessage(14,0,"Quick, get within the barrier!")
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 4000, 1)
	elseif ZG[id].VAR.e == 9 then
		for i=1,100 do
			pUnit:RegisterEvent("ZG.VAR.METEORSINCOMINGDUN_DUN", math.random(1000,20000),1)
		end
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 23000, 1)
	elseif ZG[id].VAR.e == 10 then
		pUnit:GetCreatureNearestCoords(ZG[id].VAR.leader:GetX(),ZG[id].VAR.leader:GetY(),ZG[id].VAR.leader:GetZ(),27942):RemoveAura(63894) -- shield
		ZG[id].VAR.leader:PlaySoundToSet(8292)
		pUnit:SendChatMessage(14,0,"This cannot be! I am the Master here! You mortals are nothing to my kind! DO YOU HEAR? NOTHING!")
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 4000, 1)
	elseif ZG[id].VAR.e == 11 then
		ZG[id].VAR.hpCount = ZG[id].VAR.hpCount + 1
		ZG[id].VAR.dragons = 0
		pUnit:RegisterEvent("ZG.VAR.SpawnMoreDamnDragonLords", 5000, 4)
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 21000, 1)
	elseif ZG[id].VAR.e == 12 then
		local found = false
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			local entry = unit:GetEntry()
			if entry == 871111 or entry == 497111 then
				if unit:IsAlive() then
					found = true
					break
				end
			end
		end
		if not found then
			for _,unit in pairs(pUnit:GetInRangeUnits()) do
				if unit:GetEntry() == 21234 then
					unit:Kill(unit)
					break
				end
			end
			ZG[id].VAR.leader:PlaySoundToSet(8291)
			pUnit:SendChatMessage(14,0,"Impossible! Rise my minions! Serve your master once more!")
			ZG[id].VAR.hpCount = ZG[id].VAR.hpCount + 1
			ZG[id].VAR.dragons = 0
			pUnit:RegisterEvent("ZG.VAR.SpawnMoreDamnDragonLords", 5000, 3)
			pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 21000, 1)
		else
			ZG[id].VAR.e = ZG[id].VAR.e - 1
			pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 5000, 1)
		end
	elseif ZG[id].VAR.e == 13 then
		local found = false
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			local entry = unit:GetEntry()
			if entry == 871111 or entry == 497111 then
				if unit:IsAlive() then
					found = true
					break
				end
			end
		end
		if not found then
			ZG[id].VAR.hpCount = ZG[id].VAR.hpCount + 1
			ZG[id].VAR.leader:PlaySoundToSet(8290)
			pUnit:SendChatMessage(14,0,"Burn, you wretches! Burn!")
			ZG[id].VAR.hpCount = ZG[id].VAR.hpCount + 1
			local trigger = pUnit:GetCreatureNearestCoords(ZG[id].VAR.leader:GetX(),ZG[id].VAR.leader:GetY(),ZG[id].VAR.leader:GetZ(),27942)
			trigger:SetScale(0.8)
			trigger:CastSpell(63894) -- shield
		else
			ZG[id].VAR.e = ZG[id].VAR.e - 1
		end
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 1000, 1)	
	elseif ZG[id].VAR.e == 14 then
		ZG[id].VAR.leader:SendChatMessage(14,0,"Quick, get within the barrier!")
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 2500, 1)
	elseif ZG[id].VAR.e == 15 then
		for i=1,100 do
			pUnit:RegisterEvent("ZG.VAR.METEORSINCOMINGDUN_DUN", math.random(1000,20000),1)
		end
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 23000, 1)
	elseif ZG[id].VAR.e == 16 then
		pUnit:GetCreatureNearestCoords(ZG[id].VAR.leader:GetX(),ZG[id].VAR.leader:GetY(),ZG[id].VAR.leader:GetZ(),27942):RemoveAura(63894) -- shield
		ZG[id].VAR.leader:PlaySoundToSet(8292)
		pUnit:SendChatMessage(14,0,"This cannot be! I am the Master here! You mortals are nothing to my kind! DO YOU HEAR? NOTHING!")
		pUnit:SetHealthPct(10)
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 5000, 1)
	elseif ZG[id].VAR.e == 17 then
		--pUnit:ChannelSpell(68834, ZG[id].VAR.leader)
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 1000, 1)
	elseif ZG[id].VAR.e == 18 then
		ZG[id].VAR.leader:SendChatMessage(14,0,"No!")
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 2000, 1)
	elseif ZG[id].VAR.e == 19 then
		ZG[id].VAR.leader:SendChatMessage(12,0,"Death to the interlopers.")
		ZG[id].VAR.leader:StopChannel()
		ZG[id].VAR.leader:CastSpell(41535) -- chains visual
		ZG[id].VAR.addA:StopChannel()
		ZG[id].VAR.addB:StopChannel()
		ZG[id].VAR.addC:StopChannel()
		ZG[id].VAR.addD:StopChannel()
		ZG[id].VAR.addcount = 0
		pUnit:RegisterEvent("ZG.VAR.SetFactionsOfNPCSDragon", 1000, 4)
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 5000, 1)
	elseif ZG[id].VAR.e == 20 then
		ZG[id].VAR.addA:SetFaction(21)
		ZG[id].VAR.addB:SetFaction(21)
		ZG[id].VAR.addC:SetFaction(21)
		ZG[id].VAR.addD:SetFaction(21)
		ZG[id].VAR.leader:SetFaction(21)
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 2000, 1)
	elseif ZG[id].VAR.e == 21 then
		local found = false
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			local entry = unit:GetEntry()
			if entry == 36544 or entry == 4052 then
				if unit:IsAlive() then
					found = true
					break
				end
			end
		end
		if not found then
			ZG[id].VAR.leader:PlaySoundToSet(8293)
			pUnit:SendChatMessage(14,0,"Worthless wretch! Your friends will join you soon enough!")
			pUnit:SetHealth(132)
		else
			ZG[id].VAR.e = ZG[id].VAR.e - 1
		end
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 1000, 1)		
	elseif ZG[id].VAR.e == 22 then
		pUnit:MoveTo(-11064, -2310.88, 146.2, 0)
		pUnit:RegisterEvent("ZG.VAR.VisuzlzzBoss", 100, 0)
		pUnit:RegisterEvent("ZG.VAR.BeginZeEventZZ", 6000, 1)	
	elseif ZG[id].VAR.e == 23 then
		pUnit:RemoveEvents()
		--[[for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:IsAlive() then
				plrs:CastSpellOnTarget(11, pUnit)
			end
		end]]
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			local entry = unit:GetEntry()
			if entry == 21234 or entry == 871111 or entry == 36544 or entry == 497111 or entry == 4052 then
				if not unit:IsAlive() then
					unit:Despawn(1,0)
				end
			end
		end
		local object = pUnit:GetGameObjectNearestCoords(-11095.5, -2318.3, 147.5, 146086) -- rocks
		if object ~= nil then
			object:Despawn(1,0)
		end
		pUnit:SpawnGameObject(355101, -11064, -2329.5, 146.6, 4.679757, 300000, 100) -- chest
		pUnit:Kill(pUnit)
	end
end

function ZG.VAR.SetFactionsOfNPCSDragon(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	ZG[id].VAR.addcount = ZG[id].VAR.addcount + 1
	if ZG[id].VAR.addcount == 1 then
		ZG[id].VAR.addA:CastSpell(41535)
	elseif ZG[id].VAR.addcount == 2 then
		ZG[id].VAR.addB:CastSpell(41535)
	elseif ZG[id].VAR.addcount == 3 then
		ZG[id].VAR.addC:CastSpell(41535)
	elseif ZG[id].VAR.addcount == 4 then
		ZG[id].VAR.addD:CastSpell(41535)
	end
end

function ZG.VAR.VisuzlzzBoss(pUnit)
	pUnit:CastSpell(32711) -- AoE visual
end

function ZG.VAR.METEORSINCOMINGDUN_DUN(pUnit)
	pUnit:SetPower(pUnit:GetPower(2)-3, 2)
	local nx = math.random(11051,11087)
	local ny = math.random(2325,2341)
	pUnit:CastSpellAoF(-nx,-ny,pUnit:GetLandHeight(-nx,-ny),57467)
	if math.random(1,100) < 13 then -- Since the square doesn't cover the sides of the shield, we'll hit those gaps
		if math.random(1,2) == 1 then
			pUnit:CastSpellAoF(-11048.75, -2320.6, 147.8,57467)
		else
			pUnit:CastSpellAoF(-11078.3, -2315, 147,57467)
		end
	end
end

function ZG.VAR.SpawnMoreDamnDragonLords(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZG[id] = ZG[id] or {VAR={}}
	if ZG[id].VAR.dragons == 0 then
		pUnit:CastSpellAoF(-11042, -2333, 146.65, 68926)
		pUnit:SpawnCreature(871111, -11042, -2333, 146.8, 2.67, 21, 300000, 39221):SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	elseif ZG[id].VAR.dragons == 1 then
		pUnit:CastSpellAoF(-11089.64, -2331.76, 146.3, 68926)
		pUnit:SpawnCreature(871111, -11089.64, -2331.76, 146.3, 0.37, 21, 300000, 39221):SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	elseif ZG[id].VAR.dragons == 2 then
		pUnit:CastSpellAoF(-11090.4, -2332, 146.3, 68926)
		for i=1,math.random(5,12) do
			pUnit:SpawnCreature(497111, -11090.4, -2332, 146.3, 0.206785, 15, 120000)
		end
	elseif ZG[id].VAR.dragons == 3 then
		pUnit:CastSpellAoF(-11042.7, -2333, 146.7, 68926)
		for i=1,math.random(9,15) do
			pUnit:SpawnCreature(497111, -11042.7, -2333, 146.7, 2.649929, 15, 120000)
		end	
	end
	ZG[id].VAR.dragons = ZG[id].VAR.dragons + 1
end

function ZG.VAR.DragonDespawnDeadTrash(pUnit)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		local entry = unit:GetEntry()
		if entry == 21234 or entry == 871111 or entry == 36544 or entry == 497111 or entry == 4052 then
			if not unit:IsAlive() then
				--pUnit:CastSpellAoF(unit:GetX(), unit:GetY(), unit:GetZ(), 68926) -- causes too much damage
				unit:Despawn(1,0)
			end
		end
	end
end

function ZG.VAR.DragonBossCheckForWipe_Astarot(pUnit)
	local found = false
	for _,plr in pairs(pUnit:GetInRangePlayers()) do
		if plr:GetZ() < 143 or plr:GetZ() > 149 then
			plr:Teleport(309, -11070, -2328.8, 150)
			plr:CastSpell(64446) -- teleport visual
		end
		if not found then
			if plr:IsAlive() then
				found = true
			end
		end
	end
	if not found then
		-- wipe
		pUnit:RemoveEvents()
		pUnit:StopChannel()
		pUnit:SetHealth(pUnit:GetMaxHealth())
		local object = pUnit:GetGameObjectNearestCoords(-11095.85, -2318.86, 147.5, 146086) -- cave in
		if object ~= nil then
			object:Despawn(1000, 0)
		end
		for _,unit in pairs(pUnit:GetInRangeUnits()) do
			local entry = unit:GetEntry()
			if entry == 21234 or entry == 871111 or entry == 497111 or entry == 36544 or entry == 4052 then
				unit:StopChannel()
				unit:CancelSpell()
				unit:Despawn(1000,0)
			end
		end
		pUnit:RegisterEvent("ZG.VAR.SetUpCreatures_Dragon", 5000, 1)
	end
end

-- 8289 <- ENOUGH! Now you vermin shall feel the force of my birthright: The Fury of the Earth itself!
-- 8290 <- Burn, you wretches! Burn!
-- 8291 <- Impossible! Rise my minions! Serve your master once more!
-- 8292 <- This cannot be! I am the Master here! You mortals are nothing to my kind! DO YOU HEAR? NOTHING!
-- 8293 <- Worthless wretch! Your friends will join you soon enough!

-- Draconic lords

function ZG.VAR.DRACONICLORDEVENT(pUnit, Event)
	if Event == 1 then
		pUnit:RegisterEvent("ZG.VAR.LordSpamFlameStrike", 10000, 0)
		pUnit:RegisterEvent("ZG.VAR.SummonWhelpsAndSuchLordd", 1100, 0)
	elseif Event == 2 or Event == 4 then
		pUnit:RemoveEvents()
	elseif Event == 18 then
		pUnit:RegisterEvent("ZG.VAR.MoveTowardsEnemyZZLord", 1000, 1)
	end
end

function ZG.VAR.LordSpamFlameStrike(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 2121)
	end
	plr = pUnit:GetMainTank()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 7 then
			pUnit:StopMovement(2500)
			pUnit:FullCastSpellOnTarget(5213, plr)
		end
	end
end

function ZG.VAR.MoveTowardsEnemyZZLord(pUnit)
	if not pUnit:IsInCombat() then
		local plr = pUnit:GetClosestPlayer()
		if plr ~= nil then
			pUnit:SetMovementFlags(1)
			pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
			pUnit:ChangeTarget(plr)
		end
	end
end

function ZG.VAR.SummonWhelpsAndSuchLordd(pUnit)
	if pUnit:GetHealthPct() < 20 then
		local a = pUnit:GetCreatureNearestCoords(-11041, -2334.4, 146.8, 25525)
		local b = pUnit:GetCreatureNearestCoords(-11091, -2332.4, 146.3, 25525)
		if a and b then
			pUnit:RemoveEvents()
			pUnit:Root()
			pUnit:CastSpell(22663) -- immune to all damage
			pUnit:AIDisableCombat(true)
			local ad = pUnit:GetDistanceYards(a)
			local bd = pUnit:GetDistanceYards(b)
			if ad > bd then
				pUnit:ChannelSpell(76221, b)
				pUnit:RegisterEvent("ZG.VAR.HatchEggsBBB", 7500, 1)
			else
				pUnit:ChannelSpell(76221, a)
				pUnit:RegisterEvent("ZG.VAR.HatchEggsAAA", 7500, 1)
			end
		end
	end
end

function ZG.VAR.HatchEggsBBB(pUnit)
	pUnit:RemoveAura(22663)
	pUnit:CastSpell(32711) -- AoE
	pUnit:StopChannel()
	for i=1,math.random(5,12) do
		pUnit:SpawnCreature(497111, -11090.4, -2332, 146.3, 0.206785, 15, 120000)
	end
	pUnit:RegisterEvent("ZG.VAR.KILL_SELF_INSEC", 500, 1)
end

function ZG.VAR.HatchEggsAAA(pUnit)
	pUnit:RemoveAura(22663)
	pUnit:CastSpell(32711) -- AoE
	pUnit:StopChannel()
	for i=1,math.random(5,12) do
		pUnit:SpawnCreature(497111, -11042, -2333.4, 146.7, 2.853576, 15, 120000)
	end
	pUnit:RegisterEvent("ZG.VAR.KILL_SELF_INSEC", 250, 1)
end

function ZG.VAR.KILL_SELF_INSEC(pUnit)
	pUnit:Kill(pUnit)
end

RegisterUnitEvent(871111, 1, "ZG.VAR.DRACONICLORDEVENT")
RegisterUnitEvent(871111, 2, "ZG.VAR.DRACONICLORDEVENT")
RegisterUnitEvent(871111, 4, "ZG.VAR.DRACONICLORDEVENT")
RegisterUnitEvent(871111, 18, "ZG.VAR.DRACONICLORDEVENT")

-- Whelps

function ZG.VAR.WhelpsOverwhelmingDrac(pUnit, Event)
	pUnit:RegisterEvent("ZG.VAR.WHelpsFactionsMove", math.random(900, 2000), 1)
end

function ZG.VAR.WHelpsFactionsMove(pUnit)
	pUnit:SetFaction(21)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
		pUnit:ChangeTarget(plr)
	end
end

RegisterUnitEvent(497111, 18, "ZG.VAR.WhelpsOverwhelmingDrac")

-- avoid these balls

function ZG.VAR.DESEMAGIZAVOID(pUnit)
	if Event == 4 then
		pUnit:RemoveEvents()
	else
		pUnit:RegisterEvent("ZG.VAR.VisualReadyGoGO", 1000, 1)
		pUnit:RegisterEvent("ZG.VAR.MOVETOWARDS_PLAYZ", 1000, 0)
	end
end

function ZG.VAR.VisualReadyGoGO(pUnit)
	pUnit:ChannelSpell(56220, pUnit)
	pUnit:AIDisableCombat(true)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- unselectable
end

function ZG.VAR.MOVETOWARDS_PLAYZ(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if not plr:IsAlive() then
			plr = pUnit:GetRandomPlayer(0)
			if plr ~= nil then
				pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
			end
		else
			local trigger = pUnit:GetCreatureNearestCoords(-11062, -2306, 146, 27942)
			if trigger then
				if trigger:HasAura(63894) then
					if pUnit:GetDistanceYards(trigger) < 12 then
						pUnit:StopMovement(100)
					end
				else
					pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
				end
			end
		end
	end
	for _,plrs in pairs(pUnit:GetInRangeUnits()) do
		if plrs:GetDistanceYards(pUnit) < 8 then
			if plrs:IsPlayer() then
				if pUnit:GetDistanceYards(plrs) < 5 then
					pUnit:Strike(plrs, 2, 59322, 250, 300, 1)
				end
			else
				if plrs:GetEntry() ~= 4052 and plrs:GetEntry() ~= 36544 and plrs:GetEntry() ~= 27942 then
					if not plrs:HasAura(22663) then
						if (plrs:GetHealth()-150) < 1 then
							plrs:Kill(plrs)
						else
							plrs:SetHealth(plrs:GetHealth()-150)
						end
					end
				else
					local choice = math.random(1,11)
					if choice == 1 then
						plrs:SendChatMessage(14,0,"Ugh, get this thing off me!")
					elseif choice == 2 then
						plrs:SendChatMessage(14,0,"It burns!")
					end
				end
			end
		end
	end
end

RegisterUnitEvent(21234, 18, "ZG.VAR.DESEMAGIZAVOID")
RegisterUnitEvent(21234, 4, "ZG.VAR.DESEMAGIZAVOID")

-- The druids


-- if entry == 36544 or entry == 4052 then

function ZG.VAR.MainLeaderSpawn_Event(pUnit, Event)
	if Event == 1 then
		pUnit:Root()
		pUnit:RegisterEvent("ZG.VAR.MainSpells_Dragon_Add", 4000, 0)
	elseif Event == 2 or 4 then
		pUnit:RemoveEvents()
	elseif Event == 18 then
		local plr = pUnit:GetClosestPlayer()
		if plr ~= nil then
			pUnit:SetMovementFlags(1)
			pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
		end
	end
end

function ZG.VAR.MainSpells_Dragon_Add(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(8950, plr) -- starfire
	end
end

RegisterUnitEvent(36544, 1, "ZG.VAR.MainLeaderSpawn_Event")
RegisterUnitEvent(36544, 2, "ZG.VAR.MainLeaderSpawn_Event")
RegisterUnitEvent(36544, 4, "ZG.VAR.MainLeaderSpawn_Event")
RegisterUnitEvent(36544, 18, "ZG.VAR.MainLeaderSpawn_Event")

function ZG.VAR.AddEvent_Dragon(pUnit, Event)
	if Event == 1 then
		pUnit:Root()
		pUnit:RegisterEvent("ZG.VAR.AddSpells_Dragon", 2500, 0)
	elseif Event == 2 or Event == 4 then
		pUnit:RemoveEvents()
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
		if players:HasAchievement(59387) == false then
					players:AddAchievement(59387)
					end
	end
	end
	elseif Event == 18 then
		local plr = pUnit:GetClosestPlayer()
		if plr ~= nil then
			pUnit:SetMovementFlags(1)
			pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
		end
	end
end

function ZG.VAR.AddSpells_Dragon(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(9739, plr) -- Wrath
	end
end

RegisterUnitEvent(4052, 1, "ZG.VAR.AddEvent_Dragon")
RegisterUnitEvent(4052, 2, "ZG.VAR.AddEvent_Dragon")
RegisterUnitEvent(4052, 4, "ZG.VAR.AddEvent_Dragon")
RegisterUnitEvent(4052, 18, "ZG.VAR.AddEvent_Dragon")

-- cinematic

function ZG.VAR.Event_Npc_Spawn_ZG(pUnit, Event)
	pUnit:RegisterEvent("ZG.VAR.SunwellVisual", 1000, 1)
	pUnit:RegisterEvent("ZG.VAR.KeepSunwellVisual", 3000, 0)
end

function ZG.VAR.SunwellVisual(pUnit)
	pUnit:CastSpell(46822)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:GetEntry() == 29191 then
			unit:ChannelSpell(61942, pUnit)
		end
	end
end

function ZG.VAR.KeepSunwellVisual(pUnit)
	pUnit:CastSpell(46822)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if plr:GetDistanceYards(pUnit) < 60 then
			pUnit:RemoveEvents()
			for _,plrs in pairs(pUnit:GetInRangePlayers()) do
				plrs:SendCinematic(244)
				plrs:Root()
				plrs:SetPlayerLock(1)
			end
			pUnit:RegisterEvent("ZG.VAR.EarthSpike1", 12000, 1)
			pUnit:RegisterEvent("ZG.VAR.EarthSpike2", 6000, 1)
			pUnit:RegisterEvent("ZG.VAR.EarthSpike3", 9000, 1)
			pUnit:RegisterEvent("ZG.VAR.EndEventsortOf", 42000, 1)
		end
	end
end

function ZG.VAR.EndEventsortOf(pUnit)
	pUnit:RemoveAura(46822)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if ((unit:GetEntry() == 29191 or unit:GetEntry() == 10477) and unit:IsAlive()) then
			unit:Kill(unit)
		end
	end
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		plrs:Unroot()
		plrs:SetPlayerLock(0)
	end
	pUnit:SpawnCreature(60383, -10949.4, -1985.1, 116.201, 0.805025, 21, 0)
	pUnit:Despawn(5000, 0)
end

function ZG.VAR.EarthSpike1(pUnit)
	local npc = pUnit:GetUnitBySqlId(9278878)
	if npc then
		npc:CastSpell(63548)
		npc:CastSpell(63547)
	end
	pUnit:RegisterEvent("ZG.VAR.KnockbackUnits1", 500, 1)
	-- 9278878
end

function ZG.VAR.EarthSpike2(pUnit)
	local npc = pUnit:GetUnitBySqlId(9278879)
	if npc then
		npc:CastSpell(63548)
		npc:CastSpell(63547)
	end
	pUnit:RegisterEvent("ZG.VAR.KnockbackUnits2", 500, 1)
	-- 9278879
end

function ZG.VAR.EarthSpike3(pUnit)
	local npc = pUnit:GetUnitBySqlId(9278877)
	if npc then
		npc:CastSpell(63548)
		npc:CastSpell(63547)
	end
	pUnit:RegisterEvent("ZG.VAR.KnockbackUnits3", 500, 1)
	-- 9278877
end

local knockbackunits = {nil, nil}

function ZG.VAR.KnockbackUnits1(pUnit)
	local npc = pUnit:GetUnitBySqlId(9278875)
	if npc then
		npc:MoveKnockback(-10929.8, -1959.94, 115.45, 6, 8)
		knockbackunits[1] = npc
	end
	npc = nil
	npc = pUnit:GetUnitBySqlId(9278872)
	if npc then
		npc:MoveKnockback(-10919.2, -1965, 114.909, 6, 8)
		knockbackunits[2] = npc
	end
	pUnit:RegisterEvent("ZG.VAR.KillSelf", 700, 1)
end

function ZG.VAR.KnockbackUnits2(pUnit)
	local npc = pUnit:GetUnitBySqlId(9278868)
	if npc then
		npc:MoveKnockback(-10929.3, -1970.91, 114.915, 6, 8)
		knockbackunits[1] = npc
	end
	npc = nil
	npc = pUnit:GetUnitBySqlId(9278867)
	if npc then
		npc:MoveKnockback(-10922.9, -1984.94, 114.909, 6, 8)
		knockbackunits[2] = npc
	end
	pUnit:RegisterEvent("ZG.VAR.KillSelf", 700, 1)
end

function ZG.VAR.KnockbackUnits3(pUnit)
	local npc = pUnit:GetUnitBySqlId(9278864)
	if npc then
		npc:MoveKnockback(-10955, -1959.32, 115.084, 6, 8)
		knockbackunits[1] = npc
	end
	npc = nil
	npc = pUnit:GetUnitBySqlId(9278862)
	if npc then
		npc:MoveKnockback(-10936.4, -1962.32, 115.899, 6, 8)
		knockbackunits[2] = npc
	end
	pUnit:RegisterEvent("ZG.VAR.KillSelf", 700, 1)
end

function ZG.VAR.KillSelf(pUnit)
	if knockbackunits[1] and knockbackunits[2] then
		knockbackunits[1]:Kill(knockbackunits[1])
		knockbackunits[2]:Kill(knockbackunits[2])
		knockbackunits[1] = nil
		knockbackunits[2] = nil
	end
end

RegisterUnitEvent(63083, 18, "ZG.VAR.Event_Npc_Spawn_ZG")

function ZG.VAR.NecromancerVisualSpawn(pUnit, Event)
	pUnit:RegisterEvent("ZG.VAR.SoulStormVisual", 2000, 1)
end

function ZG.VAR.SoulStormVisual(pUnit)
	local choice = math.random(1,4)
	if choice == 1 then
		pUnit:CastSpell(68886)
	elseif choice == 2 then
		pUnit:CastSpell(68897)
	elseif choice == 3 then
		pUnit:CastSpell(68904)
	elseif choice == 4 then
		pUnit:CastSpell(68906)
	end
	pUnit:RegisterEvent("ZG.VAR.SoulStormVisual", math.random(2000,6000), 1)
end

RegisterUnitEvent(29191, 18, "ZG.VAR.NecromancerVisualSpawn")

function ZG.VAR.EquipWeaponsAndWalkForwards(pUnit)
	pUnit:MoveTo(-10944, -1980, 116, 0.755591)
end

function ZG.VAR.ArchimondeTypeBoss(pUnit, Event)
	if Event == 18 then
		pUnit:EquipWeapons(37360, 0,0)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
		pUnit:RegisterEvent("ZG.VAR.EquipWeaponsAndWalkForwards", 1000, 1)
		pUnit:RegisterEvent("ZG.VAR.ArchiGoHostileEtc", 10000, 1)
	end
end

function ZG.VAR.ArchiGoHostileEtc(pUnit)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

RegisterUnitEvent(60383, 18, "ZG.VAR.ArchimondeTypeBoss")

-- Archi boss

function ZG.VAR.ArchiBossEvents(pUnit, Event)
	if Event == 1 then
		if pUnit:GetHealthPct() > 80 then
			pUnit:PlaySoundToSet(20003)
			pUnit:SendChatMessage(14,0,"Look at this one, standing bravely with earth beneath his feet, thinking to challenge me.")
			pUnit:RegisterEvent("ZG.VAR.MainRandomVisuals", 23000, 0)
			pUnit:RegisterEvent("ZG.VAR.KnockbackCreatureSpawn", 12000, 0)
			pUnit:RegisterEvent("ZG.VAR.PhaseTwoArchi", 2000, 0)
		end
	elseif Event == 2 then
		local found = false
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			if v:IsAlive() then
				found = true
				break
			end
		end
		if not found then
			pUnit:RemoveEvents()
			pUnit:SetHealth(pUnit:GetMaxHealth())
			pUnit:SetPosition(-10944, -1980, 116, 0.755591)
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(10992)
		pUnit:SendChatMessage(14,0,"NO! IT CANNOT BE! NO!")
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 6805 then
				v:Despawn(1,0)
			end
		end
	end
end

function ZG.VAR.KnockbackCreatureSpawn(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if not plr then
		return;
	end
	pUnit:SpawnCreature(71706, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 21, 30000)
end

function ZG.VAR.PhaseTwoArchi(pUnit)
	if pUnit:GetHealthPct() < 80 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"You've got some sting in you, human.")
		pUnit:PlaySoundToSet(20004)
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			v:SetPosition(-10978, -2042, 65, 1.164049)
		end
		pUnit:SetPosition(-10978, -2042, 65, 1.164049)
		pUnit:CastSpell(64446) -- teleport visual
		pUnit:RegisterEvent("ZG.VAR.MainRandomVisuals", 23000, 0)
		pUnit:RegisterEvent("ZG.VAR.FireCirclesArchi", 10000, 0)
		pUnit:RegisterEvent("ZG.VAR.PhaseThreeArchi", 2000, 0)
	end
end

function ZG.VAR.PhaseThreeArchi(pUnit)
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"You make a very tenacious corpse.")
		pUnit:PlaySoundToSet(20005)
		pUnit:RegisterEvent("ZG.VAR.MainRandomVisuals", 11000, 0)
		pUnit:RegisterEvent("ZG.VAR.FireCirclesArchi", 10000, 0)
	end
end

function ZG.VAR.PhaseFourArchi(pUnit)
	if pUnit:GetHealthPct() < 10 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("ZG.VAR.HitEveryoneMentalPhaseArchi", 10000, 0)
		pUnit:RegisterEvent("ZG.VAR.MainRandomVisuals", 6000, 0)
	end
end

function ZG.VAR.FireCirclesArchi(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		local diff = math.random(0,8)
		local diff2 = math.random(0,8)
		local x,y,z = plr:GetX(), plr:GetY(), plr:GetZ()
		pUnit:CastSpellAoF(x+diff,y+diff2,z,33814)
		pUnit:SpawnCreature(6805, x+diff, y+diff2, z, 0, 21, 80000)
		pUnit:SpawnCreature(6805, x-diff, y-diff2, z, 0, 21, 80000)
		pUnit:SpawnCreature(6805, x+diff+2, y+diff2+2, z+1, 0, 21, 80000)
		pUnit:SpawnCreature(6805, x+diff-2, y+diff2-2, z+1, 0, 21, 80000)
		pUnit:SpawnCreature(6805, x+diff+2, y+diff2-2, z+1, 0, 21, 80000)
		pUnit:SpawnCreature(6805, x+diff-2, y+diff2+2, z+1, 0, 21, 80000)
	end
end

function ZG.VAR.HitEveryoneMentalPhaseArchi(pUnit)
	for _,plr in pairs(pUnit:GetInRangePlayers()) do
		local diff = math.random(0,8)
		local diff2 = math.random(0,8)
		local x,y,z = plr:GetX(), plr:GetY(), plr:GetZ()
		pUnit:CastSpellAoF(x+diff,y+diff2,z,33814)
		pUnit:SpawnCreature(6805, x+diff, y+diff2, z, 0, 21, 30000)
		pUnit:SpawnCreature(6805, x-diff, y-diff2, z, 0, 21, 30000)
		pUnit:SpawnCreature(6805, x+diff+2, y+diff2+2, z+1, 0, 21, 30000)
		pUnit:SpawnCreature(6805, x+diff-2, y+diff2-2, z+1, 0, 21, 30000)
		pUnit:SpawnCreature(6805, x+diff+2, y+diff2-2, z+1, 0, 21, 30000)
		pUnit:SpawnCreature(6805, x+diff-2, y+diff2+2, z+1, 0, 21, 30000)
	end
end

RegisterUnitEvent(60383, 1, "ZG.VAR.ArchiBossEvents")
RegisterUnitEvent(60383, 2, "ZG.VAR.ArchiBossEvents")
RegisterUnitEvent(60383, 4, "ZG.VAR.ArchiBossEvents")

function ZG.VAR.FireBallSpawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- unselectable
	pUnit:Root()
	pUnit:SetCombatCapable(false)
	pUnit:RegisterEvent("ZG.VAR.SendFireballVisual", 1000, 1)
	pUnit:RegisterEvent("ZG.VAR.GrowBiggerFireball", 2000, 14)
	pUnit:RegisterEvent("ZG.VAR.FireballExplode", 29000, 1)
end

function ZG.VAR.SendFireballVisual(pUnit)
	pUnit:CastSpell(71706) -- perm visual
	pUnit:CastSpell(74710) -- spawn visual
end

function ZG.VAR.GrowBiggerFireball(pUnit)
	pUnit:SetScale(math.random(7, 17) / 10)
end

function ZG.VAR.FireballExplode(pUnit)

	local x2 = pUnit:GetX()
	local y2 = pUnit:GetY()
	
	pUnit:CastSpell(76010) -- visual
	pUnit:RemoveAura(71706) -- main visual
	
	for _,plr in pairs(pUnit:GetInRangePlayers()) do
		local distance = plr:GetDistanceYards(pUnit)
		if plr:GetPhase() == 2 and distance < 20 then
		
			local minimum = 2000-distance*100
			local maximum = 2000-distance*130
			
			if minimum < 1 then
				minimum = 1
			end
			if maximum < 1 then
				maximum = 1
			end
			
			pUnit:Strike(plr, 2, 695, minimum, maximum, 0.1)		
		
			local x1 = plr:GetX()
			local y1 = plr:GetY()

			local x = x2 - x1
			local y = y2 - y1
			
			local angle = math.pi + math.atan2(-y, -x)

			local x = x1 - ((math.random(25,30)-distance) * math.cos(angle))
			local y = y1 - ((math.random(25,30)-distance) * math.sin(angle))
			
			local z = pUnit:GetLandHeight(x, y)
			if z > 200 or z < 40 then
				z = plr:GetZ()
			end
			
			plr:MoveKnockback(x, y, z, 2, 9)
			
		end
	end
	pUnit:SetFaction(35)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:GetEntry() == 71706 then
			if unit:GetDistanceYards(pUnit) < 20 and unit:GetFaction() == 21 then
				unit:RemoveEvents()
				unit:RegisterEvent("ZG.VAR.FireballExplode", math.random(1,1000), 1)
			end
		end
	end
end

RegisterUnitEvent(71706, 18, "ZG.VAR.FireBallSpawn")

-- Shade of anger

function ZG.VAR.ShadeEvents(pUnit, Event)
	if Event == 1 then
		--pUnit:Root()
		pUnit:SendChatMessage(14,0,"Come, face your corrupted soul!")
		pUnit:CastSpell(64775)
		local id = pUnit:GetInstanceID() or 1
		ZG[id] = ZG[id] or {VAR={}}
		ZG[id].VAR.mirrors = {}
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			v:Root()
		end
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			table.insert(ZG[id].VAR.mirrors, v:SpawnCreature(165, v:GetX(), v:GetY(), v:GetZ(), v:GetO(), 35, 300000))
		end
		local count = 5-#ZG[id].VAR.mirrors
		for i = 1,count,1 do
			if count < 1 then
				break
			end
			local v = pUnit:GetRandomPlayer(0)
			if v then
				table.insert(ZG[id].VAR.mirrors, v:SpawnCreature(165, v:GetX(), v:GetY(), v:GetZ(), v:GetO(), 35, 300000))
			end
		end
		pUnit:RegisterEvent("ZG.VAR.UnrootPlayers", 3000, 1)
		pUnit:RegisterEvent("ZG.VAR.WaitForMirrorsDie", 10000, 0)
	else --if Event == 2 or Event == 4 then
		pUnit:RemoveEvents()
		if pUnit:HasAura(64775) then
			pUnit:RemoveAura(64775)
		end
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 165 then
				v:Despawn(1,0)
			end
		end
	end
end

function ZG.VAR.UnrootPlayers(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		v:Unroot()
	end
end

function ZG.VAR.WaitForMirrorsDie(pUnit)
	local id = pUnit:GetInstanceID() or 1
	ZG[id] = ZG[id] or {VAR={}}
	if ZG[id].VAR.mirrors then
		local found = false
		for _,v in pairs(ZG[id].VAR.mirrors) do
			if v and v:IsAlive() then
				found = true
				break
			end
		end
		if not found then
			pUnit:RemoveEvents()
			pUnit:SendChatMessage(14,0,"Give in to hate.")
			pUnit:RemoveAura(64775)
			pUnit:Unroot()
			for _,v in pairs(pUnit:GetInRangePlayers()) do
				v:SpawnCreature(165, v:GetX(), v:GetY(), v:GetZ(), v:GetO(), 35, 300000)
			end
		else
			local plr = pUnit:GetRandomPlayer(0)
			if plr then
				pUnit:CastSpellOnTarget(38047, plr)
			end
			plr = pUnit:GetRandomPlayer(0)
			if plr then
				pUnit:CastSpellOnTarget(66018, plr)
			end
			pUnit:CastSpell(9081)
		end
	end
end

RegisterUnitEvent(291721, 1, "ZG.VAR.ShadeEvents")
RegisterUnitEvent(291721, 2, "ZG.VAR.ShadeEvents")
RegisterUnitEvent(291721, 4, "ZG.VAR.ShadeEvents")

-- Hack fix, stop people falling down ----------------------------------------

function ZG.VAR.Check_Players_InZG()
	for _,plrs in pairs(GetPlayersInWorld()) do
		if plrs then
			if plrs:GetMapId() == 309 then
				if (plrs:IsAlive() and plrs:GetZ() < 52 and plrs:GetY() > -2135) then
					plrs:SetHealth(1)
					plrs:CastSpell(11)
					plrs:CastSpell(46995) -- visual
					plrs:CastSpell(39180) -- visual
				end
				if (not plrs:HasAura(35480) and not plrs:HasAura(35481)) then -- added female aura
					if plrs:GetGender() == 0 then -- added gender check
						plrs:CastSpell(35480)
					else
						plrs:CastSpell(35481)
					end
				end
			elseif plrs:HasAura(35480) or plrs:HasAura(35481) then
				if plrs:GetGender() == 0 then
					plrs:RemoveAura(35480)
				else
					plrs:RemoveAura(35481)
				end
			elseif plrs:GetMapId() == 578 then
				if (plrs:IsAlive() and plrs:GetZ() < 425 and plrs:GetY() > 450) then
					plrs:Teleport(578,1046,1032,432.516541)
					plrs:CastSpell(51347)
				end
			end
		end
	end
end
	

CreateLuaEvent(ZG.VAR.Check_Players_InZG, 5000, 0)
