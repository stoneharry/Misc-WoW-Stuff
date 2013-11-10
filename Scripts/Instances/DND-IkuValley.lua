IK = {}
IK.VAR = {}

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


SetDBCSpellVar(82010, "c_is_flags", 0x01000)

--[[//INDEX//
1. //ISKULASH//
2.//SHADOW OF HATE//
]]



function IK.VAR.EnslavedProto_events(pUnit,Event)
if Event == 1 then
pUnit:RemoveEvents()
elseif Event == 18 then
pUnit:RegisterEvent("IK.VAR.EnslavedProto_emote", 2000, 0)
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:RegisterEvent("IK.VAR.EnslavedProto_emote", 2000, 0)
elseif Event == 4 then
pUnit:RemoveEvents()
end
end


function IK.VAR.EnslavedProto_emote(pUnit,Event)
if not pUnit:IsInCombat() then
pUnit:Emote(455,8000)
else
pUnit:Emote(0,1000)
end
end

RegisterUnitEvent(24083, 18, "IK.VAR.EnslavedProto_events")
RegisterUnitEvent(24083, 1, "IK.VAR.EnslavedProto_events")
RegisterUnitEvent(24083, 2, "IK.VAR.EnslavedProto_events")
RegisterUnitEvent(24083, 4, "IK.VAR.EnslavedProto_events")


function IK.VAR.Intructor_events(pUnit,Event)
if Event == 1 then
pUnit:RemoveEvents()
pUnit:RegisterEvent("IK.VAR.DARKMENDING", math.random(5000,8000), 0)
pUnit:RegisterEvent("IK.VAR.INST_RF", math.random(6500,11000), 0)
for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:IsInWorld() and unit:GetEntry() == 674321 and unit:IsAlive() and pUnit:GetDistanceYards(unit) < 20 then
		unit:StopChannel()
		local mtarget = pUnit:GetMainTank()
			if mtank ~= nil then
		unit:Attack(mtarget)
		unit:MoveTo(mtarget:GetX(), mtarget:GetY(),mtarget:GetZ(),mtarget:GetO())
		unit:SetMovementFlags(2)
		end
		end
	end
if math.random(1,5) <= 1 then
pUnit:SendChatMessage(12,0,"Use what I have taught you against them!")
elseif math.random(1,5) <= 2 then
pUnit:SendChatMessage(12,0,"They are corrupt, they must be put down!")
elseif math.random(1,5) <= 3 then
pUnit:SendChatMessage(12,0,"Dispose of these intruders!")
end
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:RegisterEvent("IK.VAR.zTusskarr_Emotes_Training", 1000, 1)
elseif Event == 4 then
pUnit:RemoveEvents()
pUnit:Unroot()
end
end


function IK.VAR.DARKMENDING(pUnit,Event)
if pUnit:GetCurrentSpellId() == nil then
pUnit:Root()
	local FriendsAllAround = pUnit:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if friends ~= nil then
   if pUnit:GetDistanceYards(friends) < 15 then
  if friends:GetHealthPct() < 50 then
  if friends:IsDead() == false then
  pUnit:FullCastSpellOnTarget(62328,friends)
  pUnit:RegisterEvent("IK.VAR.UNROOTCASTERKTYZ", 2200, 1)
end
end
end
end
end
end
end

function IK.VAR.INST_RF(pUnit,Event)
		local tank = pUnit:GetMainTank()
		if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 10 then
pUnit:CastSpellOnTarget(61596,tank)
end
end
end

function IK.VAR.UNROOTCASTERKTYZ(pUnit,Event)
if pUnit:GetCurrentSpellId() == nil then
if pUnit:IsRooted() == true then
pUnit:Unroot()
end
end
end


RegisterUnitEvent(674322, 1, "IK.VAR.Intructor_events")
RegisterUnitEvent(674322, 2, "IK.VAR.Intructor_events")
RegisterUnitEvent(674322, 4, "IK.VAR.Intructor_events")

function IK.VAR.soh_spawn_quick(pUnit,Event)
pUnit:Unroot()
pUnit:CastSpell(39180)
end

RegisterUnitEvent(66981, 18, "IK.VAR.soh_spawn_quick")

function IK.VAR.Initiatei_events(pUnit,Event)
if Event == 1 then
pUnit:StopChannel()
for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:IsInWorld() and unit:IsAlive() and pUnit:GetDistanceYards(unit) < 20 and unit:GetEntry() == 674321 or unit:GetEntry() == 674322 then
		unit:StopChannel()
		local mtarget = pUnit:GetMainTank()
			if mtank ~= nil then
		unit:Attack(mtarget)
		unit:MoveTo(mtarget:GetX(), mtarget:GetY(),mtarget:GetZ(),mtarget:GetO())
		unit:SetMovementFlags(2)
		end
		end
	end
