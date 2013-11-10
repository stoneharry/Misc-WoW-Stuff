local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

function Worgen_Form_ZoneFix(event, pPlayer, zoneId)
	if pPlayer:GetZoneId() ~= 130 then
		if (pPlayer:HasFinishedQuest(5504) and pPlayer:GetDisplay() == 203) then
			pPlayer:RemoveAura(64490)
			pPlayer:DeMorph()
		end
	end
end

RegisterServerHook(15, "Worgen_Form_ZoneFix")

local Quest_Achievements = {
	[5511] = 59388,
	[3032] = 59389,
}

function Silverpine_Quest_Achievements(event, players, quest)
	local ach = Quest_Achievements[quest]
	if (ach) then
		if (not players:HasAchievement(ach)) then
			players:AddAchievement(ach)
		end
	end
end

RegisterServerHook(22, Silverpine_Quest_Achievements)

--[[
function Achievements_General(player,Event)
if (player:HasAchievement(59389) == false) and player:HasFinishedQuest(3032) then
player:AddAchievement(59389)
elseif (player:HasAchievement(59388) == false) and player:HasFinishedQuest(5511) then
player:AddAchievement(59388)
elseif (player:HasAchievement(59391) == false) and player:HasFinishedQuest(40043) then
player:AddAchievement(59391)
end
end

CreateLuaEvent(Achievements_General, 5000, 1)]]

function World_Problim_Events(pUnit,Event)
	if Event == 18 then
		pUnit:EquipWeapons(51796,0,0)
		pUnit:EquipWeapons(44244,0,0)
		pUnit:SetByteValue(UNIT_FIELD_BYTES_2, 0, 1)
		for _,players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 440 then
				players:SendBroadcastMessage("[EoC-Addon]- -3-3-Event!-Slay Problim!")
			end
		end
	elseif Event == 1 then
		pUnit:EquipWeapons(44244,0,0)
		pUnit:RegisterEvent("Problim_ROCKRUMBLE", math.random(6000,14300), 0)
		--pUnit:RegisterEvent("Problim_REVERBERATION", math.random(16500,27000), 0)
		pUnit:RegisterEvent("Problim_Groundslam", math.random(25000,40000), 0)
		pUnit:RegisterEvent("Problim_Crush", math.random(8000,12500), 0)
	elseif Event == 3 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
		for _,players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 40 then
				players:SendBroadcastMessage("[EoC-Addon]- -3-3-EVENT SUCCEEDED-")
				players:GiveXp(3780)
				players:CastSpell(47292)
				players:AddItem(44663,1)
			end
		end
	end
end

function Problim_Groundslam(pUnit,Event)
	pUnit:CastSpell(34771)
	pUnit:EquipWeapons(51796,0,0)
	pUnit:EquipWeapons(44244,0,0)
end

function Problim_REVERBERATION(pUnit,Event)
	pUnit:CastSpell(36297)
	pUnit:EquipWeapons(51796,0,0)
	pUnit:EquipWeapons(44244,0,0)
end

function Problim_ROCKRUMBLE(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		if pUnit:GetDistanceYards(plr) < 30 then
			if plr:IsDead() == false then
				pUnit:CastSpellOnTarget(38777,plr)
			end
		end
	end
end

function Problim_Crush(pUnit,Event)
	pUnit:EquipWeapons(51796,0,0)
	pUnit:EquipWeapons(44244,0,0)
	local tank = pUnit:GetMainTank()
	if tank ~= nil and pUnit:GetDistanceYards(tank) < 15 and (tank:IsDead() == false) then 
		pUnit:CastSpellOnTarget(59330,tank)
	end
end
	
	
RegisterUnitEvent(481231, 18, "World_Problim_Events")
RegisterUnitEvent(481231, 1, "World_Problim_Events")
RegisterUnitEvent(481231, 3, "World_Problim_Events")
RegisterUnitEvent(481231, 4, "World_Problim_Events")

function HeadlessHorseman_Events(pUnit,Event)
	if Event == 18 then
		local plrs = GetPlayersInZone(130)
		if type(plrs) == "table" then
			for _,plrs in pairs(plrs) do
				plrs:SendBroadcastMessage("[EoC-Addon]- -3-3-Event!-Slay The Headless Horseman!")
				pUnit:SendChatMessageToPlayer(14,0,"Prepare yourselves, the bells have tolled! Shelter your weak, your young and your old. Each of you shall pay the final sum! Cry for mercy, the reckoning has come!",plrs)
				plrs:PlaySoundToPlayer(11966)
			end
		end
	elseif Event == 1 then
		pUnit:SendChatMessage(14,0,"It is over, your search is done. Let fate choose now, the righteous one!")
		pUnit:PlaySoundToSet(11961)
		pUnit:RegisterEvent("HeadlessHorseman_LaughEvent", math.random(8000,16200), 0)
	elseif Event == 3 then
		pUnit:SendChatMessage(14,0,"Your body lies beaten, battered and broken. Let my curse be your own, fate has spoken.")
		pUnit:PlaySoundToSet(11962)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12,0,"So eager you are, for my blood to spill, yet to vanquish me..tis my head you must kill!")
		pUnit:PlaySoundToSet(11969)
		pUnit:RegisterEvent("HeadlessHorseman_LaughEvent",9000, 1)
		for _,players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 40 then
				players:SendBroadcastMessage("[EoC-Addon]- -3-3-EVENT SUCCEEDED-")
				players:GiveXp(3780)
				players:CastSpell(47292)
				players:AddItem(33985,1)
			end
		end
	end
end

function HeadlessHorseman_LaughEvent(pUnit,Event)
	pUnit:PlaySoundToSet(11965)
end

function HeadlessHorseman_SpawnPumpkins(pUnit,Event)
	pUnit:SendChatMessage(12,0,"Soldiers arise, stand and fight! Bring victory at last to this fallen knight!")
	pUnit:PlaySoundToSet(11963)
end

function HeadlessHorseman_Conflag(pUnit,Event)
	pUnit:SendChatMessage(12,0,"Soldiers arise, stand and fight! Bring victory at last to this fallen knight!")
	pUnit:PlaySoundToSet(12574)
end

RegisterUnitEvent(23682, 18, "HeadlessHorseman_Events")
RegisterUnitEvent(23682, 1, "HeadlessHorseman_Events")
RegisterUnitEvent(23682, 2, "HeadlessHorseman_Events")
RegisterUnitEvent(23682, 3, "HeadlessHorseman_Events")
RegisterUnitEvent(23682, 4, "HeadlessHorseman_Events")