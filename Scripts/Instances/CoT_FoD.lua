DAL = {}
DAL.VAR = {}

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local UNIT_FIELD_CHARMEDBY = OBJECT_END + 0x0006
local UNIT_FIELD_CHARM = OBJECT_END + 0x0000
local UNIT_FLAG_PVP_ATTACKABLE = 0x00000008
local UNIT_FLAG_PLAYER_CONTROLLED_CREATURE = 0x01000000
local UNIT_END = OBJECT_END + 0x008E
local PLAYER_DUEL_TEAM = UNIT_END + 0x0008
local PLAYER_DUEL_ARBITER = UNIT_END + 0x0000
local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3



function DAL.VAR.ANTONIDAS_START_SPAWN(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	pUnit:SetPhase(2)
	DAL[id].VAR.ANTONIDAS = pUnit
end
RegisterUnitEvent(323232, 18, "DAL.VAR.ANTONIDAS_START_SPAWN")


function DAL.VAR.STARTEVENTTRIGGERS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	if DAL[id].VAR.StartCinematic then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("DAL.VAR.CINEMATICSTART",1000,1)
	end
end

function DAL.VAR.ARTHAS_START_SPAWN(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	pUnit:EquipWeapons(36942,0,0)
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
	DAL[id].VAR.ARTHAS = pUnit
	pUnit:RegisterEvent("DAL.VAR.STARTEVENTTRIGGERS",1000,0)
	pUnit:RegisterEvent("DAL.VAR.ARTHAS_IntoTheSewers",1000,0)
end

function DAL.VAR.ARTHAS_IntoTheSewers(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	if DAL[id].VAR.Auras == 2 then
		if not DAL[id].VAR.ARTHAS:IsInCombat() then
			local player = pUnit:GetClosestPlayer()
			if player and pUnit:GetDistanceYards(player) < 8 then
				pUnit:RemoveEvents()
				pUnit:SendChatMessage(12,0,"You five head into the sewers.")
				pUnit:MoveTo(2804,1895.98,166.63,1.83)
				pUnit:RegisterEvent("DAL.VAR.Arthas_YellSewers",4000,1)
			end
		end
	end
end

function DAL.VAR.Arthas_YellSewers(pUnit,Event)
	pUnit:CastSpell(32992)
	pUnit:SendChatMessage(12,0,"Now Frostmourne!")
	pUnit:PlaySoundToSet(18148)
	local object = pUnit:GetGameObjectNearestCoords(2801.32,1903.22,164.94,3266354)
	if object then
		object:SetByte(0x0006+0x000B,0,0)
		object:Despawn(3000,0)
	end
	pUnit:RegisterEvent("DAL.VAR.KT_WhisperSewers",4000,1)
end

function DAL.VAR.KT_WhisperSewers(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.KT:SendChatMessage(15,0,"The Kirin Tor keeps these creatures caged for studying. If they were to be released, they would cause our enemies a great deal of pain.")
	pUnit:PlaySoundToSet(18158)
end

function DAL.VAR.ARTHAS_START_COMBAT(pUnit,Event) -- need to reformat
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 25 then
			local chance = math.random(1,7)
			if chance == 1 then
				pUnit:SendChatMessageToPlayer(12,0,"Fateless coward!",players)
				players:PlaySoundToPlayer(18144)
			elseif chance == 2 then
				pUnit:SendChatMessageToPlayer(12,0,"Your pain shall be legendary!",players)
				players:PlaySoundToPlayer(18146)
			elseif chance == 3 then
				pUnit:SendChatMessageToPlayer(12,0,"You will know endless torment!",players)
				players:PlaySoundToPlayer(18145)
			elseif chance == 4 then
				pUnit:SendChatMessageToPlayer(12,0,"I'll make sure you suffer!",players)
				players:PlaySoundToPlayer(18147)
			elseif chance == 5 then
				pUnit:SendChatMessageToPlayer(12,0,"Now Frostmourne!",players)
				players:PlaySoundToPlayer(18148)
			end
		end
	end
end

RegisterUnitEvent(32326, 18, "DAL.VAR.ARTHAS_START_SPAWN")
RegisterUnitEvent(32326, 1, "DAL.VAR.ARTHAS_START_COMBAT")

function DAL.VAR.KT_START_SPAWN(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.KT = pUnit
end

RegisterUnitEvent(30061, 18, "DAL.VAR.KT_START_SPAWN")


function DAL.VAR.KIRINTORMAGE_SPAWN(pUnit,Event)
	pUnit:RegisterEvent("DAL.VAR.TeleportVisual", 500,1)
	pUnit:RegisterEvent("DAL.VAR.MAGEMOVETO",1500,1)
	pUnit:Root()
end

function DAL.VAR.TeleportVisual(pUnit)
	pUnit:CastSpell(64446)
	pUnit:SetMovementFlags(1)
end

function DAL.VAR.SPAWNMAGE(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	if DAL[id].VAR.Auras > 2 then
		pUnit:SpawnCreature(20422,2841.29 ,1969.50,169.82,1.76, 14, 60000, 25494, 0, 0)
		pUnit:RegisterEvent("DAL.VAR.SPAWNMAGE", math.random(4000, 7000), 1)
	end
end

function DAL.VAR.MAGEMOVETO(pUnit,Event)
	pUnit:Unroot()
	pUnit:MoveTo(2836.42, 1995.24, 166.51,1.74)
end

RegisterUnitEvent(20422, 18,"DAL.VAR.KIRINTORMAGE_SPAWN")

function DAL.VAR.KIRINTORMAGE_LEAVE(pUnit)
	pUnit:Despawn(1,0)
end

RegisterUnitEvent(20422, 2,"DAL.VAR.KIRINTORMAGE_LEAVE")

function DAL.VAR.Cinematic_start_Gossipc(pUnit, event, player)
	pUnit:GossipCreateMenu(12949, player, 0)
	pUnit:GossipMenuAddItem(9, "Let us begin.", 424, 0)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 526, 0)
	pUnit:GossipSendMenu(player)
end


function DAL.VAR.Cinematic_start_Gossipm(pUnit, event, player, id, intid, code)
	player:GossipComplete()
	if(intid == 424) then
		pUnit:SetNPCFlags(2)
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		DAL[id] = DAL[id] or {VAR={}}
		DAL[id].VAR.StartCinematic = true
	end
end

RegisterUnitGossipEvent(10667, 1, "DAL.VAR.Cinematic_start_Gossipc")
RegisterUnitGossipEvent(10667, 2, "DAL.VAR.Cinematic_start_Gossipm")


function DAL.VAR.CINEMATICSTART(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ARTHAS:Emote(1,0)
	DAL[id].VAR.ARTHAS:SendChatMessage(14,0,"Wizards of the Kirin'Tor, I am Arthas, first of the Lich King's death knights. I demand that you open your gates and surrender to the might of the Scourge.")
	DAL[id].VAR.ARTHAS:PlaySoundToSet(18149)
	DAL[id].VAR.ANTONIDAS:SetPhase(3)
	pUnit:RegisterEvent("DAL.VAR.CINEMATIC_DIALOGUE",11100,1)
	pUnit:RegisterEvent("DAL.VAR.CINEMATIC_SPELL_CAST",1000,1)
end

function DAL.VAR.CINEMATIC_SPELL_CAST(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ANTONIDAS:CastSpell(64446)
end

function DAL.VAR.CINEMATIC_DIALOGUE(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ANTONIDAS:SendChatMessage(14,0,"Greetings, Prince Arthas. How fares your noble father?")
	DAL[id].VAR.ANTONIDAS:PlaySoundToSet(18162)
	DAL[id].VAR.ANTONIDAS:Emote(1,0)
	pUnit:RegisterEvent("DAL.VAR.CINEMATIC_DIALOGUEX",6000,1)
end

function DAL.VAR.CINEMATIC_DIALOGUEX(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ARTHAS:SendChatMessage(14,0,"Lord Antonidas. Theres no need to be snide.")
	DAL[id].VAR.ARTHAS:PlaySoundToSet(18150)
	DAL[id].VAR.ARTHAS:Emote(1,0)
	pUnit:RegisterEvent("DAL.VAR.CINEMATIC_DIALOGUEXX",5000,1)
end

function DAL.VAR.CINEMATIC_DIALOGUEXX(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ANTONIDAS:SendChatMessage(14,0,"We've prepared for your coming, Arthas. My brethren and I have erected auras that will destroy any undead that pass through them!")
	DAL[id].VAR.ANTONIDAS:PlaySoundToSet(18163)
	DAL[id].VAR.ANTONIDAS:Emote(1,0)
	pUnit:RegisterEvent("DAL.VAR.CINEMATIC_DIALOGUEXXX",10100,1)
end

function DAL.VAR.CINEMATIC_DIALOGUEXXX(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ARTHAS:SendChatMessage(14,0,"Your petty magics will not stop me, Antonidas.")
	DAL[id].VAR.ARTHAS:PlaySoundToSet(18151)
	DAL[id].VAR.ARTHAS:Emote(15,0)
	pUnit:RegisterEvent("DAL.VAR.CINEMATIC_DIALOGUEXXXX",4100,1)
end

function DAL.VAR.CINEMATIC_DIALOGUEXXXX(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ANTONIDAS:SendChatMessage(14,0,"Pull your troops back or we will be forced to unleash our full powers against you! Make your choice, death knight.")
	DAL[id].VAR.ANTONIDAS:PlaySoundToSet(18164)
	DAL[id].VAR.ANTONIDAS:Emote(1,0)
	pUnit:RegisterEvent("DAL.VAR.CINEMATIC_ANTONIDAS_LEAVES",9000,1)
end

function DAL.VAR.CINEMATIC_ANTONIDAS_LEAVES(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ANTONIDAS:CastSpell(64446)
	DAL[id].VAR.ANTONIDAS:Despawn(1000,0)
	pUnit:RegisterEvent("DAL.VAR.STARTINSTANCE_CINEMATICOVER",2000,1)
	pUnit:RegisterEvent("DAL.VAR.SPAWNMAGE",5000,1)
	local object = pUnit:GetGameObjectNearestCoords(2843, 1968, 169.78, 3264396)
	if object then
		object:SetPhase(1)
	end
end

function DAL.VAR.STARTINSTANCE_CINEMATICOVER(pUnit,Event)
	for _,portal in pairs(pUnit:GetInRangeObjects()) do 
		if portal:GetEntry() == 3264396 then
			portal:SetPhase(1)
		end
	end
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.Auras = 3
	DAL[id].VAR.Wave = 0
	DAL[id].VAR.Dead = 0
	DAL[id].VAR.KT:SendChatMessage(14,0,"I sense that three separate wizards are maintaining these auras. If you find and kill them, the auras will disperse.")
	DAL[id].VAR.KT:PlaySoundToSet(18156)
	DAL[id].VAR.StartCinematic = false
	local object = DAL[id].VAR.KT:GetGameObjectNearestCoords(2849.35,1934.91, 168.06, 3266354)
	if object then
		object:SetByte(0x0006+0x000B,0,0)
		object:Despawn(3000,0)
	end
	for _,plrs in pairs(DAL[id].VAR.KT:GetInRangePlayers()) do
		azUpdateWorldstatesUI(plrs)
		azzUpdateAttempts(plrs, DAL[id].VAR.Auras)
	--	pUnit:SendChatMessageToPlayer(42, 0, "Auras Remaining: "..DAL[id].VAR.Auras.."!", plrs) -- 1
	end
end

			
	

---first boss--

function DAL.VAR.CheckDistanceA(pUnit)
	local id = pUnit:GetInstanceID() or 1
	DAL[id] = DAL[id] or {VAR={}}
	if DAL[id].VAR.Sinclari and pUnit:GetDistanceYards(DAL[id].VAR.Sinclari) > 40 then
		DAL[id].VAR.Sinclari:SendChatMessage(14,0,"Do not think to take my guardian away from me!")
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			if v:IsAlive() then
				pUnit:CastSpellOnTarget(11, v)
			end
		end
	end
end

function DAL.VAR.Sinclari_Events(pUnit,Event)
	local id = pUnit:GetInstanceID() or 1
	DAL[id] = DAL[id] or {VAR={}}
	if Event == 1 then
		DAL[id].VAR.Sinclari:CastSpell(63364)
		DAL[id].VAR.Sinclari:SendChatMessage(14,0,"Scourge filth, destroy them my guardian!")
		pUnit:RegisterEvent("DAL.VAR.CheckDistanceA", 1000, 0)
		pUnit:RegisterEvent("DAL.VAR.Sinclari_Lifeshare", 1000,1)
		pUnit:RegisterEvent("DAL.VAR.Sinclari_Frostbomb", math.random(6000,8200),0)
		--pUnit:RegisterEvent("DAL.VAR.SINCLARI_FROSTBUFFET", math.random(2000,5100),0)
		pUnit:RegisterEvent("DAL.VAR.GUARDIAN_CHAINLIGHTNING", math.random(8000,16000),0)
		pUnit:RegisterEvent("DAL.VAR.Sinclari_TimeBomb", math.random(8000,11000),0)
		local object = pUnit:GetGameObjectNearestCoords(2748.11, 1903.99, 174.16, 3266385)
		if object then
			object:SetPhase(1)
		end
	elseif Event == 2 then
		pUnit:RemoveEvents()
		DAL[id].VAR.Sinclari:Despawn(1,5000)
		pUnit:Despawn(1,5000)
		DAL[id].VAR.Sinclari:RemoveAura(63364)
		local object = pUnit:GetGameObjectNearestCoords(2748.11, 1903.99, 174.16, 3266385)
		if object then
			object:SetPhase(2)
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:Kill(DAL[id].VAR.Sinclari)
		DAL[id].VAR.Auras = 2
		DAL[id].VAR.KT:SendChatMessage(14,0,"The Archmage has been killed. The first aura is dispersing.")
		DAL[id].VAR.KT:PlaySoundToSet(18157)
		local object = pUnit:GetGameObjectNearestCoords(2748.11, 1903.99, 174.16, 3266385)
		if object then
			object:Despawn(1,0)
		end
		DAL[id].VAR.ARTHAS:Despawn(1,0)
		DAL[id].VAR.KT:Despawn(1,0)
		pUnit:SpawnCreature(30061,2784.30,1890.66,167.84,5.7,35,0)
		pUnit:SpawnCreature(32326,2808.25,1886.92,166.92,2.2,35,0)
		for _,creatures in pairs(DAL[id].VAR.KT:GetInRangeUnits()) do 
			if creatures:GetEntry() == 28565 then
				creatures:SetPhase(1)
			end
		end
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			azzUpdateAttempts(v, DAL[id].VAR.Auras)
		end
	end
end

function DAL.VAR.SINCLARI_FROSTBUFFET(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 75 then
			if players:IsAlive() then
				DAL[id].VAR.Sinclari:CastSpellOnTarget(58025,players)
			end
		end
	end
end

function DAL.VAR.SINCLARI_FROSTBOLT(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local plr = DAL[id].VAR.Sinclari:GetRandomPlayer(0)
	if plr then
		if DAL[id].VAR.Sinclari:GetDistanceYards(plr) < 70 then
			if not plr:IsDead() then
				DAL[id].VAR.Sinclari:FullCastSpellOnTarget(15530,plr)
			end
		end
	end
end

function DAL.VAR.Sinclari_Lifeshare(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local hpcosts = pUnit:GetHealth() 
	DAL[id].VAR.Sinclari:SetHealth(hpcosts)
	pUnit:RegisterEvent("DAL.VAR.Sinclari_Lifeshare", 1000,1)
end
	
function DAL.VAR.Sinclari_leash(pUnit,Event)
	if pUnit:GetDistanceYards(DAL[id].VAR.Sinclari) > 51.5 then
		DAL[id].VAR.Sinclari:SendChatMessage(14,0,"You dare try to take my guardian away from me!? Perish!")
		pUnit:RegisterEvent("DAL.VAR.Sinclari_KillAllPlayers", 1000,1)
	end
end

function DAL.VAR.Sinclari_KillAllPlayers(pUnit)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 60 then
			if players:IsAlive() then
				DAL[id].VAR.Sinclari:CastSpellOnTarget(72502,players)
			end
		end
	end
end


function DAL.VAR.Sinclari_Frostbomb(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	if DAL[id].VAR.Sinclari:GetCurrentSpellId() then
		DAL[id].VAR.Sinclari:CancelSpell()
	end
	local player = DAL[id].VAR.Sinclari:GetRandomPlayer(0)
	if player then
		if DAL[id].VAR.Sinclari:GetDistanceYards(player) < 70 then
			DAL[id].VAR.Sinclari:FullCastSpellOnTarget(51103,player)
		end
	end
end
	
function DAL.VAR.GUARDIAN_CHAINLIGHTNING(pUnit)
	local plr = pUnit:GetRandomPlayer(1)
	if plr then
		if pUnit:GetDistanceYards(plr) < 70 then
			if not plr:IsDead() then
				pUnit:CastSpellOnTarget(32690,plr)
			end
		end
	end
end

	
function DAL.VAR.Sinclari_TimeBomb(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local player = DAL[id].VAR.Sinclari:GetRandomPlayer(0)
	if player then
		if DAL[id].VAR.Sinclari:GetDistanceYards(player) < 70 then
			DAL[id].VAR.Sinclari:CastSpellOnTarget(51121,player)
		end
	end
end

function DAL.VAR.Sinclari_Spawn(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.Sinclari = pUnit
end


RegisterUnitEvent(24777, 1, "DAL.VAR.Sinclari_Events")
RegisterUnitEvent(24777, 4, "DAL.VAR.Sinclari_Events")
RegisterUnitEvent(24777, 2, "DAL.VAR.Sinclari_Events")
RegisterUnitEvent(24777, 3, "DAL.VAR.Sinclari_Events")
RegisterUnitEvent(30658, 18, "DAL.VAR.Sinclari_Spawn")


function DAL.VAR.ArcaneController_Events(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(42,0,"The Sewer Creatures have been released from the controller's grasp.")
	for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
		if creatures:GetEntry() == 1498121 then
			if pUnit:GetDistanceYards(creatures) < 50 then
				creatures:SetFaction(1857)
				creatures:CastSpell(6742)
			end
		end
	end
end

RegisterUnitEvent(198231, 4, "DAL.VAR.ArcaneController_Events")

---Boss Two--

function DAL.VAR.THEFORGOTTEN_Events(pUnit,Event)
	if Event == 1 then
	pUnit:SendChatMessage(14,0,"Your flesh, yes yes, so perfect, GIVE IT TO US!")
	pUnit:PlaySoundToSet(50045)
	pUnit:RegisterEvent("DAL.VAR.THEFORGOTTEN_PHASETWO", 1000,0)
	--pUnit:RegisterEvent("DAL.VAR.GASSPORE_FORGOTTEN", math.random(12000,16000),0)
	--pUnit:RegisterEvent("DAL.VAR.HEMO_FORGOTTEN", math.random(6000,12000),0)
	pUnit:RegisterEvent("DAL.VAR.VILEGAS_FORGOTTEN", math.random(16500,21000),0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
		if pUnit:IsAlive() then
			pUnit:Despawn(1,5000)
		end
	elseif Event == 3 then
		pUnit:SendChatMessage(14,0,"Who is perfect now? Yes, yes...")
		pUnit:PlaySoundToSet(50047)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		pUnit:SpawnCreature(177799,2911.38, 1915.69, 88.14, 0, 35, 0)
		pUnit:SendChatMessage(14,0,"Again... we are torn apart... Again... to the cold darkness...")
		pUnit:PlaySoundToSet(50046)
		local object = pUnit:GetGameObjectNearestCoords(2962.69,1754.79,155.97,3266354)
		if object then
		object:SetByte(0x0006+0x000B,0,0)
		object:Despawn(3000,0)
	end
	local objectz = pUnit:GetGameObjectNearestCoords(2978.04,1835.21,158.47,3266354)
	if objectz then
		objectz:SetByte(0x0006+0x000B,0,0)
		objectz:Despawn(3000,0)
	end
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 60 then
			if not players:IsDead() then
				players:RemoveAura(72451)
			end
		end
	end
	elseif Event == 18 then
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		DAL[id] = DAL[id] or {VAR={}}
		DAL[id].VAR.Forgotten = pUnit
		pUnit:SetScale(2.5)
	end
end
	
function DAL.VAR.THEFORGOTTEN_PHASETWO(pUnit,Event)
	if pUnit:GetHealthPct() < 60 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(71603)
		pUnit:SetScale(2.8)
		pUnit:SendChatMessage(14,0,"No, no, no! The pain returns!")
		pUnit:PlaySoundToSet(50048)
		pUnit:RegisterEvent("DAL.VAR.THEFORGOTTEN_PHASETHREE", 1000,0)
		--pUnit:RegisterEvent("DAL.VAR.GASSPORE_FORGOTTEN", math.random(12000,16000),0)
		--pUnit:RegisterEvent("DAL.VAR.HEMO_FORGOTTEN", math.random(6000,10000),0)
		pUnit:RegisterEvent("DAL.VAR.VILEGAS_FORGOTTEN", math.random(16500,21000),0)
	end
end
	
function DAL.VAR.THEFORGOTTEN_PHASETHREE(pUnit,Event)
	if pUnit:GetHealthPct() < 30 then
		pUnit:RemoveEvents()
		pUnit:SetScale(3.2)
		pUnit:SendChatMessage(14,0,"It tears at us from the inside!")
		pUnit:PlaySoundToSet(50049)
		--pUnit:RegisterEvent("DAL.VAR.GASSPORE_FORGOTTEN", math.random(12000,16000),0)
		--pUnit:RegisterEvent("DAL.VAR.HEMO_FORGOTTEN", math.random(6000,10000),0)
		pUnit:RegisterEvent("DAL.VAR.VILEGAS_FORGOTTEN", math.random(13500,16000),0)
		pUnit:RegisterEvent("DAL.VAR.MUTATEDPLAGUE", 25000,0)
		for _, players in pairs(pUnit:GetInRangePlayers()) do
			if pUnit:GetDistanceYards(players) < 60 then
				if not players:IsDead() then
					pUnit:CastSpellOnTarget(72451,players)
				end
			end
		end
	end
end

function DAL.VAR.HEMO_FORGOTTEN(pUnit)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 60 then
			if not players:IsDead() then
				pUnit:CastSpellOnTarget(16511,players)
			end
		end
	end
end

function DAL.VAR.GASSPORE_FORGOTTEN(pUnit)
	pUnit:CastSpell(69278)
end

function DAL.VAR.VILEGAS_FORGOTTEN(pUnit)
	local tank = pUnit:GetMainTank()
	if tank then
		if pUnit:GetDistanceYards(tank) < 60 then
			pUnit:CastSpellOnTarget(69240,tank)
		end
	end
end

function DAL.VAR.MUTATEDPLAGUE(pUnit)
	for _, players in pairs(pUnit:GetInRangePlayers()) do
		if pUnit:GetDistanceYards(players) < 60 then
			if not players:IsDead() then
				pUnit:CastSpellOnTarget(72451,players)
			end
		end
	end
end
	
RegisterUnitEvent(3581, 1, "DAL.VAR.THEFORGOTTEN_Events")
RegisterUnitEvent(3581, 4, "DAL.VAR.THEFORGOTTEN_Events")
RegisterUnitEvent(3581, 2, "DAL.VAR.THEFORGOTTEN_Events")
RegisterUnitEvent(3581, 3, "DAL.VAR.THEFORGOTTEN_Events")
RegisterUnitEvent(3581, 18, "DAL.VAR.THEFORGOTTEN_Events")
	
function DAL.VAR.ForgottenDummy(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ff = 0
	pUnit:SetUInt32Value(UNIT_FIELD_BYTES_2, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("DAL.VAR.ForgottenCheck",1500,0)
end

function DAL.VAR.ForgottenCheck(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local player = pUnit:GetClosestPlayer()
	if player then
		if pUnit:GetDistanceYards(player) < 5 then
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("DAL.VAR.Forgottencheckingz",1000,1)
		end
	end	
end

function DAL.VAR.Forgottencheckingz(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.ff = DAL[id].VAR.ff + 1
	if DAL[id].VAR.ff == 1 then
		DAL[id].VAR.Forgotten:SendChatMessage(14,0,"So cold, so dark...!")
		DAL[id].VAR.Forgotten:PlaySoundToSet(50041)
		pUnit:RegisterEvent("DAL.VAR.Forgottencheckingz",6000,1)
	elseif DAL[id].VAR.ff == 2 then
		DAL[id].VAR.Forgotten:SendChatMessage(14,0,"We will not be forgotten, no, no, no...")
		DAL[id].VAR.Forgotten:PlaySoundToSet(50042)
		pUnit:RegisterEvent("DAL.VAR.Forgottencheckingz",8000,1)
	elseif DAL[id].VAR.ff == 3 then
		DAL[id].VAR.Forgotten:SendChatMessage(14,0,"We are the perfect one, yes, yes, not a failure, no, no, not a failure...")
		DAL[id].VAR.Forgotten:PlaySoundToSet(50043)
	end
end

RegisterUnitEvent(177798, 18, "DAL.VAR.ForgottenDummy")

function DAL.VAR.FORGOTTEN_EXITCAST(pUnit,Event)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if pUnit:GetDistanceYards(plr) < 3 then
			plr:Teleport(560, 2922.86,1782.04,135.32)
		end
	end
end

function DAL.VAR.FORGOTTENEXIT_Spawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("DAL.VAR.FORGOTTEN_EXITCAST",500,0) 
end
  
  RegisterUnitEvent(177799, 18, "DAL.VAR.FORGOTTENEXIT_Spawn")
  
  function DAL.VAR.FORGOTTEN_FRONTCAST(pUnit,Event)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if pUnit:GetDistanceYards(plr) < 3 then
			plr:Teleport(560, 2819.12,1852.58,88.19)
		end
	end
end

function DAL.VAR.FORGOTTENFRONT_Spawn(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("DAL.VAR.FORGOTTEN_FRONTCAST",500,0) 
end
  
RegisterUnitEvent(177899, 18, "DAL.VAR.FORGOTTENFRONT_Spawn")

-- Le X boss

function DAL.VAR.LeBossEvents(pUnit, Event)
	if Event == 1 then
		local object = pUnit:GetGameObjectNearestCoords(2980.28, 1835.53, 162.517, 3266385)
		if object then
			object:SetPhase(1)
		end
		object = pUnit:GetGameObjectNearestCoords(3007.88, 1824.92, 160.938, 146086)
		if object then
			object:SetPhase(1)
		end
		pUnit:RegisterEvent("DAL.VAR.AIEventRexArcaneExplosion", 7000, 0)
		pUnit:RegisterEvent("DAL.VAR.AIEventRexArcaneMissiles", 8000, 0)
		pUnit:RegisterEvent("DAL.VAR.AIEventRexSpawnMinions", 15000, 0)
		pUnit:RegisterEvent("DAL.VAR.AIEventRexPhase2", 1000, 0)
	elseif Event == 2 or Event == 4 then
		pUnit:StopChannel()
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(2980.28, 1835.53, 162.517, 3266385)
		if object then
			object:SetPhase(2)
		end
		object = pUnit:GetGameObjectNearestCoords(3007.88, 1824.92, 160.938, 146086)
		if object then
			object:SetPhase(2)
		end
		if Event == 4 then
			local id = pUnit:GetInstanceID()
			if id == nil then id = 1 end
			DAL[id] = DAL[id] or {VAR={}}
			DAL[id].VAR.Auras = 1
					DAL[id].VAR.ARTHAS:Despawn(1,0)
		pUnit:SpawnCreature(32326,2864.64,1859.83,164.12,4.91,35,0)
				DAL[id].VAR.KT:SendChatMessage(14,0,"The second wizard has fallen, only one cursed aura remains!")
	pUnit:PlaySoundToSet(18159)
	DAL[id].VAR.Chromie = pUnit:GetCreatureNearestCoords(2833, 2021, 169, 10667)
	DAL[id].VAR.Chromie:SendChatMessage(15,0,"Psst! Great work so far, meet the prince at Runeweaver Square!")
	local object = pUnit:GetGameObjectNearestCoords(2867.55, 1843.63,164.42, 3265692)
		if object then
			object:Despawn(1,0)
		end
			if DAL[id].VAR.p then
				for _,v in pairs(DAL[id].VAR.p) do
					v:StopChannel()
					v:RemoveAura(33569)
				end
			end
			for _,v in pairs(pUnit:GetInRangePlayers()) do
				azzUpdateAttempts(v, DAL[id].VAR.Auras)
			end
		end
	else
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
		pUnit:RegisterEvent("DAL.VAR.CheckForNearbyPlsLeboss", 1000, 0)
	end
end

RegisterUnitEvent(798121, 18, "DAL.VAR.LeBossEvents")
RegisterUnitEvent(798121, 1, "DAL.VAR.LeBossEvents")
RegisterUnitEvent(798121, 2, "DAL.VAR.LeBossEvents")
RegisterUnitEvent(798121, 4, "DAL.VAR.LeBossEvents")

function DAL.VAR.AIEventRexArcaneExplosion(pUnit)
	pUnit:CastSpell(9433)
end

function DAL.VAR.AIEventRexArcaneMissiles(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		if plr:GetDistanceYards(pUnit) < 30 then
			pUnit:FullCastSpellOnTarget(8417, plr)
		end
	end
end

function DAL.VAR.AIEventRexSpawnMinions(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local npc = DAL[id].VAR.p[math.random(1,5)]
	if npc then
		npc:CastSpell(41232) -- teleport visual
		npc:SpawnCreature(19205, npc:GetX(), npc:GetY(), npc:GetZ(), 4.9, 17, 60000)
	end
end

function DAL.VAR.AIEventRexPhase2(pUnit)
	if (pUnit:GetHealthPct() < 50) then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"Enough games!")
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		DAL[id] = DAL[id] or {VAR={}}
		for _,npc in pairs(DAL[id].VAR.p) do
			if npc then
				npc:CastSpell(41232) -- teleport visual
				npc:SpawnCreature(19205, npc:GetX(), npc:GetY(), npc:GetZ(), 4.9, 17, 60000)
			end
		end
		pUnit:RegisterEvent("DAL.VAR.AIEventRexArcaneExplosion", 7000, 0)
		pUnit:RegisterEvent("DAL.VAR.AIEventRexArcaneMissiles", 8000, 0)
		pUnit:RegisterEvent("DAL.VAR.AIEventRexSpawnMinions", 10000, 0)
	end
end

function DAL.VAR.CheckForNearbyPlsLeboss(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		if plr:GetDistanceYards(pUnit) < 10 then
			pUnit:RemoveEvents()
			pUnit:SendChatMessage(14,0,"Back scourge! I have not cut down a hundred of your kind just to be stopped by you few.")
			pUnit:MoveTo(3025.7, 1845.5, 164.4, 3.386782)
			local id = pUnit:GetInstanceID()
			if id == nil then id = 1 end
			DAL[id] = DAL[id] or {VAR={}}
			DAL[id].VAR.i = 0
			local object = pUnit:GetGameObjectNearestCoords(2980.28, 1835.53, 162.517, 3266385)
			if object then
				object:SetPhase(1)
			end
			object = pUnit:GetGameObjectNearestCoords(3007.88, 1824.92, 160.938, 146086)
			if object then
				object:SetPhase(1)
			end
			pUnit:RegisterEvent("DAL.VAR.CheckForCinePhaseLe", 1000, 0)
		end
	end
end

function DAL.VAR.CheckForCinePhaseLe(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.i = DAL[id].VAR.i + 1
	if (DAL[id].VAR.i == 2) then
		pUnit:MoveTo(3015.5, 1843.4, 158.5, 3.38)
	elseif (DAL[id].VAR.i == 7) then
		pUnit:MoveTo(2997.86, 1844.8, 158.5, 1.8)
		pUnit:SendChatMessage(12,0,"You think I would remain in my quarters unprotected? Think again.")
	elseif (DAL[id].VAR.i == 14) then
		pUnit:SendChatMessage(12,0,"Let the heavens be unleashed.")
		pUnit:Emote(1,0)
	elseif (DAL[id].VAR.i == 17) then
		DAL[id].VAR.p1 = pUnit:GetCreatureNearestCoords(2985, 1858, 158.5, 116869)
		DAL[id].VAR.p2 = pUnit:GetCreatureNearestCoords(2993, 1860, 158.5, 116869)
		DAL[id].VAR.p3 = pUnit:GetCreatureNearestCoords(3001, 1861, 158.5, 116869)
		DAL[id].VAR.p4 = pUnit:GetCreatureNearestCoords(3009, 1863, 158.5, 116869)
		DAL[id].VAR.p5 = pUnit:GetCreatureNearestCoords(3018, 1859, 158.5, 116869)
		local npcs = {DAL[id].VAR.p1, DAL[id].VAR.p2, DAL[id].VAR.p3, DAL[id].VAR.p4, DAL[id].VAR.p5}
		DAL[id].VAR.p = npcs
		pUnit:CastSpell(35426) -- arcane explosion visual
		for _,v in pairs(npcs) do
			v:CastSpell(33569) -- portal visual
			v:ChannelSpell(31387, pUnit)
			v:CastSpell(35426) -- arcane explosion visual
		end
		pUnit:ChannelSpell(33827, pUnit)
	elseif (DAL[id].VAR.i == 20) then
		pUnit:SendChatMessage(14,0,"Now you shall do battle with me!")
	elseif (DAL[id].VAR.i == 22) then
		--pUnit:Root()
		pUnit:StopChannel()
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
		pUnit:RemoveEvents()
	end
end

--TrashMobs--

function  DAL.VAR.KirinTorDefender_Events(pUnit,Event)
	if Event == 1 then
		pUnit:RegisterEvent("DAL.VAR.Defender_ThrowShield", math.random(6000,15000),0)
		pUnit:RegisterEvent("DAL.VAR.Defender_CounterSpell", math.random(8000,12000),0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end

function DAL.VAR.Defender_ThrowShield(pUnit)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		if pUnit:GetDistanceYards(plr) < 5 then
			if not plr:IsDead() and plr:IsInCombat() then
				pUnit:CastSpellOnTarget(73076,plr)
			end
		end
	end
end

function DAL.VAR.Defender_CounterSpell(pUnit)
local plr = pUnit:GetRandomPlayer(0)
	if plr then
		if plr:GetCurrentSpellId() then
			if pUnit:GetDistanceYards(plr) < 20 then
				if not plr:IsDead() then
					pUnit:CastSpellOnTarget(65790,plr)
				end
			end
		end
	end
end

RegisterUnitEvent(30659, 1, "DAL.VAR.KirinTorDefender_Events")
RegisterUnitEvent(30659, 4, "DAL.VAR.KirinTorDefender_Events")
RegisterUnitEvent(30659, 2, "DAL.VAR.KirinTorDefender_Events")

function DAL.VAR.KirinTor_Battlemage_Events(pUnit,Event)
	if Event == 1 then
		pUnit:RegisterEvent("DAL.VAR.Battlemage_ExplosionArcana", math.random(6000,9000),0)
		pUnit:RegisterEvent("DAL.VAR.Battlemage_Fireblase", math.random(10000,15000),0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
	end
end

function DAL.VAR.Battlemage_Fireblase(pUnit)
	pUnit:CastSpell(17145)
end

function DAL.VAR.Battlemage_ExplosionArcana(pUnit)
	pUnit:CastSpell(33860)
end

RegisterUnitEvent(33662, 1, "DAL.VAR.KirinTor_Battlemage_Events")
RegisterUnitEvent(33662, 4, "DAL.VAR.KirinTor_Battlemage_Events")
RegisterUnitEvent(33662, 2, "DAL.VAR.KirinTor_Battlemage_Events")

function DAL.VAR.KirinTorFamiliar_Events(pUnit,Event)
	if Event == 1 then
		pUnit:CastSpell(29880)
	elseif Event == 3 then
		pUnit:RemoveAura(29880)
	elseif Event == 4 then
		pUnit:CastSpell(29882)
	end
end

RegisterUnitEvent(32643, 1, "DAL.VAR.KirinTorFamiliar_Events")
RegisterUnitEvent(32643, 4, "DAL.VAR.KirinTorFamiliar_Events")
RegisterUnitEvent(32643, 2, "DAL.VAR.KirinTorFamiliar_Events")


---

function DAL.VAR.GhoulWaypatherTwo(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("DAL.VAR.GhoulWaypatherTwoCheck",1500,0)
end

function DAL.VAR.GhoulWaypatherTwoCheck(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local player = pUnit:GetClosestPlayer()
	if player then
		if pUnit:GetDistanceYards(player) < 5 then
			pUnit:RemoveEvents()
			pUnit:SpawnCreature(3981231,2831.98,1897.61,166.66,3.4, 1857, 0)
			pUnit:SpawnCreature(3981231,2832.98,1898.61,166.66,3.4, 1857, 0)
			pUnit:SpawnCreature(3981231,2833.41,1892.28,166.51,3.4, 1857, 0)
			pUnit:SpawnCreature(3981231,2834.41,1897.28,166.51,3.4, 1857, 0)
			pUnit:SpawnCreature(3981231,2837.78,1896.83,166.67,3.4, 1857, 0)
			pUnit:SpawnCreature(3981231,2838.78,1897.83,166.67,3.4, 1857, 0)
		end
	end	
end

RegisterUnitEvent(176799, 18, "DAL.VAR.GhoulWaypatherTwo")

function DAL.VAR.GhoulWaypatherOne(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("DAL.VAR.GhoulWaypatherOneCheck",1500,0)
end

function DAL.VAR.GhoulWaypatherOneCheck(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local player = pUnit:GetClosestPlayer()
	if player then
		if pUnit:GetDistanceYards(player) < 5 then
			pUnit:RemoveEvents()
			pUnit:SpawnCreature(3981231,2854.74, 1924.30, 167.00, 4.8, 1857, 0)
			pUnit:SpawnCreature(3981231,2853.74, 1924.30, 167.00, 4.8, 1857, 0)
			pUnit:SpawnCreature(3981231,2847.49, 1922.87, 167.15, 4.9, 1857, 0)
			pUnit:SpawnCreature(3981231,2846.49, 1922.87, 167.15, 4.9, 1857, 0)
			pUnit:SpawnCreature(3981231,2853.92, 1916.55, 166.28, 4.94, 1857, 0)
			pUnit:SpawnCreature(3981231,2852.92, 1916.55, 166.28, 4.94, 1857, 0)
		end
	end	
end

RegisterUnitEvent(176798, 18, "DAL.VAR.GhoulWaypatherOne")

function DAL.VAR.AGENT_SPWN(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:RegisterEvent("DAL.VAR.SPWN_TPVISUAL", 1000,1)
end

function DAL.VAR.SPWN_TPVISUAL(pUnit,Event)
	pUnit:CastSpell(21649)
end
	
RegisterUnitEvent(27744, 18, "DAL.VAR.AGENT_SPWN")

function DAL.VAR.BOSS_INTRODUMMY_INFINITE(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("DAL.VAR.BOSS_INTROFOUNDPLAYERS", 1000, 0)
end

function DAL.VAR.BOSS_INTROFOUNDPLAYERS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local player = pUnit:GetClosestPlayer()
	if player then
		if pUnit:GetDistanceYards(player) < 5 then
			pUnit:RemoveEvents()
			pUnit:SpawnCreature(77220,2871.78, 1830.37, 164.13, 1.8, 35, 6000)
			DAL[id].VAR.ll = 0
			pUnit:RegisterEvent("DAL.VAR.SPAWN_THEBOSSINFINITESTYLE", 4000, 1)
			pUnit:PlaySoundToSet(14300)
			DAL[id].VAR.ARTHAS:SendChatMessage(12,0,"What is this sorcery?")
			DAL[id].VAR.ARTHAS:MoveTo(2868.51,1844.41,164.41)
		end
	end
end
	
function DAL.VAR.SPAWN_THEBOSSINFINITESTYLE(pUnit,Event)
	pUnit:SpawnCreature(228912,2871.78, 1830.37, 164.13, 1.8, 14, 0)
end
	
RegisterUnitEvent(8981231, 18, "DAL.VAR.BOSS_INTRODUMMY_INFINITE")

function DAL.VAR.BOSS_INTRODUMMY_ANTON(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("DAL.VAR.BOSS_ANTONINTROFOUNDPLAYERS", 1000, 0)
end

function DAL.VAR.BOSS_ANTONINTROFOUNDPLAYERS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local player = pUnit:GetClosestPlayer()
	if player then
		if pUnit:GetDistanceYards(player) < 5 then
			pUnit:RemoveEvents()
			DAL[id].VAR.af = 0
			pUnit:RegisterEvent("DAL.VAR.SPAWN_ANTONIDAS_CC", 4000, 1)
			pUnit:PlaySoundToSet(18165)
			DAL[id].VAR.ANTON = pUnit:GetCreatureNearestCoords(3003.67, 1742.16, 178.86, 387313)
			DAL[id].VAR.ANTON:SendChatMessage(12,0,"It pains me to even look at you Arthas.")
		end
	end
end
	
	
function DAL.VAR.SPAWN_ANTONIDAS_CC(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	if DAL[id].VAR.af then
		DAL[id].VAR.af = DAL[id].VAR.af + 1
	else
		DAL[id].VAR.af = 1
	end
	if DAL[id].VAR.af == 1 then
		DAL[id].VAR.ARTHAS:SendChatMessage(12,0,"I'll be happy to end your torment old man, I told you that your magics could not stop me.")
		pUnit:PlaySoundToSet(18152)
		pUnit:RegisterEvent("DAL.VAR.SPAWN_ANTONIDAS_CC", 5000, 1)
	elseif DAL[id].VAR.af == 2 then
		DAL[id].VAR.ANTON:CastSpellOnTarget(71614,DAL[id].VAR.ARTHAS)
		DAL[id].VAR.ANTON:CastSpellOnTarget(71614,DAL[id].VAR.KT)
		DAL[id].VAR.KT:CastSpell(71614)
		DAL[id].VAR.ANTON:SetFaction(14)
		DAL[id].VAR.ARTHAS:AIDisableCombat(true)
		DAL[id].VAR.KT:AIDisableCombat(true)
	end
end

RegisterUnitEvent(387314, 18, "DAL.VAR.BOSS_INTRODUMMY_ANTON")

function DAL.VAR.ANTONDIAS_EVENTS(pUnit,Event)
	if Event == 1 then
		pUnit:RegisterEvent("DAL.VAR.ANTONIDAS_FROSTBOLT",  math.random(2000,5000),0)
		pUnit:RegisterEvent("DAL.VAR.ANTON_BLIZZARD",  math.random(7000,12000),0)
		pUnit:RegisterEvent("DAL.VAR.ANTONIDAS_DETONATE_MANA",  math.random(14000,16000),0)
		pUnit:RegisterEvent("DAL.VAR.ANTONIDAS_FROSTBLAST",  math.random(15000,20000),0)
		pUnit:RegisterEvent("DAL.VAR.ANTONIDAS_POLYMORPH",  math.random(25000,28000),0)
		pUnit:RegisterEvent("DAL.VAR.ANTONIDAS_TELEPORTRANDOM",  math.random(15000,25000),0)
		local object = pUnit:GetGameObjectNearestCoords(2986.70,1759.09,179.41, 3266385)
		if object then
			object:SetPhase(1)
		end
	elseif Event == 2 then
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(2986.70,1759.09,179.41, 3266385)
		if object then
			object:SetPhase(2)
		end
	elseif Event == 4 then
		pUnit:RemoveEvents()
		local id = pUnit:GetInstanceID()
		if id == nil then id = 1 end
		DAL[id] = DAL[id] or {VAR={}}
		DAL[id].VAR.ARTHAS:RemoveAura(71614)
		DAL[id].VAR.KT:RemoveAura(71614)
		DAL[id].VAR.ARTHAS:SendChatMessage(12,0,"The all Spellbook is yours lich,let's take it and leave before the wizards amass for their final attack.")
		pUnit:PlaySoundToSet(18153)
		DAL[id].VAR.ARTHAS:MoveTo(3005.09,1740.11,178.81)
		DAL[id].VAR.KT:MoveTo(3001.93,1736.95,178.61)
		DAL[id].VAR.KT:RegisterEvent("DAL.VAR.INDEEDKT",  5100,1)
		local object = pUnit:GetGameObjectNearestCoords(2986.70,1759.09,179.41, 3266385)
		if object then
			object:SetPhase(2)
		end
		for _, players in pairs(pUnit:GetInRangePlayers()) do
			if players:HasQuest(6800) then
				if (players:GetQuestObjectiveCompletion(6800, 0) == 0) then
					players:MarkQuestObjectiveAsComplete(6800, 0)
				end
			end
			if not players:HasAchievement(59394) then
				players:AddAchievement(59394)
			end
		end
	end
end

RegisterUnitEvent(387313, 1, "DAL.VAR.ANTONDIAS_EVENTS")
RegisterUnitEvent(387313, 2, "DAL.VAR.ANTONDIAS_EVENTS")
RegisterUnitEvent(387313, 4, "DAL.VAR.ANTONDIAS_EVENTS")

function DAL.VAR.INDEEDKT(pUnit)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.KT:SendChatMessage(12,0,"Indeed. I will begin summong Lord Archimonde at sunset.")
	pUnit:PlaySoundToSet(18161)
	DAL[id].VAR.Chromie = pUnit:GetCreatureNearestCoords(2975.65,1769.97,182.43, 30997)
	DAL[id].VAR.Chromie:SetPhase(1)
	DAL[id].VAR.Chromie:SendChatMessage(12,0,"Good work heroes, you have made sure that the time-line has not been altered!")
end



function DAL.VAR.ANTONIDAS_FROSTBLAST(pUnit)
	local plr = pUnit:GetRandomPlayer(0) 
	if plr then 
		pUnit:CastSpellOnTarget(27808, plr) 
	end
end

function DAL.VAR.ANTONIDAS_POLYMORPH(pUnit)
     local plr = pUnit:GetRandomPlayer(7) 
     if plr then 
          pUnit:CastSpellOnTarget(12824, plr) 
     end 
end

function DAL.VAR.ANTONIDAS_DETONATE_MANA(pUnit)
     local plr = pUnit:GetRandomPlayer(4) 
     if plr then 
          pUnit:CastSpellOnTarget(27819, plr) 
     end 
end

function DAL.VAR.ANTONIDAS_FROSTBOLT(pUnit)
	if pUnit:IsCasting() then 
	  return 
	end 
	local plr = pUnit:GetRandomPlayer(0) 
	if plr then 
	  pUnit:FullCastSpellOnTarget(46987, plr) 
	end 
end

function DAL.VAR.ANTONIDAS_TELEPORTRANDOM(pUnit)
	if pUnit:IsCasting() then 
	  return 
	end 
	local plr = pUnit:GetRandomPlayer(0) 
	if plr then 
	  pUnit:TeleportCreature(plr:GetX(),plr:GetY(),plr:GetZ())
	  pUnit:CastSpell(64446)
	end 
end

function DAL.VAR.ANTON_BLIZZARD(pUnit,Event)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		if pUnit:GetDistanceYards(plr) < 38 then
			pUnit:CastSpellAoF(plr:GetX(), plr:GetY(), plr:GetZ(), 19099)
		end
	end
end

function DAL.VAR.TIMEASSASSIN_EVENTS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	if Event == 18 then
		DAL[id].VAR.ARTHAS:Emote(375,37500)
		if DAL[id].VAR.ll == 0 then
			DAL[id].VAR.ll = 1
			pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
			DAL[id].VAR.zk = 0
			pUnit:CastSpell(21649)
			pUnit:SendChatMessage(14,0,"Ah, there you are, I had hope to accomplish this with a bit of subtlety but I suppose direct confrontation was inevitable. Your future must not come to pass and so you and your troublesome friends must die!")
			pUnit:PlaySoundToSet(10420)
			pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 2000, 1)
			pUnit:RegisterEvent("DAL.VAR.SPWN_TPVISUAL", 1000,1)
		end
	elseif Event == 1 then
		DAL[id].VAR.lk = 0
		pUnit:SendChatMessage(14,0,"Enough! I will erase your very existence!")
		pUnit:PlaySoundToSet(10421)
		DAL[id].VAR.ARTHAS:SetFaction(1857)
		pUnit:RegisterEvent("DAL.VAR.DRAKECHCKPLAYERS", 1000,0)
		pUnit:RegisterEvent("DAL.VAR.TIMEWARP",  math.random(20000,22000),0)
		pUnit:RegisterEvent("DAL.VAR.CURSEOFEXERTION",  math.random(8000,18000),0)
		pUnit:RegisterEvent("DAL.VAR.IMPENDINGDEATH",  math.random(17000,32000),0)
		pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT",  math.random(15000,18000),0)
		local object = pUnit:GetGameObjectNearestCoords(2862.20, 1873.48, 164.54, 3266385)
		if object then
			object:SetPhase(1)
		end
	elseif Event == 2 then
		pUnit:RemoveEvents()
		local object = pUnit:GetGameObjectNearestCoords(2862.20, 1873.48, 164.54, 3266385)
		if object then
			object:SetPhase(2)
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 27744 then
				creatures:Despawn(1,0)
			end
		end
	elseif Event == 3 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14,0,"You are... irrelevant.")
		pUnit:PlaySoundToSet(10425)
	elseif Event == 4 then
		pUnit:RemoveEvents()
		DAL[id].VAR.Auras = 0
		for _,v in pairs(pUnit:GetInRangePlayers()) do
			azzResetWorldstatesUI(v)
		end
		DAL[id].VAR.mk  = 0
		pUnit:SendChatMessage(14,0,"No!... The master... will not... be pleased.")
		pUnit:PlaySoundToSet(10427)
		--DAL[id].VAR.ARTHAS:Despawn(1,0)
		--pUnit:SpawnCreature(32326,2864.64,1859.83,164.12,4.91,35,0)
		DAL[id].VAR.KT:Despawn(1,0)
		pUnit:SpawnCreature(30061,2986.83,1749.54,178.86,5.71,35,0)
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do
			local entry = creatures:GetEntry()
			if entry == 27744 or entry == 20869 or entry == 892813 or entry == 32643 or entry == 33662 or entry == 30659 or entry == 892814 then
				creatures:Despawn(1,0)
			end
		end
		DAL[id].VAR.ARTHAS:RegisterEvent("DAL.VAR.ARTHAS_MOVETO_ANTONIDAS", 1000,1)
		local object = pUnit:GetGameObjectNearestCoords(2862.20, 1873.48, 164.54, 3266385)
		if object then
			object:SetPhase(2)
		end
		local object = pUnit:GetGameObjectNearestCoords(2990.28,1753.93,178.59, 3265692)
		if object then
			object:Despawn(1,0)
		end
		local object = pUnit:GetGameObjectNearestCoords(2876.52,1809.09,164.07, 3266354)
		if object then
			object:Despawn(1,0)
		end
	end
end

function DAL.VAR.ARTHAS_MOVETO_ANTONIDAS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	DAL[id].VAR.mk = DAL[id].VAR.mk + 1
	if DAL[id].VAR.mk == 1 then
		pUnit:MoveTo(2882.81,1783.97,159.73)
		pUnit:SendChatMessage(12,0,"Lets move on.")
		pUnit:PlaySoundToSet(14303)
		for _,fire in pairs(pUnit:GetInRangeObjects()) do 
			if fire:GetEntry() == 191158 then
				fire:SetPhase(1)
			end
		end
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 28565 or creatures:GetEntry() == 31692 then
				creatures:SetPhase(1)
			end
		end
		pUnit:RegisterEvent("DAL.VAR.ARTHAS_MOVETO_ANTONIDAS", 5000,1)
	elseif DAL[id].VAR.mk == 2 then
		pUnit:MoveTo(2922.61,1788.12,157.85)
		pUnit:RegisterEvent("DAL.VAR.ARTHAS_MOVETO_ANTONIDAS", 7000,1)
	elseif DAL[id].VAR.mk == 3 then
		pUnit:MoveTo(2941.05,1803.81,157.37)
		pUnit:RegisterEvent("DAL.VAR.ARTHAS_MOVETO_ANTONIDAS", 8000,1)
	elseif DAL[id].VAR.mk == 4 then
		pUnit:MoveTo(2954.71,1789.99,157.71)
		pUnit:RegisterEvent("DAL.VAR.ARTHAS_MOVETO_ANTONIDAS", 7000,1)
	elseif DAL[id].VAR.mk == 5 then
		pUnit:MoveTo(2974.27,1770.22,177.72)
		pUnit:RegisterEvent("DAL.VAR.ARTHAS_MOVETO_ANTONIDAS", 6000,1)
	elseif DAL[id].VAR.mk == 6 then
		pUnit:MoveTo(2990.28,1753.93,178.59)
	elseif DAL[id].VAR.mk == 7 then
		DAL[id].VAR.ARTHAS:Despawn(1,0)
		DAL[id].VAR.KT:SpawnCreature(32326,2989.70,1754.68,178.72,5.4,35,0)
	end
end

function DAL.VAR.TIMEWARP(pUnit,Event)
	if math.random(1,2) == 1 then
		pUnit:SendChatMessage(14, 0, "Not so fast!")
		pUnit:PlaySoundToSet(10423)
	else
		pUnit:SendChatMessage(14, 0, "Struggle as much as you like!")
		pUnit:PlaySoundToSet(10424)
	end
	pUnit:CastSpell(52766)
	pUnit:RegisterEvent("DAL.VAR.TIMESTOP", 3000,2)
end

function DAL.VAR.TIMESTOP(pUnit)
	pUnit:CastSpell(58848)
end

function DAL.VAR.CURSEOFEXERTION(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		pUnit:CastSpellOnTarget(52772,v)
	end
end

function DAL.VAR.IMPENDINGDEATH(pUnit)
	for _,v in pairs(pUnit:GetInRangePlayers()) do
		pUnit:CastSpellOnTarget(31916,v)
	end
end

function DAL.VAR.DRAKECHCKPLAYERS(pUnit,Event)
	local id = pUnit:GetInstanceID()
	if id == nil then id = 1 end
	DAL[id] = DAL[id] or {VAR={}}
	local numPlayers = pUnit:GetInRangePlayers()
	local i = 0
	for _,players in pairs(numPlayers) do
		if players:IsDead() then
			i = i + 1
		end
	end
	if i == #numPlayers then
		pUnit:RemoveEvents()
		DAL[id].VAR.ARTHAS:Despawn(1,0)
		pUnit:SpawnCreature(32326,2864.64,1859.83,164.12,4.91,35,0)
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 27744 then
				creatures:Despawn(1,0)
			end
		end
	end
end

RegisterUnitEvent(228912, 1, "DAL.VAR.TIMEASSASSIN_EVENTS")
RegisterUnitEvent(228912, 18, "DAL.VAR.TIMEASSASSIN_EVENTS")
RegisterUnitEvent(228912, 4, "DAL.VAR.TIMEASSASSIN_EVENTS")
RegisterUnitEvent(228912, 3, "DAL.VAR.TIMEASSASSIN_EVENTS")
RegisterUnitEvent(228912, 2, "DAL.VAR.TIMEASSASSIN_EVENTS")

function DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT(pUnit,Event)
local id = pUnit:GetInstanceID()
if id == nil then id = 1 end
DAL[id] = DAL[id] or {VAR={}}
DAL[id].VAR.lk = DAL[id].VAR.lk + 1
if DAL[id].VAR.lk == 1 then
pUnit:SendChatMessage(14, 0, "You cannot fight fate!")
pUnit:PlaySoundToSet(10422)
pUnit:SpawnCreature(27744,2878.40, 1836.48, 164.12, 2.5, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 2 then
pUnit:SpawnCreature(27744,2873.83, 1854.29, 164.24, 4, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 3 then
pUnit:SpawnCreature(27744,2877.48, 1851.51, 164.12, 4, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 4 then
pUnit:SpawnCreature(27744,2877.46, 1854.41, 164.47, 4, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 5 then
pUnit:SpawnCreature(27744,2873.62, 1858.17, 164.41, 4, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 6 then
pUnit:SpawnCreature(27744,2859.10, 1853.71, 164.36, 5.8, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 7 then
pUnit:SpawnCreature(27744,2857.41, 1850.01, 164.47, 5.8, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 8 then
pUnit:SpawnCreature(27744,2855.93, 1847.36, 164.25, 5.8, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 9 then
pUnit:SpawnCreature(27744,2854.48, 1851.48, 164.59, 5.66, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 10 then
pUnit:SpawnCreature(27744,2857.74, 1842.34, 164.13, 0.24, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 11 then
pUnit:SpawnCreature(27744,2857.79, 1838.85, 164.13, 0.24, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 12 then
pUnit:SpawnCreature(27744,2857.99, 1835.99, 164.13, 0.24, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 13 then
pUnit:SpawnCreature(27744,2859.53, 1831.14, 164.49, 1.0, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 14 then
pUnit:SpawnCreature(27744,2862.94, 1828.35, 164.54, 1.0, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 15 then
pUnit:SpawnCreature(27744,2860.08, 1825.88,164.73, 1.0,14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 16 then
pUnit:SpawnCreature(27744,2882.97, 1837.48, 164.12, 2.6, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 17 then
pUnit:SpawnCreature(27744,2883.21, 1831.90, 164.81, 2.39, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNSFIGHT", 500, 1)
elseif DAL[id].VAR.lk == 18 then
	DAL[id].VAR.lk = 0
	local tank = pUnit:GetMainTank()
	if tank and tank:IsAlive() then
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 27744 then
				creatures:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
				creatures:AttackReaction(tank, 1000, 0)
			end
		end
	end
end
end

function DAL.VAR.TIMEASSASSIN_SPAWNPOSSE(pUnit,Event)
local id = pUnit:GetInstanceID()
if id == nil then id = 1 end
DAL[id] = DAL[id] or {VAR={}}
DAL[id].VAR.zk = DAL[id].VAR.zk + 1
if DAL[id].VAR.zk == 1 then
pUnit:MoveTo(2869.83,1838.13,164.38)
pUnit:SpawnCreature(27744,2878.40, 1836.48, 164.12, 2.5, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 2 then
DAL[id].VAR.ARTHAS:SendChatMessage(12,0,"Watch your backs, they have us surrounded.")
pUnit:PlaySoundToSet(14304)
pUnit:SpawnCreature(27744,2873.83, 1854.29, 164.24, 4, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 3 then
pUnit:SpawnCreature(27744,2877.48, 1851.51, 164.12, 4, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 4 then
pUnit:SpawnCreature(27744,2877.46, 1854.41, 164.47, 4, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 5 then
pUnit:SpawnCreature(27744,2873.62, 1858.17, 164.41, 4, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
DAL[id].VAR.Chromie = pUnit:GetCreatureNearestCoords(2833, 2021, 169, 10667)
DAL[id].VAR.Chromie:SendChatMessage(15,0,"Oh no! Be strong, I am unable to interfere!")
elseif DAL[id].VAR.zk == 6 then
pUnit:SpawnCreature(27744,2859.10, 1853.71, 164.36, 5.8, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 7 then
pUnit:SpawnCreature(27744,2857.41, 1850.01, 164.47, 5.8, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 8 then
pUnit:SpawnCreature(27744,2855.93, 1847.36, 164.25, 5.8, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 9 then
pUnit:SpawnCreature(27744,2854.48, 1851.48, 164.59, 5.66, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 10 then
pUnit:SpawnCreature(27744,2857.74, 1842.34, 164.13, 0.24, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 11 then
pUnit:SpawnCreature(27744,2857.79, 1838.85, 164.13, 0.24, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 12 then
pUnit:SpawnCreature(27744,2857.99, 1835.99, 164.13, 0.24, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 13 then
pUnit:SpawnCreature(27744,2859.53, 1831.14, 164.49, 1.0, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 14 then
pUnit:SpawnCreature(27744,2862.94, 1828.35, 164.54, 1.0, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 15 then
pUnit:SpawnCreature(27744,2860.08, 1825.88,164.73, 1.0,14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 16 then
pUnit:SpawnCreature(27744,2882.97, 1837.48, 164.12, 2.6, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 500, 1)
elseif DAL[id].VAR.zk == 17 then
pUnit:SpawnCreature(27744,2883.21, 1831.90, 164.81, 2.39, 14, 0)
pUnit:RegisterEvent("DAL.VAR.TIMEASSASSIN_SPAWNPOSSE", 14000, 1)
elseif DAL[id].VAR.zk == 18 then
pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	local tank = pUnit:GetClosestPlayer()
	if tank and tank:IsAlive() then
		for _,creatures in pairs(pUnit:GetInRangeUnits()) do 
			if creatures:GetEntry() == 27744 then
				creatures:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
				creatures:AttackReaction(tank, 1000, 0)
			end
		end
	end
end
end


function GhoulFoD_OnSpawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 2)
	pUnit:SetMovementFlags(1) 
	pUnit:RegisterEvent("GhoulFoD_Emote_Raise", 200, 1)
end

function GhoulFoD_Emote_Raise(pUnit,Event)
	pUnit:Emote(449, 4000)
	pUnit:CastSpell(72313)
	pUnit:RegisterEvent("GhoulFoD_SetFactionAfterEmote",4200,1)
end

function GhoulFoD_SetFactionAfterEmote(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, 0)
	pUnit:RegisterEvent("GhoulFoD_MoveTo", 1000, 1)
end

function GhoulFoD_MoveTo(pUnit,Event)
	pUnit:MoveTo(2801.60, 1884.11,167.05,3.07)
end

RegisterUnitEvent(3981231, 18, "GhoulFoD_OnSpawn")

function ArcaneRoxElementalSpawn(pUnit)
	pUnit:RegisterEvent("ArcaneRoxWaitSec", 1000, 1)
end

function ArcaneRoxWaitSec(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr then
		pUnit:AttackReaction(plr, 1, 0)
	end
end

RegisterUnitEvent(19205, 18, "ArcaneRoxElementalSpawn")

--worldstate--

function azUpdateWorldstatesUI(plrs)
	local pack = LuaPacket:CreatePacket(SMSG_INIT_WORLD_STATES, 18)
	pack:WriteULong(560) -- Map
	pack:WriteULong(0) -- Zone
	pack:WriteULong(0)
	pack:WriteUShort(1)
	pack:WriteULong(4884) -- ID
	pack:WriteULong(1) -- Value
	plrs:SendPacketToPlayer(pack)
end

function azzUpdateAttempts(plrs, value)
	local pack = LuaPacket:CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
	pack:WriteULong(4882) -- ID, X
	pack:WriteULong(value) -- Value
	plrs:SendPacketToPlayer(pack)
end

function azzResetWorldstatesUI(plrs)
	local pack = LuaPacket:CreatePacket(SMSG_INIT_WORLD_STATES, 18)
	pack:WriteULong(0) -- Map
	pack:WriteULong(0) -- Zone
	pack:WriteULong(0)
	pack:WriteUShort(0)
	pack:WriteULong(0) -- ID
	pack:WriteULong(0) -- Value
	plrs:SendPacketToPlayer(pack)
end

--[[function DAL.VAR.SERVER_HOOK_ZONE(event, plr, nzone, ozone)
	plr:SendBroadcastMessage("Old zone: "..tostring(ozone).." new zone = "..tostring(nzone))
	if (nzone == 2367) then
		plr:CastSpell(51520)
	elseif (ozone == 2367) then
		plr:RemoveAura(51520)
	end
end

RegisterServerHook(15, "DAL.VAR.SERVER_HOOK_ZONE")]] -- This function is not working

-- Hack fix as function above does not work

function DAL.VAR.Check_Players_InCT()
	for _,plrs in pairs(GetPlayersInWorld()) do
		if plrs then
			if plrs:GetMapId() == 560 then
				DAL.VAR.HandleAddAura(plrs)
			else
				DAL.VAR.HandleRemoveAura(plrs)
			end
		end
	end
end

function DAL.VAR.HandleAddAura(plr)
	local race = plr:GetPlayerRace()
	local gender = plr:GetGender()
	if race == 1 then -- human
		if (gender == 1) then -- female
			plr:CastSpell(51534)
		else -- male
			plr:CastSpell(51520)
		end
	elseif race == 2 then -- orc
		if (gender == 1) then -- female
			plr:CastSpell(51544)
		else -- male
			plr:CastSpell(51543)
		end
	elseif race == 3 then -- dwarf
		if (gender == 1) then -- female
			plr:CastSpell(51537)
		else -- male
			plr:CastSpell(51538)
		end
	elseif race == 4 then -- NE
		if (gender == 1) then -- female
			plr:CastSpell(51536)
		else -- male
			plr:CastSpell(51535)
		end
	elseif race == 5 then -- Undead
		if (gender == 1) then -- female
			plr:CastSpell(51550)
		else -- male
			plr:CastSpell(51549)
		end
	elseif race == 6 then -- Tauren
		if (gender == 1) then -- female
			plr:CastSpell(51548)
		else -- male
			plr:CastSpell(51547)
		end
	elseif race == 7 then -- Gnome
		if (gender == 1) then -- female
			plr:CastSpell(51540)
		else -- male
			plr:CastSpell(51539)
		end
	elseif race == 8 then -- Troll
		if (gender == 1) then -- female
			plr:CastSpell(51545)
		else -- male
			plr:CastSpell(51546)
		end
	elseif race == 9 then
		-- unknown
	elseif race == 10 then -- blood elf
		if (gender == 1) then -- female
			plr:CastSpell(51552)
		else -- male
			plr:CastSpell(51551)
		end
	elseif race == 11 then -- draenei
		if (gender == 1) then -- female
			plr:CastSpell(51542)
		else -- male
			plr:CastSpell(51541)
		end
	elseif race == 17 then -- tuskarr

	end
end

function DAL.VAR.HandleRemoveAura(plr)
	local race = plr:GetPlayerRace()
	local gender = plr:GetGender()
	if race == 1 then -- human
		if (gender == 1) then -- female
			if plr:HasAura(51534) then
				plr:RemoveAura(51534)
			end
		else -- male
			if plr:HasAura(51520) then
				plr:RemoveAura(51520)
			end
		end
	elseif race == 2 then -- orc
		if (gender == 1) then -- female
			if plr:HasAura(51544) then
				plr:RemoveAura(51544)
			end
		else -- male
			if plr:HasAura(51543) then
				plr:RemoveAura(51543)
			end
		end
	elseif race == 3 then -- dwarf
		if (gender == 1) then -- female
			if plr:HasAura(51537) then
				plr:RemoveAura(51537)
			end
		else -- male
			if plr:HasAura(51538) then
				plr:RemoveAura(51538)
			end
		end
	elseif race == 4 then -- NE
		if (gender == 1) then -- female
			if plr:HasAura(51536) then
				plr:RemoveAura(51536)
			end
		else -- male
			if plr:HasAura(51535) then
				plr:RemoveAura(51535)
			end
		end
	elseif race == 5 then -- Undead
		if (gender == 1) then -- female
			if plr:HasAura(51550) then
				plr:RemoveAura(51550)
			end
		else -- male
			if plr:HasAura(51549) then
				plr:RemoveAura(51549)
			end
		end
	elseif race == 6 then -- Tauren
		if (gender == 1) then -- female
			if plr:HasAura(51548) then
				plr:RemoveAura(51548)
			end
		else -- male
			if plr:HasAura(51547) then
				plr:RemoveAura(51547)
			end
		end
	elseif race == 7 then -- Gnome
		if (gender == 1) then -- female
			if plr:HasAura(51540) then
				plr:RemoveAura(51540)
			end
		else -- male
			if plr:HasAura(51539) then
				plr:RemoveAura(51539)
			end
		end
	elseif race == 8 then -- Troll
		if (gender == 1) then -- female
			if plr:HasAura(51545) then
				plr:RemoveAura(51545)
			end
		else -- male
			if plr:HasAura(51546) then
				plr:RemoveAura(51546)
			end
		end
	elseif race == 9 then
		-- unknown
	elseif race == 10 then -- blood elf
		if (gender == 1) then -- female
			if plr:HasAura(51552) then
				plr:RemoveAura(51552)
			end
		else -- male
			if plr:HasAura(51551) then
				plr:RemoveAura(51551)
			end
		end
	elseif race == 11 then -- draenei
		if (gender == 1) then -- female
			if plr:HasAura(51542) then
				plr:RemoveAura(51542)
			end
		else -- male
			if plr:HasAura(51541) then
				plr:RemoveAura(51541)
			end
		end
	elseif race == 17 then -- tuskarr
		-- Unsupported
	end
end
	

CreateLuaEvent(DAL.VAR.Check_Players_InCT, 5000, 0)