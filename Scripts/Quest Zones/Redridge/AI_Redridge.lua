local UNIT_FLAG_NOT_SELECTABLE = 0x02000000



function MilitiaVisualmen_Spawn(pUnit,Event)
pUnit:SetFaction(35)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("MilitiaVisualmen_Visual", 5000, 0)
end



function MilitiaVisualmen_Visual(pUnit,Event)
  for _,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 4624 then
if pUnit:GetDistanceYards(creature) < 2 then
if creature:IsInCombat() then
creature:FullCastSpell(63691)
	break
end
	end
	end
end
end

RegisterUnitEvent(31817, 18, "MilitiaVisualmen_Spawn")



function BRaider_Spawns(pUnit,Event)
	pUnit:EquipWeapons(25169,25169,0)
end

RegisterUnitEvent(77040, 18, "BRaider_Spawns")


function BRaiderz_Spawns(pUnit,Event)
	pUnit:EquipWeapons(25169,25169,0)
	pUnit:SetMovementFlags(1)
	pUnit:RegisterEvent("FixMovement", 1000, 1)
end

RegisterUnitEvent(77046, 18, "BRaiderz_Spawns")


function FixMovement(pUnit,Event)
	pUnit:MoveTo(-9633.22, -3240.51, 48.47, 5.98)
end

function BMHound_Spawns(pUnit,Event)
	pUnit:EquipWeapons(24020,1172,0)
end


RegisterUnitEvent(77050, 18, "BMHound_Spawns")

function GrimlokEvent(pUnit,Event)
if Event == 1 then
		pUnit:SendChatMessage(12,0,"Me Grimlok, KING!")
		pUnit:PlaySoundToSet(5853)
		elseif Event == 3 then
			pUnit:SendChatMessage(12,0,"Die, DIE!")
		pUnit:PlaySoundToSet(5854)
		end
end


RegisterUnitEvent(4854, 3, "GrimlokEvent")
RegisterUnitEvent(4854, 1, "GrimlokEvent")

function BMHound_OnCombat(pUnit, Event)
	local hound = pUnit:SpawnCreature(17280, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 14, 35000)
	hound:SetUnitToFollow(pUnit, 1, 1) 
	hound:SetMovementFlags(1)
	pUnit:RegisterEvent("BMHound_WingClip", 10000, 0)
	pUnit:RegisterEvent("BMHound_RaptorStrike", 6000, 0)
end
 
function BMHound_WingClip(pUnit,Event)
	 local tank = pUnit:GetMainTank()
	 if tank then
		pUnit:CastSpellOnTarget(2974, tank)
	 end
 end
 
function BMHound_RaptorStrike(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(14262, tank)
	end
end
 
function BMHound_OnLeave(pUnit, Event)
	pUnit:RemoveEvents()
	local hound = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 17280)
	if hound then
		hound:SetUnitToFollow(pUnit, 1, 1)
	end
end
 
function BMHound_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(77050, 1, "BMHound_OnCombat")
RegisterUnitEvent(77050, 2, "BMHound_OnLeave")
RegisterUnitEvent(77050, 4, "BMHound_OnDead")


function BCultist_Spawns(pUnit,Event)
	pUnit:EquipWeapons(42348,0,0)
	pUnit:CastSpell(687)
end

RegisterUnitEvent(77041, 18, "BCultist_Spawns")

