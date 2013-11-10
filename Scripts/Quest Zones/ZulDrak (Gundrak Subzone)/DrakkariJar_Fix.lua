--[[simple bug fix for now

function BoxFix_OnUseObject(pMisc, event, player)
if player:HasQuest(9031) == true then
player:AddItem(36825,1)
pMisc:Despawn(1000,11000)
end
end


RegisterGameObjectEvent(188499, 4, "BoxFix_OnUseObject")]]