elseif Event == 2 then
pUnit:RemoveEvents()
elseif Event == 4 then
pUnit:RemoveEvents()
pUnit:CastSpell(39180)
pUnit:SpawnCreature(66981,pUnit:GetX(), pUnit:GetY(),pUnit:GetZ(),0, 16, 120000)
elseif Event == 18 then
pUnit:CastSpell(30987)
end
end


RegisterUnitEvent(674321, 18, "IK.VAR.Initiatei_events")
RegisterUnitEvent(674321, 1, "IK.VAR.Initiatei_events")
RegisterUnitEvent(674321, 2, "IK.VAR.Initiatei_events")
RegisterUnitEvent(674321, 4, "IK.VAR.Initiatei_events")

function IK.VAR.Ik_Instructor_EmoteHandlezz(pUnit, Event)
	pUnit:RegisterEvent("IK.VAR.zTusskarr_Emotes_Training", 1000, 1)
	pUnit:CastSpell(30987)
	pUnit:CastSpell(46804)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:IsInWorld() and unit:GetEntry() == 674321 and unit:IsAlive() and pUnit:GetDistanceYards(unit) < 18 then
		unit:ChannelSpell(53069,pUnit)
end
end
end

function IK.VAR.zTusskarr_Emotes_Training(pUnit)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:IsInWorld() and unit:GetEntry() == 337921 and unit:IsAlive() and unit:IsInCombat() == false and pUnit:GetDistanceYards(unit) < 18 then 
			unit:Emote(469, 9900)
			pUnit:Emote(474,9900)
		end
	end
	pUnit:RegisterEvent("IK.VAR.zDoAttacKEmote_Tuskarrs", 10000, 1)
end

function IK.VAR.zDoAttacKEmote_Tuskarrs(pUnit)
	for _,unit in pairs(pUnit:GetInRangeUnits()) do
		if unit:IsInWorld() and unit:GetEntry() == 674321 and unit:IsAlive() and unit:IsInCombat() == false and pUnit:GetDistanceYards(unit) < 18 then
			unit:Emote(35, 1000)
			unit:ChannelSpell(53069,pUnit)
			unit:CastSpell(51920)
		end
	end
	pUnit:RegisterEvent("IK.VAR.zTusskarr_Emotes_Training", 1100, 1)
end

RegisterUnitEvent(674322, 18, "IK.VAR.Ik_Instructor_EmoteHandlezz")

