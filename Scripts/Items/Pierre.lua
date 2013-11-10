
function Pierre_Events(pUnit,Event)
	if Event == 18 then
		local Owner = pUnit:GetPetOwner()
		if Owner then
			local choice = math.random(1,4)
			if choice == 1 then
				pUnit:SendChatMessageToPlayer(12,0,"At your service!", Owner)
			elseif choice == 2 then
				pUnit:SendChatMessageToPlayer(12,0,"Let's have a smashing time!", Owner)
			elseif choice == 3 then
				pUnit:SendChatMessageToPlayer(12,0,"Would you like pancakes or waffles?", Owner)
			elseif choice == 4 then
				pUnit:SendChatMessageToPlayer(12,0,"You will never go hungry ever again!", Owner)
			end
			pUnit:RegisterEvent("Pierre_FeedOwner", 10000, 1)
		end
	elseif Event == 1 then
		pUnit:RegisterEvent("P_Meatslap", math.random(10000,15000), 0)
		pUnit:RegisterEvent("P_Tenderize", math.random(8000,10000), 0)
		local Owner = pUnit:GetPetOwner()
		if Owner then
			local choice = math.random(1,4)
			if choice == 1 then
				pUnit:SendChatMessageToPlayer(12,0,"I'm going to fry you alive!", Owner)
			elseif choice == 2 then
				pUnit:SendChatMessageToPlayer(12,0,"We do not partake in your manners!", Owner)
			elseif choice == 3 then
				pUnit:SendChatMessageToPlayer(12,0,"Combat mode, engaged!", Owner)
			elseif choice == 4 then
				pUnit:SendChatMessageToPlayer(12,0,"One meal coming right up!", Owner)
			end
		end
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Pierre_FeedOwner", math.random(45000,90000), 1)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		local Owner = pUnit:GetPetOwner()
		if Owner then
			pUnit:SendChatMessageToPlayer(12,0,"How rude!", Owner)
		end
	end
end

function Pierre_FeedOwner(pUnit,Event)
	local Owner = pUnit:GetPetOwner()
	if (Owner) and (Owner:IsInCombat() == false) then
		if Owner:HasAura(24870) or Owner:HasAura(66294) or Owner:HasAura(58468) or Owner:HasAura(58479) == false then
			local choice = math.random(1,4)
			if choice == 1 then
				pUnit:SendChatMessageToPlayer(12,0,"Have some pancakes!", Owner)
				Owner:CastSpell(24870)
				pUnit:CastSpellOnTarget(23065,Owner)
			elseif choice == 2 then
				pUnit:SendChatMessageToPlayer(12,0,"One meal coming right up!", Owner)
				Owner:CastSpell(66294)
				pUnit:CastSpellOnTarget(23065,Owner)
			elseif choice == 3 then
				pUnit:SendChatMessageToPlayer(12,0,"You look starved, here!", Owner)
				Owner:CastSpell(58468)
				pUnit:CastSpellOnTarget(23065,Owner)
			elseif choice == 4 then
				pUnit:SendChatMessageToPlayer(12,0,"Tea and crumpets for the master?", Owner)
				Owner:CastSpell(58479)
				pUnit:CastSpellOnTarget(23065,Owner)
			end
		end
	end
	pUnit:RegisterEvent("Pierre_FeedOwner", math.random(45000,90000), 1)
end

function P_Meatslap(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank and tank:GetHeath() < 2000 then
		pUnit:CastSpellOnTarget(37597, tank)
	end
end

function P_Tenderize(pUnit,Event)
	local tank = pUnit:GetMainTank()
	if tank and tank:GetHeath() < 2000 then
		pUnit:CastSpellOnTarget(37596, tank)
	end
end

RegisterUnitEvent(4498123, 1,"Pierre_Events")
RegisterUnitEvent(4498123, 3,"Pierre_Events")
RegisterUnitEvent(4498123, 4,"Pierre_Events")
RegisterUnitEvent(4498123, 18,"Pierre_Events")
