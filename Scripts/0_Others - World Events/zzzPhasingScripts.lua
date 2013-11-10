local PlayersSentCinematicTo = {}

SetDBCSpellVar(54119, "c_is_flags", 0x01000)
SetDBCSpellVar(64490, "c_is_flags", 0x01000)

function ManaBombQuest(plr)
	if plr:HasQuest(25) and plr:GetQuestObjectiveCompletion(25, 0) == 0 then
		plr:SetPhase(2)
	end
end

AddAreaScript(46, 252, ManaBombQuest)

function HordeIntroZone(plr)
	if not plr:HasQuest(801) then
		if plr:GetPhase() ~= 1 then
			plr:SetPhase(1)
		end
	end
end

AddAreaScript(51, 1959, HordeIntroZone)

function ThroneAegwyth(plr)
	if not plr:HasAura(69127) then
		plr:CastSpell(69127)
	end
end

AddAreaScript(47, 491, ThroneAegwyth)
AddAreaScript(47, 80000, ThroneAegwyth)
AddAreaScript(47, 80001, ThroneAegwyth)
AddAreaScript(47, 80002, ThroneAegwyth)
AddAreaScript(47, 80003, ThroneAegwyth)
AddAreaScript(47, 80004, ThroneAegwyth)

function HandleOldLakeshireStuff(plr) -- area 68 or 69 in redrdige (old lakeshire)
	if not plr:HasFinishedQuest(3032) then -- last old lakeshit quest -- screen visual
		if plr:HasQuest(2500) then -- first quest
			if plr:GetQuestObjectiveCompletion(2500, 0) == 0 then
				plr:SetPhase(8)
				plr:CastSpell(68085)
			else
				plr:SetPhase(4)
				plr:CastSpell(68085)
			end
			return
		elseif plr:HasFinishedQuest(2500) and not plr:HasFinishedQuest(3030) then
			plr:SetPhase(4)
			plr:CastSpell(68085)
			if plr:HasQuest(3030) then
				if plr:GetQuestObjectiveCompletion(3030, 1) == 0 and plr:HasFinishedQuest(2501) then
					plr:AdvanceQuestObjective(3030, 1)
				end
				if plr:GetQuestObjectiveCompletion(3030, 2) == 0 and plr:HasFinishedQuest(2502) then
					plr:AdvanceQuestObjective(3030, 2)
				end
				if plr:GetQuestObjectiveCompletion(3030, 0) == 0 and plr:HasFinishedQuest(3031) then
					plr:AdvanceQuestObjective(3031, 0)
				end
			end
			return
		end
		-- plr has completed main quests and not on start quest - set to last quest phase (quest 3032)
		if plr:HasQuest(3032) then
			plr:SetPhase(32)
			plr:CastSpell(68085)
			return
		else
			if plr:HasFinishedQuest(3030) then
				plr:SetPhase(32)
				plr:CastSpell(68085)
				return
			end
			-- plr has completed everything - phase 1
			if plr:HasAura(68085) then
				plr:RemoveAura(68085) -- screen visual
			end
		end
		plr:SetPhase(1)
	else
		plr:SetPhase(16) -- normal phase??
	end
end

--AddAreaScript(44, 68, HandleOldLakeshireStuff)
AddAreaScript(44, 69, HandleOldLakeshireStuff)

function HandleSouthRedridge(plr)
	if plr:GetPhase() ~= 1 then
		plr:SetPhase(1)
		if plr:HasAura(68085) then -- screen visual
			plr:RemoveAura(68085)
		end
	end
end

AddAreaScript(44, 1001, HandleSouthRedridge)
AddAreaScript(44, 1002, HandleSouthRedridge)

function ShatteredSunCampHandle(plr)
	if not plr:GetPhase() == 3 then
		if plr:HasFinishedQuest(80079) then
		plr:SetPhase(3)
		end
	end
end

AddAreaScript(405, 2617, ShatteredSunCampHandle)

function DesolaceHandle(plr)
	if not plr:GetPhase() == 1 then
		plr:SetPhase(1)
		end
	end

AddAreaScript(0,405, DesolaceHandle)

