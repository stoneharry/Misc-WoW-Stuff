
SM = {}
SM.VAR = {}

local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074

function SM.VAR.ScarletShooter(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:EquipWeapons(0, 0, 31416)
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 2)
	pUnit:RegisterEvent("SM.VAR.SM_ShootNearbyPlayers", 3000, 1)
end

function SM.VAR.SM_ShootNearbyPlayers(pUnit)
	pUnit:Emote(384, 3000)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		local distance = plr:GetDistanceYards(pUnit)
		if distance < 46 and plr:IsAlive() then
			if distance < 10 then
				pUnit:RegisterEvent("SM.VAR.SM_ShooterTransform", 1000, 1)
			else
				pUnit:SetPosition(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:CalcRadAngle(pUnit:GetX(), pUnit:GetY(), plr:GetX(), plr:GetY()))
				pUnit:FullCastSpellOnTarget(53348, plr)
				pUnit:RegisterEvent("SM.VAR.SM_ShootNearbyPlayers", 3000, 1)
			end
		else
			pUnit:RegisterEvent("SM.VAR.SM_ShootNearbyPlayers", 1000, 1)
		end
	else
		pUnit:RegisterEvent("SM.VAR.SM_ShootNearbyPlayers", 3000, 1)
	end
end

function SM.VAR.SM_ShooterTransform(pUnit)
	pUnit:EquipWeapons(44638, 1200, 0)
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

RegisterUnitEvent(1827, 18, "SM.VAR.ScarletShooter")

