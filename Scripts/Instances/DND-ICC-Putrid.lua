
SLIME = {}
SLIME.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3

SetDBCSpellVar(72999, "c_is_flags", 0x01000)

function SLIME.VAR.OnSpawnSlime(pUnit, event)
	pUnit:RegisterEvent("SLIME.VAR.SpamSlime", math.random(1000, 10000), 0)
end

function SLIME.VAR.SpamSlime(pUnit)
	if pUnit ~= nil then
		if pUnit:IsAlive() then
			local plr = pUnit:GetClosestPlayer()
			if plr ~= nil then
				pUnit:CastSpellOnTarget(7125, plr)
			end
		else
			pUnit:RemoveEvents()
		end
	end
end

RegisterUnitEvent(123492, 1, "SLIME.VAR.OnSpawnSlime")

function SLIME.VAR.OnSpawnVisual(pUnit, event)
	pUnit:RegisterEvent("SLIME.VAR.slimevisual", math.random(15000, 30000), 0)
end

function SLIME.VAR.slimevisual(pUnit)
	pUnit:FullCastSpell(35426)
end

RegisterUnitEvent(123493, 18, "SLIME.VAR.OnSpawnVisual")

function SLIME.VAR.MiniBossDeath(pUnit, event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SLIME[id] = SLIME[id] or {VAR={}}
	pUnit:RemoveEvents()
	local putrid = pUnit:GetCreatureNearestCoords(4356.3, 3261.4, 389.4, 309931)
	if pUnit:GetEntry() == 310053 then -- orange
		pUnit:GetGameObjectNearestCoords(4313.16, 3041.35, 356.594, 201617):SetByte(GAMEOBJECT_BYTES_1,0,1) -- orange tubes
		pUnit:GetGameObjectNearestCoords(4357.06, 3071.33, 354.362, 201613):SetByte(GAMEOBJECT_BYTES_1,0,0) -- orange door
		pUnit:PlaySoundToSet(17146)
		if putrid ~= nil then
			putrid:SendChatMessage(14,0,"Terrible news, everyone! Rotface is dead. But great news everyone! He left plenty of ooze for me to use! Ee-whaa? I'm a poet, and I didn't know it! Astounding!")
		end
	else -- green
		pUnit:GetGameObjectNearestCoords(4400.8, 3043.07, 355.308, 201618):SetByte(GAMEOBJECT_BYTES_1,0,1) -- close
		pUnit:GetGameObjectNearestCoords(4357.06, 3071.33, 354.362, 201614):SetByte(GAMEOBJECT_BYTES_1,0,0) -- green door
		pUnit:PlaySoundToSet(17124)
		if putrid ~= nil then
			putrid:SendChatMessage(14,0,"Oh Festergut, you were always my favorite, next to Rotface... But the good news is you left behind so much gas! I can practically taste it!")
		end
	end
	if SLIME[id].VAR.deaths == nil then
		SLIME[id].VAR.deaths = 1
	else
		pUnit:GetGameObjectNearestCoords(4356.6, 3154.8, 389.4, 201372):SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		pUnit:GetGameObjectNearestCoords(4357.06, 3071.33, 354.362, 201612):SetByte(GAMEOBJECT_BYTES_1,0,0) -- collision
		pUnit:GetGameObjectNearestCoords(4357.06, 3071.33, 354.362, 201614):Despawn(2500, 0) -- green door
		pUnit:GetGameObjectNearestCoords(4357.06, 3071.33, 354.362, 201613):Despawn(2500, 0) -- orange door
	end
end

RegisterUnitEvent(310052, 4, "SLIME.VAR.MiniBossDeath")
RegisterUnitEvent(310053, 4, "SLIME.VAR.MiniBossDeath")

function SLIME.VAR.FIRESPAwn(pUnit, event)
	pUnit:RegisterEvent("SLIME.VAR.CheckForPlayersFire", 2000, 0)
end

function SLIME.VAR.CheckForPlayersFire(pUnit)
	local p = pUnit:GetClosestPlayer()
	if p ~= nil then
		if pUnit:GetDistanceYards(p) < 7 then
			if (not p:HasAura(40647)) then
				pUnit:Strike(p, 2, 38043, 520, 530, 1.2)
				p:CastSpell(36301)
				--RegisterTimedEvent("Remove_Player_Buff", 4000, 1, p)
				CreateLuaEvent(function() if p and p:HasAura(36301) then p:RemoveAura(36301) end end, 4000, 1)
			end
		end
	end
end

--[[function Remove_Player_Buff(p)
	if p ~= nil then
		if p:HasAura(36301) then
			p:RemoveAura(36301)
		end
	end
end]]

RegisterUnitEvent(309981, 18, "SLIME.VAR.FIRESPAwn")

-- boss

function SLIME.VAR.PutridOnCombat(pUnit, event)
	pUnit:PlaySoundToSet(17130)
	pUnit:SendChatMessage(12,0,"Good news everyone! I think I've perfected a plague that will destroy all life on Azeroth!")
	for place, plrs in pairs(pUnit:GetInRangePlayers()) do
		pUnit:CastSpellOnTarget(744, plrs) -- poison
	end
	pUnit:GetGameObjectNearestCoords(4356.6, 3154.8, 389.4, 201372):SetByte(GAMEOBJECT_BYTES_1,0,1)
	pUnit:RegisterEvent("SLIME.VAR.BossShadowSpellSpam", 7500, 0)
	pUnit:RegisterEvent("SLIME.VAR.BossPhaseTwo", 2500, 0)
end

function SLIME.VAR.PutridOnLeave(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:SetScale(1)
	pUnit:GetGameObjectNearestCoords(4356.6, 3154.8, 389.4, 201372):SetByte(GAMEOBJECT_BYTES_1,0,0)
end

function SLIME.VAR.PutridOnDeath(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:SetScale(1)
	pUnit:PlaySoundToSet(17133)
	pUnit:SendChatMessage(12,0,"Bad news everyone! I don't think I'm going to make it...")
	pUnit:GetGameObjectNearestCoords(4356.6, 3154.8, 389.4, 201372):SetByte(GAMEOBJECT_BYTES_1,0,0)
end

function SLIME.VAR.PutridOnSpawn(pUnit, Event)
	pUnit:SetMaxPower(1000, 1) -- amount is 100, type is rage
	pUnit:SetPowerType(1) -- type is rage
	pUnit:SetScale(1)
end

function SLIME.VAR.BossShadowSpellSpam(pUnit)
	local p = pUnit:GetRandomPlayer(0)
	if p ~= nil then
		p:FullCastSpell(72999)
	end
end

function SLIME.VAR.BossPhaseTwo(pUnit)
	if pUnit:GetHealthPct() < 80 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(40647) -- Shadow prison
		pUnit:FullCastSpell(72851)
		pUnit:PlaySoundToSet(17137)
		pUnit:SendChatMessage(12,0,"Tastes like... Sherry! Oh, excuse me!")
		pUnit:RegisterEvent("SLIME.VAR.WaitP2", 5000, 1)
		pUnit:RegisterEvent("SLIME.VAR.WaitP2s", 13000, 1)
		pUnit:RegisterEvent("SLIME.VAR.WaitP2re", 14000, 1)
	end
end

function SLIME.VAR.WaitP2(pUnit)
	for i=1,10,1 do
		local t = pUnit:GetRandomPlayer(0)
		local p = pUnit:GetRandomPlayer(0)
		if (p:GetName() ~= t:GetName()) then
			local aX = p:GetX()
			local aY = p:GetY()
			local aZ = p:GetZ()
			local aO = p:GetO()
			p:SetPosition(t:GetX(), t:GetY(), t:GetZ(), t:GetO())
			t:SetPosition(aX, aY, aZ, aO)
			t:CastSpell(64446) -- Teleport visual
			p:CastSpell(64446)
		end
	end
end

function SLIME.VAR.WaitP2s(pUnit)
	for place, plrs in pairs(pUnit:GetInRangePlayers()) do
		pUnit:CastSpellOnTarget(744, plrs) -- poison
	end
	pUnit:PlaySoundToSet(17134)
	pUnit:SendChatMessage(14,0,"Great news everyone! UGH-")
	pUnit:SetScale(1.5)
	pUnit:SetPower(1000, 1)
end

function SLIME.VAR.WaitP2re(pUnit)
	pUnit:CancelSpell()
	for place, players in pairs(pUnit:GetInRangePlayers()) do
		if players:HasAura(40647) then
			players:RemoveAura(40647)
		end
	end
	pUnit:RegisterEvent("SLIME.VAR.ThunderclapBoss", 6000, 0)
	pUnit:RegisterEvent("SLIME.VAR.WaitP2", 25000, 1)
	pUnit:RegisterEvent("SLIME.VAR.BossShadowSpellSpam", 9000, 0)
end

function SLIME.VAR.ThunderclapBoss(pUnit)
	if pUnit:GetPower(1) > 199 then
		--pUnit:SetPower(pUnit:GetPower(1)-200, 1)
		pUnit:FullCastSpell(8198)
	else
		pUnit:RegisterEvent("SLIME.VAR.ResetScaleAndPotions", 3000, 1)
	end
	if math.random(1,7) == 2 then
		pUnit:FullCastSpell(871)
	end
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:CastSpellOnTarget(871, plr) -- barrel toss
	end
end

function SLIME.VAR.ResetScaleAndPotions(pUnit)
	pUnit:RemoveEvents()
	pUnit:SetScale(1)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SLIME[id] = SLIME[id] or {VAR={}}
	SLIME[id].VAR.plr = pUnit:GetRandomPlayer(0)
	if SLIME[id].VAR.plr ~= nil then
		pUnit:SendChatMessage(42,0,"Putrid prepares to finish "..SLIME[id].VAR.plr:GetName().."!")
		pUnit:SendChatMessageToPlayer(42,0,"Click on the potions, quick!", SLIME[id].VAR.plr)
	end
	pUnit:RegisterEvent("SLIME.VAR.ContinueWithSpells", 5000, 1)
end

function SLIME.VAR.ContinueWithSpells(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SLIME[id] = SLIME[id] or {VAR={}}
	if SLIME[id].VAR.plr ~= nil then
		SLIME[id].VAR.plr:CastSpell(61126)
	end
	pUnit:RegisterEvent("SLIME.VAR.FinishPlayer", 750, 1)
end

function SLIME.VAR.FinishPlayer(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	SLIME[id] = SLIME[id] or {VAR={}}
	if SLIME[id].VAR.plr ~= nil then
		pUnit:CastSpellOnTarget(11, SLIME[id].VAR.plr)
		pUnit:CastSpellOnTarget(11, SLIME[id].VAR.plr)
		pUnit:CastSpellOnTarget(11, SLIME[id].VAR.plr)
	end
	if math.random(1,2) == 1 then
		pUnit:PlaySoundToSet(17142)
		pUnit:SendChatMessage(12,0,"Great news everyone! The slime is growing again.")
	else
		pUnit:PlaySoundToSet(17141)
		pUnit:SendChatMessage(12,0,"You can't come in here all dirty like that! You need that nasty rash scrubbed off first.")
	end
	pUnit:SetPower(1000, 1)
	pUnit:SetScale(math.random(1.3,2.1))
	pUnit:RegisterEvent("SLIME.VAR.ThunderclapBoss", math.random(5000,10000), 0)
	pUnit:RegisterEvent("SLIME.VAR.WaitP2", 25000, 1)
	pUnit:RegisterEvent("SLIME.VAR.BossShadowSpellSpam", math.random(7000,12000), 0)
	pUnit:RegisterEvent("SLIME.VAR.LastPhase", 2500, 0)
end

function SLIME.VAR.LastPhase(pUnit)
	if pUnit:GetHealthPct() < 10 then
		pUnit:RemoveEvents()
		pUnit:SetScale(2.5)
		pUnit:PlaySoundToSet(17132)
		pUnit:SendChatMessage(12,0,"That was unexpected.")
		pUnit:FullCastSpell(18501) -- enrage
		pUnit:RegisterEvent("SLIME.VAR.SCareem", 4000, 0)
	end
end

function SLIME.VAR.SCareem(pUnit)
	local target = pUnit:GetRandomPlayer(0)
	if target ~= nil then
		target:CancelSpell()
		target:CastSpell(61126)
		target:SetMana(0)
	end
end

RegisterUnitEvent(309931, 1, "SLIME.VAR.PutridOnCombat")
RegisterUnitEvent(309931, 2, "SLIME.VAR.PutridOnLeave")
RegisterUnitEvent(309931, 4, "SLIME.VAR.PutridOnDeath")
RegisterUnitEvent(309931, 18, "SLIME.VAR.PutridOnSpawn")

-- drink me

function SLIME.VAR.DrinkMeUse(pMisc, event, player)
	local id = player:GetInstanceID()
	if id == nil then id = 1 end
	SLIME[id] = SLIME[id] or {VAR={}}
	player:FullCastSpell(71968)
	if SLIME[id].VAR.plr ~= nil then
		if SLIME[id].VAR.plr:GetName() == player:GetName() then
			SLIME[id].VAR.plr = nil
		end
	end
end

RegisterGameObjectEvent(201584, 4, "SLIME.VAR.DrinkMeUse")

-- mini bosses

function SLIME.VAR.festerOnCombat(pUnit, event)
	pUnit:SendChatMessage(14,0,"Fun time!")
	pUnit:PlaySoundToSet(16901)
	pUnit:RegisterEvent("SLIME.VAR.SpamNewlings", 1000, 0)
end

function SLIME.VAR.SpamNewlings(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:SpawnCreature(123491, plr:GetX(), plr:GetY(), plr:GetZ(), 0, 21, 60000)
	end
end

function SLIME.VAR.miniOnLeave(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(310052, 1, "SLIME.VAR.festerOnCombat")
RegisterUnitEvent(310052, 2, "SLIME.VAR.miniOnLeave")

function SLIME.VAR.rotfaceOnCombat(pUnit, Event)
	pUnit:SendChatMessage(14,0,"Wheeee!")
	pUnit:PlaySoundToSet(16986)
	pUnit:SendChatMessage(42,0,"You have 60 seconds left!")
	pUnit:RegisterEvent("SLIME.VAR.rot10", 30000, 1)
	pUnit:RegisterEvent("SLIME.VAR.rot5", 45000, 1)
	pUnit:RegisterEvent("SLIME.VAR.rot3", 57000, 1)
	pUnit:RegisterEvent("SLIME.VAR.rot2", 58000, 1)
	pUnit:RegisterEvent("SLIME.VAR.rot1", 59000, 1)
	pUnit:RegisterEvent("SLIME.VAR.rot0", 60000, 1)
end

function SLIME.VAR.rot10(pUnit)
	pUnit:SendChatMessage(42,0,"30 seconds!")
end

function SLIME.VAR.rot5(pUnit)
	pUnit:SendChatMessage(42,0,"15 seconds!")
end

function SLIME.VAR.rot3(pUnit)
	pUnit:SendChatMessage(42,0,"3")
end

function SLIME.VAR.rot2(pUnit)
	pUnit:SendChatMessage(42,0,"2")
end

function SLIME.VAR.rot1(pUnit)
	pUnit:SendChatMessage(42,0,"1")
end

function SLIME.VAR.rot0(pUnit)
	pUnit:CastSpell(70063) -- wipe
end

RegisterUnitEvent(310053, 1, "SLIME.VAR.rotfaceOnCombat")
RegisterUnitEvent(310053, 2, "SLIME.VAR.miniOnLeave")

--
