BAEL = {}
BAEL.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044


function BAEL.VAR.ForgedTrogg_Spawn(pUnit,Event)
pUnit:SetMovementFlags(1)
pUnit:RegisterEvent("BAEL.VAR.Forged_MoveTo", 500, 1)
end

function BAEL.VAR.ForgedDWARF_Spawn(pUnit,Event)
pUnit:EquipWeapons(47148,47148,0)
pUnit:SetMovementFlags(1)
pUnit:RegisterEvent("BAEL.VAR.Forged_MoveTo", 500, 1)
end

function BAEL.VAR.Forged_MoveTo(pUnit,Event)
  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 444092 then 
	pUnit:MoveTo(creature:GetX(),creature:GetY(),creature:GetZ(),creature:GetO())
		end
	end
end

function BAEL.VAR.ForgedTrogg_DEAD(pUnit,Event)
pUnit:RemoveEvents()
end

function BAEL.VAR.ForgedTrogg_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

function BAEL.VAR.ForgedDWARF_DEAD(pUnit,Event)
pUnit:RemoveEvents()
end

function BAEL.VAR.ForgedDWARF_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end

function BAEL.VAR.EYETENTACLE_DEAD(pUnit,Event)
pUnit:RemoveEvents()
end

function BAEL.VAR.EYETENACLE_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
end


