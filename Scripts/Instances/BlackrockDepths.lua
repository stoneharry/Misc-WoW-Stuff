-- Vortex

function ertgagaMogash_OnCombat(pUnit, Event)
 pUnit:Root()
 pUnit:SetCombatMeleeCapable(true)
 local plr = pUnit:GetRandomPlayer(0)
 if plr == nil then
 else
 pUnit:FullCastSpellOnTarget(40368, plr)
 end
 pUnit:RegisterEvent("ertgagaMogash_Frostbolt", 5000, 0)
end

function ertgagaMogash_Frostbolt(pUnit, Event)
 local plr = pUnit:GetRandomPlayer(0)
 if plr == nil then
 else
 pUnit:FullCastSpellOnTarget(40368, plr)
 end
end

function ertgagaMogash_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function ertgagaMogash_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

RegisterUnitEvent(262622, 1, "ertgagaMogash_OnCombat")
RegisterUnitEvent(262622, 2, "ertgagaMogash_OnLeave")
RegisterUnitEvent(262622, 4, "ertgagaMogash_OnDead")

-- Fire elemental


function zzOmen_OnCombat(pUnit, Event)
 if pUnit:GetClosestPlayer() == nil then
 else
 pUnit:FullCastSpellOnTarget(35853, pUnit:GetClosestPlayer())
 end
 pUnit:RegisterEvent("zzOmen_Moonfire", 7500, 0)
end

function zzOmen_Moonfire(pUnit, Event)
 if pUnit:GetClosestPlayer() == nil then
 else
 pUnit:FullCastSpellOnTarget(35853, pUnit:GetClosestPlayer())
 end
end

function zzOmen_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function zzOmen_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

RegisterUnitEvent(46071, 1, "zzOmen_OnCombat")
RegisterUnitEvent(46071, 2, "zzOmen_OnLeave")
RegisterUnitEvent(46071, 4, "zzOmen_OnDead")


-- Gorthon


function gagaMogash_OnCombat(pUnit, Event)
 pUnit:RegisterEvent("gagaMogash_Frostbolt", 8001, 0)
 pUnit:RegisterEvent("Mogash_TimeZone", 4000, 0)
end

function gagaMogash_Frostbolt(pUnit, Event)
 local plr = pUnit:GetClosestPlayer()
 if plr == nil then
 else
 pUnit:FullCastSpellOnTarget(1106, plr)
 end
end

function Mogash_TimeZone(pUnit, Event)
 local plr = pUnit:GetRandomPlayer(0)
 if plr == nil then
 else
 pUnit:FullCastSpellOnTarget(40951, plr)
 end
end

function gagaMogash_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function gagaMogash_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

RegisterUnitEvent(80007, 1, "gagaMogash_OnCombat")
RegisterUnitEvent(80007, 2, "gagaMogash_OnLeave")
RegisterUnitEvent(80007, 4, "gagaMogash_OnDead")


-- GrimGuzzler


function fzzOmen_OnCombat(pUnit, Event)
 pUnit:SendChatMessage(12,0,"You think you can take me eh?")
 pUnit:RegisterEvent("Spin_Casttime_delay", 10000, 0)
 pUnit:RegisterEvent("Spin_Casttime_delay_B", 5000, 0)
 pUnit:RegisterEvent("Spin_Casttime_delay_Z", 7500, 0)
 pUnit:RegisterEvent("enrage_dude_enrage", 30250, 0)
end

function Spin_Casttime_delay(pUnit, Event)
   pUnit:CastSpell(45385)
end

