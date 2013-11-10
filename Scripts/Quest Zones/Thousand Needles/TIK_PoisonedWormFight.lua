--[[
Quest name: Gathering Supplies
Quest ID: 3402
Quest Starter: 4709
Quest Finisher: 4709

Made by Tikki

]]
--\/\/\/\/\/\/\--
--//VARIABLES\\--
--\/\/\/\/\/\/\--

--[[Allready used as a global variable in another script :P

OBJECT_END = 0x0006
UNIT_FIELD_FLAGS = OBJECT_END + 0x0035
UNIT_FLAG_NOT_SELECTABLE = 0x02000000
UNIT_FLAG_DEFAULT = 0X00]]--

--Q3402_ACTIV_DEBUG = true --Uncomment to activate debug function (Should be commented on live-realm!)

local TIKWorm = nil
local TIKGnomA = nil
local TIKGnomB = nil
local TIKGnomC = nil
local q = 1
local dnpc = nil
local plr = nil
local qq = 0
local TIKSCALE = 0.5
local TIKMaggot = nil
local qqq = 1
local testboolean = false
--\/\/\/\/\/\/\/\/\/--
--//INITIALIZATION\\--
--\/\/\/\/\/\/\/\/\/--

--On spawns :P
function Q3402_WormSetup(pUnit,Event)
	TIKWorm = pUnit
	pUnit:RegisterEvent("Q3402_Test",2000,1)
	pUnit:RegisterEvent("Q3402_StartWhenPlayerArrives",5000,0)
end


function Q3402_Test(pUnit,Event)
	pUnit:SetStandState(0) 
	pUnit:SetScale(0.5)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

