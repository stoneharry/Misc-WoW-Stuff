CHARACTER_SELECT_ROTATION_START_X = nil;
CHARACTER_SELECT_INITIAL_FACING = nil;

CHARACTER_ROTATION_CONSTANT = 0.6;

MAX_CHARACTERS_DISPLAYED = 10;
MAX_CHARACTERS_PER_REALM = 10;


function CharacterSelect_OnLoad(self)
	self:SetSequence(0);
	self:SetCamera(0);

	self.createIndex = 0;
	self.selectedIndex = 0;
	self.selectLast = 0;
	self.currentModel = nil;
	self:RegisterEvent("ADDON_LIST_UPDATE");
	self:RegisterEvent("CHARACTER_LIST_UPDATE");
	self:RegisterEvent("UPDATE_SELECTED_CHARACTER");
	self:RegisterEvent("SELECT_LAST_CHARACTER");
	self:RegisterEvent("SELECT_FIRST_CHARACTER");
	self:RegisterEvent("SUGGEST_REALM");
	self:RegisterEvent("FORCE_RENAME_CHARACTER");

	-- CharacterSelect:SetModel("Interface\\Glues\\Models\\UI_MainMenu\\UI_MainMenu.m2");

	-- local fogInfo = CharModelFogInfo["ORC"];
	-- CharacterSelect:SetFogColor(fogInfo.r, fogInfo.g, fogInfo.b);
	-- CharacterSelect:SetFogNear(0);
	-- CharacterSelect:SetFogFar(fogInfo.far);

	SetCharSelectModelFrame("CharacterSelect");

	-- Color edit box backdrops
	local backdropColor = DEFAULT_TOOLTIP_COLOR;
	CharacterSelectCharacterFrame:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	CharacterSelectCharacterFrame:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6], 0.85);
	
end

function CharacterSelect_OnShow()
	for k,v in pairs(M) do
		v:ClearModel();
	end
	
	-- request account data times from the server (so we know if we should refresh keybindings, etc...)
	ReadyForAccountDataTimes()
	
	local CurrentModel = CharacterSelect.currentModel;

	if ( CurrentModel ) then
		PlayGlueAmbience(GlueAmbienceTracks[strupper(CurrentModel)], 4.0);
	end

	UpdateAddonButton();

	local serverName, isPVP, isRP = GetServerName();
	local connected = IsConnectedToServer();
	local serverType = "";
	if ( serverName ) then
		if( not connected ) then
			serverName = serverName.."\n("..SERVER_DOWN..")";
		end
		if ( isPVP ) then
			if ( isRP ) then
				serverType = RPPVP_PARENTHESES;
			else
				serverType = PVP_PARENTHESES;
			end
		elseif ( isRP ) then
			serverType = RP_PARENTHESES;
		end
		CharSelectRealmName:SetText(serverName.." "..serverType);
		CharSelectRealmName:Show();
	else
		CharSelectRealmName:Hide();
	end

	if ( connected ) then
		GetCharacterListUpdate();
	else
		UpdateCharacterList();
	end

	GameRoomBillingFrameText:SetText("Welcome to the Edge of Chaos Expansion.\n\rPlease visit the forums for more information and to discuss with the rest of the community matters that may interest you.\n\rhttp://forum.dispersion-wow.com/");
	GameRoomBillingFrame:SetHeight(GameRoomBillingFrameText:GetHeight() + 26);
	GameRoomBillingFrame:Show();
	
	CharacterSelectNoCharacterText:SetText("It looks like you don't have any characters.\n\rYou can't enter our world without a character, if you want to create one you have to click on the\n'Create New Character' button.")
	CharacterSelectNoCharacter:SetHeight(CharacterSelectNoCharacterText:GetHeight() + 26);
	
	CharacterSelectRealmSplitButton:ClearAllPoints();
	CharacterSelectRealmSplitButton:SetPoint("TOP", GameRoomBillingFrame, "BOTTOM", 0, -10);

	if( IsTrialAccount() ) then
		CharacterSelectUpgradeAccountButton:Show();
	else
		CharacterSelectUpgradeAccountButton:Hide();
	end

	-- fadein the character select ui
	GlueFrameFadeIn(CharacterSelect, VX_FADE_LOAD); 

	RealmSplitCurrentChoice:Hide();
	RequestRealmSplitInfo();

	--Clear out the addons selected item
	GlueDropDownMenu_SetSelectedValue(AddonCharacterDropDown, ALL);
