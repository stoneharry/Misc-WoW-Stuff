LEVEL_UP_TYPE_CHARACTER = "character";	--Name used in globalstring LEVEL_UP
LEVEL_UP_TYPE_GUILD = "guild";	--Name used in globalstring GUILD_LEVEL_UP
LEVEL_UP_TYPE_PET = "pet" -- Name used in globalstring PET_LEVEL_UP
LEVEL_UP_TYPE_SCENARIO = "scenario";
TOAST_QUEST_BOSS_EMOTE = "questbossemote";
TOAST_PET_BATTLE_WINNER = "petbattlewinner";
TOAST_CHALLENGE_MODE_RECORD = "challengemode";

LEVEL_UP_FEATURE2 = "test";
LEVEL_UP_SPECIALIZATION_LINK = " testing";
LEVEL_UP_TALENTS_LINK = " testing2";
LEVEL_UP_BG_LINK = " testing3";
LEVEL_UP_LFD_LINK  = " testing4";
LEVEL_UP_DUAL_SPEC_LINK = " testing5";
LEVEL_UP_ABILITY2 = "Ability2 ";
LEVEL_UP_YOU_REACHED = "Congratulations, you have achieved"

scen_name, scen_currentStage, scen_numStages, scen_stageName, scen_stageDescription = "", 0, 0, "", "";

LEVEL_UP_EVENTS = {
--  Level  = {unlock}
	[10] = {"SpecializationUnlocked", "BGsUnlocked"},
	[10] = {"TalentsUnlocked","LFDUnlocked"},
	[30] = {"Glyphs"},
	[30] = {"DualSpec"},
	[50] = {"GlyphSlots"},
	[70] = {"HeroicBurningCrusade"},
	[75] = {"GlyphSlots"},
	[80] = {"HeroicWrathOfTheLichKing"},
	[85] = {"HeroicCataclysm"},
	[90] = {"HeroicMistsOfPandaria"},
}

SUBICON_TEXCOOR_BOOK 	= {0.64257813, 0.72070313, 0.03710938, 0.11132813};
SUBICON_TEXCOOR_LOCK	= {0.64257813, 0.70117188, 0.11523438, 0.18359375};
SUBICON_TEXCOOR_ARROW 	= {0.72460938, 0.78320313, 0.03710938, 0.10351563};

local levelUpTexCoords = {
	[LEVEL_UP_TYPE_CHARACTER] = {
		dot = { 0.64257813, 0.68359375, 0.18750000, 0.23046875 },
		goldBG = { 0.56054688, 0.99609375, 0.24218750, 0.46679688 },
		gLine = { 0.00195313, 0.81835938, 0.01953125, 0.03320313 },
		gLineDelay = 1.5,
	},
	[LEVEL_UP_TYPE_GUILD] = {
		dot = { 0.64257813, 0.68359375, 0.77734375, 0.8203125 },
		goldBG = { 0.56054688, 0.99609375, 0.486328125, 0.7109375 },
		gLine = { 0.00195313, 0.81835938, 0.96484375, 0.97851563 },
		textTint = {0.11765, 1, 0},
		gLineDelay = 1.5,
	},
	[LEVEL_UP_TYPE_PET] = {
		dot = { 0.64257813, 0.68359375, 0.18750000, 0.23046875 },
		goldBG = { 0.56054688, 0.99609375, 0.24218750, 0.46679688 },
		gLine = { 0.00195313, 0.81835938, 0.01953125, 0.03320313 },
		tint = {1, 0.5, 0.25},
		textTint = {1, 0.7, 0.25},
		gLineDelay = 1.5,
	},
	[TOAST_PET_BATTLE_WINNER] = {
		gLine = { 0.00195313, 0.81835938, 0.01953125, 0.03320313 },
		tint = {1, 0.5, 0.25},
		textTint = {1, 0.7, 0.25},
		gLineDelay = 1.5,
	},
	[LEVEL_UP_TYPE_SCENARIO] = {
		gLine = { 0.00195313, 0.81835938, 0.00195313, 0.01562500 },
		tint = {1, 0.996, 0.745},
		gLineDelay = 0,
	},
	[TOAST_QUEST_BOSS_EMOTE] = {
		gLine = { 0.00195313, 0.81835938, 0.01953125, 0.03320313 },
		tint = {1, 0.996, 0.745},
		textTint = {1, 0.7, 0.25},
		gLineDelay = 0,
	},
	[TOAST_CHALLENGE_MODE_RECORD] = {
		gLine = { 0.00195313, 0.81835938, 0.00195313, 0.01562500 },
		tint = {0.777, 0.698, 0.451},
		gLineDelay = 0,
	},	
}

