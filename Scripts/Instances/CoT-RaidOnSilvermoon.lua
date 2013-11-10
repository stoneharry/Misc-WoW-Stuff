--[[
Call of the Scourge (visual) = 56749
Scourge conversion beam (channel) = 47976
]]

local SYLVANIS_BOW 		= 25953
--[[
These are defined in creature_proto AURAS now
local SILVERMOON_BANNER = 66360
local SCOURGE_BANNER	= 59942
]]
local BRIDGE_EXPLODE 	= 52324
local BYTES_2 			= 0x0006 + 0x0074
local UNIT_FIELD_FLAGS 	= 0x0006 + 0x0035

local SILVERMOON_GUARDS = {}

local SOUNDS = {
	-- intro
	[1] = {50300, "Ah. Wondrous, eternal Quel'Thalas. I haven't been here since I was a boy.", false}, -- 6 seconds
	[2] = {50301, "Be wary, the elves likely wait in ambush.", false}, -- 4
	[3] = {50302, "The frail elves do not concern me, necromancer. Our forces are strengthened with every foe we slay.", false}, -- 6
	[4] = {50303, "Don't be too overconfident, death knight. The elves must not be taken lightly.", false}, -- 7
	[5] = {50304, "The energies of this place are strong. Kill the elves, level their structures. This location is perfect for your base.", false}, -- 9
	[6] = {50305, "It'll be a pleasure.", false}, -- 1
	-- bridge
	[7] = {50307, "The undead are advancing, alert the sentries!", true}, -- 2
	[8] = {50308, "You are not welcome here. I am Sylvanas Windrunner, Ranger-General of Silvermoon. I advise you to turn back now.", false}, -- 9
	[9] = {50309, "It is you who should turn back, Sylvanas! Death itself has come to your land.", false}, -- 5
	[10] = {50311, "Fall back to the trees!", true}, -- 1
	[11] = {50312, "You waste your time, woman. You cannot outrun the inevitable.", false}, -- 4
	[12] = {50313, "You think that I'm running from you? Apparently you've never fought elves before.", false}, -- 5
	[13] = {50314, "Damn that woman! We must find a way to cross the river.", false}, -- 3
	[14] = {50315, "She is... persistent. Reminds me of you, death knight.", false}, -- 6
	[15] = {50316, "Shut up, you damn ghost.", false}, -- 1
	-- Approach 1st gate
	[16] = {50317, "You will never enter Quel'Thalas, fallen prince. The woods themselves protect our borders and the enchanted elf gates protect our capital.", false}, -- 9
	[17] = {50318, "Your precious gates will not stop me any more than these trees little elf. Bring up the meat wagons, we'll make our own enterance.", false}, -- 9
	[18] = {50319, "Do your worst. The elfgate to the inner kingdom is protected by our most powerful enchantments. You will not pass.", false}, -- 7
	-- 1st gate
	[19] = {50320, "Finally we've reached the elf gate! Press the attack, let none survive.", false}, -- 4
	[20] = {50321, "Summon the reinforcements, we must hold them back!", true}, -- 3
	[21] = {50322, "Shindu fallah nah! Fall back to the second gate! Fall back!", true}, -- 4
	[22] = {50323, "The elf gate has fallen! Onward my warriors! Onward to victory!", true}, -- 4
	[23] = {50324, "You've won through this gate butcher but you won't get through the second. The inner gate to Silvermoon can only be opened with a special key, and it shall never be yours.", false}, -- 10
	[24] = {50325, "We'll see about that.", false}, -- 1
	-- 2nd gate
	[25] = {50326, "That moon crystal is a component of the key of the three moons. The other two crystals must be found if the elf gate is to be unlocked.", false}, -- 11
	[26] = {50327, "That ranger woman is starting to vex me greatly.", false}, -- 2
	[27] = {50328, "A second moon crystal is ours!", true}, -- 2
	[28] = {50329, "At last the third moon crystal! The key of the three moons is complete.", true}, -- 7
	[29] = {50330, "The gates have been opened. Once we've dealt with Sylvanas, the inner kingdom shall be ours!", true}, -- 5
	[30] = {50331, "Damn you monsters! What will it take to drive you back?!", true}, -- 3
	-- Sylvanas Fight
	[31] = {50332, "I salute your bravery, elf. But the chase is over.", false}, -- 4
	[32] = {50333, "Then I'll make my stand here, butcher. Anar'alah belore.", false}, -- 5
	-- Outro
	[33] = {50334, "Finish it... I deserve... a clean death.", false}, -- 6
	[34] = {50335, "After all you've put me through woman, the last thing I'll give you is the peace of death.", false}, -- 5
	[35] = {50336, "No! You wouldn't dare.", false}, -- 3
	-- Misc
	[36] = {50339, "Did you forget about us, you wretches? Bash'a no falor talah!", true}, -- 3
	[37] = {50336, "", false},
	[38] = {50337, "", false},
	[39] = {50338, "", false},
	[40] = {50339, "", false},
}