end

function CharacterSelect_OnHide()
	CharacterDeleteDialog:Hide();
	CharacterRenameDialog:Hide();
	if ( DeclensionFrame ) then
		DeclensionFrame:Hide();
	end
	SERVER_SPLIT_STATE_PENDING = -1;
end

function CharacterSelect_OnUpdate(elapsed)
	if ( SERVER_SPLIT_STATE_PENDING > 0 ) then
		CharacterSelectRealmSplitButton:Show();

		if ( SERVER_SPLIT_CLIENT_STATE > 0 ) then
			RealmSplit_SetChoiceText();
			RealmSplitPending:SetPoint("TOP", RealmSplitCurrentChoice, "BOTTOM", 0, -10);
		else
			RealmSplitPending:SetPoint("TOP", CharacterSelectRealmSplitButton, "BOTTOM", 0, 0);
			RealmSplitCurrentChoice:Hide();
		end

		if ( SERVER_SPLIT_STATE_PENDING > 1 ) then
			CharacterSelectRealmSplitButton:Disable();
			CharacterSelectRealmSplitButtonGlow:Hide();
			RealmSplitPending:SetText( SERVER_SPLIT_PENDING );
		else
			CharacterSelectRealmSplitButton:Enable();
			CharacterSelectRealmSplitButtonGlow:Show();
			local datetext = SERVER_SPLIT_CHOOSE_BY.."\n"..SERVER_SPLIT_DATE;
			RealmSplitPending:SetText( datetext );
		end

		if ( SERVER_SPLIT_SHOW_DIALOG and not GlueDialog:IsShown() ) then
			SERVER_SPLIT_SHOW_DIALOG = false;
			local dialogString = format(SERVER_SPLIT,SERVER_SPLIT_DATE);
			if ( SERVER_SPLIT_CLIENT_STATE > 0 ) then
				local serverChoice = RealmSplit_GetFormatedChoice(SERVER_SPLIT_REALM_CHOICE);
				local stringWithDate = format(SERVER_SPLIT,SERVER_SPLIT_DATE);
				dialogString = stringWithDate.."\n\n"..serverChoice;
				GlueDialog_Show("SERVER_SPLIT_WITH_CHOICE", dialogString);
			else
				GlueDialog_Show("SERVER_SPLIT", dialogString);
			end
		end
	else
		CharacterSelectRealmSplitButton:Hide();
	end

	-- Account Msg stuff
	if ( (ACCOUNT_MSG_NUM_AVAILABLE > 0) and not GlueDialog:IsShown() ) then
		if ( ACCOUNT_MSG_HEADERS_LOADED ) then
			if ( ACCOUNT_MSG_BODY_LOADED ) then
				local dialogString = AccountMsg_GetHeaderSubject( ACCOUNT_MSG_CURRENT_INDEX ).."\n\n"..AccountMsg_GetBody();
				GlueDialog_Show("ACCOUNT_MSG", dialogString);
			end
		end
	end
end

function CharacterSelect_OnKeyDown(self,key)
	if ( key == "ESCAPE" ) then
		CharacterSelect_Exit();
	elseif ( key == "ENTER" ) then
		CharacterSelect_EnterWorld();
	elseif ( key == "PRINTSCREEN" ) then
		Screenshot();
	elseif ( key == "UP" or key == "LEFT" ) then
		local numChars = GetNumCharacters();
		if ( numChars > 1 ) then
			if ( self.selectedIndex > 1 ) then
				CharacterSelect_SelectCharacter(self.selectedIndex - 1);
			else
				CharacterSelect_SelectCharacter(numChars);
			end
		end
	elseif ( arg1 == "DOWN" or arg1 == "RIGHT" ) then
		local numChars = GetNumCharacters();
		if ( numChars > 1 ) then
			if ( self.selectedIndex < GetNumCharacters() ) then
				CharacterSelect_SelectCharacter(self.selectedIndex + 1);
			else
				CharacterSelect_SelectCharacter(1);
			end
		end
	end
end

