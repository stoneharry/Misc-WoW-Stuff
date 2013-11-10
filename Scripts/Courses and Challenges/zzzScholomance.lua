-- By Stoneharry

-- Variables
--[[
local following = false
local phase = 0
local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local target = nil
local count = 0

-- Intro person

function Scholomance_Girl_Gossip(pUnit, event, player)
	if (not following) then
		following = true
		pUnit:SendChatMessage(12,0,"I will follow you, "..player:GetName()..".")
		pUnit:SetUnitToFollow(player, 1.5, 2.5)
	else
		pUnit:GossipCreateMenu(3938, player, 0)
		pUnit:GossipMenuAddItem(0, "Keep following me.", 2, 0)
		pUnit:GossipMenuAddItem(0, "I think we've been beat.", 3, 0)
		pUnit:GossipSendMenu(player)
	end
end

function Scholomance_Girl_Click(pUnit, event, player, id, intid, code)
	if intid == 2 then
		if following then
			pUnit:StopMovement(1)
			if pUnit:GetUnitToFollow() == nil then
				pUnit:SetUnitToFollow(player, 1.5, 2.5)
			end
		end
		player:GossipComplete()
	elseif intid == 3 then
		player:GossipComplete()
		player:CastSpell(11)
		player:CastSpell(11)
		player:CastSpell(11)
		player:CastSpell(11)
		player:CastSpell(11)
		Reset_Scholomance(pUnit)
	end
end

RegisterUnitGossipEvent(111641, 1, "Scholomance_Girl_Gossip")
RegisterUnitGossipEvent(111641, 2, "Scholomance_Girl_Click")

function Scholomance_Girl_Spawn(pUnit, event)
	pUnit:RegisterEvent("Girl_Check_Phase_Players", 1500, 0)
end

function Girl_Check_Phase_Players(pUnit)
	if following then
		if pUnit:GetClosestPlayer() == nil then
			Reset_Scholomance(pUnit)
		else
			if pUnit:GetUnitToFollow() == nil then
				count = count + 1
				if count == 4 then
					Reset_Scholomance(pUnit)
				end
			else
				count = 0
				--local temp = pUnit:GetClosestPlayer()
				if pUnit:GetClosestPlayer():GetHealthPct() < 50 then
					if pUnit:GetCurrentSpellId() == nil then
						if pUnit:GetUnitToFollow():IsDead() then
							Reset_Scholomance(pUnit)
						else
							pUnit:StopMovement(3000)
							pUnit:FullCastSpellOnTarget(8903, pUnit:GetClosestPlayer()) -- heal
						end
					end
				end
				if phase == 0 then
					local plr = pUnit:GetClosestPlayer()
					local creature = pUnit:GetCreatureNearestCoords(plr:GetX(), plr:GetY(), plr:GetZ(), 247621)
					if creature ~= nil then
						if creature:GetDistanceYards(plr) < 7 then
							pUnit:SendChatMessage(12,0,"I have an idea, if you use that gun I captured and set up earlier, I'll open the door. This will be sure to attract the attention of a necromancer, but we should be able to stop them if you repel them with the gun.")
							phase = 1
						end
					end
				elseif (phase > 1 and phase < 8) then
					pUnit:SpawnCreature(151911, 74.1, 180.1, 102, 0.034186, 21, 120000)
					phase = phase + 1
				elseif phase == 8 then
					if pUnit:GetClosestPlayer():GetClosestEnemy():IsDead() then
						pUnit:SendChatMessage(12,0,"Well done! Now let's get out of here.")
						pUnit:RemoveEvents()
						pUnit:RegisterEvent("Girl_Check_Phase_Players", 10000, 1)
						phase = phase + 1
					end
				elseif phase == 9 then
					pUnit:RegisterEvent("Girl_Check_Phase_Players", 1500, 0)
					phase = phase + 1
					pUnit:SendChatMessage(12,0,"Be careful in the following room, if we are seen they will simply lock us back up.")
				elseif phase == 10 then
					local snake = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),25113) -- NOTE: Increase timer if it gets laggy
					if snake ~= nil then
						if pUnit:GetDistanceYards(snake) < 10 then
							pUnit:SendChatMessage(12,0,"There are too many necromancers ahead, we should go right instead and hope that it leads to a way out of here!")
							phase = phase + 1
							pUnit:GetClosestPlayer():CastSpell(47113) -- knockback
						end
					end
				elseif phase == 11 then
					local targ = pUnit:GetClosestPlayer():GetSelection()
					if targ ~= nil then
						if targ:GetName() == "Rotten Ghoul" then
							if pUnit:GetCurrentSpellId() == nil then
								if pUnit:GetDistanceYards(targ) < 20 then
									pUnit:CastSpellOnTarget(22355, targ)
									pUnit:Kill(targ)
									if math.random(1,8) == 1 then
										if math.random(1,2) == 1 then
											pUnit:SendChatMessage(12,0,"Return to the dead!")
										else
											pUnit:SendChatMessage(12,0,"You shall not harm us!")
										end
									end
								end
							end
						elseif targ:GetName() == "Dreadlord" then
							if pUnit:GetDistanceYards(targ) < 15 then
								pUnit:FullCastSpellOnTarget(60502, targ)
								pUnit:Kill(targ)
								targ:SendChatMessage(14,0,"A thousand curses upon yo-")
								pUnit:SendChatMessage(12,0,"That appears to be the last of them, let us rest in this room before proceeding.")
								for place,plrs in pairs(pUnit:GetInRangePlayers()) do
									plrs:RemoveAura(47113) -- knockback
								end
								phase = phase + 1
							end
						end
						targ = pUnit:GetClosestPlayer():GetRandomEnemy()
						if targ:GetName() == "Rotten Ghoul" then
							if pUnit:GetCurrentSpellId() == nil then
								if pUnit:GetDistanceYards(targ) < 20 then
									pUnit:CastSpellOnTarget(22355, targ)
									pUnit:Kill(targ)
									if math.random(1,8) == 1 then
										if math.random(1,2) == 1 then
											pUnit:SendChatMessage(12,0,"Return to the dead!")
										else
											pUnit:SendChatMessage(12,0,"You shall not harm us!")
										end
									end
								end
							end
						end
					end
				elseif phase == 12 then
					local creat = pUnit:GetCreatureNearestCoords(58, 143, 83.5, 23412) -- increase timer later
					if creat ~= nil then
						if pUnit:GetDistanceYards(creat) < 10 then
							pUnit:SendChatMessage(12,0,"Hang on and I'll open this door.")
							pUnit:Root()
							pUnit:ChannelSpell(40447, creat)
							phase = phase + 1
							pUnit:RemoveEvents()
							pUnit:RegisterEvent("Scholomance_Girl_Spawn", 8500, 1)
						end
					end
				elseif phase == 13 then
					pUnit:StopChannel()
					pUnit:Unroot()
					pUnit:GetCreatureNearestCoords(58, 143, 83.5, 23412):CastSpell(58538) -- arcane explosion visual
					local gate = pUnit:GetGameObjectNearestCoords(58.3, 142.7, 83.5, 177370)
					if gate ~= nil then
						gate:SetByte(GAMEOBJECT_BYTES_1,0,0)
						RegisterTimedEvent("ResetGateInAMinuteOrTwo", 30000, 1, gate)
					end
					phase = phase + 1
					pUnit:RemoveEvents()
					pUnit:RegisterEvent("Scholomance_Girl_Spawn", 8500, 1)
				elseif phase == 14 then
					pUnit:SendChatMessage(12,0,"There is the orb of power! Bring me to it and I can use it to transport us out of here.")
					phase = phase + 1
				elseif phase == 15 then
					local orb = pUnit:GetGameObjectNearestCoords(-26, 141.4, 83.4, 182024)
					if orb ~= nil then
						if pUnit:GetDistanceYards(orb) < 10 then
							pUnit:RemoveEvents()
							pUnit:Root()
							pUnit:SendChatMessage(14,0,"Thank you for all your help! Here are some gold coins, now let us leave this damned place.")
							pUnit:RegisterEvent("Scholomance_Girl_Spawn", 4500, 1)
							phase = phase + 1
						end
					end
				elseif phase == 16 then
					pUnit:Unroot()
					for place,plrs in pairs(pUnit:GetInRangePlayers()) do
						if pUnit:GetDistanceYards(plrs) < 20 then
							plrs:AddItem(45978, 10)
							plrs:Teleport(0, -7500, -1161, 476)
						end
					end
					Reset_Scholomance(pUnit)
				end
			end
		end
	end