function Spin_Casttime_delay_B(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr == nil then
	else
	pUnit:CastSpellOnTarget(35853, plr)
	end
end

function Spin_Casttime_delay_Z(pUnit, Event)
	pUnit:CastSpell(8349)
end

function enrage_dude_enrage(pUnit, Event)
	pUnit:FullCastSpell(48193)
end

function fzzOmen_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
 pUnit:SendChatMessage(12,0,"That's what I thought.")
end

function fzzOmen_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
 pUnit:SendChatMessage(14,0,"No wait! I surrender! Ar-")
end

RegisterUnitEvent(39541, 1, "fzzOmen_OnCombat")
RegisterUnitEvent(39541, 2, "fzzOmen_OnLeave")
RegisterUnitEvent(39541, 4, "fzzOmen_OnDead")

-- Magma Golem

function qrzzColusn_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

function qrzzColusn_OnSpawn(pUnit, Event)
	pUnit:SetUInt32Value(59, 2)
 pUnit:RegisterEvent("test_z_Z_Z_g", 1000, 1)
end

function test_z_Z_Z_g(pUnit, Event)
	pUnit:RegisterEvent("BreathFire_Tehe_Z_t_H", 3000, 0)
end

function BreathFire_Tehe_Z_t_H(pUnit, Event)
	if math.random(1,2) == 1 then
	pUnit:CastSpell(36921)
	end
end

RegisterUnitEvent(138691, 4, "qrzzColusn_OnDead")
RegisterUnitEvent(138691, 18, "qrzzColusn_OnSpawn")


-- MolternColusus


function zzColusn_OnCombat(pUnit, Event)
 pUnit:RegisterEvent("zzSizecheck_A", 2000, 0)
end

function zzSizecheck_A(pUnit, Event)
	if pUnit:GetHealthPct() < 90 then
	pUnit:RemoveEvents()
	pUnit:SetScale(0.9)
	pUnit:RegisterEvent("zzSizecheck_B", 2000, 0)
	end
end

function zzSizecheck_B(pUnit, Event)
	if pUnit:GetHealthPct() < 80 then
	pUnit:RemoveEvents()
	pUnit:SetScale(0.8)
	pUnit:RegisterEvent("zzSizecheck_C", 2000, 0)
	end
end

function zzSizecheck_C(pUnit, Event)
	if pUnit:GetHealthPct() < 70 then
	pUnit:RemoveEvents()
	pUnit:SetScale(0.7)
	pUnit:RegisterEvent("zzSizecheck_D", 2000, 0)
	end
end

function zzSizecheck_D(pUnit, Event)
	if pUnit:GetHealthPct() < 60 then
	pUnit:RemoveEvents()
	pUnit:SetScale(0.6)
	pUnit:RegisterEvent("zzSizecheck_E", 2000, 0)
	end
end

function zzSizecheck_E(pUnit, Event)
	if pUnit:GetHealthPct() < 50 then
	pUnit:RemoveEvents()
	pUnit:SetScale(0.5)
	pUnit:RegisterEvent("zzSizecheck_F", 2000, 0)
	end
end

function zzSizecheck_F(pUnit, Event)
	if pUnit:GetHealthPct() < 40 then
	pUnit:RemoveEvents()
	pUnit:SetScale(0.4)
	pUnit:RegisterEvent("zzSizecheck_G", 2000, 0)
	end
end

function zzSizecheck_G(pUnit, Event)
	if pUnit:GetHealthPct() < 30 then
	pUnit:RemoveEvents()
	pUnit:SetScale(0.3)
	pUnit:RegisterEvent("zzSizecheck_H", 2000, 0)
	end
end

function zzSizecheck_H(pUnit, Event)
	if pUnit:GetHealthPct() < 20 then
	pUnit:RemoveEvents()
	pUnit:SetScale(0.2)
	pUnit:RegisterEvent("zzSizecheck_I", 2000, 0)
	end
end

function zzSizecheck_I(pUnit, Event)
	if pUnit:GetHealthPct() < 10 then
	pUnit:RemoveEvents()
	pUnit:SetScale(0.1)
	end
end

function zzColusn_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function zzColusn_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

function zzColusn_OnSpawn(pUnit, Event)
 pUnit:SetScale(1)
end

RegisterUnitEvent(34069, 1, "zzColusn_OnCombat")
RegisterUnitEvent(34069, 2, "zzColusn_OnLeave")
RegisterUnitEvent(34069, 4, "zzColusn_OnDead")
RegisterUnitEvent(34069, 18, "zzColusn_OnSpawn")


-- SEcond boss

function Boss_Dude_On_Gossip(pUnit, event, player)
   pUnit:GossipCreateMenu(511235, player, 0)
	pUnit:GossipMenuAddItem(9, "I have come to destroy you!", 246, 0)
   pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
   pUnit:GossipSendMenu(player)
end


function Boss_Dude_Gossip_Submenus(pUnit, event, player, id, intid, code)
if(intid == 246) then
  local name = player:GetName()
  pUnit:SendChatMessage(14,0,"Prepare for oblivion "..name.."!")
  pUnit:SetFaction(21)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		plr:SetPhase(3)
	end
end
if(intid == 250) then
	player:GossipComplete()
end
end

function Boss_Dude_OnSpawn(pUnit, Event)
	pUnit:SetFaction(15)
end

RegisterUnitGossipEvent(83291, 1, "Boss_Dude_On_Gossip")
RegisterUnitGossipEvent(83291, 2, "Boss_Dude_Gossip_Submenus")
RegisterUnitEvent(83291, 18, "Boss_Dude_OnSpawn")

local Count = 0

function Boss_Dude_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("StartSpawningAddsAtThePeoplesLocations", 2500, 0)
end

function StartSpawningAddsAtThePeoplesLocations(pUnit, Event)
	local plr = pUnit:GetRandomPlayer(0)
	if plr == nil then
	Count = Count + 1
		if Count == 3 then
		pUnit:RemoveEvents()
		end
	else
	local x = plr:GetX()
	local y = plr:GetY()
	local z = plr:GetZ()
	local o = plr:GetO()
	pUnit:SpawnCreature(288141, x, y, z, o, 15, 10000)
	end
end

function zzBoss_Dude_OnLeave(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:SetFaction(15)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		plr:SetPhase(1)
	end
	Count = 0
end

function zzBoss_Dude_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		plr:SetPhase(1)
	end
	Count = 0
end

RegisterUnitEvent(83291, 1, "Boss_Dude_OnCombat")
RegisterUnitEvent(83291, 2, "zzBoss_Dude_OnLeave")
RegisterUnitEvent(83291, 4, "zzBoss_Dude_OnDead")

function YoggSaronsMinions_OnSpawn(pUnit, Event)
	pUnit:RegisterEvent("TestRootFunctionNextSecond", 1, 1)
end

function TestRootFunctionNextSecond(pUnit, Event)
	pUnit:Emote(449, 3000)
	pUnit:Root()
	pUnit:RegisterEvent("SetFactionToHostileForThesetentaclEs", 3500, 1)
end

function SetFactionToHostileForThesetentaclEs(pUnit, Event)
	pUnit:SetFaction(21)
end

RegisterUnitEvent(288141, 18, "YoggSaronsMinions_OnSpawn")

-- Last Boss

local BRD_A = nil
local BRD_B = nil
local BRD_C = nil
local BRD_D = nil
local Exile = nil
local Boss = nil
local Count = 0


function Last_Boss_BRD_A_OnSpawn(pUnit, Event)
	pUnit:SetFaction(35)
	BRD_A = pUnit
end

RegisterUnitEvent(88031, 18, "Last_Boss_BRD_A_OnSpawn") -- Warrior

function Last_Boss_BRD_B_OnSpawn(pUnit, Event)
	pUnit:SetFaction(35)
	BRD_B = pUnit
end

RegisterUnitEvent(88032, 18, "Last_Boss_BRD_B_OnSpawn") -- Warrior

function Last_Boss_BRD_C_OnSpawn(pUnit, Event)
	pUnit:SetFaction(35)
	BRD_C = pUnit
end

RegisterUnitEvent(88033, 18, "Last_Boss_BRD_C_OnSpawn") -- Caster

function Last_Boss_BRD_D_OnSpawn(pUnit, Event)
	pUnit:SetFaction(35)
	BRD_D = pUnit
end

RegisterUnitEvent(88034, 18, "Last_Boss_BRD_D_OnSpawn") -- Caster

function Last_Boss_BRD_E_OnSpawn(pUnit, Event)
	pUnit:RegisterEvent("Wait_A_Sec_Zojgheozxjp_Boss", 2500, 1)
	Exile = pUnit
end

function Wait_A_Sec_Zojgheozxjp_Boss(pUnit, Event)
	if Boss ~= nil then
	Boss:RemoveEvents()
	Boss:RemoveFromWorld()
	end
	pUnit:SpawnCreature(9019, 1380, -834, -85, 1, 35, 0)
end

RegisterUnitEvent(12515, 18, "Last_Boss_BRD_E_OnSpawn") -- Exile

----------------------------------------------------------------------

function Last_Boss_Main_OnSpawn(pUnit, Event)
	pUnit:SetFaction(35)
	pUnit:MoveTo(1380.47, -831.56, -87.5, 1.558369)
	pUnit:EquipWeapons(11684,0,0)
	pUnit:RegisterEvent("checker_for_executioner_dude", 5000, 0)
	Boss = pUnit
end

RegisterUnitEvent(9019, 18, "Last_Boss_Main_OnSpawn")

----------------------------------------------------------------------

function checker_for_executioner_dude(pUnit, Event)
	local plr = Exile:GetClosestPlayer()
	if plr == nil then
	else
		local dist = Exile:GetDistanceYards(plr)
		if dist < 5 then
		pUnit:EquipWeapons(11684,0,0)
		pUnit:SendChatMessage(12,0,"I here by sentance this dwarf to capital punishment.")
		pUnit:FullCastSpellOnTarget(42891, Exile)
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Dwarf_now_dies_lololol", 4000, 1)
		else
			if math.random(1,6) == 3 then
				if math.random(1,2) == 1 then
				Exile:SendChatMessage(15,0,"Please.. Come to me.. Save me if you can.. Help me up!")
				else
				Exile:SendChatMessage(12,0,"I'm innocent!")
				end
			end
		end
	end
end

function Dwarf_now_dies_lololol(pUnit, Event)
	Exile:SendChatMessage(14,0,"No, please!")
	pUnit:RegisterEvent("DEBUG_DESPAWN_boss_last", 3500, 1)
end

function DEBUG_DESPAWN_boss_last(pUnit, Event)
	Exile:Despawn(1,0)
	pUnit:SendChatMessage(12,0,"Ah, we have visitors. Chancellor, deal with them.")
	pUnit:Emote(1,4000)
	pUnit:RegisterEvent("ohai_a_chancellor_attacks", 4500, 1)
end

function ohai_a_chancellor_attacks(pUnit, Event)
	BRD_A:SendChatMessage(14,0,"For the Emperor!")
	BRD_A:SetFaction(21)
	BRD_D:SetFaction(21)
	local plr = BRD_A:GetClosestPlayer()
	if plr ~= nil then
	BRD_A:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO())
	end
	local plrz = BRD_D:GetClosestPlayer()
	if plrz ~= nil then
	BRD_D:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO())
	end
	pUnit:RegisterEvent("Health_checkers_Chancellors", 4000, 0)
