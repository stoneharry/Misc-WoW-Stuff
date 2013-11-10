local w = 0 -- wine
local e = 0 -- vial
local p = 0 -- plaguebloom
local l = 0 --bear liver
local g = 0 -- gnome head
local f = 0  -- fish oil
local d = 0 -- deviate fish
local r = 0 -- rabbit ears
local er = 0 --earthroot

function Cauldron_OnUseObject(pMisc, event, player)
	pMisc:GossipObjectCreateMenu(543213, player , 0)
	if player:HasQuest(3031) then
	if player:HasItem(34714) and player:HasItem(3300) and player:GetItemCount(3300) > 1 then 
	pMisc:GossipObjectMenuAddItem(4, "Attempt Recipe #3.", 249, 0)
	end
	if player:HasItem(12886) and player:HasItem(13466) and player:HasItem(3371) then
	pMisc:GossipObjectMenuAddItem(4, "Attempt Recipe #1.", 248, 0)
	end
	if player:HasItem(2449) and player:HasItem(6522) and player:HasItem(3371) then
	pMisc:GossipObjectMenuAddItem(4, "Attempt Recipe #4.", 247, 0)
	end
	if player:HasItem(3173) and player:HasItem(17058) and player:HasItem(3371) and player:GetItemCount(17058)  > 1 then
	pMisc:GossipObjectMenuAddItem(4, "Attempt Recipe #2.", 246, 0)
	end
end
pMisc:GossipObjectMenuAddItem(0, "<Walk Away.>", 250, 0)
pMisc:GossipObjectSendMenu(player)
end


function CauldronGossip_Submenus(GameObject, event, player, id, intid, code)
if(intid == 248) then
player:RemoveItem(12886,1)
player:RemoveItem(13466,1)
player:RemoveItem(3371,1)
local Doc = GameObject:GetCreatureNearestCoords(-9238.099,-2033.23,78.16, 78963)
Doc:SendChatMessage(14,0,"By the gods! What have you done?!")
Doc:Emote(431,3000)
player:CastSpell(61126)
Doc:SpawnCreature(78964,GameObject:GetX(), GameObject:GetY(), GameObject:GetZ(), 0, 14, 0)
player:GossipComplete()
end

if(intid == 247) then
player:RemoveItem(2449,1)
player:RemoveItem(6522,1)
player:RemoveItem(3371,1)
player:CastSpell(42365)
player:GossipComplete()
end

if(intid == 246) then
if player:HasItem(24428) == false then
player:RemoveItem(17058,2)
player:RemoveItem(3173,1)
player:RemoveItem(3371,1)
player:AddItem(24428,1)
player:GossipComplete()
else
player:SendBroadcastMessage("|cffffff00You already have the potion.|r")
player:GossipComplete()
end

if(intid == 249) then
player:RemoveItem(34714,1)
player:RemoveItem(3300,2)
player:CastSpell(61815)
local name = player:GetName()
local Doc = GameObject:GetCreatureNearestCoords(-9238.099,-2033.23,78.16, 78963)
Doc:SendChatMessage(16,0,"Dr. Krendal begins laughing hysterically at "..name.."")
Doc:Emote(11,1000)
player:GossipComplete()
end

if(intid == 250) then
player:GossipComplete()
end
end
end

RegisterGameObjectEvent(186157, 4, "Cauldron_OnUseObject")
RegisterGOGossipEvent(186157, 2, "CauldronGossip_Submenus")