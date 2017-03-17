EOC_ATLAS_VERSION = "Edge of Chaos Atlas - Beta 0.4";
EOC_ATLAS_CATEGORYHEIGHT = 22;
EOC_ATLAS_ELEMENTHEIGHT = 37;

local numElements = 8;
local numCategoryDisplay = 18;

local shown, selected, selectedPage, summaryCat, heroicState, categoryPages;

local QUEST_UNAVAILABLE = 0;
local QUEST_AVAILABLE = 1;
local QUEST_COMPLETED = 2;
local QUEST_DAILY = 3;
local QUEST_DISABLED = 4;

-- [[ Functions ]] --

local function EoCAtlasFrame_ToggleInfo(on)
	if (on) then
		EoCAtlasFrameInfoSummary:Hide();
		EoCAtlasFrameInfoTitle:Show();
		EoCAtlasFrameInfoDivider:Show();
	else
		EoCAtlasFrameInfoSummary:Show();
		EoCAtlasFrameInfoTitle:Hide();
		EoCAtlasFrameInfoDivider:Hide();
	end
	
	heroicState = nil;
	EoCAtlasFrameInfoSubtitle:Hide();
	EoCAtlasFrameInfoDropDown:Hide();
	EoCAtlasFrameInfoHeroic:SetChecked(nil);
	EoCAtlasFrameInfoRaid:SetChecked(nil);
	EoCAtlasFrameInfoHeroic:Hide();
	EoCAtlasFrameInfoRaid:Hide();
	EoCAtlasFrameInfoScrollFrame:Hide();
	
	EOC_ATLAS.displayElements = {};
	EoCAtlasFrameInfo_Update();
end

local function EoCAtlasFrame_ShowError()
	EoCAtlasFrame_ToggleInfo(true);
	EoCAtlasFrameInfoDivider:Hide();
	
	EoCAtlasFrameInfoTitle:SetText("Nobody here but us chickens");
	EoCAtlasFrameInfoSubtitle:SetText("(Something went very wrong if this appeared)");
	EoCAtlasFrameInfoSubtitle:Show();
end

local function EoCAtlasFrame_GetQuestStatus(questID)
	local quest = EOC_ATLAS.quests[questID];
	if (quest) then
		if (EOC_ATLAS.completed[questID]) then
			return QUEST_COMPLETED;
		elseif (EOC_ATLAS.disabled[questID]) then
			return QUEST_DISABLED;
		elseif (UnitLevel("player") < quest.level) then
			return QUEST_UNAVAILABLE;
		elseif (quest.req) then
			for _, id in ipairs (quest.req) do
				if (not EOC_ATLAS.completed[id]) then
					return QUEST_UNAVAILABLE;
				end
			end
		elseif (quest.reqAny) then
			local unavailable = true;
			for _, id in ipairs (quest.reqAny) do
				if (EOC_ATLAS.completed[id]) then
					unavailable = false;
					break;
				end
			end
			
			if (unavailable) then
				return QUEST_UNAVAILABLE;
			end
		elseif (quest.faction) then
		end
		
		return quest.daily and QUEST_DAILY or QUEST_AVAILABLE;
	end
end

local function EoCAtlasFrame_SetType(self, info)
	if (not info) then
		-- info = {type="header", text=self:GetName()};
		self:Hide();
		return;
	end
	
	self.icon:Hide();
	self.text:Hide();
	self.textExtra:Hide();
	self.textLarge:Hide();
	self.textSmall:Hide();
	
	if (info.type == "header") then
		self.textLarge:SetText(info.text);
		self.textLarge:Show();
	elseif (info.type == "item") then
		local item = EOC_ATLAS.items[info.item];
		
		self.icon.itemLink = item.link;
		self.icon.tooltip = info.tooltip;
		
		self.text:SetText(item.name);
		self.iconTexture:SetTexture(item.icon);
		
		self.text:Show();
		self.icon:Show();
		
		if (item.extra) then
			self.textExtra:SetText(item.extra);
			self.textExtra:Show();
		end
	elseif (info.type == "text") then
		self.textSmall:SetText(info.text);
		self.textSmall:Show();
	elseif (info.type == "questReq") then
		
	end
	self:Show();
end

