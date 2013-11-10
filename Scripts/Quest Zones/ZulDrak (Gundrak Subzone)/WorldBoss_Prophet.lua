local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

--[[Interrupting Dark Rituals
===============================
Deep in Inner Gundrak there be a prophet named Lun'lokath, she was like us, a rebel fightin' for her freedom until she stabbed us in da
back, mon'. She betrayed us all for da' powers of da' Loa Gods and killed our brothers and sisters. She 
must be put to an end, $R. If ya' vanquish Lun'lokath I will make sure ya' got a reputation and ya' will
be able to choose from our fine crafted Drakkari Armor.$B

I warn ya, $R. She be very powerful and ya' might want to bring atleast ten friends with ya'.


Incomplete:
Da prophet still lives to torment more souls.

Complete:
You have succeeded my wildest expectations, mon'. Choose what ya' see fit.

Rep Reward: 1000
Gold: 10
Item Rewards: EPIC lvl63.5 CLOAKS

CASTER SPELLPOWER CLOAK
AGIL/STAM CRIT CLOAK
STR/STAM EXPERTISE CLOAK
STAM DODGE CLOAK


Da Drakkari be trainin' in inner Gundrak. They built Sentinels to protect their Claws of Har'koa and the area, 
if we are to go into Gundrak they must be destroyed.$B 
Be wary friend for they are very strong, ya might want to bring ya friends. 
]]

function PROPHET_COMBAT(pUnit,Event)
pUnit:RemoveEvents()
	pUnit:SendChatMessage(14,0,"What is this disturbance?! You dare trespass upon this hallowed ground? This shall be your final resting place.")
	pUnit:RegisterEvent("PROPHET_FROSTBOLT", 1000, 1)
	pUnit:RegisterEvent("PROPHET_FROSTBOLT_VOLLEY", 7000, 0)
	pUnit:RegisterEvent("PROPHET_REFLECT", 20000, 0)
	pUnit:RegisterEvent("PROPHET_BLIZZARD", 8000, 0)
end

function PROPHET_FROSTBOLT(pUnit,Event)
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 38 then
pUnit:FullCastSpellOnTarget(46987,tank)
end
end
pUnit:RegisterEvent("PROPHET_FROSTBOLT", 3000, 1)
end

function PROPHET_REFLECT(pUnit,Event)
pUnit:CastSpell(22067)
end

function PROPHET_BLIZZARD(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
	if pUnit:GetDistanceYards(plr) < 38 then
pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 19099)
end
end
end

function PROPHET_FROSTBOLT_VOLLEY(pUnit,Event)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 38 then
pUnit:CastSpellOnTarget(12675,players)
end
end
end



function PROPHET_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(14,0,"Fools! My death heralds your end, Malakk will consume your souls!")
end

function PROPHET_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Despawn(1000,4000)
end

function PROPHET_SLAY(pUnit,Event)
if math.random(1,2) <= 1 then
	pUnit:SendChatMessage(14,0,"Do you yet grasp of the futility of your actions?")
elseif math.random(1,2) <= 2 then
	pUnit:SendChatMessage(14,0,"Embrace the darkness... Darkness eternal!")
end
end


RegisterUnitEvent(333652, 1, "PROPHET_COMBAT")
RegisterUnitEvent(333652, 4, "PROPHET_DEAD")
RegisterUnitEvent(333652, 2, "PROPHET_LEAVE")
RegisterUnitEvent(333652, 3, "PROPHET_SLAY")