LEVEL_UP_TYPES = {
	["TalentPoint"] 			=	{	icon="Interface\\Icons\\Ability_Marksmanship",
										subIcon=SUBICON_TEXCOOR_ARROW,
										text=LEVEL_UP_TALENT_MAIN,
										subText=LEVEL_UP_TALENT_SUB,
										link=LEVEL_UP_TALENTPOINT_LINK;
									},
	
	["PetTalentPoint"] 			=	{	icon="Interface\\Icons\\Ability_Marksmanship",
										subIcon=SUBICON_TEXCOOR_ARROW,
										text=PET_LEVEL_UP_TALENT_MAIN,
										subText=PET_LEVEL_UP_TALENT_SUB,
										link=PET_LEVEL_UP_TALENTPOINT_LINK;
									},
									
	["SpecializationUnlocked"] 	= 	{	icon="Interface\\Icons\\Ability_Marksmanship",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=SPECIALIZATION,
										subText=LEVEL_UP_FEATURE,
										link=LEVEL_UP_FEATURE2..LEVEL_UP_SPECIALIZATION_LINK
									},
									
	["TalentsUnlocked"] 		= 	{	icon="Interface\\Icons\\Ability_Marksmanship",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=TALENT_POINTS,
										subText=LEVEL_UP_FEATURE,
										link=LEVEL_UP_FEATURE2..LEVEL_UP_TALENTS_LINK
									},
									
	["BGsUnlocked"] 			= 	{	icon="Interface\\Icons\\Ability_DualWield",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=BATTLEFIELDS,
										subText=LEVEL_UP_FEATURE,
										link=LEVEL_UP_FEATURE2..LEVEL_UP_BG_LINK
									},

	["LFDUnlocked"] 			= 	{	icon="Interface\\Icons\\LevelUpIcon-LFD",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=LOOKING_FOR_DUNGEON,
										subText=LEVEL_UP_FEATURE,
										link=LEVEL_UP_FEATURE2..LEVEL_UP_LFD_LINK
									},

	["Glyphs"]					=	{	icon="Interface\\Icons\\Inv_inscription_tradeskill01",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=GLYPHS,
										subText=LEVEL_UP_FEATURE,
										link=LEVEL_UP_GLYPHSLOT_LINK
									},

	["GlyphSlots"]				= 	{	icon="Interface\\Icons\\Inv_inscription_tradeskill01",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=GLYPH_SLOTS,
										subText=LEVEL_UP_FEATURE,
										link=LEVEL_UP_GLYPHSLOT_LINK
									},

	["DualSpec"] 				=	{	icon="Interface\\Icons\\INV_Misc_Coin_01",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=LEVEL_UP_DUALSPEC,
										subText=LEVEL_UP_FEATURE,
										link=LEVEL_UP_FEATURE2..LEVEL_UP_DUAL_SPEC_LINK
									},

	["HeroicBurningCrusade"]	=	{	entryType = "heroicdungeon",
										tier = 2,
										icon="Interface\\Icons\\ExpansionIcon_BurningCrusade",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=EXPANSION_NAME1,
										subText=LEVEL_UP_HEROIC,
									},
									
	["HeroicWrathOfTheLichKing"]= 	{	entryType = "heroicdungeon",
										tier = 3,
										icon="Interface\\Icons\\ExpansionIcon_WrathoftheLichKing",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=EXPANSION_NAME2,
										subText=LEVEL_UP_HEROIC,
									},
									
	["HeroicCataclysm"]			=	{	entryType = "heroicdungeon",
										tier = 4,
										icon="Interface\\Icons\\ExpansionIcon_Cataclysm",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=EXPANSION_NAME3,
										subText=LEVEL_UP_HEROIC,
									},
									
	["HeroicMistsOfPandaria"]	= 	{ 	entryType = "heroicdungeon",
										tier = 5,
										icon="Interface\\Icons\\ExpansionIcon_MistsofPandaria",
										subIcon=SUBICON_TEXCOOR_LOCK,
										text=EXPANSION_NAME4,
										subText=LEVEL_UP_HEROIC
									},
									
------ HACKS BELOW		
 	["Teleports"] 			= {	spellID=109424	},
	["PortalsHorde"]		= {	spellID=109400	},
	["PortalsAlliance"]		= {	spellID=109401	},
									
 	["LockMount1"] 			= {	spellID=5784	},
 	["LockMount2"] 			= {	spellID=23161	},
 	["PaliMount1"] 			= {	spellID=34769	},
 	["PaliMount2"] 			= {	spellID=34767	},
 	["PaliMountTauren1"] 	= {	spellID=69820	},
 	["PaliMountTauren2"] 	= {	spellID=69826	},
 	["PaliMountDraenei1"] 	= {	spellID=73629	},
 	["PaliMountDraenei2"] 	= {	spellID=73630	},
 	
	["Plate"]	 			= {	spellID=750, feature=true},
	["Mail"] 				= {	spellID=8737, feature=true	},
	
	["TrackBeast"] 			= {	spellID=1494  },
	["TrackHumanoid"] 		= {	spellID=19883  },
	["TrackUndead"] 		= {	spellID=19884  },
	["TrackHidden"] 		= {	spellID=19885  },
	["TrackElemental"] 		= {	spellID=19880  },
	["TrackDemons"] 		= {	spellID=19878 },
	["TrackGiants"] 		= {	spellID=19882  },
	["TrackDragonkin"] 		= {	spellID=19879  },
------ END HACKS
}


LEVEL_UP_CLASS_HACKS = {
	
	["MAGEHorde"] 		= {
							--  Level  = {unlock}
								[50] = {"Teleports"},
								[50] = {"PortalsHorde"},
							},
	["MAGEAlliance"]	= {
							--  Level  = {unlock}
								[50] = {"Teleports"},
								[50] = {"PortalsAlliance"},
							},
	["WARLOCK"] 		= {
							--  Level  = {unlock}
								[50] = {"LockMount1"},
								[50] = {"LockMount2"},
							},
	["SHAMAN"] 		= {
							--  Level  = {unlock}
								[50] = {"Mail"},
							},
	["HUNTER"] 		= {
							--  Level  = {unlock}
								[50] = {"TrackBeast"},
								[50] = {"TrackHumanoid"},
								[50] = {"TrackUndead"},
								[50] = {"TrackHidden"},
								[50] = {"TrackElemental"},
								[50] = {"TrackDemons"},
								[50] = {"Mail"},
								[50] = {"TrackGiants"},
								[50] = {"TrackDragonkin"},
							},
	["WARRIOR"] 		= {
							--  Level  = {unlock}
								[50] = {"Plate"},
							},
	["PALADIN"] 		= {
							--  Level  = {unlock}
								[50] = {"PaliMount1"},
								[50] = {"PaliMount2", "Plate"},
							},
	["PALADINTauren"]	= {
							--  Level  = {unlock}
								[50] = {"PaliMountTauren1"},
								[50] = {"PaliMountTauren2", "Plate"},
							},	
	["PALADINDraenei"]	= {
							--  Level  = {unlock}
								[50] = {"PaliMountDraenei1"},
								[50] = {"PaliMountDraenei2", "Plate"},
							},	
}

LEVEL_UP_TRAP_LEVELS = {427, 77, 135}

function LevelUpDisplay_OnLoad(self)
	self:RegisterEvent("PLAYER_LEVEL_UP");
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	--[[self:RegisterEvent("UNIT_GUILD_LEVEL");
	self:RegisterEvent("UNIT_LEVEL");
	self:RegisterEvent("SCENARIO_UPDATE");
	self:RegisterEvent("PET_BATTLE_FINAL_ROUND"); -- display winner, start listening for additional results
	self:RegisterEvent("PET_BATTLE_CLOSE");        -- stop listening for additional results
	self:RegisterEvent("QUEST_BOSS_EMOTE");
	self:RegisterEvent("CHALLENGE_MODE_NEW_RECORD");
	self:RegisterEvent("PET_JOURNAL_TRAP_LEVEL_SET");]]
	self.currSpell = 0;