function SM.VAR.ScarletFirstBoss(pUnit, Event)
	if Event == 18 then
		pUnit:SpawnCreature(1827, 1698, -367, 18, 3, 2089, 0)
		pUnit:SpawnCreature(1827, 1698, -361, 18, 3.124, 2089, 0)
		pUnit:SpawnCreature(1827, 1698, -358, 18, 3, 2089, 0)
		pUnit:SpawnCreature(1827, 1699, -354, 18, 3.18, 2089, 0)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
		pUnit:EquipWeapons(43875, 51533, 41746)
		pUnit:SetPosition(1702, -363.7, 18, 3)
		pUnit:RegisterEvent("SM.VAR.FindSMShooters", 1000, 0)
	elseif Event == 1 then
		pUnit:RegisterEvent("SM.VAR.AvengersShield", 12000, 0)
		pUnit:RegisterEvent("SM.VAR.HolyJudgement", 35000, 0)
		pUnit:RegisterEvent("SM.VAR.HammerOfBetrayal", 40000, 0)
		pUnit:RegisterEvent("SM.VAR.UnholyPresence", 60000, 1)
		pUnit:RegisterEvent("SM.VAR.UnholyGrowth", 2000, 0)
		pUnit:RegisterEvent("SM.VAR.ThrowShield", 8000, 0)
		pUnit:RegisterEvent("SM.VAR.SignalBombingRun", 45000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		if pUnit:HasAura(40545) then
			pUnit:RemoveAura(40545)
		end
		if pUnit:HasAura(69144) then
			pUnit:RemoveAura(69144)
		end
	elseif Event == 4 then
		if pUnit:HasAura(40545) then
			pUnit:RemoveAura(40545)
		end
		if pUnit:HasAura(69144) then
			pUnit:RemoveAura(69144)
		end
		pUnit:RemoveEvents()
		local cannon = pUnit:GetCreatureNearestCoords(1678.5, -348.6, 18, 314611)
		if cannon then
			cannon:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		end
	end
end

function SM.VAR.UnholyPresence(pUnit)
	pUnit:CastSpell(55222)
end

function SM.VAR.HammerOfBetrayal(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:WipeCurrentTarget()
		pUnit:FullCastSpellOnTarget(13005, plr)
	end
end

function SM.VAR.HolyJudgement(pUnit)
	pUnit:FullCastSpell(67364)
	pUnit:PlaySoundToSet(5831)
	pUnit:SendChatMessage(14,0,"Is that all?")
end

function SM.VAR.AvengersShield(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:SetMana(math.random(6000, 8000))
		pUnit:FullCastSpellOnTarget(32699, tank) -- avengers shield
	end
end

function SM.VAR.UnholyGrowth(pUnit)
	if pUnit:GetHealthPct() < 30 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"Blades of light!")
		pUnit:PlaySoundToSet(5832)
		pUnit:FullCastSpell(40545)
		pUnit:RegisterEvent("SM.VAR.UnholyGrowthTrigger", 10500, 1)
	end
end

function SM.VAR.ThrowShield(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		pUnit:FullCastSpellOnTarget(73076, plr)
	end
end

function SM.VAR.UnholyGrowthTrigger(pUnit)
	if not pUnit:HasAura(40545) then
		pUnit:CastSpell(40545)
	end
	if not pUnit:HasAura(55222) then
		pUnit:CastSpell(55222)
	end
	pUnit:PlaySoundToSet(5833)
	pUnit:SendChatMessage(14,0,"Light, give me strength!")
	pUnit:CastSpell(69144) -- visual
	pUnit:FullCastSpell(58153) -- heal
	pUnit:RegisterEvent("SM.VAR.AvengersShield", 12000, 0)
	pUnit:RegisterEvent("SM.VAR.HolyJudgement", 35000, 0)
	pUnit:RegisterEvent("SM.VAR.ThrowShield", 8000, 0)
	pUnit:RegisterEvent("SM.VAR.HammerOfBetrayal", 40000, 0)
	pUnit:RegisterEvent("SM.VAR.SignalBombingRun", 30000, 0)
end

function SM.VAR.SignalBombingRun(pUnit)
	local plr = pUnit:GetRandomPlayer(7)
	if plr then
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		SM[id] = SM[id] or {VAR={}}
		SM[id].VAR.plr = nil
		SM[id].VAR.plr = plr
		plr:CastSpell(46459)
		pUnit:SendChatMessage(42,0,"Lord McCree is about to launch an attack on "..plr:GetName().."!")
		pUnit:RegisterEvent("SM.VAR.BombingRun", 7000, 1)
	end
end

function SM.VAR.BombingRun(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SM[id] = SM[id] or {VAR={}}
	local plr = SM[id].VAR.plr
	if plr then
		if plr:HasAura(46459) then
			plr:RemoveAura(46459)
		end
		pUnit:RegisterEvent("SM.VAR.BombingRunShoot", 1000, 5)
	end
end

function SM.VAR.BombingRunShoot(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SM[id] = SM[id] or {VAR={}}
	local plr = SM[id].VAR.plr
	if plr then
		pUnit:FullCastSpellOnTarget(53348, plr)
	end
end

function SM.VAR.FindSMShooters(pUnit)
	local found = false
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:GetEntry() == 1827 and unit:IsAlive() then
			found = true
			break
		end
	end
	if not found then
		pUnit:RemoveEvents()
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		pUnit:PlaySoundToSet(5830)
		pUnit:SendChatMessage(14,0,"Ah - I've been waiting for a real challenge!")
		pUnit:FullCastSpell(53790) -- defensive stance
	end
end

RegisterUnitEvent(28964, 18, "SM.VAR.ScarletFirstBoss")
RegisterUnitEvent(28964, 1, "SM.VAR.ScarletFirstBoss")
RegisterUnitEvent(28964, 2, "SM.VAR.ScarletFirstBoss")
RegisterUnitEvent(28964, 4, "SM.VAR.ScarletFirstBoss")

function SM.VAR.CannonScarletGo(pUnit, event, player)
	pUnit:GossipCreateMenu(4111, player, 0)
	pUnit:GossipMenuAddItem(9, "Use the cannon.", 246, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end

function SM.VAR.CannonScarletAc(pUnit, event, player, id, intid, code)
	if(intid == 246) then
		pUnit:SetNPCFlags(2)
		player:GossipComplete()
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		SM[id] = SM[id] or {VAR={}}
		SM[id].VAR.cannon = true
	elseif(intid == 250) then
		player:GossipComplete()
	end
end

function SM.VAR.CheckForMove(pUnit, Event)
	pUnit:RegisterEvent("SM.VAR.CheckForCannonMove", 1000, 0)
end

function SM.VAR.CheckForCannonMove(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SM[id] = SM[id] or {VAR={}}
	if SM[id].VAR.cannon then
		pUnit:RemoveEvents()
		pUnit:MoveTo(1678, -363, 18, 6.26)
		pUnit:RegisterEvent("SM.VAR.CannonPrepare", 6000, 1)		
	end
end

function SM.VAR.CannonPrepare(pUnit)
	pUnit:MoveTo(1683.8, -363, 18, 6.27)
	pUnit:RegisterEvent("SM.VAR.SMFireCannon", 3000, 1)
end

function SM.VAR.SMFireCannon(pUnit)
	pUnit:CastSpellAoF(1715, -363, 18, 52539)
	pUnit:RegisterEvent("SM.VAR.SMDestroyDoor", 1000, 1)
end

function SM.VAR.SMDestroyDoor(pUnit)
	local object = pUnit:GetGameObjectNearestCoords(1716, -363, 18, 16397)
	if object then
		object:SetByte(0x0006+0x000B,0,2)
	end
end

RegisterUnitGossipEvent(314611, 1, "SM.VAR.CannonScarletGo")
RegisterUnitGossipEvent(314611, 2, "SM.VAR.CannonScarletAc")
RegisterUnitEvent(314611, 18, "SM.VAR.CheckForMove")

-- Trash

-- 64000 -- friar
-- 64001 -- mage
-- 64002 -- hunter
-- 64003 -- champion


function SM.VAR.TrashEvents(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	local entry = pUnit:GetEntry()
	if Event == 18 then
		if entry == 64000 then
			pUnit:EquipWeapons(3415, 0, 0)
		elseif entry == 64001 then
			pUnit:EquipWeapons(873, 0, 0)
		elseif entry == 64002 then
			pUnit:EquipWeapons(36677, 0, 3742)
		elseif entry == 64003 then
			pUnit:EquipWeapons(12764, 0, 0)
		end
	elseif Event == 4 or Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 1 then
		if entry == 64000 then
			SM.VAR.HealerAIEtc(pUnit)
			pUnit:RegisterEvent("SM.VAR.HealerAIEtc", 7000, 0)
		elseif entry == 64001 then
			pUnit:RegisterEvent("SM.VAR.FireballsFrostboltsMage", 10000, 0)
		elseif entry == 64002 then
			-- Uhhhh...
		elseif entry == 64003 then
			pUnit:RegisterEvent("SM.VAR.ChargeAround", 15000, 0)
			SM.VAR.ChargeAround(pUnit)
		end	
	end
end

function SM.VAR.FireballsFrostboltsMage(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(18809, plr)
	end
end

function SM.VAR.ChargeAround(pUnit)
	if math.random(1,2) == 1 then
		local plr = pUnit:GetRandomPlayer(0)
		if plr then
			pUnit:FullCastSpellOnTarget(65927, plr) -- charge
		end
	else
		pUnit:FullCastSpell(42496) -- roar
	end
end

function SM.VAR.HealerAIEtc(pUnit)
	local found = false
	for _,target in pairs(pUnit:GetInRangeUnits()) do
		if target:IsAlive() then
			if not target:IsPlayer() then
				if target:GetHealthPct() < 80 then
					if target:GetDistanceYards(pUnit) < 30 then
						pUnit:FullCastSpell(10960) -- heal
						found = true
						break
					end
				end
			end
		end
	end
	if not found then
		local plr = pUnit:GetMainTank()
		if plr ~= nil then
			if plr:GetDistanceYards(pUnit) < 30 then
				pUnit:FullCastSpellOnTarget(15266, plr) -- holy fire
			end
		end
	end
end

RegisterUnitEvent(64000, 1, "SM.VAR.TrashEvents")
RegisterUnitEvent(64000, 2, "SM.VAR.TrashEvents")
RegisterUnitEvent(64000, 4, "SM.VAR.TrashEvents")
RegisterUnitEvent(64000, 18, "SM.VAR.TrashEvents")
RegisterUnitEvent(64001, 1, "SM.VAR.TrashEvents")
RegisterUnitEvent(64001, 2, "SM.VAR.TrashEvents")
RegisterUnitEvent(64001, 4, "SM.VAR.TrashEvents")
RegisterUnitEvent(64001, 18, "SM.VAR.TrashEvents")
RegisterUnitEvent(64002, 1, "SM.VAR.TrashEvents")
RegisterUnitEvent(64002, 2, "SM.VAR.TrashEvents")
RegisterUnitEvent(64002, 4, "SM.VAR.TrashEvents")
RegisterUnitEvent(64002, 18, "SM.VAR.TrashEvents")
RegisterUnitEvent(64003, 1, "SM.VAR.TrashEvents")
RegisterUnitEvent(64003, 2, "SM.VAR.TrashEvents")
RegisterUnitEvent(64003, 4, "SM.VAR.TrashEvents")
RegisterUnitEvent(64003, 18, "SM.VAR.TrashEvents")

function SM.VAR.TheEvilRabbit(pUnit)
	pUnit:RegisterEvent("SM.VAR.SpawnFirstBossr", 1000, 1)
end

function SM.VAR.SpawnFirstBossr(pUnit)
	pUnit:SpawnCreature(28964, 1705, -363.9, 18.6, 2.925794, 2089, 0)
end

RegisterUnitEvent(18078, 18, "SM.VAR.TheEvilRabbit")

-- Last boss

function SM.VAR.SMFinalBoss(pUnit, Event)
	if Event == 1 then
		pUnit:EquipWeapons(12000, 0, 0)
		pUnit:SendChatMessage(14,0,"Finally, a worthy challenge!")
		local object = pUnit:GetGameObjectNearestCoords(1933.41, -431.589, 18.6784, 101854)
		if object then
			object:SetByte(0x0006+0x000B,0,1)
		end
		SM.VAR.MistsStuff(pUnit)
		pUnit:RegisterEvent("SM.VAR.ResetCombatAndJumpToPlayer", 30000, 0)
		pUnit:RegisterEvent("SM.VAR.MistsStuff", 16000, 0)
		pUnit:RegisterEvent("SM.VAR.WhirlWind", 7000, 0)
		pUnit:RegisterEvent("SM.VAR.SMEnrage", 50000, 0)
		pUnit:RegisterEvent("SM.VAR.STormCloud", 60000, 0)
		pUnit:RegisterEvent("SM.VAR.MaggotsEverywhereM", 40000, 0)
		pUnit:RegisterEvent("SM.VAR.JUMPTOTHEHEAVENS", 1000, 0)
	elseif Event == 2 or Event == 4 then
		local object = pUnit:GetGameObjectNearestCoords(1933.41, -431.589, 18.6784, 101854)
		if object then
			object:SetByte(0x0006+0x000B,0,0)
		end
		pUnit:RemoveEvents()
	elseif Event == 18 then
		pUnit:EquipWeapons(12000, 0, 0)
	end
end

function SM.VAR.JUMPTOTHEHEAVENS(pUnit)
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("SM.VAR.ResetCombatAndJumpToPlayer", 5000, 0)
		pUnit:RegisterEvent("SM.VAR.GetReadytoGoGoGO", 21000, 1)
	end
end

function SM.VAR.GetReadytoGoGoGO(pUnit)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("SM.VAR.ResetCombatAndJumpToPlayer", 30000, 0)
	pUnit:RegisterEvent("SM.VAR.MistsStuff", 17000, 0)
	pUnit:RegisterEvent("SM.VAR.WhirlWind", 6000, 0)
	pUnit:RegisterEvent("SM.VAR.SMEnrage", 40000, 0)
	pUnit:RegisterEvent("SM.VAR.STormCloud", 90000, 0)
	pUnit:RegisterEvent("SM.VAR.MaggotsEverywhereM", 28000, 0)	
end

function SM.VAR.MaggotsEverywhereM(pUnit)
	for _,plr in pairs(pUnit:GetInRangePlayers()) do
		pUnit:SpawnCreature(16030, plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 21, 30000)
	end
end

function SM.VAR.STormCloud(pUnit)
	local plr = pUnit:GetRandomPlayer(7)
	if plr then
		pUnit:FullCastSpellOnTarget(65123, plr)
	end
end

function SM.VAR.SMEnrage(pUnit)
	pUnit:FullCastSpell(66759)
end

function SM.VAR.MistsStuff(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(67022, plr)
	end
end

function SM.VAR.WhirlWind(pUnit)
	pUnit:FullCastSpell(67716)
end

function SM.VAR.ResetCombatAndJumpToPlayer(pUnit)
	local plr = pUnit:GetRandomPlayer(7)
	if plr then
		pUnit:CastSpell(64172) -- visual
		pUnit:FullCastSpellOnTarget(52206, plr)
	else
		local count = 0
		for _,plrs in pairs(pUnit:GetInRangePlayers()) do
			count = count + 1
		end
		if count < 2 then
			plr = pUnit:GetMainTank()
			if plr then
				for i=0,5 do
					pUnit:FullCastSpellOnTarget(11, plr)
				end
			end
		end
	end
end

RegisterUnitEvent(109110, 1, "SM.VAR.SMFinalBoss")
RegisterUnitEvent(109110, 2, "SM.VAR.SMFinalBoss")
RegisterUnitEvent(109110, 4, "SM.VAR.SMFinalBoss")
RegisterUnitEvent(109110, 18, "SM.VAR.SMFinalBoss")