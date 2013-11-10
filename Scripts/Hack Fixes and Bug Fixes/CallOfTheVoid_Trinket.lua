
function CallofTheVoid(item, event, player)
	if CooldownCheck(player, 120) then
		return
	else
		CooldownTime[player:GetName()] = os.clock()
		local Voidling = player:CreateGuardian(2623, 30000, 2, 19)
		Voidling:SetPetOwner(player)
	end
end
 
RegisterItemGossipEvent(46038, 1, "CallofTheVoid")
 
function THEVOID_SPAWN(pUnit,Event)
	local Owner = pUnit:GetPetOwner()
	if Owner ~= nil then
		 pUnit:SetMaxHealth(1200)
		 pUnit:SetHealth(1200)
		 pUnit:SetScale(0.15)
		 pUnit:CastSpell(25228)
		 Owner:CastSpell(25228)
		local choice = math.random(1,4)
		if choice == 1 then
			Owner:PlaySoundToPlayer(13997)
			pUnit:SendChatMessageToPlayer(15,0,"Know... my... pain.", Owner)
		elseif choice == 2 then
			Owner:PlaySoundToPlayer(13995)
			pUnit:SendChatMessageToPlayer(15,0,"I am... renewed.", Owner)
		elseif choice == 3 then
			Owner:PlaySoundToPlayer(13996)
			pUnit:SendChatMessageToPlayer(15,0,"Eradicate.", Owner)
		elseif choice == 4 then
			Owner:PlaySoundToPlayer(13998)
			pUnit:SendChatMessageToPlayer(15,0,"Gaze... into the void.", Owner)
		end
	 end
	pUnit:RegisterEvent("THEVOID_SUICIDE", 29500, 1)
 end
 
 function THEVOID_SUICIDE(pUnit,Event)
	 pUnit:Kill(pUnit)
 end
 

function THEVOID_KILLS(pUnit,Event)
	local Owner = pUnit:GetPetOwner()
	 if Owner ~= nil then
		local choice = math.random(1,3)
		if choice == 1 then
			Owner:PlaySoundToPlayer(13999)
			pUnit:SendChatMessageToPlayer(15,0,"More... energy.", Owner)
		elseif choice == 2 then
			Owner:PlaySoundToPlayer(14000)
			pUnit:SendChatMessageToPlayer(15,0,"Relinquish.", Owner)
		elseif choice == 3 then
			Owner:PlaySoundToPlayer(14001)
			pUnit:SendChatMessageToPlayer(15,0,"Fall... to shadow.", Owner)
		 end
	 end
 end
 
 function THEVOID_DIES(pUnit,Event)
	 pUnit:RemoveEvents()
	 local Owner = pUnit:GetPetOwner()
	 if Owner ~= nil then
		Owner:CastSpell(69391)
		Owner:RemoveAura(25228)
		Owner:PlaySoundToPlayer(14002)
		pUnit:SendChatMessageToPlayer(15,0,"Disperse.", Owner)
	 end
 end
 
 RegisterUnitEvent(2623, 3,"THEVOID_KILLS")
  RegisterUnitEvent(2623, 4,"THEVOID_DIES")
 RegisterUnitEvent(2623, 18,"THEVOID_SPAWN")