function BCultist_OnCombat(pUnit, Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(970, tank)
	end
	pUnit:RegisterEvent("BCultist_SB",  math.random(3000,5000), 0)
	pUnit:RegisterEvent("BCultist_SM",  math.random(4000,8000), 0)
end
 
function BCultist_SB(pUnit,Event)
	if pUnit:GetCurrentSpellId() == nil then
		local tank = pUnit:GetMainTank()
		if tank then
			pUnit:FullCastSpellOnTarget(695, tank)
		end
	end
end

function UNROOTCASTER(pUnit,Event)
	pUnit:Unroot()
end
 
function BCultist_SM(pUnit,Event)
	if pUnit:GetCurrentSpellId() == nil then
		local tank = pUnit:GetMainTank()
		if tank then
			pUnit:CastSpellOnTarget(589, tank)
		end
	end
end
 
function BCultist_OnLeave(pUnit, Event)
	pUnit:RemoveEvents()
end

function BCultist_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(77041, 1, "BCultist_OnCombat")
RegisterUnitEvent(77041, 2, "BCultist_OnLeave")
RegisterUnitEvent(77041, 4, "BCultist_OnDead")

RegisterUnitEvent(11791, 1, "BCultist_OnCombat")
RegisterUnitEvent(11791, 2, "BCultist_OnLeave")
RegisterUnitEvent(11791, 4, "BCultist_OnDead")

function BRaider_OnCombat(pUnit, Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(100, tank)
	end
	pUnit:RegisterEvent("BRaider_Strike", 3000, 0)
	pUnit:RegisterEvent("BRaider_Rend", 4000, 0)
	pUnit:RegisterEvent("HealthChecker", 2000, 0)
	local choice = math.random(1,12)
	if choice == 1 then
		pUnit:SendChatMessage(14,0,"We are the REAL Horde")
	elseif choice == 2 then
		pUnit:SendChatMessage(14,0,"Blackrock is renewed!")
	elseif choice == 3 then
		pUnit:SendChatMessage(14,0,"This is OUR land now!")
	end
end

function BRaider_Strike(pUnit, Event)
	local tank = pUnit:GetMainTank()
	if tank then	
		pUnit:CastSpellOnTarget(78, tank)
	end
end

function BRaider_Rend(pUnit, Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 5 then
			pUnit:CastSpellOnTarget(772, tank)
		end
	end
end

function HealthChecker(pUnit, Event)
	if pUnit:GetHealthPct() < 15 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(16789)
		pUnit:RegisterEvent("Raging", 20000, 0)
		pUnit:RegisterEvent("BRaider_Strike", 3000, 0)
		pUnit:RegisterEvent("BRaider_Rend", 4000, 0)
	end
end

function Raging(pUnit, Event)
	pUnit:CastSpell(16789)
end

function BRaider_OnLeave(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(77040, 1, "BRaider_OnCombat")
RegisterUnitEvent(77040, 2, "BRaider_OnLeave")
RegisterUnitEvent(77040, 4, "BRaider_OnLeave")

------

function BElite_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BElite_MS", 7000, 0)
	pUnit:RegisterEvent("BElite_Charge", 10000, 0)
	pUnit:RegisterEvent("HealthCheckerzxxx", 2000, 0)
	local choice = math.random(1,12)
	if choice == 1 then
		pUnit:SendChatMessage(12,0,"I will crush you!")
	elseif choice == 2 then
		pUnit:SendChatMessage(12,0,"Long live the Darkshield! Die you worthless scum!!")
	elseif choice == 3 then
		pUnit:SendChatMessage(12,0,"Your bones will break under my boot!")
	end
end


function BElite_MS(pUnit, Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(27580, tank)
	end
end

function BElite_Charge(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 20 then
			pUnit:CastSpellOnTarget(100, plr)
		end
	end
end

function HealthCheckerzxxx(pUnit, Event)
	if pUnit:GetHealthPct() < 30 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(16789)
		pUnit:RegisterEvent("BElite_MS", 7000, 0)
		pUnit:RegisterEvent("BElite_Charge", 10000, 0)
	end
end


function BElite_OnLeave(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(77047, 1, "BElite_OnCombat")
RegisterUnitEvent(77047, 2, "BElite_OnLeave")
RegisterUnitEvent(77047, 4, "BElite_OnLeave")

RegisterUnitEvent(17370, 1, "BElite_OnCombat")
RegisterUnitEvent(17370, 2, "BElite_OnLeave")
RegisterUnitEvent(17370, 4, "BElite_OnLeave")

--[[Southern Redridge]]

--[[Beasts of Redridge, Daily Quest]]--

function VrykulWarlock_OnCombat(pUnit,Event)
	pUnit:RegisterEvent("Shadowbolt_AIVrykulWarlock", math.random(3000,6000),0)
	pUnit:RegisterEvent("Flay_AIVrykulWarlock", math.random(5000,10000),0)
end

function Shadowbolt_AIVrykulWarlock(pUnit,Event)
	if pUnit:GetCurrentSpellId() == nil then
		local tank = pUnit:GetMainTank()
		if tank then
			pUnit:FullCastSpellOnTarget(1088, tank)
		end
	end
end

function Flay_AIVrykulWarlock(pUnit,Event)
	if pUnit:GetCurrentSpellId() == nil then
		local tank = pUnit:GetMainTank()
		if tank then
			pUnit:FullCastSpellOnTarget(17312, tank)
		end
	end
end

function VrykulWarlock_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37633, 1, "VrykulWarlock_OnCombat")
RegisterUnitEvent(37633, 2, "VrykulWarlock_OnDead")
RegisterUnitEvent(37633, 4, "VrykulWarlock_OnDead")

function MinionOfVerius_Spawn(pUnit,Event)
	pUnit:CastSpell(46223)
end

RegisterUnitEvent(77045, 18, "MinionOfVerius_Spawn")

function Miramisha_OnCombat(pUnit,Event)
	if pUnit:IsPet() == false then
		pUnit:RegisterEvent("Miramisha_Maul",3000,1)
		pUnit:RegisterEvent("Miramisha_Mangle",5000,1)
		pUnit:RegisterEvent("Miramisha_DemRoar",8000,1)
	end
end

function Miramisha_Maul(pUnit,Event)
	if pUnit:IsPet() == false then
		local tank = pUnit:GetMainTank()
		if tank then
			if pUnit:GetDistanceYards(tank) < 5 then
				pUnit:CastSpellOnTarget(27553, tank)
			end
			pUnit:RegisterEvent("Miramisha_Maul",9000,1)
		end
	end
end

function Miramisha_Mangle(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 5 then
			pUnit:CastSpellOnTarget(48563, pUnit:GetMainTank())
		end
		pUnit:RegisterEvent("Miramisha_Mangle",7000,1)
	end
end

function Miramisha_DemRoar(pUnit,Event)
	if pUnit:IsPet() == false then
		pUnit:CastSpell(99)
	end
end

function Miramisha_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37634, 1, "Miramisha_OnCombat")
RegisterUnitEvent(37634, 2, "Miramisha_OnLeave")
RegisterUnitEvent(37634, 4, "Miramisha_OnLeave")


function Alerio_OnCombat(pUnit,Event)
	if pUnit:IsPet() == false then
		pUnit:RegisterEvent("Alerio_Swoop",3000,1)
		pUnit:RegisterEvent("Alerio_SwoopStun",5000,1)
		pUnit:RegisterEvent("Alerio_Gutrip",7000,1)
	end
end

function Alerio_Swoop(pUnit,Event)
	if pUnit:IsPet() == false then
		local tank = pUnit:GetMainTank()
		if tank then
			if pUnit:GetDistanceYards(tank) < 5 then
				pUnit:CastSpellOnTarget(55079, tank)
			end
			pUnit:RegisterEvent("Alerio_Swoop",6000,1)
		end
	end
end

function Alerio_Gutrip(pUnit,Event)
	if pUnit:IsPet() == false then
		local tank = pUnit:GetMainTank()
		if tank then
			if pUnit:GetDistanceYards(tank) < 12 then
				pUnit:CastSpellOnTarget(32022, tank)
			end
		end
	end
end

function Alerio_SwoopStun(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 8 then
			pUnit:CastSpellOnTarget(18144, tank)
		end
		pUnit:RegisterEvent("Alerio_SwoopStun",8000,1)
	end
end

function Alerio_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37636, 1, "Alerio_OnCombat")
RegisterUnitEvent(37636, 2, "Alerio_OnLeave")
RegisterUnitEvent(37636, 4, "Alerio_OnLeave")


function RedRidgeBigBear_OnCombat(pUnit,Event)
	if pUnit:IsPet() == false then
		pUnit:RegisterEvent("RedRidgeBigBear_Maul",2000,1)
	end
end


function RedRidgeBigBear_Maul(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 5 then
			pUnit:CastSpellOnTarget(27553, tank)
		end
		pUnit:RegisterEvent("RedRidgeBigBear_Maul",8000,1)
	end
end

function RedRidgeBigBear_Dead(pUnit, Event)
	pUnit:RemoveEvents()
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
			if players:HasQuest(4225) then
				if players:GetQuestObjectiveCompletion(4225, 0) ~= 15 then
					players:AdvanceQuestObjective(4225,0)
				end
			end
		end
	end
end

function RedRidgeBigBear_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37635, 4, "RedRidgeBigBear_Dead")
RegisterUnitEvent(37635, 1, "RedRidgeBigBear_OnCombat")
RegisterUnitEvent(37635, 2, "RedRidgeBigBear_OnLeave")

function RedRidgeTinyneeLion_Dead(pUnit, Event)
	pUnit:RemoveEvents()
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
			if players:HasQuest(4225) then
				if players:GetQuestObjectiveCompletion(4225, 0) ~= 15 then
					players:AdvanceQuestObjective(4225,0)
				end
			end
		end
	end
end

function RedRidgeTinyneeLion_OnCombat(pUnit,Event)
	if pUnit:IsPet() == false then
		pUnit:RegisterEvent("RedRidgeTinyneeLion_Rake",3000,1)
	end
end

function RedRidgeTinyneeLion_Rake(pUnit,Event)
	local target = pUnit:GetMainTank()
	if target then
		if pUnit:GetDistanceYards(target) < 5 then
			target:RemoveAura(1824)
			pUnit:CastSpellOnTarget(1824, target)
			pUnit:RegisterEvent("RedRidgeTinyneeLion_Rake",9000,1)
		end
	end
end

function RedRidgeTinyneeLion_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2406, 1, "RedRidgeTinyneeLion_OnCombat")
RegisterUnitEvent(2406, 2, "RedRidgeTinyneeLion_OnLeave")
RegisterUnitEvent(2406, 4, "RedRidgeTinyneeLion_Dead")


function Asad_OnCombat(pUnit,Event)
	if pUnit:IsPet() == false then
		local tank = pUnit:GetMainTank()
		if tank then
			pUnit:CastSpellOnTarget(55077, tank)
		end
		pUnit:RegisterEvent("Asad_Rake",3000,1)
		pUnit:RegisterEvent("Asad_Roar",6000,1)
	end
end

function Asad_Rake(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 5 then
			pUnit:CastSpellOnTarget(9904, tank)
		end
		pUnit:RegisterEvent("Asad_Rake",9000,1)
	end
end

function Asad_Roar(pUnit,Event)
	if pUnit:IsPet() == false then
		pUnit:CastSpell(42496)
		pUnit:RegisterEvent("Asad_Roar",10000,1)
	end
end

function Asad_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37632, 1, "Asad_OnCombat")
RegisterUnitEvent(37632, 2, "Asad_OnDead")
RegisterUnitEvent(37632, 4, "Asad_OnDead")


----------------------
function RedRidgeBird_OnCombat(pUnit,Event)
	if pUnit:IsPet() == false then
		pUnit:RegisterEvent("RedRidgeBird_Claw",6000,1)
	end
end


function RedRidgeBird_Claw(pUnit,Event)
if pUnit:IsPet() == false then
if pUnit:GetDistanceYards(pUnit:GetMainTank()) < 5 then
pUnit:CastSpellOnTarget(11977, pUnit:GetMainTank())
pUnit:RegisterEvent("RedRidgeBird_Claw",16000,1)
end
end
end


function RedRidgeBird_Dead(pUnit, Event)
	pUnit:RemoveEvents()
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
			if players:HasQuest(4225) == true then
				if players:GetQuestObjectiveCompletion(4225, 0) ~= 15 then
					players:AdvanceQuestObjective(4225,0)
				end
			end
		end
	end
end

function RedRidgeBird_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37637, 4, "RedRidgeBird_Dead")
RegisterUnitEvent(37637, 1, "RedRidgeBird_OnCombat")
RegisterUnitEvent(37637, 2, "RedRidgeBird_OnLeave")


function VrykulGuard_OnCombat(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:FullCastSpellOnTarget(59633, tank)
	end
end


function VrykulGuard_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37640, 1, "VrykulGuard_OnCombat")
RegisterUnitEvent(37640, 2, "VrykulGuard_OnLeave")
RegisterUnitEvent(37640, 4, "VrykulGuard_OnLeave")


function BlitzcrankGuard_OnCombat(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(12024, tank)
	end
	pUnit:RegisterEvent("BlitzcrankGuard_Shoot",1500,0)
	pUnit:RegisterEvent("BlitzcrankGuard_Net",8000,0)
end

function BlitzcrankGuard_Shoot(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:FullCastSpellOnTarget(23337, tank)
	end
end

function BlitcrankGuard_Net(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:CastSpellOnTarget(12024, tank)
	end
end

function BlitzcrankGuard_OnDead(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37641, 1, "BlitzcrankGuard_OnCombat")
RegisterUnitEvent(37641, 2, "BlitzcrankGuard_OnDead")
RegisterUnitEvent(37641, 4, "BlitzcrankGuard_OnDead")

------------------

function DrakeBossAI_OnCombat(pUnit,Event)
	pUnit:PlaySoundToSet(3525)
	pUnit:SendChatMessage(14,0,"You will pay for this intrusion!")
	pUnit:RegisterEvent("DrakeBossAI_Breath",12000,0)
	pUnit:RegisterEvent("DrakeBossAI_FlameBuffet",6000,1)
	pUnit:RegisterEvent("DrakeBossAI_TerrifyingRoar",15000,1)
end

function DrakeBossAI_Breath(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank then
		pUnit:FullCastSpellOnTarget(51219, tank)
	end
end

function DrakeBossAI_Fear(pUnit,Event)
	pUnit:CastSpell(14100)
end

function DrakeBossAI_TerrifyingRoar(pUnit,Event)
	pUnit:CastSpell(14100)
	local choice = math.random(1,3)
	if choice == 1 then
		pUnit:RegisterEvent("DrakeBossAI_TerrifyingRoar",15000,1)
	elseif choice == 2 then
		pUnit:RegisterEvent("DrakeBossAI_TerrifyingRoar",12000,1)
	elseif choice == 3 then
		pUnit:RegisterEvent("DrakeBossAI_TerrifyingRoar",18000,1)
	end
end

function DrakeBossAI_FlameBuffet(pUnit,Event)
	for a, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 15 then
			pUnit:CastSpellOnTarget(23341,players)
		end
	end
end

function DrakeBossAI_OnLeave(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37644, 1, "DrakeBossAI_OnCombat")
RegisterUnitEvent(37644, 2, "DrakeBossAI_OnLeave")
RegisterUnitEvent(37644, 4, "DrakeBossAI_OnLeave")


function Blackscale_OnSpawn(pUnit,Event)
	pUnit:SetMovementFlags(2)
	pUnit:Unroot()
	pUnit:RegisterEvent("Blackscale_Terrorize",2000,0)
end

function Blackscale_Terrorize(pUnit,Event)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 55 then
			if players:GetPhase() == pUnit:GetPhase() then
				if players:IsDead() == false then
					pUnit:CastSpellOnTarget(72023,players)
					pUnit:SpawnCreature(78221 ,players:GetX(), players:GetY(), players:GetZ(), 0, 35, 6000)
				end
			end
		end
	end
end

RegisterUnitEvent(21497, 18, "Blackscale_OnSpawn")

