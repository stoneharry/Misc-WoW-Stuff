
UTG = {}
UTG.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

function UTG.VAR.SKARVAL(pUnit,Event)
	if Event == 1 then
		pUnit:RegisterEvent("UTG.VAR.ENDENCOUNTERCHECKER_GRAK", 2000, 0)
		pUnit:RegisterEvent("UTG.VAR.HARPOON", math.random(14000,16000), 0)
		pUnit:RegisterEvent("UTG.VAR.CONSTANTMOVING", 1000, 1)
		pUnit:RegisterEvent("UTG.VAR.SPAWNFIRES", 8000, 0)
		pUnit:RegisterEvent("UTG.VAR.PYROBLASTS", math.random(9000,12000), 0)
		local object = pUnit:GetGameObjectNearestCoords(379.24,93.22,30.74, 186608)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,1)
		end
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:SetHealth(55516)
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 29838 then 
				creatures:ReturnToSpawnPoint()
				--creatures:Despawn(1000,5000)
				creatures:SetHealth(41032)
				creatures:Emote(1,1000)
				creatures:RemoveAllAuras()
			elseif creatures:GetEntry() == 920741 or creatures:GetEntry() == 920742 or creatures:GetEntry() == 439182 then 
				creatures:Despawn(1,0)
			end
		end
		local object = pUnit:GetGameObjectNearestCoords(379.24,93.22,30.74, 186608)
		if object then
			object:SetByte(GAMEOBJECT_BYTES_1,0,0)
		end
	end
end

RegisterUnitEvent(29836, 1, "UTG.VAR.SKARVAL")
RegisterUnitEvent(29836, 2, "UTG.VAR.SKARVAL")
	
function UTG.VAR.HARPOON(pUnit,Event)
	local player = pUnit:GetRandomPlayer(0)
	if player then
		if player:IsAlive() then
			if pUnit:GetDistanceYards(player) < 50 then
				pUnit:CastSpellOnTarget(59633,player)
				pUnit:CastSpellOnTarget(31615,player)
			end
		end
	end
end
	
function UTG.VAR.SPAWNFIRES(pUnit,Event)
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 29838 then
			if math.random(1,2) == 1 then
				creatures:CastSpell(70367)
				pUnit:SpawnCreature(920742,pUnit:GetX()+math.random(-8,18), pUnit:GetY()+math.random(-8,18),pUnit:GetZ(),pUnit:GetO(), 14,34000)
			elseif choice == 2 then
				creatures:CastSpell(46332)
				pUnit:SpawnCreature(920741,pUnit:GetX()+math.random(-8,18), pUnit:GetY()+math.random(-8,18),pUnit:GetZ(),pUnit:GetO(), 14,34000)
			end
		end
	end
end

function UTG.VAR.PYROBLASTS(pUnit)
	local protodrake = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 29838)
	if protodrake then
		for _, players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 5 then
				if players:IsAlive() then
					protodrake:CastSpellOnTarget(12522,players)
				end
			end
		end
	end
end

function UTG.VAR.CONSTANTMOVING(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) > 5 then
			for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
				if creatures:GetEntry() == 29838 then 
					--creatures:Emote(35,80000)
					creatures:MoveTo(tank:GetX(),tank:GetY(),tank:GetZ(),tank:GetO())
				end
			end
		end
	end
	pUnit:RegisterEvent("UTG.VAR.CONSTANTMOVING", 4000, 1)
end

	
function UTG.VAR.ENDENCOUNTERCHECKER_GRAK(pUnit,Event)
	if pUnit:GetHealthPct() < 2 then
		local protodrake = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 29838)
		if protodrake then
			if protodrake:GetHealthPct() < 2 then
				pUnit:RemoveEvents()
				protodrake:RemoveEvents()
				protodrake:AIDisableCombat(true)
				protodrake:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
				protodrake:SetByteValue(UNIT_FIELD_BYTES_1, 0, 7)
				protodrake:Despawn(5000,0)
				for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
					if creatures:GetEntry() == 920741 or creatures:GetEntry() == 920742 or creatures:GetEntry() == 439182 then 
						creatures:Despawn(1,0)
					end
				end
				pUnit:ExitVehicle()
				pUnit:AIDisableCombat(true)
				pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 7)
				pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
				pUnit:SpawnGameObject(220412, 348.11, 193.56, 30.77, 5.026477, 300000, 200)
				local object = pUnit:GetGameObjectNearestCoords(379.24,93.22,30.74, 186608)
				if object then
					object:SetByte(GAMEOBJECT_BYTES_1,0,0)
				end
				local object = pUnit:GetGameObjectNearestCoords(332.61,229.69,30.74, 186608)
				if object then
					object:SetByte(GAMEOBJECT_BYTES_1,0,0)
				end
			end
		end
	end
