local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

function CreatureAI_LeaveDead(pUnit, Event)
	pUnit:RemoveEvents()
	--pUnit:RemoveAura(61181)
end

function Shoveltusk_Stag_Combat(pUnit, Event)
	pUnit:CastSpell(55860)
end

RegisterUnitEvent(23691, 1, "Shoveltusk_Stag_Combat")
 
 
function Verzil_Combat(pUnit, Event)
	pUnit:RegisterEvent("Verzil_Melt", math.random(3000, 6000), 0)
end

function Verzil_Melt(pUnit)
	local tank = pUnit:GetMainTank()
	if pUnit:GetDistanceYards(tank) < 12 then
		pUnit:CastSpellOnTarget(5159,tank)
	end
end

RegisterUnitEvent(43222, 1, "Verzil_Combat")
RegisterUnitEvent(43222, 2, "CreatureAI_LeaveDead")
RegisterUnitEvent(43222, 4, "CreatureAI_LeaveDead")

function Ninja_Combat(pUnit, Event)
	pUnit:RegisterEvent("ninja_shadowstep", 100, 1)
end

function ninja_shadowstep(pUnit)
	local tank = pUnit:GetMainTank()
	if pUnit:GetDistanceYards(tank) < 15 then
		pUnit:CastSpellOnTarget(46463, tank)
	end
end

RegisterUnitEvent(44001, 1, "Ninja_Combat")
RegisterUnitEvent(44001, 2, "CreatureAI_LeaveDead")
RegisterUnitEvent(44001, 4, "CreatureAI_LeaveDead")

function MonstrousGolem_Combat(pUnit, Event)
	pUnit:RegisterEvent("MG_LIGHTNINGFURY", math.random(4000, 8000), 0)
end

function MG_LIGHTNINGFURY(pUnit)
	local tank = pUnit:GetMainTank()
	if pUnit:GetDistanceYards(tank) < 8 then
		pUnit:CastSpellOnTarget(61561, tank)
	end
end

RegisterUnitEvent(394812, 1, "MonstrousGolem_Combat")
RegisterUnitEvent(394812, 2, "CreatureAI_LeaveDead")
RegisterUnitEvent(394812, 4, "CreatureAI_LeaveDead")

function Fudge_Combat(pUnit,Event)
	pUnit:RegisterEvent("Fudge_Corruption", math.random(4000, 8000), 0)
end

function Fudge_Corruption(pUnit)
	local tank = pUnit:GetMainTank()
	if pUnit:GetDistanceYards(tank) < 15 then
		pUnit:CastSpellOnTarget(6223, tank)
	end
end

RegisterUnitEvent(43997, 1, "Fudge_Combat")
RegisterUnitEvent(43997, 2, "CreatureAI_LeaveDead")
RegisterUnitEvent(43997, 4, "CreatureAI_LeaveDead")

function Bradford_Combat(pUnit, Event)
	--pUnit:CastSpell(61181) -- causes knockback
	pUnit:SendChatMessage(14,0,"Mmm? New test subjects!?")
	--pUnit:RegisterEvent("Bradford_Plague", math.random(6000, 10000), 1) -- OP
	pUnit:RegisterEvent("Bradford_ChemicalFlames", math.random(4000, 12000), 0)
end

function Bradford_Plague(pUnit, Event)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 12 then
			pUnit:CastSpellOnTarget(64153, tank)
		end
		pUnit:RegisterEvent("Bradford_Plague", math.random(20000, 32000), 1)
	end
end

function Bradford_ChemicalFlames(pUnit)
	pUnit:CastSpell(36253)
end

RegisterUnitEvent(234165, 1, "Bradford_Combat")
RegisterUnitEvent(234165, 2, "CreatureAI_LeaveDead")
RegisterUnitEvent(234165, 4, "CreatureAI_LeaveDead")
  
function Goblin_Combat(pUnit, Event)
	pUnit:RegisterEvent("Goblin_Sunder", math.random(3000, 12000), 0)
end

