
function Vehicle_Horse_BadlandsjoustSpawn(pUnit, event)
	pUnit:RegisterEvent("Vehicle_Horse_Badlands_Playercheck", 2500, 0)
end

function Vehicle_Horse_Badlands_Playercheck(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if tostring(plr:GetVehicleBase()) == tostring(pUnit) then
			pUnit:SendChatMessageToPlayer(42,0,"The challenger attacks!", plr)
			local enemy = pUnit:GetCreatureNearestCoords(-6789.5, -3122.55, 240.5, 290152)
			if enemy ~= nil then
				if enemy:IsAlive() then
					pUnit:RemoveEvents()
					enemy:SetFaction(21)
					enemy:SetMovementFlags(1)
					enemy:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0)
					enemy:RegisterEvent("CheckHPEverYBadlandsVehicle", 1000, 0)
				end
			end
		end
	end
end

RegisterUnitEvent(145831, 18, "Vehicle_Horse_BadlandsjoustSpawn")

function ENemy_horsechallenge_attack(pUnit, event)
	pUnit:SetMount(14584)
	pUnit:EquipWeapons(39114, 0, 0)
	pUnit:SetFaction(35)
end

function CheckHPEverYBadlandsVehicle(pUnit)
	if pUnit:GetHealthPct() < 30 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12,0,"I surrender!")
		pUnit:SetCombatCapable(false)
		pUnit:SetFaction(35)
		pUnit:Root()
		local plr = pUnit:GetClosestPlayer()
		if plr ~= nil then
			RegisterTimedEvent("Phase_Player_Back_badlandsvehicle", 3000, 1, plr)
		end
		pUnit:Despawn(4000, 30000)
	end
end

function Phase_Player_Back_badlandsvehicle(plr)
	if plr ~= nil then
		plr:GetVehicleBase():ReturnToSpawnPoint()
		plr:ExitVehicle()
	end
end

RegisterUnitEvent(290152, 18, "ENemy_horsechallenge_attack")