function Q3402_VoiceActorSetup(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

function Q3402_MaggotSetup(pUnit,Event)
	TIKMaggot = pUnit
end

RegisterUnitEvent(89002, 18, "Q3402_WormSetup")
RegisterUnitEvent(89004, 18, "Q3402_VoiceActorSetup")
RegisterUnitEvent(89004, 18, "Q3402_MaggotSetup")

--\/\/\/\/\/\/--
--//LE EVENT\\--
--\/\/\/\/\/\/--

function Q3402_StartWhenPlayerArrives(pUnit)
	plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if pUnit:GetDistanceYards(plr) < 33 then
			if plr:GetPhase() == 1 then
				if plr:HasQuest(3402) then
					pUnit:RemoveEvents()
					TIKGnomA = pUnit:SpawnCreature(89003, -5926,-4309,-58.749451,6.243208, 35, 0, 6219, 0, 0, 1, 0)
					TIKGnomB = pUnit:SpawnCreature(89003, -5927,-4307,-58.749451,6.243208, 35, 0, 6219, 0, 0, 1, 0)
					TIKGnomC = pUnit:SpawnCreature(89003, -5927,-4311,-58.749451,6.243208, 35, 0, 6219, 0, 0, 1, 0)
					pUnit:RegisterEvent("Q3402_PreFight", 1000, 1)
					--pUnit:RegisterEvent("Q3402_MassReset",360000,1)
				end
			end
		end
	end
end

function Q3402_PreFight(pUnit,Event)
	if q == 1 then
		TIKGnomA:SetMovementFlags(1)
		TIKGnomA:MoveTo(-5908,-4310,-58.749500,6.243208)
		TIKGnomB:SetMovementFlags(1)
		TIKGnomB:MoveTo(-5909,-4308,-58.749500,6.243208)
		TIKGnomC:SetMovementFlags(1)
		TIKGnomC:MoveTo(-5909,-4312,-58.749500,6.243208)
		pUnit:RegisterEvent("Q3402_PreFight",1000,1)
	elseif q == 2 then
		TIKGnomA:SendChatMessage(14, 0, "Hit it, HIT IT!")
		pUnit:RegisterEvent("Q3402_PreFight",1000,1)
	elseif q == 3 then
		TIKGnomA:Emote(27,5000)
		TIKGnomB:Emote(27,5000)
		TIKGnomC:Emote(27,5000)
		pUnit:RegisterEvent("Q3402_PreFight",1000,1)
	elseif q == 4 then
		local x,y,z,o = TIKWorm:GetLocation()
		TIKGnomA:CastSpellAoF(x, y, z, 4054)
		pUnit:RegisterEvent("Q3402_PreFight",100,1)
	elseif q == 5 then
		local x,y,z,o = TIKWorm:GetLocation()
		TIKGnomB:CastSpellAoF(x, y, z, 4054)
		TIKGnomC:CastSpellAoF(x, y, z, 4054)
		pUnit:RegisterEvent("Q3402_PreFight",1800,1)
	elseif q == 6 then
		pUnit:CastSpell(41918) -- To big :/??
		pUnit:RegisterEvent("Q3402_PreFight",100,1)
	elseif q == 7 then
		pUnit:CastSpell(41918)
		pUnit:SetStandState(7) 
		pUnit:RegisterEvent("Q3402_PreFight",2000,1)
	elseif q == 8 then
		TIKGnomC:SendChatMessage(12,0,"It's down!")
		TIKGnomB:Emote(4,2500)
		TIKGnomA:Emote(4,2500)
		TIKGnomC:Emote(22,2200)
		pUnit:RegisterEvent("Q3402_PreFight",2500,1)
	elseif q == 9 then
		TIKGnomC:SendChatMessage(12,0,"Now to take care of the rest...")
		pUnit:RegisterEvent("Q3402_PreFight",1000,1)
	elseif q == 10 then
		TIKGnomA:SetFaction(24)
		TIKGnomB:SetFaction(24)
		TIKGnomC:SetFaction(24)
		pUnit:RegisterEvent("Q3402_GnomeFight",3000,0)
		--pUnit:RegisterEvent("Q3402_ThrowDynamite",9000,0)
	end
	q = q + 1
end
--\/\/\/\/\/\/\/\/\/--
--//LE GNOME FIGHT\\--
--\/\/\/\/\/\/\/\/\/--

function Q3402_GnomeFight(pUnit,Event) --Debugging; Appears to be crashing the server
	if TIKGnomA ~= nil then
		if (TIKGnomA:GetHealthPct() <= 50) then
			if testboolean == false then
				TIKGnomA:RemoveEvents()
				local x,y,z,o = TIKGnomA:GetLocation()
				local Q3402_Voice = pUnit:SpawnCreature(89004, x,y,z,o, 35, 0, 0, 0, 0, 1, 0)
				Q3402_Voice:SendChatMessage(14,0,"WARNING! WARNING! Cake security has been breached! Activating emergency teleport!")
				Q3402_Voice:Despawn(1000,0)
				TIKGnomA:Despawn(1000,0)
				TIKGnomA:CastSpell(41232)
				TIKGnomA = nil
				qq = qq + 1
				testboolean = true
			end
		end
	end
	--[[if TIKGnomB ~= nil then
		if (TIKGnomB:GetHealthPct() <= 50) then
			TIKGnomB:RemoveEvents()
			local x,y,z,o = TIKGnomB:GetLocation()
			local Q3402_Voice = pUnit:SpawnCreature(89004, x,y,z,o, 35, 0, 0, 0, 0, 1, 0)
			Q3402_Voice:SendChatMessage(14,0,"Warning! Severe injuries detected. Activating emergency teleport!")
			Q3402_Voice:Despawn(1000,0)
			TIKGnomB:Despawn(1000,0)
			TIKGnomB:CastSpell(41232)
			TIKGnomB = nil
			qq = qq + 1
		end
	end
	if TIKGnomC ~= nil then
		if (TIKGnomC:GetHealthPct() <= 50) then
			TIKGnomC:RemoveEvents()
			local x,y,z,o = TIKGnomC:GetLocation()
			local Q3402_Voice = pUnit:SpawnCreature(89004, x,y,z,o, 35, 0, 0, 0, 0, 1, 0)
			Q3402_Voice:SendChatMessage(14,0,"Warning! Pony in danger! Activating emergency teleport!")
			Q3402_Voice:Despawn(1000,0)
			TIKGnomC:Despawn(1000,0)
			TIKGnomC:CastSpell(41232)
			TIKGnomC = nil
			qq = qq + 1
		end
	end
	if qq == 3 then
		pUnit:RemoveEvents()
		q = 1
		qq = 0
		TIKGnomA = nil
		TIKGnomB = nil
		TIKGnomC = nil
		q = 1
		qq = 0
		TIKSCALE  = 0.5
		TIKWorm:RegisterEvent("Q3402_LeWormGrowth",1600,4)
		TIKWorm:RegisterEvent("Q3402_LeWormFight",6400,1)
		TIKWorm:SendChatMessage(42,0,"The corpse of the worm starts expanding.... Rapidly")
	end]]--
	print("qq = "..tostring(qq))
end

function Q3402_ThrowDynamite(pUnit,Event)
	local i = math.random(1,100)
	if i > 85 and i < 100 then
		if TIKGnomA ~= nil then
			local x,y,z,o = plr:GetLocation()
			TIKGnomA:CastSpellAoF(x, y, z, 4054)
		end
	elseif i > 70 and i < 85 then
		if TIKGnomB ~= nil then
			local x,y,z,o = plr:GetLocation()
			TIKGnomB:CastSpellAoF(x, y, z, 4054)
		end
	elseif i > 55 and i < 70 then
		if TIKGnomC ~= nil then
			local x,y,z,o = plr:GetLocation()
			TIKGnomC:CastSpellAoF(x, y, z, 4054)
		end
	end
end

--\/\/\/\/\/\/\/\/\/--
--//Le Worm Fight!\\--
--\/\/\/\/\/\/\/\/\/--

function Q3402_LeWormGrowth(pUnit,Event)
	TIKSCALE = TIKSCALE + 0.1
	pUnit:SetScale(TIKSCALE)
	print("LeWormGrowth")
end

function Q3402_LeWormFight(pUnit,Event)
	pUnit:SpawnCreature(89018, -5884,-4300,-58.749420,4.328894, 14, 0, 0, 0, 0, 1, 0)
	TIKMaggot:SendChatMessage(42,0,"A maggot has spawned! (3)")
	TIKMaggot:RegisterEvent("Q3402_AMaggotsDream",3000,0)
	print("LeWormFight")
end

function Q3402_AMaggotsDream(pUnit,Event)
	if qqq == 1 then
		if (pUnit:GetHealthPct() <= 50) then
			pUnit:RemoveEvents()
			pUnit:SendChatMessage(42,0,"The maggot begins feeding on the worm...")
			pUnit:MoveTo(-5885.058594,-4301.469238,-58.74958,4.93647)
			pUnit:SetMaxHealth(800) 
			pUnit:CastSpell(25990)
			print("qqq is 1")
		end
	end
end
--\/\/\/\/\/\/\/\/\/\--
--//LE RESET BUTTON\\--
--\/\/\/\/\/\/\/\/\/\--
--[[
function Q3402_Reset()
	TIKWorm:RemoveEvents()
	TIKWorm:Despawn(1000,3000)
	if TIKGnomA ~= nil then
		TIKGnomA:Despawn(1000,0)
	end
	if TIKGnomB ~= nil then
		TIKGnomB:Despawn(1000,0)
	end
	if TIKGnomC ~= nil then
	TIKGnomC:Despawn(1000,0)
	end
	q = 1
	qq = 0

end

function Q3402_MassReset(pUnit,Event)
end]]--