-- By Stoneharry

-- Variables

ICC = {}
ICC.VAR = {}

-- Skeleton Beams

function ICC.VAR.Skeletal_Mage_OnCombat(pUnit, Event)
	pUnit:PlaySoundToSet(17282) -- epic music
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ICC[id] = ICC[id] or {VAR={}}
	
	--[[if pUnit:GetX() < -137 and pUnit:GetX() > -134 then
		ICC[id].VAR.portal = pUnit:GetCreatureNearestCoords(-123, 2212, 35, 203112)
		ICC[id].VAR.target = pUnit:GetCreatureNearestCoords(-116, 2212, 35, 203113)
	elseif pUnit:GetY() < 2223 and pUnit:GetY() > 2222 then
		ICC[id].VAR.portal = pUnit:GetCreatureNearestCoords(-232.7, 2223.2, 40, 203112)
		ICC[id].VAR.target = pUnit:GetCreatureNearestCoords(-232, 2217, 40.6, 203113)
	elseif pUnit:GetY() < 2201 and pUnit:GetY() > 2200 then
		ICC[id].VAR.portal = pUnit:GetCreatureNearestCoords(-235, 2200.7, 40.86, 203112)
		ICC[id].VAR.target = pUnit:GetCreatureNearestCoords(-231.35, 2206.86, 40.5, 203113)
	end]]
	ICC[id].VAR.portal = pUnit:GetCreatureNearestCoords(-123, 2212, 35, 203112)
	ICC[id].VAR.target = pUnit:GetCreatureNearestCoords(-116, 2212, 35, 203113)
	
	pUnit:ChannelSpell(31513, ICC[id].VAR.portal) -- red beam
	ICC[id].VAR.portal:ChannelSpell(72594, ICC[id].VAR.target) -- arcane fire channel
	ICC[id].VAR.portal:SetMovementFlags(2)
	ICC[id].VAR.portal:MoveTo(ICC[id].VAR.portal:GetX(), ICC[id].VAR.portal:GetY(), ICC[id].VAR.portal:GetZ()+5, ICC[id].VAR.portal:GetO())
	ICC[id].VAR.target:CastSpell(55653) -- impact
	ICC[id].VAR.target:CastSpell(33343) -- visual
	ICC[id].VAR.target:SetMovementFlags(2)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		ICC[id].VAR.target:SetUnitToFollow(plr, 0.1, 1)
	else
		ICC[id].VAR.target:SetUnitToFollow(pUnit:GetClosestPlayer(), 0.1, 1)
	end
	ICC[id].VAR.channeling = true
	ICC[id].VAR.caster = pUnit
	ICC[id].VAR.caster:RegisterEvent("ICC.VAR.CheckForPlayerNear", 1500, 0)
end

