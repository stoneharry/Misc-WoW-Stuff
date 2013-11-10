
function Infernal_Rain_PEace(pUnit, Event)
	pUnit:RegisterEvent("Infernal_Rain_PEacezzz", 5000, 1)
end

function Infernal_Rain_PEacezzz(pUnit, Event)
	pUnit:CastSpellAoF(-8129.9, -761.2, 133.1, 32148)
	pUnit:CastSpellAoF(-8096, -692, 177, 32148)
	pUnit:CastSpellAoF(-8205.8, -736.6, 164, 32148)
	pUnit:CastSpellAoF(-8153.6, -751.5, 136.5, 32148)
	pUnit:RegisterEvent("Delay_Slightly_On_More_Infernals", 2000, 1)
	pUnit:RegisterEvent("Delay_Slightly_On_More_Infernals_Two", 4000, 1)
	pUnit:RegisterEvent("Infernal_Rain_PEacezzz", math.random(10000, 60000), 1)
end

function Delay_Slightly_On_More_Infernals(pUnit, Event)
	pUnit:CastSpellAoF(-8089.8, 755.5, 145, 32148)
	pUnit:CastSpellAoF(-8190, -765.8, 159.7, 32148)
	pUnit:CastSpellAoF(-8143, -779, 130, 32148)
end

function Delay_Slightly_On_More_Infernals_Two(pUnit, Event)
	pUnit:CastSpellAoF(-8177.9, -696, 163, 32148)
	pUnit:CastSpellAoF(-8117.8, -742, 135, 32148)
	pUnit:CastSpellAoF(-8187, -739, 140, 32148)
end

RegisterUnitEvent(152941, 18, "Infernal_Rain_PEace")

--------------------------------------------------------------

function HEAP_SPAM_WHEN_ALIVE_DRACODAR(pUnit, Event)
	pUnit:RegisterEvent("heal_spam_dracodar_when_alive", 20000, 0)
	pUnit:RegisterEvent("hellfire_visual_spam", math.random(2000, 12000), 0)
end

function heal_spam_dracodar_when_alive(pUnit, Event)
	pUnit:SetHealth(pUnit:GetMaxHealth())
end

function hellfire_visual_spam(pUnit, Event)
	if math.random(1,2) == 1 then
		if math.random(1,2) == 1 then
		pUnit:CastSpell(36115) -- visual
		end
		pUnit:CastSpellAoF(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 32475) -- to not deal damage
	end
end

function HEAP_SPAM_WHEN_ALIVE_DRACODARdead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(169111, 18, "HEAP_SPAM_WHEN_ALIVE_DRACODAR")
RegisterUnitEvent(169111, 4, "HEAP_SPAM_WHEN_ALIVE_DRACODARdead")
RegisterUnitEvent(297711, 18, "HEAP_SPAM_WHEN_ALIVE_DRACODAR")
RegisterUnitEvent(297711, 4, "HEAP_SPAM_WHEN_ALIVE_DRACODARdead")
--------------------------------------------------------------