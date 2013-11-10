local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local Greatmother = nil
local km = 0
local kp = 0

function Greatmother_OnSpawn(pUnit,Event)
	Greatmother = pUnit
end

RegisterUnitEvent(25602, 18, "Greatmother_OnSpawn")

function Quest_SandyPlains(event, pPlayer, questId, pQuestGiver)
	if questId == 52019 then
		if km == 0 then
			km = 1
			Greatmother:SetNPCFlags(8)
			Greatmother:SendChatMessage(12,0,"We start our journey.")
			Greatmother:MoveTo(7075.85,-4612.25,630.55)
			Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 5100, 1)
		end
	end
end


function sp_SETUPMOVEMENTS(pUnit,Event)
kp = kp + 1
if kp == 1 then
Greatmother:SendChatMessage(12,0,"I have seen the visions many times, many times they have become true.")
Greatmother:MoveTo(7052.90,-4624.85,621.99)
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 11500, 1)
elseif kp == 2 then
Greatmother:SetFacing(5.03)
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 2000, 1)
elseif kp == 3 then
Greatmother:ChannelSpell(64269,Greatmother)
Greatmother:SpawnGameObject(3265231, 7055.76, -4631.10, 621.20, 2.336934, 18200, 200)
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 2000, 1)
elseif kp == 4 then
Greatmother:SendChatMessage(12,0,"I see a titanic object, it seems it controls the weather of sandy plains.")
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 8000, 1)
elseif kp == 5 then
Greatmother:SendChatMessage(12,0,"Wait, there is a huge excavation encampment around it... it seems it is full of, pirates?")
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 8000, 1)
elseif kp == 6 then
Greatmother:SendChatMessage(12,0,"The visions have faded, we must go to the next pool.")
Greatmother:MoveTo(7027.67,-4637.46,618.60)
Greatmother:StopChannel()
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 11000, 1)
elseif kp == 7 then
Greatmother:SetFacing(5.03)
Greatmother:ChannelSpell(64269,Greatmother)
Greatmother:SpawnGameObject(3265231, 7033.42,-4642.90,618.67,2.296351, 27100, 200)
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 2000, 1)
elseif kp == 8 then
Greatmother:SendChatMessage(12,0,"The pirates are of the Fallen Corsair, but what do they want with that device?")
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 7000, 1)
elseif kp == 9 then
Greatmother:SendChatMessage(12,0,"They wish to flood the sandy plains with that device!")
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 7000, 1)
elseif kp == 10 then
Greatmother:SendChatMessage(12,0,"There is a way however to stop them.")
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 5000, 1)
elseif kp == 11 then
Greatmother:SendChatMessage(12,0,"There are two titanic overwatches, each containing half of a sigil to shutdown the device.")
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 8000, 1)
elseif kp == 12 then
Greatmother:SendChatMessage(12,0,"The visions have faded, I have done all I can, traveler. Return with this news, you must find the two overwatches.")
Greatmother:StopChannel()
Greatmother:Emote(1,5000)
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 2000, 1)
elseif kp == 13 then
	for _, players in pairs(Greatmother:GetInRangePlayers()) do
		if Greatmother:GetDistanceYards(players) < 30 and players:HasQuest(52019) then
			players:MarkQuestObjectiveAsComplete(52019,0)
		end
	end
Greatmother:RegisterEvent("sp_SETUPMOVEMENTS", 3000, 1)
elseif kp == 14 then
kp = 0
km = 0
Greatmother:SetNPCFlags(2)
Greatmother:Despawn(2000,3000)
end
end


RegisterServerHook(14, "Quest_SandyPlains")