
local doll = nil
local player = nil
local Scale = 1

function farabbit_teleporter_on_spawn_te(pUnit, Event)
	pUnit:RegisterEvent("eahoygahoughaeluh_zloeak_aij", 5000, 0)
end

RegisterUnitEvent(78043, 18, "farabbit_teleporter_on_spawn_te")

function afarabbit_teleporter_on_spawn_te(pUnit, Event)
	doll = pUnit
end

RegisterUnitEvent(280761, 18, "afarabbit_teleporter_on_spawn_te")

function eahoygahoughaeluh_zloeak_aij(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistance(plr) < 5 then
			if doll ~= nil then
				if plr:IsAlive() == true then
					--if plr:HasQuest(819) == true then -- commented out for a reason
					pUnit:RemoveEvents()
					plr:CastSpell(68442) -- root
					plr:CastSpell(62579) -- visual
					player = plr
					pUnit:RegisterEvent("Wait_A_Seocnaganiegoanaoupqreh", 2500, 1)
					--end
				end
			end
		end
	end
end

function Wait_A_Seocnaganiegoanaoupqreh(pUnit, Event)
	if player ~= nil then
	doll:SendChatMessage(16, 0, "The Vodoo Doll begins to expand fast.")
	pUnit:RegisterEvent("ScaleIncrease_leajopgi", 1000, 9)
	pUnit:RegisterEvent("ScaleIncrease_leajopgi_z", 10000, 1)
	else
	pUnit:RemoveEvents()
	doll:SetScale(1)
	pUnit:RegisterEvent("eahoygahoughaeluh_zloeak_aij", 5000, 0)
	Scale = 1
	player = nil
	end
end

function ScaleIncrease_leajopgi(pUnit, Event)
	Scale = Scale + 0.2
	doll:SetScale(Scale)
end

function ScaleIncrease_leajopgi_z(pUnit, Event)
	if player ~= nil then
	doll:ChannelSpell(24618, player)
	local name = player:GetName()
	doll:SendChatMessage(16, 0, "The Vodoo Doll begins to drain "..name.."'s essence.")
	pUnit:RegisterEvent("Test_five_four_three_two_one", 5000, 1)
	else
	pUnit:RemoveEvents()
	doll:StopChannel()
	doll:SetScale(1)
	pUnit:RegisterEvent("eahoygahoughaeluh_zloeak_aij", 5000, 0)
	Scale = 1
	player = nil
	end
end

function Test_five_four_three_two_one(pUnit, Event)
	if player ~= nil then
	local name = player:GetName()
		if player:GetItemCount(4743) == 1 then
		doll:SendChatMessage(16, 0, "The Vodoo Doll's vodoo is being reflected by something held by "..name..".")
		doll:StopChannel()
		pUnit:RemoveEvents()
		player:RemoveAura(68442) -- root
		player:RemoveAura(62579) -- visual
		doll:SetScale(1)
		doll:FullCastSpell(63660)
		pUnit:RegisterEvent("farabbit_teleporter_on_spawn_te", 30000, 1)
		Scale = 1
			if player:HasQuest(851) == true then
			player:MarkQuestObjectiveAsComplete(851, 0)
			end
		player = nil
		else
		player:RemoveAura(68442) -- root
		player:RemoveAura(62579) -- visual
		doll:SendChatMessage(16, 0, "The Vodoo Doll's obliterates "..name..".")
		doll:StopChannel()
		doll:CastSpellOnTarget(11661, player)
		player:CastSpell(11)
		pUnit:RemoveEvents()
		doll:StopChannel()
		doll:SetScale(1)
		pUnit:RegisterEvent("eahoygahoughaeluh_zloeak_aij", 5000, 0)
		Scale = 1
		player = nil
		end
	else
	pUnit:RemoveEvents()
	doll:StopChannel()
	doll:SetScale(1)
	pUnit:RegisterEvent("eahoygahoughaeluh_zloeak_aij", 5000, 0)
	Scale = 1
	player = nil
	end
end

