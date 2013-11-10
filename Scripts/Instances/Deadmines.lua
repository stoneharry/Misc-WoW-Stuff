
DM = {}
DM.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FLAG_STUNNED = 0x00040000

SetDBCSpellVar(47591, "c_is_flags", 0x01000)
SetDBCSpellVar(70827, "c_is_flags", 0x01000)

-- First Boss -----------------------------------------------------------------------------

function DM.VAR.FirstBossCombat(pUnit, Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	pUnit:SetScale(1.2)
	pUnit:SendChatMessage(12,0,"The entertainment has arrived!")
	pUnit:PlaySoundToSet(13472)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0) -- Reset flags, bug?
	pUnit:RegisterEvent("DM.VAR.CheckHealthPctFirst", 2500, 0)
	pUnit:RegisterEvent("DM.VAR.Firstbossrandomspells", 1000, 0)
end

function DM.VAR.SpawnCatapult(pUnit, event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- Untargetable
end

RegisterUnitEvent(27881, 18, "DM.VAR.SpawnCatapult")

function DM.VAR.CheckHealthPctFirst(pUnit)
	if pUnit:GetHealthPct() < 50 then
		pUnit:SetScale(1)
		pUnit:SendChatMessage(12,0,"Say hello to some little friends of mine!")
		pUnit:PlaySoundToSet(13476)
		pUnit:RemoveEvents()
		--pUnit:SpawnCreature(116862, -192, -451, 55, 0, 35, 360000)
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		DM[id] = DM[id] or {VAR={}}
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2) -- unattackable
		pUnit:DisableMelee(true)
		local vehicle = pUnit:GetCreatureNearestCoords(-204.6, -446, 53.8, 27881)
		vehicle:SetUInt32Value(UNIT_FIELD_FLAGS, 0) -- Targetable
		pUnit:EnterVehicle(vehicle, 1000)
		vehicle:RegisterEvent("DM.VAR.launchmissilesvehicle", 4000, 0)
		pUnit:RegisterEvent("DM.VAR.THrowbombsAtPlayersFirst", 7500, 0)
	end
end

--[[function visualslimespawn(pUnit, event)
	pUnit:FullCastSpell(70343) -- visual
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- Untargetable
	pUnit:RegisterEvent("CastVisualsetcfaeo", 1000, 1)
end

function CastVisualsetcfaeo(pUnit)
	pUnit:CastSpell(70343) -- visual
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- Untargetable
end

RegisterUnitEvent(116862, 18, "visualslimespawn")]]

function DM.VAR.launchmissilesvehicle(pUnit)
	if pUnit then
		if pUnit:IsAlive() then
			local plr = pUnit:GetRandomPlayer(0)
			if plr ~= nil then
				pUnit:CastSpellOnTarget(9796, plr) -- poison
				pUnit:FullCastSpellOnTarget(48211, plr) -- fire at target
			end
		else
			pUnit:RemoveEvents()
			pUnit:Despawn(2000, 0)
		end
	end
end

function DM.VAR.THrowbombsAtPlayersFirst(pUnit)
	if pUnit:GetVehicleBase() == nil then
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0) -- attackable
		pUnit:DisableMelee(false)
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(13473)
		pUnit:SendChatMessage(12,0,"The fun is just beginning!")
		--pUnit:CastSpell(53212) -- visual
		pUnit:SetScale(1.2)
		pUnit:RegisterEvent("DM.VAR.Firstbossrandomspells", 5000, 0)
	else
		if pUnit:GetVehicleBase():IsAlive() then
			local pla = pUnit:GetRandomPlayer(0)
			if pla ~= nil then
				--pUnit:CastSpellOnTarget(4068, plr) -- grenade
				pUnit:CastSpellAoF(pla:GetX(), pla:GetY(), pla:GetZ(), 4068)
			end
		else
			pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0) -- attackable
			pUnit:DisableMelee(false)
			pUnit:RemoveEvents()
			pUnit:ExitVehicle()
			pUnit:PlaySoundToSet(13473)
			pUnit:SendChatMessage(12,0,"The fun is just beginning!")
			--pUnit:CastSpell(53212) -- visual
			pUnit:SetScale(1.2)
			pUnit:RegisterEvent("DM.VAR.Firstbossrandomspells", 1000, 0)
		end
	end
end

function DM.VAR.Firstbossrandomspells(pUnit)
	local choice = math.random(1,3)
	if choice == 1 then
		local plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			pUnit:CastSpellOnTarget(3396, plr) -- poison
		end
	elseif choice == 2 then
		local plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			pUnit:CastSpellOnTarget(744, plr) -- poison
		end	
	elseif choice == 3 then
		local plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			pUnit:CastSpellOnTarget(5208, plr) -- poison
		end	
	end
end

function DM.VAR.FirstBossDone(pUnit, Event)
	--if Event == 2 then
	if pUnit:IsAlive() then
		pUnit:RemoveEvents()
		pUnit:Despawn(3000,3000)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0) -- attackable
		pUnit:DisableMelee(false)
		--[[local slime = pUnit:GetCreatureNearestCoords(-192, -451, 54.5, 116862)
		slime:RemoveAura(70343) -- visual]]
		if pUnit:GetVehicleBase() ~= nil then
			pUnit:GetVehicleBase():RemoveEvents()
			pUnit:GetVehicleBase():SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
			pUnit:ExitVehicle()
		end
	else
		pUnit:RemoveEvents()
		--[[pUnit:GetCreatureNearestCoords(-192, -451, 54.5, 116862):RemoveAura(70343) -- visual
		pUnit:GetCreatureNearestCoords(-192, -451, 54.5, 116862):Despawn(5000, 0)]]
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0) -- attackable
		pUnit:DisableMelee(false)
		--local slime = pUnit:GetCreatureNearestCoords(-192, -451, 54.5, 116862)
		--slime:RemoveAura(70343) -- visual
		if pUnit:GetVehicleBase() ~= nil then
			pUnit:GetVehicleBase():RemoveEvents()
			pUnit:GetVehicleBase():SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
			pUnit:ExitVehicle()
		end
	end
end

function DM.VAR.FIRSTBOSS_DEAD(pUnit,Event)
	pUnit:GetGameObjectNearestCoords(-191.6, -456.4, 54.5, 13965):SetByte(GAMEOBJECT_BYTES_1,0,0) -- open door
	local Scourgelord = pUnit:SpawnCreature(6941, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 10000)
	Scourgelord:SendChatMessage(14,0,"Intruders have entered the master's domain, signal the alarms!")
	Scourgelord:PlaySoundToSet(16747)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	DM[id].VAR.teleportcount = 1
end

function DM.VAR.FIRSTBOSSOnSpawn(pUnit,Event)
	pUnit:RegisterEvent("DM.VAR.FirstBossReset", 3000,1)
end

function DM.VAR.FirstBossReset(pUnit,Event)
	if pUnit:GetVehicleBase() ~= nil then
		pUnit:GetVehicleBase():RemoveEvents()
		pUnit:GetVehicleBase():SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		pUnit:ExitVehicle()
	end
	pUnit:ReturnToSpawnPoint()
end


RegisterUnitEvent(253201, 1, "DM.VAR.FirstBossCombat")
RegisterUnitEvent(253201, 2, "DM.VAR.FirstBossDone")
RegisterUnitEvent(253201, 4, "DM.VAR.FirstBossDone")
RegisterUnitEvent(253201, 4, "DM.VAR.FIRSTBOSS_DEAD")
RegisterUnitEvent(253201, 18, "DM.VAR.FIRSTBOSSOnSpawn")


-- Second boss -----------------------------------------------------------------------------

function DM.VAR.SecondBossCombat(pUnit, Event)
	pUnit:RegisterEvent("DM.VAR.FreezeCurrentTarget", 8000, 0)
	pUnit:RegisterEvent("DM.VAR.PullTargetToSpider", 5000, 0)
	pUnit:RegisterEvent("DM.VAR.FreezeAllTargetsSpider", 17000, 0)
	pUnit:RegisterEvent("DM.VAR.StompNearbyPlayers", math.random(1000, 21000), 1)
	pUnit:RegisterEvent("DM.VAR.TrapPlayerInCoCoon", 25000, 0)
	pUnit:RegisterEvent("DM.VAR.ENrangeNearLowHealth", 5000, 0)