function Goblin_Sunder(pUnit)
	local tank = pUnit:GetMainTank()
	if tank ~= nil then
		if pUnit:GetDistanceYards(tank) < 6 then
			pUnit:CastSpellOnTarget(22426, tank)
		end
	end
end

RegisterUnitEvent(43996, 1, "Goblin_Combat")
RegisterUnitEvent(43996, 2, "CreatureAI_LeaveDead")
RegisterUnitEvent(43996, 4, "CreatureAI_LeaveDead")

function CHEMISTPANTRY_Combat(pUnit, Event)
	pUnit:Root()
	pUnit:ChannelSpell(70634, pUnit)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
	local PortalA = pUnit:GetCreatureNearestCoords(-652.38, 1174.80, 81.02, 68937)
	local PortalB = pUnit:GetCreatureNearestCoords(-638.38, 1166.30, 78.41, 68937)
	local PortalC = pUnit:GetCreatureNearestCoords(-653.32, 1188.36, 78.73, 68937)
	--PortalA:ChannelSpell(49128,pUnit) backup spell
	PortalA:ChannelSpell(48316, pUnit)
	PortalB:ChannelSpell(48316, pUnit)
	PortalC:ChannelSpell(48316, pUnit)
	pUnit:SendChatMessage(14,0,"Fool! Can you not see what power I wield?")
	pUnit:SendChatMessage(42,0,"Chemist Pantry begins to channel energy from the portals")
	--pUnit:RegisterEvent("CHEMISTPANTRY_ARCANEBLAST", math.random(12000,14000),0)
	pUnit:RegisterEvent("CHEMISTPANTRY_ARCANEMISSILES", math.random(5000, 6000), 0)
	pUnit:RegisterEvent("CHEMISTPANTRY_FLASKADD", math.random(7000, 10000), 0)
	pUnit:RegisterEvent("CHEMISTPANTRY_BOLT", math.random(10000, 15000), 0)
end



function CHEMISTPANTRY_ARCANEMISSILES(pUnit)
	--if pUnit:IsCasting() == false then
		local tank = pUnit:GetMainTank()
		if tank and pUnit:GetDistanceYards(tank) < 30 then
			pUnit:CastSpellOnTarget(7269,tank)
			pUnit:Strike(tank, 2, 7269, 50, 60, 2)
		end
	--end
end

function CHEMISTPANTRY_BOLT(pUnit)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 40 and players:IsAlive() and players:IsInPhase(1) then
			pUnit:CastSpellOnTarget(5145, players)
			pUnit:Strike(players, 2, 7269, 80, 100, 2)
		end
	end
end

