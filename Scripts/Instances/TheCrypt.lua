--.worldport 606 2868.77 732.014 254.701

CRYPT = {}
CRYPT.VAR = {}

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

--[[TRASH]]

--[[KING OF STROMGARDE FIGHT

SPELLS:
71877
Necrotic Touch
100 yd range
Instant
Your melee attacks deal an additional 10% damage as shadow damage.

55593
Necrotic Aura
Instant
A wave of necrotic energy fills the room, completely preventing all healing effects for 17 sec.

72688
Spectral Strike
Melee Range
Instant
Requires Melee Weapon
A spectral swing that slices past armor, dealing 100% of normal weapon damage. This strike ignores all armor.

24050
Spirit Burst
Melee Range
Instant
Deals 525 to 675 Shadow damage to enemies within 10 yards of the target.

72036
spell visual that freezes the ground

46648
Spectral Blast
Summons a channel ground visual(think portals) for 5-8 seconds.(USE TO SUMMON ADDS OR SOMETHING)


9326 AranFire02.wav 

9327 AranFrost02.wav 

9250 AranSlay01.wav 

9251 AranSummonElem01.wav 
9328 AranSlay02.wav 

9245 AranFire01.wav 

9246 AranFrost01.wav 

9247 AranGameOver01.wav 
]]


function CRYPT.VAR.ARCANEMINE_DUM_SPAWN(pUnit,Event)
pUnit:CastSpell(72628)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
pUnit:SetScale(1.5)
pUnit:RegisterEvent("CRYPT.VAR.ARCANEMINE_DUM_EXPLOSION",3000,1)
end

function CRYPT.VAR.ARCANEMINE_DUM_EXPLOSION(pUnit,Event)
pUnit:Despawn(1000,0)
pUnit:CastSpell(35426)
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
  if pUnit:GetDistanceYards(players) < 8 then
  if players:IsDead() == false then
 pUnit:Strike(players,1,1535,400,540,1)
end
end
end
end

RegisterUnitEvent(41719, 18, "CRYPT.VAR.ARCANEMINE_DUM_SPAWN")

function CRYPT.VAR.ARCANEMINE_SPAM_BOSS(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Root()
pUnit:SendChatMessage(14,0,"I'm not finished yet! No, I have a few more tricks up my sleeve.")
pUnit:PlaySoundToSet(9251)
pUnit:AIDisableCombat(true)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED)
pUnit:SetFacing(pUnit:GetO())
pUnit:ChannelSpell(67040,pUnit)
pUnit:RegisterEvent("CRYPT.VAR.SPAM_PLAYER_MOVEMENT",450,0)
 pUnit:RegisterEvent("CRYPT.VAR.SPAM_STOP_MAN_TROLLBANE",15000,0)
end

function CRYPT.VAR.SPAM_PLAYER_MOVEMENT(pUnit,Event)
 local player = pUnit:GetRandomPlayer(0)
if player ~= nil then
if player:IsDead() == false then
if pUnit:GetDistanceYards(player) < 40 then
 pUnit:SpawnCreature(41719,player:GetX() ,player:GetY(), player:GetZ(),player:GetO(), 35,0)
end
end
end
end

function CRYPT.VAR.SPAM_STOP_MAN_TROLLBANE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:StopChannel()
pUnit:CastSpell(72036)
pUnit:RegisterEvent("CRYPT.VAR.TROLLBANE_STRIKE_SPEC", math.random(7000,15000), 0)
pUnit:RegisterEvent("CRYPT.VAR.ARCANEMINE_SPAM_BOSS",30000,0)
pUnit:RegisterEvent("CRYPT.VAR.TROLLBANE_NOHEALING", math.random(17000,25000), 0)
local choice = math.random(1,2)
if choice == 1 then
pUnit:SendChatMessage(14,0,"Back to the cold dark with you!")
pUnit:PlaySoundToSet(9327)
elseif choice == 2 then
pUnit:SendChatMessage(14,0,"I'll freeze you all!")
pUnit:PlaySoundToSet(9246)
end
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
	if pUnit:GetDistanceYards(players) < 55 then
		if players:IsDead() == false then
				players:SetMana(players:GetMana()+15)
		players:CastSpell(41590)
		players:SetHealthPct(10)
		end
		end
		end
end

function CRYPT.VAR.TROLLBANE_COMBAT(pUnit,Event)
local choice = math.random(1,2)
if choice == 1 then
pUnit:SendChatMessage(14,0,"I will not be tortured again!")
pUnit:PlaySoundToSet(9323)
elseif choice == 2 then
pUnit:SendChatMessage(14,0,"Who are you? What do you want?! Stay away from me!")
pUnit:PlaySoundToSet(9324)
end
pUnit:RegisterEvent("CRYPT.VAR.ARCANEMINE_SPAM_BOSS",30000,0)
pUnit:RegisterEvent("CRYPT.VAR.TROLLBANE_STRIKE_SPEC", math.random(6000,18000), 0)
pUnit:RegisterEvent("CRYPT.VAR.TROLLBANE_NOHEALING", math.random(17000,25000), 0)
end


