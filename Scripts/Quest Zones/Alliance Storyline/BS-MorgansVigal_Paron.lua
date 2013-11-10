--[[ Horde Guard Paron ]]--

function Paron_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Paron_Charge", 500, 1)
local arandom= math.random(1,3) -- random = a internal lua function, do not use it :)
 if arandom==1 then
 pUnit:SendChatMessage(12, 0, "Burning Steppes belongs to the Horde!")
 pUnit:PlaySoundToSet(50033)
 end
     end

function Paron_Charge(pUnit, Event)
 pUnit:FullCastSpellOnTarget(100, pUnit:GetMainTank())
end

RegisterUnitEvent(50001, 1, "Paron_OnCombat")