local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074
local UNIT_FLAG_STUNNED = 0x00040000

function ARROWS_DUMMY(pUnit)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:SetScale(.1)
end

RegisterUnitEvent(6820, 18, "ARROWS_DUMMY")

function SunArchers_SpellEffects(pUnit,Event)
	pUnit:RegisterEvent("SunArchers_Effect",  math.random(1500, 3000), 0)
end

function SunArchers_Effect(pUnit)
	for _,enemy in pairs(pUnit:GetInRangeUnits()) do
		if enemy:GetEntry() == 6820 and pUnit:GetDistanceYards(enemy) < 205 then
			if enemy then
				if enemy:IsInPhase(2) == true then
					pUnit:FullCastSpellOnTarget(54405,enemy)
				end
			end
		end
	end
end

RegisterUnitEvent(25662, 18, "SunArchers_SpellEffects")

function Ballista_SpellEffects(pUnit,Event)
	pUnit:RegisterEvent("Ballista_Efx",  math.random(5000, 8000), 0)
end

function Ballista_Efx(pUnit)
	for _,enemy in pairs(pUnit:GetInRangeUnits()) do
		if enemy:GetEntry() == 6820 and pUnit:GetDistanceYards(enemy) < 205 then
			if enemy then
				if enemy:IsInPhase(2) == true then
					pUnit:CastSpellOnTarget(53117,enemy)
				end
			end
		end
	end
end



RegisterUnitEvent(259151, 18, "Ballista_SpellEffects")

function DMountaineer_RandomOrders(pUnit,Event)
	local choice = math.random(1,5)
	if choice == 1 then
		pUnit:SendChatMessage(14,0,"Riflemen, shoot faster!")
		pUnit:PlaySoundToSet(16954)
		pUnit:Emote(5,2000)
	elseif choice == 2 then
		pUnit:SendChatMessage(14,0,"Mortar team, reload!")
		pUnit:PlaySoundToSet(16955)
		pUnit:Emote(5,2000)
	elseif choice == 3 then
		pUnit:SendChatMessage(14,0,"Marines, Sergeants, attack!")
		pUnit:PlaySoundToSet(16956)
		pUnit:Emote(5,2000)
	end
	pUnit:RegisterEvent("DMountaineer_RandomOrders", math.random(15000, 25000), 1)
end

function Dokkin_spawn_thandol(pUnit,Event)
	pUnit:CastSpell(63514)
	pUnit:RegisterEvent("DMountaineer_RandomOrders", 5000, 1)
end

RegisterUnitEvent(15440,18, "Dokkin_spawn_thandol")


----BOSS SCRIPT----
function Miralis_Events(pUnit,Event,pVictim)
	if Event == 1 then
	--pUnit:RegisterEvent("Imposing_Explosion", math.random(15000, 30000), 1)
	--pUnit:RegisterEvent("Miralis_Roar", math.random(32000, 38000), 1)
	--pUnit:RegisterEvent("Miralis_Frostbreath", math.random(20000, 25000), 1)
	elseif Event == 3 then
		pUnit:SetHealth(pUnit:GetHealth()+10000)
		if math.random(1,2) == 1 then
			pUnit:SendChatMessage(14, 0, "DIE IN DARKNESS!")
			pUnit:PlaySoundToSet(18187)
		else
			pUnit:SendChatMessage(14, 0, "THE NIGHT SURROUNDS YOU!")
			pUnit:PlaySoundToSet(18188)
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		for _,creatures in pairs(Squadleader:GetInRangeUnits()) do
			if creatures:GetEntry() == 6820 and Squadleader:GetDistanceYards(creatures) < 150 then
				creatures:Despawn(2000,0)
			end
		end
	end
end

function Imposing_Explosion(pUnit,Event)
	pUnit:CastSpell(76010)
	for _, enemies in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(enemies) < 40 then
			if enemies:IsInPhase(3) then
				pUnit:Strike(enemies,1,69508,400,660,2)
				enemies:CastSpell(54899)
			end
		end
	end
	pUnit:RegisterEvent("Imposing_Explosion", math.random(15000, 30000), 1)
end

function Miralis_Frostbreath(pUnit,Event)
	pUnit:FullCastSpell(3131)
	pUnit:RegisterEvent("Miralis_Frostbreath", math.random(20000, 25000), 1)
end

function Miralis_Roar(pUnit,Event)
	pUnit:CastSpell(56748)
	pUnit:RegisterEvent("Miralis_Roar", math.random(32000, 38000), 1)
end

RegisterUnitEvent(900212, 1, "Miralis_Events")
RegisterUnitEvent(900212, 4, "Miralis_Events")
RegisterUnitEvent(900212, 3, "Miralis_Events")


---EVENTS--