local function EoCAtlasFrame_UpdateElements()
	if (categoryPages and selectedPage) then
		local page = categoryPages[selectedPage];
		if (page) then
			local offset = 0;
			if (EOC_ATLAS[selected].heroic and EoCAtlasFrameInfoHeroic:GetChecked()) then
				offset = 100;
			end
			if (EOC_ATLAS[selected].raid and EoCAtlasFrameInfoRaid:GetChecked()) then
				offset = offset + 200;
			end
			
			local pageElements = page.elements[offset];
			if (not pageElements) then
				EoCAtlasFrame_ShowError();
				return;
			end
			
			EoCAtlasFrameInfoScrollFrameScrollBar:SetValue(0);
			EOC_ATLAS.displayElements = {};
			
			for i = 1, pageElements do
				table.insert(EOC_ATLAS.displayElements, page.elements[offset+i]);
			end
			
			EoCAtlasFrameInfo_Update();
		end
	else
		EoCAtlasFrame_ShowError();
	end
end

local function EoCAtlasFrame_SetPage(newPage)
	if (categoryPages) then
		local page = categoryPages[newPage];
		if (page) then
			selectedPage = newPage;
			
			EoCAtlasFrameInfoTitle:SetText(page.title);
			if (page.subtitle) then
				EoCAtlasFrameInfoSubtitle:SetText(page.subtitle);
			end
			
			if (EOC_ATLAS[selected].heroic) then
				if (page.heroicOnly) then
					EoCAtlasFrameInfoHeroic:SetChecked(true);
					EoCAtlasFrameInfoHeroic:SetText("Heroic Only");
					EoCAtlasFrameInfoHeroic:Disable();
				else
					EoCAtlasFrameInfoHeroic:SetChecked(heroicState);
					EoCAtlasFrameInfoHeroic:SetText("Heroic");
					EoCAtlasFrameInfoHeroic:Enable();
				end
			end
			
			EoCAtlasFrame_UpdateElements();
		end
	else
		EoCAtlasFrame_ShowError();
	end
end

