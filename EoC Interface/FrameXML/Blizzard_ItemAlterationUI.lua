--[[
TO DO:
- Populate a table containing all currently equipped items on startup. Send to server the old item ID as well.
]]

-- below taken from EquipmentFlyout.lua
VERTICAL_FLYOUTS = { [16] = true, [17] = true, [18] = true }

local BUTTONS = { };
local ITEMS_CHANGED = { }
local CURRENT_ITEMS = { }
local numChanges = 0

function TransmogrifyFrame_Show()
	ShowUIPanel(TransmogrifyFrame);
	--[[if ( not TransmogrifyFrame:IsShown() ) then
		CloseTransmogrifyFrame();
	end]] 
end

function TransmogrifyFrame_Hide()
	--HideUIPanel(TransmogrifyFrame);
	TABLES_CHANGED = { }
end

function ApplyTransmogrifications()
	for _,v in pairs(ITEMS_CHANGED) do
		local original
		for _,k in pairs(CURRENT_ITEMS) do
			if k[2] == v[2] then
				original = k[1]
				break
			end
		end
		if not original then
			original = 0
		end
		SendChatMessage("[EoC-Addon]-"..tostring(v[1]).."-"..tostring(v[2]).."-"..tostring(original).."-0-0-0-0", "WHISPER", nil, UnitName("player"));
	end
	ITEMS_CHANGED = {}
	PlaySound("LEVELUP")
	HideUIPanel(TransmogrifyFrame);
end

function TransmogrifyFrame_OnLoad(self)
	TransmogrifyArtFrameTitleText:SetText("Transmogrify");
	TransmogrifyArtFrameTitleBg:SetDrawLayer("BACKGROUND", -1);
	TransmogrifyArtFrameTopTileStreaks:Hide();
	TransmogrifyArtFrameBg:Hide();
	SetPortraitToTexture(TransmogrifyArtFramePortrait, "Interface\\Icons\\INV_Arcane_Orb");

	RaiseFrameLevel(TransmogrifyArtFrame);
	RaiseFrameLevelByTwo(TransmogrifyFrameButtonFrame);
	TransmogrifyArtFrameCloseButton:SetScript("OnClick", function() HideUIPanel(TransmogrifyFrame); end);
	
	self:RegisterEvent("TRANSMOGRIFY_UPDATE");
	self:RegisterEvent("TRANSMOGRIFY_SUCCESS");
	self:RegisterEvent("TRANSMOGRIFY_BIND_CONFIRM");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

	-- flyout settings
	--[[self.flyoutSettings = {
		onClickFunc = TransmogrifyItemFlyoutButton_OnClick,
		getItemsFunc =  TransmogrifyItemFlyout_GetItems,
		hasPopouts = false,
		parent = TransmogrifyFrame,
		anchorX = 7,
		anchorY = 3,
		verticalAnchorX = -2,
		verticalAnchorY = -6,
	};]]
end

