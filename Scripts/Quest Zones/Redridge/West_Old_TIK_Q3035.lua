--[[
Quest Name: 		Old Problems
Quest ID: 			3035
Quest Starter: 		77110
Quest Finisher: 	77110
Made & scripted by Tikki100]]--
-----------------
--//Variables\\--
-----------------

--[[local UNIT_FLAG_NOT_SELECTABLE 		= 0x02000000  --Not needed since another script allready has this as a global variable.
local OBJECT_END 						= 0x0006
local UNIT_FIELD_FLAGS 					= OBJECT_END + 0x0035
local UNIT_FLAG_DEFAULT 				= 0X00]]--

local STANDSTATE_DEAD                	= 7
local STANDSTATE_STAND                 	= 0

local demartia							= nil
local demartib 							= nil
local demartic 							= nil
local demartid 							= nil

local plr1								= nil
local plr2								= nil
local plr3								= nil
local plr4								= nil

local q									= 0
local qq								= 0
local qqq								= 0
local qqqq								= 0

local Min1								= nil
local Min2								= nil
local War1								= nil

local Min3								= nil
local Min4								= nil
local War2								= nil

local Min5								= nil
local Min6								= nil
local War3								= nil

local Min7								= nil
local Min8								= nil
local min9								= nil
local War4								= nil

local cantuse							= false
local inuse								= false

--//Debug stuff\\--
local printon							= true
local ppt								= "TIK_Q3035.lua PRINT: " --Short for Pre Print Text
------------------------------------------
--//Define units when they spawn & Die\\--
------------------------------------------