end

function Health_checkers_Chancellors(pUnit, Event)
	if BRD_D:IsAlive() == true then
		local target = BRD_D:GetClosestPlayer()
		if target ~= nil then
		BRD_D:FullCastSpellOnTarget(35853, target)
		end
	else
		if BRD_A:IsAlive() == true then
		else
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("MORE_GUARDS_MORE_LAST_boss", 1000, 1)
		end
	end
end

function MORE_GUARDS_MORE_LAST_boss(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Chanellors, do not fail me as the last did.")
	pUnit:Emote(1, 4000)
	pUnit:RegisterEvent("Tehe_Zoighesaopioah", 4500, 1)
end

function Tehe_Zoighesaopioah(pUnit, Event)
	BRD_B:SendChatMessage(14,0,"Die!")
	BRD_B:SetFaction(21)
	BRD_C:SetFaction(21)
	local plr = BRD_C:GetClosestPlayer()
	if plr ~= nil then
	BRD_C:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO())
	end
	local plrz = BRD_B:GetClosestPlayer()
	if plrz ~= nil then
	BRD_B:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO())
	end
	pUnit:RegisterEvent("Health_checkers_Chancellors_Z", 4000, 0)
end

function Health_checkers_Chancellors_Z(pUnit, Event)
	if BRD_C:IsAlive() == true then
		local target = BRD_C:GetClosestPlayer()
		if target ~= nil then
		BRD_C:FullCastSpellOnTarget(35853, target)
		end
	else
		if BRD_B:IsAlive() == true then
		else
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("MORE_GUARDS_MORE_LAST_boss_Z", 2500, 1)
		end
	end
