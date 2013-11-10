-------------------------------------------------------------
-- [[ Some shit we should actually put in a global file ]] --
-------------------------------------------------------------
--[[
OBJECT_END = 0x0006
UNIT_FIELD_FLAGS = OBJECT_END + 0x0035
UNIT_FLAG_NOT_SELECTABLE = 0x02000000
UNIT_FLAG_DEFAULT = 0x00
]]
--------------------------------
-- [[ GATHERING THE MOUNTS ]] --
--------------------------------
--[[
function C_TamingNet(item, event, player)
	TamingNet(item, player)
end

function TamingNet(item, player)
	local MOUNT_SELECT = player:GetSelection() -- get selected target
	if CooldownCheck(player, 2) == true then return end -- check if player can use it yet
	if MOUNT_SELECT ~= nil and MOUNT_SELECT ~= player and player:GetDistanceYards(MOUNT_SELECT) < 10 and MOUNT_SELECT:GetEntry() == 57009 then -- distance, nil and entry check
		
		player:Emote(36, 500) -- whip slash emote
		MOUNT_SELECT:SetMovementFlags(1) -- make the horse run
		
		local PLAYER_ORIENTATION = player:GetO() -- getting player info
		local PLAYER_X = player:GetX()
		local PLAYER_Y = player:GetY()
				
		MoveBasedOnOrientation(MOUNT_SELECT, player:GetO(), 15) -- see KronosFunctions for explanation

		MountInfo[MOUNT_SELECT] = player -- hook player's guid with mount's guid for quest marking later on
		CooldownTime[player:GetName()] = os.clock() -- add to cooldown table
	else
		player:SendBroadcastMessage("|cFFFF0000Incorrect target or too far away!") -- error message
	end
end

RegisterItemGossipEvent(57001, 1, "C_TamingNet")

---------------------------------
--  DELIVERING THE MOUNTS  --
---------------------------------

MountSpawnLocations = {
	{-7856.7, -2663.93, 221.22, 4.84},
	{-7851.08, -2663.2, 221.2, 2.84},
	{-7841.57, -2663.33, 221.2, 5.5}
}

function MountGatherer_onSpawn(pUnit, event)
	pUnit:RegisterEvent("CheckForMounts", 1500, 0) -- not finding it quick enough, players are impatient
end

function HorsieToResetOnSpawn(pUnit, event)
	MountSpawnLocations[tostring(pUnit)] = nil
end

RegisterUnitEvent(57009, 18, "HorsieToResetOnSpawn")
RegisterUnitEvent(57008, 18, "MountGatherer_onSpawn")

function CheckForMounts(pUnit, event)
	local DELIV_MOUNT = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 57009) -- get nearest mount
	if DELIV_MOUNT ~= nil and pUnit:GetDistanceYards(DELIV_MOUNT) < 15 and MountSpawnLocations[DELIV_MOUNT] == nil then -- nil, distance and if it's already  been delivered check
		MountSpawnLocations[DELIV_MOUNT] = 1 -- mount's been delivered, add it to here to make sure it isn't delivered twice
		DELIV_MOUNT:Despawn(1000, 60000) -- despawn the delivered mount
		--MountInfo[DELIV_MOUNT]:AdvanceQuestObjective(57008, 0) -- advance quest objective by 1
		local MOUNT_RANDOM_SPAWN = math.random(1,3) -- random number for random spawning
		pUnit:SpawnCreature(284, MountSpawnLocations[MOUNT_RANDOM_SPAWN][1], MountSpawnLocations[MOUNT_RANDOM_SPAWN][2], MountSpawnLocations[MOUNT_RANDOM_SPAWN][3], MountSpawnLocations[MOUNT_RANDOM_SPAWN][4], 35, 10000) -- spawn horse on random place for 10 seconds
		if math.random(1,2) == 1 then -- random message sent by brann
			pUnit:SendChatMessage(12, 0, "Thanks, "..MountInfo[DELIV_MOUNT]:GetName().."!")
		else
			pUnit:SendChatMessage(12, 0, "Keep it up!")
		end
	end
end]]--
------------------------------------------
-- [[ RACE TRACK MOUNT PRE-REQUISITE ]] --
------------------------------------------
--[[
MountInfo = {}

RaceLocations = {-- in format as x, y, z, o, registertime, optional message
	{
		{-7900.9, -2450.8, 134.3, 6, 4800},
		{-7820.9, -2461.4, 138.9, 6, 6000},
		{-7786.7, -2463.4, 146.37, 5, 3200},
		{-7773.5, -2492.8, 160.08, 4.6, 3000},
		{-7775.3, -2517.7, 161.6, 4.6, 2200, "You're not that bad, after all!"},
		{-7776.8, -2536.5, 170.9, 4, 1500},
		{-7792.1, -2555.4, 173.7, 3.2, 2500},
		{-7826.7, -2559.5, 189.7, 4.6, 3000},
		{-7823.7, -2594.2, 202, 3.8, 3000, "Try to keep up, will you?"},
		{-7833.5, -2602.4, 207.7, 3, 1000},
		{-7854.6, -2601.5, 211.5, 3.6, 2000},
		{-7871.1, -2610.2, 220.3, 3.6, 2000},
		{-7912.6, -2615.9, 221.1, 3.3, 3000},
		{1, 1, 1, 1, 1, "I almost knew for sure I would win this race. Good job."} -- need an empty one to not error out with the message
	},
	{
		{-7862.5, -2626.8, 221.2, 2, 2500},
		{-7883.1, -2606.8, 221.2, 3.5, 2800},
		{-7923, -2620.6, 221.1, 3.5, 4000, "I knew you were slow, but at least try to keep up, will you?!"},
		{-7938.3, -2637.6, 218.5, 4.9, 2100},
		{-7934.9, -2656.8, 217.6, 4.8, 1900, "Here comes the fun part! Turn back while you still can!"}, -- 5
		{-7934.14, -2667.3, 210.3, 4, 1400},
		{-7953.2, -2668.5, 207.7, 3.2, 1400},
		{-7964.4, -2668.9, 198.4, 3.3, 1500},
		{-7965.1, -2679.1, 197.6, 5.0, 1500, "WOAH! Watch out, slow one!"}, -- ROCK!
		{-7975.3, -2693.3, 193.9, 5.5, 1400}, -- 10
		{-7967.1, -2700.9, 190.9, 6.2, 1000},
		{-7939.2, -2705.1, 188.3, 6.0, 2200},
		{-7933.7, -2706.8, 186.8, 5.4, 900},
		{-7929.6, -2715.4, 182.6, 5.1, 800},
		{-7929.3, -2720.5, 180.6, 5.7, 700}, -- 15
		{-7917.2, -2724.5, 182.0, 5.7, 1300},
		{-7908.9, -2728.3, 178.2, 3.9, 900},
		{-7923.6, -2745.1, 159.2, 4.0, 1800},
		{-7908.0, -2754.5, 160.2, 6.0, 2000},
		{-7894.6, -2750.5, 165.0, 0.4, 1500, "Another one! Almost got me, stay on your toes!"},
		{-7883.9, -2735.3, 165.7, 0.2, 1500, "That one definitely shivered the dungoos out of me!"},
		{-7867.2, -2730.9, 164.9, 0.7, 1700},
		{-7840.6, -2711.5, 170.9, 5.3, 2800}, -- ROCK
		{-7823.9, -2746.2, 139.9, 5.1, 4000, "Much for a gamebreaker! Let's go this way!"},
		{-7813.5, -2755.7, 136.0, 6.1, 2200},
		{-7807.9, -2756.5, 139.6, 1.1, 700, "An ogre ambush! This way, quick!"},
		{-7802.2, -2742.2, 148.4, 5.9, 1400},
		{-7783.9, -2749.4, 149.8, 5.9, 1400},
		{-7765.1, -2735.1, 159.4, 1.1, 1900},
		{-7757.5, -2717.3, 168.4, 1.6, 1400},
		{-7757.3, -2694.3, 173.9, 1.4, 1700},
		{-7739.2, -2693.1, 173.9, 0.1, 1900},
		{1, 1, 1, 1, 1, "Aaargh, this can't be!"}
	},
	{
		{-7751.6, -1120.8, 220.1, 0.2, 3300},
		{-7738.0, -1089.5, 221.8, 1.2, 2800},
		{-7708.1, -1091.0, 222.8, 6.2, 1900},
		{-7701.2, -1112.5, 220.7, 4.9, 2200},
		{-7698.4, -1123.3, 216.6, 5.1, 800},--5
		{-7677.9, -1171.7, 221.8, 5.5, 4000},
		{-7617.8, -1230.0, 238.1, 5.5, 6500},
		{-7611.1, -1269.5, 243.3, 4.9, 2400, "Time for the tricky part!"},
		{-7592.1, -1279.4, 249.2, 6.3, 2400},
		{-7566.7, -1279.4, 250.5, 0.1, 2100},--10
		{-7541.2, -1277.1, 255.3, 0.1, 1300},
		{-7538.8, -1289.8, 260.8, 6.3, 1300},
		{-7528.0, -1288.4, 271.5, 1.8, 1300},
		{-7531.2, -1277.2, 275.4, 3.1, 1200},
		{-7552.0, -1278.9, 277.0, 3.2, 1500},--15
		{-7574.9, -1281.3, 281.1, 5.0, 1800},
		{-7573.0, -1304.6, 287.1, 4.8, 1800},
		{-7569.8, -1332.3, 287.4, 4.8, 3000, "Come on, jump, ye pansy!", distance = 30},
		{-7551.9, -1337.5, 291.4, 0.2, 2000, "See? Gotcha.", distance = 24},
		{-7517.1, -1333.1, 293.0, 0.2, 2000, distance = 23}, -- 20
		{-7509.8, -1313.4, 294.6, 0.2, 2000},
		{-7509.8, -1313.4, 304.4, 4.8, 1500, distance = 21},
		{-7533.7, -1329.2, 302.6, 3.3, 2000},
		{-7545.1, -1327.9, 303.2, 1.9, 700, distance = 18},
		{-7576.6, -1289.3, 305.4, 1.9, 2000}, -- 25
		{-7578.9, -1281.0, 301.3, 1.7, 5000, "Well done, lad, well done! You deserve that mount more than anything."},
		{-7578.9, -1281.0, 301.3, 1.7, 1000, "What? Did ye hear that? We gotta get out of here, NOW!"}, -- escape time
		{-7573.4, -1310.1, 301.9, 4.7, 2500, distance = 40},
		{-7573.4, -1310.1, 286.5, 4.7, 4000, "Drive around, I'll pull you over that gap again!", distance = 40},
		{-7573.9, -1305.3, 286.6, 1.7, 4000, distance = 35},-- 30
		{-7576.2, -1282.4, 279.8, 1.7, 2000, distance = 35},
		{-7579.7, -1253.1, 286.4, 1.7, 1600, distance = 35},
		{-7580.3, -1243.2, 286.7, 0.2, 750},
		{-7527.6, -1223.9, 287.4, 2.1, 4000},
		{-7536.7, -1209.8, 288.4, 2.2, 2000, "There's an automatic parachute under yer chair! USE IT!"}, -- 35
		{-7579.6, -1136.9, 260.8, 2.0, 17000, distance = 200},
		{1, 1, 1, 1, 1, "Splendid, we made it! Not that I was thinkin' we wouldn't, but, well, that mount is yers, lad!"}
	},
	{
		{-5829, -2849, 365.1, 3.9, 2000}, -- 1
		{-5837.4, -2865, 366.5, 4.38, 1500}, -- 2
		{-5843.6, -2879.2, 365, 4, 1800}, -- 3
		{-5885.609375,-2879.3312988281,366.19430541992,3.164368391037, 1900},-- 4
		{-5905.982421875,-2884.3786621094,366.98233032227,4.349534034729, 2000},-- 5
		{-5915.6171875,-2905.6484375,367.15853881836,4.5584497451782, 2100},
		{-5923.029296875,-2925.3083496094,369.1882019043,4.325186252594, 2200},
		{-5939.0927734375,-2946.6801757813,372.53277587891,4.2238698005676, 2200},
		{-5952.1430664063,-2971.4482421875,381.9660949707,4.1924533843994, 2200},
		{-5957.9780273438,-2980.4328613281,385.41833496094,3.9858932495117, 2000, "Here's the fun part!"},-- 10
		{-6018.4770507813,-2981.8464355469,400.63751220703,3.0654063224792, 2500},
		{-6036.4624023438,-2990.6499023438,401.65176391602,3.711003780365, 2500},
		{-6046.4311523438,-2988.6916503906,402.93667602539,2.548614025116, 2500},
		{-6061.9443359375,-2988.8791503906,407.05227661133,3.3426516056061, 2100},
		{-6070.7563476563,-2994.1025390625,410.30663452148,3.795040845871, 600},-- 15
		{-6077.2885742188,-2991.9047851563,412.51715087891,2.8172199726105, 600, distance = 50},
		{-6084.107421875,-2986.6857910156,415.58102416992,2.4315896034241, 6900, distance = 500},
		{-6108.970703125,-2921.9194335938,419.78039550781,2.1637687683105, 800, "Woah, try to keep up, I don't think teleporting was such a good idea...", distance = 20},
		{-6110.6118164063,-2915.5617675781,418.78039550781,1.3932930231094, 800, distance = 15},
		{-6106.6162109375,-2906.5512695313,419.01162719727,1.4474856853485, 1600},
		{-6085.5625,-2873.259765625,415.43142700195,0.9958815574646, 1800},-- 
		{-6069.8344726563,-2868.0378417969,413.95651245117,0.01177754253149, 2100},
		{-6054.2299804688,-2854.3493652344,413.74871826172,0.86000764369965, 2000},
		{-6042.306640625,-2827.6665039063,412.6301574707,1.1309700012207, 2000},
		{-6038.880859375,-2808.3430175781,410.41976928711,1.0624315738678, 800},
		{-6033.2299804688,-2801.3039550781,400.00726318359,5.961745262146, 2000},-- 
		{-6018.751953125,-2801.2829589844,394.28567504883,6.130606174469, 2000},
		{-5992.54296875,-2819.1838378906,383.6884765625,5.865927696228, 2600},
		{-5969.5341796875,-2823.0563964844,378.63861083984,5.9460377693176, 2600},
		{-5944.9575195313,-2836.7495117188,375.25436401367,5.6750755310059, 2400},
		{-5916.294921875,-2868.1901855469,369.76217651367,5.4300312995911, 2400, "You can't beat me! I'm going to win!"},-- 
		{-5902.5131835938,-2880.1665039063,366.76876831055,5.316933631897, 2000},
		{-5876.943359375,-2883.37890625,367.04257202148,6.0850534439087, 3000},
		{-5853.9990234375,-2882.1201171875,365.3408203125,6.2358498573303, 2500},
		{-5818.59375,-2877.3991699219,366.16561889648,0.15058472752571, 2000},
		{-5800.2133789063,-2875.4736328125,366.31646728516,0.23540771007538, 1000}, --
		{-5801.1430664063,-2871.693359375,366.87319946289,1.8368349075317, 1000},
		{1, 1, 1, 1, 1, "I can see why Bloodhoof sent you to me now; you did very well."}
	},
	{
		{-9429,-2482,46,0, 5000, "You don't even know which way to go! Looks like I will be the clear winner."},
		{-9403, -2482, 45,0, 5000},
		{-9372, -2496, 17, 0, 5000},
		{-9334, -2551, 28, 0, 15000},
		{-9349, -2612, 44, 0, 8000, "Let us see how you deal with this!"},
		{-9403, -2578, 51, 0, 7000},
		{-9432, -2549, 39, 0, 6000},
		{-9450, -2504, 38, 0, 6000},
		{-9480, -2494, 38, 0, 1000,"Sharks! This is all your fault!"},
		{-9456, -2500, 40, 0, 3000},
		{-9437, -2503, 54, 0, 3000, "Make for the coast!"},
		{-9397.8, -2459, 54.57, 0, 7000},
		{-9322, -2374, 54.57, 0, 16000}, -- this is the coordinate for land
		{-9254, -2324, 76.7, 0, 8000, "Land ahoy!"},
		{-9202, -2359, 88, 0, 6000},
		{-9185, -2414, 106, 0, 10000},
		{-9164, -2423, 105, 0, 4000},
		{-9115, -2504, 117, 0, 14000, "Don't you understand? Nobody beats the mighty Captain Rush at his own game!"},
		{-9099, -2521, 118, 0, 2000},
		{-9058, -2560, 126, 0, 8000},
		{-9058, -2582, 126.5, 0, 1500, "Gnomes?! What is this madnes!"}, -- 21
		{-9019, -2591, 126.6, 0, 6500}, -- 22
		{-8982, -2608, 132, 0, 4000}, -- 23
		{-8902, -2586, 133, 0, 12000, "I doubt you can follow me over this terrain!"}, -- 24
		{-8874, -2591, 141, 0, 4500}, -- 25
		{-8827, -2489, 133, 0, 12000}, -- 26
		{-8794, -2468, 136.5, 0, 6500},
		{-8776.8, -2417, 157, 0, 7500},
		{-8748, -2365, 158.5, 0, 3000, "Here be dragons!"},
		{-8690.8, -2348, 157.5, 0, 5000},
		{-8677, -2301, 156, 0, 7500},
		{-8672, -2276, 156, 0, 2500},
		{-8673, -2265, 157, 0, 750},
		{-8663, -2252, 155, 0, 1000},
		{-8694, -2238, 153.1, 0, 1500}, -- 35
		{-8826, -2186, 138.4, 0, 30000},
		{1, 1, 1, 1, 1, "What are you?!"}
	}
}

----------------------------------------
-- TRIALS OF THE STEED: JAELEIN
----------------------------------------

function Jaelein_Checking(pUnit, event)
	MountInfo[tostring(pUnit)] = {ready = false} -- set her to false so she can be used
	pUnit:RegisterEvent("Jaelein_Check", 3000, 0) -- check if it's time for a race
end

function Jaelein_Check(pUnit, event)
	if MountInfo[tostring(pUnit)].ready == true then -- ready's set to true by gossip; let's go!
		pUnit:RemoveEvents() -- remove the 3 sec check
		pUnit:RegisterEvent("JaeleinRaceStart", 6000, 1) -- start race
	end		
end

function Jaelein_Race(pUnit, event, player, pMisc)
if player then
	pUnit:GossipCreateMenu(57010, player, 0)
	if player:HasQuest(57010) then
		pUnit:GossipMenuAddItem(0, "Let's race!", 1, 0)
		pUnit:GossipMenuAddItem(0, "I'll pass.", 2, 0)
	end
	pUnit:GossipSendMenu(player)
end
end

function Jaelein_Choose(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
		if MountInfo[tostring(pUnit)].ready == true then
			player:SendAreaTriggerMessage("|cFFFF0000Track's currently in use. Please wait until Jaelein is back.")
			player:GossipComplete()
		else
			MountInfo[tostring(pUnit)] = {
				player = player, 
				aura = 34406, 
				track = 1, 
				racecount = 1, 
				countdown = 5, 
				ready = true, 
				quest = 57010, 
				speed = 12, 
				distance = 15, 
				debug = false
			}
			pUnit:StopMovement(0)
			pUnit:SendChatMessage(12, 0, "Don't think you're in for an easy match, "..player:GetName()..". Try to keep up if you can!")
			player:GossipComplete()
			pUnit:SetNPCFlags(2)
			pUnit:MoveTo(-7941.1, -2434.7, 130.75, 6)
		end
	end
	
	if (intid == 2) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(57010, 1, "Jaelein_Race")
RegisterUnitGossipEvent(57010, 2, "Jaelein_Choose")
RegisterUnitEvent(57010, 18, "Jaelein_Checking")

function JaeleinRaceStart(pUnit, event)
	pUnit:SetMount(19869)
	pUnit:SetMovementFlags(1)
	pUnit:SetPosition(-7941.1, -2434.7, 130.75, 6)
	if MountInfo[tostring(pUnit)].player:IsMounted() then
		MountInfo[tostring(pUnit)].player:Dismount()
	end
	MountInfo[tostring(pUnit)].player:CastSpell(MountInfo[tostring(pUnit)].aura)
	pUnit:RegisterEvent("RacingOverTheTrack", 6000, 1)
	pUnit:RegisterEvent("RaceTrackCountDown", 1000, 6)
	pUnit:RegisterEvent("PlayerTrackCheck", 1000, 0)
	pUnit:RegisterEvent("Teleport_due_to_buggy_ground_Movement", 1000, 0)
end

----------------------------------------
-- TRIALS OF THE STEED: FONWICK
----------------------------------------

function Fonwick_Checking(pUnit, event)
	MountInfo[tostring(pUnit)] = {ready = false}
	pUnit:RegisterEvent("Fonwick_Check", 3000, 0)
end

function Fonwick_Check(pUnit, event)
	if MountInfo[tostring(pUnit)].ready == true then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12, 0, "Oh, you're serious? I'll put you down. You stand no chance against me, the most famous and swiftest gnome Azeroth has ever known, Fonwick!")
		pUnit:RegisterEvent("FonwickRaceStart", 6000, 1)
	end		
end

function Fonwick_Race(pUnit, event, player, pMisc)
	pUnit:GossipCreateMenu(57012, player, 0)
	if player:HasQuest(57012) then
		pUnit:GossipMenuAddItem(0, "Let's race!", 1, 0)
		pUnit:GossipMenuAddItem(0, "I'll pass.", 2, 0)
	end
	pUnit:GossipSendMenu(player)
end

function Fonwick_Choose(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
		if MountInfo[tostring(pUnit)].ready == true then
			player:SendAreaTriggerMessage("|cFFFF0000Track's currently in use. Please wait until Fonwick is back.")
			player:GossipComplete()
		else
			MountInfo[tostring(pUnit)] = {
				player = player, 
				aura = 17454, 
				track = 2, 
				racecount = 1, 
				countdown = 5, 
				ready = true, 
				quest = 57012, 
				speed = 12, 
				distance = 15, 
				debug = false
			}
			pUnit:StopMovement(0)
			pUnit:SendChatMessage(12, 0, "Haha! Don't make me laugh, "..player:GetPlayerClass()..".")
			player:GossipComplete()
			pUnit:SetNPCFlags(2)
			pUnit:MoveTo(-7850.64, -2652.3, 221.2, 1.8)
		end
	end
	
	if (intid == 2) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(57012, 1, "Fonwick_Race")
RegisterUnitGossipEvent(57012, 2, "Fonwick_Choose")
RegisterUnitEvent(57012, 18, "Fonwick_Checking")

function FonwickRaceStart(pUnit, event)
	pUnit:SetMount(14375)
	pUnit:SetMovementFlags(1)
	pUnit:SetPosition(-7850.64, -2652.3, 221.2, 1.8)
	pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 57008):SendChatMessage(12, 0, "Good luck, lad, ye'll need it!")
	if MountInfo[tostring(pUnit)].player:IsMounted() then
		MountInfo[tostring(pUnit)].player:Dismount()
	end
	MountInfo[tostring(pUnit)].player:CastSpell(MountInfo[tostring(pUnit)].aura)
	pUnit:RegisterEvent("RacingOverTheTrack", 6000, 1)
	pUnit:RegisterEvent("RaceTrackCountDown", 1000, 6)
	pUnit:RegisterEvent("Teleport_due_to_buggy_ground_Movement", 1000, 0)
	pUnit:RegisterEvent("PlayerTrackCheck", 1000, 0)
	pUnit:RegisterEvent("FonwickObjectOne", 21500, 1) -- game object spawning
end

function FonwickObjectOne(pUnit, event)
	pUnit:SpawnGameObject(146086, -7960.6, -2688.1, 200, 1.8, 30000, 100)
	pUnit:RegisterEvent("FonwickObjectTwo", 15500, 1)
end

function FonwickObjectTwo(pUnit, event)
	pUnit:SpawnGameObject(146086, -7879.9, -2746.2, 168, 0.6, 30000, 100)
	pUnit:RegisterEvent("FonwickObjectThree", 5000, 1)
end

function FonwickObjectThree(pUnit, event)
	pUnit:SpawnGameObject(146086, -7838.1, -2705.6, 173.1, 3.6, 30000, 100)
	pUnit:RegisterEvent("FonwickObjectFour", 7500, 1)
end

function FonwickObjectFour(pUnit,event)
	for i=1, 3, 1 do
		pUnit:SpawnCreature(50016, -7815.5+math.random(-10, 10), -2764.6+math.random(-10,10), 137.7, 1.8 , 21, 30000)
	end
	pUnit:GetCreatureNearestCoords(-7815.5, -2764.6, 134.7, 50016):SendChatMessage(14, 0, "Raaar, me crush you!")
end
-------------------------------------------------
-- TRIALS OF THE STEED: DORFUS IRONBEARD
-------------------------------------------------

function LastRace_Checking(pUnit, event)
	MountInfo[tostring(pUnit)] = {ready = false}
	pUnit:RegisterEvent("LastRace_Check", 3000, 0)
end

function LastRace_Check(pUnit, event)
	if MountInfo[tostring(pUnit)].ready == true then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("LastRaceStart", 10000, 1)
	end		
end

function Last_Race(pUnit, event, player, pMisc)
	pUnit:GossipCreateMenu(57013, player, 0)
	--if player:HasQuest(57014) then
		pUnit:GossipMenuAddItem(0, "Let's race!", 1, 0)
		pUnit:GossipMenuAddItem(0, "I'll pass.", 2, 0)
	--end
	pUnit:GossipSendMenu(player)
end

function LastRace_Choose(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
		if MountInfo[tostring(pUnit)].ready == true then
			player:SendAreaTriggerMessage("|cFFFF0000Track's currently in use. Please wait until Dorfus is back.")
			player:GossipComplete()
		else
			MountInfo[tostring(pUnit)] = {
				player = player, 
				aura = 60424, 
				track = 3, 
				racecount = 1, 
				countdown = 5, 
				ready = true, 
				quest = 0, 
				speed = 22, 
				distance = 18, 
				debug = false
			}
			pUnit:StopMovement(0)
			pUnit:SendChatMessage(12, 0, "Right fella, seems ye've come quite a bit, why dun't ye show what ye're made of?")
			player:GossipComplete()
			pUnit:SetNPCFlags(2)
			pUnit:MoveTo(-7801.51, -1130.8, 214.8, 0.2)
		end
	end
	
	if (intid == 2) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(57013, 1, "Last_Race")
RegisterUnitGossipEvent(57013, 2, "LastRace_Choose")
RegisterUnitEvent(57013, 18, "LastRace_Checking")

function LastRaceStart(pUnit, event)
	pUnit:SetMount(22719)
	pUnit:SetMovementFlags(2)
	pUnit:SetPosition(-7801.51, -1130.8, 214.8, 0.2)
	pUnit:MoveTo(-7801.51, -1130.8, 219.8, 0.2) 
	if MountInfo[tostring(pUnit)].player:IsMounted() then
		MountInfo[tostring(pUnit)].player:Dismount()
	end
	MountInfo[tostring(pUnit)].player:CastSpell(MountInfo[tostring(pUnit)].aura)
	pUnit:RegisterEvent("RacingOverTheTrack", 6000, 1)
	pUnit:RegisterEvent("RaceTrackCountDown", 1000, 6)
	pUnit:RegisterEvent("PlayerTrackCheck", 1000, 0)
	pUnit:RegisterEvent("Dorfus_GrapplePlayer", 47300, 1)
	pUnit:RegisterEvent("Dorfus_GrapplePlayerTwo", 75000, 1)
	pUnit:RegisterEvent("Dorfus_GrapplePreparation", 67000, 1)
	pUnit:RegisterEvent("Dorfus_PlayerParachute", 88000, 1)
end

function Dorfus_GrapplePreparation(pUnit, event)
	DorfTrigger = pUnit:GetUnitBySqlId(390890)
	DorfTrigger:CastSpell(20374)
	--DorfTrigger:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

function Dorfus_GrapplePlayer(pUnit, event)
	pUnit:CastSpellOnTarget(31705, MountInfo[tostring(pUnit)].player)
end

function Dorfus_GrapplePlayerTwo(pUnit, event)
	if MountInfo[tostring(pUnit)].player:GetDistanceYards(DorfTrigger) <= 8 then
		pUnit:CastSpellOnTarget(31705, MountInfo[tostring(pUnit)].player)	
	else
		MountInfo[tostring(pUnit)].player:SendBroadcastMessage("You missed the grapple!")
		PlayerLost(pUnit, event)
	end
	DorfTrigger:RemoveAura(1130)
end

function Dorfus_PlayerParachute(pUnit, event)
	MountInfo[tostring(pUnit)].player:Dismount()
	MountInfo[tostring(pUnit)].player:SetPlayerLock(true)
	pUnit:SetMovementFlags(1)
	MountInfo[tostring(pUnit)].player:MovePlayerTo(-7579.6, -1136.9, 260.8, 2.0, 12288)
	MountInfo[tostring(pUnit)].player:CastSpell(56093)
	pUnit:RegisterEvent("Dorfus_RemoveParachute", 12000, 1)
end

function Dorfus_RemoveParachute(pUnit, event)
	MountInfo[tostring(pUnit)].player:SetPlayerLock(false)
	MountInfo[tostring(pUnit)].player:RemoveAura(56093)
	MountInfo[tostring(pUnit)].player:AddItem(29104,1)
end

----------------------------------------
-- Horde Race - Loch Modan
----------------------------------------

function Loch_Checking(pUnit, event)
	MountInfo[tostring(pUnit)] = {ready = false} -- set her to false so she can be used
	pUnit:RegisterEvent("Loch_Check", 3000, 0) -- check if it's time for a race
end

function Loch_Check(pUnit, event)
	if MountInfo[tostring(pUnit)].ready == true then -- ready's set to true by gossip; let's go!
		pUnit:RemoveEvents() -- remove the 3 sec check
		pUnit:RegisterEvent("LochRaceStart", 7000, 1) -- start race
	end		
end

function Loch_Race(pUnit, event, player, pMisc)
	pUnit:GossipCreateMenu(100523, player, 0)
	if player:HasQuest(848) then
		pUnit:GossipMenuAddItem(0, "Let's race!", 1, 0)
		pUnit:GossipMenuAddItem(0, "I'll pass.", 2, 0)
	end
	pUnit:GossipSendMenu(player)
end

function Loch_Choose(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
		if MountInfo[tostring(pUnit)].ready == true then
			player:SendAreaTriggerMessage("|cFFFF0000Track's currently in use. Please wait until Grog is back.")
			player:GossipComplete()
		else
			MountInfo[tostring(pUnit)] = {
				player = player, 
				aura = 6653, 
				track = 4, 
				racecount = 1, 
				countdown = 5, 
				ready = true, 
				quest = 848, 
				speed = 11.5, 
				distance = 15, 
				debug = false
			}
			pUnit:StopMovement(0)
			pUnit:SendChatMessage(12, 0, "You fool, "..player:GetName()..". Try to keep up if you can!")
			player:GossipComplete()
			pUnit:SetNPCFlags(2)
			pUnit:MoveTo(-5806, -2847.7, 366,3)
		end
	end
	
	if (intid == 2) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(161911, 1, "Loch_Race")
RegisterUnitGossipEvent(161911, 2, "Loch_Choose")
RegisterUnitEvent(161911, 18, "Loch_Checking")

function LochRaceStart(pUnit, event)
	pUnit:SetMount(29260)
	pUnit:SetPosition(-5806, -2847.7, 366,3) 
	if MountInfo[tostring(pUnit)].player:IsMounted() then
		MountInfo[tostring(pUnit)].player:Dismount()
	end
	MountInfo[tostring(pUnit)].player:CastSpell(MountInfo[tostring(pUnit)].aura)
	pUnit:RegisterEvent("RacingOverTheTrack", 6000, 1)
	pUnit:RegisterEvent("RaceTrackCountDown", 1000, 6)
	pUnit:RegisterEvent("PlayerTrackCheck", 1000, 0)
	pUnit:RegisterEvent("Teleport_due_to_buggy_ground", 39000, 1)
end

function Teleport_due_to_buggy_ground(pUnit, Event)
	pUnit:CastSpell(64446)
	pUnit:SetPosition(-6097.5991210938,-2928.0112304688,418.78039550781,2.2250299453735)
	pUnit:CastSpell(64446)
	pUnit:SetMount(29260)
	pUnit:SetMovementFlags(1)
	pUnit:RegisterEvent("Teleport_due_to_buggy_ground_Movement", 1000, 0)
end

function Teleport_due_to_buggy_ground_Movement(pUnit)
	pUnit:SetMovementFlags(1)
end

--------------------------
-- Captain "Rush"
--------------------------

function Water_Checking(pUnit, event)
	MountInfo[tostring(pUnit)] = {ready = false} -- set her to false so she can be used
	pUnit:RegisterEvent("Water_Check", 1000, 0) -- check if it's time for a race
end

function Water_Check(pUnit, event)
	if MountInfo[tostring(pUnit)].ready == true then -- ready's set to true by gossip; let's go!
		pUnit:RemoveEvents() -- remove the 3 sec check
		pUnit:SetMovementFlags(2)
		pUnit:RegisterEvent("WaterRaceStart", 7000, 1) -- start race
		pUnit:RegisterEvent("Water_SEtPosition", 3300, 1) -- 2300
	end		
end

function Water_SEtPosition(pUnit)
	pUnit:SetPosition(-9426,-2500,54.61, 1.924178)
	pUnit:Root()
end

function Water_Race(pUnit, event, player, pMisc)
	pUnit:GossipCreateMenu(6794, player, 0)
	pUnit:GossipMenuAddItem(0, "Bring it on!", 1, 0)
	pUnit:GossipMenuAddItem(0, "I'll pass.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function Water_Choose(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
		if MountInfo[tostring(pUnit)].ready == true then
			player:SendAreaTriggerMessage("|cFFFF0000Track's currently in use. Please wait until the captain is back.")
			player:GossipComplete()
		else
			player:SetFacing(1.924178)
			player:MoveKnockback(-9426,-2500,54.61,7,14)
			MountInfo[tostring(pUnit)] = {
				player = player, 
				aura = 64731, 
				track = 5, 
				racecount = 1, 
				countdown = 5, 
				ready = true, 
				quest = 0, 
				speed = 7.5, 
				distance = 15, 
				debug = false
			}
			pUnit:StopMovement(0)
			pUnit:SendChatMessage(12, 0, "Ha, this will be all too easy!")
			player:GossipComplete()
			pUnit:SetFlying()
			pUnit:SetNPCFlags(2)
			pUnit:SetFacing(1.924178)
			pUnit:MoveKnockback(-9426,-2500,54.61,3,4)
		end
	end
	
	if (intid == 2) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(262461, 1, "Water_Race")
RegisterUnitGossipEvent(262461, 2, "Water_Choose")
RegisterUnitEvent(262461, 18, "Water_Checking")

function WaterRaceStart(pUnit, event)
	pUnit:SetMount(17158) -- 29161
	pUnit:Unroot()
	if MountInfo[tostring(pUnit)].player:IsMounted() then
		MountInfo[tostring(pUnit)].player:Dismount()
	end
	MountInfo[tostring(pUnit)].player:CastSpell(MountInfo[tostring(pUnit)].aura)
	pUnit:RegisterEvent("RacingOverTheTrack", 6000, 1)
	pUnit:RegisterEvent("RaceTrackCountDown", 1000, 6)
	pUnit:RegisterEvent("PlayerTrackCheck", 1000, 0)
	pUnit:RegisterEvent("SharkEventRoot", 63000, 1)
	pUnit:RegisterEvent("LandPhaseChangeMovement", 87000, 1)
	pUnit:RegisterEvent("AddRewardSeaRace", 240000, 1)
end

function SharkEventRoot(pUnit)
	local sharka = pUnit:SpawnCreature(23928, -9522, -2488, 43, 6.05, 21, 60000)
	local sharkb = pUnit:SpawnCreature(23928, -9517, -2469, 43, 5.929, 21, 60000)
	sharka:SetMovementFlags(2)
	sharkb:SetMovementFlags(2)
	sharka:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0)
	sharkb:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 0)
end

function LandPhaseChangeMovement(pUnit)
	pUnit:Land()
	pUnit:SetMovementFlags(1)
end

function SharkMoveSpawn(pUnit, Event)
	pUnit:RegisterEvent("Wait_LessTHanASEcond", 750, 1)
end

function Wait_LessTHanASEcond(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), 0)
	end
end

function AddRewardSeaRace(pUnit)
	MountInfo[tostring(pUnit)].player:AddItem(46109,1)
	MountInfo[tostring(pUnit)].player:Dismount()
end

RegisterUnitEvent(23928, 18, "SharkMoveSpawn")

--------------------------
-- RACE FUNCTIONS
--------------------------

function ResetTrack(pUnit, event)
	if MountInfo[tostring(pUnit)].player:HasAura(MountInfo[tostring(pUnit)].aura) then
		MountInfo[tostring(pUnit)].player:RemoveAura(MountInfo[tostring(pUnit)].aura)
	end
	local DorfusTrigger = pUnit:GetUnitBySqlId(390890)	
	if DorfusTrigger ~= nil and DorfusTrigger:HasAura(1130) then
		DorfusTrigger:RemoveAura(1130)
	end
	MountInfo[tostring(pUnit)] = {}
	pUnit:RemoveEvents()
	--pUnit:ModifyWalkSpeed(2.5)
	pUnit:SetMount(0)
	pUnit:SetMovementFlags(0)
	pUnit:Despawn(5000, 1000)
end

function PlayerTrackCheck(pUnit, event)
	if MountInfo[tostring(pUnit)].player ~= nil then
		if pUnit:GetDistanceYards(MountInfo[tostring(pUnit)].player) >= MountInfo[tostring(pUnit)].distance then
			PlayerLost(pUnit, event)
		end
	else
		PlayerLost(pUnit, event)
	end
end

function PlayerLost(pUnit, event)
	if MountInfo[tostring(pUnit)].player ~= nil then
		pUnit:SendChatMessageToPlayer(42, 0, "You have lost. Try again!", MountInfo[tostring(pUnit)].player)
	end
	pUnit:SetMovementFlags(0)
	ResetTrack(pUnit, event)
end

function RaceTrackCountDown(pUnit, event)
	if MountInfo[tostring(pUnit)].player ~= nil then
		if MountInfo[tostring(pUnit)].countdown > 0 then
			pUnit:SendChatMessageToPlayer(42, 0, "Race starting in "..tostring(MountInfo[tostring(pUnit)].countdown).." seconds!", MountInfo[tostring(pUnit)].player)
			MountInfo[tostring(pUnit)].countdown = MountInfo[tostring(pUnit)].countdown - 1
		else
			pUnit:SendChatMessageToPlayer(42, 0, "GO!", MountInfo[tostring(pUnit)].player)
			if (pUnit:GetEntry() == 262461) then
				pUnit:SetMovementFlags(2)
			else
				pUnit:SetMovementFlags(1)
			end
		end
	else
		PlayerLost(pUnit, event)
	end
end

function RacingOverTheTrack(pUnit, event)
	if MountInfo[tostring(pUnit)].debug == true then
		pUnit:SendChatMessage(12, 0, "DEBUG | RACING OVER THE TRACK | COUNT: "..MountInfo[tostring(pUnit)].racecount.." | DISTANCE: "..MountInfo[tostring(pUnit)].distance.." |")
	end
	
	if RaceLocations[MountInfo[tostring(pUnit)].track][MountInfo[tostring(pUnit)].racecount][6] ~= nil then
		pUnit:SendChatMessage(12, 0, RaceLocations[MountInfo[tostring(pUnit)].track][MountInfo[tostring(pUnit)].racecount][6])
	end
	
	if RaceLocations[MountInfo[tostring(pUnit)].track][MountInfo[tostring(pUnit)].racecount].distance ~= nil then
		MountInfo[tostring(pUnit)].distance = RaceLocations[MountInfo[tostring(pUnit)].track][MountInfo[tostring(pUnit)].racecount].distance
	end
	
	if MountInfo[tostring(pUnit)].racecount == #RaceLocations[MountInfo[tostring(pUnit)].track] then
		PlayerWon(pUnit, event)
		if MountInfo[tostring(pUnit)].debug == true then
			pUnit:SendChatMessage(12, 0, "DEBUG | END OF TABLE REACHED")
		end
		return
	end
	
	pUnit:MoveTo(RaceLocations[MountInfo[tostring(pUnit)].track][MountInfo[tostring(pUnit)].racecount][1], RaceLocations[MountInfo[tostring(pUnit)].track][MountInfo[tostring(pUnit)].racecount][2], RaceLocations[MountInfo[tostring(pUnit)].track][MountInfo[tostring(pUnit)].racecount][3], RaceLocations[MountInfo[tostring(pUnit)].track][MountInfo[tostring(pUnit)].racecount][4])
	pUnit:RegisterEvent("RacingOverTheTrack", RaceLocations[MountInfo[tostring(pUnit)].track][MountInfo[tostring(pUnit)].racecount][5], 1)
	MountInfo[tostring(pUnit)].racecount = MountInfo[tostring(pUnit)].racecount + 1
end

function PlayerWon(pUnit, event)
	pUnit:SendChatMessageToPlayer(42, 0, "You have won the race! Congratulations!", MountInfo[tostring(pUnit)].player)
	if MountInfo[tostring(pUnit)].debug == false then
		if MountInfo[tostring(pUnit)].player:HasQuest(MountInfo[tostring(pUnit)].quest) then
		MountInfo[tostring(pUnit)].player:MarkQuestObjectiveAsComplete(MountInfo[tostring(pUnit)].quest, 0)
		end
	end
	ResetTrack(pUnit, event)
end
]]