function CHEMISTPANTRY_FLASKADD(pUnit)
	local players = pUnit:GetInRangePlayers()
	local tbl = {}
	for k, player in pairs (players) do
		if (player and player:IsAlive() and pUnit:GetDistanceYards(player) < 20) then
			table.insert(tbl, player)
		end
	end
	if #tbl > 1 then
		local r = math.random(1, (#tbl))
		local player = tbl[r]
		if player then
			pUnit:CastSpellOnTarget(43291,player)
			local x, y, z, o = player:GetLocation()
			pUnit:SpawnCreature(20865, x, y, z, o, 14, 0)
		end
	end
end

function CHEMISTPANTRY_ARCANEBLAST(pUnit)
	if pUnit:IsCasting() == false then
		pUnit:FullCastSpell(35927)
	end
end

function CHEMISTPANTRY_LEAVE(pUnit)
	pUnit:RemoveEvents()
	pUnit:Unroot()
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	local PortalA = pUnit:GetCreatureNearestCoords(-652.38, 1174.80, 81.02, 68937)
	local PortalB = pUnit:GetCreatureNearestCoords(-638.38, 1166.30, 78.41, 68937)
	local PortalC = pUnit:GetCreatureNearestCoords(-653.32, 1188.36, 78.73, 68937)
	PortalA:StopChannel()
	PortalB:StopChannel()
	PortalC:StopChannel()
	pUnit:StopChannel()
	for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 20865 then 
			creatures:Despawn(1,0)
		end
	end
end

RegisterUnitEvent(43970, 1, "CHEMISTPANTRY_Combat")
RegisterUnitEvent(43970, 2, "CHEMISTPANTRY_LEAVE")
RegisterUnitEvent(43970, 4, "CHEMISTPANTRY_LEAVE")


function Lagiacrus_Events(pUnit,Event)
if Event == 1 then
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	players:PlayMusicToPlayer(50110)
	end
		end
pUnit:RegisterEvent("Lagiacrus_Lightning", math.random(8000,12000), 0)
pUnit:RegisterEvent("Lagiacrus_Pushback", math.random(20000,22000), 0)
pUnit:RegisterEvent("Lagiacrus_Overloaded", 32000, 1)
pUnit:RegisterEvent("Lagiacrus_CantLeaveWater", 1000, 0)
elseif Event == 2 then
pUnit:Unroot()
pUnit:RemoveEvents()
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	players:PlayMusicToPlayer(0)
	end
		end
elseif Event == 4 then
pUnit:Unroot()
pUnit:RemoveEvents()
		local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 30 then
	players:PlayMusicToPlayer(50084)
	end
		end
	end
end


function Lagiacrus_Lightning(pUnit)
local plr = pUnit:GetRandomPlayer(0) 
	if plr then
	if plr:IsAlive() then
	if pUnit:GetDistanceYards(plr) < 32 then
		pUnit:CastSpellOnTarget(2860, plr) 
		end
		end
	end
end


function Lagiacrus_Overloaded(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Root()
for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 30 then
pUnit:SendChatMessageToPlayer(42,0,"The Lagiacrus becomes overloaded with electricity!",players)
end
	end
	pUnit:RegisterEvent("LagiacrusOVERLOADED_STRIKE", 1500, 8)
	pUnit:RegisterEvent("Lagiacrus_Restat", 12100, 1)
end

function Lagiacrus_Restat(pUnit,Event)
pUnit:Unroot()
pUnit:RegisterEvent("Lagiacrus_Lightning", math.random(8000,12000), 0)
pUnit:RegisterEvent("Lagiacrus_CantLeaveWater", 1000, 0)
pUnit:RegisterEvent("Lagiacrus_Pushback", math.random(20000,22000), 0)
pUnit:RegisterEvent("Lagiacrus_Overloaded", 32000, 1)
end

function Lagiacrus_Pushback(pUnit,Event)
pUnit:CastSpell(66794)
end

function Lagiacrus_CantLeaveWater(pUnit,Event)
if pUnit:GetZoneId() == 130 then
if pUnit:GetZ() >= 33 then
for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 30 then
		pUnit:CastSpellOnTarget(61586,players)
			players:CastSpell(45935)
			pUnit:Strike(players, 2, 29768, 4350, 5390, 2)
		end
	end
end
elseif pUnit:GetZoneId() == 44 then
if pUnit:GetZ() >= 55 then
for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 30 then
		pUnit:CastSpellOnTarget(61586,players)
			players:CastSpell(45935)
			pUnit:Strike(players, 2, 29768, 4350, 5390, 2)
		end
		end
	end
	end
end


function LagiacrusOVERLOADED_STRIKE(pUnit)
pUnit:CastSpell(45935)
	local player = pUnit:GetRandomPlayer(0)
	if player then
		if pUnit:GetDistanceYards(player) < 20 then
			pUnit:CastSpellOnTarget(61586,player)
			player:CastSpell(45935)
			pUnit:Strike(player, 2, 29768, 350, 390, 2)
		end
	end
end

RegisterUnitEvent(791023, 1, "Lagiacrus_Events")
RegisterUnitEvent(791023, 2, "Lagiacrus_Events")
RegisterUnitEvent(791023, 4, "Lagiacrus_Events")


function HoarderYells(pUnit)
pUnit:SendChatMessage(14,0,"GET AWAY FROM MY STUFF!")
end


RegisterUnitEvent(4333982, 1, "HoarderYells")