function TransmogrifyFrame_OnEvent(self, event, ...)
	if ( event == "TRANSMOGRIFY_UPDATE" ) then
		local slot = ...;
		-- play sound?
		local button = BUTTONS[slot];
		if ( button ) then
			local isTransmogrified, canTransmogrify, cannotTransmogrifyReason, hasPending, hasUndo = GetTransmogrifySlotInfo(button.id);
			if ( hasUndo ) then
				--PlaySound("UI_Transmogrify_Undo");
			elseif ( not hasPending ) then
				if ( button.hadUndo ) then
					--PlaySound("UI_Transmogrify_Redo");
					button.hadUndo = nil;
				end
			end
		end
		local dialog = StaticPopup_FindVisible("TRANSMOGRIFY_BIND_CONFIRM");
		if ( dialog and dialog.data.slot == slot ) then
			StaticPopup_Hide("TRANSMOGRIFY_BIND_CONFIRM");
		end
		-- check whether to show melee over ranged weapons
		-- ranged weapons normally apply last so they take over melee weapons, but classes without ranged always show melee
		if ( self.ranged ) then
			if ( slot == INVSLOT_RANGED ) then
				self.showMelee = nil;
			elseif ( slot == INVSLOT_MAINHAND or slot == INVSLOT_OFFHAND ) then
				self.showMelee = true;
			end
		end
		TransmogrifyFrame_Update(self);
	elseif ( event == "BAG_UPDATE" ) then
		--ValidateTransmogrifications();
	elseif ( event == "PLAYER_EQUIPMENT_CHANGED" ) then
		--ValidateTransmogrifications();
		if not TransmogrifyFrame:IsShown() then
			return
		end
		local slot, hasItem = ...;
		if not hasItem then -- Hackers :G
			return
		end
		local itemID = GetInventoryItemID("player", slot)
		local quality = GetInventoryItemQuality("player", itemID)
		if quality then
			if quality < 3 or quality > 4 then
				return
			end
		end
		if not itemID then
			return
		end
		local original
		for _,k in pairs(CURRENT_ITEMS) do
			if k[2] == slot then
				original = k[1]
				break
			end
		end
		if not original then
			return
		end
		local _, _, _, _, _, _, itemSubType, _, _, _, _ = GetItemInfo(itemID)
		local _, _, _, _, _, _, itemSubType2, _, _, _, _ = GetItemInfo(original)
		if itemSubType ~= itemSubType2 then
			return
		end
		numChanges = numChanges + 1
		if #ITEMS_CHANGED == 0 then
			table.insert(ITEMS_CHANGED, {itemID, slot})
		else
			for _,v in pairs(ITEMS_CHANGED) do
				if v[2] == slot then
					v[1] = itemID
				else
					table.insert(ITEMS_CHANGED, {itemID, slot})
				end
			end
		end
		TransmogrifyModelFrame:TryOn(itemID);
		TransmogrifyFrame_Update(self);
	elseif ( event == "TRANSMOGRIFY_CLOSE" ) then
		self:Hide();
		numChanges = 0
	elseif ( event == "TRANSMOGRIFY_SUCCESS" ) then
		local slot = ...;
		local button = BUTTONS[slot];
		if ( button ) then
			TransmogrifyFrame_AnimateSlotButton(button);
			TransmogrifyFrame_UpdateSlotButton(button);
		end
	elseif ( event == "TRANSMOGRIFY_BIND_CONFIRM" ) then
		local slot, itemLink = ...;
		local itemName, _, itemQuality, _, _, _, _, _, _, texture = GetItemInfo(itemLink);
		local r, g, b = GetItemQualityColor(itemQuality or 1);
		StaticPopup_Show("TRANSMOGRIFY_BIND_CONFIRM", nil, nil, {["texture"] = texture, ["name"] = itemName, ["color"] = {r, g, b, 1}, ["link"] = itemLink, ["slot"] = slot});
		TransmogrifyApplyButton:Disable();
	elseif ( event == "UNIT_MODEL_CHANGED" ) then
		local unit = ...;
		if ( unit == "player" ) then
			local hasAlternateForm, inAlternateForm = HasAlternateForm();
			if ( self.alternateForm ~= inAlternateForm ) then
				self.alternateForm = inAlternateForm;
				TransmogrifyModelFrame:SetUnit("player");
				TransmogrifyFrame_Update(self);
			end
		end
	end
end

function transRightClick(self, button)
end

function TransmogrifyFrame_OnShow(self)
	PlaySound("igSpellBookOpen");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:RegisterEvent("BAG_UPDATE");
	TransmogrifyModelFrame:SetUnit("player");
	--Model_Reset(TransmogrifyModelFrame);
	self.headSlot.displayHelm = ShowingHelm();
	self.backSlot.displayCloak = ShowingCloak();
	
	CURRENT_ITEMS = { }
	numChanges = 0
	
	for i = 1, 18 do
		local itemID = GetInventoryItemID("player", i);
		table.insert(CURRENT_ITEMS, {itemID, i})
	end
	
	TransmogrifyFrame_Update(self);
end

function TransmogrifyFrame_OnHide(self)
	PlaySound("igSpellBookClose");
	StaticPopup_Hide("TRANSMOGRIFY_BIND_CONFIRM");
	self:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:UnregisterEvent("BAG_UPDATE");
	self:UnregisterEvent("UNIT_MODEL_CHANGED");
	--CloseTransmogrifyFrame();
