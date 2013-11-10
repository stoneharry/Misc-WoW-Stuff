local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC


function RANDOMTALK_GIL(pUnit,Event)
	local choice = math.random(1,5)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 40 then
			if choice == 1 then
				pUnit:SendChatMessageToPlayer(12,0,"There are so many of the poor people these days.",players)
			elseif choice == 2 then
				pUnit:SendChatMessageToPlayer(12,0,"I wonder, if I gave these poor people some copper, would they leave?",players)
			elseif choice == 3 then
				pUnit:SendChatMessageToPlayer(16,0,"Gil throws a copper coin at a Peasant Refugee.",players)
				local refugee = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 19170)
				if refugee ~= nil then
					refugee:SendChatMessageToPlayer(12,0,"Darn kid! Didn't your mother ever teach you manners?",players)
				end
			end
		end
	end
	pUnit:RegisterEvent("RANDOMTALK_GIL", math.random(20000, 35000), 1)
end

function Gilspawn(pUnit,Event)
	pUnit:RegisterEvent("RANDOMTALK_GIL", 5000, 1)
end

RegisterUnitEvent(3504,18, "Gilspawn")


function Peasant_spawn(pUnit,Event)
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
end

RegisterUnitEvent(19170,18, "Peasant_spawn")


function RANDOMTALK_Father(pUnit,Event)
	local choice = math.random(1,5)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 40 then
			if choice == 1 then
				pUnit:SendChatMessageToPlayer(12,0,"Many of you are here to seek guidance and refuge in these dark times, You have found it, you have succeeded. You are safe here, the light shall protect you..",players)
			elseif choice == 2 then
				pUnit:SendChatMessageToPlayer(12,0,"The light shall shine brightest on the blackest day. Fear not as we are safe here!",players)
			elseif choice == 3 then
				pUnit:SendChatMessageToPlayer(12,0,"We mourn our fallen friends and families but know this, their sacrifices have not gone in vain!",players)
			end
		end
	end
	pUnit:RegisterEvent("RANDOMTALK_Father", math.random(25000, 40000), 1)
end

function Fatherspawn(pUnit,Event)
	pUnit:RegisterEvent("RANDOMTALK_Father", 5000, 1)
	pUnit:RegisterEvent("RANDOMPRAYER_Father", 6000, 1)
end

function RANDOMPRAYER_Father(pUnit,Event)
	local choice = math.random(1,5)
	for _, sinners in pairs(pUnit:GetInRangeUnits()) do
		if pUnit:GetDistanceYards(sinners) < 10 then
			if choice == 1 then
				pUnit:CastSpellOnTarget(1243,sinners)
			elseif choice == 2 then
				pUnit:CastSpellOnTarget(139,sinners)
			elseif choice == 3 then
				pUnit:CastSpellOnTarget(9232,sinners)
			end
		end
	end
	pUnit:RegisterEvent("RANDOMPRAYER_Father", math.random(5000, 40000), 1)
end

RegisterUnitEvent(16825,18, "Fatherspawn")


function RANDOMEMOTE_Stromheart(pUnit,Event)
	local choice = math.random(1,4)
	if choice == 1 then
		pUnit:Emote(61,1000)
	elseif choice == 2 then
		pUnit:Emote(60,1000)
	elseif choice == 3 then
		pUnit:Emote(54,1000)
	elseif choice == 4 then
		pUnit:Emote(35,1000)
	end
	pUnit:RegisterEvent("RANDOMEMOTE_Stromheart", math.random(2000, 5000), 1)
end

function Stromheart(pUnit,Event)
	pUnit:RegisterEvent("RANDOMEMOTE_Stromheart", 3000, 1)
	pUnit:Emote(27,10000)
end

RegisterUnitEvent(440962,18, "Stromheart")

function RANDOMTALK_ChefBreanna(pUnit,Event)
	local choice = math.random(1,5)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 40 then
			if choice == 1 then
				pUnit:SendChatMessageToPlayer(12,0,"Soup's done. Nice and Hot, come and get it!",players)
				pUnit:Emote(5,2000)
			elseif choice == 2 then
				pUnit:SendChatMessageToPlayer(12,0,"I serve the best soup in all of Stromgarde! Come and get some!",players)
				pUnit:Emote(5,2000)
			elseif choice == 3 then
				pUnit:SendChatMessageToPlayer(12,0,"Now now, there's enough for everyone.",players)
				pUnit:Emote(274,2000)
			end
		end
	end
	pUnit:RegisterEvent("RANDOMTALK_ChefBreanna", math.random(25000, 45000), 1)
end

function ChefBreannaspawn(pUnit,Event)
	pUnit:RegisterEvent("RANDOMTALK_ChefBreanna", 5000, 1)
end

RegisterUnitEvent(343,18, "ChefBreannaspawn")
