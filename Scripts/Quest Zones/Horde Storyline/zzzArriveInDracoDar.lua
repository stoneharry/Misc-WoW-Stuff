
local player = nil

function LEIT_On_Spawn(pUnit, Event)
	pUnit:RegisterEvent("Check_check_eojaojeo_aeojpq", 1500, 0)
end

function Check_check_eojaojeo_aeojpq(pUnit, Event)
	player = pUnit:GetClosestPlayer()
	if player ~= nil then
		if pUnit:GetDistance(player) < 5 then
			if player:HasQuest(1103) == true then
			pUnit:RemoveEvents()
			player:SetPlayerLock(true)
			player:CastSpell(70788) -- Visual
			player:CastSpell(68442) -- Kneel
			pUnit:ChannelSpell(66680, player)
			pUnit:SendChatMessage(12, 0, "Back foul beast!")
			pUnit:RegisterEvent("OMFG_we_have_a_player", 4000, 1)
			end
		end
	end
end

RegisterUnitEvent(259311, 18, "LEIT_On_Spawn")

function OMFG_we_have_a_player(pUnit, Event)
	if player ~= nil then
	player:PlayerSendChatMessage(12, 0, "No, wait! I have a propersition for your leader!")
	pUnit:RegisterEvent("OH_LA_LA_LA_LA_LA_LA", 5000, 1)
	pUnit:RegisterEvent("OH_LA_LA_LA_LA_LA_LA_La", 10000, 1)
	pUnit:RegisterEvent("OH_LA_LA_LA_LA_LA_LA_Laa", 16000, 1)
	else
	pUnit:RemoveEvents()
	pUnit:StopChannel()
	pUnit:RegisterEvent("Check_check_eojaojeo_aeojpq", 1500, 0)
	end
end

function OH_LA_LA_LA_LA_LA_LA(pUnit, Event)
	if player ~= nil then
	pUnit:SendChatMessage(12, 0, "No longer will I listen to your lies, prepare to feel the full wrath of the light!")
	else
	pUnit:RemoveEvents()
	pUnit:StopChannel()
	pUnit:RegisterEvent("Check_check_eojaojeo_aeojpq", 1500, 0)
	end
end

function OH_LA_LA_LA_LA_LA_LA_La(pUnit, Event)
	if player ~= nil then
	player:PlayerSendChatMessage(12, 0, "Demons are coming... I am here to try and form a peace, at least till the greater enemy is defeated.")
	else
	pUnit:RemoveEvents()
	pUnit:StopChannel()
	pUnit:RegisterEvent("Check_check_eojaojeo_aeojpq", 1500, 0)
	end
end

function OH_LA_LA_LA_LA_LA_LA_Laa(pUnit, Event)
	if player ~= nil then
	pUnit:SendChatMessage(12, 0, "Very well beast, you have a persuasive tongue. I will not hesitate to still that tongue if you give me any reason to doubt your word. Seek our leader then, stay true to your word.")
	player:RemoveAura(70788) -- Visual
	player:SetPlayerLock(false)
	player:RemoveAura(68442) -- Kneel
	pUnit:StopChannel()
	player = nil
	pUnit:RegisterEvent("LEIT_On_Spawn", 15000, 1)
	else
	pUnit:RemoveEvents()
	pUnit:StopChannel()
	pUnit:RegisterEvent("Check_check_eojaojeo_aeojpq", 1500, 0)
	end
end