function HandleEastRedridge(plr)
	if plr:GetPhase() ~= 4 then
		if plr:HasQuest(3008) or plr:HasQuest(3007) or plr:HasQuest(3006) then
			plr:SetPhase(4)
			if plr:HasAura(68085) then
				plr:RemoveAura(68085)
			end
		end
	end
	if plr:GetPhase() ~= 8 then
		if plr:HasFinishedQuest(3010) then
			plr:SetPhase(8)
			if plr:HasAura(68085) then
				plr:RemoveAura(68085)
			end
		end
	end
	if plr:HasQuest(3001) then
		plr:SetPhase(2)
	end
end

AddAreaScript(44, 997, HandleEastRedridge)
AddAreaScript(44, 71, HandleEastRedridge)

function HandleRedridgeGeneral(plr)
	if plr:GetPhase() ~= 1 then
		if plr:GetZ() > 470 then
			plr:SetPhase(1)
			if plr:HasAura(68085) then
				plr:RemoveAura(68085)
			end
		end
	end
end

AddAreaScript(44, 254, HandleRedridgeGeneral)

function HandleRedridgeGeneral_Two(plr)
	if plr:GetPhase() ~= 1 then
		plr:SetPhase(1)
		if plr:HasAura(68085) then
			plr:RemoveAura(68085)
		end
	end
end

AddAreaScript(44, 70, HandleRedridgeGeneral_Two)
AddAreaScript(44, 4812, HandleRedridgeGeneral_Two)
--AddAreaScript(44, 254, HandleRedridgeGeneral_Two)

function HandleWestfall(plr)
	if plr:GetAreaId() == 2 and plr:GetZ() < 8.7 and not plr:HasAura(54119) then
		plr:CastSpell(54119)
	else
		if plr:HasAura(54119) then
			plr:RemoveAura(54119)
		end
	end
end

--[[AddAreaScript(40, 0, HandleWestfall)
AddAreaScript(40, 2, HandleWestfall)]]
AddZoneScript(40, HandleWestfall)

function DRAKKARIAreaCheck(plr)
	if plr and plr:IsInWorld() then
		if plr:GetZ() < 450 then
			if plr:IsDead() then
				plr:ResurrectPlayer()
			end
			plr:CastSpell(8690)
		end
	end
end

AddZoneScript(66, DRAKKARIAreaCheck)

function BlackrockPhasing(plr)
	if plr:HasQuest(25) then
		if plr:GetQuestObjectiveCompletion(25, 0) == 0 then
			plr:SetPhase(2)
		end
	elseif plr:HasQuest(26) then
		plr:SetPhase(1)
	elseif plr:HasQuest(45) then
		plr:SetPhase(2)
	elseif plr:HasQuest(46) or plr:HasQuest(47) or plr:HasQuest(300) then
		plr:SetPhase(1)
	end
end

AddAreaScript(44, 252, BlackrockPhasing)
AddAreaScript(44, 2421, BlackrockPhasing)

function Blackrock_sanctuaryHandle(plr)
if plr:HasFinishedQuest(3032) then
plr:SetPhase(3)
else
plr:SetPhase(1)
end
end

AddAreaScript(46, 254, Blackrock_sanctuaryHandle)

function BlastedLandsHandle(plr)
	if plr:HasQuest(4468) or plr:HasQuest(4368) and (plr:GetPhase() ~= 3) then
		plr:SetPhase(3)
	elseif plr:HasFinishedQuest(4468) or plr:HasFinishedQuest(4368) and (plr:GetPhase() ~= 4) then
		plr:SetPhase(4)
	end
end

AddZoneScript(4, BlastedLandsHandle)

function SilverPineForestHandler(plr)
	if plr:GetPhase() ~= 2 then
		if plr:HasQuest(5503) and plr:GetQuestObjectiveCompletion(5503, 0) == 0 then
			plr:SetPhase(2)
		end
	end
end

AddAreaScript(130, 233, SilverPineForestHandler)

function SilverPineForestHandlerTwo(plr)
	if (plr:HasQuest(5303)) then
		if (plr:GetQuestObjectiveCompletion(5303, 0) ~= 100) then
			plr:SetPhase(2)
		else
			if plr:IsOnVehicle() then
				plr:ExitVehicle()
			end
			plr:SetPhase(1)
		end
	else
		plr:SetPhase(1)
	end
end

AddAreaScript(130, 228, SilverPineForestHandlerTwo)

function SilverPineForestHandlerThree(plr)
	if plr:HasFinishedQuest(5511) then
		plr:SetPhase(4)
	end
