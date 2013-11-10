
local Haven = nil
local GuardA = nil
local GuardB = nil
local BVZABZ = nil
local Nature = nil

----------------------------------------------------------

function haven_invisible_trigger_Spawn(pUnit, Event)
	pUnit:RegisterEvent("haven_lolcake", 1000, 1)
end

function haven_lolcake(pUnit, Event)
	Haven = pUnit
end

RegisterUnitEvent(13477, 18, "haven_invisible_trigger_Spawn")

function zbzhaven_invisible_trigger_Spawn(pUnit, Event)
	pUnit:RegisterEvent("zbzhaven_lolcake", 1000, 1)
end

function zbzhaven_lolcake(pUnit, Event)
	GuardA = pUnit
end

RegisterUnitEvent(250785, 18, "zbzhaven_invisible_trigger_Spawn")

function zbhaven_invisible_trigger_Spawn(pUnit, Event)
	pUnit:RegisterEvent("zbhaven_lolcake", 1000, 1)
end

function zbhaven_lolcake(pUnit, Event)
	GuardB = pUnit
end

RegisterUnitEvent(250784, 18, "zbhaven_invisible_trigger_Spawn")

function ohgod_its_a_nature_dude_AGAIN(pUnit, Event)
	pUnit:RegisterEvent("ohgod_its_a_nature_dude_AGAINz", 1000, 1)
end

function ohgod_its_a_nature_dude_AGAINz(pUnit, Event)
	Nature = pUnit
	Nature:CastSpell(44816)
end

RegisterUnitEvent(123651, 18, "ohgod_its_a_nature_dude_AGAIN")

----------------------------------------------------------

function zzz_invisible_trigger_Spawn(pUnit, Event)
	pUnit:RegisterEvent("zzz_lolcake", 1000, 0)
end

function zzz_lolcake(pUnit, Event)
	if Haven ~= nil then
	BVZABZ = Haven:GetClosestPlayer()
		if BVZABZ ~= nil then
			if Haven:GetDistanceYards(BVZABZ) < 10 then
				if BVZABZ:HasQuest(1099) == true then -- He must be in phase 4 so no need to check
				pUnit:RemoveEvents()
				BVZABZ:SetPlayerLock(true)
				BVZABZ:CastSpell(51367)
				pUnit:RegisterEvent("Spawn_Peace_Guy_UhLahLah_Lahlahlah", 6000, 1)
					if GuardA ~= nil and GuardB ~= nil then
					GuardA:SendChatMessage(12,0,"Stop right there!")
					GuardA:SetModel(15374)
					GuardB:SetModel(15374)
					GuardA:CastSpell(24085)
					GuardB:CastSpell(24085)
					GuardA:Emote(45, 20000)
					GuardB:Emote(45, 20000)
					end
				end
			end
		end
	end
end

RegisterUnitEvent(32790, 18, "zzz_invisible_trigger_Spawn")

----------------------------------------------------------

function Spawn_Peace_Guy_UhLahLah_Lahlahlah(pUnit, Event)
	if BVZABZ ~= nil then
	pUnit:CastSpell(42050)
	pUnit:RegisterEvent("olawd_SPAWNGOD_GOD_GOD", 3000, 1)
	else
	pUnit:RegisterEvent("zzz_lolcake", 2000, 0)
		if GuardA ~= nil and GuardB ~= nil then
		GuardA:SetModel(2227)
		GuardB:SetModel(2227)
		GuardA:CastSpell(24085)
		GuardB:CastSpell(24085)
		end
	end
end

function olawd_SPAWNGOD_GOD_GOD(pUnit, Event)
	if BVZABZ ~= nil then
	pUnit:SpawnCreature(123651, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 35, 0)
	pUnit:RegisterEvent("Ohaewihgoahgoahgea_zogje_zegio_eaga", 4000, 1)
	else
	pUnit:RemoveAura(42050)
	pUnit:RegisterEvent("zzz_lolcake", 2000, 0)
		if GuardA ~= nil and GuardB ~= nil then
		GuardA:SetModel(2227)
		GuardB:SetModel(2227)
		GuardA:CastSpell(24085)
		GuardB:CastSpell(24085)
		end
	end
end

function Ohaewihgoahgoahgea_zogje_zegio_eaga(pUnit, Event)
	if BVZABZ ~= nil then
	pUnit:RegisterEvent("OHeahoghaozhoughz_reset", 6000, 1)
	else
	pUnit:RemoveAura(42050)
	pUnit:RegisterEvent("zzz_lolcake", 2000, 0)
		if GuardA ~= nil and GuardB ~= nil then
		GuardA:SetModel(2227)
		GuardB:SetModel(2227)
		GuardA:CastSpell(24085)
		GuardB:CastSpell(24085)
		end
		if Nature ~= nil then
		Nature:Despawn(1,0)
		end
	end
end

function OHeahoghaozhoughz_reset(pUnit, Event)
	if BVZABZ ~= nil then
	BVZABZ:RemoveAura(51367)
	BVZABZ:SetPlayerLock(false)
	BVZABZ:CastSpell(28136)
	BVZABZ:GossipSendPOI(7799.46, -2574.07, 7, 6, 0, "Moonglade's Haven")
	BVZABZ = nil
	Nature:Despawn(1,0)
	pUnit:RemoveAura(42050)
	pUnit:RegisterEvent("zzz_invisible_trigger_Spawn", 20000, 1)
		if GuardA ~= nil and GuardB ~= nil then
		GuardA:SetModel(2227)
		GuardB:SetModel(2227)
		GuardA:CastSpell(24085)
		GuardB:CastSpell(24085)
		GuardB:SendChatMessage(12,0,"The peacekeeper seeks an audience with you it seems. Do not keep him waiting.")
		end
	else
	pUnit:RemoveAura(42050)
	pUnit:RegisterEvent("zzz_lolcake", 2000, 0)
		if GuardA ~= nil and GuardB ~= nil then
		GuardA:SetModel(2227)
		GuardB:SetModel(2227)
		GuardA:CastSpell(24085)
		GuardB:CastSpell(24085)
		end
		if Nature ~= nil then
		Nature:Despawn(1,0)
		end
	end
end

----------------------------------------------------------