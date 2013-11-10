function APOTHECARY_SPAWN(pUnit,Event)
pUnit:RegisterEvent("APOTHECARY_DIALOGUE_LULZ", math.random(15000,20000),1)
end

RegisterUnitEvent(160631,18, "APOTHECARY_SPAWN") 

function APOTHECARY_DIALOGUE_LULZ(pUnit,Event)
pUnit:SendChatMessage(12,0,"Oh, there will be much fun to be had experimenting. Shall I use you for an abomination, no? A ghoul perhaps? Or would you rather be like the rest of your 'comrades'.")
pUnit:MoveTo(557.25,1563.83,132.57,5.73)
pUnit:RegisterEvent("APOTHECARY_DIALOGUE_LULZZ",7000,1)
end

function APOTHECARY_DIALOGUE_LULZZ(pUnit,Event)
local guard = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 36363)
guard:SendChatMessage(12,0,"You're sick! There is no place for your kind in this world.")
pUnit:RegisterEvent("APOTHECARY_DIALOGUE_LULZZZ",4000,1)
end

function APOTHECARY_DIALOGUE_LULZZZ(pUnit,Event)
pUnit:SendChatMessage(16,0,"Apothecary Jim laughs at the Stormwind Guard.")
pUnit:Emote(11,1500)
pUnit:RegisterEvent("APOTHECARY_DIALOGUE_LULZZZZZ",3000,1)
end

function APOTHECARY_DIALOGUE_LULZZZZZ(pUnit,Event)
pUnit:SendChatMessage(12,0,"My dear boy; being dead is only the beginning.")
pUnit:Emote(1,2000)
pUnit:RegisterEvent("APOTHECARY_DIALOGUE_LULZ", math.random(60000,90000),1)
pUnit:RegisterEvent("APOTHECARY_DIALOGUE_RESET",2500,1)
end

function APOTHECARY_DIALOGUE_RESET(pUnit)
pUnit:MoveTo(557.29,1569.81,131.95,2.79)
end
