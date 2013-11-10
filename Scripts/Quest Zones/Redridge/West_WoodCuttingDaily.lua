function treespawnsz(pUnit,Event)
pUnit:SetNPCFlags(1)
end


RegisterUnitEvent(77080, 18, "treespawnsz")


function DummySpawnc(pUnit,Event)
pUnit:RegisterEvent("Dummy_SpawnCreatures", 3000, 1)
end


RegisterUnitEvent(77187, 18, "DummySpawnc")

function Dummy_SpawnCreatures(pUnit,Event)
local player = pUnit:GetClosestPlayer()
	if player ~= nil then
		player:Unroot()
	if math.random(1,2) <= 1 then
			player:AddItem(23776,1)
	elseif math.random(1,2) <= 2 then
			player:AddItem(23776,2)
		end
		local x = pUnit:GetX()
        local y = pUnit:GetY()
        local z = pUnit:GetZ()
        local o = pUnit:GetO()
if math.random(1,10) <= 1 then
		elseif math.random(1,10) <= 2 then
			pUnit:SpawnCreature(77085, x+math.random(4,6), y+math.random(4,6), z, o, 14, 60000)
		elseif math.random(1,10) <= 3 then
			pUnit:SpawnCreature(77085, x-math.random(4,6), y-math.random(4,6), z, o, 14, 60000)
		else
			pUnit:SpawnCreature(77084, x+math.random(4,6), y+math.random(4,6), z, o, 14, 60000)
			pUnit:SpawnCreature(77084, x-math.random(4,6), y-math.random(4,6), z, o, 14, 60000)
		end
local creature = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(),77080)
		if creature ~= nil then
			creature:SetNPCFlags(1)
			creature:Despawn(6000,2000)
			creature:Kill(creature)
		end
		end
		end

function ChopingTree_On_Gossip(pUnit, event, player)
	if player:IsMounted() then
		player:Dismount()
	end
	if player:HasQuest(3014) == false then
	player:SendAreaTriggerMessage("|cffffff00Requires Quest: Lumber Jack For A Day.|r")
	else
		if player:GetItemCount(23776) == 10 then
			player:SendAreaTriggerMessage("|cffffff00You have enough lumber!|r")
		else
		local x = pUnit:GetX()
        local y = pUnit:GetY()
        local z = pUnit:GetZ()
        local o = pUnit:GetO()
		pUnit:SpawnCreature(77187 ,x , y, z, o, 35, 6000)
			pUnit:SetNPCFlags(2)
			player:Root()
			player:FullCastSpell(62990)
         
		end
	end
end





RegisterUnitGossipEvent(77080, 1, "ChopingTree_On_Gossip")




function BlackwoodShaman(pUnit,Event)
pUnit:EquipWeapons(6215,0,0)
pUnit:RegisterEvent("Lightningshield_spawncast", 1000, 1)
end


RegisterUnitEvent(77083, 18, "BlackwoodShaman")

function Lightningshield_spawncast(pUnit,Event)
pUnit:CastSpell(325)
end



function BlackwoodAmbusher(pUnit,Event)
pUnit:EquipWeapons(19852,19852,0)
end


RegisterUnitEvent(77084, 18, "BlackwoodAmbusher")


function BlackwoodHunter(pUnit,Event)
pUnit:EquipWeapons(30753,0,0)
pUnit:RegisterEvent("hunter_stealth", 500, 1)
end


RegisterUnitEvent(77082, 18, "BlackwoodHunter")


function hunter_stealth(pUnit,Event)
pUnit:CastSpell(59045)
end

function TreantSpirit_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
end

function TreantSpirit_OnDead(pUnit,Event)
pUnit:RemoveEvents()
end

function TreantSpirit_OnCombat(pUnit,Event)
pUnit:CastSpellOnTarget(8927, pUnit:GetMainTank())
pUnit:RegisterEvent("TreantSpirit_Stomp", 4000, 0)
pUnit:RegisterEvent("TreantSpirit_Heal", 10000, 0)
end

function TreantSpirit_Heal(pUnit,Event)
if pUnit:GetHealthPct() < 70 then
pUnit:RemoveEvents()
pUnit:CancelSpell()
pUnit:FullCastSpell(8940)
pUnit:RegisterEvent("TreantSpirit_Stomp", 4000, 0)
pUnit:RegisterEvent("TreantSpirit_Heal", 10000, 0)
end
end

function TreantSpirit_Stomp(pUnit,Event)
pUnit:FullCastSpellOnTarget(5179, pUnit:GetMainTank())
end



RegisterUnitEvent(77085, 1, "TreantSpirit_OnCombat")
RegisterUnitEvent(77085, 2, "TreantSpirit_OnLeave")
RegisterUnitEvent(77085, 4, "TreantSpirit_OnDead")


function Ambusher_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
end

function Ambusher_OnDead(pUnit,Event)
pUnit:RemoveEvents()
end

function Ambusher_OnCombat(pUnit,Event)
pUnit:RegisterEvent("Ambusher_Frenzy", 15000, 0)
pUnit:RegisterEvent("Ambusher_backstab", 8000, 0)
end

function Ambusher_Frenzy(pUnit,Event)
pUnit:CastSpell(53361)
end

function Ambusher_backstab(pUnit,Event)
pUnit:CastSpellOnTarget(2590, pUnit:GetMainTank())
end

RegisterUnitEvent(77084, 1, "Ambusher_OnCombat")
RegisterUnitEvent(77084, 2, "Ambusher_OnLeave")
RegisterUnitEvent(77084, 4, "Ambusher_OnDead")


function Hunter_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
end

function Hunter_OnDead(pUnit,Event)
pUnit:RemoveEvents()
end

function Hunter_OnCombat(pUnit,Event)
pUnit:RegisterEvent("Hunter_Trap", 8000, 1)
pUnit:RegisterEvent("Hunter_Net", 1000, 1)
end

function Hunter_Trap(pUnit,Event)
pUnit:CastSpell(13795)
end

function Hunter_Net(pUnit,Event)
pUnit:CastSpellOnTarget(49092, pUnit:GetMainTank())
end


RegisterUnitEvent(77082, 1, "Hunter_OnCombat")
RegisterUnitEvent(77082, 2, "Hunter_OnLeave")
RegisterUnitEvent(77082, 4, "Hunter_OnDead")




function BlackwoodShaman_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
end

function BlackwoodShaman_OnDead(pUnit,Event)
pUnit:RemoveEvents()
end

function BlackwoodShaman_OnCombat(pUnit,Event)
pUnit:CastSpellOnTarget(8052, pUnit:GetMainTank())
pUnit:RegisterEvent("BlackwoodShaman_Lightning", 3000, 0)
pUnit:RegisterEvent("BlackwoodShaman_Heal", 8000, 0)
end

function BlackwoodShaman_Heal(pUnit,Event)
if pUnit:GetHealthPct() < 70 then
pUnit:RemoveEvents()
pUnit:CancelSpell()
pUnit:FullCastSpell(8008)
pUnit:RegisterEvent("BlackwoodShaman_Lightning", 4000, 0)
pUnit:RegisterEvent("BlackwoodShaman_Heal", 8000, 0)
end
end

function BlackwoodShaman_Lightning(pUnit,Event)
pUnit:FullCastSpellOnTarget(915, pUnit:GetMainTank())
end



RegisterUnitEvent(77083, 1, "BlackwoodShaman_OnCombat")
RegisterUnitEvent(77083, 2, "BlackwoodShaman_OnLeave")
RegisterUnitEvent(77083, 4, "BlackwoodShaman_OnDead")