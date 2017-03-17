MAX_ACHIEVEMENT_ALERTS = 2;
MAX_LOOT_WON_ALERTS = 2;
DELAYED_LOOT_WON_ALERT_FRAMES = {};
ITEM_QUALITY_LEGENDARY = 5;
LOOT_BORDER_QUALITY_COORDS = {
	[ITEM_QUALITY_UNCOMMON] = {0.17968750, 0.23632813, 0.74218750, 0.96875000},
	[ITEM_QUALITY_RARE] = {0.86718750, 0.92382813, 0.00390625, 0.23046875},
	[ITEM_QUALITY_EPIC] = {0.92578125, 0.98242188, 0.00390625, 0.23046875},
	[ITEM_QUALITY_LEGENDARY] = {0.80859375, 0.86523438, 0.00390625, 0.23046875},
};

function AlertFrame_OnLoad (self)
	self:RegisterEvent("ACHIEVEMENT_EARNED");
	self:RegisterEvent("LFG_COMPLETION_REWARD");
end

function AlertFrame_OnEvent (self, event, ...)
	if ( event == "ACHIEVEMENT_EARNED" ) then
		local id = ...;
		
		if ( not AchievementFrame ) then
			AchievementFrame_LoadUI();
		end
		
		AchievementAlertFrame_ShowAlert(id);
	elseif ( event == "LFG_COMPLETION_REWARD" ) then
		DungeonCompletionAlertFrame_ShowAlert();
	end
end

function AlertFrame_AnimateIn(frame)
	frame:Show();
	frame.animIn:Play();
	if ( frame.glow ) then
		frame.glow:Show();
		frame.glow.animIn:Play();
	end
	if ( frame.shine ) then
		frame.shine:Show();
		frame.shine.animIn:Play();
	end
	frame.waitAndAnimOut:Stop();	--Just in case it's already animating out, but we want to reinstate it.
	if ( frame:IsMouseOver() ) then
		frame.waitAndAnimOut.animOut:SetStartDelay(1);
	else
		frame.waitAndAnimOut.animOut:SetStartDelay(4.05);
		frame.waitAndAnimOut:Play();
	end
end

function AlertFrame_StopOutAnimation(frame)
	frame.waitAndAnimOut:Stop();
	frame.waitAndAnimOut.animOut:SetStartDelay(1);
end

function AlertFrame_ResumeOutAnimation(frame)
	frame.waitAndAnimOut:Play();
end

--[[
function AlertFrame_FixAnchors()
	AchievementAlertFrame_FixAnchors();
	DungeonCompletionAlertFrame_FixAnchors();
	LootWonAlertFrame_FixAnchors();
end]]

function AlertFrame_FixAnchors()
	local alertAnchor = AlertFrame;
	alertAnchor = AlertFrame_SetLootAnchors(alertAnchor);
	alertAnchor = AlertFrame_SetLootWonAnchors(alertAnchor);
	alertAnchor = AlertFrame_SetAchievementAnchors(alertAnchor);
	alertAnchor = AlertFrame_SetDungeonCompletionAnchors(alertAnchor);
end

function AlertFrame_SetLootAnchors(alertAnchor)
	for i=1, NUM_GROUP_LOOT_FRAMES do
		local frame = _G["GroupLootFrame"..i];
		if ( frame and frame:IsShown() ) then
			--frame:SetPoint("BOTTOM", alertAnchor, "TOP", 0, 10);
			alertAnchor = frame;
		end
	end
	return alertAnchor;
end

function AlertFrame_SetLootWonAnchors(alertAnchor)
	if ( LootWonAlertFrame1 ) then
		for i=1, MAX_LOOT_WON_ALERTS do
			local frame = _G["LootWonAlertFrame"..i];
			if ( frame and frame:IsShown() ) then
				frame:SetPoint("BOTTOM", alertAnchor, "TOP", 0, 5);
				alertAnchor = frame;
			end
		end
	end
	return alertAnchor;
end

function AlertFrame_SetAchievementAnchors(alertAnchor)
	-- skip work if there hasn't been an achievement toast yet
	if ( AchievementAlertFrame1 ) then
		for i = 1, MAX_ACHIEVEMENT_ALERTS do
			local frame = _G["AchievementAlertFrame"..i];
			if ( frame and frame:IsShown() ) then
				frame:SetPoint("BOTTOM", alertAnchor, "TOP", 0, 5);
				alertAnchor = frame;
			end
		end
	end
	return alertAnchor;
end

function AlertFrame_SetDungeonCompletionAnchors(alertAnchor)
	local frame = DungeonCompletionAlertFrame1;
	if ( frame:IsShown() ) then
		frame:SetPoint("BOTTOM", alertAnchor, "TOP", 0, 5);
		alertAnchor = frame;
	end
	return alertAnchor;
end

-- [[ DungeonCompletionAlertFrame ]] --
function DungeonCompletionAlertFrame_OnLoad (self)
	self.glow = self.glowFrame.glow;
end