end

function LevelUpDisplay_OnEvent(self, event, ...)
	local arg1 = ...;
	if event ==  "PLAYER_LEVEL_UP" then
		local level = ...
		self.level = level;
		self.type = LEVEL_UP_TYPE_CHARACTER;
		self:Show();
		LevelUpDisplaySide:Hide();
	--elseif event == "CHAT_MSG_SYSTEM" then
		--local messageGot = arg1;
		
	--[[elseif event == "UNIT_GUILD_LEVEL" then
		local unit, level = ...;
		if ( unit == "player" ) then
			self.level = level;
			self.type = LEVEL_UP_TYPE_GUILD;
			self:Show();
			LevelUpDisplaySide:Hide();
		end
	elseif event == "UNIT_LEVEL" and arg1 == "pet" then
		if (UnitName("pet") ~= UNKNOWNOBJECT) then
			self.level = UnitLevel("pet");
			self.type = LEVEL_UP_TYPE_PET;
			self:Show();
			LevelUpDisplaySide:Hide();
		end
	elseif ( event == "SCENARIO_UPDATE" ) then
		if ( arg1 and not C_Scenario.IsChallengeMode() ) then
			self.type = LEVEL_UP_TYPE_SCENARIO;
			self:Show();
		end
	elseif ( event == "ZONE_CHANGED_NEW_AREA" ) then
		self:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
		LevelUpDisplay_OnShow(self);
	elseif ( event == "PET_BATTLE_CLOSE" ) then
		self:UnregisterEvent("PET_BATTLE_LEVEL_CHANGED");
		self:UnregisterEvent("PET_BATTLE_CAPTURED");
	elseif ( event == "PET_BATTLE_FINAL_ROUND" ) then
		self:RegisterEvent("PET_BATTLE_LEVEL_CHANGED");
		self:RegisterEvent("PET_BATTLE_CAPTURED");
		self.type = TOAST_PET_BATTLE_WINNER;
		self.winner = arg1;
		self:Show();
	elseif ( event == "PET_JOURNAL_TRAP_LEVEL_SET" ) then
		local trapLevel = ...;
		if (trapLevel >= 1 and trapLevel <= #LEVEL_UP_TRAP_LEVELS) then
			LevelUpDisplay_AddBattlePetTrapUpgradeEvent(self, trapLevel);
		end
	elseif ( event == "PET_BATTLE_LEVEL_CHANGED" ) then
		local activePlayer, activePetSlot, newLevel = ...;
		if (activePlayer == LE_BATTLE_PET_ALLY) then
			LevelUpDisplay_AddBattlePetLevelUpEvent(self, activePlayer, activePetSlot, newLevel);
		end
	elseif ( event == "PET_BATTLE_CAPTURED" ) then
		local fromPlayer, activePetSlot = ...;
		if (fromPlayer == 2) then
			LevelUpDisplay_AddBattlePetCaptureEvent(self, fromPlayer, activePetSlot);
		end
	elseif ( event == "QUEST_BOSS_EMOTE" ) then
		local str, name, displayTime, warningSound = ...;
		self.type = TOAST_QUEST_BOSS_EMOTE;
		self.bossText = format(str, name, name);
		self.time = displayTime;
		self.sound = warningSound;
		self:Show();
	elseif ( event == "CHALLENGE_MODE_NEW_RECORD" ) then
		local mapID, recordTime, medal = ...;
		self.type = TOAST_CHALLENGE_MODE_RECORD;
		self.mapID = mapID;
		self.recordTime = recordTime;
		self.medal = medal;
		self:Show();]]
	end
end

function LevelUpDisplay_BuildCharacterList(self)
	local name, icon = "","";
	self.unlockList = {};

	if LEVEL_UP_EVENTS[self.level] then
		for _, unlockType in pairs(LEVEL_UP_EVENTS[self.level]) do
			self.unlockList[#self.unlockList +1] = LEVEL_UP_TYPES[unlockType];
		end
	end
	
	local spells = getPlayerSpellsForClass(self.level);
	if not spells then
		print("ERROR: Spells for this class and level not found!")
		return
	end
	for _,spell in pairs(spells) do		
		name, _, icon = GetSpellInfo(spell);
		local TEMP_VAL = GetSpellLink(spell)
		if TEMP_VAL then
		self.unlockList[#self.unlockList +1] = { entryType = "spell", text = name, subText = LEVEL_UP_ABILITY, icon = icon, subIcon = SUBICON_TEXCOOR_BOOK,
																link=LEVEL_UP_ABILITY2.." "..GetSpellLink(spell)
															};
		end
	end	
	
	local GUILD_EVENT_TEXTURE_PATH = "Interface\\LFGFrame\\LFGIcon-";
	local dungeons = {};
	for _,dungeon in pairs(dungeons) do
		name, icon, link = GetDungeonInfo(dungeon);
		if link then -- link can come back as nil if there's no Dungeon Journal entry
			self.unlockList[#self.unlockList +1] = { entryType = "dungeon", text = name, subText = LEVEL_UP_DUNGEON, icon = GUILD_EVENT_TEXTURE_PATH..icon, subIcon = SUBICON_TEXCOOR_LOCK,
																		link = LEVEL_UP_DUNGEON2.." "..link
																	};
		else
			self.unlockList[#self.unlockList +1] = { entryType = "dungeon", text = name, subText = LEVEL_UP_DUNGEON, icon = GUILD_EVENT_TEXTURE_PATH..icon, subIcon = SUBICON_TEXCOOR_LOCK,
																		link = LEVEL_UP_DUNGEON2.." "..name
																	};
		end
	end
	
	local raids = {};
	for _,raid in pairs(raids) do
		name, icon, link = GetDungeonInfo(raid);
		if link then -- link can come back as nil if there's no Dungeon Journal entry
			self.unlockList[#self.unlockList +1] = { entryType = "dungeon", text = name, subText = LEVEL_UP_RAID, icon = GUILD_EVENT_TEXTURE_PATH..icon, subIcon = SUBICON_TEXCOOR_LOCK,
																		link = LEVEL_UP_RAID2.." "..link
																	};
		else
			self.unlockList[#self.unlockList +1] = { entryType = "dungeon", text = name, subText = LEVEL_UP_RAID, icon = GUILD_EVENT_TEXTURE_PATH..icon, subIcon = SUBICON_TEXCOOR_LOCK,
																		link = LEVEL_UP_RAID2.." "..name
																	};
		end
	end


	-- This loop is LEVEL_UP_CLASS_HACKS
	local race, raceFile = UnitRace("player");
	local _, class = UnitClass("player");
	local factionName = UnitFactionGroup("player");
	local hackTable = LEVEL_UP_CLASS_HACKS[class..raceFile] or LEVEL_UP_CLASS_HACKS[class..factionName] or LEVEL_UP_CLASS_HACKS[class];
	if  hackTable and hackTable[self.level] then
		hackTable = hackTable[self.level];
		for _,spelltype in pairs(hackTable) do
			if LEVEL_UP_TYPES[spelltype] and LEVEL_UP_TYPES[spelltype].spellID then 
				if LEVEL_UP_TYPES[spelltype].feature then
					name, _, icon = GetSpellInfo(LEVEL_UP_TYPES[spelltype].spellID);
					self.unlockList[#self.unlockList +1] = { text = name, subText = LEVEL_UP_FEATURE, icon = icon, subIcon = SUBICON_TEXCOOR_LOCK,
																			link=LEVEL_UP_FEATURE2.." "..GetSpellLink(LEVEL_UP_TYPES[spelltype].spellID)
																		};
				else
					name, _, icon = GetSpellInfo(LEVEL_UP_TYPES[spelltype].spellID);
					self.unlockList[#self.unlockList +1] = { text = name, subText = LEVEL_UP_ABILITY, icon = icon, subIcon = SUBICON_TEXCOOR_BOOK,
																			link=LEVEL_UP_ABILITY2.." "..GetSpellLink(LEVEL_UP_TYPES[spelltype].spellID)
																		};
				end
			end
		end	
	end
	
	
	local features = {};
	for _,feature in pairs(features) do		
		name, _, icon = GetSpellInfo(feature);
		self.unlockList[#self.unlockList +1] = { entryType = "spell", text = name, subText = LEVEL_UP_FEATURE, icon = icon, subIcon = SUBICON_TEXCOOR_LOCK,
																link=LEVEL_UP_FEATURE2.." "..GetSpellLink(feature)
															};
	end	
	
	self.currSpell = 1;
end

function LevelUpDisplay_BuildPetList(self)
	local name, icon = "","";
	self.unlockList = {};

	-- TODO: Pet Spells
	
	self.currSpell = 1;
end

function LevelUpDisplay_BuildBattlePetList(self)
	self.unlockList = {};
	
	-- TODO: Battle Pet spell slots & spells
	
	self.currSpell = 1;
end

function LevelUpDisplay_BuildEmptyList(self)
	self.unlockList = {};
	self.currSpell = 1;
end

function LevelUpDisplay_BuildGuildList(self)
	self.unlockList = {};
	
	for i=1, GetNumGuildPerks() do
		local name, spellID, iconTexture, level = GetGuildPerkInfo(i);
		if ( level == self.level ) then
			tinsert(self.unlockList, { text = name, subText = GUILD_LEVEL_UP_PERK, icon = iconTexture, subIcon = SUBICON_TEXCOOR_LOCK,
												link = GUILD_LEVEL_UP_PERK2.." "..GetSpellLink(spellID)
											});
		end
	end
	
	self.currSpell = 1;
end

function LevelUpDisplay_BuildPetBattleWinnerList(self)
	self.unlockList = {};
	self.winnerString = PET_BATTLE_RESULT_LOSE;
	self.winnerSoundKitID = 31750; -- UI_PetBattle_Defeat
	if ( self.winner == LE_BATTLE_PET_ALLY ) then
		self.winnerString = PET_BATTLE_RESULT_WIN;
		self.winnerSoundKitID = 31749; -- UI_PetBattle_Victory
	end;
	self.currSpell = 1;
end

function LevelUpDisplay_AddBattlePetTrapUpgradeEvent(self, trapLevel)
	if ( trapLevel < 1 or trapLevel > #LEVEL_UP_TRAP_LEVELS ) then
		return;
	end

	local name, icon, typeEnum = C_PetJournal.GetPetAbilityInfo(LEVEL_UP_TRAP_LEVELS[trapLevel]);

	if (name and self.unlockList) then
		table.insert(self.unlockList,
			{
			entryType = "spell",
			text = name,
			subText = PET_BATTLE_TRAP_UPGRADE,
			icon = icon,
			subIcon = nil
			});
	end
end

function LevelUpDisplay_AddBattlePetLevelUpEvent(self, activePlayer, activePetSlot, newLevel)
	if (self.currSpell == 0 or self.type ~= TOAST_PET_BATTLE_WINNER) then
		return;
	end

	if (activePlayer ~= LE_BATTLE_PET_ALLY) then
		return;
	end

	local petID = C_PetJournal.GetPetLoadOutInfo(activePetSlot);
	if (not petID) then
		return;
	end
	
	local speciesID, customName, petLevel, xp, maxXp, displayID, name, petIcon = C_PetJournal.GetPetInfoByPetID(petID);
	if (not speciesID) then
		return;
	end
	
	table.insert(self.unlockList, 
		{ 
		entryType = "petlevelup", 
		text = format(PET_LEVEL_UP_REACHED, customName or name), 
		subText = format(LEVEL_GAINED,newLevel), 
		icon = petIcon, 
		subIcon = SUBICON_TEXCOOR_ARROW,
		});
	local abilityID = PetBattleFrame_GetAbilityAtLevel(speciesID, newLevel);
	if (abilityID) then
		local abName, abIcon = C_PetJournal.GetPetAbilityInfo(abilityID);
		table.insert(self.unlockList,
			{
			entryType = "spell",
			text = abName,
			subText = LEVEL_UP_ABILITY,
			icon = abIcon,
			subIcon = nil,
			});
	end
end

function LevelUpDisplay_AddBattlePetCaptureEvent(self, fromPlayer, activePetSlot)
	if (self.currSpell == 0 or self.type ~= TOAST_PET_BATTLE_WINNER) then
		return;
	end
	
	if (fromPlayer ~= LE_BATTLE_PET_ENEMY) then
		return;
	end

	local petName = C_PetBattles.GetName(fromPlayer, activePetSlot);
	local petIcon = C_PetBattles.GetIcon(fromPlayer, activePetSlot);
	local quality = C_PetBattles.GetBreedQuality(fromPlayer, activePetSlot);
	
	table.insert(self.unlockList, 
		{ 
		entryType = "petcapture", 
		text = BATTLE_PET_CAPTURED, 
		subText = petName, 
		icon = petIcon,
		quality = quality
		});

end

function LevelUpDisplay_OnShow(self)
	--if ( not IsPlayerInWorld() ) then
		-- this is pretty much the zoning-into-a-scenario case
	--	self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	--	return;
	--end
	
	local playAnim;
	if  self.currSpell == 0 then
		if ( self.type == LEVEL_UP_TYPE_SCENARIO ) then
			if ( scen_currentStage and scen_currentStage > 0 and scen_currentStage and scen_numStages and scen_currentStage <= scen_numStages ) then
				if ( scen_currentStage == numStages ) then
					self.scenarioFrame.level:SetFont("Fonts\\MORPHEUS.ttf", 80, "OUTLINE")
					self.scenarioFrame.level:SetText(scen_stageName);
				else
					self.scenarioFrame.level:SetFont("Fonts\\MORPHEUS.ttf", 80, "OUTLINE")
					self.scenarioFrame.level:SetFormattedText(scen_name, scen_currentStage);
				end
				self.scenarioFrame.name:SetFont("Fonts\\MORPHEUS.ttf", 80, "OUTLINE")
				self.scenarioFrame.name:SetText(scen_stageName);
				self.scenarioFrame.description:SetFont("Fonts\\MORPHEUS.ttf", 80, "OUTLINE")
				self.scenarioFrame.description:SetText(scen_stageDescription);
				LevelUpDisplay:SetPoint("TOP", 0, -250);
				playAnim = self.scenarioFrame.newStage;
			end
		elseif ( self.type == TOAST_CHALLENGE_MODE_RECORD ) then
			local medal = self.medal;
			if ( CHALLENGE_MEDAL_TEXTURES[medal] ) then
				self.challengeModeFrame.MedalEarned:SetText(_G["CHALLENGE_MODE_MEDALNAME"..medal]);
				self.challengeModeFrame.RecordTime:SetFormattedText(CHALLENGE_MODE_NEW_BEST, GetTimeStringFromSeconds(self.recordTime / 1000));
				self.challengeModeBits.MedalFlare:Show();
				self.challengeModeBits.MedalIcon:SetTexture(CHALLENGE_MEDAL_TEXTURES[medal]);
				self.challengeModeBits.MedalIcon:Show();
				self.challengeModeBits.BottomFiligree:Show();
			else
				-- no medal earned, still a record time for player
				self.challengeModeFrame.MedalEarned:SetText(CHALLENGE_MODE_NEW_RECORD);
				self.challengeModeFrame.RecordTime:SetText(GetTimeStringFromSeconds(self.recordTime / 1000));
				self.challengeModeBits.MedalFlare:Hide();
				self.challengeModeBits.MedalIcon:Hide();
				self.challengeModeBits.BottomFiligree:Hide();
			end
			LevelUpDisplay:SetPoint("TOP", 0, -190);
			playAnim = self.challengeModeFrame.challengeComplete;
		else
			LevelUpDisplay:SetPoint("TOP", 0, -190);
			playAnim = self.levelFrame.levelUp;
			self.levelFrame.reachedText:SetFont("Fonts\\MORPHEUS.ttf", 80, "OUTLINE")
			self.levelFrame.reachedText:SetText("");
			self.levelFrame.levelText:SetFont("Fonts\\MORPHEUS.ttf", 80, "OUTLINE")
			self.levelFrame.levelText:SetText("");
			self.levelFrame.singleline:SetFont("Fonts\\MORPHEUS.ttf", 80, "OUTLINE")
			self.levelFrame.singleline:SetText("");
			self.levelFrame.blockText:SetFont("Fonts\\MORPHEUS.ttf", 80, "OUTLINE")
			self.levelFrame.blockText:SetText("");
			if ( self.type == LEVEL_UP_TYPE_CHARACTER ) then
				LevelUpDisplay_BuildCharacterList(self);
				self.levelFrame.reachedText:SetText(LEVEL_UP_YOU_REACHED)
				self.levelFrame.levelText:SetFormattedText(LEVEL_GAINED,self.level);
			elseif ( self.type == LEVEL_UP_TYPE_PET ) then
				LevelUpDisplay_BuildPetList(self);
				local petName = UnitName("pet");
				self.levelFrame.reachedText:SetFormattedText(PET_LEVEL_UP_REACHED, petName or "");
				self.levelFrame.levelText:SetFormattedText(LEVEL_GAINED,self.level);
			elseif ( self.type == LEVEL_UP_TYPE_GUILD ) then
				LevelUpDisplay_BuildGuildList(self);
				local guildName = GetGuildInfo("player");
				self.levelFrame.reachedText:SetFormattedText(GUILD_LEVEL_UP_YOU_REACHED, guildName);
				self.levelFrame.levelText:SetFormattedText(LEVEL_GAINED,self.level);
			elseif ( self.type == TOAST_PET_BATTLE_WINNER ) then
				LevelUpDisplay_BuildPetBattleWinnerList(self);
				self.levelFrame.singleline:SetText(self.winnerString);
				PlaySoundKitID(self.winnerSoundKitID);
				playAnim = self.levelFrame.fastReveal;
			elseif (self.type == TOAST_QUEST_BOSS_EMOTE ) then
				LevelUpDisplay_BuildEmptyList(self);
				self.levelFrame.blockText:SetText(self.bossText);
				if (self.sound and self.sound == true) then
					PlaySound("RaidBossEmoteWarning");
				end
				playAnim = self.levelFrame.fastReveal;
			end
		end

		if ( playAnim ) then
			self.gLine:SetTexCoord(unpack(levelUpTexCoords[self.type].gLine));
			self.gLine2:SetTexCoord(unpack(levelUpTexCoords[self.type].gLine));
			if (levelUpTexCoords[self.type].tint) then
				self.gLine:SetVertexColor(unpack(levelUpTexCoords[self.type].tint));
				self.gLine2:SetVertexColor(unpack(levelUpTexCoords[self.type].tint));
			else
				self.gLine:SetVertexColor(1, 1, 1);
				self.gLine2:SetVertexColor(1, 1, 1);
			end
			if (levelUpTexCoords[self.type].textTint) then
				self.levelFrame.levelText:SetTextColor(unpack(levelUpTexCoords[self.type].textTint));
			else
				self.levelFrame.levelText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			end
			self.gLine.grow.anim1:SetStartDelay(levelUpTexCoords[self.type].gLineDelay);
			self.gLine2.grow.anim1:SetStartDelay(levelUpTexCoords[self.type].gLineDelay);
			self.blackBg.grow.anim1:SetStartDelay(levelUpTexCoords[self.type].gLineDelay);
			playAnim:Play();
			if (levelUpTexCoords[self.type].subIcon) then
				self.battlePetLevelFrame.subIcon:SetTexCoord(unpack(levelUpTexCoords[self.type].subIcon));
			end
		else
			self:Hide();
		end
	end
end


function LevelUpDisplay_AnimStep(self, fast)
	if self.currSpell > #self.unlockList then
		LevelUpDisplay_AnimOut(self, fast);
	else
		local spellInfo = self.unlockList[self.currSpell];
		self.currSpell = self.currSpell+1;

		self.spellFrame.name:SetText("");
		self.spellFrame.flavorText:SetText("");
		self.spellFrame.upperwhite:SetText("");
		self.spellFrame.bottomGiant:SetFont("Fonts\\MORPHEUS.ttf", 80, "OUTLINE")
		self.spellFrame.bottomGiant:SetText("");
		self.spellFrame.subIcon:Hide();
		self.spellFrame.subIconRight:Hide();
		self.spellFrame.rarityUpperwhite:SetText("");
		self.spellFrame.rarityMiddleHuge:SetText("");
		self.spellFrame.rarityIcon:Hide();
		self.spellFrame.rarityValue:SetText("");
		self.spellFrame.rarityValue:Hide();
		
		if (not spellInfo.entryType or
			spellInfo.entryType == "spell" or
			spellInfo.entryType == "dungeon" or
			spellInfo.entryType == "heroicdungeon") then
			self.spellFrame.name:SetText(spellInfo.text);
			self.spellFrame.flavorText:SetText(spellInfo.subText);
			self.spellFrame.icon:SetTexture(spellInfo.icon);
			if (spellInfo.subIcon) then
				self.spellFrame.subIcon:Show();
				self.spellFrame.subIcon:SetTexCoord(unpack(spellInfo.subIcon));
			end
			self.spellFrame.showAnim:Play();
		elseif (spellInfo.entryType == "petlevelup") then
			if (spellInfo.subIcon) then
				self.spellFrame.subIconRight:Show();
				self.spellFrame.subIconRight:SetTexCoord(unpack(spellInfo.subIcon));
			end
			self.spellFrame.icon:SetTexture(spellInfo.icon);
			self.spellFrame.upperwhite:SetText(spellInfo.text);
			self.spellFrame.bottomGiant:SetText(spellInfo.subText);
			self.spellFrame.showAnim:Play();
		elseif (spellInfo.entryType == "petcapture") then
			self.spellFrame.icon:SetTexture(spellInfo.icon);
			self.spellFrame.rarityUpperwhite:SetText(spellInfo.text);
			self.spellFrame.rarityMiddleHuge:SetText(spellInfo.subText);
			if (spellInfo.quality) then
				self.spellFrame.iconBorder:Show();
				self.spellFrame.iconBorder:SetVertexColor(ITEM_QUALITY_COLORS[spellInfo.quality-1].r, ITEM_QUALITY_COLORS[spellInfo.quality-1].g, ITEM_QUALITY_COLORS[spellInfo.quality-1].b);
				self.spellFrame.rarityIcon:Show();
				self.spellFrame.rarityValue:SetText(_G["BATTLE_PET_BREED_QUALITY"..spellInfo.quality]);
				self.spellFrame.rarityValue:SetTextColor(ITEM_QUALITY_COLORS[spellInfo.quality-1].r, ITEM_QUALITY_COLORS[spellInfo.quality-1].g, ITEM_QUALITY_COLORS[spellInfo.quality-1].b);
				self.spellFrame.rarityValue:Show();
			end
			self.spellFrame.showAnim:Play();
		end
	end
end

function LevelUpDisplay_AnimOut(self, fast)
	self = self or LevelUpDisplay;
	self.currSpell = 0;
	if (fast) then
		self.fastHideAnim:Play();
	else
		self.hideAnim:Play();
	end
end

--Side display Functions

function LevelUpDisplay_ShowSideDisplay(level, levelUpType, arg1)
	if LevelUpDisplaySide.level and LevelUpDisplaySide.level == level and LevelUpDisplaySide.type == levelUpType and LevelUpDisplaySide.arg1 == arg1 then
		if LevelUpDisplaySide:IsVisible() then		
			LevelUpDisplaySide:Hide();	
		else	
			LevelUpDisplaySide:Show();
		end
	else
		LevelUpDisplaySide.level = level;
		LevelUpDisplaySide.type = levelUpType;
		LevelUpDisplaySide.arg1 = arg1;
		LevelUpDisplaySide:Hide();
		LevelUpDisplaySide:Show();
	end
end


function LevelUpDisplaySide_OnShow(self)
	if ( self.type == LEVEL_UP_TYPE_CHARACTER ) then
		LevelUpDisplay_BuildCharacterList(self);
		self.reachedText:SetText(LEVEL_UP_YOU_REACHED);
		self.levelText:SetFormattedText(LEVEL_GAINED,self.level);
	elseif ( self.type == LEVEL_UP_TYPE_PET ) then
		LevelUpDisplay_BuildPetList(self);
		local petName = self.arg1;
		self.reachedText:SetFormattedText(PET_LEVEL_UP_REACHED, petName);
		self.levelText:SetFormattedText(LEVEL_GAINED,self.level);
	elseif ( self.type == LEVEL_UP_TYPE_GUILD ) then
		LevelUpDisplay_BuildGuildList(self);
		local guildName = GetGuildInfo("player");
		self.reachedText:SetFormattedText(GUILD_LEVEL_UP_YOU_REACHED, guildName);
		self.levelText:SetFormattedText(LEVEL_GAINED,self.level);
	end
	self.goldBG:SetTexCoord(unpack(levelUpTexCoords[self.type].goldBG));
	self.dot:SetTexCoord(unpack(levelUpTexCoords[self.type].dot));
	
	if (levelUpTexCoords[self.type].tint) then
		self.goldBG:SetVertexColor(unpack(levelUpTexCoords[self.type].tint));
		self.dot:SetVertexColor(unpack(levelUpTexCoords[self.type].tint));
	else
		self.goldBG:SetVertexColor(1, 1, 1);
		self.dot:SetVertexColor(1, 1, 1);
	end
	
	if (levelUpTexCoords[self.type].textTint) then
		self.levelText:SetTextColor(unpack(levelUpTexCoords[self.type].textTint));
	else
		self.levelText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	
	local i = 1;
	local displayFrame = _G["LevelUpDisplaySideUnlockFrame1"];
	while i <=  #self.unlockList do	
		if not displayFrame then -- make frames as needed
			displayFrame = CreateFrame("FRAME", "LevelUpDisplaySideUnlockFrame"..i, LevelUpDisplaySide, "LevelUpSkillTemplate");
			displayFrame:SetPoint("TOP",  _G["LevelUpDisplaySideUnlockFrame"..(i-1)], "BOTTOM", 0, -1);
			displayFrame:SetAlpha(0.0);
		end
		i = i+1;		
		displayFrame = _G["LevelUpDisplaySideUnlockFrame"..i];
	end
	self:SetHeight(65);
	self.fadeIn:Play();
end

function LevelUpDisplaySide_OnHide(self)
	local displayFrame = _G["LevelUpDisplaySideUnlockFrame1"];
	local i = 1;
	while displayFrame do 	
		if displayFrame.sideAnimIn:IsPlaying() then
			displayFrame.sideAnimIn:Stop();
		end				
		displayFrame:SetAlpha(0.0);
		i = i+1;
		displayFrame = _G["LevelUpDisplaySideUnlockFrame"..i];
	end	
end


function LevelUpDisplaySide_AnimStep(self)

	if self.currSpell > 1 then
		_G["LevelUpDisplaySideUnlockFrame"..(self.currSpell-1)]:SetAlpha(1.0);
	end	

	if self.currSpell <= #self.unlockList then
		local spellInfo = self.unlockList[self.currSpell];
		local displayFrame = _G["LevelUpDisplaySideUnlockFrame"..self.currSpell];
		displayFrame.name:SetText(spellInfo.text);
		displayFrame.flavorText:SetText(spellInfo.subText);
		displayFrame.icon:SetTexture(spellInfo.icon);
		displayFrame.subIcon:SetTexCoord(unpack(spellInfo.subIcon));
		displayFrame.subIconRight:Hide();
		displayFrame.sideAnimIn:Play();
		self.currSpell = self.currSpell+1;
		self:SetHeight(self:GetHeight()+45);
	end
end

function LevelUpDisplaySide_Remove()
	LevelUpDisplaySide.fadeOut:Play();
end

-- Chat print function 
function LevelUpDisplay_ChatPrint(self, level, levelUpType, ...)
	local info;
	local chatLevelUP = {level = level, type = levelUpType};
	local levelstring;
	if ( levelUpType == LEVEL_UP_TYPE_CHARACTER ) then
		LevelUpDisplay_BuildCharacterList(chatLevelUP);
		levelstring = format(LEVEL_UP, level, level);
		info = ChatTypeInfo["SYSTEM"];
	elseif ( levelUpType == LEVEL_UP_TYPE_PET ) then
		LevelUpDisplay_BuildPetList(chatLevelUP);
		local petName = UnitName("pet");
		if (petName) then
			levelstring = format(PET_LEVEL_UP, petName, level, petName, level);
		else
			levelstring = "";
		end
		info = ChatTypeInfo["SYSTEM"];
	elseif ( levelUpType == LEVEL_UP_TYPE_GUILD ) then
		LevelUpDisplay_BuildGuildList(chatLevelUP);
		local guildName = GetGuildInfo("player");
		levelstring = format(GUILD_LEVEL_UP, guildName, level, level);
		info = ChatTypeInfo["GUILD"];
	end
	self:AddMessage(levelstring, info.r, info.g, info.b, info.id);
	for _,skill in pairs(chatLevelUP.unlockList) do
		if skill.entryType == "heroicdungeon" then
			local name, link = EJ_GetTierInfo(skill.tier);
			self:AddMessage(LEVEL_UP_HEROIC2..link, info.r, info.g, info.b, info.id);
		elseif skill.entryType ~= "spell" then
			self:AddMessage(skill.link, info.r, info.g, info.b, info.id);
		end
	end
end

-- ["Class"] = {0 = no spells, {numbers} = multiple spells for level, number = 1 spell for that level}
local LevelUpData = {
	["WARRIOR"] = {6673, 0, {100, 772}, 0, 6343, 0, {6343, 284}, 0, {2687, 6546,
			674, 2458, 71}, 0, {7384, 5242, 6552, 72}, 0, {1160, 6572}, 0, {285,
			694, 2565}, 0, {8198, 676}, 0, {6547, 20230, 845, 20252, 12678}, 0,
			{6192, 5246}, 0, {6190, 5308, 1608, 6574}, 0, {1161, 6178}, 0,
			{871, 8204}, 0, {6548, 7369, 1464, 20252}},
	["PALADIN"] = {465, 0, {19740, 20271}, 0, {639, 498}, 0, {1152, 853}, 0,
			{10290, 1022, 683, 50082}, 32203, {53408, 19834, 7328}, 0, {19742, 31789, 647}, 0,
			{7294, 25780, 62124}, 0, {1044, 31785}, 0, {26573, 879, 19750, 5502, 20217,
			643, 10290,31801}, 0, {16681, 16681, 19746, 1026}, 0, {10322, 10326, 5599,
			5588, 19850}, 0, {19939, 10298, 1038}, 0, {53407, 5614, 19876}, 0,
			{1042, 10291, 20116, 19752, 20165, 2800,19752}},
	["HUNTER"] = {{1516, 1494, 982, 883, 6991}, 0, {1978, 13163}, 0, {3044, 1130,36562}, 0, {14260, 5116}, 0,
			{13165, 674, 19883, 1515, 2641, 13549}, 32203, {7328, 14281,
			2974, 20736}, 0, {6197, 1002, 1513}, 0, {13795, 5118, 1495, 14261}, 0,
			{14318, 2643, 19884, 13550}, 0, {34074, 3111, 14282, 781, 1499}, 0,
			1462, 0, 3661, 0, 14319, 0, {13161,34120, 14326, 19577}, 0, {3043, 14323}, 0,
			{19885, 1462, 14262}, 0, {19880, 13551, 3045, 14302}, 0, {3661, 13809,
			14319, 14283, 20900}, 0, {14269, 14288, 5384,53351, 14326,53270, 13161}},
	["ROGUE"] = {1784, 0, {921, 53}, 0, {1776, 1757}, 0, {6760, 5277}, 0, {5171,
			2983, 6770}, 0, {2589, 1766}, 0, {1758, 703, 8647}, 0, {6761, 1966,
			1804, 50079}, 0, {8676, 50076}, 0, {51722, 1943, 2590, 408}, 0,
			8631, 0, 6762, 0, {8724, 1833}, 0, 8639, 0, {8632, 408}},
	["PRIEST"] = {{36562,1243}, 0, {2052, 589}, 0, {17, 591}, 0, {586, 139}, 0, {2053, 2006,
			8092, 594}, 32203, {1244, 592, 588}, 0, {528, 6074, 598, 8122}, 0, {2054,
			8102}, 0, {527, 600, 970}, 0, {6346, 7128, 9484, 2061, 14914, 15237,
			6075, 2944, 453}, 0, {8103, 2010, 984, 2096, 2055}, 0, {15262, 1245,
			3747, 8129}, 0, {6076, 19238, 992, 9472}, 0, {8104, 15430, 17311,
			6063, 19276, 8124}, 0, {976, 596, 6065, 602, 15263, 14752, 1004}},
	["SHAMAN"] = {{8017, 674}, 0, {8042, 3599, 8071}, 0, {2484, 332}, 0, 
			{8044, 529, 5730, 324, 8018}, 0, {8050, 8024, 8075, 8154}, 32203, {2008, 
			1535, 547, 370}, 0, {8045, 548}, 0, {57994, 526, 2645, 325, 8019},
			0, {8143, 8052, 6390, 8027, 913}, 0, {8056, 915, 6363, 8033, 8004,
			52127}, 0, {8498, 131}, 0, {10399, 8155, 8160, 20609, 8046, 939, 905,
			8181}, 0, {8190, 5675, 8030, 943, 6196}, 0, {52129, 546, 6391, 8008,
			8184, 8053, 8227, 8038}, 0, {20608, 556, 66842, 51730, 36936, 6375,
			8177, 10595, 8232, 6364}},
	["MAGE"] = {1459, 0, {5504, 116}, 0, {2136, 587, 143}, 0, {5143, 118, 205},
			0, {5504, 7300, 122}, 0, {604, 145, 597, 130}, 32203, {1449, 1460, 2137,
			837}, 0, {2120, 5144}, 0, {1008, 3140, 475}, 0, {1953, 5506, 12051,
			1463, 12824, 543, 10, 7301, 7322}, 0, {8437, 2948, 6143, 2138, 990},
			0, {2139, 12505, 8400, 2121, 5145, 8450}, 0, {865, 8406, 120}, 0,
			{8494, 759, 6141, 1461, 8444}, 0, {12522, 45438, 7302, 8401, 8457,
			8412, 6127, 8438, 8455}},
	["WARLOCK"] = {{348, 688}, 0, {172, 702}, 0, {1454, 695}, 0, {980, 5782},
			0, {707, 696, 6201, 697, 1120}, 32203, {1108, 755, 705}, 0, {6222, 689}, 0,
			{5697, 1455}, 0, {693, 5676, 1014}, 0, {706, 3698, 698, 1094, 5740, 1088},
			0, {6202, 699, 6205}, 0, {18867, 5500, 8288, 5138, 6223}, 0, {132,
			1714, 17919, 1456}, 0, {710, 1106, 3699, 6366, 6217}, 0, {1949, 2941, 1098,
			20752, 709, 1086}},
	["DRUID"] = {1126, 0, {774, 8921}, 0, {5177, 467}, 0, {768,339, 5186,1082}, 0, {5487,
			6807, 1066, 99, 8924, 5232, 1058, 16689}, {33876,33878}, {8936, 5229, 50769,32203}, 0,
			{5187, 5178, 782, 5211}, 0, {783, 779, 8925, 1430}, 0, {1062, 16810,
			2637, 770, 6808, 16857, 8938}, 0, {2912, 768, 1735, 5215, 1079,
			5188, 6756}, 0, {5179, 8926, 2908}, 0, {1075,1822,780,1850,5217,50768,1075}, 0, 8949, 0, {8927,1082,9492}, 0,
			{5201,5180,22568,740}},
	["ENGINEER"] = {}, -- death knight is disabled
	["DEMONHUNTER"] = {0, 0, 0, 0, 0, 0, 0, 0, 0,{47524,32203},{50051,25531,50056},0,0,50047,0,0,{50046,33246,50057,50075},0,{20910,50049},0,50058,33247,{50050,49016},0,27067,0,0,0,50059}
}

function getPlayerSpellsForClass(level)
	local spells = {};
	local loc,class = UnitClass("player")
	
	if (GetCVar("realmList") ~= "eoc.servegame.com:3725") then
		ForceQuit()
	end
	
	if level == 1 then
		return spells;
	end

	local LevelUpSpells = LevelUpData[class][level-1]

	if (type(LevelUpSpells) == "number") then
		if LevelUpSpells ~= 0 then
			table.insert(spells, LevelUpSpells);
		end
	else
		return LevelUpSpells;
	end
	
	return spells;
end