local function EoCAtlasFrame_SetCategory(category)
	EoCAtlasFrame_ToggleInfo(true);
	local cat = EOC_ATLAS[category];
	if (cat) then
		EoCAtlasFrameInfo:Show();
		
		if (cat.pages) then
			if (#cat.pages == 0) then
				EoCAtlasFrameInfoTitle:SetText("Coming Soon™");
				return;
			end
			
			if (cat.heroic) then
				EoCAtlasFrameInfoHeroic:Show();
			end
			if (cat.raid) then
				EoCAtlasFrameInfoRaid:Show();
			end
			
			categoryPages = cat.pages;
			EoCAtlasFrame_SetPage(1);
			
			if (#cat.pages > 1) then
				EoCAtlasFrameInfoDropDown:Show();
			end
		else
			EoCAtlasFrame_ShowError();
		end
	end
end

local function EoCAtlasFrame_UpdateDisplayedCategories()
	EOC_ATLAS.displayCategories = {};
	
	for _, catN in ipairs (EOC_ATLAS.categoryList) do
		local cat = EOC_ATLAS[catN];
		if (cat.parent == -1) then
			tinsert(EOC_ATLAS.displayCategories, catN);
			
			if (shown == catN) then
				for _, subcatN in ipairs (EOC_ATLAS.categoryList) do
					if (EOC_ATLAS[subcatN].parent == catN) then
						tinsert(EOC_ATLAS.displayCategories, subcatN);
					end
				end
			end
		end
	end
	
	EoCAtlasFrameCategory_Update();
end

-- [[ AtlasFrame ]] --

function EoCAtlasFrame_Toggle()
	if ( EoCAtlasFrame:IsShown() ) then
		EoCAtlasFrame:Hide();
	else
		EoCAtlasFrame:Show();
	end
end
ShowAtlas = EoCAtlasFrame_Toggle;

function EoCAtlasFrame_OnLoad (self)
	tinsert(UISpecialFrames, self:GetName());
	
	self:RegisterEvent("VARIABLES_LOADED");
	-- self:RegisterEvent("CHAT_MSG_ADDON");
	-- self:RegisterEvent("QUEST_COMPLETE");
	self:SetScript("OnEvent", EoCAtlasFrame_OnEvent);
	
    EoCAtlasFrameInfoSummary:SetText([[
This section will probably have an actual summary later.

Changelog:
    Added:
        *Scrollbar added to elements display. Can
           now display more than twenty elements!
           Oh, the divider is also new, I suppose
    Changed:
        *Tons of behind-the-scenes work to support
           the new elements scrollbar
        *Sets category now looks pretty! Yay!
        *Element size increased, icon size increased,
           extra text can now have two lines
        *Using some fancy code, the generator now
           balances loot between the two columns
           based on item type (currently weapon,
           armor, offset and other)
    Fixed:
        *Lua error caused by poor copy-pasting of
           minimap button XML code
        *Derpy faux scrollbars are derpy. Apparently
           FauxScrollFrame_SetOffset doesn't actually
           set the slider. That's been fixed.
]]);
	
	local baseX = -132;
	local baseY = -74;
	for y = 0, 7 do
		for x = 0, 1 do
			local index = (y+1) .. (x == 0 and "Left" or "Right");
			local button = CreateFrame("Button", "EoCAtlasFrameInfoElement"..index, EoCAtlasFrameInfo, "EoCAtlasFrameElementTemplate");
			button:SetPoint("TOP", EoCAtlasFrameInfo, "TOP", baseX + x*236, baseY - y*40);
			button:SetSize(234, 38);
			
			EoCAtlasFrame_SetType(button);
		end
	end
end

function EoCAtlasFrame_OnShow (self)
	PlaySound("AchievementMenuOpen");
	EoCAtlasFrameCategoryScrollFrameScrollBar:SetValue(0);
	
	EOC_ATLAS.displayCategories = {};
	EOC_ATLAS.displayElements = {};
	local index = 1;
	for _, catN in ipairs (EOC_ATLAS.categoryList) do
		local cat = EOC_ATLAS[catN];
		if (cat.parent == -1) then
			tinsert(EOC_ATLAS.displayCategories, catN);
			
			if (cat.title == "Summary" and not selected) then
				selected = catN;
				summaryCat = catN;
			end
			
			if (index <= numCategoryDisplay) then
				local button = _G["EoCAtlasFrameCategory"..index];
				button.category = catN;
				
				local normalText = _G[button:GetName().."NormalText"];
				local normalTexture = _G[button:GetName().."NormalTexture"];
				if (cat.parent == -1) then
					button:SetText(cat.title);
					normalText:SetPoint("LEFT", button, "LEFT", 4, 0);
					normalTexture:SetAlpha(1.0);	
				else
					button:SetText(HIGHLIGHT_FONT_COLOR_CODE..cat.title..FONT_COLOR_CODE_CLOSE);
					normalText:SetPoint("LEFT", button, "LEFT", 12, 0);
					normalTexture:SetAlpha(0.4);
				end
				
				index = index + 1;
			end
		end
	end
	
	EoCAtlasFrame_UpdateDisplayedCategories();
end

function EoCAtlasFrame_OnHide (self)
	PlaySound("AchievementMenuClose");
end

-- [[ AtlasFrameCategory ]] --

function EoCAtlasFrameCategory_Update()
	local categories = #EOC_ATLAS.displayCategories;
	local offset = FauxScrollFrame_GetOffset(EoCAtlasFrameCategoryScrollFrame);
	
	for i = 1, numCategoryDisplay do
		local index = offset + i;
		local button = _G["EoCAtlasFrameCategory"..i];
		
		if (index > categories) then
			button:Hide();
		else
			button:Show();
			
			local catN = EOC_ATLAS.displayCategories[index];
			local cat = EOC_ATLAS[catN];
			button.category = catN;
			
			local normalText = _G[button:GetName().."NormalText"];
			local normalTexture = _G[button:GetName().."NormalTexture"];
			if (cat.parent == -1) then
				button:SetText(cat.title);
				normalText:SetPoint("LEFT", button, "LEFT", 4, 0);
				normalTexture:SetAlpha(1.0);	
			else
				button:SetText(HIGHLIGHT_FONT_COLOR_CODE..cat.title..FONT_COLOR_CODE_CLOSE);
				normalText:SetPoint("LEFT", button, "LEFT", 12, 0);
				normalTexture:SetAlpha(0.4);
			end
			
			if (catN ~= summaryCat and (catN == shown or catN == selected)) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
		end
	end

	FauxScrollFrame_Update(EoCAtlasFrameCategoryScrollFrame, categories, numCategoryDisplay, EOC_ATLAS_CATEGORYHEIGHT);
	EoCAtlasFrameCategoryScrollFrame:Show();
end

function EoCAtlasFrameCategory_OnClick(self)
	local parent = EOC_ATLAS[self.category].parent;
	local old = selected;
	if (self.category == summaryCat) then
		shown = summaryCat;
		selected = nil;
		old = nil; --Don't want it to hide everything again
		
		EoCAtlasFrame_ToggleInfo(false);
	elseif (parent == -1) then
		shown = shown ~= self.category and self.category or nil;
	else
		selected = self.category;
	end
	
	EoCAtlasFrame_UpdateDisplayedCategories();
	
	if (selected ~= old) then
		EoCAtlasFrame_SetCategory(selected);
	end
end

-- [[ AtlasFrameInfo ]] --

function EoCAtlasFrameInfo_Update()
	local elements = #EOC_ATLAS.displayElements;
	local offset = FauxScrollFrame_GetOffset(EoCAtlasFrameInfoScrollFrame);
	
	for i = 1, numElements do
		local index = offset + i;
		local left, right = _G["EoCAtlasFrameInfoElement"..i.."Left"], _G["EoCAtlasFrameInfoElement"..i.."Right"];
		
		if (index > elements) then
			left:Hide();
			right:Hide();
		else
			local element = EOC_ATLAS.displayElements[index];
			
			if (element) then
				if (element.left) then
					left:Show();
					EoCAtlasFrame_SetType(left, element.left);
				else
					left:Hide();
				end
				if (element.right) then
					right:Show();
					EoCAtlasFrame_SetType(right, element.right);
				else
					right:Hide();
				end
			else
				left:Hide();
				right:Hide();
			end
		end
	end

	FauxScrollFrame_Update(EoCAtlasFrameInfoScrollFrame, elements, numElements, EOC_ATLAS_ELEMENTHEIGHT);
end

function EoCAtlasFrameInfoElement_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetHyperlink(self.itemLink);

	if (self.tooltip) then
		GameTooltip:AddLine("|n");
		GameTooltip:AddLine(self.tooltip);
		GameTooltip:Show();
	end

	GameTooltip_ShowCompareItem();

	if ( IsModifiedClick("DRESSUP") ) then
		ShowInspectCursor();
	else
		ResetCursor();
	end
end

function EoCAtlasFrameInfoHeroic_OnClick(self)
	heroicState = self:GetChecked();
	EoCAtlasFrame_UpdateElements();
end

function EoCAtlasFrameInfoDropDown_OnShow(self)
	UIDropDownMenu_Initialize(self, EoCAtlasFrameInfoDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(EoCAtlasFrameInfoDropDown, selectedPage or 1);
end

function EoCAtlasFrameInfoDropDown_Initialize()
	local pages = categoryPages;
	local info = UIDropDownMenu_CreateInfo();
	for i = 1, #pages do
		if (pages[i].quest) then
			local status = EoCAtlasFrame_GetQuestStatus(pages[i].quest);
		end
		info.text = pages[i].title;
		info.value = i;
		info.func = EoCAtlasFrameInfoDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
		info.checked = nil;
	end
end

function EoCAtlasFrameInfoDropDown_OnClick(self)
	UIDropDownMenu_SetSelectedValue(EoCAtlasFrameInfoDropDown, self.value);
	EoCAtlasFrame_SetPage(self.value);
end

-- [[ EoCAtlasFrameMinimapButton ]] --

function EoCAtlasFrameMinimapButton_OnUpdate(self)
	centerY, centerX = ( Minimap:GetTop() - ( ( Minimap:GetTop() - Minimap:GetBottom() ) / 2 ) ), ( Minimap:GetLeft() + ( ( Minimap:GetRight() - Minimap:GetLeft() ) / 2 ) )
	x, y = GetCursorPosition();
	x, y = x / self:GetEffectiveScale(), y / self:GetEffectiveScale();
	x, y = -( centerX - x ), -( centerY - y );
	centerX, centerY = math.abs(x), math.abs(y);
	centerX, centerY = (centerX / sqrt((centerX * centerX) + (centerY * centerY))) * 76, (centerY / sqrt((centerX * centerX) + (centerY * centerY))) * 76;
	
	if ( x < 0 ) then
		centerX = -centerX;
	end
	
	if ( y < 0 ) then
		centerY = -centerY;
	end
	
	self:ClearAllPoints();
	self:SetPoint("CENTER", centerX, centerY);
	self:SetUserPlaced(true);
end