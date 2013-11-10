ZA = {}
ZA.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local UNIT_FIELD_CHARMEDBY = OBJECT_END + 0x0006
local UNIT_FIELD_CHARM = OBJECT_END + 0x0000
local UNIT_FLAG_PVP_ATTACKABLE = 0x00000008
local UNIT_FLAG_PLAYER_CONTROLLED_CREATURE = 0x01000000
local UNIT_END = OBJECT_END + 0x008E
local PLAYER_DUEL_TEAM = UNIT_END + 0x0008
local PLAYER_DUEL_ARBITER = UNIT_END + 0x0000
local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3

--[[INDEX
1. HEADHUNTER
5. DARK ANIMUS
]]
--[[
5.DARK ANIMUS
]]

function ZA.VAR.DARKANIMUS_SPAWN(pUnit,Event)
	pUnit:AIDisableCombat(false)
	pUnit:SetPhase(3)
	pUnit:Unroot()
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 9)
	pUnit:RegisterEvent("ZA.VAR.DARKANIMUS_DETECTPLRS", 1500, 0)
end

function ZA.VAR.DARKANIMUS_DETECTPLRS(pUnit)
	for _,plr in pairs(pUnit:GetInRangePlayers()) do
		if plr:GetDistanceYards(pUnit) < 15 then
			if not plr:IsDead() then
				pUnit:RemoveEvents()
				pUnit:SendChatMessage(14,0,"Systems online. All cores operating at peak efficiency.")
				pUnit:PlaySoundToSet(40069)
				pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
				pUnit:RegisterEvent("ZA.VAR.DARKANIMUS_SUP", 9100, 1)
			end
		end
	end
end

function ZA.VAR.DARKANIMUS_SUP(pUnit)
	pUnit:SendChatMessage(14,0," Identification matrix mismatch. Unknown entities detected.")
	pUnit:PlaySoundToSet(40070)
	pUnit:RegisterEvent("ZA.VAR.DARKANIMUSTURNCOMBAT", 8500, 1)
end

function ZA.VAR.DARKANIMUSTURNCOMBAT(pUnit)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

RegisterUnitEvent(449814, 18, "ZA.VAR.DARKANIMUS_SPAWN")

