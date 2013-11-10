
function Trainer_OnSpawn_NoActuallyVendor(pUnit, Event)
	pUnit:RegisterEvent("Do_Random_Stuff_Etc", 10000, 1)
end

function Do_Random_Stuff_Etc(pUnit)
	local choice = math.random(1,5)
	if choice == 1 then
		local dummy = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 32667)
		if dummy then
			pUnit:Emote(389, 2000)
			dummy:Emote(33, 2000)
		end
	elseif choice == 2 then
		local dummy = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 32667)
		if dummy then
			pUnit:Emote(390, 2800)
			dummy:Emote(34, 2800)
		end
	elseif choice == 3 then
		pUnit:Emote(386, 20000)
	elseif choice == 4 then
		pUnit:Emote(45, 20000)
	elseif choice == 5 then
		choice = math.random(1,3)
		if choice == 1 then
			pUnit:SendChatMessage(12,0,"What is stronger: wood, or the steel of my sword upon your bindings!")
		elseif choice == 2 then
			pUnit:SendChatMessage(12,0,"At long last, Training Dummy. We meet again, and for the last time!")
		elseif choice == 3 then
			pUnit:SendChatMessage(12,0,"Your mind games are no match for me, Training Dummy!")
		end
	end
	pUnit:RegisterEvent("Do_Random_Stuff_Etc", math.random(120000, 320000), 1)
end

RegisterUnitEvent(60007, 18, "Trainer_OnSpawn_NoActuallyVendor")