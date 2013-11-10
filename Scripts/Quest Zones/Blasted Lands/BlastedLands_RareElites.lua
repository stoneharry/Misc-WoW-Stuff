function RAREBEAST_GRUNTER(pUnit,Event)
if pUnit:IsPet() == true then
pUnit:SetScale(.5)
end
end

RegisterUnitEvent(77055,18, "RAREBEAST_GRUNTER") 