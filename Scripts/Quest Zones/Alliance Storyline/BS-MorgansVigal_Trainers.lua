	function WarlockTrainer_Spawn(pUnit,Event)
	pUnit:RegisterEvent("Warlock_Hates_Mage", 5000, 0)
end

RegisterUnitEvent(5171, 18, "WarlockTrainer_Spawn")

	function MageTrainer_Spawn(pUnit,Event)
	pUnit:RegisterEvent("Mage_Hates_Warlock", 6000, 0)
end

RegisterUnitEvent(5144, 18, "MageTrainer_Spawn")


function Warlock_Hates_Mage(pUnit,Event)
  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 5144 then 
	pUnit:CastSpellOnTarget(52257,creature)
	pUnit:SetHealthPct(60)
end
end
if math.random(1,10) == 1 then
if math.random(1,12) <= 1 then
pUnit:SendChatMessage(12,0,"Take that, mage!")
elseif math.random(1,12) <= 2 then
pUnit:SendChatMessage(12,0,"I am superior to you, Bink!")
elseif math.random(1,12) <= 3 then
pUnit:SendChatMessage(12,0,"Warlocks are better than mages!")
end
end
end

function Mage_Hates_Warlock(pUnit,Event)
  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 5171 then 
	pUnit:CastSpellOnTarget(11,creature)
	pUnit:SetHealthPct(60)
end
end
if math.random(1,10) == 1 then
if math.random(1,12) <= 1 then
pUnit:SendChatMessage(12,0,"I hope that hurt!")
elseif math.random(1,12) <= 2 then
pUnit:SendChatMessage(12,0,"I hate you, Thistleheart!")
elseif math.random(1,12) <= 3 then
pUnit:SendChatMessage(12,0,"Mages are much better than you foul warlocks!")
end
end
end

function HunterTrainer_Spawn(pUnit,Event)
	pUnit:RegisterEvent("HunterTrainer_Visual", 5000, 0)
	pUnit:RegisterEvent("QQ_HUNTERtrainer_SetPower", 1000, 1)
	pUnit:Root()
end

function QQ_HUNTERtrainer_SetPower(pUnit)
	pUnit:SetMaxPower(100, 2)
	pUnit:SetPowerType(2)
end

function HunterTrainer_Visual(pUnit,Event)
  for place,creature in pairs(pUnit:GetInRangeUnits()) do 
	if creature:GetEntry() == 24792 then 
	pUnit:FullCastSpellOnTarget(3044,creature)
	creature:Emote(34,1000)
	break
end
end
end

RegisterUnitEvent(10930, 18, "HunterTrainer_Spawn")