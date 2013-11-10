--[[ Put all your trash mobs here :D ]]--

-- Script variables

OBJECT_END = 0x0006
UNIT_FIELD_FLAGS = OBJECT_END + 0x0035
UNIT_FLAG_NOT_SELECTABLE = 0x02000000
UNIT_FLAG_DEFAULT = 0X00
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044

-- Orc Prisoners kneel

function spirit_spawn_on_orc_died(pUnit, Event)
	if Event == 18 then
		pUnit:SetUInt32Value(UNIT_FIELD_BYTES_1, 8)
	else
		pUnit:SpawnCreature(174581, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 2, 60000)
	end
end

RegisterUnitEvent(18598, 4, "spirit_spawn_on_orc_died")
RegisterUnitEvent(18598, 18, "spirit_spawn_on_orc_died")

---------------- Flamescale Wyrmkin ----------------

function FlamescaleWyrm_OnCombat(pUnit, Event)
 pUnit:RegisterEvent("FlamescaleWyrm_Fireball", 4500, 0)
end

function FlamescaleWyrm_Fireball(pUnit, Event)
 if pUnit:GetMainTank() == nil then
 else
 pUnit:FullCastSpellOnTarget(7799, pUnit:GetMainTank())
 end
end

function FlamescaleWyrm_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function FlamescaleWyrm_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

RegisterUnitEvent(50006, 1, "FlamescaleWyrm_OnCombat")
RegisterUnitEvent(50006, 2, "FlamescaleWyrm_OnLeave")
RegisterUnitEvent(50006, 4, "FlamescaleWyrm_OnDead")

-----------------------------------------------------

---------------- Red Drake --------------------------

function zFlamescaleWyrm_OnCombat(pUnit, Event)
 pUnit:FullCastSpell(37638)
 pUnit:RegisterEvent("zFlamescaleWyrm_Fireball", 10000, 0)
end

function zFlamescaleWyrm_Fireball(pUnit, Event)
 pUnit:FullCastSpell(37638)
end

function zFlamescaleWyrm_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function zFlamescaleWyrm_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

RegisterUnitEvent(258275, 1, "zFlamescaleWyrm_OnCombat")
RegisterUnitEvent(258275, 2, "zFlamescaleWyrm_OnLeave")
RegisterUnitEvent(258275, 4, "zFlamescaleWyrm_OnDead")

-----------------------------------------------------

---------------- Corrupt Druid ----------------------

function zzFlamescaleWyrm_OnSpawn(pUnit, Event)
	pUnit:RegisterEvent("Delay_A_Second_Tehesohjps", 1000, 1)
end

function Delay_A_Second_Tehesohjps(pUnit, Event)
	if math.random(1,2) == 1 then
	pUnit:SetModel(29430)
	pUnit:CastSpell(27123)
	else
	pUnit:SetModel(29429)
	pUnit:CastSpell(27123)
	end
end

function zzFlamescaleWyrm_OnLeave(pUnit, Event)
	if math.random(1,2) == 1 then
	pUnit:SetModel(29430)
	pUnit:CastSpell(27123)
	else
	pUnit:SetModel(29429)
	pUnit:CastSpell(27123)
	end
end

function zzFlamescaleWyrm_OnCombat(pUnit, Event)
	if math.random(1,2) == 1 then
	pUnit:SetModel(29418)
	pUnit:CastSpell(27123)
	else
	pUnit:SetModel(29412)
	pUnit:CastSpell(27123)
	end
end

RegisterUnitEvent(258279, 1, "zzFlamescaleWyrm_OnCombat")
RegisterUnitEvent(258279, 2, "zzFlamescaleWyrm_OnLeave")
RegisterUnitEvent(258279, 18, "zzFlamescaleWyrm_OnSpawn")

-----------------------------------------------------

--------------- Necromancer  ------------------------

--Moved to zzzWarlockCrystal.lua
--[[
function zfFlamescaleWyrm_OnCombat(pUnit, Event)
 pUnit:RegisterEvent("zfFlamescaleWyrm_Fireball", 8000, 0)
end

function zfFlamescaleWyrm_Fireball(pUnit, Event)
 local plr = pUnit:GetClosestPlayer()
 if plr == nil then
 else
 pUnit:FullCastSpellOnTarget(695, plr)
 end
end

function zfFlamescaleWyrm_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function zfFlamescaleWyrm_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

RegisterUnitEvent(326211, 1, "zfFlamescaleWyrm_OnCombat")
RegisterUnitEvent(326211, 2, "zfFlamescaleWyrm_OnLeave")
RegisterUnitEvent(326211, 4, "zfFlamescaleWyrm_OnDead")]]--