--[[//ISKULASH//]]





function IK.VAR.TAINTEDSHADOW_SPAWN(pUnit,Event)
pUnit:RegisterEvent("IK.VAR.UNITMOVE_FIRSTBOSS", 1000, 1)
end

RegisterUnitEvent(44129, 18, "IK.VAR.TAINTEDSHADOW_SPAWN")


function IK.VAR.TAINTEDSHADOW_DEATH(pUnit,Event)
pUnit:RemoveEvents()
pUnit:CastSpell(70663)
pUnit:SpawnCreature(449822,pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 0)
end

function IK.VAR.TAINTEDSHADOW_COMBAT(pUnit,Event)
pUnit:RegisterEvent("IK.VAR.TAINTEDSHADOW_FISSURE", math.random(8000,11000), 0)
pUnit:RegisterEvent("IK.VAR.TAINTEDSHADOW_CLAW", math.random(5000,6500), 0)
end

RegisterUnitEvent(44129, 4, "IK.VAR.TAINTEDSHADOW_DEATH")
RegisterUnitEvent(44129, 1, "IK.VAR.TAINTEDSHADOW_COMBAT")

function IK.VAR.UNITMOVE_FIRSTBOSS(pUnit,Event)
pUnit:MoveTo(-15154.07,-14180.09,112.82,3.25)
end




function IK.VAR.SHADOWBOLTVOLLEY_CORR(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 40 then
			if players:IsDead() == false then
				pUnit:CastSpellOnTarget(695,players)
			end
		end
	end
end


function IK.VAR.CORRUPTEDADD_COMBAT(pUnit,Event)
pUnit:RegisterEvent("IK.VAR.SHADOWBOLTVOLLEY_CORR", math.random(8000,11000), 0)
end

function IK.VAR.CORRUPTEDADD_DEATH(pUnit,Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(449822, 1, "IK.VAR.CORRUPTEDADD_COMBAT")
RegisterUnitEvent(449822, 4, "IK.VAR.CORRUPTEDADD_DEATH")


function IK.VAR.TAINTEDSHADOW_FISSURE(pUnit,Event)
local player = pUnit:GetRandomPlayer(0)
	if player ~= nil then
		pUnit:CastSpellOnTarget(59127,player)
	end
end

function IK.VAR.TAINTEDSHADOW_CLAW(pUnit,Event)
local tank = pUnit:GetMainTank()
	if tank ~= nil then
		pUnit:CastSpellOnTarget(15608,tank)
	end
end


function IK.VAR.ISKULASH_EVENTS(pUnit,Event)
if Event == 1 then
pUnit:RegisterEvent("IK.VAR.ISKULASH_DEFILE", 6000, 0)
pUnit:RegisterEvent("IK.VAR.ISKULASH_BREATH", 10000,0)
pUnit:SendChatMessage(14,0,"My awakening is complete! You shall all perish!")
		pUnit:PlaySoundToSet(12427)
local go = pUnit:GetGameObjectNearestCoords(-15803.97, -13649.73, 11.00, 203624)
		if go ~= nil then
			go:SetByte(0x0006+0x000B,0,1)
end
elseif Event == 2 then
local go = pUnit:GetGameObjectNearestCoords(-15803.97, -13649.73, 11.00, 203624)
		if go ~= nil then
			go:SetByte(0x0006+0x000B,0,0)
end
elseif Event == 3 then
	pUnit:SendChatMessage(14,0,"You were warned!")
			pUnit:PlaySoundToSet(12426)
elseif Event == 4 then
local go = pUnit:GetGameObjectNearestCoords(-15803.97, -13649.73, 11.00, 203624)
		if go ~= nil then
			go:SetByte(0x0006+0x000B,0,0)
end
	end
	end


RegisterUnitEvent(423112, 1, "IK.VAR.ISKULASH_EVENTS")
RegisterUnitEvent(423112, 3, "IK.VAR.ISKULASH_EVENTS")
RegisterUnitEvent(423112, 2, "IK.VAR.ISKULASH_EVENTS")


	function IK.VAR.ISKULASH_DEFILE(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		if plr:IsAlive() then
			if pUnit:GetDistanceYards(plr) < 40 then
			pUnit:SpawnCreature(920060, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 15, 0)
			end
		end
	end
end


function IK.VAR.ISKULASH_BREATH(pUnit,Event)
pUnit:SetOrientation(pUnit:GetO())
pUnit:AIDisableCombat(true)
pUnit:Root()
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:FullCastSpell(74806)
pUnit:RegisterEvent("SP.VAR.DEVILSAUR_BREATH_CAST", 1700, 1)
end

function IK.VAR.ISKULASH_BREATH_CAST(pUnit,Event)
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end

--[[//SHADOW OF HATRED//]]




function IK.VAR.SHAHATRED_DIALOGUEZZ(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:RegisterEvent("IK.VAR.SHAHATE_DETECTPLRS", 1000, 0)
end

RegisterUnitEvent(948102, 18, "IK.VAR.SHAHATRED_DIALOGUEZZ")

function IK.VAR.SHAHATE_DETECTPLRS(pUnit,Event)
for _,plr in pairs(pUnit:GetInRangePlayers()) do
		if plr:GetDistanceYards(pUnit) < 15 then
		if not plr:IsDead() then
		pUnit:RemoveEvents()
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 423112 then
		creatures:SendChatMessage(14,0,"I need... your help... Cannot... resist him... much longer...")
		end
pUnit:PlaySoundToSet(18166)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
--pUnit:RegisterEvent("IK.VAR.SHAHATRED_DIALOGUEONE", 7100, 1)
			end
			end
		end
	end
end

function IK.VAR.SHAHATRED_DIALOGUEONE(pUnit,Event)
		pUnit:SendChatMessage(14,0,"You pitiful weaklings!")
pUnit:PlaySoundToSet(18180)
pUnit:RegisterEvent("IK.VAR.ISK_DIALOGUEONE", 8100, 1)
end

function IK.VAR.SHAHATRED_DIALOGUETWO(pUnit,Event)
		pUnit:SendChatMessage(14,0,"Even your strongest warriors, succumb like lambs to the slaughter!")
pUnit:PlaySoundToSet(18181)
pUnit:RegisterEvent("IK.VAR.SHAHATRED_DIALOGUETHREE", 9100, 1)
end

function IK.VAR.SHAHATRED_DIALOGUETHREE(pUnit,Event)
		pUnit:SendChatMessage(14,0,"Your turn will come, hate will turn you all against one another until this world burns!")
pUnit:PlaySoundToSet(18182)
end


function IK.VAR.ISK_DIALOGUEONE(pUnit,Event)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 423112 then
		creatures:SendChatMessage(14,0,"Aaahhh! Help me, before I lose my mind!")
		end
pUnit:PlaySoundToSet(18182)
pUnit:RegisterEvent("IK.VAR.ISK_DIALOGUETWO", 15000, 1)
end
	end
	
function IK.VAR.ISK_DIALOGUETWO(pUnit,Event)
for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 423112 then
		creatures:SendChatMessage(14,0,"Hurry! There is not much of me left!")
				end
pUnit:PlaySoundToSet(18182)
pUnit:RegisterEvent("IK.VAR.SHAHATRED_DIALOGUETWO", 6500, 1)
end
end
