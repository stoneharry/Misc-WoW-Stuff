

BWL = {}
BWL.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

SetDBCSpellVar(22280, "c_is_flags", 0x01000)
SetDBCSpellVar(70953, "c_is_flags", 0x01000)
SetDBCSpellVar(41107, "c_is_flags", 0x01000)

--[[Developers Log:
Forgemaster Trash: INCOMPLETE
Forgemaster:COMPLETE
Serinar Trash: COMPLETE
Serinar The Corrupt: COMPLETE
Zurtrogg Trash: INCOMPLETE
Zurtrogg: INCOMPLETE
Verius: COMPLETE

LOOT: INCOMPLETE
]]

function BWL.VAR.SERINAR_SPEAK_OnSpawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("BWL.VAR.SERINAR_SPEAK_CheckingForPlayer",1500,0)
end

RegisterUnitEvent(77095, 18, "BWL.VAR.SERINAR_SPEAK_OnSpawn")

function BWL.VAR.FOGGUYSPAWN(pUnit,Event)
	 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	 pUnit:RegisterEvent("BWL.VAR.FOGGUYSPAWNDelay", 1000, 1)
end

function BWL.VAR.FOGGUYSPAWNDelay(pUnit)
	pUnit:CastSpell(69126)
end

RegisterUnitEvent(77092,18, "BWL.VAR.FOGGUYSPAWN") 

function BWL.VAR.JANE_SPAWN(pUnit,Event)
	pUnit:AIDisableCombat(true)
	pUnit:Root()
end

RegisterUnitEvent(77110,18, "BWL.VAR.JANE_SPAWN") 

function BWL.VAR.Slime_spawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("BWL.VAR.SSlime_Damage", 1000, 0)
	pUnit:RegisterEvent("BWL.VAR.SSlime_Cast", 800, 1)
	pUnit:RegisterEvent("BWL.VAR.SLIME_SPAWN_CREATURE", 10000, 1)
end

function BWL.VAR.SSlime_Cast(pUnit)
	pUnit:CastSpell(45212)
end

RegisterUnitEvent(391902, 18, "BWL.VAR.Slime_spawn")

function BWL.VAR.SENTRYCONSTRUCT(pUnit,Event)
	if Event == 18 then
		pUnit:ModifyRunSpeed(16)
		pUnit:ModifyWalkSpeed(14)
		pUnit:SetMovementFlags(1)
		pUnit:RegisterEvent("BWL.VAR.SENTRYCONSTRUCT_MOVE", 1000, 1)
		pUnit:RegisterEvent("BWL.VAR.CONSTRUCT_LIGHTNING", 1500, 0)
	elseif Event == 2 or Event == 4 then
		pUnit:RemoveEvents()
	end
end

RegisterUnitEvent(24972,2, "BWL.VAR.SENTRYCONSTRUCT") 
RegisterUnitEvent(24972,4, "BWL.VAR.SENTRYCONSTRUCT") 
RegisterUnitEvent(24972,18, "BWL.VAR.SENTRYCONSTRUCT") 

function BWL.VAR.WHELPLING_SERINAR_FIGHT_SPAWN(pUnit,Event)
	pUnit:ModifyRunSpeed(18)
	pUnit:ModifyWalkSpeed(18)
	pUnit:RegisterEvent("BWL.VAR.SERINAR_ADD_MOVE",1000,1)
end

RegisterUnitEvent(77098,18, "BWL.VAR.WHELPLING_SERINAR_FIGHT_SPAWN") 

function BWL.VAR.SLIMECREATURE_EVENTS(pUnit,Event)
	if Event == 18 then
		pUnit:Unroot()
		pUnit:RegisterEvent("BWL.VAR.SLIMECREATURE_SELFDESTRUCT", 2000, 1)
		pUnit:RegisterEvent("BWL.VAR.SENTRYCONSTRUCT_MOVE", 1000, 1)
	elseif Event == 2 or Event == 4 then
		pUnit:RemoveEvents()
	end
end

RegisterUnitEvent(16024,18,"BWL.VAR.SLIMECREATURE_EVENTS")
RegisterUnitEvent(16024,2,"BWL.VAR.SLIMECREATURE_EVENTS") 
RegisterUnitEvent(16024,4,"BWL.VAR.SLIMECREATURE_EVENTS") 

function BWL.VAR.GATEWATCHER_EVENTS(pUnit,Event)
	if Event == 1 then
		pUnit:SendChatMessage(14,0,"You have approximately five seconds to live.")
		pUnit:PlaySoundToSet(11109)
		local object = pUnit:GetGameObjectNearestCoords(-7481.85, -961.09, 449.81, 186859)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,1)
		end
		pUnit:RegisterEvent("BWL.VAR.GATEWATCHER_SHADOWPOWER", 20000, 1)
		pUnit:RegisterEvent("BWL.VAR.OVERLOADED", 30000, 0)
		pUnit:RegisterEvent("BWL.VAR.ENRAGETIMER_GATEWATCHER", 2000, 0)
		pUnit:RegisterEvent("BWL.VAR.GATEWATCHER_FLUID", 10000, 0)
	elseif Event == 2 then
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		BWL[id] = BWL[id] or {VAR={}}
		pUnit:RemoveEvents()
		BWL[id].VAR.EnrageTimer = 0
		local object = pUnit:GetGameObjectNearestCoords(-7481.85, -961.09, 449.81, 186859)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,0)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 24972 or creatures:GetEntry() == 391902 or creatures:GetEntry() == 16024 then
			creatures:Despawn(1,0)
		end
		pUnit:Despawn(1000,7000)
	end
	elseif Event == 3 then
		local chance = math.random(1,2)
		if chance == 1 then
			pUnit:SendChatMessage(14,0,"A foregone conclusion.")
			pUnit:PlaySoundToSet(11110)
		else
			pUnit:SendChatMessage(14,0,"The processing will continue as scheduled.")
			pUnit:PlaySoundToSet(11111)
		end
	elseif Event == 4 then
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		BWL[id] = BWL[id] or {VAR={}}
		pUnit:RemoveEvents()
		BWL[id].VAR.EnrageTimer = 0
		pUnit:SendChatMessage(14,0,"My calculations did not...")
		pUnit:PlaySoundToSet(11114)
		local object = pUnit:GetGameObjectNearestCoords(-7481.85, -961.09, 449.81, 186859)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,0)
		end
		object = pUnit:GetGameObjectNearestCoords(-7566.60, -1031.02, 449.14, 179365)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,0)
		end
		for _,gasses in pairs(pUnit:GetInRangeObjects()) do 
			if gasses:GetEntry() == 3266452 then
				gasses:Despawn(1,0)
			end
		end  
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 77089 or creatures:GetEntry() == 24972 or creatures:GetEntry() == 391902 or creatures:GetEntry() == 16024 then
				creatures:Despawn(1,0)
			elseif creatures:GetEntry() == 77088 then
				creatures:RemoveEvents()
			end
		end
		for _,players in pairs(pUnit:GetInRangePlayers()) do
			if players:HasAura(22280) then
				players:RemoveAura(22280)
			end
		end
	elseif Event == 18 then
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		BWL[id] = BWL[id] or {VAR={}}
		BWL[id].VAR.Gatewatcher = pUnit
	end	