end

function Gargoyal_Spawn_scholo(pUnit, event)
	pUnit:RegisterEvent("MoveGargoyal_scholo", 1500, 1)
end

function MoveGargoyal_scholo(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:SetMovementFlags(2)
		pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
	end
end

RegisterUnitEvent(151911, 18, "Gargoyal_Spawn_scholo")

function Reset_Scholomance(pUnit)
	following = false
	phase = 0
	for place,plrs in pairs(pUnit:GetInRangePlayers()) do
		plrs:RemoveAura(47113) -- knockback	
	end
	pUnit:Despawn(1, 10000)
end

RegisterUnitEvent(111641, 18, "Scholomance_Girl_Spawn")

function Gun_Click(pUnit, event, player)
	if phase == 1 then
		pUnit:SendChatMessage(42,0,"The gates are opening! Click the gun to shoot creatures away.")
		phase = 2
		local gate = pUnit:GetGameObjectNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 179724)
		gate:SetByte(GAMEOBJECT_BYTES_1,0,0)
		RegisterTimedEvent("ResetGateInAMinuteOrTwo", 120000, 1, gate)
	elseif (phase > 1) then
		local target = player:GetClosestEnemy()
		if target ~= nil then
			if target:GetDistanceYards(pUnit) < 30 then
				if target:IsAlive() then
					player:CastSpell(16715) -- smoke visual
					target:CastSpell(34602) -- explosion visual
					player:CastSpellOnTarget(49987, target) -- bullet + damage
					--target:Despawn(3000, 0) -- doesn't work
				end
			end
		end
	end
