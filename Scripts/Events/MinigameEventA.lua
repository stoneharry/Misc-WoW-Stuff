
local OBJECT_END = 0x0006
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074

local can_start = false

local plrA = nil
local plrB = nil

local resources_A = 0
local resources_B = 0

local UpgradedGhoulsA = false
local UpgradedGhoulsB = false
local UpgradedNecrosA = false
local UpgradedNecrosB = false

local ax, ay, az = -945,-3155,49
local bx, by, bz = -941,-3090,50

local TEAM_A_VISUAL = 52619
local TEAM_B_VISUAL = 52670

-- missing function

function isSame(a, b)
	return tostring(a) == tostring(b)
end

-- end missing function

function Event_Game_Minigame_A(pUnit, event, player)
	pUnit:GossipCreateMenu(1, player, 0)
	if can_start then
		pUnit:GossipMenuAddItem(10, "A game is in progress.", 250, 0)
	else
		pUnit:GossipMenuAddItem(10, "Challenge a target player to a game.", 1, 0)
	end
	pUnit:GossipMenuAddItem(10, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end

function Event_Game_Minigame_B(pUnit, event, player, id, intid, code)
	if intid == 1 then
		local target = player:GetSelection()
		if (target and target:IsPlayer() and target:GetName() ~= player:GetName() and can_start == false) then
			plrA = player;
			plrB = target
			pUnit:SendChatMessage(42,0,"Player "..player:GetName().." has challenged "..plrB:GetName().." to a game!")
			plrA:SendBroadcastMessage("[CU-ADDON] OpenMinigame")
			plrB:SendBroadcastMessage("[CU-ADDON] OpenMinigame")
			can_start = true
		else
			player:SendBroadcastMessage("Error: Target player was not found.")
		end
		player:GossipComplete()
	elseif intid == 250 then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(400000, 1, "Event_Game_Minigame_A")
RegisterUnitGossipEvent(400000, 2, "Event_Game_Minigame_B")
RegisterUnitGossipEvent(400001, 1, "Event_Game_Minigame_A")
RegisterUnitGossipEvent(400001, 2, "Event_Game_Minigame_B")

-- Update score

function UpdateScoreSpawn(pUnit, Event)
	pUnit:RegisterEvent("Update_Player_Scores_Local", 1000, 0)
end

function Update_Player_Scores_Local(pUnit)
	if plrA and plrB then
		resources_A = resources_A + 2
		resources_B = resources_B + 2
		plrA:SendBroadcastMessage("[CU-ADDON] minigame-resources : "..tostring(resources_A))
		plrB:SendBroadcastMessage("[CU-ADDON] minigame-resources : "..tostring(resources_B))
	end
end

RegisterUnitEvent(400000, 18, "UpdateScoreSpawn")

-- Reset event

function ResetGame_Mini(pUnit, Event)
	if plrA and plrB then
		if pUnit:GetEntry() == 400000 then
			pUnit:SendChatMessage(42,0,plrB:GetName().." has won!")
		else
			pUnit:SendChatMessage(42,0,plrA:GetName().." has won!")
		end
	end
	for _,v in pairs(pUnit:GetInRangeUnits()) do
		local entry = v:GetEntry()
		if entry < 420000 and entry > 350000 then
			if entry == 400000 or entry == 400001 then
				v:Despawn(5000, 60000)
			else
				v:Despawn(1,0)
			end
		end
	end
	if plrA then
		plrA:SendBroadcastMessage("[CU-ADDON] CloseMiniGame")
	end
	plrA = nil
	if plrB then
		plrB:SendBroadcastMessage("[CU-ADDON] CloseMiniGame")
	end
	plrB = nil
	can_start = false
	resources_A = 0
	resources_B = 0
	UpgradedGhoulsA = false
	UpgradedGhoulsB = false
	UpgradedNecrosA = false
	UpgradedNecrosB = false
end

RegisterUnitEvent(400001, 4, "ResetGame_Mini")
RegisterUnitEvent(400000, 4, "ResetGame_Mini")

-- chat

function Minigame_Chat(event, plr, message, mtype, language)
	if message ~= nil then
		if message == "[CU-ADDON] SpawnWeakGhouls" then
			if plrA and plrB then
				if plr:GetName() == plrA:GetName() then
					if resources_A > 4 then
						resources_A = resources_A - 5
						plrA:SendBroadcastMessage("[CU-ADDON] minigame-resources : "..tostring(resources_A))
						plr:SpawnCreature(399999, ax, ay, az, 0, 35, 120000)
					end
				elseif plr:GetName() == plrB:GetName() then
					if resources_B > 4 then
						resources_B = resources_B - 5
						plrB:SendBroadcastMessage("[CU-ADDON] minigame-resources : "..tostring(resources_B))
						plr:SpawnCreature(400002, bx, by, bz, 0, 35, 120000)
					end
				end
			end
		elseif message == "[CU-ADDON] SpawnSpellcaster" then
			if plrA and plrB then
				if plr:GetName() == plrA:GetName() then
					if resources_A > 6 then
						resources_A = resources_A - 7
						plrB:SendBroadcastMessage("[CU-ADDON] minigame-resources : "..tostring(resources_B))
						plr:SpawnCreature(399998, ax, ay, az, 0, 35, 120000)
					end
				elseif plr:GetName() == plrB:GetName() then
					if resources_B > 6 then
						resources_B = resources_B - 7
						plr:SpawnCreature(400003, bx, by, bz, 0, 35, 120000)
					end
				end
			end
		elseif message == "[CU-ADDON] SpawnAbomination" then
			if plrA and plrB then
				if plr:GetName() == plrA:GetName() then
					if resources_A > 49 then
						resources_A = resources_A - 50
						plrB:SendBroadcastMessage("[CU-ADDON] minigame-resources : "..tostring(resources_B))
						plr:SpawnCreature(399997, ax, ay, az, 0, 35, 120000)
					end
				elseif plr:GetName() == plrB:GetName() then
					if resources_B > 49 then
						resources_B = resources_B - 50
						plr:SpawnCreature(400004, bx, by, bz, 0, 35, 120000)
					end
				end
			end
		elseif message == "[CU-ADDON] TurretR" then
			if plrA and plrB then
				if plr:GetName() == plrA:GetName() then
					if resources_A > 29 then
						resources_A = resources_A - 30
						plrB:SendBroadcastMessage("[CU-ADDON] minigame-resources : "..tostring(resources_B))
						plr:SpawnCreature(399995, ax+6, ay+6, az, 2.045725, 35, 300000)
					end
				elseif plr:GetName() == plrB:GetName() then
					if resources_B > 29 then
						resources_B = resources_B - 30
						plr:SpawnCreature(400005, bx+6, by-4, bz, 4.994109, 35, 300000)
					end
				end
			end		
		elseif message == "[CU-ADDON] TurretL" then
			if plrA and plrB then
				if plr:GetName() == plrA:GetName() then
					if resources_A > 29 then
						resources_A = resources_A - 30
						plrB:SendBroadcastMessage("[CU-ADDON] minigame-resources : "..tostring(resources_B))
						plr:SpawnCreature(399995, ax-6, ay+6, az, 1.684442, 35, 300000)
					end
				elseif plr:GetName() == plrB:GetName() then
					if resources_B > 29 then
						resources_B = resources_B - 30
						plr:SpawnCreature(400005, bx-6, by-4, bz, 5.198315, 35, 300000)
					end
				end
			end		
		elseif message == "[CU-ADDON] UpgradeGhouls" then
			if plrA and plrB then
				if plr:GetName() == plrA:GetName() then
					if resources_A > 49 then
						resources_A = resources_A - 50
						UpgradedGhoulsA = true
					end
				elseif plr:GetName() == plrB:GetName() then
					if resources_B > 49 then
						resources_B = resources_B - 50
						UpgradedGhoulsB = true
					end				
				end
			end
		elseif message == "[CU-ADDON] UpgradeNecros" then
			if plrA and plrB then
				if plr:GetName() == plrA:GetName() then
					if resources_A > 49 then
						resources_A = resources_A - 50
						UpgradedNecrosA = true
					end
				elseif plr:GetName() == plrB:GetName() then
					if resources_B > 49 then
						resources_B = resources_B - 50
						UpgradedNecrosB = true
					end				
				end
			end
		end
	end
end

RegisterServerHook(16, "Minigame_Chat")

function MeleeUnit_AI(pUnit, Event)
	if Event == 18 then
		pUnit:RegisterEvent("MeleeUnitAI_Tick", 1000, 0)
		if pUnit:GetMana() > 0 then
			pUnit:RegisterEvent("AI_SPELL_TICK", 4000, 0)
		elseif pUnit:GetEntry() == 399997 or pUnit:GetEntry() == 400004 then
			pUnit:RegisterEvent("Abomination_Cleave", 3000, 0)
		end
		pUnit:RegisterEvent("Do_Upgrades_For_Units", 1000, 1)
	else
		pUnit:RemoveEvents()
	end
end

function MeleeUnitAI_Tick(pUnit)
	if pUnit:IsInCombat() and pUnit:GetSelection() == nil then
		return;
	end
	pUnit:SetMovementFlags(1)
	local target = pUnit:GetValue("target")
	if (target == nil or target:IsDead()) then
		target = nil
		local distance = 40
		if pUnit:GetEntry() < 400001 then -- Team A
			pUnit:CastSpell(TEAM_A_VISUAL)
			for _,v in pairs(pUnit:GetInRangeUnits()) do
				if v:GetEntry() > 400000 and v:IsAlive() and v:IsCreature() then
					if v:GetDistanceYards(pUnit) < distance then
						distance = v:GetDistanceYards(pUnit)
						target = v
					end
				end
			end
			if (target == nil) then
				pUnit:MoveTo(bx, by, bz, 0)
			end
		else -- team B
			pUnit:CastSpell(TEAM_B_VISUAL)
			for _,v in pairs(pUnit:GetInRangeUnits()) do
				if v:GetEntry() < 400001 and v:IsAlive() and v:IsCreature() then
					if v:GetDistanceYards(pUnit) < distance then
						distance = v:GetDistanceYards(pUnit)
						target = v
					end
				end
			end
			if (target == nil) then
				pUnit:MoveTo(ax, ay, az, 0)
			end
		end
	end
	pUnit:SetValue("target", target)
	if (target) then
		local_attack(pUnit, target)
	end
end

function local_attack(pUnit, target)
	pUnit:AttackReaction(target, 1, 0)
end

function AI_SPELL_TICK(pUnit)
	local target = pUnit:GetValue("spell_target")
	if (target == nil or target:IsDead()) then
		target = nil
		local distance = 40
		if pUnit:GetEntry() < 400001 then -- Team A
			for _,v in pairs(pUnit:GetInRangeUnits()) do
				if v:GetEntry() > 400000 and v:IsAlive() and v:IsCreature() then
					if v:GetDistanceYards(pUnit) < distance then
						distance = v:GetDistanceYards(pUnit)
						target = v
					end
				end
			end
		else
			for _,v in pairs(pUnit:GetInRangeUnits()) do
				if v:GetEntry() < 400001 and v:IsAlive() and v:IsCreature() then
					if v:GetDistanceYards(pUnit) < distance then
						distance = v:GetDistanceYards(pUnit)
						target = v
					end
				end
			end
		end
	end
	pUnit:SetValue("spell_target", target)
	if target then
		pUnit:CastSpellOnTarget(42319, target)
		local damage = math.random(20,30)
		if damage > target:GetHealth() then
			target:Kill(target)
		else
			target:SetHealth(target:GetHealth()-damage)
		end
	end
end

function Abomination_Cleave(pUnit)
	local targets = pUnit:GetValue("cleave_targets")
	local update = false
	if (targets == nil) then
		targets = {}
		update = true
	else
		for i = 3, 1, -1 do
			if (targets[i] == nil or targets[i]:IsDead()) then
				update = true
				table.remove(targets, i)
			end
		end
	end
	if (update) then
		if pUnit:GetEntry() < 400001 then -- Team A
			for _,v in pairs(pUnit:GetInRangeUnits()) do
				if v:GetEntry() > 400000 and v:IsAlive() and v:IsCreature() then
					if v:GetDistanceYards(pUnit) < 8 then
						if (#targets < 3 and isSame(v, targets[1]) == false and isSame(v, targets[2]) == false) then
							table.insert(targets, v)
							if (#targets == 3) then
								break
							end
						end
					end
				end
			end
		else
			for _,v in pairs(pUnit:GetInRangeUnits()) do
				if v:GetEntry() < 400001 and v:IsAlive() and v:IsCreature() then
					if v:GetDistanceYards(pUnit) < 8 then
						if (#targets < 3) then
							table.insert(targets, v)
							if (#targets == 3) then
								break
							end
						end
					end
				end
			end
		end
	end
	if (0 < #targets) then
		pUnit:SetValue("cleave_targets", targets)
		pUnit:CastSpell(58913) -- visual
		for i = 1, #targets do
			local damage = i * 5 + math.random(0, 5)
			local t = targets[i]
			if (t:GetHealth() <= damage) then
				t:Kill(t)
			else
				t:SetHealth(t:GetHealth() - damage)
			end
		end
	end
end

function Do_Upgrades_For_Units(pUnit)
	if pUnit:GetEntry() == 400003 or pUnit:GetEntry() == 399998 then
		pUnit:EquipWeapons(1155, 0, 0)
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	end
	if UpgradedGhoulsA then
		if pUnit:GetEntry() == 399999 then -- upgrade ghouls A
			pUnit:CastSpell(41447)
			return;
		end
	end
	if UpgradedGhoulsB then
		if pUnit:GetEntry() == 400002 then -- upgrade ghouls B
			pUnit:CastSpell(41447)
			return;
		end
	end
	if UpgradedNecrosA then
		if pUnit:GetEntry() == 399998 then -- upgrade necros A
			pUnit:SetMaxHealth(150)
			pUnit:SetHealth(150)
			pUnit:SetScale(1.2)
			return;
		end
	end
	if UpgradedNecrosB then
		if pUnit:GetEntry() == 400003 then -- upgrade necros B
			pUnit:SetMaxHealth(150)
			pUnit:SetHealth(150)
			pUnit:SetScale(1.2)
			return;
		end
	end
end

RegisterUnitEvent(399999, 18, "MeleeUnit_AI")
RegisterUnitEvent(400002, 18, "MeleeUnit_AI")
RegisterUnitEvent(399998, 18, "MeleeUnit_AI")
RegisterUnitEvent(400003, 18, "MeleeUnit_AI")
RegisterUnitEvent(399997, 18, "MeleeUnit_AI")
RegisterUnitEvent(400004, 18, "MeleeUnit_AI")

RegisterUnitEvent(399999, 4, "MeleeUnit_AI")
RegisterUnitEvent(400002, 4, "MeleeUnit_AI")
RegisterUnitEvent(399998, 4, "MeleeUnit_AI")
RegisterUnitEvent(400003, 4, "MeleeUnit_AI")
RegisterUnitEvent(399997, 4, "MeleeUnit_AI")
RegisterUnitEvent(400004, 4, "MeleeUnit_AI")

function TurretAI(pUnit, Event)
	if Event == 18 then
		pUnit:RegisterEvent("TurretAI_Tick", 2000, 0)
	else
		pUnit:RemoveEvents()
	end
end

function TurretAI_Tick(pUnit)
	local target = nil
	local distance = 20
	if pUnit:GetEntry() < 400001 then -- Team A
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() > 400000 and v:IsAlive() and v:IsCreature() then
				if v:GetDistanceYards(pUnit) < distance then
					distance = v:GetDistanceYards(pUnit)
					target = v
				end
			end
		end
	else
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			if v:GetEntry() < 400001 and v:IsAlive() and v:IsCreature() then
				if v:GetDistanceYards(pUnit) < distance then
					target = v
				end
			end
		end
	end
	if target then
		pUnit:CastSpellOnTarget(49687, target)
		local damage = math.random(50,80)
		if damage > target:GetHealth() then
			target:Kill(target)
		else
			target:SetHealth(target:GetHealth()-damage)
		end
	end
end

RegisterUnitEvent(399995, 4, "TurretAI")
RegisterUnitEvent(400005, 4, "TurretAI")
RegisterUnitEvent(399995, 18, "TurretAI")
RegisterUnitEvent(400005, 18, "TurretAI")