end

function MORE_GUARDS_MORE_LAST_boss_Z(pUnit, Event)
	pUnit:SendChatMessage(12,0,"Pathetic! Looks like I will have to deal with you myself.")
	pUnit:Emote(1,4000)
	pUnit:RegisterEvent("OK_BOSS_IS_ATTACKING_OH_SHI", 5000, 1)
end

function OK_BOSS_IS_ATTACKING_OH_SHI(pUnit, Event)
	pUnit:SetFaction(21)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
	pUnit:FullCastSpellOnTarget(41959, plr)
	end
end

-----------------------------------------------------------

function Last_Boss_Main_OnLeave(pUnit, Event)
	pUnit:RemoveEvents()
end

function Last_Boss_Main_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function Last_Boss_Main_OnCombat(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("Delay_A_Sek_LAST_BOSS", 2500, 1)
end

RegisterUnitEvent(9019, 1, "Last_Boss_Main_OnCombat")
RegisterUnitEvent(9019, 2, "Last_Boss_Main_OnLeave")
RegisterUnitEvent(9019, 4, "Last_Boss_Main_OnDead")

function Delay_A_Sek_LAST_BOSS(pUnit, Event)
	pUnit:RegisterEvent("zSpin_Casttime_delay", 10000, 0)
	pUnit:RegisterEvent("zSpin_Casttime_delay_B", 4500, 0)
	pUnit:RegisterEvent("zSpin_Casttime_delay_Z", 7000, 0)
	pUnit:RegisterEvent("zSpin_Casttime_delay_C", 1000, 0)
end

function zSpin_Casttime_delay(pUnit, Event)
   pUnit:CastSpell(45385)
end

function zSpin_Casttime_delay_B(pUnit, Event)
	local plr = pUnit:GetClosestPlayer()
	if plr == nil then
	else
	pUnit:CastSpellOnTarget(35853, plr)
	end
end

function zSpin_Casttime_delay_Z(pUnit, Event)
	pUnit:CastSpell(8349)
end

function zSpin_Casttime_delay_C(pUnit, Event)
	if pUnit:GetHealthPct() < 50 then
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(12,0,"The demons! They burn within my mind.. For kil'jaeden")
	pUnit:CastSpell(34602)
	pUnit:CastSpell(39180)
	pUnit:RegisterEvent("zSpin_Casttime_delay", 10000, 0)
	pUnit:RegisterEvent("zSpin_Casttime_delay_B", 4500, 0)
	pUnit:RegisterEvent("zSpin_Casttime_delay_Z", 7000, 0)
	end
end

-----------------------------------------------------------
