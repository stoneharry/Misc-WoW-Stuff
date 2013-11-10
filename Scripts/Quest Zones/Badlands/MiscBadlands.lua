local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

function Landmines(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
    if players ~= nil then
  if players:IsAlive() == true then
if pUnit:GetDistanceYards(players) < 3 then
  pUnit:RemoveEvents()
    pUnit:Despawn(1000,10000)
  pUnit:CastSpell(46419)
  pUnit:Strike(players, 1, 72620, 170, 250, 1.2)
  players:CastSpell(54899)
	end
		end
			end
		end
		 for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
		     if creatures ~= nil then
  if creatures:IsAlive() == true then
if pUnit:GetDistanceYards(creatures) < 3 then
 pUnit:RemoveEvents()
    pUnit:Despawn(1000,10000)
  pUnit:CastSpell(46419)
  if creatures:GetEntry() == 10481 then
  pUnit:Kill(creatures)
  else
  pUnit:Strike(players, 1, 72620, 270, 350, 1.2)
	end
	end
end
	end
end
	end
	
	function Landmines_Spwn(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("Landmines", 100, 0)
	end

RegisterUnitEvent(7527,18, "Landmines_Spwn") 