end

RegisterUnitEvent(77091, 3, "BWL.VAR.GATEWATCHER_EVENTS")
RegisterUnitEvent(77091, 1, "BWL.VAR.GATEWATCHER_EVENTS")
RegisterUnitEvent(77091, 4, "BWL.VAR.GATEWATCHER_EVENTS")
RegisterUnitEvent(77091, 2, "BWL.VAR.GATEWATCHER_EVENTS")
RegisterUnitEvent(77091, 18, "BWL.VAR.GATEWATCHER_EVENTS")	
	
function BWL.VAR.GATEWATCHER_SHADOWPOWER(pUnit,Event)
	pUnit:Root()
	pUnit:FullCastSpell(39193)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
	pUnit:AIDisableCombat(true)
	pUnit:SendChatMessage(42,0,"Gatewatcher Gork'lonn Begins to cast Shadow Power!")
	pUnit:RegisterEvent("BWL.VAR.GATEWATCHER_SHADOWPOWERUNROOTREGISTER", 2200, 1)
end

function BWL.VAR.GATEWATCHER_SHADOWPOWERUNROOTREGISTER(pUnit,Event)
	if not pUnit:HasAura(39193) then
		pUnit:CastSpell(39193)
	end
	pUnit:Unroot()
	pUnit:AIDisableCombat(false)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	pUnit:RegisterEvent("BWL.VAR.GATEWATCHER_SHADOWPOWER", 20000, 1)
end

function BWL.VAR.GATEWATCHER_FLUID(pUnit,Event)
	if pUnit:GetCurrentSpellId() == nil then
		pUnit:CastSpell(35311)
		pUnit:RegisterEvent("BWL.VAR.GATEWATCHER_FLUID_HANGOVER", 1000, 1)
	end
end

function BWL.VAR.GATEWATCHER_FLUID_HANGOVER(pUnit)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
			if players:HasAura(35311) then
				pUnit:SpawnCreature(391902,players:GetX() , players:GetY(), players:GetZ(),players:GetO(), 35, 15000)
			end
		end
	end
end

function BWL.VAR.OVERLOADED(pUnit,Event)
	pUnit:RemoveEvents()
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BWL[id] = BWL[id] or {VAR={}}
	if BWL[id].VAR.EnrageTimer == nil then BWL[id].VAR.EnrageTimer = 0 end
	BWL[id].VAR.EnrageTimer = BWL[id].VAR.EnrageTimer + 1
	pUnit:Unroot()
	pUnit:RemoveEvents()
	pUnit:AIDisableCombat(false)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	pUnit:SendChatMessage(42,0,"Gatewatcher Gork'lonn Becomes overloaded with power!")
	pUnit:SendChatMessage(14,0,"With the precise angle and velocity...")
	pUnit:PlaySoundToSet(11112)
	pUnit:RegisterEvent("BWL.VAR.OVERLOADED_STRIKE", 1500, 0)
	pUnit:RegisterEvent("BWL.VAR.LIGHTNING_STRIKE", 8000, 0)
	pUnit:RegisterEvent("BWL.VAR.CONSTRUCT", 14790, 0)
	--pUnit:RegisterEvent("BWL.VAR.LIGHTNING_WHIRL", 6000, 0)
	pUnit:RegisterEvent("BWL.VAR.ENRAGETIMER_GATEWATCHER", 2000, 0)
	pUnit:RegisterEvent("BWL.VAR.OVERLOAD_FINISHED", 30000, 1)
end

function BWL.VAR.LIGHTNING_STRIKE(pUnit)
	pUnit:CastSpell(52944)
end