end

function SilverPineForestHandlerFour(plr)
	plr:SetPhase(1)
end

function SilverPineForestHandlerFive(plr)
	if not plr:HasQuest(5324) then
		plr:SetPhase(1)
	end
end

AddAreaScript(130, 204, SilverPineForestHandlerThree)
AddAreaScript(130, 236, SilverPineForestHandlerFour)
AddAreaScript(130, 130, SilverPineForestHandlerFive)

function SilverPineForestGeneralHandler(plr)
	if (plr:HasFinishedQuest(5511) and plr:GetDisplay() == 203) then
		if plr:HasAura(64490) then
			plr:RemoveAura(64490)
		end
		plr:DeMorph()
	end
	if (plr:HasFinishedQuest(5504) == false and plr:GetDisplay() == 203) then
		if plr:HasAura(64490) then
			plr:RemoveAura(64490)
			plr:DeMorph()
		end
	elseif (plr:HasFinishedQuest(5504) and plr:HasFinishedQuest(5511) == false) and (plr:GetDisplay() ~= 203 and plr:IsAlive()) then
		plr:CastSpell(64490)
	end
end

AddZoneScript(130, SilverPineForestGeneralHandler)

SetDBCSpellVar(82010, "c_is_flags", 0x01000)

function ARATHIHIGHLAND_LAND(plr)
	if plr:GetAreaId() == 315 then
		if (not plr:HasAura(82010)) then
			plr:CastSpell(82010)
		end
	else
		if plr:HasAura(82010) then
			plr:RemoveAura(82010)
		end
	end
end

AddZoneScript(45, ARATHIHIGHLAND_LAND)



function ThandolSpan(plr)
	if not plr:HasFinishedQuest(6008) then
		plr:SetPhase(6)
	else
		plr:SetPhase(1)
	end
end

AddAreaScript(45, 880, ThandolSpan)

function ThoriumPoint(plr)
	if (plr:HasQuest(827)) and (plr:IsInPhase(4) == false) and (plr:GetQuestObjectiveCompletion(827, 0) == 0) then
		plr:SetPhase(4)
	elseif (plr:HasQuest(826)) or (plr:HasQuest(825)) and (plr:IsInPhase(2) == false) then
		plr:SetPhase(2)
	elseif plr:HasFinishedQuest(827) and (plr:IsInPhase(1) == false) then
		plr:SetPhase(1)
	end
end

AddAreaScript(51, 1446, ThoriumPoint)


function Stromgarde(plr)
	plr:SetPhase(1)
	plr:RemoveAura(64490)
	if plr:HasQuest(8220) and plr:GetQuestObjectiveCompletion(8220, 0) == 0 then
		if not table.find(PlayersSentCinematicTo, plr:GetName()) then
			plr:MarkQuestObjectiveAsComplete(8220, 0)
			plr:SendCinematic(247)
			table.insert(PlayersSentCinematicTo, plr:GetName())
		end
	end
	if plr:GetAreaId() == 4995 then
		if (not plr:HasAura(82010)) then
			plr:CastSpell(82010)
		end
	else
		if plr:HasAura(82010) then
			plr:RemoveAura(82010)
		end
	end
end


AddZoneScript(324, Stromgarde)

function ShrinesArathi(plr)
	if plr:HasQuest(40041) then
		plr:SetPhase(3)
	else
		plr:SetPhase(1)
	end
end

AddAreaScript(45, 336, ShrinesArathi)
AddAreaScript(45, 333, ShrinesArathi)

-- Snowdrift Peaks

function SnowdriftPeaks(plr)
	if plr:HasFinishedQuest(41102) then
		if plr:HasQuest(41104) then
			if plr:GetQuestObjectiveCompletion(41104, 0) == 0 then
				plr:SetPhase(4)
			else
			if not plr:HasQuest(900010) then
				plr:SetPhase(1)
				end
			end
		elseif not plr:HasFinishedQuest(41104) then
			plr:SetPhase(3)
		else
		if not plr:HasQuest(900010) then
			plr:SetPhase(1)
			end
		end
	end
end

AddZoneScript(616, SnowdriftPeaks)

--[[

1 = 1
2 = 2
3 = 1+2
4 = 4
5 = 1+4
6 = 2+4
7 = 3+4 (1,2,4)
8 = 8

]]