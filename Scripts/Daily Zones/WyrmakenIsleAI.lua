



function WyrmrestIsle_AI_Events(pUnit,Event)
if Event == 1 then
if pUnit:GetEntry() == 445812 then
pUnit:RegisterEvent("AI_BoneFlurry", 3000, 1)
elseif pUnit:GetEntry() == 21627 then
pUnit:RegisterEvent("AI_DirtyTrick", 4000, 1)
elseif pUnit:GetEntry() == 6369 then
pUnit:RegisterEvent("AI_Shellwind", 4000, 1)
pUnit:RegisterEvent("AI_Rockshell", 15000, 0)
end
elseif Event == 2 or 4 then
pUnit:RemoveEvents()
end
	end
	
	
	function AI_BoneFlurry(pUnit)
	pUnit:FullCastSpell(70960)
	pUnit:RegisterEvent("AI_BoneFlurry", 9000, 1)
	end
	
	function AI_Shellwind(pUnit)
	pUnit:CastSpell(61009)
	pUnit:RegisterEvent("AI_Shellwind", 20000, 1)
	end
	
	function AI_Rockshell(pUnit)
	pUnit:CastSpell(33810)
	end
	
function AI_DirtyTrick(pUnit)
local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 10 then
		--pUnit:CastSpellAOF(tank:GetX(),tank:GetY(),tank:GetZ(),42805)
		pUnit:CastSpellOnTarget(tank,42805)
		end
	end
	pUnit:RegisterEvent("AI_DirtyTrick", 12000, 1)
end
	
	
	
		RegisterUnitEvent(445812, 1, "WyrmrestIsle_AI_Events")
		RegisterUnitEvent(445812, 2, "WyrmrestIsle_AI_Events")
		RegisterUnitEvent(445812, 4, "WyrmrestIsle_AI_Events")
		RegisterUnitEvent(21627, 1, "WyrmrestIsle_AI_Events")
		RegisterUnitEvent(21627, 2, "WyrmrestIsle_AI_Events")
		RegisterUnitEvent(21627, 4, "WyrmrestIsle_AI_Events")
				RegisterUnitEvent(6369, 1, "WyrmrestIsle_AI_Events")
		RegisterUnitEvent(6369, 2, "WyrmrestIsle_AI_Events")
		RegisterUnitEvent(6369, 4, "WyrmrestIsle_AI_Events")

------
	
	function WyrmakenIsle_SpiritHealer(pUnit,Event)
	pUnit:RegisterEvent("Ressurect_DeadPlayers", 2000, 0)
	end
	
function Ressurect_DeadPlayers(pUnit,Event)
		for _, players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 10 then
				if players:HasAura(8326) and players:IsDead() then
				players:ResurrectPlayer() 
				players:CastSpell(61613)
				end
			end
		end
	end
	
	
	RegisterUnitEvent(32537, 18, "WyrmakenIsle_SpiritHealer")

	
	
