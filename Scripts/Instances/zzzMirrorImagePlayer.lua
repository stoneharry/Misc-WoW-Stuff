local PlayerClassToInt = {["Warrior"] = 1, ["Paladin"] = 2, ["Hunter"] = 3, ["Rogue"] = 4, ["Priest"] = 5,
["Death Knight"] = 6, ["Shaman"] = 7, ["Mage"] = 8, ["Warlock"] = 9, ["Druid"] = 11, ["Demon Hunter"] = 12}

local RaceDisplayMap = {
	{49, 50}, {51, 52}, {53, 54}, {55, 56}, {57, 58},
	{59, 60}, {1563, 1564}, {1478, 1479}, {6894, 6895}, {15476, 15475},
	{16125, 16126}, {16981, 16980}, {17402, 17403}, {17576,
	17577}, {17578, 17579}, {21685, 21686}, {21780,21780},{21963,
	21964}, {26316, 26317}, {26871, 26872}, {26873, 26874}
};

function DisplaySetDelay(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if not plr then
		return
	end
	if plr:GetGender() == 0 then
		plr:RemoveAura(35480)
	else
		plr:RemoveAura(35481)
	end
	local model = RaceDisplayMap[plr:GetPlayerRace()][plr:GetGender()+1]
	if not model then
		model = plr:GetDisplay()
	end
	pUnit:SetModel(model)
end

function MirrorSpawnImage165(pUnit, Event)
	if Event == 18 then
		pUnit:SetUInt32Value(0x0006 + 0x0035, 0x02000000) 
		pUnit:RegisterEvent("DisplaySetDelay", 600, 1)
		pUnit:RegisterEvent("Wait_A_Second_Then_Update_Mirrorimage", 1000, 1)
	elseif Event == 4 then
		pUnit:RemoveEvents()
	elseif Event == 1 then
		local class = pUnit:GetValue("class")
		if class == "Warrior" then
			local plr = pUnit:GetMainTank()
			if plr then
				pUnit:FullCastSpellOnTarget(41581, plr) -- charge0
			end
			pUnit:RegisterEvent("ThunderClapEtc", 6000, 0)
		elseif class == "Paladin" then
			--pUnit:FullCastSpell(20217) -- blessing of kings
			pUnit:RegisterEvent("HealPeoplePaladin", 5000, 0)
		elseif class == "Hunter" then
			pUnit:RegisterEvent("HunterAIEtc", 2500, 0)
		elseif class == "Rogue" then
			pUnit:RegisterEvent("RogueAIEtc", 2500, 0)
		elseif class == "Priest" then
			pUnit:RegisterEvent("PriestAIEtc", 1000, 0)
		elseif class == "Shaman" then
			pUnit:RegisterEvent("ShamanAIEtc", 5000, 0)
		elseif class == "Mage" then
			pUnit:RegisterEvent("MageAIEtc", 3000, 0)
		elseif class == "Warlock" then
			pUnit:RegisterEvent("WarlockAIEtc", 1000, 0)
		elseif class == "Druid" then
			pUnit:RegisterEvent("DruidAIEtc", 1000, 0)
		elseif class == "Demon Hunter" then
			pUnit:RegisterEvent("DemonAIEtc", 2500, 0)
			pUnit:FullCastSpell(50046)
		end		
	end
end

function WarlockAIEtc(pUnit)
	if pUnit:IsCasting() then
		return
	end
	local plr = pUnit:GetMainTank()
	if not plr then
		return
	end
	if not pUnit:HasAura(696) then
		pUnit:FullCastSpell(696)
		return
	end
	if not plr:HasAura(1094) then
		pUnit:FullCastSpellOnTarget(1094, plr) -- immolate
		return
	end
	if not plr:HasAura(6223) then
		pUnit:FullCastSpellOnTarget(6223, plr) -- affliction
		return
	end
	if not plr:HasAura(1014) then
		pUnit:FullCastSpellOnTarget(1014, plr) -- curse of agony
		return
	end
	local chance = math.random(1,3)
	if chance == 1 then
		pUnit:FullCastSpellOnTarget(1088, plr) -- shadowbolt
	elseif chance == 2 then
		pUnit:FullCastSpellOnTarget(5676, plr) -- searing pain
	elseif chance == 3 then
		pUnit:FullCastSpellOnTarget(709, plr) -- drain life
	end
end

function MageAIEtc(pUnit)
	if pUnit:IsCasting() then
		return
	end
	if not pUnit:HasAura(7302) then
		pUnit:FullCastSpell(7302)
		return
	end
	local plr = pUnit:GetMainTank()
	if not plr then
		return
	end
	local chance = math.random(1,5)
	if chance == 1 then
		pUnit:FullCastSpellOnTarget(51103, plr) -- frostbomb
	elseif chance == 2 then
		pUnit:FullCastSpellOnTarget(8406, plr) -- frostbolt
	elseif chance == 3 then
		pUnit:FullCastSpellOnTarget(8401, plr) -- fireball
	elseif chance == 4 then
		pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 2121) -- flamestrike
	elseif chance == 5 then
		pUnit:FullCastSpellOnTarget(5145, plr) -- arcane missiles
	end
