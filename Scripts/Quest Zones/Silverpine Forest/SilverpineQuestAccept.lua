local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local q = 0 
local Dalin = nil
local Kernan = nil
local Billy = nil


function Dalin_OnSpawn(pUnit,Event)
	Dalin = pUnit
	pUnit:RegisterEvent("CAN_START_DALIN", 3000, 0)
end

RegisterUnitEvent(43991, 18, "Dalin_OnSpawn")

function Kernan_OnSpawn(pUnit,Event)
	Kernan = pUnit
end

RegisterUnitEvent(11056, 18, "Kernan_OnSpawn")

function Silverpine_OnQuestAccept(event, pPlayer, questId, pQuestGiver)
	if (questId == 5502 and pPlayer:HasSpell(73712)) then
		pPlayer:UnlearnSpell(73712)
	elseif (questId == 5503) then
		pPlayer:SetPhase(2)
		if q == 0 then
			q = 1
			Dalin:SendChatMessage(12,0,"Be on your guard, they come!")
		end
	elseif (questId == 5506) then
		local name = pPlayer:GetName()
		Kernan:SendChatMessageToPlayer(12, 0, "I am not giving up on you, "..name..". I don't have a cure for the Curse yet... but there are treatments. You will have control again.", pPlayer)
		pPlayer:PlaySoundToPlayer(18030)
	elseif (questId == 5321) then -- Witch Quests
		if Billy == nil then
			Billy = pPlayer:CreateGuardian(432144, 0, 2, 19)
			Billy:SetPetOwner(pPlayer)
		else
			Billy:Despawn(1,0)
			Billy = nil
			Billy = pPlayer:CreateGuardian(432144, 0, 2, 19)
			Billy:SetPetOwner(pPlayer)
		end
	elseif (questId == 5322) then
		if Billy == nil then
			Billy = pPlayer:CreateGuardian(432144, 0, 2, 19)
			Billy:SetPetOwner(pPlayer)
		else
			Billy:Despawn(1,0)
			Billy = nil
			Billy = pPlayer:CreateGuardian(432144, 0, 2, 19)
			Billy:SetPetOwner(pPlayer)
		end
	elseif (questId == 5324) then
		pPlayer:SetPhase(2)
	end
end

function CAN_START_DALIN(pUnit)
	if q == 1 then
		q = 2
		pUnit:RegisterEvent("Quest_Onslaught_Wave_One", 2000, 1)
	end
end

function Quest_Onslaught_Wave_One(pUnit,event,pPlayer)
	Dalin:SendChatMessage(12,0,"Here they come!")
	Dalin:SpawnCreature(43994,-128.20,860.22, 62.13,4.87, 14,0)
	Dalin:SpawnCreature(43994,-132.28,859.55, 62.24,4.87, 14,0)
	Dalin:SpawnCreature(43994,-139.28,858.40, 62.58,4.87, 14,0)
	Dalin:RegisterEvent("Quest_Onslaught_Wave_Two",21000,1) 
end

function Quest_Onslaught_Wave_Two(pUnit,event,pPlayer)
	Dalin:SpawnCreature(43994,-128.20,860.22, 62.13,4.87, 14,0)
	Dalin:SpawnCreature(43994,-132.28,859.55, 62.24,4.87, 14,0)
	Dalin:SpawnCreature(43994,-139.28,858.40, 62.58,4.87, 14,0)
	Dalin:RegisterEvent("Quest_Onslaught_Wave_Three",21000,1) 
end


function Quest_Onslaught_Wave_Three(pUnit,event,pPlayer)
	Dalin:SendChatMessage(12,0,"More incoming!")
	Dalin:SpawnCreature(43994,-128.20,860.22, 62.13,4.87, 14,0)
	Dalin:SpawnCreature(43994,-132.28,859.55, 62.24,4.87, 14,0)
	Dalin:SpawnCreature(43994,-139.28,858.40, 62.58,4.87, 14,0)
	Dalin:RegisterEvent("Quest_Onslaught_Wave_Four",21000,1) 
end


function Quest_Onslaught_Wave_Four(pUnit,event,pPlayer)
	Dalin:SpawnCreature(43994,-128.20,860.22, 62.13,4.87, 14,0)
	Dalin:SpawnCreature(43994,-132.28,859.55, 62.24,4.87, 14,0)
	Dalin:SpawnCreature(43994,-139.28,858.40, 62.58,4.87, 14,0)
	Dalin:RegisterEvent("Quest_Onslaught_Wave_Final",20000,1) 
end


function Quest_Onslaught_Wave_Final(pUnit,event,pPlayer)
	Dalin:SendChatMessage(12,0,"Hold the line!")
	Dalin:SpawnCreature(43993,-132.28,859.55, 62.24,4.87, 14,0)
--Dalin:RegisterEvent("Quest_Onslaught_Wave_Complete",16000,0) 
end


function Quest_Onslaught_Wave_Complete(pUnit,event,pPlayer)
	for _, creatures in pairs(Dalin:GetInRangeUnits()) do 
		if creatures:GetEntry() == 43994 and creatures:GetEntry() == 43993 then 
			creatures:Despawn(1,0)
		end
	end
	local PlayersAllAround = Dalin:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if Dalin:GetDistanceYards(players) < 40 and players:HasQuest(5503) then
			players:MarkQuestObjectiveAsComplete(5503,0)
			players:SetPhase(1)
		end
	end
	q = 0
end

RegisterServerHook(14, "Silverpine_OnQuestAccept")

function Phase2SoundSFX_OnSpawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("PlayMusicPhase2Town", 8000, 0)
end
   

