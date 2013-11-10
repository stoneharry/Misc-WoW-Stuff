
-- SH might be taken already
ZH = {}
ZH.VAR = {}

local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 

-- First boss vars

local pos = {
	{2124, 402, 2.455638}, -- Player random teleportation coords
	{2121, 424, 3.961246},
	{2105, 430, 4.958695},
	{2095, 414, 0.001251},
	{2104, 398, 1.052896},
	{2104, 398, 1.052896},
	{2104, 398, 1.052896},
	{2104, 398, 1.052896}
}

-------------------------------------
-- First Boss -- Satyre
-------------------------------------

function ZH.VAR.SatyrosToggleGates(pUnit)
	local obj = pUnit:GetGameObjectNearestCoords(2100.26, 390.824, 116.611, 3266385)
	if obj then
		if obj:GetPhase() == 1 then
			obj:SetPhase(2)
		else
			obj:SetPhase(1)
		end
	end
	obj = pUnit:GetGameObjectNearestCoords(2130.22, 432.018, 121.053, 3266385)
	if obj then
		if obj:GetPhase() == 1 then
			obj:SetPhase(2)
		else
			obj:SetPhase(1)
		end
	end	
end

function ZH.VAR.SatyrosEvents(pUnit, Event)
	if Event == 18 then
		pUnit:RegisterEvent("ZH.VAR.SatyrosVisuals", 1000, 1)
	elseif Event == 1 then
		pUnit:StopChannel()
		ZH.VAR.SatyrosToggleGates(pUnit)
		local i = 1
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			v:CastSpell(60427) -- visual
			v:SetPosition(pos[i][1], pos[i][2], 113, pos[i][3])
			i = i + 1
		end
		local plr = pUnit:GetRandomPlayer(0)
		if plr then
			pUnit:ModThreat(plr, 100)
		end
		pUnit:SendChatMessage(12,0,"Ah, you're just in time, the rituals are about to begin!")
		pUnit:PlaySoundToSet(9260)
		pUnit:RegisterEvent("ZH.VAR.SatyrosMainAbility", 1000, 0)
		pUnit:RegisterEvent("ZH.VAR.SatyrosRend", 16000, 0)
		pUnit:RegisterEvent("ZH.VAR.SatyrosRandomTeleport", 10000, 0)
		pUnit:RegisterEvent("ZH.VAR.SatyrosCleave", 15000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		ZH.VAR.SatyrosToggleGates(pUnit)
	 	local id = pUnit:GetInstanceID() or 1
		ZH[id] = ZH[id] or {VAR={}}
		ZH[id].VAR.Dummy1:RemoveAura(52241) -- visual
		ZH[id].VAR.Dummy1:RemoveEvents()
	elseif Event == 3 then
		pUnit:SendChatMessage(12,0,"Please accept this humble offering oh great one.")
		pUnit:PlaySoundToSet(9263)
		pUnit:CastSpell(69882) -- Regrowth
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:StopChannel()
		ZH.VAR.SatyrosToggleGates(pUnit)
		pUnit:SendChatMessage(12,0,"My life, is yours, oh great one.")
		pUnit:PlaySoundToSet(9262)
	 	local id = pUnit:GetInstanceID() or 1
		ZH[id] = ZH[id] or {VAR={}}
		ZH[id].VAR.Dummy1:RemoveAura(52241) -- visual
		ZH[id].VAR.Dummy1:RemoveEvents()
	end
end

function ZH.VAR.SatyrosVisuals(pUnit)
	pUnit:SetPosition(2106.8, 409.55, 112.8, 0.822669)
	pUnit:ChannelSpell(29423, pUnit)
end

function ZH.VAR.SatyrosCleave(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(74367, plr)
	end
end

function ZH.VAR.SatyrosRend(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(43931, plr)
	end
end

function ZH.VAR.SatyrosRandomTeleport(pUnit)
	local plr = pUnit:GetRandomPlayer(7)
	if plr then
		local i = math.random(1,5)
		plr:CancelSpell()
		plr:CastSpell(60427)
		plr:SetPosition(pos[i][1], pos[i][2], 113, pos[i][3])
	end
end

function ZH.VAR.SatyrosMainAbility(pUnit)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12, 0, "Your blood will anoint my circle.")
		pUnit:PlaySoundToSet(9264)
		pUnit:SetPosition(2110, 414, 115, 3.9)
		pUnit:Root()
	 	local id = pUnit:GetInstanceID() or 1
		ZH[id] = ZH[id] or {VAR={}}
		ZH[id].VAR.Dummy1:RegisterEvent("ZH.VAR.MoveAroundPoints", 100, 0)
		pUnit:ChannelSpell(72209, ZH[id].VAR.Dummy1)
		pUnit:DisableMelee(true)
		pUnit:AIDisableCombat(true)
		ZH[id].VAR.Dummy1:CastSpell(52241) -- visual
		ZH[id].VAR.Dummy1:RegisterEvent("ZH.VAR.ZAPzePlayers", 1000, 0)
		pUnit:RegisterEvent("ZH.VAR.StopMainAbility", 30000, 1)
	end
end

function ZH.VAR.StopMainAbility(pUnit)
 	local id = pUnit:GetInstanceID() or 1
	ZH[id] = ZH[id] or {VAR={}}
	ZH[id].VAR.Dummy1:RemoveAura(52241) -- visual
	ZH[id].VAR.Dummy1:RemoveEvents()
	pUnit:DisableMelee(false)
	pUnit:AIDisableCombat(false)
	pUnit:Unroot()
	pUnit:StopChannel()
	local i = 5
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		v:CancelSpell()
		v:CastSpell(60427)
		if i < 1 then
			i = 1
		end
		v:SetPosition(pos[i][1], pos[i][2], 113, pos[i][3])
		i = i - 1
	end
	pUnit:RegisterEvent("ZH.VAR.SatyrosRend", 16000, 0)
	pUnit:RegisterEvent("ZH.VAR.SatyrosRandomTeleport", 10000, 0)
	pUnit:RegisterEvent("ZH.VAR.SatyrosCleave", 8000, 0)
	pUnit:RegisterEvent("ZH.VAR.SatyrosMainAbilityTwo", 1000, 0)
end

function ZH.VAR.SatyrosMainAbilityTwo(pUnit)
	if pUnit:GetHealthPct() < 40 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14, 0, "Come you dwellers of the dark, rally to my call!")
		pUnit:PlaySoundToSet(9265)
		pUnit:SetPosition(2110, 414, 115, 3.9)
		pUnit:Root()
	 	local id = pUnit:GetInstanceID() or 1
		ZH[id] = ZH[id] or {VAR={}}
		ZH[id].VAR.Dummy1:RegisterEvent("ZH.VAR.MoveAroundPoints", 100, 0)
		pUnit:ChannelSpell(72209, ZH[id].VAR.Dummy1)
		pUnit:DisableMelee(true)
		pUnit:AIDisableCombat(true)
		ZH[id].VAR.Dummy1:CastSpell(52241) -- visual
		ZH[id].VAR.Dummy1:RegisterEvent("ZH.VAR.ZAPzePlayers", 1000, 0)
		pUnit:RegisterEvent("ZH.VAR.StopMainAbilityTwo", 30000, 1)
	end
end

function ZH.VAR.StopMainAbilityTwo(pUnit)
 	local id = pUnit:GetInstanceID() or 1
	ZH[id] = ZH[id] or {VAR={}}
	ZH[id].VAR.Dummy1:RemoveAura(52241) -- visual
	ZH[id].VAR.Dummy1:RemoveEvents()
	pUnit:DisableMelee(false)
	pUnit:AIDisableCombat(false)
	pUnit:Unroot()
	pUnit:StopChannel()
	local i = 5
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		v:CancelSpell()
		v:CastSpell(60427)
		if i < 1 then
			i = 1
		end
		v:SetPosition(pos[i][1], pos[i][2], 113, pos[i][3])
		i = i - 1
	end
	pUnit:CastSpell(61369) -- enrage
	pUnit:RegisterEvent("ZH.VAR.SatyrosRend", 16000, 0)
	pUnit:RegisterEvent("ZH.VAR.SatyrosRandomTeleport", 10000, 0)
	pUnit:RegisterEvent("ZH.VAR.SatyrosCleave", 5000, 0)
end

RegisterUnitEvent(216561, 1, "ZH.VAR.SatyrosEvents")
RegisterUnitEvent(216561, 2, "ZH.VAR.SatyrosEvents")
RegisterUnitEvent(216561, 3, "ZH.VAR.SatyrosEvents")
RegisterUnitEvent(216561, 4, "ZH.VAR.SatyrosEvents")
RegisterUnitEvent(216561, 18, "ZH.VAR.SatyrosEvents")

-------------------------------------
-- First Boss Adds
-------------------------------------

function ZH.VAR.SatyrosDummySpawn(pUnit, Event)
	pUnit:RegisterEvent("ZH.VAR.RunDummyRunSatyros", 1000, 1)
end

function ZH.VAR.RunDummyRunSatyros(pUnit)
	pUnit:SetMovementFlags(2)
 	local id = pUnit:GetInstanceID() or 1
	ZH[id] = ZH[id] or {VAR={}}
	ZH[id].VAR.Dummy1 = pUnit
	ZH[id].VAR.points = {}
	ZH[id].VAR.i = 0
	local x = 2110
	local y = 414
	local r = math.pi / 180
	local distance = 13
	for i = 1, 360 do
		local nx = x + (distance * math.cos(i*r))
		local ny = y + (distance * math.sin(i*r))
		ZH[id].VAR.points[i] = {nx, ny}
	end
end

function ZH.VAR.MoveAroundPoints(pUnit)
 	local id = pUnit:GetInstanceID() or 1
	ZH[id] = ZH[id] or {VAR={}}
	ZH[id].VAR.i = ZH[id].VAR.i + 6
	if ZH[id].VAR.i > 359 then
		ZH[id].VAR.i = 1
	end
	pUnit:MoveTo(ZH[id].VAR.points[ZH[id].VAR.i][1], ZH[id].VAR.points[ZH[id].VAR.i][2], 115, 0)
end

function ZH.VAR.ZAPzePlayers(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		pUnit:FullCastSpellOnTarget(42502, v) -- Damage
	end
end

RegisterUnitEvent(802992, 18, "ZH.VAR.SatyrosDummySpawn")

-------------------------------------
-- Second Boss -- Imp
-------------------------------------

function ZH.VAR.XezbethEvents(pUnit, Event)
	if Event == 1 then
		pUnit:PlaySoundToSet(11314)
		pUnit:SendChatMessage(14,0,"Kill! KILL!")
		pUnit:RegisterEvent("ZH.VAR.XexbethPhaseTwo", 1000, 0)
		pUnit:RegisterEvent("ZH.VAR.FelImmolate", 21000, 0)
		pUnit:RegisterEvent("ZH.VAR.FelAoF", 16000, 0)
		pUnit:RegisterEvent("ZH.VAR.FelCleave", 12000, 0)
		pUnit:RegisterEvent("ZH.VAR.StrongFelBall", 21000, 0)
		pUnit:RegisterEvent("ZH.VAR.FelFlames", 17000, 0)
		pUnit:RegisterEvent("ZH.VAR.ChainFelBall", 26000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:SetPosition(2143, 279, 73, 3.338336)
		pUnit:RemoveAura(57764) -- hover aura
		pUnit:Land()
		pUnit:SetMovementFlags(1)
		pUnit:StopChannel()
		pUnit:SetModel(20514)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:RemoveAura(57764) -- hover aura
		pUnit:Land()
		pUnit:SetMovementFlags(1)
		pUnit:StopChannel()
		pUnit:SetModel(20514)
		pUnit:PlaySoundToSet(11317)
	pUnit:SendChatMessage(14,0,"You cannot kill me, fools! I'll be back, I'll...")
	elseif Event == 18 then
		pUnit:SetModel(20514)
	end
end

function ZH.VAR.XexbethPhaseTwo(pUnit)
	if pUnit:GetHealthPct() < 60 then
		pUnit:RemoveEvents()
		pUnit:SetModel(25277)
		pUnit:CastSpell(60427) -- visual
		pUnit:DisableMelee(true)
		pUnit:AIDisableCombat(true)
		pUnit:SetScale(1.5)
		pUnit:Emote(405, 0)
		pUnit:PlaySoundToSet(11307)
		pUnit:SendChatMessage(14,0,"Yes, YES! Ahahah!")
		pUnit:RegisterEvent("ZH.VAR.FlyUpAndAway", 3000, 1)
	end
end

function ZH.VAR.FlyUpAndAway(pUnit)
	pUnit:CastSpell(57764) -- 57764 hover aura
	pUnit:SetMovementFlags(2)
	pUnit:MoveTo(2116.8, 270, 88, 0.377059)
	pUnit:RegisterEvent("ZH.VAR.LazorBeemsEtc", 10000, 5)
	pUnit:RegisterEvent("ZH.VAR.FlyBackDown", 60000, 1) -- le debug
end

function ZH.VAR.LazorBeemsEtc(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if not plr then
		plr = pUnit:GetRandomPlayer(0)
		if not plr then
			return
		end
	end
 	local id = pUnit:GetInstanceID() or 1
	ZH[id] = ZH[id] or {VAR={}}
	ZH[id].VAR.Dummy2 = pUnit:SpawnCreature(116888, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 17, 15000)
	ZH[id].VAR.plr = plr
	pUnit:RegisterEvent("ZH.VAR.FollowZePlayer", 1000, 1)
end

function ZH.VAR.Dummy2Spawn(pUnit, Event)
	pUnit:SetUInt32Value(0x0006 + 0x0035, 0x02000000)
	pUnit:DisableMelee(true)
	pUnit:AIDisableCombat(true)
	pUnit:RegisterEvent("ZH.VAR.SpamFireEtc", 1000, 9)
	pUnit:RegisterEvent("ZH.VAR.SpamFireVisual", 500, 18)
end

function ZH.VAR.SpamFireEtc(pUnit)
	pUnit:SpawnCreature(309981, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 10000)
	--pUnit:CastSpell(50745) -- visual
end

function ZH.VAR.SpamFireVisual(pUnit)
	pUnit:CastSpell(42345)
end

RegisterUnitEvent(116888, 18, "ZH.VAR.Dummy2Spawn")

function ZH.VAR.FollowZePlayer(pUnit)
 	local id = pUnit:GetInstanceID() or 1
	ZH[id] = ZH[id] or {VAR={}}
	if ZH[id].VAR.plr then
		pUnit:ChannelSpell(39908, ZH[id].VAR.Dummy2)
		ZH[id].VAR.Dummy2:SetUnitToFollow(ZH[id].VAR.plr, 0, 1)
	end
end

function ZH.VAR.FlyBackDown(pUnit)
	pUnit:StopChannel()
	pUnit:RemoveEvents()
	pUnit:MoveTo(2132, 276, 73, 0.359880)
	pUnit:RegisterEvent("ZH.VAR.FlyDownTwo", 4000, 1)
end

function ZH.VAR.FlyDownTwo(pUnit)
	pUnit:StopChannel()
	pUnit:RemoveAura(57764) -- hover aura
	pUnit:Land()
	pUnit:SetMovementFlags(1)
	pUnit:Emote(407, 1000)
	pUnit:RegisterEvent("ZH.VAR.EndFlyPhase", 1000, 1)
end

function ZH.VAR.EndFlyPhase(pUnit)
	pUnit:SetModel(20514)
	pUnit:CastSpell(60427) -- visual
	pUnit:DisableMelee(false)
	pUnit:AIDisableCombat(false)
	pUnit:SetMovementFlags(1)
	pUnit:SetScale(1)
	if pUnit:GetHealthPct() > 35 then
		pUnit:RegisterEvent("ZH.VAR.CheckPhase2Again", 1000, 0)
	end
	pUnit:RegisterEvent("ZH.VAR.FelImmolate", 10000, 0)
	pUnit:RegisterEvent("ZH.VAR.FelAoF", 16000, 0)
	pUnit:RegisterEvent("ZH.VAR.FelCleave", 12000, 0)
	pUnit:RegisterEvent("ZH.VAR.StrongFelBall", 23000, 0)
	pUnit:RegisterEvent("ZH.VAR.FelFlames", 17000, 0)
	pUnit:RegisterEvent("ZH.VAR.ChainFelBall", 26000, 0)
end

function ZH.VAR.CheckPhase2Again(pUnit)
	if pUnit:GetHealthPct() < 35 then
		pUnit:RemoveEvents()
		pUnit:SetModel(25277)
		pUnit:PlaySoundToSet(11306)
		pUnit:SendChatMessage(14,0,"I have no equal.")
		pUnit:CastSpell(60427) -- visual
		pUnit:DisableMelee(true)
		pUnit:AIDisableCombat(true)
		pUnit:SetScale(1.5)
		pUnit:Emote(405, 0)
		pUnit:RegisterEvent("ZH.VAR.FlyUpAndAway", 3000, 1)
	end
end

function ZH.VAR.FelImmolate(pUnit)
	if pUnit:IsCasting() then
		return
	end
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:CastSpellOnTarget(50059, plr)
	end
end

function ZH.VAR.FelAoF(pUnit)
	if pUnit:IsCasting() then
		return
	end
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 39429)
	end
end

function ZH.VAR.FelCleave(pUnit)
	if pUnit:IsCasting() then
		return
	end
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(38742, plr)
	end
end

function ZH.VAR.StrongFelBall(pUnit)
	if pUnit:IsCasting() then
		return
	end
	for _, players in pairs(pUnit:GetInRangePlayers()) do
	if not players:IsDead() then
		pUnit:CastSpellOnTarget(39054, players)
		end
	end
end

function ZH.VAR.FelFlames(pUnit)
	if pUnit:IsCasting() then
		return
	end
	pUnit:FullCastSpell(37488)
	pUnit:SetMana(pUnit:GetMaxMana())
end

function ZH.VAR.ChainFelBall(pUnit)
	--[[ -- Disabled for some reason
	if pUnit:IsCasting() then
		return
	end
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(36404, plr)
	end
	]]
end

RegisterUnitEvent(143801, 1, "ZH.VAR.XezbethEvents")
RegisterUnitEvent(143801, 2, "ZH.VAR.XezbethEvents")
RegisterUnitEvent(143801, 4, "ZH.VAR.XezbethEvents")
RegisterUnitEvent(143801, 18, "ZH.VAR.XezbethEvents")

-------------------------------------
-- Trash
-------------------------------------

-- 50491 Felguard
-- 50492 Felhunter
-- 168881 Imp

function ZH.VAR.TrashEvents(pUnit, Event)
	if Event == 1 then
		local entry = pUnit:GetEntry()
		if entry == 50492 then
			pUnit:RegisterEvent("ZH.VAR.ManaDrainStrike", 6000, 0)
		elseif entry == 50491 then
			pUnit:RegisterEvent("ZH.VAR.KnockdownPlayer", 7000, 0)
			pUnit:RegisterEvent("ZH.VAR.AncientFury", 8000, 1)
		elseif entry == 168881 then
			ZH.VAR.SpamFirebolt(pUnit)
			pUnit:RegisterEvent("ZH.VAR.SpamFirebolt", 4000, 0)
		end
	elseif Event == 2 or Event == 4 then
		pUnit:RemoveEvents()
	end
end


function ZH.VAR.AncientFury(pUnit,Event)
pUnit:CastSpell(61575)
pUnit:RegisterEvent("ZH.VAR.AncientFury", 14000, 1)
end


function ZH.VAR.ManaDrainStrike(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(15695, plr)
	end
end

function ZH.VAR.KnockdownPlayer(pUnit)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(46183, plr)
	end
end

function ZH.VAR.SpamFirebolt(pUnit)
	local plr
	if math.random(1,2) == 1 then
		plr = pUnit:GetClosestPlayer()
	else
		plr = pUnit:GetRandomPlayer(0)
	end
	if plr then
		if plr:IsAlive() then
			pUnit:StopMovement(3500)
			pUnit:FullCastSpellOnTarget(7802, plr)
		end
	end
end

RegisterUnitEvent(50491, 1, "ZH.VAR.TrashEvents")
RegisterUnitEvent(50491, 2, "ZH.VAR.TrashEvents")
RegisterUnitEvent(50491, 4, "ZH.VAR.TrashEvents")
RegisterUnitEvent(50492, 1, "ZH.VAR.TrashEvents")
RegisterUnitEvent(50492, 2, "ZH.VAR.TrashEvents")
RegisterUnitEvent(50492, 4, "ZH.VAR.TrashEvents")
RegisterUnitEvent(168881, 1, "ZH.VAR.TrashEvents")
RegisterUnitEvent(168881, 2, "ZH.VAR.TrashEvents")
RegisterUnitEvent(168881, 4, "ZH.VAR.TrashEvents")

-------------------------------------
-- Unbound Dreadlord
-------------------------------------

function ZH.VAR.DreadlordSpawn(pUnit, Event)
	if Event == 4 then
		pUnit:RemoveEvents()
		return
	end
	pUnit:SetUInt32Value(0x0006 + 0x0035, 0x00040000) -- Do not turn
	pUnit:RegisterEvent("ZH.VAR.SummonVisualD", 1500, 0)
end

local s_x1 = 2165
local s_x2 = 2207
local s_y1 = 312
local s_y2 = 325

function ZH.VAR.SummonVisualD(pUnit)
	pUnit:CastSpell(46172) -- visual
	pUnit:SpawnCreature(278041, math.random(s_x1, s_x2), math.random(s_y1, s_y2), 99.6, 0, 21, 60000, 0, 0, 0, 2)
end

RegisterUnitEvent(276101, 18, "ZH.VAR.DreadlordSpawn")
RegisterUnitEvent(276101, 4, "ZH.VAR.DreadlordSpawn")

function ZH.VAR.Ghoulsp(pUnit, Event)
	pUnit:SetUInt32Value(0x0006 + 0x0035, 2) -- unattackable
	pUnit:SetUInt32Value(0x0006 + 0x0044, 9) -- underground
	pUnit:RegisterEvent("ZH.VAR.SpawnFromGround", 2000, 1)
	pUnit:RegisterEvent("ZH.VAR.SpawnFdPhase", 1000, 1)
end

function ZH.VAR.SpawnFdPhase(pUnit)
	pUnit:SetPhase(1)
	pUnit:AIDisableCombat(true)
end

function ZH.VAR.SpawnFromGround(pUnit)
	pUnit:SetUInt32Value(0x0006 + 0x0044, 0)
	pUnit:RegisterEvent("ZH.VAR.MoveAttackable", 4000, 1)
end

function ZH.VAR.MoveAttackable(pUnit)
	pUnit:SetUInt32Value(0x0006 + 0x0035, 0)
	pUnit:MoveTo(2179, 346, 98.82, 0)
	pUnit:RegisterEvent("ZH.VAR.CheckIfNearBoss", 1000, 0)
end

function ZH.VAR.CheckIfNearBoss(pUnit)
	local boss = pUnit:GetCreatureNearestCoords(2179, 346, 98.8, 276101)
	if not boss then
		pUnit:Kill(pUnit)
		return
	end
	if pUnit:GetDistanceYards(boss) < 6 then
		pUnit:Kill(pUnit)
	end
	if not boss:IsInCombat() then
		return
	end
	local plr = pUnit:GetRandomPlayer(0)
	if plr and plr:GetDistanceYards(pUnit) < 60 then
		boss:CastSpellOnTarget(686, plr)
	end
end

RegisterUnitEvent(278041, 18, "ZH.VAR.Ghoulsp")

-------------------------------------
-- The last boss - W/E
-------------------------------------

function ZH.VAR.LBossE(pUnit, Event)
	if Event == 1 then
		pUnit:SendChatMessage(14,0,"You may have defeated my followers but you shall not be able to prevent me putting a stop to your foolish conquest!")
		pUnit:RegisterEvent("ZH.VAR.INCOMINGROCKS", 40000, 0)
		pUnit:RegisterEvent("ZH.VAR.BoneSlice", 11000, 0)
		pUnit:RegisterEvent("ZH.VAR.FlamingShield", 30000, 0)
		pUnit:RegisterEvent("ZH.VAR.LBPhase2", 1000, 0)
		pUnit:FullCastSpell(37941)
	else
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() == 165 then
				v:Despawn(1,0)
			end
		end
		pUnit:RemoveEvents()
		if Event == 4 then
			for _,v in pairs(pUnit:GetInRangePlayers()) do
				if v:HasQuest(6800) then
					v:MarkQuestObjectiveAsComplete(6800, 0)
				end
			end
		end
	end
end

function ZH.VAR.BoneSlice(pUnit)
	local t = pUnit:GetMainTank()
	if t then
		pUnit:FullCastSpellOnTarget(70814, t)
	end
end

function ZH.VAR.INCOMINGROCKS(pUnit)
	pUnit:Root()
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		v:CastSpell(36455)
		if pUnit:GetDistanceYards(v) < 5 then
			pUnit:CastSpellOnTarget(60868, v) -- knockback
		end
	end
	for _,v in pairs(pUnit:GetInRangeUnits()) do
		if v:GetEntry() == 205971 then
			v:CastSpell(37098)
		end
	end
	pUnit:RegisterEvent("ZH.VAR.StrikeNearbyP", 1000, 10)
	pUnit:RegisterEvent("ZH.VAR.Unroot", 4000, 1)
end

function ZH.VAR.Unroot(pUnit)
	pUnit:Unroot()
end

function ZH.VAR.StrikeNearbyP(pUnit)
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		pUnit:Strike(plrs, 2, 1535, 50, 50, 1)
	end
end

function ZH.VAR.FlamingShield(pUnit)
	pUnit:FullCastSpell(37941)
end

function ZH.VAR.LBPhase2(pUnit)
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"I will not be defeated so easily!")
		pUnit:RegisterEvent("ZH.VAR.INCOMINGROCKS", 60000, 0)
		pUnit:RegisterEvent("ZH.VAR.BoneSlice", 10000, 0)
		pUnit:RegisterEvent("ZH.VAR.FlamingShield", 28000, 0)
		pUnit:RegisterEvent("ZH.VAR.SummonAddM", 20000, 0)
		-----
		pUnit:RegisterEvent("ZH.VAR.FelImmolate", 11000, 0)
		pUnit:RegisterEvent("ZH.VAR.FelAoF", 16000, 0)
		pUnit:RegisterEvent("ZH.VAR.SatyrosRend", 16000, 0)
		pUnit:RegisterEvent("ZH.VAR.SatyrosCleave", 17000, 0)
	end
end

function ZH.VAR.SummonAddM(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		pUnit:SpawnCreature(165, plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 21, 120000)
	end
end

RegisterUnitEvent(207131, 1, "ZH.VAR.LBossE")
RegisterUnitEvent(207131, 4, "ZH.VAR.LBossE")
RegisterUnitEvent(207131, 2, "ZH.VAR.LBossE")

-------------------------------------
-- Trash
-------------------------------------

function ZH.VAR.Putridus_Shadowstalker(pUnit,Event)
	if Event == 1 then
		pUnit:RegisterEvent("ZH.VAR.PSSS", 4000, 0)
	elseif Event == 2 or Event == 4 then
		pUnit:RemoveEvents()
	elseif Event == 18 then
		pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
		pUnit:EquipWeapons(32369,32369,0)
		pUnit:SetMaxPower(100,3)
		pUnit:SetPower(100,3)	
		pUnit:SetPowerType(3)
	end
end
	
	
function ZH.VAR.PSSS(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 5 then
			if tank:HasAura(50050) then
				pUnit:CastSpellOnTarget(50071,tank)
			else
				pUnit:CastSpellOnTarget(50050,tank)
			end
		end
	end
end
	
RegisterUnitEvent(11792, 18, "ZH.VAR.Putridus_Shadowstalker")
RegisterUnitEvent(11792, 4, "ZH.VAR.Putridus_Shadowstalker")
RegisterUnitEvent(11792, 1, "ZH.VAR.Putridus_Shadowstalker")
RegisterUnitEvent(11792, 2, "ZH.VAR.Putridus_Shadowstalker")


function ZH.VAR.DH_OVERSEER(pUnit,Event)
if Event == 1 then
		pUnit:RegisterEvent("ZH.VAR.FelFlames", 17000, 0)
		pUnit:RegisterEvent("ZH.VAR.ChainFelBall", 14000, 0)
		pUnit:RegisterEvent("ZH.VAR.DH_FORM", 19000, 0)
pUnit:RegisterEvent("ZH.VAR.DH_FORM",1000, 0)
local choice = math.random(1,5)
	if choice == 1 then
	pUnit:SendChatMessage(12,0,"The training has ended, kill them my students!")
	elseif choice == 2 then
	pUnit:SendChatMessage(12,0,"Intruders, slay them!")
	end
elseif Event == 2 or Event == 4 then
pUnit:RemoveEvents()
pUnit:RemoveAura(59672)
end
	end
	
function ZH.VAR.DH_FORM(pUnit,Event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("ZH.VAR.FelFlames", 17000, 0)
		pUnit:RegisterEvent("ZH.VAR.ChainFelBall", 19000, 0)
		pUnit:CastSpell(59672)
		local choice = math.random(1,6)
		if choice == 1 then
			pUnit:SendChatMessage(12,0,"Feel my fury!")
		elseif choice == 2 then
			pUnit:SendChatMessage(12,0,"The power within!")
		end
	end
end
	
RegisterUnitEvent(21179, 4, "ZH.VAR.DH_OVERSEER")
RegisterUnitEvent(21179, 1, "ZH.VAR.DH_OVERSEER")
RegisterUnitEvent(21179, 2, "ZH.VAR.DH_OVERSEER")