end

function RejuvinateDruid(pUnit)
	pUnit:CastSpell(9840)
end

function DruidAIEtc(pUnit)
	if pUnit:IsCasting() then
		return
	end
	if pUnit:GetHealthPct() < 75 and math.random(1,2) == 1 then
		pUnit:FullCastSpell(8938)
		pUnit:RegisterEvent("RejuvinateDruid", 3050, 1)
		return
	end
	--[[if not pUnit:HasAura(6756) then
		pUnit:FullCastSpell(6756)
	end]]
	local plr = pUnit:GetMainTank()
	if not plr then
		return
	end
	local chance = math.random(1,3)
	if chance == 1 then
		pUnit:FullCastSpellOnTarget(2912, plr) -- starfire
	elseif chance == 2 then
		pUnit:FullCastSpellOnTarget(8926, plr) -- moonfire
	elseif chance == 3 then
		pUnit:FullCastSpellOnTarget(5179, plr) -- wrath
	end
end

function ShamanAIEtc(pUnit)
	if pUnit:IsCasting() then
		return
	end
	if pUnit:GetHealthPct() < 60 and math.random(1,2) == 1 then
		pUnit:FullCastSpell(1064)
		return
	end
	if not pUnit:HasAura(325) then
		pUnit:FullCastSpell(325)
	end
	local plr = pUnit:GetMainTank()
	if not plr then
		return
	end
	local chance = math.random(1,3)
	if chance == 1 then
		pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 50068)
	elseif chance == 2 then
		pUnit:FullCastSpellOnTarget(421, plr) -- chain lightning
	elseif chance == 3 then
		pUnit:FullCastSpellOnTarget(8045, plr) -- earth shock
	end
end

function PriestAIEtc(pUnit)
	if pUnit:IsCasting() then
		return
	end
	if pUnit:GetHealthPct() < 75 and math.random(1,2) == 1 then
		pUnit:FullCastSpell(1026)
		return
	end
	for _,v in pairs(pUnit:GetInRangeFriends()) do
		if v:GetDistanceYards(pUnit) < 30 and v:GetHealthPct() < 75 then
			pUnit:FullCastSpellOnTarget(1026, v)
			return
		end
	end
	--[[if not (pUnit:HasAura(21084)) then
		pUnit:FullCastSpell(21084)
		return
	end]]
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(15238, plr)
	end
end

function HealPeoplePaladin(pUnit)
	if pUnit:IsCasting() then
		return
	end
	if pUnit:GetHealthPct() < 75 and math.random(1,2) == 1 then
		pUnit:FullCastSpell(2055)
		return
	end
	for _,v in pairs(pUnit:GetInRangeFriends()) do
		if v:GetDistanceYards(pUnit) < 30 and v:GetHealthPct() < 50 then
			pUnit:FullCastSpellOnTarget(2055, v)
			return
		end
	end
	--[[if not (pUnit:HasAura(1245)) then
		pUnit:FullCastSpell(1245)
		return
	end]]
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(15262, plr)
	end
end

function HunterAIEtc(pUnit)
	local plr = pUnit:GetMainTank()
	if not plr then
		return
	end
	if plr:GetDistanceYards(pUnit) > 30 then
		pUnit:Unroot()
		return
	else
		pUnit:Root()
	end
	local chance = math.random(1,2)
	if chance == 1 then
		pUnit:FullCastSpellOnTarget(14282, plr) -- arcane shot
	elseif chance == 2 then
		pUnit:FullCastSpellOnTarget(14443, plr) -- multi-shot
	end
end

function RogueAIEtc(pUnit)
	local plr = pUnit:GetMainTank()
	if not plr then
		return
	end
	if math.random(1,6) == 1 then
		pUnit:CastSpell(31224)
	elseif math.random(1,6) == 1 then
		pUnit:FullCastSpellOnTarget(72335, plr)
	end
	pUnit:FullCastSpellOnTarget(8621, plr) -- sinister strike