function ICC.VAR.CheckForPlayerNear(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ICC[id] = ICC[id] or {VAR={}}
	if ICC[id].VAR.channeling then
		pla = ICC[id].VAR.target:GetClosestPlayer()
		if pla ~= nil then
			--[[if boss:GetDistanceYards(pla) > 30 then
				trig:SetUnitToFollow(pla, 0.1, 0)
				print("too far away")
			else
				trig:SetUnitToFollow(pla, 0.1, 1)
				print("following")
			end]]
			if ICC[id].VAR.target:GetDistanceYards(pla) < 5 and pla:IsAlive() then
				pla:CastSpell(43418) -- impact
				ICC[id].VAR.target:Strike(pla, 0, 38043, 890, 990, 2)
			end
		end
	end	
end

function ICC.VAR.Skeletal_Mage_OnDeath(pUnit, Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ICC[id] = ICC[id] or {VAR={}}
	ICC[id].VAR.caster:StopChannel()
	ICC[id].VAR.channeling = false
	ICC[id].VAR.portal:StopChannel()
	ICC[id].VAR.caster:RemoveEvents()
	ICC[id].VAR.target:SetHealth(1)
	ICC[id].VAR.target:CastSpell(11)
	ICC[id].VAR.target:CastSpell(11)
	ICC[id].VAR.target:CastSpell(11)
	ICC[id].VAR.target:CastSpell(11)
end

function ICC.VAR.Skeletal_Mage_OnSpawn(pUnit, Event)
	pUnit:SetCombatCapable(true)
	pUnit:FullCastSpell(29880) -- mana shield
end

RegisterUnitEvent(203111, 1, "ICC.VAR.Skeletal_Mage_OnCombat")
RegisterUnitEvent(203111, 4, "ICC.VAR.Skeletal_Mage_OnDeath")
RegisterUnitEvent(203111, 18, "ICC.VAR.Skeletal_Mage_OnSpawn")

-- Ghouls

function ICC.VAR.Ghoul_Enters_Combat(pUnit, Event)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(100, plr)
	end
end

RegisterUnitEvent(203114, 1, "ICC.VAR.Ghoul_Enters_Combat")

-- Lord Marrow

function ICC.VAR.LordMarrowSpawns(pUnit, Event)
	pUnit:SetMaxPower(1000, 6) -- amount is 100, type is rage
	pUnit:SetPowerType(6) -- type is rage
end

function ICC.VAR.LordMarrowCombat(pUnit, Event)
	pUnit:PlaySoundToSet(16949)
	pUnit:SendChatMessage(14,0, "The only escape is death!")
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ICC[id] = ICC[id] or {VAR={}}
	ICC[id].VAR.rage = 0
	pUnit:RegisterEvent("ICC.VAR.updage_Rage", 3000, 1)
	pUnit:RegisterEvent("ICC.VAR.updage_spellsrandom", 5000, 1)
end

function ICC.VAR.LordMarrowLeave(pUnit, Event)
	pUnit:SetPower(0, 6)
	pUnit:RemoveEvents()
	pUnit:PlaySoundToSet(16944)
	pUnit:SendChatMessage(14, 0, "I see... only darkness...")
end

function ICC.VAR.updage_spellsrandom(pUnit)
	if math.random(1,2) == 1 then
		if pUnit:GetMainTank() ~= nil then -- just in case
			pUnit:FullCastSpellOnTarget(19983, pUnit:GetMainTank()) -- cleave
		end
	else
		if pUnit:GetRandomPlayer(0) ~= nil then
			if math.random(1,2) == 2 then
				pUnit:CastSpellOnTarget(29540, pUnit:GetRandomPlayer(0)) -- slow + weaken
				pUnit:CastSpellOnTarget(29540, pUnit:GetRandomPlayer(0)) -- slow + weaken
				pUnit:CastSpellOnTarget(29540, pUnit:GetRandomPlayer(0)) -- slow + weaken
			else
				pUnit:FullCastSpellOnTarget(100, pUnit:GetRandomPlayer(0)) -- charge
				--pUnit:CastSpellOnTarget(11, pUnit:GetMainTank()) -- 1k damage
			end
		end
	end
	pUnit:RegisterEvent("ICC.VAR.updage_spellsrandom", math.random(4000, 8000), 1)
end

function ICC.VAR.updage_Rage(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ICC[id] = ICC[id] or {VAR={}}
	if ICC[id].VAR.rage == 1000 then
		ICC[id].VAR.rage = 0
		pUnit:CastSpell(27688) -- Bone Shield
		if math.random(1,2) == 1 then
			pUnit:PlaySoundToSet(16943)
			pUnit:SendChatMessage(14, 0, "Languish in damnation!")
		else
			pUnit:PlaySoundToSet(16945)
			pUnit:SendChatMessage(14, 0, "The master's rage courses through me!")
		end
		pUnit:CastSpell(64438) -- spin round in circles
		pUnit:CastSpell(17228) -- Shadow bolt volley
		ICC[id].VAR.raging = true
		ICC[id].VAR.ragecount = 0
		pUnit:RegisterEvent("ICC.VAR.rage_part", 1000, 4)
	else
		ICC[id].VAR.rage = ICC[id].VAR.rage + 100
	end
	pUnit:SetPower(ICC[id].VAR.rage, 6)
	pUnit:RegisterEvent("ICC.VAR.updage_Rage", math.random(2000,4000), 1)
end

function ICC.VAR.rage_part(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	ICC[id] = ICC[id] or {VAR={}}
	if ICC[id].VAR.raging then
		--[[if math.random(1,4) then
			pUnit:FullCastSpell(17228) -- shadow bolt volley
		end]]
		--[[if pUnit:GetRandomPlayer(0) ~= nil then
			pUnit:CastSpellOnTarget(100, pUnit:GetRandomPlayer(0)) -- charge
		end]]
		ICC[id].VAR.ragecount = ICC[id].VAR.ragecount + 1
		if ICC[id].VAR.ragecount == 4 then
			ICC[id].VAR.raging = false
			pUnit:RemoveAura(64438) -- spin round in circles
			pUnit:RemoveAura(27688) -- Bone shield
		end
	end
end

RegisterUnitEvent(203115, 1, "ICC.VAR.LordMarrowCombat")
RegisterUnitEvent(203115, 2, "ICC.VAR.LordMarrowLeave")
RegisterUnitEvent(203115, 4, "ICC.VAR.LordMarrowLeave")
RegisterUnitEvent(203115, 18, "ICC.VAR.LordMarrowSpawns")

--