DUNGEON_COMPLETION_MAX_REWARDS = 1;
function DungeonCompletionAlertFrame_ShowAlert()
	PlaySound("LFG_Rewards");
	local frame = DungeonCompletionAlertFrame1;
	--For now we only have 1 dungeon alert frame. If you're completing more than one dungeon within ~5 seconds, tough luck.
	local name, typeID, textureFilename, moneyBase, moneyVar, experienceBase, experienceVar, numStrangers, numRewards= GetLFGCompletionReward();
	
	
	--Set up the rewards
	local moneyAmount = moneyBase + moneyVar * numStrangers;
	local experienceGained = experienceBase + experienceVar * numStrangers;
	
	local rewardsOffset = 0;

	if ( moneyAmount > 0 or experienceGained > 0 ) then --hasMiscReward ) then
		SetPortraitToTexture(DungeonCompletionAlertFrame1Reward1.texture, "Interface\\Icons\\inv_misc_coin_02");
		DungeonCompletionAlertFrame1Reward1.rewardID = 0;
		DungeonCompletionAlertFrame1Reward1:Show();

		rewardsOffset = 1;
	end
	
	for i = 1, numRewards do
		local frameID = (i + rewardsOffset);
		local reward = _G["DungeonCompletionAlertFrame1Reward"..frameID];
		if ( not reward ) then
			reward = CreateFrame("FRAME", "DungeonCompletionAlertFrame1Reward"..frameID, DungeonCompletionAlertFrame1, "DungeonCompletionAlertFrameRewardTemplate");
			reward:SetID(frameID);
			DUNGEON_COMPLETION_MAX_REWARDS = frameID;
		end
		DungeonCompletionAlertFrameReward_SetReward(reward, i);
	end
	
	local usedButtons = numRewards + rewardsOffset;
	--Hide the unused ones
	for i = usedButtons + 1, DUNGEON_COMPLETION_MAX_REWARDS do
		_G["DungeonCompletionAlertFrame1Reward"..i]:Hide();
	end
	
	if ( usedButtons > 0 ) then
		--Set up positions
		local spacing = 36;
		DungeonCompletionAlertFrame1Reward1:SetPoint("TOP", DungeonCompletionAlertFrame1, "TOP", -spacing/2 * usedButtons + 41, 0);
		for i = 2, usedButtons do
			_G["DungeonCompletionAlertFrame1Reward"..i]:SetPoint("CENTER", "DungeonCompletionAlertFrame1Reward"..(i - 1), "CENTER", spacing, 0);
		end
	end
	
	--Set up the text and icons.
	
	frame.instanceName:SetText(name);
	if ( typeID == TYPEID_HEROIC_DIFFICULTY ) then
		frame.heroicIcon:Show();
		frame.instanceName:SetPoint("TOP", 33, -44);
	else
		frame.heroicIcon:Hide();
		frame.instanceName:SetPoint("TOP", 25, -44);
	end
		
	frame.dungeonTexture:SetTexture("Interface\\LFGFrame\\LFGIcon-"..textureFilename);
	
	AlertFrame_AnimateIn(frame)
	
	
	AlertFrame_FixAnchors();
end

function DungeonCompletionAlertFrameReward_SetReward(frame, index)
	local texturePath, quantity = GetLFGCompletionRewardItem(index);
	SetPortraitToTexture(frame.texture, texturePath);
	frame.rewardID = index;
	frame:Show();
end

function DungeonCompletionAlertFrameReward_OnEnter(self)
	AlertFrame_StopOutAnimation(self:GetParent());
	
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if ( self.rewardID == 0 ) then
		GameTooltip:AddLine(YOU_RECEIVED);
		local name, typeID, textureFilename, moneyBase, moneyVar, experienceBase, experienceVar, numStrangers, numRewards = GetLFGCompletionReward();

		local moneyAmount = moneyBase + moneyVar * numStrangers;
		local experienceGained = experienceBase + experienceVar * numStrangers;
		
		if ( experienceGained > 0 ) then
			GameTooltip:AddLine(string.format(GAIN_EXPERIENCE, experienceGained));
		end
		if ( moneyAmount > 0 ) then
			SetTooltipMoney(GameTooltip, moneyAmount, nil);
		end
	else
		GameTooltip:SetLFGCompletionReward(self.rewardID);
	end
	GameTooltip:Show();
end

function DungeonCompletionAlertFrameReward_OnLeave(frame)
	AlertFrame_ResumeOutAnimation(frame:GetParent());
	GameTooltip:Hide();
end

-- [[ AchievementAlertFrame ]] --
function AchievementAlertFrame_OnLoad (self)
	self:RegisterForClicks("LeftButtonUp");
end