function BWL.VAR.LIGHTNING_WHIRL(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 12 then
			pUnit:CastSpellOnTarget(54429,tank)
		end
	end
end

function BWL.VAR.OVERLOADED_STRIKE(pUnit)
	local player = pUnit:GetRandomPlayer(0)
	if player then
		if pUnit:GetDistanceYards(player) < 40 then
			pUnit:CastSpellOnTarget(61586,player)
			player:CastSpell(45935)
			pUnit:Strike(player, 2, 29768, 280, 330, 2)
		end
	end
end

function BWL.VAR.CONSTRUCT(pUnit)
	local construct = nil
	for _,v in pairs(pUnit: GetInRangeUnits() ) do
		if v:GetEntry() == 27641 then
			construct = v
			break
		end
	end
	if construct then
		pUnit:SendChatMessage(42,0,"A Sentry comes to life!")
		construct:CastSpell(61883)
		construct:SpawnCreature(24972, construct:GetX(), construct:GetY(), construct:GetZ(), construct:GetO(), 14, 0)
		construct:Despawn(2000,14000)
	end
end

function BWL.VAR.CONSTRUCT_LIGHTNING(pUnit)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 5 then
			if players:IsAlive() then
				pUnit:CastSpellOnTarget(61586,players)
				players:CastSpell(28136)
				pUnit:Strike(players, 2, 29768, 140, 270, 1)
			end
		end
	end
end

function BWL.VAR.SENTRYCONSTRUCT_MOVE(pUnit)
	for _,creature in pairs(pUnit:GetInRangeUnits()) do 
		if creature:GetEntry() == 77091 then 
			if creature:IsInCombat() then
				pUnit:MoveTo(creature:GetX(),creature:GetY(),creature:GetZ(),creature:GetO())
			end
		end
	end
end


function BWL.VAR.OVERLOAD_FINISHED(pUnit,Event)
	pUnit:RemoveEvents()
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BWL[id] = BWL[id] or {VAR={}}
	if BWL[id].VAR.EnrageTimer == nil then BWL[id].VAR.EnrageTimer = 0 end
	BWL[id].VAR.EnrageTimer = BWL[id].VAR.EnrageTimer + 1
	pUnit:SendChatMessage(42,0,"Gatewatcher Gork'lonn returns to normal.")
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("BWL.VAR.GATEWATCHER_SHADOWPOWER", 20000, 0)
	pUnit:RegisterEvent("BWL.VAR.OVERLOADED", 35000, 0)
	pUnit:RegisterEvent("BWL.VAR.GATEWATCHER_FLUID", 10000, 0)
	pUnit:RegisterEvent("BWL.VAR.ENRAGETIMER_GATEWATCHER", 2000, 0)
end

function BWL.VAR.ENRAGETIMER_GATEWATCHER(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BWL[id] = BWL[id] or {VAR={}}
	if BWL[id].VAR.EnrageTimer == 9 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(42,0,"Gatewatcher Gork'lonn Explodes into a power overload.")
		for _,players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 65 then
				if players:IsAlive() then
					pUnit:CastSpellOnTarget(66528,players)
				end
			end
		end
	end
end
----
function BWL.VAR.SSlime_Damage(pUnit)
	pUnit:CastSpell(45212)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 6 then
			pUnit:Strike(players,1,69508,140,160,2)
		end
	end
end

function BWL.VAR.SLIME_SPAWN_CREATURE(pUnit)
	pUnit:SpawnCreature(16024,pUnit:GetX() ,pUnit:GetY(), pUnit:GetZ(),pUnit:GetO(), 14,0)
end

function BWL.VAR.SLIMECREATURE_SELFDESTRUCT(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Root()
	pUnit:CastSpell(67751)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
	pUnit:SendChatMessage(16,0,"Embalming Slime begins to erupt!")
	pUnit:RegisterEvent("BWL.VAR.SLIMECREATURE_SELFDESTRUCT_TRIGGER", 4000, 1)
end

function BWL.VAR.SLIMECREATURE_SELFDESTRUCT_TRIGGER(pUnit)
	pUnit:CastSpell(25938)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 10 then
			pUnit:Strike(players,1,69669,140,160,1)
			players:RemoveAura(22280)
		end
	end
	pUnit:Kill(pUnit)
end

function BWL.VAR.SERINAR_EVENTS(pUnit,Event)
	if Event == 1 then
		pUnit:SendChatMessage(14,0,"My awakening is complete! You shall all perish!")
		pUnit:PlaySoundToSet(12427)
		local object = pUnit:GetGameObjectNearestCoords(-7693.61, -1052.60, 440.67, 3263492)
		if object then
			object:SetPhase(1)
		end
		pUnit:RegisterEvent("BWL.VAR.SERINAR_CORRUPT_CYCLONE_PHASE",22000,1) 
		pUnit:RegisterEvent("BWL.VAR.SERINAR_BREATH",12000,0) 
		pUnit:RegisterEvent("BWL.VAR.SERINAR_CLEAVE",8000,0) 
		pUnit:RegisterEvent("BWL.VAR.UNROOTCASTERKTY",1000,0) 
		pUnit:RegisterEvent("BWL.VAR.SERINAR_SPAWN_WHELPLINGS",18000,0)
		pUnit:RegisterEvent("BWL.VAR.SERINAR_ENRAGE",360000,1)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:RemoveAura(26662)
		local object = pUnit:GetGameObjectNearestCoords(-7693.61, -1052.60, 440.67, 3263492)
		if object then
			object:SetPhase(2)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 77097 then
				creatures:SetPhase(2)
			elseif creatures:GetEntry() == 68940 or creatures:GetEntry() == 77098 then
				creatures:Despawn(1,0)
			end
		end
		pUnit:Despawn(1000,4000)
	elseif Event == 3 then
		local chance = math.random(1,2)
		if chance == 1 then
			pUnit:SendChatMessage(14,0,"In the name of Kil'jaeden!")
			pUnit:PlaySoundToSet(12425)
		else
			pUnit:SendChatMessage(14,0,"You were warned!")
			pUnit:PlaySoundToSet(12426)
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"At last the agony ends. I have failed you my Queen... I have failed us all...")
		local object = pUnit:GetGameObjectNearestCoords(-7693.61, -1052.60, 440.67, 3263492)
		if object then
			object:SetPhase(2)
		end
		object = pUnit:GetGameObjectNearestCoords(-7621.51, -932.77, 441.23, 3267531)
		if object then
			object:Despawn(1,0)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 77097 or creatures:GetEntry() == 68940 or creatures:GetEntry() == 77098 then
				creatures:Despawn(1,0)
			end
		end
	elseif Event == 18 then
		pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 3)
		pUnit:Unroot()
		pUnit:RemoveAura(26662)
	end
end

RegisterUnitEvent(77094, 1, "BWL.VAR.SERINAR_EVENTS")
RegisterUnitEvent(77094, 2, "BWL.VAR.SERINAR_EVENTS")
RegisterUnitEvent(77094, 3, "BWL.VAR.SERINAR_EVENTS")
RegisterUnitEvent(77094, 4, "BWL.VAR.SERINAR_EVENTS")
RegisterUnitEvent(77094, 18, "BWL.VAR.SERINAR_EVENTS")

function BWL.VAR.SERINAR_ENRAGE(pUnit)
	pUnit:SendChatMessage(14,0,"I will purge you!")
	pUnit:PlaySoundToSet(12423)
	pUnit:CastSpell(26662)
end

function BWL.VAR.SERINAR_SPAWN_WHELPLINGS(pUnit)
	pUnit:SendChatMessage(42,0,"Whelplings have hatched from nearby eggs!")
	for _,eggs in pairs(pUnit:GetInRangeObjects()) do 
		if eggs:GetEntry() == 3260477 then
			eggs:Despawn(2000,12000)
			eggs:SetByte(GAMEOBJECT_BYTES_1,0,1)
			pUnit:SpawnCreature(77098,eggs:GetX() , eggs:GetY(), eggs:GetZ(), eggs:GetO(), 14, 3600000)
		end
	end
end


function BWL.VAR.SERINAR_CORRUPT_CYCLONE_PHASE(pUnit,Event)
	pUnit:SendChatMessage(42,0,"Fire Cyclones have emerged!")
	pUnit:SendChatMessage(14,0,"Your pain has only begun!")
	pUnit:PlaySoundToSet(12424)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 77097 then
			creatures:SetPhase(1)
		end
	end
	pUnit:RegisterEvent("BWL.VAR.SERINAR_CORRUPT_CYCLONEPHASE_OVER",27000,1) 
end

function BWL.VAR.SERINAR_CORRUPT_CYCLONEPHASE_OVER(pUnit,Event)
	pUnit:SendChatMessage(42,0,"The fire begins to subdue")
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 77097 then
			creatures:SetPhase(2)
		end
	end
	pUnit:RegisterEvent("BWL.VAR.SERINAR_CORRUPT_CYCLONE_PHASE",27000,1) 
end



function BWL.VAR.SERINAR_CLEAVE(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 7 then
			pUnit:CastSpellOnTarget(19983,tank)
		end
	end
end

function BWL.VAR.SERINAR_BREATH(pUnit)
	if pUnit:GetCurrentSpellId() == nil then
		pUnit:Root()
		pUnit:FullCastSpell(51219)
	end
end

function BWL.VAR.UNROOTCASTERKTY(pUnit)
	if pUnit:GetCurrentSpellId() == nil then
		if pUnit:IsRooted() then
			pUnit:Unroot()
		end
	end
end

function BWL.VAR.SERINAR_ADD_MOVE(pUnit)
	--[[for _,creature in pairs(pUnit:GetInRangeUnits()) do 
		if creature:GetEntry() == 77094 then 
			if creature:IsInCombat() then
				pUnit:MoveTo(creature:GetX(),creature:GetY(),creature:GetZ(),creature:GetO())
			end
		end
	end]]
	-- Above is very ineffecient, doesn't break when finding the creature either.
	-- Below should be more effecient
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if pUnit:GetDistanceYards(plr) < 40 then
			pUnit:AttackReaction(plr, 1, 0)
		else
			pUnit:SetMovementFlags(1)
			pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
		end
	end
end

function BWL.VAR.CYCLONEPULL(pUnit)
	pUnit:CastSpell(57560)
	if pUnit:IsInPhase(1) then
		for _,players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 7 then
				if players:IsAlive() then
					pUnit:SendChatMessageToPlayer(42,0,"A cyclone has pulled you in!",players)
					players:MoveKnockback(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 10, 20)
				end
			end
		end
	end
end
  
function BWL.VAR.CYCLONE_SPAWN_FIRE(pUnit)
	pUnit:CastSpell(57560)
	if pUnit:IsInPhase(1) then
		pUnit:SpawnCreature(68940,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 35, 12000)
	end
end
  
  
function BWL.VAR.FIRECYCLONE_SPAWN(pUnit,Event)
	pUnit:CastSpell(57560)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("BWL.VAR.CYCLONEPULL",2000,0) 
	pUnit:RegisterEvent("BWL.VAR.CYCLONE_SPAWN_FIRE",1200,0) 
end

RegisterUnitEvent(77097, 18, "BWL.VAR.FIRECYCLONE_SPAWN")

function BWL.VAR.TREMORDAMAGE(pUnit)
	pUnit:CastSpell(63547)
	if pUnit:IsInPhase(1) then
		for _,players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 5.5 then
				if players:IsAlive() then
					pUnit:Strike(players,1,1535,280,360,1)
				end
			end
		end
	end
end

function BWL.VAR.GROUNDTREMOR_SPAWN(pUnit,Event)
	pUnit:ModifyRunSpeed(18)
	pUnit:ModifyWalkSpeed(17)
	pUnit:SetMovementFlags(1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("BWL.VAR.TREMORDAMAGE",1000,0) 
end

RegisterUnitEvent(77243, 18, "BWL.VAR.GROUNDTREMOR_SPAWN")

---SERINAR TRASH AND EVENTS --

function BWL.VAR.WHELPHANDLER_COMBAT(pUnit,Event)
	pUnit:SendChatMessage(16,0,"Darkshield Whelp Handler calls for nearby whelps to assist him!")
	local tank = pUnit:GetMainTank()
	if tank then
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 77096 then
				if pUnit:GetDistanceYards(creatures) < 20 then
					creatures:AttackReaction(tank, 1, 0) 
				end
			end
		end
	end
end

RegisterUnitEvent(17455, 1, "BWL.VAR.WHELPHANDLER_COMBAT")

function BWL.VAR.FELGUARD_DESTROYER_COMBAT(pUnit,Event)
	pUnit:RegisterEvent("BWL.VAR.FELGUARD_TEMPEST",13000,0)
	pUnit:RegisterEvent("BWL.VAR.FELGUARD_DESTROYER_METEORSTRIKE",9000,0)
	pUnit:RegisterEvent("BWL.VAR.FELGUARD_METEOR_ON_CASTERS",6000,0)
end

function BWL.VAR.FELGUARDESTROYER_EV(pUnit)
if pUnit:GetAreaId() == 467 then
pUnit:SetMaxHealth(42304)
pUnit:SetHealth(42304)
end
	end
	
	function BWL.VAR.FELWHELPS_EV(pUnit)
if pUnit:GetAreaId() == 467 then
pUnit:SetMaxHealth(3144)
pUnit:SetHealth(3144)
end
	end
	
	RegisterUnitEvent(77096,18, "BWL.VAR.FELWHELPS_EV")

function BWL.VAR.FELGUARD_DESTROYER_METEORSTRIKE(pUnit)
	pUnit:CastSpell(26789)
end

function BWL.VAR.FELGUARD_METEOR_ON_CASTERS(pUnit)
	local plr = pUnit:GetRandomPlayer(3)
	if plr then
		if pUnit:GetDistanceYards(plr) < 30 then
			if plr:IsAlive() then
				pUnit:CastSpellOnTarget(26789,plr)
			end
		end
	end
end

function BWL.VAR.FELGUARD_TEMPEST(pUnit)
	pUnit:CastSpell(75125)
end

RegisterUnitEvent(18977,1, "BWL.VAR.FELGUARD_DESTROYER_COMBAT")
RegisterUnitEvent(18977,18, "BWL.VAR.FELGUARDESTROYER_EV")
RegisterUnitEvent(18977,2, "BWL.VAR.SENTRYCONSTRUCT") 
RegisterUnitEvent(18977,4, "BWL.VAR.SENTRYCONSTRUCT") 

function BWL.VAR.ARCHEREVENT_OnSpawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("BWL.VAR.ARCHEREVENT_CheckingForPlayer",1500,0)
end

RegisterUnitEvent(77148, 18, "BWL.VAR.ARCHEREVENT_OnSpawn")

function BWL.VAR.ARCHEREVENT_CheckingForPlayer(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BWL[id] = BWL[id] or {VAR={}}
	local player = pUnit:GetClosestPlayer()
	if player then
		if pUnit:GetDistanceYards(player) < 15 then
			pUnit:RemoveEvents()
			if BWL[id].VAR.Bloodguard == nil then
				BWL[id].VAR.Bloodguard = pUnit:GetCreatureNearestCoords(-7685.85,-1119.01,449.09,20923)
				BWL[id].VAR.Bloodguard:SendChatMessage(14,0,"Archers, form ranks! On my mark!")
				BWL[id].VAR.Bloodguard:PlaySoundToSet(10156)
				pUnit:RegisterEvent("BWL.VAR.ARCHEREVENT_READY",5000,1)
			else
				BWL[id].VAR.Bloodguard = nil
				BWL[id].VAR.Bloodguard = pUnit:GetCreatureNearestCoords(-7685.85,-1119.01,449.09,20923)
				BWL[id].VAR.Bloodguard:SendChatMessage(14,0,"Archers, form ranks! On my mark!")
				BWL[id].VAR.Bloodguard:PlaySoundToSet(10156)
				pUnit:RegisterEvent("BWL.VAR.ARCHEREVENT_READY",5000,1)
			end
		end
	end
end

function BWL.VAR.ARCHEREVENT_READY(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BWL[id] = BWL[id] or {VAR={}}
	if BWL[id].VAR.Bloodguard then
		BWL[id].VAR.Bloodguard:SendChatMessage(14,0,"Ready!")
		BWL[id].VAR.Bloodguard:PlaySoundToSet(10157)
		pUnit:RegisterEvent("BWL.VAR.ARCHEREVENT_AIM",3000,1)
	end
end

function BWL.VAR.ARCHEREVENT_AIM(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BWL[id] = BWL[id] or {VAR={}}
	if BWL[id].VAR.Bloodguard then
		BWL[id].VAR.Bloodguard:SendChatMessage(14,0,"Aim!")
		BWL[id].VAR.Bloodguard:PlaySoundToSet(10158)
		pUnit:RegisterEvent("BWL.VAR.ARCHEREVENT_FIRE",3000,1)
	end
end

function BWL.VAR.ARCHEREVENT_FIRE(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BWL[id] = BWL[id] or {VAR={}}
	if BWL[id].VAR.Bloodguard then
		BWL[id].VAR.Bloodguard:SendChatMessage(14,0,"Fire!")
		BWL[id].VAR.Bloodguard:PlaySoundToSet(10159)
						BWL[id].VAR.Bloodguard:RegisterEvent("BWL.VAR.ARCHER_SHOOTPLAYERS",2000,0)
			end
		end


function BWL.VAR.ARCHER_SHOOTPLAYERS(pUnit)
	for _,creatures in pairs(BWL[id].VAR.Bloodguard:GetInRangeUnits()) do 
			if creatures:GetEntry() == 17427 then
		local plr = creatures:GetClosestPlayer()
		if plr then
			if creatures:GetDistanceYards(plr) < 50 then
				if plr:IsInPhase(1) then
					if plr:IsAlive() then
						creatures:CastSpellOnTarget(30221,plr)
						creatures:SpawnCreature(68940,plr:GetX() , plr:GetY(), plr:GetZ(), plr:GetO(), 35, 15000):CastSpell(19823)
					end
				end
			end
		end
		end
	end
end

--END ARCHER

function BWL.VAR.SERINAR_SPEAK_CheckingForPlayer(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BWL[id] = BWL[id] or {VAR={}}
	local player = pUnit:GetClosestPlayer()
	if player then
		if pUnit:GetDistanceYards(player) < 5 then
			pUnit:RemoveEvents()
			if not BWL[id].VAR.Serinar then
				BWL[id].VAR.Serinar = pUnit:GetCreatureNearestCoords(-7621.21,-976.83,440.05, 77094)
				BWL[id].VAR.Serinar:SendChatMessage(14,0,"I beg you Mortals, flee! Flee before I lose all sense of control. The Black Fire rages within my heart. I must release it!")
				BWL[id].VAR.Serinar:PlaySoundToSet(8282)
				BWL[id].VAR.Serinar:RegisterEvent("BWL.VAR.SERINAR_SPEAK_LINE_TWO",15000,1)
			else
				BWL[id].VAR.Serinar = nil
				BWL[id].VAR.Serinar = pUnit:GetCreatureNearestCoords(-7621.21,-976.83,440.05, 77094)
				BWL[id].VAR.Serinar:SendChatMessage(14,0,"I beg you Mortals, flee! Flee before I lose all sense of control. The Black Fire rages within my heart. I must release it!")
				BWL[id].VAR.Serinar:PlaySoundToSet(8282)
				BWL[id].VAR.Serinar:RegisterEvent("BWL.VAR.SERINAR_SPEAK_LINE_TWO",15000,1)
			end
		end
	end
end

function BWL.VAR.SERINAR_SPEAK_LINE_TWO(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BWL[id] = BWL[id] or {VAR={}}
	if not BWL[id].VAR.Serinar then
		BWL[id].VAR.Serinar = pUnit:GetCreatureNearestCoords(-7621.21,-976.83,440.05, 77094)
		BWL[id].VAR.Serinar:SendChatMessage(14,0,"FLAME! DEATH! DESTRUCTION! COWER MORTALS BEFORE THE WRATH OF LORD V....NO! I MUST FIGHT THIS! ALEXSTRASZA, HELP ME! I MUST FIGHT!")
		BWL[id].VAR.Serinar:PlaySoundToSet(8283)
	end
end

function BWL.VAR.ZURTROGG_SPWN(pUnit,Event)
	pUnit:ChannelSpell(75129,pUnit)
	pUnit:RegisterEvent("BWL.VAR.zzFINDPLAYERS",2000,0)
end

RegisterUnitEvent(322246, 18, "BWL.VAR.ZURTROGG_SPWN")

function BWL.VAR.DURNSPAWN(pUnit,Event)
	pUnit:CastSpell(67924)
end

RegisterUnitEvent(18411, 18, "BWL.VAR.DURNSPAWN")

function BWL.VAR.zzFINDPLAYERS(pUnit,Event)
	local player = pUnit:GetClosestPlayer()
	if player then
		if pUnit:GetDistanceYards(player) < 5 then
			pUnit:RemoveEvents()
			pUnit:SendChatMessage(14,0,"Ah, the Heroes, you are persistent aren't you? This Gronn here attempted to match his power against mine....and paid the price. Now he shall serve me. By slaughtering you.")
			pUnit:SetOrientation(5.3)
			pUnit:SetFacing(5.3)
			pUnit:Emote(1,3000)
			pUnit:StopChannel()
			pUnit:RegisterEvent("BWL.VAR.zzzFOUNDPLAYERS_NEXTEVENT",7000,1)
		end
	end
end

function BWL.VAR.zzzFOUNDPLAYERS_NEXTEVENT(pUnit,Event)
	pUnit:SendChatMessage(14,0,"Good luck.")
	pUnit:MoveTo(-7533.30,-1010.95,408.59,3.27)
	pUnit:Despawn(7000,0)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("BWL.VAR.zzzGRONNACTIVE",4000,1)
end

function BWL.VAR.zzzGRONNACTIVE(pUnit)
	local gronn = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 18411)
	if gronn then
		gronn:PlaySoundToSet(11355)
		gronn:RemoveAura(67924)
		gronn:SendChatMessage(14,0,"Come... and die.")
		gronn:SetFaction(14)
	end
end

---DURN FIGHT--

function BWL.VAR.DURN_REVERBERATION(pUnit)
	pUnit:CastSpell(36297)
end

function BWL.VAR.DURN_FORCEPUNCH(pUnit,Event)
	pUnit:Root()
	pUnit:FullCastSpell(34771)
	pUnit:RegisterEvent("BWL.VAR.DURN_UNROOT", 1100,1)
end

function BWL.VAR.DURN_TREMOR_PHASE(pUnit,Event)
	pUnit:SendChatMessage(14,0,"Beg for life!")
	pUnit:PlaySoundToSet(11359)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 77243 then
			creatures:SetPhase(1)
		end
	end
	pUnit:RegisterEvent("BWL.VAR.DURN_TREMORPHASE_OVER",27000,1) 
end

function BWL.VAR.DURN_TREMORPHASE_OVER(pUnit,Event)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 77243 then
			creatures:SetPhase(2)
		end
	end
	pUnit:RegisterEvent("BWL.VAR.DURN_TREMOR_PHASE",27000,1) 
end

function BWL.VAR.ROCKRUMBLE(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if pUnit:GetDistanceYards(plr) < 30 then
		if plr:IsAlive() then
			pUnit:CastSpellOnTarget(38777,plr)
		end
	end
end

function BWL.VAR.DURN_SHOCKWAVE(pUnit,Event)
	pUnit:SendChatMessage(14,0,"Scurry.")
	pUnit:PlaySoundToSet(11356)
	pUnit:AIDisableCombat(true)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
	pUnit:SetFacing(pUnit:GetO())
	pUnit:SendChatMessage(42,0,"Durn the Destroyer Begins to Cast \124cff71d5ff\124Hspell:58977\124h[Shockwave]\124h\124r")
	pUnit:Root()
	pUnit:RegisterEvent("BWL.VAR.DURN_SHOCKWAVECAST", 3000,1)
end

function BWL.VAR.DURN_SHOCKWAVECAST(pUnit,Event)
	pUnit:SetFacing(0)
	pUnit:CastSpell(58977)
	pUnit:Emote(51,1200)
	pUnit:SpawnCreature(8925, pUnit:GetX(), pUnit:GetY()+math.random(-10,-1), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SpawnCreature(8925, pUnit:GetX(), pUnit:GetY()+math.random(-7,-1), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SpawnCreature(8925, pUnit:GetX(), pUnit:GetY()+math.random(-6,-1), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SpawnCreature(8925, pUnit:GetX(), pUnit:GetY()+math.random(-5,-1), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SpawnCreature(8925, pUnit:GetX(), pUnit:GetY()+math.random(-10,-1), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SpawnCreature(8925, pUnit:GetX(), pUnit:GetY()+math.random(-10,-1), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:SpawnCreature(8925, pUnit:GetX(), pUnit:GetY()+math.random(-10,-1), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	pUnit:RegisterEvent("BWL.VAR.DURN_UNROOT", 1000,1)
	pUnit:RegisterEvent("BWL.VAR.DURN_SHOCKWAVE", 20000,1)
	local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 8925 then
			creatures:MoveTo(x, y, z, 0)
		end
	end
end

function BWL.VAR.DURN_UNROOT(pUnit)
	if not pUnit:GetCurrentSpellId() then
		if pUnit:IsRooted() then
			pUnit:Unroot()
			pUnit:AIDisableCombat(false)
			pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		end
	end
end

function BWL.VAR.DURN_EVENTS(pUnit,Event)
	if Event == 1 then
		pUnit:RegisterEvent("BWL.VAR.DURN_SHOCKWAVE", 20000,1)
		pUnit:RegisterEvent("BWL.VAR.DURN_TREMOR_PHASE",27000,1) 
		pUnit:RegisterEvent("BWL.VAR.DURN_REVERBERATION",  math.random(10000,15000),0)
		pUnit:RegisterEvent("BWL.VAR.ROCKRUMBLE", math.random(6000,8000),0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		pUnit:Unroot()
		pUnit:AIDisableCombat(false)
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 8925 then
				creatures:Despawn(1,0)
			elseif creatures:GetEntry() == 77243 then
				creatures:SetPhase(2)
			end
		end
		pUnit:Despawn(3000,4000)
	elseif Event == 3 then
		local chance = math.random(1,2)
		if chance == 1 then
			pUnit:PlaySoundToSet(11360)
			pUnit:SendChatMessage(14,0,"No more.")
		else
			pUnit:PlaySoundToSet(11360)
			pUnit:SendChatMessage(14,0,"Die.")
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(11363)
		local object = pUnit:GetGameObjectNearestCoords(-7535.77, -1011.47, 408.60, 3266685)
		if object then
			object:Despawn(1,0)
		end
		object = pUnit:GetGameObjectNearestCoords(-7489.64, -1049.43, 408.60, 3267148)
		if object then
			object:Despawn(1,0)
		end
		object = pUnit:GetGameObjectNearestCoords(-7449.33, -1022.54, 408.60, 3267148)
		if object then
			object:Despawn(1,0)
		end
		object = pUnit:GetGameObjectNearestCoords(-7553.13, -1022.98, 408.48, 176965)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,0)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 8925 then
				creatures:Despawn(1,0)
			elseif creatures:GetEntry() == 77243 then
				creatures:Despawn(1,0)
			end
		end
	end
end

RegisterUnitEvent(18411, 2, "BWL.VAR.DURN_EVENTS")
RegisterUnitEvent(18411, 3, "BWL.VAR.DURN_EVENTS")
RegisterUnitEvent(18411, 1, "BWL.VAR.DURN_EVENTS")
RegisterUnitEvent(18411, 4, "BWL.VAR.DURN_EVENTS")

function BWL.VAR.VERIUS_EVENTS(pUnit,Event)
	if Event == 1 then
		pUnit:RegisterEvent("BWL.VAR.VERIUSBANISH", 45000, 1)
		pUnit:RegisterEvent("BWL.VAR.VARIUS_METEORFISTS", 10000, 4)
		pUnit:RegisterEvent("BWL.VAR.FinalSpawnRAIN", 5000, 0)
		pUnit:RegisterEvent("BWL.VAR.VARIUS_RANDOMEVENT", 20000, 2)
		pUnit:RegisterEvent("BWL.VAR.VARIUS_ENRAGE", 300000, 1)
		pUnit:RegisterEvent("BWL.VAR.VERIUS_PHASE2", 2000, 0)
		pUnit:RegisterEvent("BWL.VAR.VERIUS_INFERNALSPAWNBALL", 15000, 3)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(-7553.13, -1022.98, 408.48, 176965)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,0)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 77110 then 
				creatures:StopChannel()
				creatures:SetNPCFlags(1)
				creatures:Despawn(2000,4000)
			elseif creatures:GetEntry() == 4676 or creatures:GetEntry() == 68940 then 
				creatures:Despawn(2000,0)
			end
		end
		pUnit:Despawn(2000,4000)
	elseif Event == 3 then
		local choice = math.random(1,3)
		if choice == 1 then
			pUnit:PlaySoundToSet(30034)
			pUnit:SendChatMessage(14,0,"Fall and die before me!")
		elseif choice == 2 then
			pUnit:PlaySoundToSet(30035)
			pUnit:SendChatMessage(14,0,"Squirm...Scream. Hahahaha!")
		elseif choice == 3 then
			pUnit:PlaySoundToSet(30036)
			pUnit:SendChatMessage(14,0,"Useless!")
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(18031)
		pUnit:SendChatMessage(14,0,"No... no! This victory will not be ripped from my grasp! I will not return to him in failure! I will not be torn from this pitiful world! No... NOOOOOOOO!!")
		local object = pUnit:GetGameObjectNearestCoords(-7553.13, -1022.98, 408.48, 176965)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,0)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 77110 then 
				creatures:StopChannel()
				creatures:RemoveAura(46957)
			elseif creatures:GetEntry() == 4676 or creatures:GetEntry() == 68940 then 
				creatures:Despawn(2000,0)
			end
		end
	elseif Event == 18 then
		pUnit:AIDisableCombat(true)
		pUnit:DisableCombat(0)
		pUnit:CastSpell(68862)
		pUnit:SetModel(18526)
		pUnit:SetScale(1)
		pUnit:CastSpell(54852)
		pUnit:EquipWeapons(29348,0,0)
		pUnit:SetFaction(35)
		pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
		pUnit:RemoveAura(66118)
		pUnit:RegisterEvent("BWL.VAR.VERIUS_CANFLAG", 1000, 1)
	end
end

RegisterUnitEvent(77180,18, "BWL.VAR.VERIUS_EVENTS") 
RegisterUnitEvent(77180, 2, "BWL.VAR.VERIUS_EVENTS")
RegisterUnitEvent(77180, 3, "BWL.VAR.VERIUS_EVENTS")
RegisterUnitEvent(77180, 1, "BWL.VAR.VERIUS_EVENTS")
RegisterUnitEvent(77180, 4, "BWL.VAR.VERIUS_EVENTS")

function BWL.VAR.VERIUS_CANFLAG(pUnit)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:SetFaction(16)
end

function BWL.VAR.VERIUS_PHASE2(pUnit,Event)
	if pUnit:GetHealthPct() < 50 then
		pUnit:RemoveEvents()
		pUnit:RemoveAura(68862)
		pUnit:RemoveAura(54852)
		pUnit:AIDisableCombat(false)
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 77110 then 
				creatures:StopChannel()
				creatures:RemoveAura(46957)
				creatures:FullCastSpellOnTarget(70616, pUnit)
				creatures:PlaySoundToSet(16609)
				creatures:SendChatMessage(14,0,"He's toying with us! I will show him what happens to ice when it meets fire!")
			end
		end
		pUnit:RegisterEvent("BWL.VAR.VERIUSCHANGING", 3100, 1)
	end
end

function BWL.VAR.VERIUS_FREEZERAID(pUnit)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 35 then
			if players:IsAlive() then
				pUnit:CastSpellOnTarget(66012,players)
			end
		end
	end
end

function BWL.VAR.VERIUSCHANGING(pUnit,Event)
	pUnit:CastSpell(46419)
	pUnit:SetModel(22711)
	pUnit:SetScale(.7)
	pUnit:EquipWeapons(0,0,0)
	pUnit:PlaySoundToSet(18033)
	pUnit:SendChatMessage(14,0,"Yes... yes! I can feel his burning eyes upon me, he is close...so close. And then your world will be unmade, your lives as nothing!")
	pUnit:CastSpell(42726)
	pUnit:RegisterEvent("BWL.VAR.CURSEOFAGONY", 8000, 0)
	pUnit:RegisterEvent("BWL.VAR.CINEMATICEVENTTWO", 2000, 1)
	pUnit:RegisterEvent("BWL.VAR.VARIUS_METEORFISTS", 10000, 0)
	pUnit:RegisterEvent("BWL.VAR.VERIUS_FREEZERAID", 15000, 0)
	pUnit:RegisterEvent("BWL.VAR.FinalSpawnRAIN", 5000, 0)
	pUnit:RegisterEvent("BWL.VAR.VERIUS_INFERNALSPAWNBALL", 15000, 0)
	pUnit:RegisterEvent("BWL.VAR.VARIUS_RANDOMEVENT", 20000, 0)
	pUnit:RegisterEvent("BWL.VAR.VARIUS_ENRAGE", 120000, 1)
	pUnit:RegisterEvent("BWL.VAR.VERIUS_FIRE", 7000, 0)
end

function BWL.VAR.CINEMATICEVENTTWO(pUnit)
	pUnit:RemoveAura(42726)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 77110 then 
			creatures:SendChatMessage(14,0,"I have given it my best, it is up to you champions to vanquish him!")
			creatures:CastSpell(46957)
		end
	end
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 75 then
			if players:IsAlive() then
				players:CastSpell(32182)
				players:RemoveAura(57723)
				players:RemoveAura(41107)
			end
		end
	end
end

function BWL.VAR.INFERNAL_BALLSPWN(pUnit,Event)
	pUnit:AIDisableCombat(true)
	pUnit:Unroot()
	pUnit:CastSpell(36055)
	pUnit:SetModel(11686)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("BWL.VAR.INFERNALFOLLOW_BALL", 1000, 1)
	pUnit:RegisterEvent("BWL.VAR.INFERALBALL_SPAWNINFERNAL", 8000, 1)
	pUnit:RegisterEvent("BWL.VAR.INFERNAL_FIRE", 1200, 0)
end

function BWL.VAR.INFERNAL_FIRE(pUnit)
	pUnit:CastSpell(36055)
	pUnit:SpawnCreature(68940,pUnit:GetX() , pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 35, 11000)
end

function BWL.VAR.VERIUSBANISH(pUnit,Event)
	pUnit:CastSpell(68862)
	pUnit:AIDisableCombat(true)
	pUnit:CastSpell(54852)
	pUnit:Emote(64,15000)
	pUnit:RegisterEvent("BWL.VAR.BANISHPHASEOVER_Rawr", 15000, 1)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 75 then
			players:CastSpell(41107)
		end
	end
end

function BWL.VAR.BANISHPHASEOVER_Rawr(pUnit,Event)
	pUnit:AIDisableCombat(false)
	pUnit:CastSpell(63660)
	pUnit:RemoveAura(54852)
	pUnit:RegisterEvent("BWL.VAR.JANE_RECHANNEL", 10000, 1)
	pUnit:RegisterEvent("BWL.VAR.VARIUS_METEORFISTS", 10000, 4)
	pUnit:RegisterEvent("BWL.VAR.VERIUSBANISH", 45000, 1)
	pUnit:RegisterEvent("BWL.VAR.VERIUS_INFERNALSPAWNBALL", 15000, 3)
	pUnit:RegisterEvent("BWL.VAR.VARIUS_RANDOMEVENT", 20000, 2)
	pUnit:RemoveAura(68862)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 77110 then 
			creatures:StopChannel()
			creatures:CastSpell(46957)
		end
	end
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 85 then
			players:CastSpell(47533)
			players:CastSpell(38016)
			players:RemoveAura(41107)
			players:CastSpell(38016)
			pUnit:SpawnCreature(68940,players:GetX() , players:GetY(), players:GetZ(),players:GetO(), 35, 18000)
		end
	end
end

function BWL.VAR.VERIUS_FIRE(pUnit)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 30 then
			if players:IsDead() == false then
				players:CastSpell(38016)
				pUnit:SpawnCreature(68940,players:GetX() , players:GetY(), players:GetZ(),players:GetO(), 35, 32000)
			end
		end
	end
end

function BWL.VAR.JANE_RECHANNEL(pUnit)
	local chance = math.random(1,2)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 77110 then 
			creatures:ChannelSpell(59069,pUnit)
			creatures:RemoveAura(46957)
			if chance == 1 then
				creatures:PlaySoundToSet(11006)
				creatures:SendChatMessage(14,0,"Don't give up! We must prevail!")
			elseif chance == 2 then
				creatures:PlaySoundToSet(11051)
				creatures:SendChatMessage(14,0,"We must hold strong!")
			end
			break
		end
	end
end

function BWL.VAR.CURSEOFAGONY(pUnit)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 65 then
			pUnit:CastSpellOnTarget(6217,players)
		end
	end
end

function BWL.VAR.VARIUS_METEORFISTS(pUnit)
	pUnit:CastSpell(67331)
end

function BWL.VAR.VERIUS_INFERNALSPAWNBALL(pUnit)
	pUnit:SpawnCreature(772190, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 8100)
end

function BWL.VAR.VARIUS_ENRAGE(pUnit,Event)
	pUnit:CastSpell(26662)
	pUnit:PlaySoundToSet(30037)
	pUnit:SendChatMessage(14,0,"Amanare maev il azgalada zila ashj ashj zila enkil!")
end

function BWL.VAR.VARIUS_RANDOMEVENT(pUnit)
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:PlaySoundToSet(18036)
		pUnit:CastSpell(37786)
	elseif choice == 2 then
		pUnit:PlaySoundToSet(18036)
		pUnit:CastSpell(35491)
	elseif choice == 3 then
		pUnit:PlaySoundToSet(18036)
		for _,players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 65 then
				pUnit:FullCastSpellOnTarget(64429, players) -- visual
				players:MoveKnockback(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 10, 20)
			end
		end
	end
end

---DUMMY FUNCTIONS --

function BWL.VAR.FinalSpawnRAIN(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		pUnit:SpawnCreature(771390, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 21, 15000)
	end
end

function BWL.VAR.RAINSPawnDa(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) -- Untargetable
	pUnit:RegisterEvent("BWL.VAR.CastRAINSpellDinal", 1000, 1)
end

function BWL.VAR.CastRAINSpellDinal(pUnit)
	pUnit:CastSpellAoF(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 39376)
	pUnit:RegisterEvent("BWL.VAR.CastRAINSpellDamage", 1000, 9)
end

function BWL.VAR.CastRAINSpellDamage(pUnit)
	for _,plrs in pairs(pUnit:GetInRangePlayers()) do
		if plrs:IsAlive() then
			if plrs:GetDistanceYards(pUnit) < 10 then
				pUnit:Strike(plrs,1,39376,350,480,1.1)
			end
		end
	end
end

RegisterUnitEvent(771390, 18, "BWL.VAR.RAINSPawnDa")


function BWL.VAR.FireDummyDamage(pUnit,Event)
	pUnit:CastSpell(42345)
	if pUnit:IsInPhase(1) then
		pUnit:AIDisableCombat(true)
		for _, players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 3.5 then
				if players:IsDead() == false then
					pUnit:Strike(players,1,1535,200,350,1)
				end
			end
		end
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:IsPet() then
				pUnit:Strike(v,1,1535,200,350,1)
			end
		end
	end
end
  
function BWL.VAR.FireDummySpawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:CastSpell(42345)
	pUnit:RegisterEvent("BWL.VAR.FireDummyDamage",1000,0) 
	if not pUnit:GetDisplay() == 50112 then
		pUnit:SetScale(0.6)
	end
end
  
RegisterUnitEvent(68940, 18, "BWL.VAR.FireDummySpawn")
RegisterUnitEvent(920602, 18, "BWL.VAR.FireDummySpawn")


function BWL.VAR.INFERNALFOLLOW_BALL(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		if plr:IsAlive() then
			if pUnit:GetDistanceYards(plr) < 40 then
				pUnit:ChannelSpell(60857,plr)
				pUnit:SetUnitToFollow(plr, 1, 0) 
				pUnit:MoveTo(plr:GetX(),plr:GetY(),plr:GetZ(),plr:GetO())
			end
		end
	end
end

function BWL.VAR.INFERALBALL_SPAWNINFERNAL(pUnit,Event)
	pUnit:Root()
	pUnit:Despawn(1000,0)
	pUnit:CastSpell(19823)
	pUnit:SpawnCreature(4676, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 0)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 3.5 then
			pUnit:CastSpellOnTarget(42299,players)
			pUnit:Strike(players,1,1535,400,450,1)
		end
	end
end

RegisterUnitEvent(772190,18, "BWL.VAR.INFERNAL_BALLSPWN") 

function BWL.VAR.VERIUSGOSSIPFIGHT_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(930, player,0)
	pUnit:GossipMenuAddItem(0, "Start fight.", 242, 0)
	pUnit:GossipSendMenu(player)
end

function BWL.VAR.VERIUSGOSSIPFIGHT_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 242) then
		player:GossipComplete()
		pUnit:SetNPCFlags(2)
		local object = pUnit:GetGameObjectNearestCoords(-7553.13, -1022.98, 408.48, 176965)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,1)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 77180 then 
				creatures:Emote(1,4000)
				creatures:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
				creatures:RemoveAura(68862)
				creatures:AIDisableCombat(false)
				creatures:PlaySoundToSet(18034)
				creatures:SendChatMessage(14,0,"Lord Sargeras, I will not fail you! Sweep your molten fist through this world so that it may be reborn in flames and darkness!")
				creatures:RemoveAura(54852)
				break
			end
		end
		pUnit:ChannelSpell(59069,creatures)
	end
end

RegisterUnitGossipEvent(77110, 1, "BWL.VAR.VERIUSGOSSIPFIGHT_On_Gossip")
RegisterUnitGossipEvent(77110, 2, "BWL.VAR.VERIUSGOSSIPFIGHT_Gossip_Submenus")