function CharacterSelect_OnEvent(self, event, ...)
	if ( event == "ADDON_LIST_UPDATE" ) then
		UpdateAddonButton();
	elseif ( event == "CHARACTER_LIST_UPDATE" ) then
		UpdateCharacterList();
		CharSelectCharacterName:SetText(GetCharacterInfo(self.selectedIndex));
	elseif ( event == "UPDATE_SELECTED_CHARACTER" ) then
		local index = ...;
		if ( index == 0 ) then
			CharSelectCharacterName:SetText("");
		else
			CharSelectCharacterName:SetText(GetCharacterInfo(index));
			self.selectedIndex = index;
		end
		UpdateCharacterSelection(self);
	elseif ( event == "SELECT_LAST_CHARACTER" ) then
		self.selectLast = 1;
	elseif ( event == "SELECT_FIRST_CHARACTER" ) then
		CharacterSelect_SelectCharacter(1, 1);
	elseif ( event == "SUGGEST_REALM" ) then
		local category, id = ...;
		local name = GetRealmInfo(category, id);
		if ( name ) then
			SetGlueScreen("charselect");
			ChangeRealm(category, id);
		else
			if ( RealmList:IsShown() ) then
				RealmListUpdate();
			else
				RealmList:Show();
			end
		end
	elseif ( event == "FORCE_RENAME_CHARACTER" ) then
		local message = ...;
		CharacterRenameDialog:Show();
		CharacterRenameText1:SetText(_G[message]);
	end
end

function CharacterSelect_UpdateModel(self)
	UpdateSelectionCustomizationScene();
	
	self:AdvanceTime();
end

function UpdateCharacterSelection(self)
	for i=1, MAX_CHARACTERS_DISPLAYED, 1 do
	--	_G["CharSelectCharacterButton"..i]:UnlockHighlight();
		_G[_G["CharSelectCharacterButton"..i]:GetName().."OnSelect"]:Hide();
	end

	local index = self.selectedIndex;
	if ( (index > 0) and (index <= MAX_CHARACTERS_DISPLAYED) )then
	--	_G["CharSelectCharacterButton"..index]:LockHighlight();
		_G[_G["CharSelectCharacterButton"..index]:GetName().."OnSelect"]:Show();
	end
end

function UpdateCharacterList()
	local numChars = GetNumCharacters();
	local index = 1;
	local coords;

	_G["CharacterSelectCharacterFrame"]:SetHeight( 647 - ( 9 - numChars ) * 57 );
	if numChars == 10 then
		_G["CharacterSelectCharacterFrame"]:SetHeight(647);
	end

	for i=1, numChars, 1 do
		local name, race, class, level, zone, sex, ghost, PCC, PRC, PFC = GetCharacterInfo(i);
		if name == "Debug" then
			DisconnectFromServer();
		else
			local button = _G["CharSelectCharacterButton"..index];
			if ( not name ) then
				button:SetText("ERROR - Tell Jeremy");
			else
				if ( not zone ) then
					zone = "The Unknown";
				end
				if (zone == "City") then
					zone = "The Unknown";
				end
				_G["CharSelectCharacterButton"..index.."ButtonTextName"]:SetText(name);
				if( ghost ) then
					_G["CharSelectCharacterButton"..index.."ButtonTextInfo"]:SetFormattedText(CHARACTER_SELECT_INFO_GHOST, level, class);
				else
					_G["CharSelectCharacterButton"..index.."ButtonTextInfo"]:SetFormattedText(CHARACTER_SELECT_INFO, level, class);
				end
				_G["CharSelectCharacterButton"..index.."ButtonTextLocation"]:SetText(zone);
			end
			button:Show();

			-- setup paid service buttons
			_G["CharSelectCharacterCustomize"..index]:Hide();
			_G["CharSelectRaceChange"..index]:Hide();
			_G["CharSelectFactionChange"..index]:Hide();
			if ( PFC ) then
				_G["CharSelectFactionChange"..index]:Show();
			elseif ( PRC ) then
				_G["CharSelectRaceChange"..index]:Show();
			elseif ( PCC ) then
				_G["CharSelectCharacterCustomize"..index]:Show();
			end

			index = index + 1;
			if ( index > MAX_CHARACTERS_DISPLAYED ) then
				break;
			end
		end
	end

	if ( numChars == 0 ) then
		CharacterSelectDeleteButton:Disable();
		CharSelectEnterWorldButton:Disable();
		CharacterSelectNoCharacter:Show();
		
		CharacterSelectDeleteButton:Hide();
		CharSelectEnterWorldButton:Hide();
		CharacterSelectRotateLeft:Hide();
		CharacterSelectRotateRight:Hide();
	else
		CharacterSelectDeleteButton:Enable();
		CharSelectEnterWorldButton:Enable();
		CharacterSelectNoCharacter:Hide();
		
		CharacterSelectDeleteButton:Show();
		CharSelectEnterWorldButton:Show();
		CharacterSelectRotateLeft:Show();
		CharacterSelectRotateRight:Show();
	end

	CharacterSelect.createIndex = 0;
	CharSelectCreateCharacterButton:Hide();	
	
	local connected = IsConnectedToServer();
	for i=index, MAX_CHARACTERS_DISPLAYED, 1 do
		local button = _G["CharSelectCharacterButton"..index];
		if ( (CharacterSelect.createIndex == 0) and (numChars < MAX_CHARACTERS_PER_REALM) ) then
			CharacterSelect.createIndex = index;
			if ( connected ) then
				--If can create characters position and show the create button
				CharSelectCreateCharacterButton:SetID(index);
				--CharSelectCreateCharacterButton:SetPoint("TOP", button, "TOP", 0, -5);
				CharSelectCreateCharacterButton:Show();	
			end
		end
		_G["CharSelectCharacterCustomize"..index]:Hide();
		_G["CharSelectFactionChange"..index]:Hide();
		_G["CharSelectRaceChange"..index]:Hide();
		button:Hide();
		index = index + 1;
	end

	if ( numChars == 0 ) then
		CharacterSelect.selectedIndex = 0;
		CharacterSelect_SelectCharacter(CharacterSelect.selectedIndex, 1);
		return;
	end

	if ( CharacterSelect.selectLast == 1 ) then
		CharacterSelect.selectLast = 0;
		CharacterSelect_SelectCharacter(numChars, 1);
		return;
	end

	if ( (CharacterSelect.selectedIndex == 0) or (CharacterSelect.selectedIndex > numChars) ) then
		CharacterSelect.selectedIndex = 1;
	end
	CharacterSelect_SelectCharacter(CharacterSelect.selectedIndex, 1);
