function OrcScout_OnCombat(pUnit, plr, Event)
if math.random(1,2) == 1 then
if math.random(1,7) == 2 then
pUnit:SendChatMessage(12, 0, "The Horde shall crush you!")
elseif math.random(1,7) == 4 then
pUnit:SendChatMessage(12, 0, "I will take pleasure in killing you.")
elseif math.random(1,7) == 5 then
pUnit:SendChatMessage(12, 0, "I will place your head on a pike!")
end
end
end





RegisterUnitEvent(19175, 1, "OrcScout_OnCombat")