end

function TransmogrifyFrame_GetAnimationFrame()
	local name, frame;
	local i = 1;
	while true do
		name = "TransmogrifyAnimation"..i;
		frame = _G[name];
		if ( frame ) then
			if ( not frame:IsShown() ) then
				return frame;
			end
		else
			frame = CreateFrame("Frame", name, TransmogrifyFrame, "TransmogrifyAnimationFrameTemplate");
			return frame;
		end
		i = i + 1;
		assert(i < 20);
	end
end

function TransmogrifyFrame_GetPendingFrame()
	local name, frame;
	local i = 1;
	while true do
		name = "TransmogrifyPending"..i;
		frame = _G[name];
		if ( frame ) then
			if ( not frame:IsShown() ) then
				return frame;
			end
		else
			frame = CreateFrame("Frame", name, TransmogrifyFrame, "TransmogrifyPendingFrameTemplate");
			return frame;
		end
		i = i + 1;
		assert(i < 20);
	end
end

function TransmogrifyFrame_AnimateSlotButton(button)
	-- don't do anything if this button already has an animation frame;
	if ( button.animationFrame ) then
		return;
	end
	local animationFrame = TransmogrifyFrame_GetAnimationFrame();
	animationFrame:SetParent(button);
	animationFrame:SetPoint("CENTER");
	button.animationFrame = animationFrame;
	--local isTransmogrified = GetTransmogrifySlotInfo(button.id);
	--if ( isTransmogrified ) then
		animationFrame.transition:Show();
	--else
	--	animationFrame.transition:Hide();
	--end
	animationFrame:Show();
	animationFrame.anim:Play();
end

function TransmogrifySlotButton_OnLoad(self)
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	self:RegisterForDrag("LeftButton");
	local slotName = strsub(self:GetName(), 18);
	local id, textureName = GetInventorySlotInfo(slotName);
	self.id = id;
	self.defaultTexture = textureName;
	self.icon:SetTexture(textureName);
	self.verticalFlyout = VERTICAL_FLYOUTS[id];
	BUTTONS[id] = self;
	RaiseFrameLevelByTwo(self);
end

function TransmogrifySlotButton_OnEvent(self, event, ...)
	if ( event == "MODIFIER_STATE_CHANGED" ) then
		if ( IsModifiedClick("SHOWITEMFLYOUT") and self:IsMouseOver() ) then
			TransmogrifySlotButton_OnEnter(self);
		end
	end
end

function TransmogrifySlotButton_OnClick(self, button)
	--local isTransmogrified, canTransmogrify, cannotTransmogrifyReason, hasPending, hasUndo = GetTransmogrifySlotInfo(self.id);
	-- save for sound to play on TRANSMOGRIFY_UPDATE event
	self.hadUndo = hasUndo;
	if ( button == "LeftButton" ) then
		transLeftClick(self, button)
	elseif ( button == "RightButton" ) then
		transRightClick(self, button)
	end
	self.undoIcon:Hide();
	TransmogrifySlotButton_OnEnter(self);
end

local inv_colours = {
	[0] = "",
	[1] = "",
	[2] = "",
	[3] = "\124cff0070dd\ ", -- rare
	[4] = "\124cffa335ee\ ", -- epic
	[5] = "",
	[6] = ""
}

function transLeftClick(self, button)
	local slotName = strupper(strsub(self:GetName(), 18));
	local items = {}
	slotName = "INVTYPE_"..slotName
	local ID = nil
	for i = 0, NUM_BAG_SLOTS do
		for z = 1, GetContainerNumSlots(i) do
			ID = GetContainerItemID(i, z)
			if ID then
				itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType,
					itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =
					GetItemInfo(ID)
				if itemRarity == 3 or itemRarity == 4 then		
					itemEquipLoc = itemEquipLoc.."SLOT"
					if slotName == itemEquipLoc then
						local insert = inv_colours[itemRarity]..itemName
						table.insert(items, insert)
					end
				end
			end
		end
	end
	print("Available transmog items:")
	for _,v in pairs(items) do
		print(v)
	end
end