function BAEL.VAR.ForgedTrogg_CL(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:Root()
	local tank = pUnit:GetMainTank()
				if tank ~= nil then
pUnit:FullCastSpellOnTarget(59220,tank)
end
end
pUnit:RegisterEvent("BAEL.VAR.UNROOTCASTER", 3000, 1)
end



function BAEL.VAR.UNROOTCASTER(pUnit,Event)
pUnit:Unroot()
end


function BAEL.VAR.ForgedDWARF_Combat(pUnit,Event)
pUnit:RegisterEvent("BAEL.VAR.FORGEDDWARF_SS", 6000, 0)
pUnit:RegisterEvent("BAEL.VAR.DWARFWINDSHEAR", 3000, 0)
end


function BAEL.VAR.DWARFWINDSHEAR(pUnit,Event)
local player = pUnit:GetRandomPlayer(4)
if player ~= nil then
if player:IsCasting() == true then
pUnit:CastSpellOnTarget(57994,player)
end
end
end

function BAEL.VAR.FORGEDDWARF_SS(pUnit,Event)
	local tank = pUnit:GetMainTank()
				if tank ~= nil then
pUnit:CastSpellOnTarget(64757,tank)
end
end

function BAEL.VAR.ForgedTrogg_Combat(pUnit,Event)
pUnit:RegisterEvent("BAEL.VAR.ForgedTrogg_CL", 4000, 0)
end

function BAEL.VAR.EYETENACLE_Combat(pUnit,Event)
pUnit:RegisterEvent("BAEL.VAR.EYETENACLE_MINDFLAY", 3400, 0)
end

function BAEL.VAR.EYETENACLE_MINDFLAY(pUnit,Event)
if pUnit:GetCurrentSpellId() ~= nil then
	player = pUnit:GetRandomPlayer(0)
	if player ~= nil then
		if player:IsAlive() == true then
			pUnit:FullCastSpellOnTarget(17311,player)
				end
			end
		end
	end



	RegisterUnitEvent(27979, 2, "BAEL.VAR.ForgedTrogg_LEAVE")
RegisterUnitEvent(27979, 4, "BAEL.VAR.ForgedTrogg_DEAD")
	RegisterUnitEvent(27979, 1, "BAEL.VAR.ForgedTrogg_Combat")
	RegisterUnitEvent(27979, 18, "BAEL.VAR.ForgedTrogg_Spawn")
	
	
		RegisterUnitEvent(15726, 2,"BAEL.VAR.EYETENACLE_LEAVE")
RegisterUnitEvent(15726, 4,"BAEL.VAR.EYETENTACLE_DEAD")
	RegisterUnitEvent(15726, 18, "BAEL.VAR.EYETENACLE_Combat")
	
	
	
		RegisterUnitEvent(27982, 2, "BAEL.VAR.ForgedDWARF_LEAVE")
RegisterUnitEvent(27982, 4, "BAEL.VAR.ForgedDWARF_DEAD")
	RegisterUnitEvent(27982, 1, "BAEL.VAR.ForgedDWARF_Combat")
	RegisterUnitEvent(27982, 18, "BAEL.VAR.ForgedDWARF_Spawn")
	
function BAEL.VAR.Archeras_Combat(pUnit,Event)
pUnit:SendChatMessage(14,0,"What hope is there for you? None!")
		pUnit:PlaySoundToSet(14162)
		pUnit:GetGameObjectNearestCoords(88.30, -102.39, 97.54, 194554):SetByte(GAMEOBJECT_BYTES_1,0,1) -- close door
		 pUnit:RegisterEvent("BAEL.VAR.StoneEffect", 10000, 1)
		 pUnit:RegisterEvent("BAEL.VAR.LIGHTNINGNOVA", 22000, 1)
		 pUnit:RegisterEvent("BAEL.VAR.CreateAdds", 15000, 0)
		 pUnit:RegisterEvent("BAEL.VAR.UNBALANCINGSTRIKE", 10000, 0)
		 pUnit:RegisterEvent("BAEL.VAR.PHASE2", 1000, 0)
		end

		
function BAEL.VAR.StoneEffect(pUnit,Event)
pUnit:RegisterEvent("BAEL.VAR.StoneEffectStun", 3500, 1)
pUnit:CastSpell(10347)
pUnit:SendChatMessage(14,0,"You cannot hide from fate!")
	pUnit:PlaySoundToSet(14163)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if players ~= nil then
  pUnit:CastSpell(33525)
end
end
end


function BAEL.VAR.UNBALANCINGSTRIKE(pUnit,Event)
	local tank = pUnit:GetMainTank()
				if tank ~= nil then
pUnit:CastSpellOnTarget(62130,tank)
end
end

function BAEL.VAR.PHASE2(pUnit,Event) -- no lightning nova.
if pUnit:GetHealthPct() < 50 then
pUnit:RemoveEvents()
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BAEL[id] = BAEL[id] or {VAR={}}
pUnit:CastSpell(22663)
BAEL[id].VAR.TentacleOne = pUnit:SpawnCreature(33966, 163.82, -117.11, 91.50, 2.86, 14, 0)
BAEL[id].VAR.TentacleTwo = pUnit:SpawnCreature(33966, 162.20, -87.45, 91.50, 2.86, 14, 0)
pUnit:SendChatMessage(14,0,"Your ignorance is profound. Can you not see where this path leads?")
	pUnit:PlaySoundToSet(14170)
		 pUnit:RegisterEvent("BAEL.VAR.CreateAddsV2", 27000, 0)
		 pUnit:RegisterEvent("BAEL.VAR.StoneEffect", 10000, 1)
		 pUnit:RegisterEvent("BAEL.VAR.TENTACLESDEAD", 1000, 0)
		 pUnit:RegisterEvent("BAEL.VAR.UNBALANCINGSTRIKE", 10000, 0)
end
end

function BAEL.VAR.TENTACLESDEAD(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	BAEL[id] = BAEL[id] or {VAR={}}
	if BAEL[id].VAR.TentacleOne:IsDead() and BAEL[id].VAR.TentacleTwo:IsDead() == true then
	pUnit:RemoveEvents()
	pUnit:RemoveAura(22663)
	pUnit:CastSpell(61029) -- tremor effect
	pUnit:SendChatMessage(14,0,"You cross the precipice of oblivion!")
	pUnit:PlaySoundToSet(14171)
		 pUnit:RegisterEvent("BAEL.VAR.CreateAddsV2", 30000, 0)
		 pUnit:RegisterEvent("BAEL.VAR.StoneEffect", 10000, 1)
		 pUnit:RegisterEvent("BAEL.VAR.BOSSENRAGE", 180000 ,1)
		 pUnit:RegisterEvent("BAEL.VAR.CURSEOFDOOM", 17000 ,0)
		 pUnit:RegisterEvent("BAEL.VAR.UNBALANCINGSTRIKE", 10000, 0)
end
end

function BAEL.VAR.CURSEOFDOOM(pUnit,Event)
player = pUnit:GetRandomPlayer(7)
if player ~= nil then
pUnit:CastSpellOnTarget(70144,player)
end
end



function BAEL.VAR.BOSSENRAGE(pUnit,Event)
pUnit:SendChatMessage(14,0,"I... am... FOREVER!")
pUnit:PlaySoundToSet(14167)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if players ~= nil then
pUnit:CastSpellOnTarget(62131,players)
end
end
end

function BAEL.VAR.CreateAddsV2(pUnit,Event)
pUnit:SpawnCreature(15726, 118.99, -113.93, 91.43, 0.48, 14, 0)
pUnit:SpawnCreature(15726, 118.54, -89.63, 91.50, 5.97, 14, 0)
pUnit:SpawnCreature(15726, 139.42, -78.47, 91.47, 4.78, 14, 0)
pUnit:SpawnCreature(15726, 139.79, -125.61, 91.40, 1.42, 14, 0)
pUnit:SpawnCreature(15726, 160.69, -113.74, 91.48, 2.66, 14, 0)
pUnit:SpawnCreature(15726, 160.73, -90.02, 91.48, 3.73, 14, 0)
end

function BAEL.VAR.LIGHTNINGNOVA(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Root()
pUnit:SendChatMessage(42,0,"Archeras Begins Casting \124cff71d5ff\124Hspell:52960\124h[Lightning Nova]\124h\124r")
pUnit:FullCastSpell(59835)
pUnit:RegisterEvent("BAEL.VAR.ReRegister", 5200, 1)
if math.random(1,2) == 1 then
pUnit:SendChatMessage(14,0,"Come closer. I will make it quick.")
pUnit:PlaySoundToSet(14164)
elseif math.random(1,2) == 2 then
pUnit:SendChatMessage(14,0,"Your flesh cannot hold out for long.")
pUnit:PlaySoundToSet(14165)
end
end

function BAEL.VAR.ReRegister(pUnit,Event)
pUnit:Unroot()
 pUnit:RegisterEvent("BAEL.VAR.LIGHTNINGNOVA", 30000, 1)
  pUnit:RegisterEvent("BAEL.VAR.StoneEffect", 22000, 1)
   pUnit:RegisterEvent("BAEL.VAR.CreateAdds", 13000, 0)
   pUnit:RegisterEvent("BAEL.VAR.UNBALANCINGSTRIKE", 10000, 0)
    pUnit:RegisterEvent("BAEL.VAR.PHASE2", 1000, 0)
  for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 27979 or creatures:GetEntry() == 27982 then 
	 if pUnit:GetDistanceYards(creatures) < 20 then
	 creatures:Kill(creatures)
	 --pUnit:CastSpell(39378)
			end
		end
	end
end


function BAEL.VAR.CreateAdds(pUnit,Event)
-- left is troggs
-- right is dwarves
if math.random(1,4) == 1 then
pUnit:SpawnCreature(27979, 139.71, -70.29, 92.26, 4.5, 14, 0) -- left pillar coords
pUnit:SpawnCreature(27982, 140.60, -133.28, 92.45, 1.6, 14, 0) -- right pillar coords
elseif math.random(1,3) == 2 then
pUnit:SpawnCreature(27982, 140.60, -133.28, 92.45, 1.6, 14, 0)
pUnit:SpawnCreature(27982, 140.60, -133.28, 92.45, 1.6, 14, 0)
elseif math.random(1,3) == 3 then
pUnit:SpawnCreature(27979, 139.71, -70.29, 92.26, 4.5, 14, 0)
pUnit:SpawnCreature(27979, 139.71, -70.29, 92.26, 4.5, 14, 0)
end
end

function BAEL.VAR.StoneEffectStun(pUnit,Event)
  pUnit:RegisterEvent("BAEL.VAR.StoneEffectRemove", 4000, 1)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if players ~= nil then
  players:CastSpell(33652)
  end
  end
  end

function BAEL.VAR.StoneEffectRemove(pUnit,Event)
 pUnit:RegisterEvent("BAEL.VAR.StoneEffect", 22000, 1)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if players ~= nil then
		if players:HasAura(33652) == true then
		players:RemoveAura(33652)
		pUnit:Strike(players,1,5679,200,350,1)
local FriendsAllAround = players:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if players:GetDistanceYards(friends) < 8 then
   pUnit:Strike(players,1,5679,200,350,1)
    pUnit:Strike(friends,1,5679,300,450,1)
		end
			end
		end
	end
end
	end
	
	
	function BAEL.VAR.Archeras_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:GetGameObjectNearestCoords(88.30, -102.39, 97.54, 194554):SetByte(GAMEOBJECT_BYTES_1,0,0)
	 for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
	if creatures:GetEntry() == 27979 or creatures:GetEntry() == 27982 or creatures:GetEntry() == 15726 or creatures:GetEntry() == 33966 then 
	 creatures:Despawn(1,0)
	end
	end
	pUnit:RemoveAura(22663)
	pUnit:Despawn(2000,5000)
	end
	
	function BAEL.VAR.Archeras_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:GetGameObjectNearestCoords(88.30, -102.39, 97.54, 194554):SetByte(GAMEOBJECT_BYTES_1,0,0)
	pUnit:SendChatMessage(14,0,"My death... heralds the end of this world.")
pUnit:PlaySoundToSet(14172)
if creatures:GetEntry() == 27979 or creatures:GetEntry() == 27982 or creatures:GetEntry() == 15726 or creatures:GetEntry() == 33966 then 
	 creatures:Despawn(1,0)
	 end
	end
	
	function BAEL.VAR.Archeras_Kill(pUnit,Event)
	if math.random(1,2) == 1 then
pUnit:SendChatMessage(14,0,"Only mortal...")
pUnit:PlaySoundToSet(14166)
elseif math.random(1,2) == 2 then
pUnit:SendChatMessage(14,0,"What little time you had, you wasted!")
pUnit:PlaySoundToSet(14168)
	end
end
	
	RegisterUnitEvent(444092, 2, "BAEL.VAR.Archeras_LEAVE")
RegisterUnitEvent(444092, 4, "BAEL.VAR.Archeras_DEAD")
	RegisterUnitEvent(444092, 1, "BAEL.VAR.Archeras_Combat")
	RegisterUnitEvent(444092, 3, "BAEL.VAR.Archeras_Kill")
	
	
	-----TRASH----
	
	
	function BAEL.VAR.CUSTODIAN_COMBAT(pUnit,Event)
	pUnit:RegisterEvent("BAEL.VAR.RUNEPUNCH", 10000, 0)
	pUnit:RegisterEvent("BAEL.VAR.RUNESHIELD", 12000, 0)
	local FriendsAllAround = pUnit:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if pUnit:GetDistanceYards(pUnit) < 7 then
  pUnit:SetSoulLinkedWith(friends) 
	end
	end
	end
	
	function BAEL.VAR.RUNEPUNCH(pUnit,Event)
		local tank = pUnit:GetMainTank()
				if tank ~= nil then
pUnit:CastSpellOnTarget(52702,tank)
end
end

function BAEL.VAR.RUNESHIELD(pUnit,Event)
pUnit:CastSpell(52630)
end

	function BAEL.VAR.CUSTODIAN_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	end
	
		function BAEL.VAR.CUSTODIAN_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	end
	
	
		RegisterUnitEvent(27985, 2, "BAEL.VAR.CUSTODIAN_LEAVE")
RegisterUnitEvent(27985, 4, "BAEL.VAR.CUSTODIAN_DEAD")
	RegisterUnitEvent(27985, 1, "BAEL.VAR.CUSTODIAN_COMBAT")
	
	
		function BAEL.VAR.GUARDIAN_COMBAT(pUnit,Event)
pUnit:RegisterEvent("BAEL.VAR.FORGEDDWARF_SS", 6000, 0)
pUnit:RegisterEvent("BAEL.VAR.DWARFWINDSHEAR", 3000, 0)
local FriendsAllAround = pUnit:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if pUnit:GetDistanceYards(pUnit) < 5 then
  pUnit:SetSoulLinkedWith(friends) 
	end
	end
	end
	
	

	function BAEL.VAR.GUARDIAN_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	end
	
		function BAEL.VAR.GUARDIAN_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	end
	
	
		RegisterUnitEvent(33388, 2, "BAEL.VAR.GUARDIAN_LEAVE")
RegisterUnitEvent(33388, 4, "BAEL.VAR.GUARDIAN_DEAD")
	RegisterUnitEvent(33388, 1, "BAEL.VAR.GUARDIAN_COMBAT")
	


function BAEL.VAR.ACOLYTE_SMITE(pUnit,Event)
		if pUnit:IsCasting() == false then
		local tank = pUnit:GetMainTank()
				if tank ~= nil then
pUnit:FullCastSpellOnTarget(6060,tank)
end
end
end


function BAEL.VAR.ACOLYTE_HEAL(pUnit,Event)
	if pUnit:GetHealthPct() < 70 then
		pUnit:RemoveEvents()
		pUnit:Root()
		pUnit:FullCastSpell(2060)
		pUnit:RegisterEvent("BAEL.VAR.ACOLYTE_SMITE", 4000,0)
		pUnit:RegisterEvent("BAEL.VAR.UNROOTCASTER", 3100,1)
		pUnit:RegisterEvent("BAEL.VAR.ACOLYTE_HEAL", 7100,0)
	else 
		local friend = pUnit:GetClosestFriend()
		if friend ~= nil then
			if friend:GetHealthPct() < 70 then
				if pUnit:GetDistanceYards(friend) < 15 then
				pUnit:Root()
					pUnit:FullCastSpellOnTarget(2060,friend)
					pUnit:RemoveEvents()
				end
			end
		end
		pUnit:RegisterEvent("BAEL.VAR.ACOLYTE_SMITE", 4000,0)
		pUnit:RegisterEvent("BAEL.VAR.ACOLYTE_HEAL", 7100,0)
			pUnit:RegisterEvent("BAEL.VAR.UNROOTCASTER", 3100,1)
	end
end

		function  BAEL.VAR.ACOLYTE_COMBAT(pUnit,Event)
pUnit:RegisterEvent("BAEL.VAR.ACOLYTE_SMITE", 4000, 0)
pUnit:RegisterEvent("BAEL.VAR.ACOLYTE_HEAL", 6000, 0)
local FriendsAllAround = pUnit:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if pUnit:GetDistanceYards(pUnit) < 5 then
  pUnit:SetSoulLinkedWith(friends) 
	end
	end
	end
	
	

	function  BAEL.VAR.ACOLYTE_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Unroot()
	end
	
		function  BAEL.VAR.ACOLYTE_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	end
	
	

		RegisterUnitEvent(32886, 2, "BAEL.VAR.ACOLYTE_LEAVE")
RegisterUnitEvent(32886, 4, "BAEL.VAR.ACOLYTE_DEAD")
	RegisterUnitEvent(32886, 1, "BAEL.VAR.ACOLYTE_COMBAT")
	
	
		function  BAEL.VAR.CHAMP_COMBAT(pUnit,Event)
pUnit:RegisterEvent("BAEL.VAR.CHAMP_WHIRL", 15000, 0)
pUnit:RegisterEvent("BAEL.VAR.CHAMP_STRIKE", 8000, 0)
local FriendsAllAround = pUnit:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if pUnit:GetDistanceYards(pUnit) < 5 then
  pUnit:SetSoulLinkedWith(friends) 
	end
	end
	end
	

	function BAEL.VAR.CHAMP_WHIRL(pUnit,Event)
	pUnit:CastSpell(40653)
	pUnit:RegisterEvent("BAEL.VAR.UNROOTCASTER", 10000,1)
	end
	

	function BAEL.VAR.CHAMP_STRIKE(pUnit,Event)
		local tank = pUnit:GetMainTank()
				if tank ~= nil then
pUnit:CastSpellOnTarget(35054,tank)
end
end

	function  BAEL.VAR.CHAMP_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	end
	
		function  BAEL.VAR.CHAMP_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	end
		RegisterUnitEvent(32876, 2, "BAEL.VAR.CHAMP_LEAVE")
RegisterUnitEvent(32876, 4, "BAEL.VAR.CHAMP_DEAD")
	RegisterUnitEvent(32876, 1, "BAEL.VAR.CHAMP_COMBAT")
	
	
			function  BAEL.VAR.STORM_COMBAT(pUnit,Event)
			pUnit:RegisterEvent("BAEL.VAR.ForgedTrogg_CL", 4000, 0)
			pUnit:RegisterEvent("BAEL.VAR.STORM_HURRICANE", 8000, 1)
			local FriendsAllAround = pUnit:GetInRangeFriends()
  for a, friends in pairs(FriendsAllAround) do
  if pUnit:GetDistanceYards(pUnit) < 5 then
  pUnit:SetSoulLinkedWith(friends) 
	end
	end
	end
	
	function BAEL.VAR.STORM_HURRICANE(pUnit,Event)
	player = pUnit:GetRandomPlayer(0)
if player ~= nil then
	pUnit:CastSpellAoF(player:GetX(), player:GetY(), player:GetZ(), 16914)
	end
	pUnit:RegisterEvent("BAEL.VAR.STORM_HURRICANE", 11000, 1)
	end
	
	

	function  BAEL.VAR.STORM_LEAVE(pUnit,Event)
	pUnit:RemoveEvents()
	end
	
		function  BAEL.VAR.STORM_DEAD(pUnit,Event)
	pUnit:RemoveEvents()
	end
	
	

		RegisterUnitEvent(27984, 2, "BAEL.VAR.STORM_LEAVE")
RegisterUnitEvent(27984, 4, "BAEL.VAR.STORM_DEAD")
	RegisterUnitEvent(27984, 1, "BAEL.VAR.STORM_COMBAT")
	
	
function BAEL.VAR.LFPDUMMY_OnSpawn(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:RegisterEvent("BAEL.VAR.LFP_Intro",1200,0)
end

RegisterUnitEvent(97190, 18, "BAEL.VAR.LFPDUMMY_OnSpawn")


function BAEL.VAR.LFP_Intro(pUnit,Event)
player = pUnit:GetClosestPlayer()
if player ~= nil then
if pUnit:GetDistanceYards(player) < 15 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"I have witnessed the rise and fall of empires... the birth and extinction of entire species... Over countless millennia the foolishness of mortals has remained the only constant. Your presence here confirms this.")
pUnit:PlaySoundToSet(14160)
end
end
end
	