local function PlayMessage(u, s)
	if not u then
		return
	end
	local m = SOUNDS[s][2]
	if m then
		if SOUNDS[s][3] then
			u:SendChatMessage(14,0,m)
			u:Emote(5,0)
		else
			u:SendChatMessage(12,0,m)
			u:Emote(1,0)
		end
		if SOUNDS[s][1] then
			u:PlaySoundToSet(SOUNDS[s][1])
		end
	else
		if SOUNDS[s][1] then
			u:PlayMusicToSet(SOUNDS[s][1])
		end
	end
end

-- To the bridge
local WALK_PATH = {
	[1] = {
		{8698, -6782, 91, 0},
		{8717, -6711, 76, 0},
		{8774, -6648, 64.5, 0},
		{8842, -6648, 48.3, 0},
		{8882, -6685, 37.6, 0.007690}
	},
	[2] = {
		{8708, -6789, 91.5, 0},
		{8754, -6664, 68, 0},
		{8831, -6656, 49.6, 0},
		{8880, -6690, 37.8, 0},
		{8882, -6691, 37.5, 0.078538}
	}
}

RS = {}
RS.VAR = {}

---------------------------
-- Setup
---------------------------
function RS.VAR.KelThuzadSpawn(pUnit, Event)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	pUnit:RegisterEvent("RS.VAR.GhostVisual", 1000, 1)
	RS[id].VAR.KelThuzad = pUnit
end

function RS.VAR.GhostVisual(pUnit)
	pUnit:EquipWeapons(0,40699,0)
	pUnit:SetUInt32Value(BYTES_2, 1)
end

RegisterUnitEvent(163091, 18, "RS.VAR.KelThuzadSpawn")

function RS.VAR.ArthasSpawn(pUnit, Event)
	pUnit:RegisterEvent("RS.VAR.SetupArthas", 1000, 1)
	pUnit:RegisterEvent("RS.VAR.StartEvent2", 3000, 0)
end