RegisterUnitEvent(43989, 18, "Phase2SoundSFX_OnSpawn")
	
function InvadingWorgen_OnSpawn(pUnit,Event)
	pUnit:ModifyRunSpeed(16)
	pUnit:ModifyWalkSpeed(14)
	pUnit:SetMovementFlags(1)
	pUnit:RegisterEvent("InvadingWorgen_MoveTo", 1000, 1)
end
	

function InvadingWorgenHORDE_OnSpawn(pUnit,Event)
	pUnit:ModifyRunSpeed(16)
	pUnit:ModifyWalkSpeed(14)
	pUnit:SetMovementFlags(1)
	pUnit:RegisterEvent("InvadingWorgen_MoveToHORDIES", 1000, 1)
end

function InvadingWorgen_MoveTo(pUnit,Event)
	pUnit:MoveTo(-129.28,837.40,63.59,4.84)
end
	
function InvadingWorgen_MoveToHORDIES(pUnit,Event)
	pUnit:MoveTo(504.55,1500.42,124.20,2.28)
end
	
	
	
function Packleader_OnSpawn(pUnit,Event)
	pUnit:ModifyRunSpeed(16)
	pUnit:ModifyWalkSpeed(14)
	pUnit:SetMovementFlags(1)
	pUnit:RegisterEvent("InvadingWorgen_MoveTo", 1000, 1)
	pUnit:SendChatMessage(12,0,"All the better to own you with!")
	pUnit:PlaySoundToSet(9276)
end
	
function Packleader_Dead(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:PlaySoundToSet(9275)
	if Dalin ~= nil then
		Dalin:RegisterEvent("Quest_Onslaught_Wave_Complete",3000,1) 
	end
end
	
function HORDEWORGEN_Dead(pUnit,Event)
	pUnit:RemoveEvents()
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 100 and players:IsOnVehicle() and players:GetQuestObjectiveCompletion(5303, 0) ~= 100 then
			players:AdvanceQuestObjective(5303, 0)
		end
	end
end

RegisterUnitEvent(44505, 4, "HORDEWORGEN_Dead")


function Packleader_Combat(pUnit,Event)
	pUnit:RegisterEvent("PACKLEADER_JUMP", math.random(7000, 14000), 0)
end

function PACKLEADER_JUMP(pUnit,Event)
	local enemy = pUnit:GetRandomEnemy()
	if enemy ~= nil and pUnit:GetDistanceYards(enemy) < 15 and enemy:IsAlive() then
		pUnit:MoveKnockback(enemy:GetX(), enemy:GetY(), enemy:GetZ(), 10, 20)
		pUnit:Strike(enemy, 1, 1535, 140, 170, 1)
	end
end

RegisterUnitEvent(43993, 4, "Packleader_Dead")
RegisterUnitEvent(43993, 1, "Packleader_Combat")
RegisterUnitEvent(43994, 18, "InvadingWorgen_OnSpawn")
RegisterUnitEvent(44505, 18, "InvadingWorgenHORDE_OnSpawn")
RegisterUnitEvent(43993, 18, "Packleader_OnSpawn")

function SpawnWorgen_Spawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("SpawnWorgen_zzz",500,0) 
end

function SpawnWorgen_zzz(pUnit,Event)
	pUnit:SpawnCreature(44505,542.97,1464.58, 106.37,2.4, 14,7000)
	pUnit:SpawnCreature(44505,545.66,1467.53, 106.61,2.40, 14,7000)
	pUnit:SpawnCreature(44505,539.73,1461.04, 106.28,2.40, 14,7000)
	for place,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 44505 and creatures:IsDead() then 
			creatures:Despawn(1,0)
		end
	end
end

RegisterUnitEvent(44504, 18, "SpawnWorgen_Spawn")
	
function PlayMusicPhase2Town(pUnit,Event)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, players in pairs(PlayersAllAround) do
		if pUnit:GetDistanceYards(players) < 40 and players:IsInPhase(2) then
			local r = math.random(1, 3)
			local s = r == 1 and 14557 or r == 2 and 14556 or 14559
			players:PlaySoundToPlayer(s)
		end
	end
end



function Billy_Guardian_spawn(pUnit,Event)
	pUnit:SetPhase(1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:SetNPCFlags(2)
	pUnit:SetFaction(35)
	pUnit:AIDisableCombat(true)
	pUnit:RegisterEvent("BillyGuardian_GetQuestInfo", 2000, 0)
	pUnit:RegisterEvent("BillyGuardian_OutOfPlace", 4000, 0)
	pUnit:RegisterEvent("Billyguardian_NoQuest", 1000, 0)
end


RegisterUnitEvent(432144, 18, "Billy_Guardian_spawn")


function Billyguardian_NoQuest(pUnit,Event)
	local Owner = pUnit:GetPetOwner()
	if Owner:HasQuest(5321) == false then
		if Owner:HasQuest(5322) == false then
			pUnit:Despawn(1000,0)
		end
	end
end

function BillyGuardian_GetQuestInfo(pUnit,Event)
	local Owner = pUnit:GetPetOwner()
	if Owner ~= nil and Owner:GetQuestObjectiveCompletion(5321, 0) == 8 then
			pUnit:RemoveEvents()
			pUnit:SendChatMessageToPlayer(12,0,"Woot! We did it!", Owner)
	end
end

function BillyGuardian_OutOfPlace(pUnit,Event)
	if pUnit:GetAreaId() ~= 130 then
		pUnit:RemoveEvents()
		pUnit:Despawn(2000, 0)
	end
	if pUnit:IsInPhase(1) == false then
		pUnit:SetPhase(1)
	end
end