end

function ResetGateInAMinuteOrTwo(gate)
	gate:SetByte(GAMEOBJECT_BYTES_1,0,1)
end

RegisterUnitGossipEvent(247621, 1, "Gun_Click")

function Necromancer_Spawn_Scholo(pUnit, event)
	pUnit:RegisterEvent("CheckForNearNecroPlayer_Scholo", 1500, 0)
end

function CheckForNearNecroPlayer_Scholo(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 20 then
			if plr:GetZ() > 107 then
				if pUnit:IsInFront(plr) then
					pUnit:SendChatMessage(12,0,"Get back in the cells where you belong!")
					--pUnit:RemoveEvents()
					plr:Teleport(289, 153.2, 135.6, 114.5)
					plr:CastSpell(61456)
					--pUnit:RegisterEvent("Necromancer_Spawn_Scholo", 5000, 1)
				end
			end
		end
	end
end

RegisterUnitEvent(28200, 18, "Necromancer_Spawn_Scholo")

-- 183517

function lever_goes_untargetablesojgs_a(pMisc, Event)
	local door = pMisc:GetGameObjectNearestCoords(165.9, 153.5, 109.5, 175616)
	door:SetByte(0x0006+0x000B,0,0) -- Open
	RegisterTimedEvent("Reset_Door_A_Tehe_Test_A", 20000, 1, door)
end

function Reset_Door_A_Tehe_Test_A(door)
	door:SetByte(0x0006+0x000B,0,1) -- Close
end

RegisterGameObjectEvent(183517, 4, "lever_goes_untargetablesojgs_a")]]