function RS.VAR.SetupArthas(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	RS[id].VAR.Arthas = pUnit
	pUnit:EquipWeapons(36942,0,0)
	pUnit:SetUInt32Value(BYTES_2, 1)
end

RegisterUnitEvent(222351, 18, "RS.VAR.ArthasSpawn")

function RS.VAR.ScourgeIntroAI(pUnit, Event)
	if pUnit:GetEntry() == 275371 then
		pUnit:RegisterEvent("RS.VAR.ScourgeEquip", 1000, 1)
	else
		pUnit:SetValue("spawn", {pUnit:GetX(), pUnit:GetY(), pUnit:GetZ()})
		pUnit:RegisterEvent("RS.VAR.ScourgeRMove", math.random(1,10)*1000, 1)
	end
end

function RS.VAR.ScourgeEquip(pUnit)
	pUnit:EquipWeapons(1933,0,0)
	pUnit:SetUInt32Value(BYTES_2, 1)
end

function RS.VAR.ScourgeRMove(pUnit)
	pUnit:RegisterEvent("RS.VAR.ScourgeRMove", math.random(4, 6)*1000, 1)

	local x,y = pUnit:GetX(), pUnit:GetY()

	local start = pUnit:GetValue("spawn")
	if start then
		local a,b,c = start[1], start[2], start[3]
		if a and b and c then
			if pUnit:CalcToDistance(a, b, c) > 11 then
				pUnit:ReturnToSpawnPoint()
				return
			end
		end
	end

	local choice = math.random(1,4)
	if choice == 1 then
		x = x + math.random(1,5)
		y = y + math.random(1,5)
	elseif choice == 2 then
		x = x + math.random(1,5)
		y = y - math.random(1,5)
	elseif choice == 3 then
		x = x - math.random(1,5)
		y = y + math.random(1,5)
	elseif choice == 4 then
		x = x - math.random(1,5)
		y = y - math.random(1,5)
	end
	pUnit:MoveTo(x,y,pUnit:GetLandHeight(x,y),0)
end

RegisterUnitEvent(275372, 18, "RS.VAR.ScourgeIntroAI")
RegisterUnitEvent(275371, 18, "RS.VAR.ScourgeIntroAI")

---------------------------
-- Gossip Start & Intro
---------------------------

function RS.VAR.GossipStartZ11(pUnit, event, player)
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(9, "Let us begin.", 424, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 526, 0)
	pUnit:GossipSendMenu(player)
end


function RS.VAR.GossipStartZ22(pUnit, event, player, id, intid, code)
	player:GossipComplete()
	if(intid == 424) then
		local id = pUnit:GetInstanceID() or 1
		RS[id] = RS[id] or {VAR={}}
		if RS[id].VAR.KelThuzad and RS[id].VAR.Arthas then
			pUnit:SetNPCFlags(2)
			RS[id].VAR.start = true
		end
	end
end

RegisterUnitGossipEvent(95208, 1, "RS.VAR.GossipStartZ11")
RegisterUnitGossipEvent(95208, 2, "RS.VAR.GossipStartZ22")

function RS.VAR.StartEvent2(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	if RS[id].VAR.start then
		RS[id].VAR.start = false
		RS[id].VAR.i = 0
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("RS.VAR.CinematicIntro", 1000, 0)
		pUnit:SetValue("i", 1)
		pUnit:RegisterEvent("RS.VAR.WalkToBridge", 1000, 0)
		RS[id].VAR.KelThuzad:SetValue("i", 1)
		RS[id].VAR.KelThuzad:RegisterEvent("RS.VAR.WalkToBridge", 1000, 0)
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			local e = v:GetEntry()
			if e == 275371 or e == 275372 then
				v:RemoveEvents()
				v:SetValue("i", 1)
				v:SetValue("x", math.random(1,2))
				v:RegisterEvent("RS.VAR.WalkToBridge", math.random(1,6)*1000, 0)
			end
		end
	end
end

function RS.VAR.CinematicIntro(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	RS[id].VAR.i = RS[id].VAR.i + 1
	if RS[id].VAR.i == 1 then
		PlayMessage(pUnit, 1)
	elseif RS[id].VAR.i == 8 then
		PlayMessage(RS[id].VAR.KelThuzad, 2)
	elseif RS[id].VAR.i == 13 then
		PlayMessage(pUnit, 3)
	elseif RS[id].VAR.i == 20 then
		PlayMessage(RS[id].VAR.KelThuzad, 4)
	elseif RS[id].VAR.i == 27 then
		PlayMessage(RS[id].VAR.KelThuzad, 5)
	elseif RS[id].VAR.i == 36 then
		PlayMessage(pUnit, 6)
	end
end

function RS.VAR.WalkToBridge(pUnit)
	local i = pUnit:GetValue("i")
	if pUnit:GetEntry() == 222351 then -- arthas
		if pUnit:CalcToDistance(WALK_PATH[1][i][1], WALK_PATH[1][i][2], WALK_PATH[1][i][3]) < 5 then
			i = i + 1
			pUnit:SetValue("i", i)
		end
		if not WALK_PATH[1][i] then
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("RS.VAR.BeginPhase1", 15000, 1)
			return
		end
		pUnit:MoveTo(WALK_PATH[1][i][1], WALK_PATH[1][i][2], WALK_PATH[1][i][3], WALK_PATH[1][i][4])
		return
	end
	if pUnit:GetEntry() == 163091 then -- Kel'Thuzad
		if pUnit:CalcToDistance(WALK_PATH[2][i][1], WALK_PATH[2][i][2], WALK_PATH[2][i][3]) < 5 then
			i = i + 1
			pUnit:SetValue("i", i)
		end
		if not WALK_PATH[2][i] then
			pUnit:RemoveEvents()
			return
		end
		pUnit:MoveTo(WALK_PATH[2][i][1], WALK_PATH[2][i][2], WALK_PATH[2][i][3], WALK_PATH[2][i][4])
		return
	end
	local x = pUnit:GetValue("x")
	if WALK_PATH[x][i] then
		if pUnit:CalcToDistance(WALK_PATH[x][i][1], WALK_PATH[x][i][2], WALK_PATH[x][i][3]) < 5 then
			i = i + 1
			pUnit:SetValue("i", i)
		end
	end
	if not WALK_PATH[x][i] then
		local id = pUnit:GetInstanceID() or 1
		RS[id] = RS[id] or {VAR={}}
		if pUnit:GetDistanceYards(RS[id].VAR.Arthas) < 6 or pUnit:GetDistanceYards(RS[id].VAR.KelThuzad) < 6 then
			local x,y = pUnit:GetX()+math.random(5,20), pUnit:GetY()
			if math.random(1,2) == 1 then
				y = y + math.random(0,10)
			else
				y = y - math.random(0,10)
			end
			pUnit:MoveTo(x,y,pUnit:GetLandHeight(x,y),0.008)
			pUnit:RemoveEvents()
		end
		return
	end
	pUnit:MoveTo(WALK_PATH[x][i][1], WALK_PATH[x][i][2], WALK_PATH[x][i][3], WALK_PATH[x][i][4])
end

function RS.VAR.BeginPhase1(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr and plr:GetDistanceYards(pUnit) < 10 then
		pUnit:RegisterEvent("RS.VAR.ProperlyStartThisStuff", 1000, 1)
	else
		pUnit:RegisterEvent("RS.VAR.BeginPhase1", 2000, 1)
	end
end

---------------------------
-- The Bridge
---------------------------

function RS.VAR.ProperlyStartThisStuff(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	if not RS[id].VAR.Sylvanas or not RS[id].VAR.Sylvanas:IsInWorld() then
		pUnit:RegisterEvent("RS.VAR.ProperlyStartThisStuff", 3000, 1)
		pUnit:SpawnCreature(50207, 8992.4, -6682.8, 12.11, 3.129243, 14, 0, SYLVANIS_BOW, SYLVANIS_BOW, SYLVANIS_BOW)
	else
		PlayMessage(RS[id].VAR.Sylvanas, 7)
		pUnit:RegisterEvent("RS.VAR.MoreMessBridge", 3000, 1)
		pUnit:RegisterEvent("RS.VAR.MoreMessBridge_2", 13000, 1)
		pUnit:RegisterEvent("RS.VAR.ATTACKWHOOBRIDGE", 18000, 1)
	end
end

function RS.VAR.MoreMessBridge(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	PlayMessage(RS[id].VAR.Sylvanas, 8)
	local i
	local x1,y1,x2,y2 = 9049, 6675, 9062, 6688
	for i=1,10 do
		local n1,n2 = math.random(x1,x2),math.random(y1,y2)
		n2 = -n2
		pUnit:SpawnCreature(155111, n1,n2,pUnit:GetLandHeight(n1,n2), 0, 14, 0)
	end
end

function RS.VAR.MoreMessBridge_2(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	PlayMessage(pUnit, 9)
end

function RS.VAR.SylvanasSpawnBridge(pUnit)
	pUnit:SetUInt32Value(BYTES_2, 2)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:RegisterEvent("RS.VAR.Sylvanas_DelayBridge", 1000, 1)
end

function RS.VAR.Sylvanas_DelayBridge(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	RS[id].VAR.Sylvanas = pUnit
end

RegisterUnitEvent(50207, 18, "RS.VAR.SylvanasSpawnBridge")

function RS.VAR.ATTACKWHOOBRIDGE(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	--RS[id].VAR.Sylvanas:AIDisableCombat(true)
	RS[id].VAR.Sylvanas:Root()
	RS[id].VAR.Sylvanas:RegisterEvent("RS.VAR.SylvanasAI", 4000, 0)
	local plr = pUnit:GetClosestPlayer()
	if not plr then
		pUnit:RegisterEvent("RS.VAR.ATTACKWHOOBRIDGE", 1000, 1)
		return
	end
	local faction = plr:GetFaction()
	local amnt = #SILVERMOON_GUARDS
	for _,v in pairs(pUnit:GetInRangeUnits()) do
		local e = v:GetEntry()
		if e == 155111 or e == 50207 then
			v:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
			v:RegisterEvent("RS.VAR.StayInCombatGuards", 30000, 1)
		elseif e == 275371 or e == 275372 then
			v:SetFaction(faction)
			v:RegisterEvent("RS.VAR.KeepAttackingGuards", math.random(1,3)*1000, 1)
		end
	end
	pUnit:MoveTo(8942, -6680, 25.4, 0.026417)
	RS[id].VAR.KelThuzad:MoveTo(8944,-6685.9,25.4,0.152081)
	pUnit:RegisterEvent("RS.VAR.WaitForGuardsDead", 1000, 0)
end

function RS.VAR.KeepAttackingGuards(pUnit)
	if not pUnit:IsInCombat() then
		local amnt = #SILVERMOON_GUARDS
		if amnt > 0 then
			local t = SILVERMOON_GUARDS[math.random(1, amnt)]
			if t then
				pUnit:MoveTo(t:GetX(), t:GetY(), t:GetZ(), 0)
				if pUnit:GetEntry() == 275371 then
					pUnit:RegisterEvent("RS.VAR.SkeletonAI", 3000, 0)
				end
			end
		end
	end
end

function RS.VAR.StayInCombatGuards(pUnit)
	if pUnit:IsDead() then
		return
	end
	if not pUnit:IsInCombat() then
		pUnit:SetMovementFlags(1)
		pUnit:MoveTo(8989, -6682, 13, 0)
	end
	pUnit:RegisterEvent("RS.VAR.StayInCombatGuards", 5000, 1)
end

function RS.VAR.SkeletonAI(pUnit)
	if pUnit:IsDead() then
		pUnit:RemoveEvents()
		return
	end
	local t = pUnit:GetMainTank()
	if not t then
		return
	end
	if pUnit:GetDistanceYards(t) < 31 then
		--[[local t2 = t:GetMainTank()
		if pUnit:GetDistanceYards(t) < 8 and t2 and tostring(t2:GetGUID()) ~= tostring(pUnit:GetGUID()) then
			pUnit:Unroot()
			pUnit:AIDisableCombat(true)
			pUnit:SetMovementFlags(1)
			pUnit:MoveTo(t:GetX()+10, t:GetY(), t:GetZ(), 0)
		else]]
			pUnit:AIDisableCombat(false)
			pUnit:Root()
			pUnit:SetMana(pUnit:GetMaxMana()/2)
			pUnit:FullCastSpellOnTarget(5145, t) -- arcane bolt, could also use 38340
		--end
	else
		pUnit:Unroot()
	end
end

function RS.VAR.SylvanasAI(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	local syl = RS[id].VAR.Sylvanas
	local plr = syl:GetClosestPlayer()
	if plr and plr:GetDistanceYards(syl) < 31 then
		syl:FullCastSpellOnTarget(66081, plr)
	else
		local t = pUnit:GetClosestEnemy()
		if t and t:GetDistanceYards(syl) < 31 then
			syl:FullCastSpellOnTarget(66081, t)
		end
	end
end

function RS.VAR.SilvermoonGuardBridge(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:RegisterEvent("RS.VAR.RunAccrossBridgeS", math.random(1,3)*1000, 1)
end

function RS.VAR.RunAccrossBridgeS(pUnit)
	pUnit:SetMovementFlags(1)
	local x1,y1,x2,y2 = 8979,6690,8990,6677
	local n1,n2 = math.random(x1,x2),math.random(y2,y1)
	n2 = -n2
	pUnit:MoveTo(n1,n2,pUnit:GetLandHeight(n1,n2),0)
	table.insert(SILVERMOON_GUARDS, pUnit)
end

RegisterUnitEvent(155111, 18, "RS.VAR.SilvermoonGuardBridge")

function RS.VAR.WaitForGuardsDead(pUnit)
	local found = false
	for _,v in pairs(SILVERMOON_GUARDS) do
		if v and v:IsAlive() then
			found = true
			break
		end
	end
	if not found then
		local id = pUnit:GetInstanceID() or 1
		RS[id] = RS[id] or {VAR={}}
		SILVERMOON_GUARDS = {}
		PlayMessage(RS[id].VAR.Sylvanas, 10)
		pUnit:RemoveEvents()
		RS[id].VAR.i = 0
		pUnit:MoveTo(8975,-6679,17.4,6.269292)
		RS[id].VAR.KelThuzad:MoveTo(8975, -6685, 17.5, 6.269292)
		pUnit:RegisterEvent("RS.VAR.EventsAIBridge", 1000, 0)
	end
end

function RS.VAR.EventsAIBridge(pUnit)
	local id = pUnit:GetInstanceID() or 1
	RS[id] = RS[id] or {VAR={}}
	RS[id].VAR.i = RS[id].VAR.i + 1
	if RS[id].VAR.i == 2 then
		PlayMessage(pUnit, 11)
		RS[id].VAR.Sylvanas:RemoveEvents()
		RS[id].VAR.Sylvanas:AIDisableCombat(true)
		RS[id].VAR.Sylvanas:Unroot()
		RS[id].VAR.Sylvanas:SetMovementFlags(1)
		RS[id].VAR.Sylvanas:MoveTo(9053, -6683, 14.53, 3.135553)
	elseif RS[id].VAR.i == 6 then
		PlayMessage(RS[id].VAR.Sylvanas, 12)
	elseif RS[id].VAR.i == 13 then
		for _,v in pairs(pUnit:GetInRangeUnits()) do
			local e = v:GetEntry()
			if e == 275371 or e == 275372 then
				v:RemoveEvents()
				v:Kill(v)
			elseif v:GetEntry() == 99811 then
				v:CastSpell(BRIDGE_EXPLODE)
				v:CastSpell(71025)
			end
		end
		RS[id].VAR.Sylvanas:RemoveEvents()
		RS[id].VAR.Sylvanas:Despawn(1000,0)
		RS[id].VAR.Sylvanas = nil
	elseif RS[id].VAR.i == 15 then
		PlayMessage(pUnit, 13)
	elseif RS[id].VAR.i == 19 then
		PlayMessage(RS[id].VAR.KelThuzad, 14)
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			v:GossipSendPOI(9007, -6954, 7, 6, 0, "A Way To Cross The River")
		end
	elseif RS[id].VAR.i == 26 then
		PlayMessage(pUnit, 15)
		pUnit:RemoveEvents()
		RS[id].VAR.Arthas = nil
		RS[id].VAR.KelThuzad = nil
	end
end

---------------------------
-- 1st Boss
---------------------------

function RS.VAR.RiverLordEvents(pUnit, Event)
	if Event == 18 then
		pUnit:RegisterEvent("RS.VAR.RiverLordVisuals", 5000, 0)
	elseif Event == 1 then
		pUnit:SetModel(50084)
		pUnit:CastSpell(69665)
		pUnit:RemoveAura(38464)
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("RS.VAR.WAtervisualR", 500, 3)
		pUnit:SetScale(7)
		pUnit:RegisterEvent("RS.VAR.WaterVolley", 6000, 0)
		pUnit:RegisterEvent("RS.VAR.BlizzardShit", 11000, 0)
		local id = pUnit:GetInstanceID() or 1
		RS[id] = RS[id] or {VAR={}}
		if RS[id].VAR.Arthas then
			pUnit:CastSpell(69787)
		end
		pUnit:RegisterEvent("RS.VAR.HitAllPlayersOnGround", 30000, 0)
		pUnit:RegisterEvent("RS.VAR.CountPlayerLogs", 1000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		pUnit:RemoveAura(69787)
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end

RegisterUnitEvent(99812, 18, "RS.VAR.RiverLordEvents")
RegisterUnitEvent(99812, 1, "RS.VAR.RiverLordEvents")
RegisterUnitEvent(99812, 2, "RS.VAR.RiverLordEvents")
RegisterUnitEvent(99812, 4, "RS.VAR.RiverLordEvents")

function RS.VAR.BlizzardShit(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 42937)
	end
end

function RS.VAR.RiverLordVisuals(pUnit)
	pUnit:CastSpell(38464)
end

function RS.VAR.WAtervisualR(pUnit)
	pUnit:CastSpell(69665)
end

function RS.VAR.WaterVolley(pUnit)
	pUnit:FullCastSpell(59266)
end

function RS.VAR.HitAllPlayersOnGround(pUnit)
	pUnit:SendChatMessage(42,0,"The River Lord prepares to unleash a tidal wave that will wipe out all people in the water!")
	pUnit:RegisterEvent("RS.VAR.DO_DAT_DAMAGE_STUFF", 5000, 1)
end

function RS.VAR.DO_DAT_DAMAGE_STUFF(pUnit)
	pUnit:FullCastSpell(59627)
	for _,v in ipairs(pUnit:GetInRangePlayers()) do
		if v:IsAlive() then
			if v:GetZ() < 16.6 then
				pUnit:CastSpellOnTarget(11, v)
				pUnit:CastSpellOnTarget(11, v)
				pUnit:CastSpellOnTarget(11, v)
			end
		end
		v:CastSpell(69665)
	end
end

function RS.VAR.CountPlayerLogs(pUnit)
	for _,v in ipairs(pUnit:GetInRangePlayers()) do
		if v:IsAlive() and v:GetZ() > 16.5 then
			local c = v:GetValue("c")
			if not c then
				c = 0
			end
			v:SetValue("c", c+1)
			if c > 45 then
				pUnit:SendChatMessageToPlayer(42,0,"The River Guardian focuses on you because you stayed out of the water for too long!", v)
				v:CastSpell(54899)
				pUnit:CastSpellOnTarget(11, v)
				v:SetValue("c", 0)
			end
		else
			v:SetValue("c", 0)
		end
	end
end

---------------------------
---------------------------