local Dummychannel_A
local Dummychannel_B

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B

function Dummychannel_Az(pUnit,Event)
 Dummychannel_A = pUnit
end

RegisterUnitEvent(18555,18, "Dummychannel_Az")

function Dummychannel_Bz(pUnit,Event)
 Dummychannel_B = pUnit
end

RegisterUnitEvent(18582,18, "Dummychannel_Bz")

function Knaal_Spawn(pUnit,Event)
local door = pUnit:GetGameObjectNearestCoords(-9808, -3246, 59, 175946)
if door ~= nil then
door:SetByte(GAMEOBJECT_BYTES_1,0,0)
end
pUnit:SetMaxHealth(740)
pUnit:SetHealth(740)
pUnit:Unroot()
pUnit:EquipWeapons(28749,28358,0)
end

RegisterUnitEvent(77019,18, "Knaal_Spawn")


function Knaal_Leash(pUnit,Event)
local creature = pUnit:GetCreatureNearestCoords(-9819, -3256,58.99, 77019)
if creature ~= nil then
if pUnit:GetDistanceYards(creature) < 6 and creature:IsAlive() then
creature:RemoveEvents()
creature:Despawn(1,3000)
end
	end
     	end
			
			
function Knaals_Leasher(pUnit,Event)
 pUnit:RegisterEvent("Knaal_Leash", 1000, 0)
	end
	
	
		RegisterUnitEvent(78190,18, "Knaals_Leasher")

function Knaal_OnCombat(pUnit,Event)
--pUnit:GetGameObjectNearestCoords(-9808, -3246, 59, 175946):SetByte(GAMEOBJECT_BYTES_1,0,1)
pUnit:SendChatMessage(12,0,"You have faced many challenges, pity they were all in vain. Soon your people will kneel to my lord!")
pUnit:PlaySoundToSet(10292)
pUnit:CastSpell(71)
 pUnit:RegisterEvent("Knaal_Cleave", 6000, 0)
 pUnit:RegisterEvent("Knaal_Sunder", 8000, 0)
  pUnit:RegisterEvent("Shield_Wall", 15000, 0)
  pUnit:RegisterEvent("Shield_Block", 10000, 0)
  pUnit:RegisterEvent("Shield_Reflect", 22000, 0)
 pUnit:RegisterEvent("Phase2Knaal", 2500, 0)
end


function Knaal_Cleave(pUnit,Event)
pUnit:CastSpellOnTarget(40505, pUnit:GetMainTank())
end

function Knaal_Sunder(pUnit,Event)
pUnit:CastSpellOnTarget(7386, pUnit:GetMainTank())
end

function Shield_Wall(pUnit,Event)
pUnit:CastSpell(871)
end

function Shield_Reflect(pUnit,Event)
pUnit:CastSpell(23920)
end

function Shield_Block(pUnit,Event)
pUnit:CastSpell(2565)
end






function Phase2Knaal(pUnit, Event)
	if pUnit:GetHealthPct() < 70 then
	pUnit:RemoveEvents()
	pUnit:EquipWeapons(24550,0,0)
	pUnit:RemoveAura(2565)
	pUnit:RemoveAura(871)
	pUnit:CastSpell(2457)
	pUnit:SendChatMessage(12,0,"You are nothing, I answer a higher call!")
	pUnit:PlaySoundToSet(10295)
	 pUnit:RegisterEvent("Knaal_MS", 6000, 0)
	 pUnit:RegisterEvent("Knaal_WW", 8000, 0)
	 pUnit:RegisterEvent("Knaal_Fear", 20000, 0)
	 pUnit:RegisterEvent("Knaal_Charge", 13000, 0)
	 pUnit:RegisterEvent("Phase3Knaal", 2500, 0)
	end
end

function Knaal_MS(pUnit, Event)
 pUnit:CastSpellOnTarget(27580, pUnit:GetMainTank())
end

function Knaal_WW(pUnit,Event)
pUnit:CastSpell(1680)
pUnit:CastSpellOnTarget(40505, pUnit:GetMainTank())
end

function Knaal_Fear(pUnit,Event)
pUnit:CastSpell(8122)
end

function Knaal_Strike(pUnit, Event)
 pUnit:CastSpellOnTarget(11976, pUnit:GetMainTank())
end

function Knaal_Charge(pUnit,Event)
local plr = pUnit:GetRandomPlayer(0)
if plr ~= nil then
if pUnit:GetDistanceYards(plr) > 10 then
pUnit:CastSpellOnTarget(100, plr)
pUnit:CastSpellOnTarget(27580, plr)
end
end
end

