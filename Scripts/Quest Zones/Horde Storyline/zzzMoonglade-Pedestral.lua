------------------------------------------

local GBVOERMoonwellTriggerZCA = nil
local BIERBEDPedestralTriggerEVR = nil
local OVIRVEWRVEMoonWellGetDistanceOMGZWE = nil
local player = nil

local BRVCMoonwellTrigger_UnitEntryIDZCE = 90000
local ICOQPedestralTrigger_QWCUnitEntryIDBVREVR = 90001

local VRSVSR_EmptyBottle_HCEEItemEntryID = 12814
local NRTBRT_FilledBottle_WQEQItemEntryID = 9321

----------- On Spawn Functions -----------

function BUVIOERZZ_MoonwellTriggerCEAC_OnSpawnCAECAE(pUnit, event)
	GBVOERMoonwellTriggerZCA = pUnit
end

function ERBEHRIO_PedestralTriggerBERV_OnSpawnNCEAIO(pUnit, event)
	BIERBEDPedestralTriggerEVR = pUnit
end

RegisterUnitEvent(BRVCMoonwellTrigger_UnitEntryIDZCE, 18, "BUVIOERZZ_MoonwellTriggerCEAC_OnSpawnCAECAE")
RegisterUnitEvent(ICOQPedestralTrigger_QWCUnitEntryIDBVREVR, 18, "ERBEHRIO_PedestralTriggerBERV_OnSpawnNCEAIO")

----------- OnItemUse Functions -----------

function IOHWQEVWQEV_CEACEmptyBottleItem_CIEAOnUse(pItem, event, player)
	local test = player:GetCreatureNearestCoords(7983.92,-2504.65,487.161,90000)
	if test ~= nil then
		local OVIRVEWRVEMoonWellGetDistanceOMGZWE = player:GetDistanceYards(test)
		if (OVIRVEWRVEMoonWellGetDistanceOMGZWE ~= nil and OVIRVEWRVEMoonWellGetDistanceOMGZWE <= 6) then
			player:RemoveItem(VRSVSR_EmptyBottle_HCEEItemEntryID, 1)
			player:AddItem(NRTBRT_FilledBottle_WQEQItemEntryID, 1)
			player:CastSpell(69665)
			if (player:HasQuest(90000) == true) then
				player:AdvanceQuestObjective(90000, 0)
			end
			player = nil
		else
			player:SendAreaTriggerMessage("|CFFff0000You need to be inside the Moonwell!|R")
		end
	else
		if (GBVOERMoonwellTriggerZCA ~= nil) then
			local OVIRVEWRVEMoonWellGetDistanceOMGZWE = player:GetDistanceYards(GBVOERMoonwellTriggerZCA)
			if (OVIRVEWRVEMoonWellGetDistanceOMGZWE ~= nil and OVIRVEWRVEMoonWellGetDistanceOMGZWE <= 6) then
				player:RemoveItem(VRSVSR_EmptyBottle_HCEEItemEntryID, 1)
				player:AddItem(NRTBRT_FilledBottle_WQEQItemEntryID, 1)
				player:CastSpell(69665)
				if (player:HasQuest(90000) == true) then
					player:AdvanceQuestObjective(90000, 0)
				end
				player = nil
			else
				player:SendAreaTriggerMessage("|CFFff0000You need to be inside the Moonwell!|R")
			end
		end
	end
end

RegisterItemGossipEvent(VRSVSR_EmptyBottle_HCEEItemEntryID, 1, "IOHWQEVWQEV_CEACEmptyBottleItem_CIEAOnUse")

function ERBCWQECWE_FilledBottleItem_IOEVVOnUse(pItem, event, player)
	if (BIERBEDPedestralTriggerEVR ~= nil) then
		local AOCIHAECIAEPedestralGetDistanceIOBWCEwe = player:GetDistance(BIERBEDPedestralTriggerEVR)
			if (AOCIHAECIAEPedestralGetDistanceIOBWCEwe ~= nil and AOCIHAECIAEPedestralGetDistanceIOBWCEwe <= 10) then
				player:CastSpellAoF(7997.309082, -2483.291992, 493.005646, 51661)
				BIERBEDPedestralTriggerEVR:SpawnGameObject(225505, 7997.424316, -2483.240234, 492.981659, 0.099132, 6000, 100)
				BIERBEDPedestralTriggerEVR:SpawnGameObject(183812, 7997.424316, -2483.240234, 492.981659, 0.099132, 6000, 100)
				player:RemoveItem(NRTBRT_FilledBottle_WQEQItemEntryID, 1)
					if (player:HasQuest(90000) == true) then
						player:AdvanceQuestObjective(90000, 1)
					end
			else
				player:SendAreaTriggerMessage("|CFFff0000You need to be near Blessed Pedestral!|R")
			end
	end
end

RegisterItemGossipEvent(NRTBRT_FilledBottle_WQEQItemEntryID, 1, "ERBCWQECWE_FilledBottleItem_IOEVVOnUse")

----------- End Of The Script ----------- :)