function AchievementAlertFrame_ShowAlert (achievementID)
	local frame = AchievementAlertFrame_GetAlertFrame();
	local _, name, points, completed, month, day, year, description, flags, icon = GetAchievementInfo(achievementID);
	if ( not frame ) then
		-- We ran out of frames! Bail!
		return;
	end

	_G[frame:GetName() .. "Name"]:SetText(name);
	
	local shield = _G[frame:GetName() .. "Shield"];
	AchievementShield_SetPoints(points, shield.points, GameFontNormal, GameFontNormalSmall);
	if ( points == 0 ) then
		shield.icon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields-NoPoints]]);
	else
		shield.icon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields]]);
	end
	
	_G[frame:GetName() .. "IconTexture"]:SetTexture(icon);
	
	frame.id = achievementID;
	
	AlertFrame_AnimateIn(frame);
	
	AlertFrame_FixAnchors();
end

function AchievementAlertFrame_GetAlertFrame()
	local name, frame, previousFrame;
	for i=1, MAX_ACHIEVEMENT_ALERTS do
		name = "AchievementAlertFrame"..i;
		frame = _G[name];
		if ( frame ) then
			if ( not frame:IsShown() ) then
				return frame;
			end
		else
			frame = CreateFrame("Button", name, UIParent, "AchievementAlertFrameTemplate");
			if ( not previousFrame ) then
				frame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 128);
			else
				frame:SetPoint("BOTTOM", previousFrame, "TOP", 0, -10);
			end
			return frame;
		end
		previousFrame = frame;
	end
	return nil;
end

function AchievementAlertFrame_OnClick (self)
	local id = self.id;
	if ( not id ) then
		return;
	end
	
	CloseAllWindows();
	ShowUIPanel(AchievementFrame);
	
	local _, _, _, achCompleted = GetAchievementInfo(id);
	if ( achCompleted and (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrameFilters[ACHIEVEMENT_FILTER_INCOMPLETE].func) ) then
		AchievementFrame_SetFilter(ACHIEVEMENT_FILTER_ALL);
	elseif ( (not achCompleted) and (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrameFilters[ACHIEVEMENT_FILTER_COMPLETE].func) ) then
		AchievementFrame_SetFilter(ACHIEVEMENT_FILTER_ALL);
	end
	
	AchievementFrame_SelectAchievement(id)
end

function AchievementAlertFrame_OnHide (self)
	AlertFrame_FixAnchors();
end

-- [[ LootWonAlertFrame ]] --

function LootWonAlertFrame_OnLoad (self)
	self.glow = _G[self:GetName().."Glow"];
	self.shine = _G[self:GetName().."Shine"];
end

function LootWonAlertFrame_ShowAlert(itemLink)
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		if ( GetBattlefieldStatus(i) == "active" ) then
			return;
		end
	end
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemLink);
	if ( not itemName or itemRarity < 2 or itemType == "Money" ) then
		--Invalid item link.
		return;
	elseif ( 5 < itemRarity ) then
		itemRarity = 5;
	end
	
	local frame;
	for i=1, MAX_LOOT_WON_ALERTS do
		local name = "LootWonAlertFrame"..i
		local lootWon = _G[name];
		if ( not lootWon ) then
			frame = CreateFrame("Button", name, UIParent, "LootWonAlertFrameTemplate");
			break;
		elseif ( not lootWon:IsShown() ) then
			frame = lootWon;
			break;
		end
	end

	if ( not frame ) then
		table.insert(DELAYED_LOOT_WON_ALERT_FRAMES, itemLink);
		return;
	end

	frame.Icon:SetTexture(itemTexture);
	frame.Label:SetText("You Won!");
	frame.ItemName:SetText(itemName);
	local color = ITEM_QUALITY_COLORS[itemRarity];
	frame.ItemName:SetVertexColor(color.r, color.g, color.b);
	frame.IconBorder:SetTexCoord(unpack(LOOT_BORDER_QUALITY_COORDS[itemRarity] or LOOT_BORDER_QUALITY_COORDS[ITEM_QUALITY_UNCOMMON]));

	frame.hyperlink = itemLink;

	AlertFrame_AnimateIn(frame);
	
	AlertFrame_FixAnchors();
end

function LootWonAlertFrame_OnHide(self)
	if ( 0 < #DELAYED_LOOT_WON_ALERT_FRAMES ) then
		AlertFrame__wait(0.1, LootWonAlertFrame_ShowAlert, DELAYED_LOOT_WON_ALERT_FRAMES[1]);
		tremove(DELAYED_LOOT_WON_ALERT_FRAMES, 1);
	end
end

local waitTable = {};
local waitFrame = nil;

function AlertFrame__wait(delay, func, ...)
  if(type(delay)~="number" or type(func)~="function") then
    return false;
  end
  if(waitFrame == nil) then
    waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
    waitFrame:SetScript("onUpdate",function (self,elapse)
      local count = #waitTable;
      local i = 1;
      while(i<=count) do
        local waitRecord = tremove(waitTable,i);
        local d = tremove(waitRecord,1);
        local f = tremove(waitRecord,1);
        local p = tremove(waitRecord,1);
        if(d>elapse) then
          tinsert(waitTable,i,{d-elapse,f,p});
          i = i + 1;
        else
          count = count - 1;
          f(unpack(p));
        end
      end
    end);
  end
  tinsert(waitTable,{delay,func,{...}});
  return true;
end