function TransmogrifySlotButton_OnEnter(self)
	--local isTransmogrified, canTransmogrify, cannotTransmogrifyReason, hasPending, hasUndo = GetTransmogrifySlotInfo(self.id);
	local cursorItem = GetCursorInfo();
	if ( cursorItem ~= "item" --[[and isTransmogrified and not ( hasPending or hasUndo )]] ) then
		self.undoIcon:Show();
	end
	
	local canTransmogrify = true
	local errorMsg = "No item in slot."
	local id, textureName = GetInventorySlotInfo(strsub(self:GetName(), 18));
	local item = GetInventoryItemID("player", id)
	if item then
		local quality = GetInventoryItemQuality("player",id)
		if quality < 3 or quality > 4 then
			errorMsg = "Item is too great or low a quality."
			canTransmogrify = false
		end
	else
		canTransmogrify = false
	end

	self:RegisterEvent("MODIFIER_STATE_CHANGED");
	--EquipmentFlyout_UpdateFlyout(self);
	--if ( not EquipmentFlyout_SetTooltipAnchor(self) ) then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	--end
	if ( hasPending or hasUndo ) then
		GameTooltip:SetTransmogrifyItem(self.id);
	elseif ( not canTransmogrify ) then
		local slotName = _G[strupper(strsub(self:GetName(), 18))];
		GameTooltip:SetText(slotName);
		if ( errorMsg ) then
			GameTooltip:AddLine(errorMsg, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1, 1);
		end
		GameTooltip:Show();
	else
		local hasItem = GameTooltip:SetInventoryItem("player", self.id);
	end

	TransmogrifyModelFrame.controlFrame:Show();
end

function TransmogrifySlotButton_OnLeave(self)
	self:UnregisterEvent("MODIFIER_STATE_CHANGED");
	TransmogrifyModelFrame.controlFrame:Hide();
	self.undoIcon:Hide();
	GameTooltip:Hide();
end

function TransmogrifyFrame_Update(self)
	-- ranged trickery
	-- stoneharry, until I understand this logic disabled ranged transmog
	--[[if (GetInventoryItemID("player",INVSLOT_RANGED) ~= nil) then
		TransmogrifyFrameRangedSlot:Show();
		TransmogrifyFrameMainHandSlot:Hide();
		TransmogrifyFrame.showMelee = false;
	else]]
		TransmogrifyFrameRangedSlot:Hide();
		TransmogrifyFrameMainHandSlot:Show();
		TransmogrifyFrame.showMelee = true;
	--end

	for _, button in pairs(BUTTONS) do
		TransmogrifyFrame_UpdateSlotButton(button);
	end
	local hasWarningDialog = StaticPopup_FindVisible("TRANSMOGRIFY_BIND_CONFIRM");
	TransmogrifyFrame_UpdateApplyButton(hasWarningDialog);
end

function TransmogrifyFrame_UpdateApplyButton(hasWarningDialog)
	local cost = numChanges * 400000
	local canApply = false
	local canApply;
	if ( cost > GetMoney() ) then
		SetMoneyFrameColor("TransmogrifyMoneyFrame", "red");
	else
		SetMoneyFrameColor("TransmogrifyMoneyFrame");
		if (numChanges > 0 ) then
			canApply = true;
		end
	end
	if cost == 0 then
		canApply = false
	end
	if ( hasWarningDialog ) then
		canApply = false;
	end
	MoneyFrame_Update("TransmogrifyMoneyFrame", cost);
	if ( canApply ) then
		TransmogrifyApplyButton:Enable();
	else
		TransmogrifyApplyButton:Disable();
	end
end

