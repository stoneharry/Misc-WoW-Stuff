function DemolisherVehicle_SpellEffects(pUnit,Event)
pUnit:RegisterEvent("Demolish_Effect", 10000, 0)
end

function Demolish_Effect(pUnit,Event)
local enemy = pUnit:GetRandomEnemy()
	if enemy ~= nil then
		if enemy:IsDead() == false then
		if pUnit:GetDistanceYards(enemy) < 150 then
 pUnit:CastSpellOnTarget(57618,enemy)
			end
		end
	end
end



RegisterUnitEvent(33059, 18, "DemolisherVehicle_SpellEffects")