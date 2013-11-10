


function SavoryDeviateFish(item, event, player)
		if CooldownCheck(player, 0) then
			return
		else
			CooldownTime[player:GetName()] = os.clock()
if player:GetGender() == 0 then
if math.random(1,2) == 1 then -- pirate
player:CastSpell(8221)
elseif math.random(1,2) == 2 then -- ninja
player:CastSpell(8219)
end
elseif player:GetGender() == 1 then
if math.random(1,2) == 1 then
player:CastSpell(8222)
elseif math.random(1,2) == 2 then
player:CastSpell(8220)
end
					end
				end
				player:RemoveItem(6657,1)
				end

 
 
 
 
 RegisterItemGossipEvent(6657, 1, "SavoryDeviateFish")
 
 
 
 
function StrangeGreenFluid(item, event, player)
if CooldownCheck(player, 0) then
			return
		else
			CooldownTime[player:GetName()] = os.clock()
if player:GetGender() == 0 then
player:CastSpell(83295)
elseif player:GetGender() == 1 then
player:CastSpell(83294)
end
end
player:RemoveItem(40081,1)
end

 
 
 
 
 RegisterItemGossipEvent(40081, 1, "StrangeGreenFluid")