function ShadowBolt(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 30 then
local PlayersAllAround = pUnit:GetInRangePlayers()
  for a, players in pairs(PlayersAllAround) do
pUnit:CastSpellOnTarget(686, players)
end
end
end
end

function Phase3Knaal(pUnit,Event)
if pUnit:GetHealthPct() < 40 then
	pUnit:RemoveEvents()
	pUnit:EquipWeapons(28749,28749,0)
	pUnit:SendChatMessage(12,0,"Your time is running out!")
	pUnit:PlaySoundToSet(10294)
	pUnit:RegisterEvent("Knaal_Charge", 6000, 0)
	pUnit:RegisterEvent("Knaal_Strike", 7000, 0)
	pUnit:RegisterEvent("ShadowBolt", 12000, 0)
	pUnit:RegisterEvent("Shadowfury", 20000, 0)
	pUnit:RegisterEvent("ChannelUnit", 1000, 1)
	end
	end
	
	function ChannelUnit(pUnit,Event)
	pUnit:CastSpell(35194)
	Dummychannel_B:ChannelSpell(60857,pUnit)
	Dummychannel_A:ChannelSpell(60857,pUnit)
	end
	
	function Shadowfury(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Root()
	pUnit:SendChatMessage(42,0,"Knaal begins to pound the ground with shadow magic.")
	pUnit:RegisterEvent("ShadowfuryChecker", 1000, 1)
    end
	
	 function ShadowfuryChecker(pUnit,Event)
	 pUnit:Emote(36,10500)
	  	pUnit:RegisterEvent("ShadowfuryCheckerz", 1500, 7)
	pUnit:RegisterEvent("ResetTimers", 10500, 1)
	  end
	 
	 function ResetTimers(pUnit,Event)
	 pUnit:Unroot()
	 pUnit:RegisterEvent("Knaal_Charge", 6000, 0)
	pUnit:RegisterEvent("Knaal_Strike", 7000, 0)
	pUnit:RegisterEvent("ShadowBolt", 5000, 0)
	pUnit:RegisterEvent("Shadowfury", 12000, 0)
	end
	 
	 function ShadowfuryCheckerz(pUnit,Event)
	  pUnit:CastSpell(39082)
	  pUnit:PlaySoundToSet(10069)
	  end
	  
	 
	  
	  
function Knaal_OnLeave(pUnit, Event)
if pUnit:IsInCombat() == false then 
pUnit:RemoveEvents()
pUnit:GetGameObjectNearestCoords(-9808, -3246, 59, 175946):SetByte(GAMEOBJECT_BYTES_1,0,0)
Dummychannel_A:StopChannel()
Dummychannel_B:StopChannel()
pUnit:RegisterEvent("Despawn_Knaal", 1000, 1)
end
end

function Despawn_Knaal(pUnit,Event)
pUnit:Despawn(1,4000)
end

function Knaal_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:GetGameObjectNearestCoords(-9808, -3246, 59, 175946):SetByte(GAMEOBJECT_BYTES_1,0,0)
	Dummychannel_A:StopChannel()
	Dummychannel_B:StopChannel()
	pUnit:SendChatMessage(12,0,"My lord will be the end of you all...")
	pUnit:PlaySoundToSet(10299)
	--[[for _,plr in pairs(pUnit:GetInRangePlayers()) do
		if plr:HasAura(64775) then
			plr:RemoveAura(64775)
		end
	end]]
end

function Knaal_OnSlay(pUnit, Event)
pUnit:CastSpell(8599)
if math.random(1,3) <= 1 then
pUnit:PlaySoundToSet(10297)
pUnit:SendChatMessage(12,0,"It is over. Finished!")
elseif math.random(1,3) <= 2 then
pUnit:PlaySoundToSet(10298)
pUnit:SendChatMessage(12,0,"Your days are done!")
elseif math.random(1,3) <= 3 then
pUnit:PlaySoundToSet(10296)
pUnit:SendChatMessage(12,0,"The Dark Lord laughs at you!")
end
end



RegisterUnitEvent(77019, 1, "Knaal_OnCombat")
RegisterUnitEvent(77019, 3, "Knaal_OnSlay")
RegisterUnitEvent(77019, 2, "Knaal_OnLeave")
RegisterUnitEvent(77019, 4, "Knaal_OnDead")