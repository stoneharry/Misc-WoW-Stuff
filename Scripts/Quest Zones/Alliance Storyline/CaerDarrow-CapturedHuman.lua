local PMNZ_CageObject_EntryID = 90505
local QWCE_CapturedHuman_UnitID = 90505

local ASDIASd_FearEmote_kjalshdoiasd = 431

function IOCCWR_WECEWWE_CapturedHuman_OnSpawn(pUnit, event)
	HIOSAC_CapturedHuman_COmNomNom = pUnit
	HIOSAC_CapturedHuman_COmNomNom:SetMovementFlags(0)
	HIOSAC_CapturedHuman_COmNomNom:SetUInt32Value(UNIT_NPC_EMOTESTATE, ASDIASd_FearEmote_kjalshdoiasd)
end

RegisterUnitEvent(QWCE_CapturedHuman_UnitID, 18, "IOCCWR_WECEWWE_CapturedHuman_OnSpawn")

function CPEACAE_Cage_asdasd_OnUseZXC(pMisc, event, player)
	if (player:HasQuest(90505) == true) then
		if (player:GetQuestObjectiveCompletion(90505, 0) == 1) then
			HIOSAC_CapturedHuman_COmNomNom:SendChatMessageToPlayer(12, 0, "Please... Don't kill me!", player)
		else
		HIOSAC_CapturedHuman_COmNomNom:SetUInt32Value(UNIT_NPC_EMOTESTATE, 0)
		HIOSAC_CapturedHuman_COmNomNom:SendChatMessage(12, 0, "Thank you, "..player:GetName().."!")
		HIOSAC_CapturedHuman_COmNomNom:Emote(1, 1850)
		HIOSAC_CapturedHuman_COmNomNom:RegisterEvent("IUOCHWECWE_WeNeedToRun_omgnomnom", 1860, 1)
		player:AdvanceQuestObjective(90505, 0)
		end
	else
		HIOSAC_CapturedHuman_COmNomNom:SendChatMessageToPlayer(12, 0, "Please... Don't kill me!", player)
	end
end

RegisterGameObjectEvent(PMNZ_CageObject_EntryID, 4, "CPEACAE_Cage_asdasd_OnUseZXC")

function IUOCHWECWE_WeNeedToRun_omgnomnom(pUnit, event)
	HIOSAC_CapturedHuman_COmNomNom:SetMovementFlags(1)
	HIOSAC_CapturedHuman_COmNomNom:MoveTo(1199.602417, -2370.494141, 58.424507)
	HIOSAC_CapturedHuman_COmNomNom:RegisterEvent("QWEASDZXC_QWEIOPASD_Morerunbye", 1200, 1)
end

function QWEASDZXC_QWEIOPASD_Morerunbye(pUnit, event)
	HIOSAC_CapturedHuman_COmNomNom:MoveTo(1192.340942, -2392.032227, 60.031815)
	HIOSAC_CapturedHuman_COmNomNom:Despawn(2000, 24000)
end