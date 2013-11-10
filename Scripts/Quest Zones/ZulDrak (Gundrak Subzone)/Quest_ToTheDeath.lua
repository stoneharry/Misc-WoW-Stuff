local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 

local DREKMAZ


function DREKMAZ_Main(pUnit, event, player)
	pUnit:GossipCreateMenu(7777, player, 0)
	if player:HasQuest(9032) == true then
		pUnit:GossipMenuAddItem(9,"I challenge you to a duel", 3, 0)
		end
		pUnit:GossipMenuAddItem(10, "Nevermind.", 80, 0)
	pUnit:GossipSendMenu(player)
end

function DREKMAZ_Sub(pUnit, event, player, id, intid, code)
	if intid == 1 then
	 player:GossipComplete()
	elseif(intid == 3) then
	DREKMAZ = pUnit
	pUnit:SendChatMessage(12,0,"Ya' be dead meat mon!")
	pUnit:Emote(11,1800)
	pUnit:SetNPCFlags(2)
	RegisterTimedEvent("DrekMaz_Start", 1800, 1, player)
		player:GossipComplete()
		elseif (intid == 80) then
		player:GossipComplete()
	end
end

function DrekMaz_Start(pUnit,event,player)
DREKMAZ:SetFaction(16)
DREKMAZ:SendChatMessage(12,0,"Ya' gonna die now!")
DREKMAZ:GetGameObjectNearestCoords(6475.17, -3901.29, 484.91, 3267531):SetPhase(1)
DREKMAZ:GetGameObjectNearestCoords(6489.02, -3913.30, 484.47, 3267531):SetPhase(1)
DREKMAZ:GetGameObjectNearestCoords(6501.39, -3899.38, 484.49, 3267531):SetPhase(1)
DREKMAZ:GetGameObjectNearestCoords(6486.97, -3886.50, 484.77, 3267531):SetPhase(1)
end


RegisterUnitGossipEvent(28918, 1, "DREKMAZ_Main")
RegisterUnitGossipEvent(28918, 2, "DREKMAZ_Sub")

function DREKMAZ_Spawn(pUnit,Event)
pUnit:SetMaxPower(1000,1)
pUnit:SetPower(1000,1)	
pUnit:SetPowerType(1)	
pUnit:SetNPCFlags(1)
pUnit:SetFaction(35)
	pUnit:ModifyRunSpeed(8)
	pUnit:ModifyWalkSpeed(2.5)
	 pUnit:AIDisableCombat(false)
end

RegisterUnitEvent(28918, 18, "DREKMAZ_Spawn")


function DREKMAZ_COMBAT(pUnit,Event)
	pUnit:ModifyRunSpeed(18)
	pUnit:ModifyWalkSpeed(18)
pUnit:RegisterEvent("DREKMAZ_WHIRLWIND", 7000, 0)
end

function DREKMAZ_WHIRLWIND(pUnit,Event)
 pUnit:RemoveEvents()
 pUnit:CastSpell(40653)
 pUnit:AIDisableCombat(true)
  pUnit:RegisterEvent("DREKMAZ_MOVERANDOMSPOT", 3000, 4)
  pUnit:RegisterEvent("DREKMAZ_REREGISTER", 12000, 1)
end

 function DREKMAZ_REREGISTER(pUnit,Event)
 pUnit:AIDisableCombat(false)
 pUnit:CancelSpell()
  pUnit:RegisterEvent("DREKMAZ_WHIRLWIND", 16000, 0)
 end
 
 function DREKMAZ_MOVERANDOMSPOT(pUnit,Event)
 if math.random(1,6) <= 1 then
 pUnit:MoveTo(6478.88,-3908.03,484.16,0)
 elseif math.random(1,6) <= 2 then
  pUnit:MoveTo(6479.61,-3891.02,483.96,0)
   elseif math.random(1,6) <= 3 then
   pUnit:MoveTo(6478.88,-3908.03,484.16,0)
    elseif math.random(1,6) <= 4 then
    pUnit:MoveTo(6486.16,-3898.39,483.63)
	 elseif math.random(1,6) <= 5 then
	 pUnit:MoveTo(6494.22,-3906.36,483.63,0)
	  elseif math.random(1,6) <= 6 then
	  pUnit:MoveTo(6496.00,-3892.61,483.65,0)
		end
	end

function DREKMAZ_DEAD(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Despawn(3000,7000)
pUnit:GetGameObjectNearestCoords(6475.17, -3901.29, 484.91, 3267531):SetPhase(2)
pUnit:GetGameObjectNearestCoords(6489.02, -3913.30, 484.47, 3267531):SetPhase(2)
pUnit:GetGameObjectNearestCoords(6501.39, -3899.38, 484.49, 3267531):SetPhase(2)
pUnit:GetGameObjectNearestCoords(6486.97, -3886.50, 484.77, 3267531):SetPhase(2)
end

function DREKMAZ_LEAVE(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Despawn(1000,5000)
pUnit:GetGameObjectNearestCoords(6475.17, -3901.29, 484.91, 3267531):SetPhase(2)
pUnit:GetGameObjectNearestCoords(6489.02, -3913.30, 484.47, 3267531):SetPhase(2)
pUnit:GetGameObjectNearestCoords(6501.39, -3899.38, 484.49, 3267531):SetPhase(2)
pUnit:GetGameObjectNearestCoords(6486.97, -3886.50, 484.77, 3267531):SetPhase(2)
end

RegisterUnitEvent(28918, 1, "DREKMAZ_COMBAT")
RegisterUnitEvent(28918, 4, "DREKMAZ_DEAD")
RegisterUnitEvent(28918, 2, "DREKMAZ_LEAVE")