end

function DM.VAR.FreezeCurrentTarget(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(15471, plr) -- Stun for 8 seconds
	end
end

function DM.VAR.PullTargetToSpider(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		local cacoon = pUnit:GetCreatureNearestCoords(plr:GetX(), plr:GetY(), plr:GetZ(), 249252)
		if cacoon ~= nil then
			if plr:GetDistanceYards(cacoon) < 3 then
				-- do nothing
			else
				pUnit:FullCastSpellOnTarget(28434, plr) -- Pull player to npc
			end
		else
			pUnit:FullCastSpellOnTarget(28434, plr) -- Pull player to npc
		end
	end
end

function DM.VAR.FreezeAllTargetsSpider(pUnit)
	pUnit:CastSpell(56632) -- Freeze all nearby (root)
end

function DM.VAR.StompNearbyPlayers(pUnit)
	pUnit:CastSpell(11681) -- damage nearby players (hellfire effect)
	pUnit:RegisterEvent("DM.VAR.StompNearbyPlayers", math.random(1000, 21000), 1)
end

function DM.VAR.ENrangeNearLowHealth(pUnit)
	if pUnit:GetHealthPct() < 30 then
		pUnit:CastSpell(42705) -- Enrage (stacks)
		pUnit:CastSpell(30494) -- damage nearby people and slow
		pUnit:CastSpell(56741) -- visual
	end
end

function DM.VAR.TrapPlayerInCoCoon(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		local cacoon = pUnit:GetCreatureNearestCoords(plr:GetX(), plr:GetY(), plr:GetZ(), 249252)
		if cacoon ~= nil then
			if plr:GetDistanceYards(cacoon) < 3 then
				-- Re-register?
			else
				pUnit:SendChatMessage(42,0, plr:GetName().." has been trapped in a cacoon!")
				plr:Root()
				plr:SetScale(0.5)
				plr:SetPlayerLock(true)
				pUnit:SpawnCreature(249252, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 21, 120000)
			end
		else
			pUnit:SendChatMessage(42,0, plr:GetName().." has been trapped in a cacoon!")
			plr:Root()
			plr:SetScale(0.5)
			plr:SetPlayerLock(true)
			pUnit:SpawnCreature(249252, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 21, 120000)
		end
	end
end

-- Cocoon

function DM.VAR.TrappedCheckerRegisterTLDR(pUnit, Event)
	pUnit:RegisterEvent("DM.VAR.TrappedPlayerSpawnCheckTLDR", 1000, 0)
end

function DM.VAR.TrappedPlayerSpawnCheckTLDR(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if ((pUnit:GetHealthPct() < 5) or (not plr:IsAlive())) then
			pUnit:RemoveEvents()
			plr:Unroot()
			plr:SetScale(1)
			plr:SetPlayerLock(false)
			pUnit:Emote(387, 1000)
			pUnit:Despawn(100, 0)
		else
			pUnit:Strike(plr, 2, 70569, 40, 80, 1.2)
		end
	end
end

RegisterUnitEvent(249252, 18, "DM.VAR.TrappedCheckerRegisterTLDR")

function DM.VAR.SeocndBossDone(pUnit, Event)
	pUnit:RemoveEvents()
	if (Event == 4) then
		pUnit:GetGameObjectNearestCoords(-290.4, -535.8, 49.5, 16400):SetByte(GAMEOBJECT_BYTES_1,0,0) -- open door
	end
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	DM[id].VAR.teleportcount = 2
end

RegisterUnitEvent(279761, 1, "DM.VAR.SecondBossCombat")
RegisterUnitEvent(279761, 2, "DM.VAR.SeocndBossDone")
RegisterUnitEvent(279761, 4, "DM.VAR.SeocndBossDone")

-- Third boss -----------------------------------------------------------------------------

function DM.VAR.FORGE_SHOCKWAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"Defend yourself, for all the good it will do!")
pUnit:PlaySoundToSet(14151)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:AIDisableCombat(true)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
DM[id].VAR.Shock = pUnit:GetRandomPlayer(0)
if pUnit:GetDistanceYards(DM[id].VAR.Shock) < 30 then
if DM[id].VAR.Shock:IsDead() == false then
pUnit:SetFacing(DM[id].VAR.Shock:GetO())
pUnit:SendChatMessageToPlayer(42,0,"Forgemaster Arkvoth Targets YOU!", DM[id].VAR.Shock)
pUnit:SendChatMessage(42,0,"Forgemaster Arkvoth Begins to Cast \124cff71d5ff\124Hspell:58977\124h[Shockwave]\124h\124r")
pUnit:Root()
pUnit:RegisterEvent("DM.VAR.FORGE_SHOCKWAVECAST", 2000,1)
else
DM[id].VAR.Shock = nil
end
end
end

function DM.VAR.FORGE_SHOCKWAVECAST(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
pUnit:SetFacing(0)
pUnit:CastSpellOnTarget(58977,DM[id].VAR.Shock)
pUnit:Emote(37,1200)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:AIDisableCombat(false)
DM[id].VAR.Shock = nil
 pUnit:RegisterEvent("DM.VAR.FORGE_Unroot", 1000,1)
 pUnit:RegisterEvent("DM.VAR.FORGE_SHOCKWAVE", 16000,0)
pUnit:RegisterEvent("DM.VAR.FORGE_FIREPATCH", 6000,0)
pUnit:RegisterEvent("DM.VAR.FORGE_FIRECHARGE", 10000,0)
pUnit:RegisterEvent("DM.VAR.FORGE_HASAURA", 2000,0)
end

function DM.VAR.FORGE_Unroot(pUnit,Event)
pUnit:Unroot()
pUnit:SetFacing(1)
end

function DM.VAR.FORGE_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"How can it be...? Flesh is not... stronger!")
pUnit:PlaySoundToSet(14156)
pUnit:Unroot()
pUnit:GetGameObjectNearestCoords(-169.5, -580.5, 19.31, 16399):SetByte(GAMEOBJECT_BYTES_1,0,0)
local Scourgelord = pUnit:SpawnCreature(6937, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 10000)
Scourgelord:SendChatMessage(14,0,"Another shall take his place, you waste your time!")
Scourgelord:PlaySoundToSet(16752)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	DM[id].VAR.teleportcount = 3
end



function DM.VAR.SPEAKERDUMMY_OnSpawn(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:RegisterEvent("DM.VAR.SPEAKERDUMMYCheckingForPlayer",1200,0)
end

RegisterUnitEvent(6938, 18, "DM.VAR.SPEAKERDUMMY_OnSpawn")


function DM.VAR.SPEAKERDUMMYCheckingForPlayer(pUnit,Event)
player = pUnit:GetClosestPlayer()
if player ~= nil then
if pUnit:GetDistanceYards(player) < 5 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"Rimefang! Trap them within the tunnel! Bury them alive!")
pUnit:PlaySoundToSet(17311)
pUnit:PlaySoundToSet(16757)
local General = pUnit:GetCreatureNearestCoords(-101.88,-664.099,7.4, 6904)
General:RegisterEvent("DM.VAR.LOOPMUSIC",22000,0)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
players:CastSpell(69235)
players:Emote(431,4000)
end
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 6748 or creatures:GetEntry() == 6900 then 
	creatures:SetPhase(1)
		end
	end
	for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 6948 then 
	creatures:SetPhase(1)
	creatures:Emote(449, 4000)
		end
	end
end
	end
		end

function DM.VAR.LOOPMUSIC(pUnit,Event)
pUnit:PlaySoundToSet(17311)
pUnit:PlaySoundToSet(15886)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
players:CastSpell(69235)
end
end


function DM.VAR.AMBUSH_MONSTER_OnSpawn(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:RegisterEvent("DM.VAR.AMBUSH_MONSTER_CheckingForPlayer",1200,0)
end

RegisterUnitEvent(6944, 18, "DM.VAR.AMBUSH_MONSTER_OnSpawn")


function DM.VAR.AMBUSH_MONSTER_CheckingForPlayer(pUnit,Event)
player = pUnit:GetClosestPlayer()
if player ~= nil then
if pUnit:GetDistanceYards(player) < 5 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"Persistent whelps! You will not reach the entrance of my lord's lair! Soldiers, destory them!")
pUnit:PlaySoundToSet(17311)
pUnit:PlaySoundToSet(16756)
pUnit:SpawnCreature(6945, -23.33, -794.71, 19.78, 0.58, 14, 0)
pUnit:SpawnCreature(6945, -20.93, -798.76, 20.01, 0.58, 14, 0)
 pUnit:SpawnCreature(6945, -16.55,-789.55,16.075, 0.69, 14, 0) --second tier
pUnit:SpawnCreature(6945, -13.57,-793.15,15.98, 0.69, 14, 0) -- second tier
pUnit:SpawnCreature(6945, -6.42,-781.78,10.51, 0.65, 14, 0) -- front tier
pUnit:SpawnCreature(6945, -3.46,-785.61,10.48, 0.65, 14, 0) -- front tier
end
end
end

function DM.VAR.FALLENWARRIOR_OnSpawn(pUnit,Event) -- event npcs
pUnit:EquipWeapons(50290,40400,0)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
pUnit:RegisterEvent("DM.VAR.RAISE_EMOTE",200,1)
end

function DM.VAR.RAISE_EMOTE(pUnit,Event)
pUnit:Emote(449, 4000)
pUnit:RegisterEvent("DM.VAR.SETFACTION_AFTER_EMOTE",4200,1)
end

function DM.VAR.SETFACTION_AFTER_EMOTE(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:Emote(45,300000)
end

RegisterUnitEvent(6945, 18, "DM.VAR.FALLENWARRIOR_OnSpawn")

function DM.VAR.FALLENWARRIORz_OnSpawn(pUnit,Event) -- static npc
pUnit:EquipWeapons(50290,40400,0)
end

RegisterUnitEvent(6948, 18, "DM.VAR.FALLENWARRIORz_OnSpawn")


function DM.VAR.FORGE_COMBAT(pUnit,Event)
pUnit:SendChatMessage(14,0,"I am the greatest of my father's sons! Your end has come!")
pUnit:PlaySoundToSet(14149)
pUnit:RegisterEvent("DM.VAR.FORGE_SHOCKWAVE", 16000,0)
pUnit:RegisterEvent("DM.VAR.FORGE_FIREPATCH", 6000,0)
pUnit:RegisterEvent("DM.VAR.FORGE_FIRECHARGE", 10000,0)
pUnit:RegisterEvent("DM.VAR.FORGE_HASAURA", 2000,0)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	DM[id].VAR.loststacks = false
end

function DM.VAR.FORGE_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:AIDisableCombat(false)
 pUnit:Despawn(3000,4000)
 for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 6899 then 
	creatures:Despawn(1,0)
	end
 end
	end

function DM.VAR.FORGE_FIREPATCH(pUnit,Event)
pUnit:CastSpell(19823)
pUnit:Emote(37,1200)
 pUnit:SpawnCreature(6805, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 15000)
end


function DM.VAR.FORGE_FIRECHARGE(pUnit,Event)
local plr = pUnit:GetRandomPlayer(7)
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 30 then
			if plr:IsDead() == false then
			pUnit:FullCastSpellOnTarget(33971,plr)
			pUnit:TeleportCreature(plr:GetX(),plr:GetY(),plr:GetZ())
			pUnit:RegisterEvent("DM.VAR.FORGE_FIRECHARGEPLANT", 1500,1)
			end
		end
	end
end

function DM.VAR.FORGE_FIRECHARGEPLANT(pUnit,Event)
pUnit:CastSpell(60290)
pUnit:SpawnCreature(6805, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 15000)
end

function DM.VAR.FORGE_SLAY(pUnit,Event)
	if math.random(1,3) <= 1 then
	pUnit:PlaySoundToSet(14153)
	pUnit:SendChatMessage(14,0,"So ends your curse!")
	elseif math.random(1,3) <= 2 then
	pUnit:PlaySoundToSet(14154)
	pUnit:SendChatMessage(14,0,"Flesh... is... weak!")
	elseif math.random(1,3) <= 3 then
	pUnit:PlaySoundToSet(14155)
	pUnit:SendChatMessage(14,0,"Bolvin umyol marnjar.")
	end
end

 RegisterUnitEvent(6888, 1, "DM.VAR.FORGE_COMBAT")
RegisterUnitEvent(6888, 2, "DM.VAR.FORGE_LEAVE")
RegisterUnitEvent(6888, 4, "DM.VAR.FORGE_DEAD")
RegisterUnitEvent(6888, 3, "DM.VAR.FORGE_SLAY")



function DM.VAR.STEAMSURGE_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SpawnCreature(6812, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 15000)
pUnit:SpawnCreature(6805, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 18000)
end

RegisterUnitEvent(6899, 4, "DM.VAR.STEAMSURGE_DEAD")

function DM.VAR.FireDummyDamage(pUnit,Event)
 pUnit:CastSpell(42345)
 local plrs = pUnit:GetInRangePlayers()
 if plrs and #plrs ~= 0 then
  for _,players in pairs(plrs) do
	if pUnit:GetDistanceYards(players) < 3.5 then
		if players:IsDead() == false then
			pUnit:Strike(players,1,5679,250,300,1)
		end
	end
	end
 end
end
  
  
  function DM.VAR.FireDummyENEMY(pUnit,Event)
local Forge = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 6888)
	if Forge ~= nil then
		if pUnit:GetDistanceYards(Forge) < 5 then
			if Forge:IsAlive() then
			local tank = Forge:GetMainTank()
				if tank ~= nil then
				tank:CastSpellOnTarget(61509,Forge)
				local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	if DM[id].VAR.Stacks == nil then DM[id].VAR.Stacks = 0 end
				DM[id].VAR.Stacks = DM[id].VAR.Stacks + 1
				end
			end
		end
	end
 end
  
  function DM.VAR.FireDummySpawn(pUnit,Event)
  pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("DM.VAR.FireDummyDamage",1000,0) 
   pUnit:RegisterEvent("DM.VAR.FireDummyENEMY",2000,0) 
  pUnit:CastSpell(42345)
  end
  
 function DM.VAR.FORGE_HASAURA(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	if DM[id].VAR.Stacks == nil then DM[id].VAR.Stacks = 0 end
	-- if he has aura
		--if pUnit:HasAura(61509) == true then
		local stacks = pUnit:GetAuraStackCount(61509)
		if stacks > 0 then
		DM[id].VAR.loststacks = true
		end
		-- add to stacks
		-- if stacks more than 0, cast spell
			if stacks >= 1 then
			-- cast spell
				local PlayersAllAround = pUnit:GetInRangePlayers()
				for a, players in pairs(PlayersAllAround) do
					if pUnit:GetDistanceYards(players) < 20 then
						if players:IsAlive() == true then
						if stacks == 1 then -- Damage increases with stacks
							pUnit:CastSpellOnTarget(13878,players)
							elseif stacks == 2 then
							pUnit:CastSpellOnTarget(2948,players)
							elseif stacks == 3 then
							pUnit:CastSpellOnTarget(8444,players)
							elseif stacks == 4 then
							pUnit:CastSpellOnTarget(8445,players)
							elseif stacks == 5 then
							pUnit:CastSpellOnTarget(8446,players)
							elseif stacks == 6 then
							pUnit:CastSpellOnTarget(10205,players)
							elseif stacks == 7 then
							pUnit:CastSpellOnTarget(10206,players)
							elseif stacks >= 8 then
							pUnit:CastSpellOnTarget(10207,players)
						  end
					   end
					end
				end
			else
		-- if more than one stack, spawn adds
			if pUnit:HasAura(61509) == false then
				if DM[id].VAR.loststacks and stacks == 0 then
			-- spawn creature on nearby players
				stacks = 0
				DM[id].VAR.loststacks = false
									pUnit:SendChatMessage(14,0,"GRAAAAAH! Behold the fury of iron and steel!")
pUnit:PlaySoundToSet(14152)
				local PlayersAllAround = pUnit:GetInRangePlayers()
				for a, players in pairs(PlayersAllAround) do
					if pUnit:GetDistanceYards(players) < 40 then
						pUnit:SpawnCreature(6899, players:GetX(), players:GetY(), players:GetZ(), 0, 14, 320000)
						pUnit:SpawnCreature(6899, players:GetX(), players:GetY(), players:GetZ(), 0, 14, 320000)
						pUnit:SpawnCreature(6812, players:GetX(), players:GetY(), players:GetZ(), 0, 35, 15000)
					end
				end
			end
		end
	end
 end
 
  
  RegisterUnitEvent(6805, 18, "DM.VAR.FireDummySpawn")
  
  -- Fourth Boss - Scourgelord----------------------
  
function DM.VAR.MARKPLAYER(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	if DM[id].VAR.Icetombed == nil then
		DM[id].VAR.Icetombed = pUnit:GetRandomPlayer(0)
		if DM[id].VAR.Icetombed ~= nil then
			pUnit:CastSpellOnTarget(70126,DM[id].VAR.Icetombed)
			pUnit:RegisterEvent("DM.VAR.TrapPlayerInIce", 10000, 0)
		end
	else
		DM[id].VAR.Icetombed = nil
		DM[id].VAR.Icetombed = pUnit:GetRandomPlayer(0)
		if DM[id].VAR.Icetombed ~= nil then
			pUnit:CastSpellOnTarget(70126,DM[id].VAR.Icetombed)
			pUnit:RegisterEvent("DM.VAR.TrapPlayerInIce", 10000, 0)
		end
	end
end

function DM.VAR.TrapPlayerInIce(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	if DM[id].VAR.Icetombed ~= nil then
		local Ice = pUnit:GetCreatureNearestCoords(DM[id].VAR.Icetombed:GetX(), DM[id].VAR.Icetombed:GetY(), DM[id].VAR.Icetombed:GetZ(), 6951)
		if Ice ~= nil then
			if DM[id].VAR.Icetombed:GetDistanceYards(Ice) < 3 then
			else
				pUnit:SendChatMessage(42,0, DM[id].VAR.Icetombed:GetName().." has been trapped in a block of Ice!")
				DM[id].VAR.Icetombed:Root()
				DM[id].VAR.Icetombed:SetPlayerLock(true)
				DM[id].VAR.Icetombed:DisableSpells(true)
				pUnit:SpawnCreature(6951, DM[id].VAR.Icetombed:GetX(), DM[id].VAR.Icetombed:GetY(), DM[id].VAR.Icetombed:GetZ(), 0, 21, 120000)
				pUnit:CastSpellOnTarget(63487,DM[id].VAR.Icetombed)
				local PlayersAllAround = DM[id].VAR.Icetombed:GetInRangePlayers()
				for a, players in pairs(PlayersAllAround) do
					if DM[id].VAR.Icetombed:GetDistanceYards(players) < 5 then
						players:Root()
						players:SetPlayerLock(true)
						players:DisableSpells(true)
						pUnit:SpawnCreature(6951, players:GetX(), players:GetY(), players:GetZ(), 0, 21, 120000)
					end
				end
			end
		else
			pUnit:SendChatMessage(42,0, DM[id].VAR.Icetombed:GetName().." has been trapped in a block of Ice!")
			DM[id].VAR.Icetombed:Root()
			DM[id].VAR.Icetombed:SetPlayerLock(true)
			DM[id].VAR.Icetombed:DisableSpells(true)
			pUnit:SpawnCreature(6951, DM[id].VAR.Icetombed:GetX(), DM[id].VAR.Icetombed:GetY(), DM[id].VAR.Icetombed:GetZ(), 0, 21, 120000)
			pUnit:CastSpellOnTarget(63487,DM[id].VAR.Icetombed)
			local PlayersAllAround = DM[id].VAR.Icetombed:GetInRangePlayers()
			for a, players in pairs(PlayersAllAround) do
				if DM[id].VAR.Icetombed:GetDistanceYards(players) < 5 then
					players:Root()
					players:SetPlayerLock(true)
					players:DisableSpells(true)
					pUnit:SpawnCreature(6951, players:GetX(), players:GetY(), players:GetZ(), 0, 21, 120000)
				end
			end
		end
	end
end

-- Ice block

function DM.VAR.TrappedICECheckerRegisterTLDR(pUnit, Event)
	pUnit:RegisterEvent("DM.VAR.TrappedICEPlayerSpawnCheckTLDR", 1000, 0)
end

function DM.VAR.TrappedICEPlayerSpawnCheckTLDR(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if ((pUnit:GetHealthPct() < 5) or (not plr:IsAlive())) then
			pUnit:RemoveEvents()
			plr:Unroot()
			plr:SetPlayerLock(false)
			plr:DisableSpells(false)
			pUnit:Emote(387, 1000)
			pUnit:Despawn(100, 0)
		else
			pUnit:Strike(plr, 2, 70569, 75, 150, 1.2)
		end
	end
end

RegisterUnitEvent(6951, 18, "DM.VAR.TrappedICECheckerRegisterTLDR")



function DM.VAR.SCOURGELORD_OVERWHELMING(pUnit,Event)
pUnit:CastSpell(69167)
pUnit:SendChatMessage(42,0,"Scourgelord Aulus roars and swells with dark might!")
pUnit:PlaySoundToSet(16765)
pUnit:EquipWeapons(49623,0,0)
pUnit:SendChatMessage(14,0,"Power... overwhelming!")
pUnit:RegisterEvent("DM.VAR.SCOURGELORD_DEPOWER", 10000, 1)
end

function DM.VAR.SCOURGELORD_DEPOWER(pUnit,Event)
pUnit:EquipWeapons(49888,0,0)
pUnit:RegisterEvent("DM.VAR.SCOURGELORD_OVERWHELMING", 13000, 1)
end

function DM.VAR.SCOURGELORD_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:EquipWeapons(49888,0,0)
pUnit:Despawn(3000,7000)
end

function DM.VAR.SCOURGELORD_DEAD(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	DM[id].VAR.SCOURGELORDISDEAD = 1
pUnit:RemoveEvents()
pUnit:PlaySoundToSet(16763)
pUnit:SendChatMessage(14,0,"Impossible! Rimefang...Warn...-")
pUnit:SpawnCreature(40333, -107.76, -909.58, 27.70, 1.13, 35, 0)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 40333 then
	creatures:SetModel(9331)
	creatures:SendChatMessage(14,0,"Heroes, we must defeat the Frost Queen. Your transport is a bit impatient and tempered, so hurry up!")
	end
end
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	DM[id].VAR.teleportcount = 4
end

function DM.VAR.SCOURGELORD_COMBAT(pUnit,Event)
pUnit:SendChatMessage(14,0,"I shall not fail The Lich King! Come and meet your end!")
pUnit:PlaySoundToSet(16760)
pUnit:RegisterEvent("DM.VAR.MARKPLAYER", 31000, 0)
pUnit:RegisterEvent("DM.VAR.SCOURGELORD_OVERWHELMING", 14000, 1)
end

 RegisterUnitEvent(6934, 1, "DM.VAR.SCOURGELORD_COMBAT")
RegisterUnitEvent(6934, 2, "DM.VAR.SCOURGELORD_LEAVE")
RegisterUnitEvent(6934, 4, "DM.VAR.SCOURGELORD_DEAD")
  
-- Last Boss - Dragon --------------------------------------------------------------------

function DM.VAR.LastBossSPAWNS(pUnit, Event)
	if pUnit:HasAura(60534) then
		pUnit:RemoveAura(60534) -- flying
	end
	pUnit:SetHealth(pUnit:GetMaxHealth())
	--pUnit:CastSpell(41292) -- regen aura temp
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2) -- Unkillable
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 3) -- Sleep
	pUnit:RegisterEvent("DM.VAR.SpamEmoteForPlayersWhoAreDelayed", 1000, 0)
end

function DM.VAR.SpamEmoteForPlayersWhoAreDelayed(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if plr:IsAlive() then
			if pUnit:GetDistanceYards(plr) < 30 then
				pUnit:RemoveEvents()
				--pUnit:CastSpell(41292) -- regen aura temp
				pUnit:SpawnGameObject(201385, 95.7, -815.85, 131.12, 1.478113, 900000, 100):SetUInt32Value(0x0006+0x0003,0x1) -- Unclickable -- ice wall
				pUnit:SendChatMessage(14,0,"Your incursion ends here - none shall surive!")
				pUnit:PlaySoundToSet(17012) -- sound
				pUnit:PlaySoundToSet(17311) -- epic music
				pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 0) -- Get Up
				pUnit:SetMovementFlags(2) -- This creature flies
				pUnit:RegisterEvent("DM.VAR.FinalBossFlyIntoAirVisual", 4000, 1)
				pUnit:RegisterEvent("DM.VAR.FinalBossFlyIntoAirPermanent", 6950, 1)
			else
				pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2) -- Unkillable
				pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 3) -- Sleep
			end
		end
	end
end

function DM.VAR.FinalBossFlyIntoAirVisual(pUnit)
	pUnit:Emote(448, 3000) -- Fly into the air
end

function DM.VAR.FinalBossFlyIntoAirPermanent(pUnit)
	pUnit:CastSpell(60534)
	pUnit:SetPosition(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+15, pUnit:GetO())
	pUnit:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+0.1, 0)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	DM[id].VAR.finali = 0
	pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 500, 1)
end

function DM.VAR.HandleEventsAsTheyHappenLast(pUnit)
 	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	if DM[id].VAR.finali == nil then 
		DM[id].VAR.finali = 0
	end
	if DM[id].VAR.finali == 0 then
		pUnit:SetMovementFlags(2)
		pUnit:FullCastSpell(3129) -- Frost breath
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 500, 1)
	elseif DM[id].VAR.finali == 1 then
		for place,players in pairs(pUnit:GetInRangePlayers()) do
			players:CastSpell(47591) -- Freeze self
		end
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 2000, 1)
	elseif DM[id].VAR.finali == 2 then
		pUnit:MoveTo(64.7, -763.6, 142, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 3 then
		pUnit:MoveTo(82.8, -765, 140, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 4 then
		for place,players in pairs(pUnit:GetInRangePlayers()) do
			if players:HasAura(47591) then
				players:RemoveAura(47591) -- Freeze self
			end
		end
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0) -- Attackable
		DM[id].VAR.dragon = pUnit
		pUnit:RegisterEvent("DM.VAR.IceLancePeopleFinalBoss", 5000, 0)
		pUnit:RegisterEvent("DM.VAR.CheckifWipedLastBoss", 2000, 0)
		pUnit:RegisterEvent("DM.VAR.SpawnCyclonesLastBoss", 45000, 1)
		pUnit:RegisterEvent("DM.VAR.CheckForPlayerPhaseTwoFinal", 1000, 0)
		pUnit:RegisterEvent("DM.VAR.FinalSpawnBlizzards", 5000, 0)
		pUnit:RegisterEvent("DM.VAR.finalplaydramaticmusic", 20000, 1)
	elseif DM[id].VAR.finali == 6 then -- 5 is for cyclone
		pUnit:MoveTo(98, -789, 131.6, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 4000, 1)
	elseif DM[id].VAR.finali == 7 then
		local plr = pUnit:GetClosestPlayer()
		if plr ~= nil then
			if plr:IsOnVehicle() then
				plr:ExitVehicle()
			end
		end
		pUnit:Emote(447, 3000) -- land
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 2950, 1)
	elseif DM[id].VAR.finali == 8 then
		pUnit:RemoveAura(60534)
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+0.1, 0)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		pUnit:MoveTo(96.8, -753, 131.6, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 9 then
		pUnit:SendChatMessage(42,0,"The Queen prepares to blast everyone in front of her!")
		pUnit:FullCastSpell(16094) -- ice breath
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 2000, 1)
	elseif DM[id].VAR.finali == 10 then
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 4000, 1)
	elseif DM[id].VAR.finali == 11 then
		pUnit:CastSpell(15531) -- frost nova
		pUnit:PlaySoundToSet(17015)
		pUnit:SendChatMessage(14,0,"It burns! What sorcery is this?!")
		pUnit:ChannelSpell(7083, pUnit)
		local d = 0
		while d ~= 6 do
			local plr = pUnit:GetRandomPlayer(0)
			if plr ~= nil then
				pUnit:SpawnCreature(30419, plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 21, 30000)
				plr:CastSpell(69665) -- visual
			end
			d = d + 1
		end
		pUnit:Emote(64, 29800)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 30000, 1)
	elseif DM[id].VAR.finali == 12 then
		pUnit:RemoveEvents()
		pUnit:StopChannel()
		pUnit:Emote(448, 3000) -- Fly into the air
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 2950, 1)
	elseif DM[id].VAR.finali == 13 then
		pUnit:CastSpell(60534) -- flying
		pUnit:SetPosition(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+15, pUnit:GetO())
		pUnit:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+0.1, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 2000, 1)
	elseif DM[id].VAR.finali == 14 then
		pUnit:SetMovementFlags(2)
		pUnit:MoveTo(64.7, -763.6, 142, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 15 then
		pUnit:MoveTo(82.8, -765, 140, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 16 then
		pUnit:SendChatMessage(14,0,"Can you feel the cold hand of death, upon your heart?!")
		pUnit:PlaySoundToSet(17013)
		pUnit:RegisterEvent("DM.VAR.IceLancePeopleFinalBoss", 5000, 0)
		pUnit:RegisterEvent("DM.VAR.CheckifWipedLastBoss", 2000, 0)
		pUnit:RegisterEvent("DM.VAR.finalplaydramaticmusic", 5000, 1)
		pUnit:RegisterEvent("DM.VAR.SpawnCyclonesLastBoss", 45000, 1)
		pUnit:RegisterEvent("DM.VAR.CheckForPlayerPhaseTwoFinal", 1000, 0)
		pUnit:RegisterEvent("DM.VAR.FinalSpawnBlizzards", 5000, 0)	
	elseif DM[id].VAR.finali == 18 then -- 17 = cyclone
		pUnit:MoveTo(92.8, -736.7, 131.6, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 19 then
		local plr = pUnit:GetClosestPlayer()
		if plr ~= nil then
			if plr:IsOnVehicle() then
				plr:ExitVehicle()
			end
		end
		pUnit:Emote(447, 3000) -- land
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 2950, 1)
	elseif DM[id].VAR.finali == 20 then
		pUnit:RemoveAura(60534)
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()+0.1, 0)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		pUnit:MoveTo(98.6, -761.5, 131.6, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 3000, 1)
	elseif DM[id].VAR.finali == 21 then
		pUnit:SendChatMessage(42,0,"The Queen becomes enraged!")
		pUnit:FullCastSpell(16094) -- ice breath
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 22 then
		pUnit:MoveTo(101, -747, 131.6, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1500, 1)
	elseif DM[id].VAR.finali == 23 then
		pUnit:FullCastSpell(16094) -- ice breath
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 24 then
		pUnit:MoveTo(107, -756, 131.6, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1500, 1)
	elseif DM[id].VAR.finali == 25 then
		pUnit:FullCastSpell(16094) -- ice breath
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 26 then
		pUnit:MoveTo(89, -766, 131.6, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1500, 1)
	elseif DM[id].VAR.finali == 27 then
		pUnit:FullCastSpell(16094) -- ice breath
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 28 then
		pUnit:MoveTo(97.8, -745.35, 131.6, 0)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 29 then
		pUnit:RegisterEvent("DM.VAR.finalplaydramaticmusic", 5000, 1)
		pUnit:CastSpell(15531) -- frost nova
		pUnit:PlaySoundToSet(17015)
		pUnit:SendChatMessage(14,0,"It burns! What sorcery is this?!")
		pUnit:ChannelSpell(7083, pUnit)
		local d = 0
		while d ~= 6 do
			local plr = pUnit:GetRandomPlayer(0)
			if plr ~= nil then
				pUnit:SpawnCreature(30419, plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 21, 30000)
				plr:CastSpell(69665) -- visual
			end
			d = d + 1
		end
		pUnit:Emote(64, 29800)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 30000, 1)		
	elseif DM[id].VAR.finali == 30 then
		pUnit:RemoveEvents()
		pUnit:StopChannel()
		pUnit:SendChatMessage(14,0,"Now, feel my masters limitless power, and despair!")
		pUnit:PlaySoundToSet(17016)
		DM[id].VAR.finali = 11
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1000, 1)
	elseif DM[id].VAR.finali == 35 then
		pUnit:PlaySoundToSet(17015)
		pUnit:SendChatMessage(14,0,"It burns! What sorcery is this?!")
		pUnit:SpawnCreature(116899, 85.4,-726,131.6,0, 35, 11000)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1000, 1)
	elseif DM[id].VAR.finali == 36 then
		pUnit:SpawnCreature(116899, 86.6, -748, 131.6, 0, 35, 11000)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1000, 1)
	elseif DM[id].VAR.finali == 37 then
		pUnit:SpawnCreature(116899, 90.7, -780, 131.6, 0, 35, 11000)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1000, 1)
	elseif DM[id].VAR.finali == 38 then
		pUnit:SpawnCreature(116899, 90.8, -781, 131.6, 0, 35, 11000)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1000, 1)
	elseif DM[id].VAR.finali == 39 then
		pUnit:SpawnCreature(116899, 89, -818, 131.3, 0, 35, 11000)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1000, 1)
	elseif DM[id].VAR.finali == 40 then
		--pUnit:SpawnCreature(116899, x,y,z,o, 35, 11000)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1000, 1)
	elseif DM[id].VAR.finali == 41 then
		--pUnit:SpawnCreature(116899, x,y,z,o, 35, 11000)
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 5000, 1)
	elseif DM[id].VAR.finali == 42 then
		pUnit:RemoveEvents()
		pUnit:SetScale(0.5)
		pUnit:CastSpell(46822) -- visual
		pUnit:RemoveAura(41292) -- regen aura
		pUnit:SpawnGameObject(202241, 98.85, -760.6, 131.55, 3.239136, 300000, 150) -- chest loot
		pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 2500, 1)
		pUnit:RegisterEvent("DM.VAR.explosion_Dragon", 250, 7)
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		DM[id] = DM[id] or {VAR={}}
		DM[id].VAR.teleportcount = 5
		for k,players in pairs(pUnit:GetInRangePlayers()) do
			if players:HasQuest(1580) then
				players:MarkQuestObjectiveAsComplete(1580, 0)
				elseif players:HasQuest(6800) then
				if (players:GetQuestObjectiveCompletion(6800, 0) == 0) then
			players:MarkQuestObjectiveAsComplete(6800, 0)
			end
			end
		end
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
		if players:HasAchievement(59383) == false then
					players:AddAchievement(59383)
					end
	end
	end
	elseif DM[id].VAR.finali == 43 then
		pUnit:Despawn(1, 0)
	end
	DM[id].VAR.finali = DM[id].VAR.finali + 1