function TIKLake_DemArti_OnSpawn(pUnit, Event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:CastSpell(52952)
	demartia = pUnit:GetUnitBySqlId(9272526) --Lakeshire Bridge
	demartib = pUnit:GetUnitBySqlId(9272527) --Lakeshire Inn
	demartic = pUnit:GetUnitBySqlId(9272544) --Lakeshire Manor
	demartid = pUnit:GetUnitBySqlId(9272546) --Lakeshire Town Hall
end

RegisterUnitEvent(77193, 18, "TIKLake_DemArti_OnSpawn")

function TIKLake_Citizen_OnSpawn(pUnit, Event)
	pUnit:RegisterEvent("TIKLake_Citizen_Define", 500, 1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

function TIKLake_Citizen_Define(pUnit,Event)
	pUnit:SetStandState(STANDSTATE_DEAD)
	pUnit:FullCastSpell(44816)	
end
RegisterUnitEvent(77194, 18, "TIKLake_Citizen_OnSpawn")

function TIKLake_Citizen_OnDeath(pUnit,Event)
	pUnit:Despawn(25000,0)
end

RegisterUnitEvent(77194, 4, "TIKLake_Citizen_OnDeath")

------------------
--//The events\\--
------------------

function TIKLake_Orb_OnUse(item, event, plr)
	TIKLake_Orb_MagicThingy(item, plr)
end

RegisterItemGossipEvent(29324, 1, "TIKLake_Orb_OnUse")

function TIKLake_Orb_MagicThingy(item, plr)
	if plr:IsInCombat() ~= true then
	print("Player is not in combat.")
		if demartia ~= nil and plr ~= nil then --Bridge
			print("A Passed Nil check. Posting Values...")
			print("demartia = "..tostring(demartia))
			print("plr = "..tostring(plr))
			if demartia ~= nil then
			if demartia:GetDistance(plr) < 35 then
				print("Player is within range of Crystal A")
				inuse = true
				print("Inuse = "..tostring(inuse))
				plr1 = plr
				print("plr1 = "..tostring(plr1))
				plr:SetPlayerLock(true)
				plr:ChannelSpell(24618, demartia)
				demartia:RegisterEvent("TIKLake_demartia_Event", 500, 1)
			end
			end
		else
			print("cantuse = "..tostring(cantuse))
			cantuse = true
		end
		if demartib ~= nil and plr ~= nil then --Inn
			print("B Passed Nil check. Posting Values...")
			print("demartib = "..tostring(demartib))
			print("plr = "..tostring(plr))
			if demartib ~= nil then
			if demartib:GetDistance(plr) < 35 then
				print("Player is within range of Crystal B")
				inuse = true
				print("Inuse = "..tostring(inuse))
				plr2 = plr
				print("plr2 = "..tostring(plr2))
				plr:SetPlayerLock(true)
				plr:ChannelSpell(24618, demartib)
				demartib:RegisterEvent("TIKLake_demartib_Event", 500, 1)
			end
			end
		else
			print("cantuse = "..tostring(cantuse))
			cantuse = true
		end
		if demartic ~= nil and plr ~= nil then --Manor
			print("C Passed Nil check. Posting Values...")
			print("demartic = "..tostring(demartic))
			print("plr = "..tostring(plr))
			if demartic ~= nil then
			if demartic:GetDistance(plr) < 35 then
				print("Player is within range of Crystal C")
				inuse = true
				print("Inuse = "..tostring(inuse))
				plr3 = plr
				print("plr3 = "..tostring(plr3))
				plr:SetPlayerLock(true)
				plr:ChannelSpell(24618, demartic)
				demartic:RegisterEvent("TIKLake_demartic_Event", 500, 1)
			end
			end
		else
			print("cantuse = "..tostring(cantuse))
			cantuse = true
		end
		if demartid ~= nil and plr ~= nil then --Town hall
			print("D Passed Nil check. Posting Values...")
			print("demartid = "..tostring(demartid))
			print("plr = "..tostring(plr))
			if demartid ~= nil then
			if demartid:GetDistance(plr) < 35 then
				print("Player is within range of Crystal D")
				inuse = true
				print("Inuse = "..tostring(inuse))
				plr4 = plr
				print("plr1 = "..tostring(plr4))
				plr:SetPlayerLock(true)
				plr:ChannelSpell(24618, demartid)
				demartid:RegisterEvent("TIKLake_demartid_Event", 500, 1)
			end
			end
		else
			print("cantuse = "..tostring(cantuse))
			cantuse = true
		end
		if cantuse == true then
			print("cantuse was true.")
			if inuse == false then
				print("inuse was false")
				plr:SendAreaTriggerMessage("|cFFFF0000You can not use this here!")
				cantuse = false
				print("Setting cantuse to false")
				print("cantuse = "..tostring(cantuse))
			end
		end
	end
end

------------------------
--//Lakeshire Bridge\\--
------------------------

function TIKLake_demartia_Event(pUnit,Event)
	if q == 0 then
		Min1 = pUnit:SpawnCreature(77194, -9342.659180, -2193.693115, 61.897728, 1.145851, 35, 300000)
		Min2 = pUnit:SpawnCreature(77194, -9346.033203, -2191.454102, 61.897728, 0.661232, 35, 300000)
		War1 = pUnit:SpawnCreature(77195, -9341.658555, -2190.616943, 61.898243, 3.693218, 35, 300000)
		demartia:RegisterEvent("TIKLake_demartia_Event", 1000, 1)
		War1:FullCastSpell(44816)
		inuse = false
	elseif q == 1 then
		War1:SendChatMessage(12, 0, "Rise minions... Rise and serve the master...")
		demartia:RegisterEvent("TIKLake_demartia_Event", 1000, 1)
	elseif q == 2 then
		Min1:ChannelSpell(24618, War1)
		Min2:ChannelSpell(24618, War1)
		demartia:RegisterEvent("TIKLake_demartia_Event", 6000, 1)
	elseif q == 3 then
		Min1:StopChannel()
		Min2:StopChannel()
		demartia:RegisterEvent("TIKLake_demartia_Event", 100, 1)
	elseif q == 4 then
		Min1:FullCastSpell(46242)
		Min2:FullCastSpell(46242)
		War1:SendChatMessage(12,0,"Yes. Rise!")
		demartia:RegisterEvent("TIKLake_demartia_Event", 3000, 1)
	elseif q == 5 then
		Min1:SetModel(15298)
		Min1:SetScale(0.7)
		Min2:SetModel(15298)
		Min2:SetScale(0.7)
		pUnit:SendChatMessageToPlayer(42,0,"The crystal begins to shatters.", plr1)
		demartia:RegisterEvent("TIKLake_demartia_Event", 1000, 1)
	elseif q == 6 then
		Min1:SetStandState(0)
		Min2:SetStandState(0)
		demartia:FullCastSpell(34656)
		if plr1:HasQuest(3035) == true then
			if (plr1:GetQuestObjectiveCompletion(3035, 0) ~= 4) then
				plr1:AdvanceQuestObjective(3035, 0)
			end
		end
		demartia:RegisterEvent("TIKLake_demartia_Event", 3000,1)
	elseif q == 7 then
		pUnit:SendChatMessageToPlayer(42,0,"The crystal has brought the demons to the present!",plr1)
		demartia:FullCastSpell(34656)
		Min1:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Min2:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Min1:RemoveAura(44816)
		Min2:RemoveAura(44816)
		War1:FullCastSpell(44816)
		plr1:SetPlayerLock(false)
		plr1:StopChannel()
		Min1:SetFaction(100)
		Min2:SetFaction(100)
		demartia:RegisterEvent("TIKLake_demartia_Event", 3000,1)
	elseif q == 8 then
		demartia:FullCastSpell(34656)
		War1:SendChatMessage(12,0,"Huh? Where did they go...? Hmpf.. I better continue.")
		demartia:RegisterEvent("TIKLake_demartia_Event", 1000,1)
	elseif q == 9 then
		demartia:FullCastSpell(34656)
		demartia:Despawn(1000,150000)
		War1:Despawn(2000,0)
		q = -1
	end
	q = q + 1
end

---------------------
--//Lakeshire Inn\\--
---------------------

function TIKLake_demartib_Event(pUnit,Event)
	if qq == 0 then
		Min3 = pUnit:SpawnCreature(77194, -9224.795898,-2159.039063,63.730877,4.502909, 35, 300000)
		Min4 = pUnit:SpawnCreature(77194, -9227.434570,-2159.841553,63.730980,5.168142, 35, 300000)
		War2 = pUnit:SpawnCreature(77195, -9226.239258,-2163.416504,63.731022,1.519967, 35, 300000)
		demartib:RegisterEvent("TIKLake_demartib_Event", 1000, 1)
		War2:FullCastSpell(44816)
		inuse = false
	elseif qq == 1 then
		War2:SendChatMessage(12, 0, "Live... Live my minions! Muhahaha!")
		demartib:RegisterEvent("TIKLake_demartib_Event", 1000, 1)
	elseif qq == 2 then
		Min3:ChannelSpell(24618, War2)
		Min4:ChannelSpell(24618, War2)
		demartib:RegisterEvent("TIKLake_demartib_Event", 6000, 1)
	elseif qq == 3 then
		Min3:StopChannel()
		Min4:StopChannel()
		demartib:RegisterEvent("TIKLake_demartib_Event", 100, 1)
	elseif qq == 4 then
		Min3:FullCastSpell(46242)
		Min4:FullCastSpell(46242)
		War2:SendChatMessage(12,0,"Arise, my champions...")
		demartib:RegisterEvent("TIKLake_demartib_Event", 3000, 1)
	elseif qq == 5 then
		Min3:SetModel(15298)
		Min3:SetScale(0.7)
		Min4:SetModel(15298)
		Min4:SetScale(0.7)
		pUnit:SendChatMessageToPlayer(42,0,"The crystal begins to shatters.", plr2)
		demartib:RegisterEvent("TIKLake_demartib_Event", 1000, 1)
	elseif qq == 6 then
		Min3:SetStandState(0)
		Min4:SetStandState(0)
		demartib:FullCastSpell(34656)
		if plr2:HasQuest(3035) == true then
			if (plr2:GetQuestObjectiveCompletion(3035, 0) ~= 4) then
				plr2:AdvanceQuestObjective(3035, 0)
			end
		end
		demartib:RegisterEvent("TIKLake_demartib_Event", 3000,1)
	elseif qq == 7 then
		pUnit:SendChatMessageToPlayer(42,0,"The crystal has brought the demons to the present!",plr2)
		demartib:FullCastSpell(34656)
		Min3:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Min4:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Min3:RemoveAura(44816)
		Min4:RemoveAura(44816)
		War2:FullCastSpell(44816)
		plr2:SetPlayerLock(false)
		plr2:StopChannel()
		Min3:SetFaction(100)
		Min4:SetFaction(100)
		demartib:RegisterEvent("TIKLake_demartib_Event", 3000,1)
	elseif qq == 8 then
		demartib:FullCastSpell(34656)
		War2:SendChatMessage(12,0,"Once I can live with, but twice...?")
		demartib:RegisterEvent("TIKLake_demartib_Event", 1000,1)
	elseif qq == 9 then
		demartib:FullCastSpell(34656)
		demartib:Despawn(1000,150000)
		War2:Despawn(2000,0)
		qq = -1
	end
	qq = qq + 1
end

-----------------------
--//Lakeshire Manor\\--
-----------------------

function TIKLake_demartic_Event(pUnit,Event)
	if qqq == 0 then
		Min5 = pUnit:SpawnCreature(77194, -9215.528320,-2061.189209,78.099083,5.492024, 35, 300000)
		Min6 = pUnit:SpawnCreature(77194, -9210.762305,-2060.691162,78.099083,4.372828, 35, 300000)
		War3 = pUnit:SpawnCreature(77195, -9209.056641,-2065.084473,78.099083,2.455672, 35, 300000)
		demartic:RegisterEvent("TIKLake_demartic_Event", 1000, 1)
		War3:FullCastSpell(44816)
		inuse = false
	elseif qqq == 1 then
		War3:SendChatMessage(12, 0, "Live... Live my minions! Muhahaha!")
		demartic:RegisterEvent("TIKLake_demartic_Event", 1000, 1)
	elseif qqq == 2 then
		Min5:ChannelSpell(24618, War3)
		Min6:ChannelSpell(24618, War3)
		demartic:RegisterEvent("TIKLake_demartic_Event", 6000, 1)
	elseif qqq == 3 then
		Min5:StopChannel()
		Min6:StopChannel()
		demartic:RegisterEvent("TIKLake_demartic_Event", 100, 1)
	elseif qqq == 4 then
		Min5:FullCastSpell(46242)
		Min6:FullCastSpell(46242)
		War3:SendChatMessage(12,0,"Wakey wakey.")
		demartic:RegisterEvent("TIKLake_demartic_Event", 3000, 1)
	elseif qqq == 5 then
		Min5:SetModel(15298)
		Min5:SetScale(0.7)
		Min6:SetModel(15298)
		Min6:SetScale(0.7)
		pUnit:SendChatMessageToPlayer(42,0,"The crystal begins to shatters.", plr3)
		demartic:RegisterEvent("TIKLake_demartic_Event", 1000, 1)
	elseif qqq == 6 then
		Min5:SetStandState(0)
		Min6:SetStandState(0)
		demartic:FullCastSpell(34656)
		if plr3:HasQuest(3035) == true then
			if (plr3:GetQuestObjectiveCompletion(3035, 0) ~= 4) then
				plr3:AdvanceQuestObjective(3035, 0)
			end
		end
		demartic:RegisterEvent("TIKLake_demartic_Event", 3000,1)
	elseif qqq == 7 then
		pUnit:SendChatMessageToPlayer(42,0,"The crystal has brought the demons to the present!",plr3)
		demartic:FullCastSpell(34656)
		Min5:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Min6:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Min5:RemoveAura(44816)
		Min6:RemoveAura(44816)
		War3:FullCastSpell(44816)
		plr3:SetPlayerLock(false)
		plr3:StopChannel()
		Min5:SetFaction(100)
		Min6:SetFaction(100)
		demartic:RegisterEvent("TIKLake_demartic_Event", 3000,1)
	elseif qqq == 8 then
		demartic:FullCastSpell(34656)
		War3:SendChatMessage(12,0,"Where did they..? Did I send them to the Twisting Nether? Ups...")
		demartic:RegisterEvent("TIKLake_demartic_Event", 1000,1)
	elseif qqq == 9 then
		demartic:FullCastSpell(34656)
		demartic:Despawn(1000,150000)
		War3:Despawn(6000,0)
		qqq = -1
	end
	qqq = qqq + 1
end

---------------------------
--//Lakeshire Town Hall\\--
---------------------------

function TIKLake_demartid_Event(pUnit,Event)
	if qqqq == 0 then
		Min7 = pUnit:SpawnCreature(77194, -9222.002930,-2193.953369,66.180145,5.384115, 35, 300000)
		Min8 = pUnit:SpawnCreature(77194, -9217.694336,-2193.204834,66.180145,4.648496, 35, 300000)
		Min9 = pUnit:SpawnCreature(77194, -9213.126953,-2195.181396,66.180145,3.870953, 35, 300000)
		War4 = pUnit:SpawnCreature(77195, -9217.312500,-2199.150391,66.180053,1.563454, 35, 300000)
		demartid:RegisterEvent("TIKLake_demartid_Event", 1000, 1)
		inuse = false
		War4:FullCastSpell(44816)
	elseif qqqq == 1 then
		War4:SendChatMessage(12, 0, "The master shall be most pleased with my progress...")
		demartid:RegisterEvent("TIKLake_demartid_Event", 1000, 1)
	elseif qqqq == 2 then
		Min7:ChannelSpell(24618, War4)
		Min8:ChannelSpell(24618, War4)
		Min9:ChannelSpell(24618, War4)
		demartid:RegisterEvent("TIKLake_demartid_Event", 6000, 1)
	elseif qqqq == 3 then
		Min7:StopChannel()
		Min8:StopChannel()
		Min9:StopChannel()
		demartid:RegisterEvent("TIKLake_demartid_Event", 100, 1)
	elseif qqqq == 4 then
		Min7:FullCastSpell(46242)
		Min8:FullCastSpell(46242)
		Min9:FullCastSpell(46242)
		War4:SendChatMessage(12,0,"Breathe once more, fallen champions... Feel the power!")
		demartid:RegisterEvent("TIKLake_demartid_Event", 3000, 1)
	elseif qqqq == 5 then
		Min7:SetModel(15298)
		Min7:SetScale(0.7)
		Min8:SetModel(15298)
		Min8:SetScale(0.7)
		Min9:SetModel(15298)
		Min9:SetScale(0.7)
		pUnit:SendChatMessageToPlayer(42,0,"The crystal begins to shatters.", plr4)
		demartid:RegisterEvent("TIKLake_demartid_Event", 1000, 1)
	elseif qqqq == 6 then
		Min7:SetStandState(0)
		Min8:SetStandState(0)
		Min9:SetStandState(0)
		demartid:FullCastSpell(34656)
		if plr4:HasQuest(3035) == true then
			if (plr4:GetQuestObjectiveCompletion(3035, 0) ~= 4) then
				plr4:AdvanceQuestObjective(3035, 0)
			end
		end
		demartid:RegisterEvent("TIKLake_demartid_Event", 3000,1)
	elseif qqqq == 7 then
		pUnit:SendChatMessageToPlayer(42,0,"The crystal has brought the demons to the present!",plr4)
		demartid:FullCastSpell(34656)
		Min7:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Min8:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Min9:RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		Min7:RemoveAura(44816)
		Min8:RemoveAura(44816)
		Min9:RemoveAura(44816)
		War4:FullCastSpell(44816)
		plr4:SetPlayerLock(false)
		plr4:StopChannel()
		Min7:SetFaction(100)
		Min8:SetFaction(100)
		Min9:SetFaction(100)
		demartid:RegisterEvent("TIKLake_demartid_Event", 3000,1)
	elseif qqqq == 8 then
		demartid:FullCastSpell(34656)
		War4:SendChatMessage(12,0,"It most be the bloody spell...")
		demartid:RegisterEvent("TIKLake_demartid_Event", 1000,1)
	elseif qqqq == 9 then
		demartid:FullCastSpell(34656)
		demartid:Despawn(1000,150000)
		War4:Despawn(4000,0)
		qqqq = -1
	end
	qqqq = qqqq + 1
end