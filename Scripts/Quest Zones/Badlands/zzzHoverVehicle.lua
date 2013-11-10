--[[
function WierdGirl_OnSpawn_Bad(pUnit, event)
	pUnit:RegisterEvent("MoveToSpawn_wierD_badlan", 1000, 1)
end

function MoveToSpawn_wierD_badlan(pUnit)
	pUnit:EquipWeapons(40489, 0, 0)
	pUnit:SpawnAndEnterVehicle(30234, 2000)
	pUnit:RegisterEvent("channel_spell_combat_check_bad", 3000, 1)
end

function channel_spell_combat_check_bad(pUnit)
	pUnit:ChannelSpell(38106, pUnit) -- air
	pUnit:GetVehicleBase():CastSpell(60534) -- flight
end

RegisterUnitEvent(31260, 18, "WierdGirl_OnSpawn_Bad")

function WierdGirl_OnSCombat_Bad(pUnit)
	pUnit:StopChannel()
	pUnit:RemoveAura(38106) -- air shield
	if math.random(1,3) == 1 then
		pUnit:SendChatMessage(14,0,"Death to the defier!")
	elseif math.random(1,3) == 2 then
		pUnit:SendChatMessage(14,0,"Your blood will saint my thirst!")
	end
	pUnit:CastSpell(17668) -- lightning area
	pUnit:RegisterEvent("Spell_badlands_disc", 2500, 0)
	local vehicle = pUnit:GetVehicleBase()
	vehicle:SetFaction(35)
	RegisterTimedEvent("Check_For_Vehicle_Stuffbadlands", 3000, 1, vehicle)
end

function Spell_badlands_disc(pUnit)
	local plr = pUnit:GetMainTank()
	if plr ~= nil then
		pUnit:FullCastSpellOnTarget(837, plr) -- frostbolt
	end
end

RegisterUnitEvent(31260, 1, "WierdGirl_OnSCombat_Bad")

function WierdGirl_OnSCLeave_Bad(pUnit, Event)
	if pUnit:IsAlive() then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("channel_spell_combat_check_bad", 4000, 1)
	end
end

RegisterUnitEvent(31260, 2, "WierdGirl_OnSCLeave_Bad")

function WierdGirl_OnSCDeath_Bad(pUnit, Event)
	if (not pUnit:IsAlive()) then
		pUnit:RemoveEvents()
		pUnit:ExitVehicle()
	end
end

RegisterUnitEvent(31260, 4, "WierdGirl_OnSCDeath_Bad")

function Check_For_Vehicle_Stuffbadlands(vehicle)
	if vehicle ~= nil then
		local unit = vehicle:GetCreatureNearestCoords(vehicle:GetX(), vehicle:GetY(), vehicle:GetZ(), 31260)
		if unit ~= nil then
			if tostring(unit:GetVehicleBase()) == tostring(vehicle) then
				RegisterTimedEvent("Check_For_Vehicle_Stuffbadlands", 3000, 1, vehicle)
			else
				if vehicle:GetClosestPlayer() ~= nil then
					if vehicle:GetClosestPlayer():GetDistanceYards(vehicle) > 5 then
						vehicle:Despawn(1,0)
					else
						RegisterTimedEvent("Check_For_Vehicle_Stuffbadlands", 3000, 1, vehicle)
					end
				else
					vehicle:Despawn(1,0)
				end
			end
		else
			if vehicle:GetClosestPlayer() ~= nil then
				if vehicle:GetClosestPlayer():GetDistanceYards(vehicle) > 5 then
					vehicle:Despawn(1,0)
				else
					RegisterTimedEvent("Check_For_Vehicle_Stuffbadlands", 3000, 1, vehicle)
				end
			else
				vehicle:Despawn(1,0)
			end
		end
	end
end

local WarningMessage = {}

function check_players_areinbaldsnarea()
	for place, plrs in pairs(GetPlayersInWorld()) do
		if plrs:IsOnVehicle() and plrs:GetVehicleBase() then
			if plrs:GetVehicleBase():GetEntry() == 30234 then
				if plrs:GetAreaId() ~= 346 and plrs:GetAreaId() ~= 3 then
					if WarningMessage[tostring(plrs)] ~= nil then
						WarningMessage[tostring(plrs)] = nil
						plrs:DismissVehicle()
					else
						WarningMessage[tostring(plrs)] = true
						plrs:PlaySoundToPlayer(8959) -- warning
						plrs:SendBroadcastMessage("You will be removed from your vehicle in ten seconds unless you return to your quest area!")
						plrs:SendAreaTriggerMessage("You will be removed from your vehicle in ten seconds unless you return to your quest area!")
					end
				elseif WarningMessage[tostring(plrs)] ~= nil then
					WarningMessage[tostring(plrs)] = nil
				end
			end
		end
	end
end

CreateLuaEvent(check_players_areinbaldsnarea, 10000, 0)
]]