end

function CharacterSelectButton_OnClick(self)
	local id = self:GetID();
	if ( id ~= CharacterSelect.selectedIndex ) then
		CharacterSelect_SelectCharacter(id);
	end
end

function CharacterSelectButton_OnDoubleClick(self)
	local id = self:GetID();
	if ( id ~= CharacterSelect.selectedIndex ) then
		CharacterSelect_SelectCharacter(id);
	end
	CharacterSelect_EnterWorld();
end

function CharacterSelect_TabResize(self)
	local buttonMiddle = _G[self:GetName().."Middle"];
	local buttonMiddleDisabled = _G[self:GetName().."MiddleDisabled"];
	local width = self:GetTextWidth() - 8;
	local leftWidth = _G[self:GetName().."Left"]:GetWidth();
	buttonMiddle:SetWidth(width);
	buttonMiddleDisabled:SetWidth(width);
	self:SetWidth(width + (2 * leftWidth));
end

function CharacterSelect_SelectCharacter(id, noCreate)
	if ( id == CharacterSelect.createIndex ) then
		if ( not noCreate ) then
			PlaySound("gsCharacterSelectionCreateNew");
			SetGlueScreen("charcreate");
		end
	else
		CharacterSelect.currentModel = GetSelectBackgroundModel(id);
		SetBackgroundModel(CharacterSelect,CharacterSelect.currentModel);

		SelectCharacter(id);
	end
end

function CharacterDeleteDialog_OnShow()
	local name, race, class, level = GetCharacterInfo(CharacterSelect.selectedIndex);
	CharacterDeleteText1:SetFormattedText(CONFIRM_CHAR_DELETE, name, level, class);
	CharacterDeleteBackground:SetHeight(16 + CharacterDeleteText1:GetHeight() + CharacterDeleteText2:GetHeight() + 23 + CharacterDeleteEditBox:GetHeight() + 8 + CharacterDeleteButton1:GetHeight() + 16);
	CharacterDeleteButton1:Disable();
end

function CharacterSelect_EnterWorld()
	PlaySound("gsCharacterSelectionEnterWorld");
	StopGlueAmbience();
	EnterWorld();
end

function CharacterSelect_Exit()
	for k,v in pairs(M) do
		v:ClearModel();
	end
	
	PlaySound("gsCharacterSelectionExit");
	DisconnectFromServer();
	SetGlueScreen("login");
end

function CharacterSelect_AccountOptions()
	PlaySound("gsCharacterSelectionAcctOptions");