-----------------------------------------------------

------------------- Dead Ogre -----------------------

function DeadOgre_OnSpawn(pUnit, Event)
 pUnit:RegisterEvent("DeadOgre_SetTheFlags", 500, 1)
end

function DeadOgre_SetTheFlags(pUnit, Event)
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(50018, 18, "DeadOgre_OnSpawn")

-----------------------------------------------------

------------------- Mogash -----------------------
--[[
function Mogash_OnCombat(pUnit, Event)
 pUnit:RegisterEvent("Mogash_Frostbolt", 8000, 0)
end

function Mogash_Frostbolt(pUnit, Event)
 local plr = pUnit:GetClosestPlayer()
 if plr == nil then
 else
 pUnit:FullCastSpellOnTarget(116, plr)
 end
end

function Mogash_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function Mogash_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

RegisterUnitEvent(50015, 1, "Mogash_OnCombat")
RegisterUnitEvent(50015, 2, "Mogash_OnLeave")
RegisterUnitEvent(50015, 4, "Mogash_OnDead")]]

------------------- Dead Orc ------------------------

function zdhDeadOgre_OnSpawn(pUnit, Event)
 pUnit:RegisterEvent("zdhDeadOgre_SetTheFlags", 500, 1)
end

function zdhDeadOgre_SetTheFlags(pUnit, Event)
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(31416, 18, "zdhDeadOgre_OnSpawn")

-----------------------------------------------------

------------------- Some dude -----------------------
--[[
function rsjhMogash_OnCombat(pUnit, Event)
 pUnit:RegisterEvent("rsjhMogash_Frostbolt", 5000, 0)
end

function rsjhMogash_Frostbolt(pUnit, Event)
 local plr = pUnit:GetClosestPlayer()
 if plr == nil then
 else
 pUnit:FullCastSpellOnTarget(16403, plr)
 end
end

function rsjhMogash_OnLeave(pUnit, Event)
 pUnit:RemoveEvents()
end

function rsjhMogash_OnDead(pUnit, Event)
 pUnit:RemoveEvents()
end

RegisterUnitEvent(50020, 1, "rsjhMogash_OnCombat")
RegisterUnitEvent(50020, 2, "rsjhMogash_OnLeave")
RegisterUnitEvent(50020, 4, "rsjhMogash_OnDead") ]]

------------------- Ogre Pinata -------------------

function zzzrsjhMogash_OnCombat(pUnit, Event)
	pUnit:Root()
end

RegisterUnitEvent(293091, 1, "zzzrsjhMogash_OnCombat")

------------------- Ghostly Skull -----------------

function rzdhDeadOgre_OnSpawn(pUnit, Event)
 pUnit:RegisterEvent("rzdhDeadOgre_SetTheFlags", 500, 1)
end

function rzdhDeadOgre_SetTheFlags(pUnit, Event)
 pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(29147, 18, "rzdhDeadOgre_OnSpawn")

-----------------Energised Crystal-----------------

function energised_crystal_onGossip(pUnit,Event,plr)
	pUnit:GossipCreateMenu(1218, plr, 0)
	if plr:HasQuest(550) then
		if plr:HasAura(47740) then
			pUnit:GossipMenuAddItem(0, "I need to return.", 51, 0)
		else
			pUnit:GossipMenuAddItem(0, "Can you share your vision once more?", 57, 0)
		end
	end
	pUnit:GossipAddQuests(plr) 
    pUnit:GossipSendMenu(plr)
end

function energised_crystal_onSelect(pUnit, event, plr, id, intid, code)
	if (intid == 51) then
		plr:GossipComplete()
		plr:RemoveAura(47740)
	else
		plr:GossipComplete()
		plr:CastSpell(47740)
	end
end

RegisterUnitGossipEvent(116591, 1, "energised_crystal_onGossip")
RegisterUnitGossipEvent(116591, 2, "energised_crystal_onSelect")