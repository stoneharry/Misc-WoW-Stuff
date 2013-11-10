function Mogash_Spawn(pUnit,Event)
pUnit:ChannelSpell(75129,pUnit)
pUnit:AIDisableCombat(false)
end

RegisterUnitEvent(50015, 18, "Mogash_Spawn")


function Mogash_Combat(pUnit,Event)
pUnit:StopChannel()
pUnit:SendChatMessage(12, 0, "The Hour of Twilight is near!")
pUnit:RegisterEvent("Mogash_SHADOWBOLT", 2400, 0)
pUnit:RegisterEvent("BRM_UNROOT_CASTER", 1000, 0)
end



function Mogash_Leave(pUnit,Event)
pUnit:RemoveEvents()
pUnit:ChannelSpell(75129,pUnit)
end

function Mogash_Dead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:StopChannel()
end

RegisterUnitEvent(50015, 1, "Mogash_Combat")
RegisterUnitEvent(50015, 2, "Mogash_Leave")
RegisterUnitEvent(50015, 4, "Mogash_Dead")

function DumbOgres_OnCombat(pUnit, plr, Event)
if math.random(1,7) == 2 then
pUnit:SendChatMessage(12, 0, "Me mad! You get smash in face!")
elseif math.random(1,7) == 3 then
pUnit:SendChatMessage(12, 0, "Stupid puny thing! Me smash!")
elseif math.random(1,7) == 4 then
pUnit:SendChatMessage(12, 0, "Me smash! You die!")
end
end


function Mogash_SHADOWBOLT(pUnit,Event)
if pUnit:IsCasting() == false then
pUnit:Root()
local tank = pUnit:GetMainTank()
if tank ~= nil then
if pUnit:GetDistanceYards(tank) < 15 then
pUnit:FullCastSpellOnTarget(16408,tank)
end
end
end
end

function BRM_UNROOT_CASTER(pUnit,Event)
if pUnit:IsCasting() == false then
if pUnit:IsRooted() == true then
pUnit:Unroot()
end
end
end





RegisterUnitEvent(50016, 1, "DumbOgres_OnCombat")