end

function DemonAIEtc(pUnit)
	local plr = pUnit:GetMainTank()
	if not plr then
		return
	end
	if pUnit:GetHealthPct() < 30 then
		pUnit:FullCastSpell(33247) -- heal
		return
	end
	if math.random(1,3) == 1 then
		pUnit:FullCastSpellOnTarget(50059, plr) -- burn
		return
	end
	if math.random(1,2) == 1 then
		pUnit:FullCastSpellOnTarget(50071, plr) -- blow
	else
		pUnit:FullCastSpellOnTarget(50050, plr) -- black cleave
	end
end

function ThunderClapEtc(pUnit)
	local plr = pUnit:GetMainTank()
	if not plr then
		return
	end
	local chance = math.random(1,3)
	if chance == 1 then
		pUnit:FullCastSpell(25264)
	elseif chance == 2 then
		pUnit:FullCastSpellOnTarget(15284, plr)
	elseif chance == 3 then
		pUnit:FullCastSpell(11555)
	end
end

function Wait_A_Second_Then_Update_Mirrorimage(pUnit)
	pUnit:SetUInt32Value(0x0006 + 0x0035, 0) 
	local plr = pUnit:GetClosestPlayer()
	if not plr then
		return
	end
	if plr:GetGender() == 0 then
		plr:RemoveAura(35480)
	else
		plr:RemoveAura(35481)
	end

	pUnit:SetFaction(21)

	--plr:CastSpellOnTarget(69828, pUnit) -- change display
	plr:CastSpellOnTarget(69837, pUnit) -- change name

	--[[local model = RaceDisplayMap[plr:GetPlayerRace()][plr:GetGender()+1]
	if not model then
		model = plr:GetDisplay()
	end
	pUnit:SetModel(model)]]

	pUnit:SetUInt32Value(60, bit_or(pUnit:GetUInt32Value(60), 16))
	
	local p = LuaPacket:CreatePacket(1026, 68)

	p:WriteGUID(pUnit:GetGUID())
	p:WriteULong(plr:GetDisplay()) -- race display

	p:WriteUByte(plr:GetPlayerRace()) -- race ID
	p:WriteUByte(plr:GetGender()) -- gender
	p:WriteUByte(PlayerClassToInt[plr:GetPlayerClass()]) -- class ID
	p:WriteUByte(plr:GetByteValue(153, 0)) -- skinID
	p:WriteUByte(plr:GetByteValue(153, 1)) -- faceID
	p:WriteUByte(plr:GetByteValue(153, 2)) -- Hair style ID
	p:WriteUByte(plr:GetByteValue(153, 3)) -- Hair colour ID
	p:WriteUByte(plr:GetByteValue(154, 0)) -- facial hair ID
	local guild = plr:GetGuildId()
	if not guild then
		guild = 0
	end
	p:WriteULong(guild) -- guild

	local slot_ids = {0, 2, 3, 4, 5, 6, 7, 8, 9, 14, 18}
	
	local i;
	for i = 0, 10 do
		local item = plr:GetEquippedItemBySlot(slot_ids[i+1])
		if not item then
			p:WriteULong(0)
		else
			local display = item:GetDisplayId()
			if not display then
				display = 0
			end
			if i == 0 and plr:HasFlag(150, 1024) then
				display = 0
			elseif i == 9 and plr:HasFlag(150, 2048) then
				display = 0
			end
			p:WriteULong(display)
		end
	end
	
	local item = plr:GetEquippedItemBySlot(15)
	if item then
		pUnit:SetUInt32Value(0x0006 + 0x0032, item:GetEntryId()) -- main hand
	else
		pUnit:SetUInt32Value(0x0006 + 0x0032, 0)
	end
	item = plr:GetEquippedItemBySlot(16)
	if item then
		pUnit:SetUInt32Value(0x0006 + 0x0032 + 0x1, item:GetEntryId()) -- offhand
	else
		pUnit:SetUInt32Value(0x0006 + 0x0032 + 0x1, 0)
	end
	item = plr:GetEquippedItemBySlot(17)
	if item then
		pUnit:SetUInt32Value(0x0006 + 0x0032 + 0x2, item:GetEntryId()) -- ranged
	else
		pUnit:SetUInt32Value(0x0006 + 0x0032 + 0x2, 0)
	end

	pUnit:SetUInt32Value(0x0006 + 0x0074, 1) -- bytes2 1
	
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		v:SendPacketToPlayer(p)
	end
	
	pUnit:SetMaxHealth(plr:GetMaxHealth() * 2)
	pUnit:SetHealth(pUnit:GetMaxHealth())

	local mana_regen_time = 4000
	local class = plr:GetPlayerClass()
	pUnit:SetValue("class", class)
	if class == "Warrior" then
		pUnit:SetMaxPower(1000, 1)
		pUnit:SetPower(100, 1)
		pUnit:SetPowerType(1)
		pUnit:RegisterEvent("GenerateRage", 3500, 0)
		pUnit:SetMaxHealth(plr:GetMaxHealth() * 3.25)
		pUnit:SetHealth(pUnit:GetMaxHealth())
	elseif class == "Paladin" then
		pUnit:SetMaxPower(plr:GetMaxMana() * 2, 0)
		pUnit:SetPower(pUnit:GetMaxMana(), 0)
		pUnit:SetPowerType(0)
		pUnit:RegisterEvent("RegenerateMana", mana_regen_time, 0)
	elseif class == "Hunter" then
		pUnit:SetMaxPower(100, 2)
		pUnit:SetPower(100, 2)
		pUnit:SetPowerType(2)
		pUnit:RegisterEvent("RegenerateFocus", 500, 0)
	elseif class == "Rogue" then
		pUnit:SetMaxPower(100, 3)
		pUnit:SetPower(100, 3)
		pUnit:SetPowerType(3)
		pUnit:RegisterEvent("RegenerateEnergy", 500, 0)
	elseif class == "Priest" then
		pUnit:SetMaxPower(plr:GetMaxMana() * 2, 0)
		pUnit:SetPower(pUnit:GetMaxMana(), 0)
		pUnit:SetPowerType(0)
		pUnit:RegisterEvent("RegenerateMana", mana_regen_time, 0)
	elseif class == "Shaman" then
		pUnit:SetMaxPower(plr:GetMaxMana() * 2, 0)
		pUnit:SetPower(pUnit:GetMaxMana(), 0)
		pUnit:SetPowerType(0)
		pUnit:RegisterEvent("RegenerateMana", mana_regen_time, 0)
	elseif class == "Mage" then
		pUnit:SetMaxPower(plr:GetMaxMana() * 2, 0)
		pUnit:SetPower(pUnit:GetMaxMana(), 0)
		pUnit:SetPowerType(0)
		pUnit:RegisterEvent("RegenerateMana", mana_regen_time, 0)
	elseif class == "Warlock" then
		pUnit:SetMaxPower(plr:GetMaxMana() * 2, 0)
		pUnit:SetPower(pUnit:GetMaxMana(), 0)
		pUnit:SetPowerType(0)
		pUnit:RegisterEvent("RegenerateMana", mana_regen_time, 0)
	elseif class == "Druid" then
		pUnit:SetMaxPower(plr:GetMaxMana() * 2, 0)
		pUnit:SetPower(pUnit:GetMaxMana(), 0)
		pUnit:SetPowerType(0)
		pUnit:RegisterEvent("RegenerateMana", mana_regen_time, 0)
	elseif class == "Demon Hunter" then
		pUnit:SetMaxPower(100, 3)
		pUnit:SetPower(100, 3)
		pUnit:SetPowerType(3)
		pUnit:RegisterEvent("RegenerateEnergy", 500, 0)
	end
end

function RegenerateEnergy(pUnit)
	local p = pUnit:GetPower(3) + 2
	if p > 100 then
		p = 100
	end
	pUnit:SetPower(p, 3)
end

function RegenerateFocus(pUnit)
	local p = pUnit:GetPower(2) + 2
	if p > 100 then
		p = 100
	end
	pUnit:SetPower(p, 2)
end

function GenerateRage(pUnit)
	local p = pUnit:GetPower(1) + 100
	if p > 1000 then
		p = 1000
	end
	pUnit:SetPower(p, 1)
end

function RegenerateMana(pUnit)
	local p = pUnit:GetMana() + (pUnit:GetMaxMana() / 100)
	if p > pUnit:GetMaxMana() then
		p = pUnit:GetMaxMana()
	end
	pUnit:SetMana(p)
end

RegisterUnitEvent(165, 18, "MirrorSpawnImage165")
RegisterUnitEvent(165, 4, "MirrorSpawnImage165")
RegisterUnitEvent(165, 2, "MirrorSpawnImage165")
RegisterUnitEvent(165, 1, "MirrorSpawnImage165")