RFC = {}
RFC.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044

function RFC.VAR.Tenebron_Spawn(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:StopChannel()
	pUnit:Land()
	pUnit:AIDisableCombat(false)
	pUnit:RemoveAura(61248)
end

function RFC.VAR.CONSTRUCT_SPAWNMAN(pUnit,Event)
	pUnit:MoveTo(-245.59,150.84,-18.37,0)
end

RegisterUnitEvent(14605, 18, "RFC.VAR.CONSTRUCT_SPAWNMAN")

function RFC.VAR.TWILIGHTFISSURE(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:SetMaxHealth(100000)
	pUnit:SetHealth(100000)
	pUnit:RegisterEvent("RFC.VAR.FISSURE_ERUPT", 5000, 1)
end

function RFC.VAR.datbeam(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:SetScale(.1)
end


RegisterUnitEvent(68938, 18, "RFC.VAR.datbeam")

function PLAYERCHECK_IFDEAD(pUnit,Event)
	-- NOT A CLUE what this is supposed to do
	--[[
	local PlayersAllAround = pUnit:GetInRangePlayers()
	if players ~= nil then
		if pUnit:GetDistanceYards(players) < 35 then
			if players:IsDead() == true then
				pUnit:Despawn(1,3000)
			end
		end
	end
	]]
end

function RFC.VAR.FISSURE_ERUPT(pUnit,Event)
	pUnit:CastSpell(50657)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 3.2 then
			if not players:IsDead() then
				pUnit:Strike(players,1,59127,2000,3050,1)
			end
		end
	end
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do
		if creatures:GetEntry() == 14605 then
			if pUnit:GetDistanceYards(creatures) < 3.5 then
				creatures:Kill(creatures)
			end
		end
	end
end

function RFC.VAR.SHADOWBOLTVOLLEYzz(pUnit,Event)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 40 then
			if players:IsAlive() then
				pUnit:CastSpellOnTarget(695,players)
			end
		end
	end
end

RegisterUnitEvent(30452, 18, "RFC.VAR.Tenebron_Spawn")
RegisterUnitEvent(30641, 18, "RFC.VAR.TWILIGHTFISSURE")

function RFC.VAR.CONSTRUCTSPAWNS(pUnit,Event)
	local chance = math.random(1,4)
	if chance == 1 then
		pUnit:SpawnCreature(14605, -231.37, 151.21, -18.58, 3.18, 14, 0)
	elseif chance == 2 then
		pUnit:SpawnCreature(14605, -240, 170.19, -18.42, 4.45, 14, 0)
	elseif chance == 3 then
		pUnit:SpawnCreature(14605, -259.89, 150.99, -18.84, 0.9, 14, 0)
	elseif chance == 4 then
		pUnit:SpawnCreature(14605, -248.29, 136.12, -18.48, 1.32, 14, 0)
	end
end


function RFC.VAR.TENE_Phase2(pUnit,Event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(61248)
		pUnit:SendChatMessage(14,0,"It is amusing to watch you struggle. Very well, witness how it is done.")
		pUnit:PlaySoundToSet(14128)
		pUnit:AIDisableCombat(true)
		pUnit:SetFlying()
		pUnit:RegisterEvent("RFC.VAR.AIRPHASE_LASER", 5000, 1)
		pUnit:MoveTo(-230.25,134.41,-5.53,2.2)
		local chance = math.random(1,4)
		if chance == 1 then
			pUnit:MoveTo(-230.25,134.41,-5.53,2.2)
		elseif chance == 2 then
			pUnit:MoveTo(-226.21,163.48,-8.34,3.65)
		elseif chance == 3 then
			pUnit:MoveTo(-255.63,166.06,-9.1,5.4)
		elseif chance == 4 then
			pUnit:MoveTo(-259.34,140.45,-9.63,0.4)
		end
		pUnit:RegisterEvent("RFC.VAR.RANDOMFLIGHTPATH", 8000, 4)
		pUnit:RegisterEvent("RFC.VAR.SHADOWFISSURE_RAWRT", 5000, 6)
		pUnit:RegisterEvent("RFC.VAR.GIVEHERASECOND", 32000, 1)
		pUnit:RegisterEvent("RFC.VAR.CONSTRUCTSPAWNS", 7000, 0)
		pUnit:RegisterEvent("PLAYERCHECK_IFDEAD", 2000, 0)
		pUnit:RegisterEvent("RFC.VAR.AIRPHASE_LASER", 15000, 1)
		pUnit:RegisterEvent("RFC.VAR.SHADOWBOLTVOLLEYzz", 3000, 0)
	end
end

function RFC.VAR.SHADOWFISSURE_RAWRT(pUnit,Event)
	local player = pUnit:GetRandomPlayer(0)
	if player then
		pUnit:CastSpellOnTarget(59127,player)
	end
end

function RFC.VAR.RANDOMFLIGHTPATH(pUnit,Event)
	local chance = math.random(1,4)
	if chance == 1 then
		pUnit:MoveTo(-230.25,134.41,-5.53,2.2)
	elseif chance == 2 then
		pUnit:MoveTo(-226.21,163.48,-8.34,3.65)
	elseif chance == 3 then
		pUnit:MoveTo(-255.63,166.06,-9.1,5.4)
	elseif chance == 4 then
		pUnit:MoveTo(-259.34,140.45,-9.63,0.4)
	end
end

function RFC.VAR.FLIGHTPHASE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:AIDisableCombat(true)
	pUnit:SetFlying()
	pUnit:CastSpell(61248)
	pUnit:MoveTo(-230.25,134.41,-5.53,2.2)
	local chance = math.random(1,4)
	if chance == 1 then
		pUnit:MoveTo(-230.25,134.41,-5.53,2.2)
	elseif chance == 2 then
		pUnit:MoveTo(-226.21,163.48,-8.34,3.65)
	elseif chance == 3 then
		pUnit:MoveTo(-255.63,166.06,-9.1,5.4)
	elseif chance == 4 then
		pUnit:MoveTo(-259.34,140.45,-9.63,0.4)
	end
	if math.random(1,2) == 1 then
		pUnit:SendChatMessage(14,0,"I am no mere dragon! You will find I am much, much, more...")
		pUnit:PlaySoundToSet(14127)
	else
		pUnit:SendChatMessage(14,0,"Arrogant little creatures! To challenge powers you do not yet understand.")
		pUnit:PlaySoundToSet(14126)
	end
	pUnit:RegisterEvent("RFC.VAR.AIRPHASE_LASER", 5000, 1)
	pUnit:RegisterEvent("RFC.VAR.RANDOMFLIGHTPATH", 8000, 4)
	pUnit:RegisterEvent("RFC.VAR.SHADOWBOLTVOLLEYzz", 3000, 0)
	pUnit:RegisterEvent("PLAYERCHECK_IFDEAD", 2000, 0)
	pUnit:RegisterEvent("RFC.VAR.AIRPHASE_LASER", 15000, 1)
	pUnit:RegisterEvent("RFC.VAR.SHADOWFISSURE_RAWRT", 5000, 6)
	pUnit:RegisterEvent("RFC.VAR.CONSTRUCTSPAWNS", 7000, 0)
	pUnit:RegisterEvent("RFC.VAR.GIVEHERASECOND", 32000, 1)
end

function RFC.VAR.GIVEHERASECOND(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:StopChannel()
	pUnit:MoveTo(-245.59,150.84,-18.37,0)
	pUnit:RegisterEvent("RFC.VAR.LANDPHASE", 4000, 1)
end

function RFC.VAR.LANDPHASE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RemoveAura(61248)
	pUnit:AIDisableCombat(false)
	pUnit:Land()
	pUnit:TeleportCreature(-245.59,150.84,-18.37)
	pUnit:RegisterEvent("RFC.VAR.FLIGHTPHASE", 22000, 1)
	pUnit:RegisterEvent("RFC.VAR.FLAMEBREATH", 10000, 0)
end

function RFC.VAR.Tenebron_Combat(pUnit,Event)
	pUnit:SendChatMessage(14,0,"You have no place here. Your place is among the departed.")
	pUnit:PlaySoundToSet(14122)
	pUnit:GetGameObjectNearestCoords(-236.57, 145.54, -18.81, 203624):SetByte(GAMEOBJECT_BYTES_1,0,1)
	pUnit:RegisterEvent("RFC.VAR.TENE_Phase2", 2000, 0)
	pUnit:RegisterEvent("RFC.VAR.FLAMEBREATH", 8000, 0)
	pUnit:RegisterEvent("RFC.VAR.SHADOWFISSURE_RAWRT", 10000, 0)
end

function RFC.VAR.WINGBUFFET(pUnit,Event)
	pUnit:CastSpell(51785)
end

function RFC.VAR.FLAMEBREATH(pUnit,Event)
	pUnit:CastSpell(9573)
end

function RFC.VAR.AIRPHASE_LASER(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	RFC[id] = RFC[id] or {VAR={}}
	RFC[id].VAR.Laser = pUnit:GetCreatureNearestCoords(-234.44, 156.56, -18.83,68938)
	pUnit:ChannelSpell(45576,RFC[id].VAR.Laser)
	pUnit:RegisterEvent("RFC.VAR.LASERFUNCTION", 1000, 7)
	pUnit:RegisterEvent("RFC.VAR.STOPCHANNEL", 9000, 1)
end

function RFC.VAR.STOPCHANNEL(pUnit,Event)
	pUnit:StopChannel()
end

function RFC.VAR.LASERFUNCTION(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	RFC[id] = RFC[id] or {VAR={}}
	RFC[id].VAR.Laser:CastSpell(39180)
	for _,players in pairs(RFC[id].VAR.Laser:GetInRangePlayers()) do
		if RFC[id].VAR.Laser:GetDistanceYards(players) < 3.5 then
			RFC[id].VAR.Laser:Strike(players,1,37826,500,800,2)
		end
	end
end


function RFC.VAR.FlameBuffet(pUnit,Event)
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
			pUnit:CastSpellOnTarget(23341,players)
		end
	end
end

function RFC.VAR.Tenebron_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Despawn(1000,6000)
	pUnit:GetGameObjectNearestCoords(-236.57, 145.54, -18.81, 203624):SetByte(GAMEOBJECT_BYTES_1,0,0)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do
		if creatures:GetEntry() == 14605 then
			creatures:Despawn(1,0)
		end
	end
end

function RFC.VAR.Tenebron_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:GetGameObjectNearestCoords(-236.57, 145.54, -18.81, 203624):SetByte(GAMEOBJECT_BYTES_1,0,0)
	local object = pUnit:GetGameObjectNearestCoords(-319.36,221.85,-21.71, 3263492)
	if object then
		object:Despawn(1,0)
	end
	pUnit:AIDisableCombat(false)
	pUnit:SendChatMessage(14,0,"I should not... have held back...")
	pUnit:PlaySoundToSet(14129)
	if pUnit:IsFlying() then -- incase it dies flightphase
		pUnit:TeleportCreature(-245.59,150.84,-18.37)
	else
		pUnit:TeleportCreature(-245.59,150.84,-18.37)
	end
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do
		if creatures:GetEntry() == 14605 then
			creatures:Despawn(1,0)
		end
	end
end


function RFC.VAR.Tenebron_SLAY(pUnit,Event)
	if math.random(1,2) == 1 then
		pUnit:SendChatMessage(14,0,"No contest.")
		pUnit:PlaySoundToSet(14123)
	else
		pUnit:SendChatMessage(14,0,"Typical... just as I was having fun.")
		pUnit:PlaySoundToSet(14123)
	end
end

RegisterUnitEvent(30452, 1, "RFC.VAR.Tenebron_Combat")
RegisterUnitEvent(30452, 4, "RFC.VAR.Tenebron_DEAD")
RegisterUnitEvent(30452, 2, "RFC.VAR.Tenebron_LEAVE")
RegisterUnitEvent(30452, 3, "RFC.VAR.Tenebron_SLAY")

function RFC.VAR.TENEBRON_Leash(pUnit,Event)
	for _,creature in pairs(pUnit:GetInRangeUnits()) do
		if creature:GetEntry() == 30452 then
			if pUnit:GetDistanceYards(creature) < 5 and creature:IsAlive() then
				if not creature:IsFlying() then
					creature:Despawn(1000,5000)
					creature:RemoveEvents()
					creature:GetGameObjectNearestCoords(-236.57, 145.54, -18.81, 203624):SetByte(GAMEOBJECT_BYTES_1,0,0)
				end
			end
		end
	end
end
			
function RFC.VAR.TENEBRON_Leasher(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("RFC.VAR.TENEBRON_Leash", 1000, 0)
end

RegisterUnitEvent(447999,18, "RFC.VAR.TENEBRON_Leasher")

function RFC.VAR.RANDOMWHISPERGUY_ISSPAWNED(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("RFC.VAR.WHISPERING_VOICE", 35000, 0)
end

RegisterUnitEvent(477190,18, "RFC.VAR.RANDOMWHISPERGUY_ISSPAWNED")

function RFC.VAR.WHISPERING_VOICE(pUnit,Event)
	local player = pUnit:GetRandomPlayer(0)
	if player then
		if pUnit:GetDistanceYards(player) < 100 then
			local chance = math.random(1,9)
			if chance == 1 then
				pUnit:SendChatMessageToPlayer(15,0,"Trust is your weakness...", player)
				player:PlaySoundToPlayer(14373)
			elseif chance == 2 then
				pUnit:SendChatMessageToPlayer(15,0,"Hope is an illusion...", player)
				player:PlaySoundToPlayer(14374)
			elseif chance == 3 then
				pUnit:SendChatMessageToPlayer(15,0,"All that you know will fade...", player)
				player:PlaySoundToPlayer(14375)
			elseif chance == 4 then
				pUnit:SendChatMessageToPlayer(15,0,"You will be alone in the end...", player)
				player:PlaySoundToPlayer(14372)
			elseif chance == 5 then
				pUnit:SendChatMessageToPlayer(15,0,"There is no escape... not in this life... not in the next...", player)
				player:PlaySoundToPlayer(14381)
			elseif chance == 6 then
				pUnit:SendChatMessageToPlayer(15,0,"They are coming for you...", player)
				player:PlaySoundToPlayer(14376)
			elseif chance == 7 then
				pUnit:SendChatMessageToPlayer(15,0,"Give in to your fear...", player)
				player:PlaySoundToPlayer(14377)
			elseif chance == 8 then
				pUnit:SendChatMessageToPlayer(15,0,"Tell yourself again that these are not truly your friends...", player)
				player:PlaySoundToPlayer(14380)
			elseif chance == 9 then
				pUnit:SendChatMessageToPlayer(15,0,"It WAS your fault...", player)
				player:PlaySoundToPlayer(14383)
			end
		end
	end
end

----

function RFC.VAR.DAEVROC_EVENTS(pUnit,Event)
	if Event == 1 then
		pUnit:SpawnGameObject(3263492, -319.36,221.85,-21.71,0, 0, 200)
		pUnit:SendChatMessage(14,0,"Fool mortals. Hurl yourselves into your own demise!")
		pUnit:PlaySoundToSet(50050)
		pUnit:RegisterEvent("DAEVROC_METEORS", math.random(28000,32000), 0)
		pUnit:RegisterEvent("RFC.VAR.DAEVROC_AFTERBURN", math.random(11000,14000), 0)
		pUnit:RegisterEvent("RFC.VAR.RFCKnockbackCreatureSpawn", math.random(18000,22000), 0)
		pUnit:RegisterEvent("RFC.VAR.DAEVROC_QUIVSTRIKE", math.random(8000,12000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(-319.36,221.85,-21.71, 3263492)
		if object then
			object:Despawn(1,0)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 71706 or creatures:GetEntry() == 920602 then
				if pUnit:GetDistanceYards(creatures) < 25 then
					creatures:Despawn(1,0)
				end
			end
		end
	elseif Event == 3 then
		if math.random(1,2) == 1 then
			pUnit:SendChatMessage(14,0,"You have been judged.")
			pUnit:PlaySoundToSet(50057)
		elseif choice == 2 then
			pUnit:SendChatMessage(14,0,"Behold your weakness.")
			pUnit:PlaySoundToSet(50055)
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"Mortal filth... the master's keep is forbidden.")
		pUnit:PlaySoundToSet(50051)
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
		if players:HasAchievement(60015) == false then
					players:AddAchievement(60015)
					end
						if (players:GetQuestObjectiveCompletion(6800, 0) == 0) then
					players:MarkQuestObjectiveAsComplete(6800, 0)
					end
	end
	end
		local object = pUnit:GetGameObjectNearestCoords(-319.36,221.85,-21.71, 3263492)
		if object then
			object:Despawn(1,0)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 71706 or creatures:GetEntry() == 920602 then
				if pUnit:GetDistanceYards(creatures) < 25 then
					creatures:Despawn(1,0)
				end
			end
		end
	end
end

function DAEVROC_METEORS(pUnit)
	if math.random(1,2) == 1 then
		pUnit:SendChatMessage(14,0,"Your flesh is forfeit to the fires of this realm.")
		pUnit:PlaySoundToSet(50053)
	else
		pUnit:SendChatMessage(14,0,"Burn beneath my molten fury!")
		pUnit:PlaySoundToSet(50054)
	end
	for _,players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 5.5 then
			if players:IsAlive() then
				pUnit:CastSpellOnTarget(26789,players)	
				pUnit:SpawnCreature(920602, players:GetX(), players:GetY(), players:GetZ(), 0, 35, 30000)		
			end
		end
	end
end

function RFC.VAR.DAEVROC_QUIVSTRIKE(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 7 then
			pUnit:CastSpellOnTarget(72422,tank)
		end
	end
end

function RFC.VAR.DAEVROC_AFTERBURN(pUnit)
	pUnit:CastSpell(59183)
	pUnit:PlaySoundToSet(50056)
end
	
function RFC.VAR.RFCKnockbackCreatureSpawn(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if not plr then
		return;
	end
	pUnit:SpawnCreature(71706, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 21, 30000)
	pUnit:SpawnCreature(920602, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 35, 30000)
end
	
RegisterUnitEvent(437821, 1, "RFC.VAR.DAEVROC_EVENTS")
RegisterUnitEvent(437821, 2, "RFC.VAR.DAEVROC_EVENTS")
RegisterUnitEvent(437821, 3, "RFC.VAR.DAEVROC_EVENTS")
RegisterUnitEvent(437821, 4, "RFC.VAR.DAEVROC_EVENTS")


function RFC.VAR.ENSLAVED_BEING(pUnit,Event)
	if Event == 1 then
		pUnit:RegisterEvent("RFC.VAR.ENSLAVED_SPAWNDAMAGED",  math.random(14000,17000),0)
		pUnit:RegisterEvent("RFC.VAR.ENSLAVED_BLASTWAVE",  math.random(8000,10000),1)
		pUnit:RegisterEvent("RFC.VAR.RANDOMLASER_ACTION",  math.random(15000,16000),1)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 68938 then
				creatures:StopChannel()
			elseif creatures:GetEntry() == 920603 or creatures:GetEntry() == 920602 then
				creatures:Despawn(1,0)
			end
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(-299.89,-31.09,-60.70, 3267531)
		if object then
			object:Despawn(1,0)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 68938 then
				creatures:StopChannel()
			elseif creatures:GetEntry() == 920603 or creatures:GetEntry() == 920602 then
				creatures:Despawn(1,0)
			end
		end
	end
end

function RFC.VAR.ENSLAVED_BLASTWAVE(pUnit)
	pUnit:CastSpell(23113)
	pUnit:SpawnCreature(920602,pUnit:GetX(), pUnit:GetY(),pUnit:GetZ(),pUnit:GetO(), 35,0)
	pUnit:RegisterEvent("RFC.VAR.ENSLAVED_BLASTWAVE",  math.random(12000,14000),1)
end

function RFC.VAR.ENSLAVED_SPAWNDAMAGED(pUnit)
	if pUnit:GetHealthPct() < 99 then
		pUnit:SpawnCreature(920603,pUnit:GetX()+math.random(1,5), pUnit:GetY()+math.random(1,5),pUnit:GetZ(),pUnit:GetO(), 14, 0)
	end
end	

function RFC.VAR.RANDOMLASER_ACTION(pUnit)
	pUnit:SendChatMessage(42,0,"T'luraag unleashes beams of fire upon the ground!")
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 68938 then
			if pUnit:GetDistanceYards(creatures) < 25 then
				creatures:ChannelSpell(45576,pUnit)
				creatures:RegisterEvent("RFC.VAR.LASERFUNCTIONZ", 1000, 15)
				creatures:RegisterEvent("RFC.VAR.STOPCHANNEL", 16000, 1)
			end
		end
	end
	pUnit:RegisterEvent("RFC.VAR.RANDOMLASER_ACTION",  math.random(36000,37000),1)
end

function RFC.VAR.LASERFUNCTIONZ(pUnit,Event)
	pUnit:CastSpell(39180)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 3.5 then
			pUnit:Strike(players,1,37826,360,400,2)
		end
	end
	for _,v in pairs(pUnit:GetInRangeUnits()) do
		if v:IsPet() and v:GetDistanceYards(pUnit) < 3.5 then
			pUnit:Strike(v,1,37826,360,400,2)
			pUnit:AIDisableCombat(true)
		end
	end
end

RegisterUnitEvent(920412, 1, "RFC.VAR.ENSLAVED_BEING")
RegisterUnitEvent(920412, 2, "RFC.VAR.ENSLAVED_BEING")
RegisterUnitEvent(920412, 4, "RFC.VAR.ENSLAVED_BEING")
		
		
function RFC.VAR.GENERALKAK_EVENTS(pUnit,Event)
	if Event == 1 then
		pUnit:SpawnGameObject(3263492, -115.02,20.27,-18.86,4.17, 0, 200)
		if math.random(1,2) == 1 then
			pUnit:SendChatMessage(14,0,"Ours is the TRUE Horde! The only Horde!")
			pUnit:PlaySoundToSet(10323)
		elseif choice == 2 then
			pUnit:SendChatMessage(14,0,"I'll grind the meat from your bones!")
			pUnit:PlaySoundToSet(10324)
		end
		pUnit:RegisterEvent("RFC.VAR.GENERALK_SWEEPSTRIKES", math.random(10000,15000), 1)
		pUnit:RegisterEvent("RFC.VAR.SPAMCHARGE", math.random(16000,19000), 0)
		pUnit:RegisterEvent("RFC.VAR.GENERALK_SPAWNPEOPLE", math.random(22000,25000), 1)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(-115.02,20.27,-18.86,4.17, 3263492)
		if object then
			object:Despawn(1,0)
		end
		pUnit:Despawn(3000,5000)
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 17370 then
				if pUnit:GetDistanceYards(creatures) < 25 then
					creatures:Despawn(1,0)
				end
			end
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12,0,"The true Horde... will prevail.")
		pUnit:PlaySoundToSet(10328)
		local object = pUnit:GetGameObjectNearestCoords(-176.65,75.61,-21.88, 3267531)
		if object then
			object:Despawn(1,0)
		end
		local object = pUnit:GetGameObjectNearestCoords(-115.02,20.27,-18.86,4.17, 3263492)
		if object then
			object:Despawn(1,0)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 17370 then
				if pUnit:GetDistanceYards(creatures) < 25 then
					creatures:Despawn(1,0)
				end
			end
		end
	end
end
		
function RFC.VAR.SPAMCHARGE(pUnit,Event)
	pUnit:RegisterEvent("RFC.VAR.GENERALK_RANDOMCHARGE", 1000, 4)
end

RegisterUnitEvent(16808, 1, "RFC.VAR.GENERALKAK_EVENTS")
RegisterUnitEvent(16808, 2, "RFC.VAR.GENERALKAK_EVENTS")
RegisterUnitEvent(16808, 4, "RFC.VAR.GENERALKAK_EVENTS")

function RFC.VAR.GENERALK_RANDOMCHARGE(pUnit)
	local player = pUnit:GetRandomPlayer(0)
	if player then
		if player:IsAlive() then
			if pUnit:GetDistanceYards(player) < 20 then
				pUnit:CastSpellOnTarget(51492,player)
				if not player:HasAura(11574) then
					pUnit:CastSpellOnTarget(11574,player)
				end
			end
		end
	end
end

function RFC.VAR.GENERALK_SPAWNPEOPLE(pUnit)
	pUnit:SpawnCreature(17370,pUnit:GetX()+math.random(1,5), pUnit:GetY()+math.random(1,5),pUnit:GetZ(),pUnit:GetO(), 14, 0)
	pUnit:RegisterEvent("RFC.VAR.GENERALK_SPAWNPEOPLE", math.random(25000,45000), 1)
end
	
function RFC.VAR.GENERALK_SWEEPSTRIKES(pUnit)
	pUnit:CastSpell(18765)
	pUnit:RegisterEvent("RFC.VAR.GENERALK_SWEEPSTRIKES", math.random(27000,30000), 1)
end