function TransmogrifyFrame_UpdateSlotButton(button)
	local slot = 0
	local isTransmogrified = false
	local canTransmogrify = false
	local cannotTransmogrifyReason = "No item in slot."
	local hasPending = false
	local hasUndo = false
	local visibleItemID, textureName
	local hasChange = hasPending or hasUndo;
	--[[for k,v in pairs(BUTTONS) do
		if v:GetName() == button:GetName() then
			slot = k
		end
	end]]
	local slotName = strsub(button:GetName(), 18);
	local id, textureName = GetInventorySlotInfo(slotName);
	slot = id
	local item = GetInventoryItemID("player", slot)
	if item then
		isTransmogrified = false
		for _,v in pairs(ITEMS_CHANGED) do
			if v[1] == item then
				isTransmogrified = true
				hasChange = true
				break
			end
		end
		canTransmogrify = true
		cannotTransmogrifyReason = ""
		hasPending = false
		hasUndo = false
		visibleItemID, textureName = GetInventoryItemID("player", slot), GetInventoryItemTexture("player",slot)
		hasChange = hasPending or hasUndo;
		local quality = GetInventoryItemQuality("player",slot)
		if quality < 3 or quality > 4 then
			cannotTransmogrifyReason = "Item is too powerful or too weak."
			canTransmogrify = false
			isTransmogrified = false
		end
	end

	if ( canTransmogrify ) then
		button.icon:SetTexture(textureName);
		button.noItem:Hide();
	else
		button.icon:SetTexture(button.defaultTexture);
		button.noItem:Show();
	end

	-- desaturate icon if it's not transmogrified
	if ( isTransmogrified or hasPending ) then
		if not button.animplayed then
			button.animplayed = true
			TransmogrifyFrame_AnimateSlotButton(button)
		end
		button.icon:SetDesaturated(false);
	else
		button.icon:SetDesaturated(true);
	end

	-- show altered texture if the item is transmogrified and doesn't have a pending transmogrification or is animating
	if ( isTransmogrified and not hasChange and not button.animationFrame ) then
		button.altTexture:Show();
	else
		button.altTexture:Hide();
	end

	-- show ants frame is the item has a pending transmogrification and is not animating
	if ( hasChange and not button.animationFrame ) then
		local pendingFrame = button.pendingFrame;
		if ( not pendingFrame ) then
			pendingFrame = TransmogrifyFrame_GetPendingFrame();
			pendingFrame:SetParent(button);
			pendingFrame:SetPoint("CENTER");
			button.pendingFrame = pendingFrame;
		end
		pendingFrame:Show();
		if ( hasUndo ) then
			pendingFrame.undo:Show();
		else
			pendingFrame.undo:Hide();
		end
	elseif ( button.pendingFrame ) then
		button.pendingFrame:Hide();
		button.pendingFrame = nil;
	end
	

	local showModel = true;
	if ( TransmogrifyFrame.showMelee and button.id == INVSLOT_RANGED ) then
		showModel = false;
	elseif ( not TransmogrifyFrame.showMelee and ( button.id == INVSLOT_MAINHAND or button.id == INVSLOT_OFFHAND ) ) then
		showModel = false;
	end
	if (button.id == INVSLOT_HEAD and not button.displayHelm) then
		if ( hasChange ) then
			button.displayHelm = true;
		else
			showModel = false;
		end
	end
	if (button.id == INVSLOT_BACK and not button.displayCloak) then
		if ( hasChange ) then
			button.displayCloak = true;
		else
			showModel = false;
		end
	end
	if ( showModel ) then
		if ( visibleItemID and visibleItemID > 0 ) then
			local slot;
			if ( button.id == INVSLOT_MAINHAND ) then
				slot = "mainhand";
			elseif ( button.id == INVSLOT_OFFHAND ) then
				slot = "offhand";
			end
			TransmogrifyModelFrame:TryOn(visibleItemID, slot);
		else
			--[[if ( button.id == INVSLOT_RANGED ) then
				-- clear both hands
				TransmogrifyModelFrame:UndressSlot(INVSLOT_MAINHAND);
				TransmogrifyModelFrame:UndressSlot(INVSLOT_OFFHAND);
			else
				TransmogrifyModelFrame:UndressSlot(button.id);
			end]]
		end
	end
end

function TransmogrifyItemFlyoutButton_OnClick(self)
	if ( self.location ) then
		local player, bank, bags, slot, bag = EquipmentManager_UnpackLocation(self.location);
		if ( bag ) then
			UseItemForTransmogrify(bag, slot, EquipmentFlyoutFrame.button.id);
		else
			UseItemForTransmogrify(nil, slot, EquipmentFlyoutFrame.button.id);
		end
	end
end

function TransmogrifyItemFlyout_GetItems(slot, itemTable)
	GetInventoryItemsForSlot(slot, itemTable, "transmogrify");
end