end
	
function UTG.VAR.GOODFIRESPELLS(pUnit,Event)
	pUnit:CastSpell(42345)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 5 then
			if players:IsAlive()then
				pUnit:Strike(players,1,39376,250,350,1.1)
				players:RemoveAura(60588)
				players:RemoveAura(69391)
			end
		end
	end
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 439182 and pUnit:GetDistanceYards(creatures) < 5 then
			pUnit:Strike(creatures,1,39376,350,550,1.1)
		end
	end
end
  
function UTG.VAR.GOODFIRESpawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:CastSpell(42345)
	pUnit:RegisterEvent("UTG.VAR.GOODFIRESPELLS",1000,0) 
	pUnit:RegisterEvent("UTG.VAR.FIRE_KNOCKBACKSELF",1000,1) 
end
  
RegisterUnitEvent(920741, 18, "UTG.VAR.GOODFIRESpawn")


function UTG.VAR.BADFIRESPELLS(pUnit,Event)
	local firebad = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 29836)
	if firebad then
		for _, players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 5 then
				if players:IsAlive() then
					firebad:CastSpellOnTarget(60588,players)
					if not players:HasAura(69391) then
						players:CastSpell(69391)
					end
				end
			end
		end
	end
end
  
function UTG.VAR.BADFIRESpawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("UTG.VAR.BADFIRESPELLS",1500,0)
	pUnit:RegisterEvent("BADFIRE_SPAWNADD",math.random(10000,14000),0) 
	pUnit:RegisterEvent("UTG.VAR.FIRE_KNOCKBACKSELF",1000,1) 
end

function BADFIRE_SPAWNADD(pUnit)
	pUnit:SpawnCreature(439182,pUnit:GetX(), pUnit:GetY(),pUnit:GetZ(),pUnit:GetO(), 14,0)
end

function UTG.VAR.FIRE_KNOCKBACKSELF(pUnit)
	if pUnit:GetEntry() == 920741 then
		pUnit:CastSpell(38016)
	elseif pUnit:GetEntry() == 920742 then
		pUnit:CastSpell(62003)
	end
end

RegisterUnitEvent(920742, 18, "UTG.VAR.BADFIRESpawn")




function UTG.VAR.STAGROAR(pUnit,Event)
	pUnit:CancelSpell()
	pUnit:RemoveAura(40653)
	local name = pUnit:GetName()
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 60 then
			pUnit:SendChatMessageToPlayer(42,0,""..name.." begins to cast \124cff71d5ff\124Hspell:42708\124h[Staggering Roar]\124h\124r",players)
		end
	end
	pUnit:Root()
	pUnit:AIDisableCombat(true)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
	pUnit:SetOrientation(pUnit:GetO())
	pUnit:FullCastSpell(42708)
	pUnit:RegisterEvent("UTG.VAR.STAGROARCAST", 2100, 1)
end

function UTG.VAR.STAGROARCAST(pUnit,Event)
	pUnit:Unroot()
	pUnit:CancelSpell()
	pUnit:AIDisableCombat(false)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	pUnit:RegisterEvent("UTG.VAR.STAGROAR", 14000, 1)
end

function UTG.VAR.TRASH_ENRAGE(pUnit)
	pUnit:CastSpell(42705)
end

function UTG.VAR.SOFTENRAGE_TRASH(pUnit)
	pUnit:CastSpell(48193)
end

