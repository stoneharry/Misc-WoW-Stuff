
local play = nil
local Bink = nil

function aehHarpoon_Used_Ha(pMisc, Event, player)
	if Bink ~= nil then
	SetDBCSpellVar(71614, "c_is_flags", 0x01000)
	player:CastSpell(34326) -- frost nova visual
	player:CastSpell(71614) -- ice block
	play = player
	Bink:SetMovementFlags(1) -- Run
	Bink:MoveTo(-6619, -1299.6, 209, 5)
	Bink:RegisterEvent("ttesojspjxpjirjspiwajtyahapgaen", 4000, 1)
	end
end

RegisterGameObjectEvent(8000003, 4, "aehHarpoon_Used_Ha")

function Leecher_Just_Stole_LIchKING_SCript(pUnit, Event)
	Bink = pUnit
end

RegisterUnitEvent(295201, 18, "Leecher_Just_Stole_LIchKING_SCript")

function ttesojspjxpjirjspiwajtyahapgaen(pUnit, Event)
	if play == nil then
	pUnit:Despawn(0,1)
	else
		if Bink == nil then
		pUnit:Despawn(0,1)
		else
		Bink:SendChatMessage(12,0,"My, what have we here? Your not trying to steal some of the plans are you?")
		Bink:Emote(1, 5000)
		Bink:RegisterEvent("ttesojspjxpjirjspiwajtyahapgaenzz", 2000, 1)
		end
	end
end

function ttesojspjxpjirjspiwajtyahapgaenzz(pUnit, Event)
	if play == nil then
	pUnit:Despawn(0,1)
	else
		if Bink == nil then
		pUnit:Despawn(0,1)
		else
		Bink:RegisterEvent("ttesojspjxpjirjspiwajtyahapgaenzzzz", 4000, 1)
		end
	end
end

function ttesojspjxpjirjspiwajtyahapgaenzzzz(pUnit, Event)
	if play == nil then
	pUnit:Despawn(0,1)
	else
		if Bink == nil then
		pUnit:Despawn(0,1)
		else
		Bink:SendChatMessage(12,0,"Ahh... a spy...")
		Bink:Emote(1, 2000)
		Bink:RegisterEvent("ttesojspjxpjirjspiwajtyahapgaenzzzz2", 2000, 1)
		end
	end
end

function ttesojspjxpjirjspiwajtyahapgaenzzzz2(pUnit, Event)
	if play == nil then
	pUnit:Despawn(0,1)
	else
		if Bink == nil then
		pUnit:Despawn(0,1)
		else
		Bink:SendChatMessage(14,0,"Prepare to die spy!")
		Bink:Emote(4, 2000)
		Bink:RegisterEvent("ttesojspjxpjirjspiwajtyahapgerhjaehaaenzzzz", 2000, 1)
		end
	end
end

function ttesojspjxpjirjspiwajtyahapgerhjaehaaenzzzz(pUnit, Event)
	if play == nil then
	pUnit:Despawn(0,1)
	else
		if Bink == nil then
		pUnit:Despawn(0,1)
		else
		if play:HasQuest(829) == true then
		play:MarkQuestObjectiveAsComplete(829, 0)
		end
	    --thescream:SendChatMessage(14, 0, "Another me- What is this! Argh ARRRGH!")
	    --thescream:PlaySoundToSet(14556)
		play:RemoveAura(5267)
		play:RemoveAura(71614)
		play:SetPhase(1)
		play:Teleport(0,-6723.9, -1077.8, 270)
		play = nil
		Bink:Despawn(0,1)
		end
	end
end


--[[function thescreamdefine_OnSpawn(pUnit, event)
	thescream = pUnit
end

RegisterUnitEvent(426020, 18, "thescreamdefine_OnSpawn")--]]