end

function DM.VAR.explosion_Dragon(pUnit)
	pUnit:CastSpell(43759)
end

function DM.VAR.finalplaydramaticmusic(pUnit)
	pUnit:PlaySoundToSet(17288) -- Dramatic music
end

function DM.VAR.IceLancePeopleFinalBoss(pUnit)
	if math.random(1,4) == 4 then
		pUnit:FullCastSpell(8398) -- frostobolt volley
	else
		local plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			if (not plr:IsOnVehicle()) then
				pUnit:CastSpellOnTarget(42913, plr) -- ice lance
			end
		end
	end
end

function DM.VAR.FinalSpawnBlizzards(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:SpawnCreature(232159, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 21, 15000)
	end
end

function DM.VAR.BlizzardSPawnDa(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- Untargetable
	pUnit:RegisterEvent("DM.VAR.CastBlizzardSpellDinal", 1000, 1)
end

function DM.VAR.CastBlizzardSpellDinal(pUnit)
	pUnit:CastSpellAoF(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 19099)
	pUnit:RegisterEvent("DM.VAR.CastBlizzardSpellDamage", 1000, 9)
end

function DM.VAR.CastBlizzardSpellDamage(pUnit)
	for k,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:IsAlive() then
			if plrs:GetDistanceYards(pUnit) < 10 then
				pUnit:Strike(plrs,1,19099,20,140,1.1)
			end
		end
	end
end

RegisterUnitEvent(232159, 18, "DM.VAR.BlizzardSPawnDa")

function DM.VAR.SpawnCyclonesLastBoss(pUnit)
	pUnit:SendChatMessage(42,0,"A cyclone has appeared, use it!")
	pUnit:SendChatMessage(14,0,"Suffer mortals, as your pathetic magic betrays you!")
	pUnit:PlaySoundToSet(17014)
 	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	if DM[id].VAR.finali == 5 then
		pUnit:SpawnCreature(323321, 90.225, -765.6, 131.6, 0, 35, 120000)
	elseif DM[id].VAR.finali == 17 then
		pUnit:SpawnCreature(323321, 90.4, -798.8, 131.6, 0, 35, 120000)
	end
	DM[id].VAR.finali = DM[id].VAR.finali + 1
end

function DM.VAR.CheckForPlayerPhaseTwoFinal(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if plr:IsOnVehicle() then
			if pUnit:GetHealthPct() < 10 then
				pUnit:RemoveEvents()
				plr:ExitVehicle()
				plr:MoveKnockback(89.63, -766.53, 131.6, 5, 10)
				pUnit:CastSpell(35362) -- explosion visual
				pUnit:CastSpell(64785) -- lightning visual
				pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
				pUnit:Emote(403, 10000)
				local object = pUnit:GetGameObjectNearestCoords(96.6, -811.5, 131.1, 201385)
				if object ~= nil then
					object:Despawn(1,0)
				end
				local id = pUnit:GetInstanceID()
				if id == nil then id = 1 end
				DM[id] = DM[id] or {VAR={}}
				DM[id].VAR.finali = 35
				pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 1, 1)
			else
				pUnit:RemoveEvents()
				pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
				pUnit:MoveTo(63.9, -784.6, 140, 0)
				pUnit:RegisterEvent("DM.VAR.HandleEventsAsTheyHappenLast", 2500, 1)
			end
		end
	end
end

function DM.VAR.CheckifWipedLastBoss(pUnit)
	-- The boss cannot leave combat since it never enters combat - vehicle
	local reset = true
	for place,players in pairs(pUnit:GetInRangePlayers()) do
		if players:IsAlive() then
			reset = false
			if players:GetZ() < 126 then
				players:CastSpell(51347) -- teleport visual
				players:Teleport(36, 99, -806.6, 132)
			elseif players:GetDistanceYards(pUnit) > 255 then
				players:CastSpell(51347) -- teleport visual
				players:Teleport(36, 99, -806.6, 132)			
			end
		end
	end
	if reset then
		pUnit:RemoveEvents()
		pUnit:ReturnToSpawnPoint()
		local object = pUnit:GetGameObjectNearestCoords(96.6, -811.5, 131.1, 201385)
		if object ~= nil then
			object:Despawn(1,0)
		end
		pUnit:RegisterEvent("DM.VAR.LastBossSPAWNS", 10000, 1)
	end
end

function DM.VAR.BossLeaveOrDeadFinal(pUnit, Event)
	pUnit:RemoveEvents()
	local object = pUnit:GetGameObjectNearestCoords(96.6, -811.5, 131.1, 201385)
	if object ~= nil then
		object:Despawn(1,0)
	end
end

RegisterUnitEvent(30609, 18, "DM.VAR.LastBossSPAWNS")
RegisterUnitEvent(30609, 4, "DM.VAR.BossLeaveOrDeadFinal")

function DM.VAR.CycleJumpToCreatureVisual(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- Untargetable
	pUnit:RegisterEvent("DM.VAR.CycloneVisualPrepare", 1000, 1)
end

function DM.VAR.CycloneVisualPrepare(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	if DM[id].VAR.finali == 18 then
		pUnit:SetScale(2)
	end
	pUnit:CastSpell(32332) -- cyclone visual
	pUnit:RegisterEvent("DM.VAR.Cyclevisualchancetospawn", 1000, 0)
end

function DM.VAR.Cyclevisualchancetospawn(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if plr:GetDistanceYards(pUnit) < 5 then
		 	local id = pUnit:GetInstanceID()
			if id == nil then id = 1 end
			DM[id] = DM[id] or {VAR={}}
			if DM[id].VAR.dragon ~= nil then
				pUnit:RemoveEvents()
				plr:EnterVehicle(DM[id].VAR.dragon, 1000)
				pUnit:Despawn(1000, 0)
			end
		end
	end
end

RegisterUnitEvent(323321, 18, "DM.VAR.CycleJumpToCreatureVisual")

function DM.VAR.endvisualsspam(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- Untargetable
	pUnit:RegisterEvent("DM.VAR.etietspamvisual", 1000, 1)
end

function DM.VAR.etietspamvisual(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	if DM[id].VAR.dragon ~= nil then
		pUnit:ChannelSpell(48316, DM[id].VAR.dragon)
	end
end

RegisterUnitEvent(116899, 18, "DM.VAR.endvisualsspam")

-----DeadMines Trash---

function DM.VAR.FALLENWARRIOR_COMBAT(pUnit,Event)
pUnit:RegisterEvent("DM.VAR.FALLENWARRIOR_BLOCK", 9000, 1)
pUnit:RegisterEvent("DM.VAR.FALLENWARRIOR_SLICE", 6000, 1)
end

function DM.VAR.FALLENWARRIOR_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

function DM.VAR.FALLENWARRIOR_DEAD(pUnit,Event)
pUnit:RemoveEvents()
end

function DM.VAR.FALLENWARRIOR_BLOCK(pUnit,Event)
pUnit:CastSpell(69580)
end

function DM.VAR.FALLENWARRIOR_SLICE(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 8 then
 pUnit:CastSpellOnTarget(69579, tank)
 end
 end
 end
 
 
 RegisterUnitEvent(6945, 1, "DM.VAR.FALLENWARRIOR_COMBAT")
RegisterUnitEvent(6945, 2, "DM.VAR.FALLENWARRIOR_LEAVE")
RegisterUnitEvent(6945, 4, "DM.VAR.FALLENWARRIOR_DEAD")
 RegisterUnitEvent(6948, 1, "DM.VAR.FALLENWARRIOR_COMBAT")
RegisterUnitEvent(6948, 2, "DM.VAR.FALLENWARRIOR_LEAVE")
RegisterUnitEvent(6948, 4, "DM.VAR.FALLENWARRIOR_DEAD")



function DM.VAR.LOSTMINER_COMBAT(pUnit,Event)
end

function DM.VAR.LOSTMINER_PICKAXETOSS(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 12 then
 pUnit:CastSpellOnTarget(ID, tank)
 end
 end
 end

function DM.VAR.LOSTMINER_SUNDER(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 6 then
 pUnit:CastSpellOnTarget(ID, tank)
 end
 end
 end

function DM.VAR.LOSTMINER_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

function DM.VAR.LOSTMINER_DEAD(pUnit,Event)
pUnit:RemoveEvents()
end


function DM.VAR.OVERSEER_COMBAT(pUnit,Event)
end


function DM.VAR.OVERSEER_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

function DM.VAR.OVERSEER_DEAD(pUnit,Event)
pUnit:RemoveEvents()
end

function DM.VAR.REVENANTFIRE_COMBAT(pUnit,Event)
pUnit:RegisterEvent("DM.VAR.REVENANTFIRE_AFTERBLAZE", 6000, 1)
pUnit:RegisterEvent("DM.VAR.REVENANT_SELFDESTRUCT", 1000, 0)
pUnit:RegisterEvent("DM.VAR.REVENANT_FLAMEBUFFET", 6500, 0)
end

function DM.VAR.REVENANTFIRE_AFTERBLAZE(pUnit,Event)
pUnit:Root()
pUnit:RemoveEvents()
pUnit:FullCastSpell(59183)
pUnit:RegisterEvent("DM.VAR.REVENANTFIRE_AFTERBLAZEUNROOTREGISTER", 2200, 1)
end

function DM.VAR.REVENANTFIRE_AFTERBLAZEUNROOTREGISTER(pUnit,Event)
if pUnit:HasAura(59183) == false then
pUnit:CastSpell(59183)
end
pUnit:Unroot()
pUnit:RegisterEvent("DM.VAR.REVENANTFIRE_AFTERBLAZE", 14000, 1)
pUnit:RegisterEvent("DM.VAR.REVENANT_SELFDESTRUCT", 1000, 0)
pUnit:RegisterEvent("DM.VAR.REVENANT_FLAMEBUFFET", 6500, 0)
end

function DM.VAR.REVENANT_SELFDESTRUCT(pUnit,Event)
if pUnit:GetHealthPct() < 10 then
pUnit:RemoveEvents()
pUnit:Root()
pUnit:SendChatMessage(42,0,"Blazing Revenant begins to erupt!")
pUnit:RegisterEvent("DM.VAR.REVENANT_SELFDESTRUCT_TRIGGER", 4000, 1)
end
end

function DM.VAR.REVENANT_FLAMEBUFFET(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
if pUnit:GetDistanceYards(players) < 20 then
pUnit:CastSpellOnTarget(9574, players)
end
end
end

function DM.VAR.REVENANT_DEAD(pUnit,Event)
pUnit:RemoveEvents()
end

function DM.VAR.REVENANT_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

function DM.VAR.REVENANT_SELFDESTRUCT_TRIGGER(pUnit,Event)
pUnit:CastSpell(19497)
pUnit:CastSpell(39038)
pUnit:Kill(pUnit)
end

RegisterUnitEvent(6925, 1, "DM.VAR.REVENANTFIRE_COMBAT")
RegisterUnitEvent(6925, 2, "DM.VAR.REVENANT_LEAVE")
RegisterUnitEvent(6925, 4, "DM.VAR.REVENANT_DEAD")

function DM.VAR.GENERAL_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:GetGameObjectNearestCoords(-100.85, -667.85, 7.42, 16397):SetByte(GAMEOBJECT_BYTES_1,0,0)
	local Scourgelord = pUnit:SpawnCreature(6939, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0, 35, 10000)
Scourgelord:SendChatMessage(14,0,"Do not think that I shall permit you entry into my master's sanctum so easily. Pursue me if you dare.")
Scourgelord:PlaySoundToSet(16754)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 6748 or creatures:GetEntry() == 6900 then 
	creatures:Despawn(1,0)
end
end
end

RegisterUnitEvent(6904, 4, "DM.VAR.GENERAL_DEAD")


function DM.VAR.GAUNTADD_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Despawn(4000,6000)
end

RegisterUnitEvent(6748, 4, "DM.VAR.GAUNTADD_DEAD")


function DM.VAR.BLIZZARDGAUNTSPAWN(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- Untargetable
	pUnit:SetModel(28470)
	pUnit:RegisterEvent("DM.VAR.CastBlizzardSpellGAUNTLET", 1000, 1)
end

function DM.VAR.CastBlizzardSpellGAUNTLET(pUnit)
pUnit:CastSpell(70827)
pUnit:CastSpell(56418)
	--pUnit:CastSpellAoF(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 19099)
	pUnit:RegisterEvent("DM.VAR.CastBlizzardSpellDamage", 1000, 9)
	pUnit:RegisterEvent("DM.VAR.CastBlizzardSpellGAUNTLET", 10000, 1)
	local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
if pUnit:GetDistanceYards(players) < 2 then
pUnit:CastSpellOnTarget(57456,players)
end
end
end

function DM.VAR.CastBlizzardSpellDamageGAUNTLET(pUnit)
	for k,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:IsAlive() then
			if plrs:GetDistanceYards(pUnit) < 10 then
				pUnit:Strike(plrs,1,19099,40,140,1.1)
			end
		end
	end
end

RegisterUnitEvent(6900, 18, "DM.VAR.BLIZZARDGAUNTSPAWN")

function DM.VAR.SHIPExplosionVisual(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
if math.random(1,3) <= 1 then
pUnit:RegisterEvent("DM.VAR.SHIPTimeExplosion",5000,0) 
elseif math.random(1,3) <= 2 then
pUnit:RegisterEvent("DM.VAR.SHIPTimeExplosion",7000,0) 
elseif math.random(1,3) <= 3 then
pUnit:RegisterEvent("DM.VAR.SHIPTimeExplosion",9000,0) 
end
end

function DM.VAR.SHIPTimeExplosion(pUnit,Event)
pUnit:CastSpellAoF(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 20827)
pUnit:CastSpell(46419)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 3.5 then
  if players:IsDead() == false then
  pUnit:CastSpellOnTarget(54899,players)
   pUnit:Strike(players,1,56777,300,540,2)
			end
		end
	end
end


  RegisterUnitEvent(6905, 18, "DM.VAR.SHIPExplosionVisual")
  
  
  function DM.VAR.RISENMINER_OnSpawn(pUnit,Event) -- event npcs
pUnit:EquipWeapons(2901,0,0)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
pUnit:RegisterEvent("DM.VAR.RISENMINERRAISE_EMOTE",200,1)
end

function DM.VAR.RISENMINERRAISE_EMOTE(pUnit,Event)
pUnit:Emote(449, 4000)
pUnit:RegisterEvent("DM.VAR.RISENMINERSETFACTION_AFTER_EMOTE",4200,1)
end

function DM.VAR.RISENMINERSETFACTION_AFTER_EMOTE(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	pUnit:MoveTo(-44.98,-377.79,55.47,0.27)
end

RegisterUnitEvent(91987, 18, "DM.VAR.RISENMINER_OnSpawn")

function DM.VAR.NECROBUNNY_OnSpawn(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:RegisterEvent("DM.VAR.NECROBUNNYCheckingForPlayer",1200,0)
end

RegisterUnitEvent(91988, 18, "DM.VAR.NECROBUNNY_OnSpawn")


function DM.VAR.NECROBUNNYCheckingForPlayer(pUnit,Event)
player = pUnit:GetClosestPlayer()
if player ~= nil then
if pUnit:GetDistanceYards(player) < 5 then
pUnit:RemoveEvents()
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 13317 then 
	creatures:CastSpell(61614)
	creatures:SpawnCreature(91987 ,creatures:GetX(), creatures:GetY(),creatures:GetZ(), creatures:GetO(), 14, 0)
		end
	end
end
	end
end

-------------------------
--//Second Boss Trash\\--
-------------------------

function DM.VAR.CocoonOnSpawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("DM.VAR.SpawnSpidersHaha", 1200, 0)
end

function DM.VAR.SpawnSpidersHaha(pUnit,Event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 12 then
			pUnit:RemoveEvents()
			local bigorsmalladds = math.random(1,4)
			if bigorsmalladds == 1 then -- Small adds
				pUnit:SpawnCreature(77206,pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO(),22,0)
				pUnit:SpawnCreature(77206,pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO(),22,0)
				pUnit:SpawnCreature(77206,pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO(),22,0)
			else --Big add
				pUnit:SpawnCreature(77205,pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO(),22,0)
			end
			pUnit:CastSpell(11)
		end
	end
end

function DM.VAR.DespawnOnDeath(pUnit,Event)
	if pUnit:GetEntry() == 77205 then
		pUnit:Despawn(36000,0)
	elseif pUnit:GetEntry() == 77206 then
		pUnit:Despawn(36000,0)
	end
end

function DM.VAR.DespawnCocoonsFix(pUnit, Event)
	for k,cacoon in pairs(pUnit:GetInRangeUnits()) do
		if cacoon:GetEntry() == 77207 then
			if not cacoon:IsAlive() then
				cacoon:Despawn(0, 30000) --Temporarely disabled for dev purposes.
			end
		end
	end
end


RegisterUnitEvent(77207, 18, "DM.VAR.CocoonOnSpawn")
RegisterUnitEvent(77205, 18, "DM.VAR.DespawnCocoonsFix")
RegisterUnitEvent(77206, 18, "DM.VAR.DespawnCocoonsFix")
RegisterUnitEvent(77206, 4, "DM.VAR.DespawnOnDeath")
RegisterUnitEvent(77205, 4, "DM.VAR.DespawnOnDeath")
------------------------------------------------------------------------------------------

function Teleporter_OnUseObject(pMisc, event, player)
	pMisc:GossipObjectCreateMenu(7903, player , 0)
	local id = player:GetInstanceID()
	if id == nil then id = 1 end
	DM[id] = DM[id] or {VAR={}}
	if DM[id].VAR.teleportcount == nil then
		DM[id].VAR.teleportcount = 0
	end
	if DM[id].VAR.teleportcount == 0 then
		pMisc:GossipObjectMenuAddItem(4, "The teleport device does not appear to be active.", 1, 0)
	elseif DM[id].VAR.teleportcount == 1 then
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Plagueworks.", 247, 0)
	elseif DM[id].VAR.teleportcount == 2 then
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Plagueworks.", 247, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Hatchery.", 248, 0)
	elseif DM[id].VAR.teleportcount == 3 then
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Plagueworks.", 247, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Hatchery.", 248, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Forge.", 249, 0)
	elseif DM[id].VAR.teleportcount == 4 then
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Plagueworks.", 247, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Hatchery.", 248, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Forge.", 249, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Plague-ship.", 250, 0)
	elseif DM[id].VAR.teleportcount == 5 then
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Plagueworks.", 247, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Hatchery.", 248, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Forge.", 249, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Plague-ship.", 250, 0)
		pMisc:GossipObjectMenuAddItem(4, "Teleport to the Beasts lair.", 251, 0)
	end
	pMisc:GossipObjectMenuAddItem(4, "Leave the device alone.", 1, 0)
	pMisc:GossipObjectSendMenu(player)
end

function TeleporterGossip_Submenus(pMisc, event, player, id, intid, code)
	if intid == 247 then
		player:CastSpell(61456) -- teleport visual
		player:Teleport(36, -196, -433, 54)
	elseif intid == 248 then
		player:CastSpell(61456) -- teleport visual
		player:Teleport(36, -276.7, -484.65, 48.9)
	elseif intid == 249 then
		player:CastSpell(61456) -- teleport visual
		player:Teleport(36,-208.75,-565.01,20.97)
	elseif intid == 250 then
		player:CastSpell(61456) -- teleport visual
		player:Teleport(36, -69.85, -828.9, 41)
	elseif intid == 251 then
		player:CastSpell(61456) -- teleport visual
		player:Teleport(36, 90, -771, 132)
	end
	player:GossipComplete()
end


RegisterGameObjectEvent(194569, 4, "Teleporter_OnUseObject")
RegisterGOGossipEvent(194569, 2, "TeleporterGossip_Submenus")

------SCOURGELORD BUGFIX ---


function DM.VAR.SCOURGELORDSPAWNFix(pUnit,Event)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 6951 then 
	creatures:Despawn(1,0)
end
end
end

RegisterUnitEvent(6934, 18, "DM.VAR.SCOURGELORDSPAWNFix")

function FINALBOSSgossipstart(pUnit, event, player)
		local Taxi = LuaTaxi:CreateTaxi()
		Taxi:AddPathNode(36, -101.54, -900.036, 32.11)
		Taxi:AddPathNode(36, -30.84, -866.72, 77.58)
		Taxi:AddPathNode(36, -101.54, -900.036, 32.11) -- bug point
		Taxi:AddPathNode(36, -87.28, -725.25, 92.79)
		Taxi:AddPathNode(36, -101.54, -900.036, 32.11)--bug point
		Taxi:AddPathNode(36, -159.25, -752.85, 5.08)
		Taxi:AddPathNode(36, -153.52, -818.93, 8.49)
		Taxi:AddPathNode(36, -44.73, -908.63, 79.87)
		Taxi:AddPathNode(36, 43.07, -900.36, 141.52)
	 Taxi:AddPathNode(36, 66.31, -908.21, 138.83)
		player:StartTaxi(Taxi, 25511)
	pUnit:GossipSendMenu(player)
end




RegisterUnitGossipEvent(40333, 1, "FINALBOSSgossipstart")
--

-----------
function DM.VAR.LUMBERABOMINATION_COMBAT(pUnit,Event)
pUnit:RegisterEvent("DM.VAR.LUMBERABOM_CLEAVE", 5000, 0)
end

function DM.VAR.LUMBERABOM_CLEAVE(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 8 then
 pUnit:CastSpellOnTarget(40504, tank)
end
end
end

function DM.VAR.LUMBERABOMINATION_DEADANDLEAVE(pUnit,Event)
pUnit:RemoveEvents()
end


RegisterUnitEvent(91986, 2, "DM.VAR.LUMBERABOMINATION_DEADANDLEAVE")
RegisterUnitEvent(91986, 4, "DM.VAR.LUMBERABOMINATION_DEADANDLEAVE")
RegisterUnitEvent(91986, 1, "DM.VAR.LUMBERABOMINATION_COMBAT")