function UTG.VAR.TRASH_SUNDER(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 9 then
			pUnit:CastSpellOnTarget(15572,tank)
		end
	end
end

function UTG.VAR.TRASH_BLACKCLEAVE(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 9 then
			pUnit:CastSpellOnTarget(50050,tank)
		end
	end
end


function UTG.VAR.TRASH_Brand(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 9 then
			pUnit:CastSpellOnTarget(43757,tank)
		end
	end
	pUnit:RegisterEvent("UTG.VAR.TRASH_Brand", 30000, 1)
end

function UTG.VAR.UtgardeTrashEvents(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	UTG[id] = UTG[id] or {VAR={}}
if Event == 1 then
if pUnit:GetEntry() == 24085 then
pUnit:CastSpell(38232)
pUnit:RegisterEvent("UTG.VAR.STAGROAR", 8000, 1)
pUnit:RegisterEvent("UTG.VAR.TRASH_ENRAGE", 12000, 1)
pUnit:RegisterEvent("UTG.VAR.SOFTENRAGE_TRASH", 32000, 1)
elseif pUnit:GetEntry() == 24078 then
pUnit:RegisterEvent("UTG.VAR.SOFTENRAGE_TRASH", 32000, 1)
pUnit:RegisterEvent("UTG.VAR.TRASH_SUNDER", math.random(7000,12000), 0)
elseif pUnit:GetEntry() == 24080 then
pUnit:RegisterEvent("UTG.VAR.TRASH_Brand", 8000, 1)
pUnit:RegisterEvent("UTG.VAR.TRASH_SUNDER", math.random(7000,12000), 0)
elseif pUnit:GetEntry() == 839812 then
pUnit:RegisterEvent("UTG.VAR.TRASH_SUNDER", math.random(7000,12000), 0)
elseif pUnit:GetEntry() == 83920 then
pUnit:RegisterEvent("UTG.VAR.TRASH_BLACKCLEAVE", math.random(7000,12000), 0)
pUnit:RegisterEvent("UTG.VAR.MINIONOFHATRED_BARRIER", 1000, 0)
elseif pUnit:GetEntry() == 83921 then
pUnit:CastSpell(50054)
pUnit:RegisterEvent("UTG.VAR.TRASH_BLACKCLEAVE", math.random(5000,9000), 0)
--pUnit:RegisterEvent("UTG.VAR.SHADOWCRASHES_HATEHEART", math.random(11000,16000), 0)
end
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:RemoveAura(63710)
elseif Event == 4 then
pUnit:RemoveEvents()
if pUnit:GetEntry() == 24080 then
if not UTG[id].VAR.FuranceCount then
UTG[id].VAR.FuranceCount = 0
end
UTG[id].VAR.FuranceCount = UTG[id].VAR.FuranceCount + 1
if UTG[id].VAR.FuranceCount == 1 then
	local object = pUnit:GetGameObjectNearestCoords(374.60,-63.86,22.75, 186692)
	if object then
		object:SetByte(GAMEOBJECT_BYTES_1,0,0)
	end
	
elseif UTG[id].VAR.FuranceCount == 2 then
	local object = pUnit:GetGameObjectNearestCoords(374.60,-63.86,22.75, 186693)
	if object then
		object:SetByte(GAMEOBJECT_BYTES_1,0,0)
	end
end
	end
end
	end
	
	function UTG.VAR.SHADOWCRASHES_HATEHEART(pUnit,Event)
local player = pUnit:GetRandomPlayer(7)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 40 then
if player:IsDead() == false then
pUnit:CastSpellAoF(player:GetX(), player:GetY(),player:GetZ() , 63722)
end
end
end
end
	
	function UTG.VAR.MINIONOFHATRED_BARRIER(pUnit,Event)
	if pUnit:GetHealthPct() < 49 then
	pUnit:RemoveEvents()
	pUnit:CastSpell(63710)
	pUnit:RegisterEvent("UTG.VAR.TRASH_BLACKCLEAVE", math.random(7000,12000), 0)
	pUnit:RegisterEvent("UTG.VAR.MINIONOFHATRED_REMOVEBARRIER", math.random(5000,8000), 1)
	end
		end
		
		function UTG.VAR.MINIONOFHATRED_REMOVEBARRIER(pUnit)
		pUnit:RemoveAura(63710)
		end
		
			RegisterUnitEvent(83921, 1, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(83921, 2, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(83921, 4, "UTG.VAR.UtgardeTrashEvents")
		RegisterUnitEvent(83920, 1, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(83920, 2, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(83920, 4, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(24085, 1, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(24085, 2, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(24085, 4, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(24078, 1, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(24078, 2, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(24078, 4, "UTG.VAR.UtgardeTrashEvents")
		RegisterUnitEvent(24080, 1, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(24080, 2, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(24080, 4, "UTG.VAR.UtgardeTrashEvents")
			RegisterUnitEvent(839812, 1, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(839812, 2, "UTG.VAR.UtgardeTrashEvents")
	RegisterUnitEvent(839812, 4, "UTG.VAR.UtgardeTrashEvents")
	
	
	
	function UTG.VAR.COUNCIL_FIGHT(pUnit,Event)
if Event == 1 then
local object = pUnit:GetGameObjectNearestCoords(272.50,235.82,42.86, 186608)
	if object then
		object:SetByte(GAMEOBJECT_BYTES_1,0,1)
	end
	pUnit:RegisterEvent("UTG.VAR.COUNCIL_LINKHEALTH", 1000, 0)
	if pUnit:GetEntry() == 839818 then
pUnit:PlaySoundToSet(11482)
pUnit:SendChatMessage(14,0,"Flee or die!")
pUnit:RegisterEvent("UTG.VAR.COUNCIL_LIVINGBOMB", math.random(8000,14000), 0)
pUnit:RegisterEvent("UTG.VAR.COUNCIL_FORCEPUSH", 15000, 0)
			pUnit:RegisterEvent("UTG.VAR.COUNCIL_SHADOWBOLT", math.random(4000,5000), 0)
pUnit:RegisterEvent("UTG.VAR.COUNCIL_POLY", math.random(14000,18000), 0)
elseif pUnit:GetEntry() == 839815 then
	pUnit:RegisterEvent("UTG.VAR.COUNCIL_STEADYSHOT", math.random(5000,6000), 0)
	pUnit:RegisterEvent("UTG.VAR.COUNCIL_SERPENTSTING", math.random(6000,8000), 0)
elseif pUnit:GetEntry() == 839817 then
pUnit:PlaySoundToSet(13207)
pUnit:SendChatMessage(14,0,"I'll paint my face with your blood!")
pUnit:RegisterEvent("UTG.VAR.COUNCIL_Whirlwind", math.random(8000,13000), 0)
pUnit:RegisterEvent("UTG.VAR.COUNCIL_FEAR", math.random(7000,12000), 0)
pUnit:RegisterEvent("UTG.VAR.COUNCIL_BLACKBRAND", math.random(14000,16000), 0)
	end
	elseif Event == 2 then
	pUnit:RemoveEvents()
	pUnit:Despawn(1000,6000)
	elseif Event == 4 then
	pUnit:RemoveEvents()
					local object = pUnit:GetGameObjectNearestCoords(272.50,235.82,42.86, 186608)
	if object then
		object:SetByte(GAMEOBJECT_BYTES_1,0,0)
	end
						local object = pUnit:GetGameObjectNearestCoords(160.56,255.02,42.86, 186608)
	if object then
		object:SetByte(GAMEOBJECT_BYTES_1,0,0)
	end
	for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 839814 or creatures:GetEntry() == 839817 or creatures:GetEntry() == 839818  or creatures:GetEntry() == 839815 then
		if not creatures:IsDead() then
		pUnit:Kill(creatures)
		end
			end
	end
		end
	end

	
		RegisterUnitEvent(839818, 1, "UTG.VAR.COUNCIL_FIGHT")
	RegisterUnitEvent(839818, 2, "UTG.VAR.COUNCIL_FIGHT")
	RegisterUnitEvent(839818, 4, "UTG.VAR.COUNCIL_FIGHT")
			RegisterUnitEvent(839815, 1, "UTG.VAR.COUNCIL_FIGHT")
	RegisterUnitEvent(839815, 2, "UTG.VAR.COUNCIL_FIGHT")
	RegisterUnitEvent(839815, 4, "UTG.VAR.COUNCIL_FIGHT")
				RegisterUnitEvent(839816, 1, "UTG.VAR.COUNCIL_FIGHT")
	RegisterUnitEvent(839816, 2, "UTG.VAR.COUNCIL_FIGHT")
	RegisterUnitEvent(839816, 4, "UTG.VAR.COUNCIL_FIGHT")
				RegisterUnitEvent(839817, 1, "UTG.VAR.COUNCIL_FIGHT")
	RegisterUnitEvent(839817, 2, "UTG.VAR.COUNCIL_FIGHT")
	RegisterUnitEvent(839817, 4, "UTG.VAR.COUNCIL_FIGHT")
	
		function UTG.VAR.COUNCIL_STEADYSHOT(pUnit)
local tank = pUnit:GetMainTank()
if tank then
if pUnit:GetDistanceYards(tank) < 35 then
pUnit:FullCastSpellOnTarget(34120,tank)
end
	end
end

function UTG.VAR.COUNCIL_FEAR(pUnit)
 local player = pUnit:GetRandomPlayer(0)
if player then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 45 then
if not pUnit:GetCurrentSpellId() then
pUnit:CastSpellOnTarget(65809,player)
end
end
	end
		end
	end

	function UTG.VAR.COUNCIL_SHADOWBOLT(pUnit)
 local player = pUnit:GetRandomPlayer(0)
if player then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 45 then
if not pUnit:GetCurrentSpellId() then
pUnit:FullCastSpellOnTarget(18211,player)
end
end
	end
		end
	end
	
		function UTG.VAR.COUNCIL_SERPENTSTING(pUnit)
local tank = pUnit:GetMainTank()
if tank then
if pUnit:GetDistanceYards(tank) < 35 then
pUnit:CastSpellOnTarget(13551,tank)
end
	end
end

	
function UTG.VAR.COUNCIL_Whirlwind(pUnit)
	pUnit:CastSpell(40653)
end

function UTG.VAR.COUNCIL_LIVINGBOMB(pUnit)
 local player = pUnit:GetRandomPlayer(0)
if player then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 45 then
pUnit:CastSpellOnTarget(44457,player)
end
	end
		end
	end

	function UTG.VAR.COUNCIL_FIREBALL(pUnit)
 local player = pUnit:GetRandomPlayer(0)
if player then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 45 then
pUnit:CastSpellOnTarget(8401,player)
end
	end
		end
	end
	
		function UTG.VAR.COUNCIL_POLY(pUnit)
 local player = pUnit:GetRandomPlayer(7)
if player then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 45 then
pUnit:CastSpellOnTarget(12824,player)
end
	end
		end
	end
	
	function UTG.VAR.COUNCIL_FORCEPUSH(pUnit)
	pUnit:CastSpell(82011)
	end

	
		function UTG.VAR.COUNCIL_BLACKBRAND(pUnit)
	pUnit:CastSpell(50081)
						pUnit:PlaySoundToSet(11486)
		pUnit:SendChatMessage(14,0,"No second chances!")
	end

		
		function UTG.VAR.COUNCIL_LINKHEALTH(pUnit)
		local hpcosts = pUnit:GetHealth() 
		for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 839814 or creatures:GetEntry() == 839817 or creatures:GetEntry() == 839818  or creatures:GetEntry() == 839815 then
		creatures:SetHealth(hpcosts)
		end
			end
		end
		
		
		
	function UTG.VAR.Foreman_Events(pUnit,Event)
if Event == 1 then
pUnit:PlaySoundToSet(10376)
pUnit:SpawnGameObject(3262230, 43.89,-10.32,118.77,0, 0, 200)
pUnit:SendChatMessage(14,0,"The work must continue.")
pUnit:RegisterEvent("UTG.VAR.COUNCIL_Whirlwind", math.random(15000,17000), 0)
pUnit:RegisterEvent("UTG.VAR.STAGROAR", 8000, 1)
pUnit:RegisterEvent("UTG.VAR.TRASH_SUNDER", math.random(7000,12000), 0)
pUnit:RegisterEvent("UTG.VAR.SPAWNWORKERS", 30000, 1)
	for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
if creatures:GetEntry() == 6814 and  pUnit:GetDistanceYards(creatures) < 40 then
creatures:SetPhase(1)
end
	end
elseif Event == 2 then
pUnit:RemoveEvents()
	for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
if creatures:GetEntry() == 839812 then
if pUnit:GetDistanceYards(creatures) < 60 then
creatures:Despawn(1,0)
end
	end
if creatures:GetEntry() == 6814 then
if pUnit:GetDistanceYards(creatures) < 40 then
creatures:SetPhase(2)
end
end
	end
local object = pUnit:GetGameObjectNearestCoords(43.89,-10.32,118.77,3262230)
if object then
object:Despawn(1,0)
end
elseif Event == 3 then
		local choice = math.random(1,2)
	if choice == 1 then
			pUnit:PlaySoundToSet(10380)
		pUnit:SendChatMessage(14,0,"It had to be done.")
	elseif choice == 2 then
		pUnit:SendChatMessage(14,0,"You should not have come.")
			pUnit:PlaySoundToSet(10381)
		end
		elseif Event == 4 then
		pUnit:RemoveEvents()
			pUnit:PlaySoundToSet(10382)
		pUnit:SendChatMessage(14,0,"I... Deserve this.")
				for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
if creatures:GetEntry() == 839812 then
if pUnit:GetDistanceYards(creatures) < 60 then
creatures:Despawn(1,0)
end
	end
	if creatures:GetEntry() == 6814 then
if pUnit:GetDistanceYards(creatures) < 40 then
creatures:SetPhase(2)
end
	end
end
		end
			local object = pUnit:GetGameObjectNearestCoords(43.89,-10.32,118.77, 362230)
		if object then
			object:Despawn(1,0)
		end
local object = pUnit:GetGameObjectNearestCoords(156.28,-25.29,135.01, 186608)
	if object then
		object:SetByte(GAMEOBJECT_BYTES_1,0,0)
	end
end
			
			
			
function UTG.VAR.SPAWNWORKERS(pUnit,Event)
	pUnit:PlaySoundToSet(10378)
		pUnit:SendChatMessage(14,0,"You brought this on yourselves.")
	pUnit:SpawnCreature(839812,51.40,-13.64,118.77,5.26, 14,720000)
pUnit:SpawnCreature(839812,40.82,-16.4,118.77,5.59, 14,720000)
pUnit:RegisterEvent("UTG.VAR.SPAWNWORKERSPARTTWO", 2000, 1)
end


function UTG.VAR.SPAWNWORKERSPARTTWO(pUnit,Event)
for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
if creatures:GetEntry() == 839812 then
if pUnit:GetDistanceYards(creatures) < 80 then
creatures:EquipWeapons(70014,0,0)
creatures:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
creatures:MoveTo(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO())
end
	end
end
pUnit:RegisterEvent("UTG.VAR.SPAWNWORKERS", 30000, 1)
end
	

		
RegisterUnitEvent(839813, 1, "UTG.VAR.Foreman_Events")
RegisterUnitEvent(839813, 2, "UTG.VAR.Foreman_Events")
RegisterUnitEvent(839813, 3, "UTG.VAR.Foreman_Events")
RegisterUnitEvent(839813, 4, "UTG.VAR.Foreman_Events")
	
			
			
			
			
function UTG.VAR.SHAOFHATE_EVENTS(pUnit,Event)
if Event == 18 then
pUnit:Unroot()
pUnit:SetMaxPower(100,6)
pUnit:SetPower(0,6)
pUnit:SetPowerType(6)
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 9)
					local object = pUnit:GetGameObjectNearestCoords( 210.96,-273.48,180.46, 3267530)
		if object then
			object:Despawn(1,0)
		end
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_DETECTPLRS", 1500, 0)
elseif Event == 1 then
pUnit:SendChatMessage(14,0,"HATRED WILL CONSUME AND CONQUER ALL!")
pUnit:PlaySoundToSet(18168)
pUnit:PlayMusicToSet(50262)
pUnit:SpawnGameObject(3267530, 210.96,-273.48,180.46,5.24,0, 200)
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_PHASE", 20000, 1)
--pUnit:RegisterEvent("UTG.VAR.SHADOWCRASHES_HATE", 8000, 0)
elseif Event == 2 then
pUnit:RemoveEvents()
pUnit:Despawn(1000,5000)
pUnit:PlayMusicToSet(50261)
					local object = pUnit:GetGameObjectNearestCoords( 210.96,-273.48,180.46, 3267530)
		if object then
			object:Despawn(1,0)
		end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  players:RemoveAura(82010)
  end
  end
		for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 66981 or creatures:GetEntry() == 82031 or creatures:GetEntry() == 82030 or creatures:GetEntry() == 82023 then 
			creatures:Despawn(1,0)
end
end
elseif Event == 3 then
if math.random(1,2) <= 1 then
pUnit:SendChatMessage(14,0,"RAGE at your defeat!")
pUnit:PlaySoundToSet(18178)
elseif math.random(1,2) <= 2 then
pUnit:SendChatMessage(14,0,"Feed me your hatred!")
pUnit:PlaySoundToSet(18179)
end
elseif Event == 4 then
pUnit:RemoveEvents()
pUnit:PlayMusicToSet(50261)
pUnit:SendChatMessage(14,0,"No! NOOOOOOOOO!")
pUnit:PlaySoundToSet(18169)
					local object = pUnit:GetGameObjectNearestCoords( 210.96,-273.48,180.46, 3267530)
		if object then
			object:Despawn(1,0)
		end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 50 then
		if players:HasAchievement(59392) == false then
					players:AddAchievement(59392)
					end
	end
	end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  players:RemoveAura(82010)
  end
  end
  for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 66981 or creatures:GetEntry() == 82031 or creatures:GetEntry() == 82030 or creatures:GetEntry() == 82023 then 
			creatures:Despawn(1,0)
end
end
end
	end





function UTG.VAR.SHAOFHATE_PHASE(pUnit,Event) -- Spawn adds that walk toward the boss and pUnit:SetPower+1 per add that hits the boss, at 100% boss does major damage
	local choice = math.random(1,2)
if choice == 1 then
pUnit:SendChatMessage(14,0,"Give in..the more you fight, the more your hatred broils within you!")
pUnit:PlaySoundToSet(18173)
elseif choice == 2 then
pUnit:SendChatMessage(14,0,"Everything that you are is mine to destroy!")
pUnit:PlaySoundToSet(18174)
end
pUnit:RemoveEvents()
pUnit:Root()
pUnit:TeleportCreature(229.56,-307.13,180.49)
--pUnit:AIDisableCombat(true)
pUnit:SpawnCreature(82031,pUnit:GetX(), pUnit:GetY(),pUnit:GetZ(),pUnit:GetO(), 35,25000)
pUnit:SpawnCreature(82030,pUnit:GetX(), pUnit:GetY(),pUnit:GetZ(),pUnit:GetO(), 35,25000)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:Emote(382,25000)
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_SPAMSHADOW", 1000, 0)
--pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_NOTINRANGE", 2000, 0)
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_PHASEOVER", 25000, 1)
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_SPAWNADDS", 9000, 0)
pUnit:RegisterEvent("UTG.VAR.SHAHATRED_FULLPOWER", 2000, 0)
--pUnit:RegisterEvent("UTG.VAR.SOH_CHECKING_FOR_RESET", 1000, 0)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 50 then
  players:CastSpell(82010)
  end
  end
end



function UTG.VAR.SHAOFHATE_SPAWNADDS(pUnit)
	local choice = math.random(1,4)
if choice == 1 then
pUnit:SpawnCreature(83923,249.47,-280.22,180.44,4.15, 14,0)
elseif choice == 2 then
pUnit:SpawnCreature(83923,209.52,-337.57,180.43,0.92, 14,0)
elseif choice == 3 then
pUnit:SpawnCreature(83923,253.92,-332.34,180.44,2.48, 14,0)
elseif choice == 4 then
pUnit:SpawnCreature(83923,196.62,-294.13,180.43,5.88, 14,0)
end
	end
	
	function UTG.VAR.IMPLODINGHATE_MOVETOBOSS(pUnit)
	  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 444521 then 
	if creature:IsInCombat() then
	pUnit:MoveTo(creature:GetX(),creature:GetY(),creature:GetZ(),creature:GetO())
		end
	end
end
	end
	
	
	function UTG.VAR.IMPLODINGHATE_ONTOPOFBOSS(pUnit)
		  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 444521 then 
	if creature:IsInCombat() then
	  if pUnit:GetDistanceYards(creature) < 5 then
	  pUnit:RemoveEvents()
	  pUnit:Kill(pUnit)
creature:SetPower(creature:GetPower(6)+10,6)
creature:SetMaxPower(100,6)
creature:SetPowerType(6)
	  end
		end
	end
end
	end
	
	function UTG.VAR.SHAHATRED_FULLPOWER(pUnit)
	if pUnit:GetPower(6) >= 100 then
	pUnit:RemoveEvents()
	pUnit:PlaySoundToSet(18175)
	pUnit:SendChatMessage(42,0,"Sha of Hatred has gained full hatred!")
	pUnit:CastSpell(64166)
	end
	end
	
	
	function UTG.VAR.IMPLODINGSHA_EV(pUnit,Event)
	if Event == 18 then
	pUnit:AIDisableCombat(true)
	pUnit:RegisterEvent("UTG.VAR.IMPLODINGHATE_MOVETOBOSS", 1500, 1)
	pUnit:RegisterEvent("UTG.VAR.IMPLODINGHATE_ONTOPOFBOSS", 2000, 0)
		end
	end
	
	RegisterUnitEvent(83923, 18, "UTG.VAR.IMPLODINGSHA_EV")
	
	function UTG.VAR.UTGDUMMY_SPAWNINGS(pUnit)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	end
	
	RegisterUnitEvent(82030, 18, "UTG.VAR.UTGDUMMY_SPAWNINGS")
	RegisterUnitEvent(82031, 18, "UTG.VAR.UTGDUMMY_SPAWNINGS")
	
function UTG.VAR.SHAOFHATE_SPAMSHADOW(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 10 then
pUnit:Strike(players,1,5679,240,300,1)
  elseif pUnit:GetDistanceYards(players) > 10 then
pUnit:Strike(players,1,5679,100,210,1)
  end
  end
end

function UTG.VAR.SHAOFHATE_PHASEOVER(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:PlayMusicToSet(50262)
--pUnit:RegisterEvent("UTG.VAR.SHADOWCRASHES_HATE", 8000, 0)
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_PHASE", 20000, 1)
pUnit:RegisterEvent("UTG.VAR.SHAHATRED_FULLPOWER", 2000, 0)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  players:RemoveAura(82010)
  end
  end
end


function UTG.VAR.SHAOFHATE_ENRAGE(pUnit,Event)
if pUnit:GetHealthPct() < 20 then
pUnit:RemoveEvents()
pUnit:CastSpell(68335)
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:PlaySoundToSet(18175)
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_SPAMSHADOW", 800, 0)
--pUnit:RegisterEvent("UTG.VAR.SHADOWCRASHES_HATE", 3000, 0)
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_PULSE", 15000, 0)
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_NOTINRANGE", 2000, 0)
end
end


function UTG.VAR.SHAOFHATE_PULSE(pUnit,Event)
pUnit:CastSpell(48582)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 30 then
			pUnit:Strike(players,1,37826,500,800,2)
end
end
end

function UTG.VAR.SHAOFHATE_NOTINRANGE(pUnit,Event)
local player = pUnit:GetClosestPlayer()
if player ~= nil and pUnit:GetDistanceYards(player) > 20 then
--pUnit:RegisterEvent("UTG.VAR.SHADOWCRASHES_HATE", 1000, 5)
if pUnit:HasAura(51170) == false then
pUnit:CastSpell(51170)
end
end
end

function UTG.VAR.SHADOWCRASHES_HATE(pUnit,Event)
local player = pUnit:GetRandomPlayer(7)
if player ~= nil then
if pUnit:GetDistanceYards(player) < 40 then
if player:IsDead() == false then
pUnit:CastSpellAoF(player:GetX(), player:GetY(),player:GetZ() , 63722)
end
end
end
end

function UTG.VAR.SOH_CHECKING_FOR_RESET(pUnit)
local numPlayers = pUnit:GetInRangePlayers()
	local i = 0
	for _,players in pairs(numPlayers) do
		if pUnit:GetDistanceYards(players) < 40 then
			if players:IsDead() then
				i = i + 1
			end
		end
	end
	if i == #numPlayers then
		pUnit:AIDisableCombat(false) -- random 323 was here
			end
		pUnit:Despawn(2000,5000)
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 30 then
  players:RemoveAura(82010)
  end
  end
    for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 66981 or creatures:GetEntry() == 82031 or creatures:GetEntry() == 82030 or creatures:GetEntry() == 82023 then 
			creatures:Despawn(1,0)
end
end
end
	
function UTG.VAR.SHAOFHATE_DETECTPLRS(pUnit,Event)
for _,plr in pairs(pUnit:GetInRangePlayers()) do
		if plr:GetDistanceYards(pUnit) < 25 then
		if not plr:IsDead() then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"Come lambs..come and face your demise!")
pUnit:PlaySoundToSet(18166)
pUnit:PlayMusicToSet(50262)
pUnit:SetByteValue(UNIT_FIELD_BYTES_1, 0, 0)
pUnit:RegisterEvent("UTG.VAR.SHAOFHATE_SUP", 5100, 1)
			end
		end
	end
end

	function UTG.VAR.SHAOFHATE_SUP(pUnit,Event)
		pUnit:SendChatMessage(14,0,"The hatred inside you drives your hunt for me...you are already mine!")
pUnit:PlaySoundToSet(500082)
pUnit:RegisterEvent("UTG.VAR.TURNCOMBAT", 6500, 1)
end

	function UTG.VAR.TURNCOMBAT(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
end


	RegisterUnitEvent(444521, 18, "UTG.VAR.SHAOFHATE_EVENTS")
	RegisterUnitEvent(444521, 1, "UTG.VAR.SHAOFHATE_EVENTS")
	RegisterUnitEvent(444521, 3, "UTG.VAR.SHAOFHATE_EVENTS")
	RegisterUnitEvent(444521, 2, "UTG.VAR.SHAOFHATE_EVENTS")
	RegisterUnitEvent(444521, 4, "UTG.VAR.SHAOFHATE_EVENTS")