function CRYPT.VAR.TROLLBANE_STRIKE_SPEC(pUnit,Event)
local tank = pUnit:GetMainTank()
				if tank ~= nil then
				if tank:HasAura(41590) == true then
				tank:RemoveAura(41590)
				pUnit:CastSpellOnTarget(72688,tank)
end
end
end

function CRYPT.VAR.TROLLBANE_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:StopChannel()
end

function CRYPT.VAR.TROLLBANE_NOHEALING(pUnit,Event)
pUnit:CastSpell(55593)
end

function CRYPT.VAR.TROLLBANE_DIES(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Unroot()
pUnit:AIDisableCombat(false)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
pUnit:StopChannel()
pUnit:SendChatMessage(14,0,"At last the nightmare is over...")
pUnit:PlaySoundToSet(9244)
end

RegisterUnitEvent(442199, 1, "CRYPT.VAR.TROLLBANE_COMBAT")
RegisterUnitEvent(442199, 2, "CRYPT.VAR.TROLLBANE_LEAVE")





function CRYPT.VAR.FUELTANK_DEATH(pUnit,Event)
pUnit:CastSpell(34602)
 for i,unitvariables in pairs(pUnit:GetInRangeUnits()) do
if unitvariables ~= nil then
if pUnit:GetDistanceYards(unitvariables) < 11 then
		if unitvariables:IsDead() == false then
		unitvariables:RemoveAura(8269)
		unitvariables:CastSpell(50280)
		unitvariables:CastSpell(35856)
		 pUnit:Strike(unitvariables,1,1535,400,740,1)
end
end
end
end
end

RegisterUnitEvent(27064, 4, "CRYPT.VAR.FUELTANK_DEATH")


function CRYPT.VAR.SHARKBOSS_EVENTCOMBAT(pUnit,Event)
pUnit:RegisterEvent("CRYPT.VAR.SHARKBOSS_FRENZY", math.random(20000,35000),0)
pUnit:RegisterEvent("CRYPT.VAR.SHARKBOSS_DOTBITE", math.random(8000,11000),0)
pUnit:RegisterEvent("CRYPT.VAR.SHARKBOSS_EATLOWHEALTH", math.random(2000,3000),0)
pUnit:RegisterEvent("CRYPT.VAR.SHARKBOSS_POWERFULBITE", math.random(10000,14000),0)
pUnit:RegisterEvent("CRYPT.VAR.SHARKBOSS_GAPCLOSER", math.random(2000,5000),0)
end

function CRYPT.VAR.SHARKBOSS_POWERFULBITE(pUnit,Event)
local tank = pUnit:GetMainTank()
				if tank ~= nil then
	if pUnit:GetDistanceYards(tank) < 15 then
				pUnit:CastSpellOnTarget(48287,tank)
end
end
end

function CRYPT.VAR.SHARKBOSS_DOTBITE(pUnit,Event)
local tank = pUnit:GetMainTank()
				if tank ~= nil then
	if pUnit:GetDistanceYards(tank) < 15 then
				pUnit:CastSpellOnTarget(32901,tank)
end
end
end

function CRYPT.VAR.SHARKBOSS_GAPCLOSER(pUnit,Event)
local tank = pUnit:GetMainTank()
				if tank ~= nil then
	if pUnit:GetDistanceYards(tank) > 20 then
				pUnit:CastSpellOnTarget(37359,tank)
end
end
end

function CRYPT.VAR.SHARKBOSS_FRENZY(pUnit,Event)
pUnit:RemoveAura(8269)
pUnit:CastSpell(8269)
end

function CRYPT.VAR.SHARKBOSS_EVENTDEATH(pUnit,Event)
pUnit:RemoveEvents()
end

function CRYPT.VAR.SHARKBOSS_EVENTLEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Despawn(1000,8000)
end

function CRYPT.VAR.SHARKBOSS_EATLOWHEALTH(pUnit,Event)
local plr = pUnit:GetMainTank()
if plr ~= nil then
	if pUnit:GetDistanceYards(plr) < 10 then
		if plr:IsDead() == false then
			if plr:GetHealthPct() < 11 then
				local name = plr:GetName()
				pUnit:CastSpellOnTarget(58758,plr)
				local PlayersAllAround = pUnit:GetInRangePlayers()
				for a, players in pairs(PlayersAllAround) do
					if pUnit:GetDistanceYards(players) < 50 then
						pUnit:SendChatMessageToPlayer(42,0,""..name.."has been consumed.", players)
					end
				end
				end
			end
		end
	end
end

RegisterUnitEvent(499811, 1, "CRYPT.VAR.SHARKBOSS_EVENTCOMBAT")
RegisterUnitEvent(499811, 2, "CRYPT.VAR.SHARKBOSS_EVENTLEAVE")
RegisterUnitEvent(499811, 4, "CRYPT.VAR.SHARKBOSS_EVENTDEATH")