end

function CharacterSelect_TechSupport()
	PlaySound("gsCharacterSelectionAcctOptions");
	LaunchURL("https://www.dispersion-wow.com/");
end

function CharacterSelect_Delete()
	PlaySound("gsCharacterSelectionDelCharacter");
	if ( CharacterSelect.selectedIndex > 0 ) then
		CharacterDeleteDialog:Show();
	end
end

function CharacterSelect_ChangeRealm()
	PlaySound("gsCharacterSelectionDelCharacter");
	RequestRealmList(1);
end

function CharacterSelectFrame_OnMouseDown(button)
	if ( button == "LeftButton" ) then
		CHARACTER_SELECT_ROTATION_START_X = GetCursorPosition();
		CHARACTER_SELECT_INITIAL_FACING = GetCharacterSelectFacing();
	end
end

function CharacterSelectFrame_OnMouseUp(button)
	if ( button == "LeftButton" ) then
		CHARACTER_SELECT_ROTATION_START_X = nil
	end
end

function CharacterSelectFrame_OnUpdate()
	if ( CHARACTER_SELECT_ROTATION_START_X ) then
		local x = GetCursorPosition();
		local diff = (x - CHARACTER_SELECT_ROTATION_START_X) * CHARACTER_ROTATION_CONSTANT;
		CHARACTER_SELECT_ROTATION_START_X = GetCursorPosition();
		SetCharacterSelectFacing(GetCharacterSelectFacing() + diff);
	end
end

function CharacterSelectRotateRight_OnUpdate(self)
	if ( self:GetButtonState() == "PUSHED" ) then
		SetCharacterSelectFacing(GetCharacterSelectFacing() + CHARACTER_FACING_INCREMENT);
	end
end

function CharacterSelectRotateLeft_OnUpdate(self)
	if ( self:GetButtonState() == "PUSHED" ) then
		SetCharacterSelectFacing(GetCharacterSelectFacing() - CHARACTER_FACING_INCREMENT);
	end
end

function CharacterSelect_ManageAccount()
	PlaySound("gsCharacterSelectionAcctOptions");
	LaunchURL(AUTH_NO_TIME_URL);
end

function RealmSplit_GetFormatedChoice(formatText)
	if ( SERVER_SPLIT_CLIENT_STATE == 1 ) then
		realmChoice = SERVER_SPLIT_SERVER_ONE;
	else
		realmChoice = SERVER_SPLIT_SERVER_TWO;
	end
	return format(formatText, realmChoice);
end

function RealmSplit_SetChoiceText()
	RealmSplitCurrentChoice:SetText( RealmSplit_GetFormatedChoice(SERVER_SPLIT_CURRENT_CHOICE) );
	RealmSplitCurrentChoice:Show();
end

function CharacterSelect_PaidServiceOnClick(self, button, down, service)
	PAID_SERVICE_CHARACTER_ID = self:GetID();
	PAID_SERVICE_TYPE = service;
	PlaySound("gsCharacterSelectionCreateNew");
	SetGlueScreen("charcreate");
end

function CharacterSelect_DeathKnightSwap(self)
	if ( CharacterSelect.currentModel == "DEATHKNIGHT" ) then
		if (self.currentModel ~= "DEATHKNIGHT") then
			self.currentModel = "DEATHKNIGHT";
			self:SetNormalTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Up-Blue");
			self:SetPushedTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Down-Blue");
			self:SetHighlightTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Highlight-Blue");
		end
	else
		if (self.currentModel == "DEATHKNIGHT") then
			self.currentModel = nil;
			self:SetNormalTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Up");
			self:SetPushedTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Down");
			self:SetHighlightTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Highlight");
		end
	end
end

function CharacterSelect_DemonHunterSwap(self)
	if ( CharacterSelect.currentModel == "DEMONHUNTER" ) then
		if (self.currentModel ~= "DEMONHUNTER") then
			self.currentModel = "DEMONHUNTER";
			self:SetNormalTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Up-Blue");
			self:SetPushedTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Down-Blue");
			self:SetHighlightTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Highlight-Blue");
		end
	else
		if (self.currentModel == "DEMONHUNTER") then
			self.currentModel = nil;
			self:SetNormalTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Up");
			self:SetPushedTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Down");
			self:SetHighlightTexture("Interface\\Glues\\Common\\Glue-Panel-Button-Highlight");
		end
	end
end