function ZA.VAR.DarkAnimus_Events(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
	if Event == 1 then
		ZA[id].VAR.AnimusPhase = 0
		ZA[id].VAR.AnimusEnrage = 0
		pUnit:SendChatMessage(14,0,"Entering defensive mode. Disabling output failsafes.")
		pUnit:PlaySoundToSet(40060)
		pUnit:RegisterEvent("ZA.VAR.DarkAnimus_Phase_A", 25000, 1)
		pUnit:RegisterEvent("ZA.VAR.DarkAnimus_BloodBoil", math.random(30000,35000), 0)
		pUnit:RegisterEvent("ZA.VAR.DarkAnimus_BloodStackAmt", 15000, 0)
		pUnit:RegisterEvent("ZA.VAR.DarkAnimus_SoftEnrage", 1000, 0)
		pUnit:RegisterEvent("ZA.VAR.DarkAnimus_HardEnrage_TimerCount", 10000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:Despawn(1500,5000)
		ZA[id].VAR.AnimusPhase = 0
		ZA[id].VAR.AnimusEnrage = 0
		for a, players in pairs(pUnit:GetInRangePlayers()) do
			players:SetPhase(1)
		end
	elseif Event == 3 then -- slay derp
		local choice = math.random(1,3)
		if choice == 1 then
			pUnit:SendChatMessage(14,0,"The spark of life fades.")
			pUnit:PlaySoundToSet(40071)
		elseif choice == 2 then
			pUnit:SendChatMessage(14,0,"What was is no longer.")
			pUnit:PlaySoundToSet(40072)
		elseif choice == 3 then
			pUnit:SendChatMessage(14,0,"Countermeasures successful.")
			pUnit:PlaySoundToSet(40073)
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		ZA[id].VAR.AnimusPhase = 0
		ZA[id].VAR.AnimusEnrage = 0
		pUnit:SendChatMessage(14,0,"Existence ends...I become nothing...")
		pUnit:PlaySoundToSet(40061)
		for a, players in pairs(pUnit:GetInRangePlayers()) do
			players:SetPhase(1)
		end
	end
end

function ZA.VAR.DarkAnimus_HardEnrage_TimerCount(pUnit)
	local id = pUnit:GetInstanceID() --1 == 10 seconds
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
	if ZA[id].VAR.AnimusEnrage == 30 then
		pUnit:RemoveEvents()
		pUnit:Root()
		pUnit:CancelSpell()
		pUnit:FullCastSpell(64584)
		pUnit:SendChatMessage(14,0,"Engaging total destruction sequence. Goodbye.")
		pUnit:PlaySoundToSet(40067)
		pUnit:RegisterEvent("ZA.VAR.DarkAnimus_failsafe", 8100, 1)
	else
		ZA[id].VAR.AnimusEnrage = ZA[id].VAR.AnimusEnrage + 1
	end
end

function ZA.VAR.DarkAnimus_failsafe(pUnit)
	pUnit:CastSpell(64584)
end

function ZA.VAR.DarkAnimus_SoftEnrage(pUnit)
	local id = pUnit:GetInstanceID() --1 == 10 seconds
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
	if pUnit:GetHealthPct() < 30 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(72737)
		ZA[id].VAR.AnimusPhase = 1
		pUnit:RegisterEvent("ZA.VAR.DarkAnimus_BloodBoil", math.random(20000,25000), 0)
		pUnit:RegisterEvent("ZA.VAR.DarkAnimus_BloodStackAmt", 15000, 0)
		pUnit:RegisterEvent("ZA.VAR.DarkAnimus_HardEnrage_TimerCount", 10000, 0)
		pUnit:SendChatMessage(14,0,"Let the energies consume you!")
		pUnit:PlaySoundToSet(40068)
		for a, players in pairs(pUnit:GetInRangePlayers()) do
			players:SetPhase(3)
		end
	end
end

function ZA.VAR.DarkAnimus_Phase_A(pUnit)
	pUnit:SendChatMessage(14,0,"Redirecting power.")
	pUnit:PlaySoundToSet(40066)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		players:SetPhase(3)
	end
	pUnit:RegisterEvent("ZA.VAR.DarkAnimus_Phase_A_Over", 20000, 1)
end

function ZA.VAR.DarkAnimus_Phase_A_Over(pUnit)
	pUnit:SendChatMessage(14,0,"Energy Vortex ramping down.")
	pUnit:PlaySoundToSet(40065)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		players:SetPhase(1)
	end
	pUnit:RegisterEvent("ZA.VAR.DarkAnimus_Phase_A", 20000, 1)
end

RegisterUnitEvent(449814, 3, "ZA.VAR.DarkAnimus_Events")
RegisterUnitEvent(449814, 1, "ZA.VAR.DarkAnimus_Events")
RegisterUnitEvent(449814, 2, "ZA.VAR.DarkAnimus_Events")
RegisterUnitEvent(449814, 4, "ZA.VAR.DarkAnimus_Events")

function ZA.VAR.DarkAnimus_BloodBoil(pUnit)
	pUnit:CastSpell(49941)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 10 then
			if players:HasAura(50380) then
				players:RemoveAura(50380)
			end
		end
	end
end

function ZA.VAR.DarkAnimus_BloodStackAmt(pUnit)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 40 then
			pUnit:CastSpellOnTarget(50380, players)
			if players:GetAuraStackCount(50380) > 4 then
				players:RemoveNegativeAuras()
				players:CastSpell(50396)
			end
		end
	end
end

function ZA.VAR.Animus_Beamdummy(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:IsInWorld() and unit:GetEntry() == 68938 and unit:IsAlive() and pUnit:GetDistanceYards(unit) < 25 then
			unit:ChannelSpell(31324,pUnit)
			pUnit:RegisterEvent("ZA.VAR.Animus_beam_dealdamageyo", 1000, 0)
		end
	end
end


function ZA.VAR.Animus_beam_dealdamageyo(pUnit)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:IsInWorld() and unit:GetEntry() == 68938 and unit:IsAlive() and pUnit:GetDistanceYards(unit) < 25 then
			unit:CastSpell(39180)
			unit:ChannelSpell(31324,pUnit)
		end
	end
end

RegisterUnitEvent(68937, 18, "ZA.VAR.Animus_Beamdummy")

function ZA.VAR.animusbeamsupperspawn(pUnit,Event)
	pUnit:SetScale(0.4)
	pUnit:RegisterEvent("ZA.VAR.animusbeamdamage_forreal", 1000, 0)
end

function ZA.VAR.animusbeamdamage_forreal(pUnit)
	local id = pUnit:GetInstanceID() --1 == 10 seconds
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if players:IsInPhase(2) and pUnit:GetDistanceYards(players) < 2.5 then
			pUnit:Strike(players,1,37826,500,800,2)
		end
	end
	if ZA[id].VAR.AnimusPhase == 1 then
		pUnit:SpawnCreature(68940,pUnit:GetX(),pUnit:GetY(), pUnit:GetZ(),0, 35, 5000)
	end
end

RegisterUnitEvent(68938, 18, "ZA.VAR.animusbeamsupperspawn")


--[[
1. HEADHUNTER

439812 == phase 2 steed dismount
]]

function ZA.VAR.Headhunter_Events(pUnit,Event)
	if Event == 1 then
		pUnit:SendChatMessage(14,0,"You shall regret disturbing my homeland!")
		pUnit:PlaySoundToSet(40075)
		pUnit:RegisterEvent("ZA.VAR.HEADHUNTER_IMPALE_SETUP", math.random(25000,32000), 0)
		pUnit:RegisterEvent("ZA.VAR.Headhunter_lightningclouds", math.random(17000,20000), 0)
		pUnit:RegisterEvent("ZA.VAR.Headhunter_Hurlspear", math.random(8000,12000), 0)
		pUnit:RegisterEvent("ZA.VAR.Headhunter_Forkedcone", math.random(10000,15000), 2)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:Despawn(10000,5000)
		pUnit:AIDisableCombat(false)
		pUnit:Unroot()
	elseif Event == 3 then
		pUnit:SendChatMessage(14,0,"Shocking. I know.")
		pUnit:PlaySoundToSet(40077)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SpawnCreature(439812,pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 0)
		pUnit:SendChatMessage(14,0,"The end of our empire... is only the beginning...")
		pUnit:PlaySoundToSet(40076)
		pUnit:AIDisableCombat(false)
		pUnit:Unroot()
	elseif Event == 18 then
		pUnit:SetMount(40076)
		pUnit:AIDisableCombat(false)
		pUnit:Unroot()
	end
end

function ZA.VAR.Headhunter_Hurlspear(pUnit)
	local player = pUnit:GetRandomPlayer(0)
	if player then
		if pUnit:GetDistanceYards(player) < 40 then
			if not player:IsDead() then
				pUnit:CastSpellOnTarget(43325,player)
			end
		end
	end
end

function ZA.VAR.Headhunter_Forkedcone(pUnit)
	pUnit:CastSpell(24682)
end

function ZA.VAR.Headhunter_lightningclouds(pUnit)
	pUnit:SendChatMessage(14,0,"Can you feel that tingling sensation? It may be your last.")
	pUnit:PlaySoundToSet(40078)
	pUnit:CastSpellAoF(-101.694931, 1363.84, 40.80, 26550)
	pUnit:CastSpellAoF(-58.03, 1367.72, 40.83, 26550)
	pUnit:CastSpellAoF(-59.57, 1318.31, 41.16, 26550)
	pUnit:CastSpellAoF(-104.39, 1321.22, 40.82, 26550)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 50 then
			pUnit:CastSpellAoF(players:GetX(), players:GetY(), players:GetZ(), 26550)
		end
	end
end

RegisterUnitEvent(449812, 1, "ZA.VAR.Headhunter_Events")
RegisterUnitEvent(449812, 2, "ZA.VAR.Headhunter_Events")
RegisterUnitEvent(449812, 3, "ZA.VAR.Headhunter_Events")
RegisterUnitEvent(449812, 4, "ZA.VAR.Headhunter_Events")
RegisterUnitEvent(449812, 18, "ZA.VAR.Headhunter_Events")

function ZA.VAR.HEADHUNTER_IMPALE_SETUP(pUnit)
	pUnit:RemoveEvents()
	if math.random(1,2) == 1 then
		pUnit:SendChatMessage(14,0,"You're in for a stunning surprise...")
		pUnit:PlaySoundToSet(40079)
	else
		pUnit:SendChatMessage(14,0,"In a flash, you'll be nothing more than dust...")
		pUnit:PlaySoundToSet(40080)
	end
	pUnit:AIDisableCombat(true)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
	pUnit:Root()
	pUnit:TeleportCreature(-80.149712,1343.896682,40.77)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 40 then
			pUnit:CastSpellOnTarget(54899,players)
			players:CastSpell(47693)
		end
	end
	pUnit:RegisterEvent("ZA.VAR.HEADHUNTER_IMPALE", 4000, 1)
	pUnit:RegisterEvent("ZA.VAR.ROOT_PLAYERS", 2800, 1)
end

function ZA.VAR.ROOT_PLAYERS(pUnit)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 50 then
			players:Root()
			players:SetPlayerLock(1)
		end
	end
end

function ZA.VAR.HEADHUNTER_IMPALE(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
	ZA[id].VAR.Impaletarget = pUnit:GetRandomPlayer(0)
	if ZA[id].VAR.Impaletarget then
		if pUnit:GetDistanceYards(ZA[id].VAR.Impaletarget) < 30 then
			if ZA[id].VAR.Impaletarget:IsDead() == false then
				pUnit:CastSpellOnTarget(53338,ZA[id].VAR.Impaletarget)
				pUnit:SendChatMessageToPlayer(42,0,"Zulanzi begins to charge at YOU!", ZA[id].VAR.Impaletarget)
				local name = ZA[id].VAR.Impaletarget:GetName()
				pUnit:SendChatMessage(42,0,"Zulanzi begins to fixate on "..name.."")
				pUnit:SetOrientation(ZA[id].VAR.Impaletarget:GetO())
			end
		end
	end
	pUnit:RegisterEvent("ZA.VAR.HEADHUNTER_IMPALE_CHARGE", 2000, 1)
	pUnit:RegisterEvent("ZA.VAR.UNROOT_PLAYERS", 2100, 1)
end



function ZA.VAR.HEADHUNTER_IMPALE_CHARGE(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
	pUnit:Unroot()
	if ZA[id].VAR.Impaletarget then
		pUnit:SetOrientation(ZA[id].VAR.Impaletarget:GetO())
		pUnit:ModifyRunSpeed(20)
		pUnit:ModifyWalkSpeed(21)
		pUnit:CastSpell(8260)
		pUnit:MoveTo(ZA[id].VAR.Impaletarget:GetX(),ZA[id].VAR.Impaletarget:GetY(),ZA[id].VAR.Impaletarget:GetZ(),ZA[id].VAR.Impaletarget:GetO())
	end
	pUnit:RegisterEvent("ZA.VAR.HEADHUNTER_STUNNED", 4000, 1)
	pUnit:RegisterEvent("ZA.VAR.HEADHUNTER_CRASH", 1000, 0)
end


function ZA.VAR.HEADHUNTER_CRASH(pUnit)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 8 then
			if not players:IsDead() then
				pUnit:CastSpellOnTarget(66770,players)
			end
		end
	end
end

function ZA.VAR.UNROOT_PLAYERS(pUnit)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 50 then
			players:Unroot()
			players:SetPlayerLock(0)
		end
	end
end

function ZA.VAR.HEADHUNTER_STUNNED(pUnit)
	pUnit:RemoveEvents()
	pUnit:Emote(64,5000)
	pUnit:AIDisableCombat(false)
	pUnit:Root()
	pUnit:SendChatMessage(42,0,"Zulanzi is stunned!")
	pUnit:RegisterEvent("ZA.VAR.HEADHUNTER_UNSTUNNED", 5100, 1)
end

function ZA.VAR.HEADHUNTER_UNSTUNNED(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
	pUnit:Unroot()
	pUnit:ModifyRunSpeed(14)
	pUnit:ModifyWalkSpeed(2.5)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	ZA[id].VAR.Impaletarget = nil
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("ZA.VAR.HEADHUNTER_IMPALE_SETUP", math.random(25000,32000), 0)
	pUnit:RegisterEvent("ZA.VAR.Headhunter_lightningclouds", math.random(17000,20000), 0)
	pUnit:RegisterEvent("ZA.VAR.Headhunter_Hurlspear", math.random(8000,12000), 0)
	pUnit:RegisterEvent("ZA.VAR.Headhunter_Forkedcone", math.random(10000,16000), 0)
end

function ZA.VAR.zULANZISuicide(pUnit,Event)
	pUnit:Kill(pUnit)
end

RegisterUnitEvent(439812, 18, "ZA.VAR.zULANZISuicide")


function ZA.VAR.KingZulji_Events(pUnit,Event)
	if Event == 1 then
		pUnit:SendChatMessage(14,0,"You are not the first to challenge me, peons. You will not be the last.")
		pUnit:PlaySoundToSet(40090)
	elseif Event == 3 then
		if math.random(1,2) == 1 then
			pUnit:SendChatMessage(14,0,"See how effortlessly I CRUSH your bones!")
			pUnit:PlaySoundToSet(40098)
		else
			pUnit:SendChatMessage(14,0,"Fall to your knees, coward!")
			pUnit:PlaySoundToSet(40099)
		end
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"I. Am. UNDEFEATED!")
		pUnit:PlaySoundToSet(40097)
		pUnit:Despawn(3000,7000)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"You call that... a fight?")
		pUnit:PlaySoundToSet(40093)
	end
end

RegisterUnitEvent(113441, 1, "ZA.VAR.KingZulji_Events")
RegisterUnitEvent(113441, 2, "ZA.VAR.KingZulji_Events")
RegisterUnitEvent(113441, 3, "ZA.VAR.KingZulji_Events")
RegisterUnitEvent(113441, 4, "ZA.VAR.KingZulji_Events")

function ZA.VAR.KingZulji_METEOR_ON_CASTERS(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(3)
	if plr then
		if pUnit:GetDistanceYards(plr) < 30 then
			if not plr:IsDead() then
				pUnit:CastSpellOnTarget(26789,plr)
			end
		end
	end
end


function ZA.VAR.TSULAN_EVENTS(pUnit,Event)
local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
if Event == 1 then
ZA[id].VAR.en = 0
	pUnit:SendChatMessage(14,0,"YOU DO NOT BELONG HERE, THE WATERS MUST BE PROTECTED. I WILL CAST YOU OUT OR SLAY YOU!")
		pUnit:PlaySoundToSet(18184)
		pUnit:RegisterEvent("ZA.VAR.CYCLONE_PHASE", 20000, 1)
		pUnit:RegisterEvent("ZA.VAR.TSLUN_PHASE_HPONE", 1000, 0)
		pUnit:RegisterEvent("ZA.VAR.TSLUN_FROSTBOLT",  math.random(2000,3000),0)
		pUnit:RegisterEvent("ZA.VAR.TSLUN_WATERTOMB",  math.random(15000,16000),0)
		local object = pUnit:GetGameObjectNearestCoords(108.96,1328.12,-21.99,3267530)
		if object then
			object:SetPhase(1)
		end
elseif Event == 2 then
pUnit:RemoveEvents()
ZA[id].VAR.en = 0
pUnit:Despawn(1,6000)
local object = pUnit:GetGameObjectNearestCoords(108.96,1328.12,-21.99, 3267530)
		if object then
			object:SetPhase(2)
	end
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 or creatures:GetEntry() == 29834 then 
		creatures:SetPhase(2)
	end
end
elseif Event == 3 then
elseif Event == 4 then
pUnit:RemoveEvents()
ZA[id].VAR.en = 0
		pUnit:SendChatMessage(14,0,"I thank you strangers, I have been freed...")
		pUnit:PlaySoundToSet(18185)
		pUnit:CastSpell(61613)
local object = pUnit:GetGameObjectNearestCoords(108.96,1328.12,-21.99, 3267530)
		if object then
			object:SetPhase(2)
end
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 or creatures:GetEntry() == 29834 then 
		creatures:SetPhase(2)
	end
end
end
end

function ZA.VAR.TSLUN_WATERTOMB(pUnit)
     local plr = pUnit:GetRandomPlayer(0) 
     if plr then 
          pUnit:CastSpellOnTarget(38235, plr) 
		end 
	end
	
	RegisterUnitEvent(4981231, 1, "ZA.VAR.TSULAN_EVENTS")
	RegisterUnitEvent(4981231, 4, "ZA.VAR.TSULAN_EVENTS")
	RegisterUnitEvent(4981231, 2, "ZA.VAR.TSULAN_EVENTS")
	RegisterUnitEvent(4981231, 3, "ZA.VAR.TSULAN_EVENTS")

	
	function ZA.VAR.CYCLONE_PHASE(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
		pUnit:SendChatMessage(14,0,"Darkness grows..")
		pUnit:PlaySoundToSet(18186)
		pUnit:CastSpell(50066)
		ZA[id].VAR.en = ZA[id].VAR.en + 1
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(1)
		creatures:CastSpell(38464)
		end
	end
	if ZA[id].VAR.en == 30 then
		pUnit:SendChatMessage(14,0,"DIE IN DARKNESS.")
		pUnit:PlaySoundToSet(18187)
		pUnit:FullCastSpell(59377)
	end
	pUnit:RegisterEvent("ZA.VAR.CYCLONE_PHASE", 30000, 1)
end
	
	function ZA.VAR.CYCLONE_PHASEOVER(pUnit)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(2)
		end
	end
	pUnit:RegisterEvent("ZA.VAR.CYCLONE_PHASE", 45000, 1)
end


function ZA.VAR.TSLUN_FROSTBOLT(pUnit)
 if pUnit:IsCasting() then 
          return 
     end 
   --[[  local plr = pUnit:GetRandomPlayer(0) 
     if plr then 
          pUnit:FullCastSpellOnTarget(46987, plr) 
     end ]]
	 pUnit:FullCastSpell(34449)
end
	
	function ZA.VAR.CYCLONE_DUMMYxx(pUnit,Event)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		pUnit:CastSpell(38464)
		pUnit:Unroot()
		pUnit:RegisterEvent("ZA.VAR.CYCLONE_vDAMAGE", 1500, 0)
	end
	
	
function ZA.VAR.CYCLONE_vDAMAGE(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ZA[id] = ZA[id] or {VAR={}}
for _, players in pairs(pUnit:GetInRangePlayers()) do
if pUnit:GetDistanceYards(players) < 3.5 then
	if not players:IsDead() then
	if pUnit:IsInPhase(1) then
	pUnit:Strike(players,1,1535,300,390,1)
	players:CastSpell(54899)
		end
	end
		end
	end
end

function ZA.VAR.TSLUN_PHASE_HPONE(pUnit,Event)
if pUnit:GetHealthPct() < 80 then
pUnit:RemoveEvents()
	pUnit:SendChatMessage(14,0,"OVERWHELMING FEAR.")
		pUnit:PlaySoundToSet(18189)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:AIDisableCombat(true)
pUnit:Emote(382,14100)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(2)
		end
	end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(1)
		creatures:CastSpell(38464)
		end
	end
pUnit:RegisterEvent("ZA.VAR.TSLUN_WATERBOLTS", 2000, 0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_PULLBACKIN", 3500, 0)
pUnit:RegisterEvent("ZA.VAR.RESETPHASETSLUN", 1000, 0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_STOPITA", 14000, 1)
		end
end


function ZA.VAR.TSLUN_PHASE_HPTWO(pUnit,Event)
if pUnit:GetHealthPct() < 60 then
pUnit:RemoveEvents()
	pUnit:SendChatMessage(14,0,"FLEE THIS PLACE OR DIE!")
		pUnit:PlaySoundToSet(18190)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:AIDisableCombat(true)
pUnit:Emote(382,14100)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(2)
		end
	end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(1)
		creatures:CastSpell(38464)
		end
	end
pUnit:RegisterEvent("ZA.VAR.TSLUN_WATERBOLTS", 2000, 0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_PULLBACKIN", 3500, 0)
pUnit:RegisterEvent("ZA.VAR.RESETPHASETSLUN", 1000, 0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_STOPITB", 14000, 1)
		end
end

function ZA.VAR.TSLUN_PHASE_HPTHREE(pUnit,Event)
if pUnit:GetHealthPct() < 40 then
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:AIDisableCombat(true)
pUnit:Emote(382,14100)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(2)
		end
	end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(1)
		creatures:CastSpell(38464)
		end
	end
pUnit:RegisterEvent("ZA.VAR.TSLUN_WATERBOLTS", 2000, 0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_PULLBACKIN", 3500, 0)
pUnit:RegisterEvent("ZA.VAR.RESETPHASETSLUN", 1000, 0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_STOPITC", 14000, 1)
		end
end



function ZA.VAR.TSLUN_PHASE_HPFOUR(pUnit,Event)
if pUnit:GetHealthPct() < 20 then
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:AIDisableCombat(true)
pUnit:Emote(382,14100)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(2)
		end
	end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 798321 then 
		creatures:SetPhase(1)
		creatures:CastSpell(38464)
		end
	end
pUnit:RegisterEvent("ZA.VAR.TSLUN_WATERBOLTS", 2000, 0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_PULLBACKIN", 3500, 0)
pUnit:RegisterEvent("ZA.VAR.RESETPHASETSLUN", 1000, 0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_STOPITD", 14000, 1)
		end
end

function ZA.VAR.TSLUN_STOPITA(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:AIDisableCombat(false)
pUnit:RegisterEvent("ZA.VAR.CYCLONE_PHASE", 20000, 1)
pUnit:RegisterEvent("ZA.VAR.TSLUN_FROSTBOLT",  math.random(2000,3000),0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_WATERTOMB",  math.random(15000,16000),0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_PHASE_HPTWO", 1000, 0)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 29834 then 
		creatures:SetPhase(1)
	end
end
end

function ZA.VAR.TSLUN_STOPITB(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:AIDisableCombat(false)
pUnit:RegisterEvent("ZA.VAR.CYCLONE_PHASE", 20000, 1)
pUnit:RegisterEvent("ZA.VAR.TSLUN_FROSTBOLT",  math.random(2000,3000),0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_WATERTOMB",  math.random(15000,16000),0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_PHASE_HPTHREE", 1000, 0)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 29834 then 
		creatures:SetPhase(1)
	end
end
end

function ZA.VAR.TSLUN_STOPITC(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:AIDisableCombat(false)
pUnit:RegisterEvent("ZA.VAR.CYCLONE_PHASE", 20000, 1)
pUnit:RegisterEvent("ZA.VAR.TSLUN_FROSTBOLT",  math.random(2000,3000),0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_WATERTOMB",  math.random(15000,16000),0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_PHASE_HPFOUR", 1000, 0)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 29834 then 
		creatures:SetPhase(1)
	end
end
end

function ZA.VAR.TSLUN_STOPITD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:AIDisableCombat(false)
pUnit:RegisterEvent("ZA.VAR.CYCLONE_PHASE", 20000, 1)
pUnit:RegisterEvent("ZA.VAR.TSLUN_FROSTBOLT",  math.random(2000,3000),0)
pUnit:RegisterEvent("ZA.VAR.TSLUN_WATERTOMB",  math.random(15000,16000),0)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 29834 then 
		creatures:SetPhase(1)
	end
end
end

function ZA.VAR.RESETPHASETSLUN(pUnit,Event)
local id = pUnit:GetInstanceID()
if id == nil then id = 1 end
DAL[id] = DAL[id] or {VAR={}}
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
	pUnit:RemoveEvents()
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:AIDisableCombat(false)
			pUnit:Despawn(1,0)
			for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 498322 then
			creatures:Despawn(1,0)
			elseif creatures:GetEntry() == 798321 or creatures:GetEntry() == 29834 then 
		creatures:SetPhase(2)
			end
			end
end
local object = pUnit:GetGameObjectNearestCoords(108.96,1328.12,-21.99, 3267530)
		if object then
			object:SetPhase(2)
			end
end

function ZA.VAR.TSLUN_WATERBOLTS(pUnit)
for _, players in pairs(pUnit:GetInRangePlayers()) do
	if not players:IsDead() then
	pUnit:Strike(players,1,1535,150,290,1)
	players:CastSpell(54899)
	end
	end
end

function ZA.VAR.TSLUN_PULLBACKIN(pUnit)
for _, players in pairs(pUnit:GetInRangePlayers()) do
	if not players:IsDead() then
pUnit:FullCastSpellOnTarget(64429, players) -- visual
				players:MoveKnockback(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 10, 20)
	end
	end
end
				
RegisterUnitEvent(798321, 18, "ZA.VAR.CYCLONE_DUMMYxx")



function ZA.VAR.FRENZY_DIES(pUnit)
pUnit:RemoveEvents()
pUnit:SetPhase(2)
end


RegisterUnitEvent(29834, 4, "ZA.VAR.FRENZY_DIES")

function ZA.VAR.PRIMALTIDEWALKER_Events(pUnit,Event)
if Event == 1 then
elseif Event == 4 then
for _, players in pairs(pUnit:GetInRangePlayers()) do
if pUnit:GetDistanceYards(players) < 10 then
	if not players:IsDead() then
	players:CastSpell(50065)
		end
	end	
end
elseif Event == 18 then
pUnit:RegisterEvent("ZA.VAR.PRIMALTIDEWALKER_MOVETO", 1000, 1)
	end
		end
	
	
	function ZA.VAR.PRIMALTIDEWALKER_MOVETO(pUnit)
	pUnit:MoveTo(116.25,1289.74,-21.50,4.68)
	end
	
	
	RegisterUnitEvent(498322, 1, "ZA.VAR.PRIMALTIDEWALKER_Events")
		RegisterUnitEvent(498322, 4, "ZA.VAR.PRIMALTIDEWALKER_Events")
			RegisterUnitEvent(498322, 18, "ZA.VAR.PRIMALTIDEWALKER_Events")

	