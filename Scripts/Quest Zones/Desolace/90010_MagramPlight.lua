local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local Jhen = nil
local zq = 0
local wp = 0
local qt = 0

function Jhen_OnSpawn(pUnit,Event)
	Jhen = pUnit
end

RegisterUnitEvent(5601, 18, "Jhen_OnSpawn")

function Quest_Desolace(event, pPlayer, questId, pQuestGiver)
	if questId == 90010 then
		if zq == 0 then
			zq = 1
			Jhen:SetNPCFlags(8)
			Jhen:SendChatMessage(12,0,"Come. Walk with me, for this may take a while..")
			Jhen:MoveTo(-1741.64,942.06,92.05)
			Jhen:RegisterEvent("SETUPMOVEMENTS", 12000, 1)
		end
	end
end

function TEXTOFFBASED(pUnit,Event)
	qt = qt + 1
	if qt == 1 then
		Jhen:SendChatMessage(12,0,"We were allies of the treants, the forest spirit itself; we also were not divided into tribes as we are now, the Magram clan never existed; the Gelkis clan never existed.")
	elseif qt == 2 then
		Jhen:SendChatMessage(12,0,"The Gelkis secured our downfall by betraying us, they allied themselves with the kingdom of Aegwyth in fear of being exterminated.")
	elseif qt == 3 then
		Jhen:SendChatMessage(16,0,"Khan Jhen sighs.")
	elseif qt == 4 then
		Jhen:SendChatMessage(12,0,"Let us walk back now..")
	end
end

function SETUPMOVEMENTS(pUnit,Event)
wp = wp + 1
if wp == 1 then
Jhen:SendChatMessage(12,0,"Decades ago the Magram as you see now, were different. We were not centaurs, but dryads and keepers. Desolace used to be a lush forest, we watched over and protected the land with our lives.")
Jhen:MoveTo(-1767.47,966.56,92.43)
Jhen:RegisterEvent("TEXTOFFBASED", 8000, 1)
Jhen:RegisterEvent("SETUPMOVEMENTS", 12000, 1)
elseif wp == 2 then
Jhen:SendChatMessage(12,0,"This all changed however when a nearby human kingdom settled and started destroying the land, slaughtering us one by one. ")
Jhen:MoveTo(-1808.05,1014.94,93.25)
Jhen:RegisterEvent("TEXTOFFBASED", 11000, 1)
Jhen:RegisterEvent("SETUPMOVEMENTS", 23000, 1)
elseif wp == 3 then
Jhen:MoveTo(-1769.64,1067.57,91.31)
Jhen:SendChatMessage(12,0,"The rats fled after the kingdom disposed of their usefulness as they found a dark secret power hidden within the caves of Desolace. The military of Aegwyth could not be destroyed, they came back after death. We could do nothing but hide and watch in the shadows.")
Jhen:RegisterEvent("SETUPMOVEMENTS", 20000, 1)
elseif wp == 4 then
Jhen:MoveTo(-1840.45,1126.61,90.27)
Jhen:SendChatMessage(12,0,"This dark power attracted demons to the land and ever since then the land had started to corrupt, thus we became who we are today; Cenarius abandoned us and now we fight a three sided battle. ")
Jhen:RegisterEvent("TEXTOFFBASED", 19500, 1)
Jhen:RegisterEvent("SETUPMOVEMENTS", 39000, 1)
elseif wp == 5 then
Jhen:SendChatMessage(12,0," What is left of the forest spirit had sacrificed itself to protect us from the legion, specifically their mechanical giants. It is now in stasis, protecting us from harm.")
Jhen:MoveTo(-1876.10,1097.80,92.00)
Jhen:RegisterEvent("SETUPMOVEMENTS", 18000, 1)
elseif wp == 6 then
Jhen:MoveTo(-1854.82,1062.78,90.79)
Jhen:SendChatMessage(12,0,"Thus ends the story of our plight.")
Jhen:RegisterEvent("SETUPMOVEMENTS", 16000, 1)
Jhen:RegisterEvent("TEXTOFFBASED", 8000, 1)
	for _, players in pairs(Jhen:GetInRangePlayers()) do
		if Jhen:GetDistanceYards(players) < 40 and players:HasQuest(90010) then
			players:MarkQuestObjectiveAsComplete(90010,0)
		end
	end
elseif wp == 7 then
Jhen:MoveTo(-1848.19,1039.57,92.41)
Jhen:RegisterEvent("SETUPMOVEMENTS", 9000, 1)
elseif wp == 8 then
Jhen:MoveTo(-1820.55,1032.69,93.01)
Jhen:RegisterEvent("SETUPMOVEMENTS", 11000, 1)
elseif wp == 9 then
Jhen:MoveTo(-1760.38,954.48,92.11)
Jhen:RegisterEvent("SETUPMOVEMENTS", 39000, 1)
elseif wp == 10 then
Jhen:MoveTo(-1743.25,940.71,92.32)
Jhen:RegisterEvent("SETUPMOVEMENTS", 9000, 1)
elseif wp == 11 then
Jhen:MoveTo(-1764.14,913.15,92.49)
Jhen:RegisterEvent("SETUPMOVEMENTS", 13000, 1)
elseif wp == 12 then
wp = 0
zq = 0
qt = 0
Jhen:SetNPCFlags(2)
Jhen:Despawn(1,1)
end
	end


RegisterServerHook(14, "Quest_Desolace")