--[[
Snake by Motig-VashjEU
TODO: cleanup, improve efficiency, seperate interface, features
--]]

local snakeDirection = 0;
local timeSinceLastUpdate = 0;
local snakeDirection = 'right';
local gameState = 0;
local totalScore = 0;
local snakePlayerX, snakePlayerY = 0, 0;
local foodTexture = { 'Interface/ICONS/INV_Misc_Food_20', 
					'Interface/ICONS/inv_misc_food_68', 
					'Interface/ICONS/inv_misc_food_37',
					'Interface/ICONS/inv_misc_food_31',
					'Interface/ICONS/inv_misc_food_23'}
local snakeHeadTexture = 'Interface/ICONS/spell_nature_guardianward'
local snakePosition = { [1] = {['x'] = 0, ['y'] = 0} }
local snakeBodyFrames = {}
local maxFood = #foodTexture;
		
local snakeEventFrame = CreateFrame('FRAME', 'Snake_EventFrame')
		
local snakeFrameContainer = CreateFrame("FRAME", "Snake_MainFrameContainer", UI_Parent);
	snakeFrameContainer:SetWidth(300); snakeFrameContainer:SetHeight(320); 
	snakeFrameContainer:SetPoint('CENTER', 0, -10);
	snakeFrameContainer:SetBackdrop({
	bgFile="Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile="Interface/DialogFrame/UI-DialogBox-Border", 
	tile = true, tileSize = 32, edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }})
	snakeFrameContainer:SetBackdropColor(0, 0, 0, 1);
	snakeFrameContainer:SetFrameStrata("HIGH");
	snakeFrameContainer:SetScript("OnMouseDown", snakeFrameContainer.StartMoving);
	snakeFrameContainer:SetScript("OnMouseUp", snakeFrameContainer.StopMovingOrSizing);
	snakeFrameContainer:EnableMouse(true);
	snakeFrameContainer:SetMovable(true);
	snakeFrameContainer:Hide();

local snakeFrameContainerHeader = snakeFrameContainer:CreateTexture()
	snakeFrameContainerHeader:SetWidth(172); snakeFrameContainerHeader:SetHeight(48);
	snakeFrameContainerHeader:SetPoint("TOP", 0, 12);
	snakeFrameContainerHeader:SetTexture("Interface/DialogFrame/UI-DialogBox-Header");
	
local snakeFrameContainerHeaderText = snakeFrameContainer:CreateFontString(nil,"ARTWORK","GameFontNormal");
	snakeFrameContainerHeaderText:SetText('Snake');
	snakeFrameContainerHeaderText:SetPoint("TOP", 0, 3);
	snakeFrameContainerHeaderText:SetTextColor(1, 1, 1);
	
local snakeScoreFrame = CreateFrame("FRAME", "Snake_ScoreFrame", Snake_MainFrameContainer);
	snakeScoreFrame:SetWidth(100); snakeScoreFrame:SetHeight(24);
	snakeScoreFrame:SetPoint("TOPLEFT", 18, -22);
	snakeScoreFrame:SetBackdrop({
	bgFile="Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 32, edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }})
	
local snakeScoreFrameText = snakeScoreFrame:CreateFontString(nil,"ARTWORK","GameFontNormal");
	snakeScoreFrameText:SetText('Score:');
	snakeScoreFrameText:SetPoint("CENTER", -20	, 0);
	snakeScoreFrameText:SetTextColor(1, 1, 0);
	
local snakeScoreFrameScore = snakeScoreFrame:CreateFontString(nil,"ARTWORK","GameFontNormal");
	snakeScoreFrameScore:SetText(totalScore);
	snakeScoreFrameScore:SetPoint("CENTER", 11, 0);
	snakeScoreFrameScore:SetTextColor(1, 1, 1);
		
local snakeFrame = CreateFrame("FRAME", "Snake_MainFrame", Snake_MainFrameContainer);
	snakeFrame:SetWidth(264); snakeFrame:SetHeight(264);
	snakeFrame:SetPoint("CENTER", 0, -18);
	snakeFrame:SetBackdrop({
	bgFile="Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 32, edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }})
	snakeFrame:SetBackdropColor(0, 0, 0, 0.4);	
	snakeFrame:EnableKeyboard();
	
local snakeCloseButton = CreateFrame('BUTTON', 'Snake_CloseButton', Snake_MainFrameContainer);
	snakeCloseButton:SetPoint('TOPRIGHT', 0, 0);
	snakeCloseButton:SetHeight(24); snakeCloseButton:SetWidth(24);
	snakeCloseButton:SetHighlightTexture('Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight');
	snakeCloseButton:SetNormalTexture('Interface/BUTTONS/UI-Panel-MinimizeButton-Up');
	snakeCloseButton:SetScript('OnClick', function(self) snakeFrameContainer:Hide(); snakeEventFrame:SetScript('OnUpdate', nil); end);

local snakeStartButton = CreateFrame('BUTTON', 'Snake_StartButton', Snake_MainFrameContainer, "UIPanelButtonTemplate2");
	snakeStartButton:SetPoint('TOPLEFT', 124, -25);
	snakeStartButton:SetHeight(20); snakeStartButton:SetWidth(70);
	snakeStartButton:SetText('Start');

local function gameStart(action)
	if action == 2 then
		gameState = 2;
		snakeFrame:SetScript('OnkeyDown', function(self, key)
			if key == 'UP' then
				snakeDirection = 'up';
			elseif key == 'RIGHT' then
				snakeDirection = 'right';
			elseif key == 'DOWN' then
				snakeDirection = 'down';
			elseif key == 'LEFT' then
				snakeDirection = 'left';
			end
		end);
		snakeStartButton:SetText('Pause');
		snakeStartButton:SetScript('OnClick', function(self) gameStart(1); end);
	elseif action == 1 then
		gameState = 1;
		snakeFrame:SetScript('OnkeyDown', nil);
		snakeStartButton:SetText('Continue');
		snakeStartButton:SetScript('OnClick', function(self) gameStart(2); end);
	end
end		
	
	
	
local snakePlayerFrame = CreateFrame("FRAME", "Snake_PlayerFrame", Snake_MainFrame);
	snakePlayerFrame:SetWidth(9); snakePlayerFrame:SetHeight(9); 
	snakePlayerFrame:SetPoint('CENTER', snakePosition[1]['x'], snakePosition[1]['y']);	
	snakePlayerFrameTex = snakePlayerFrame:CreateTexture();
	snakePlayerFrameTex:SetTexture(0, 1, 0);
	snakePlayerFrameTex:SetAllPoints(snakePlayerFrame)
	table.insert(snakeBodyFrames, snakePlayerFrame);
	
local snakeFoodFrame = CreateFrame("FRAME", "Snake_FoodFrame", Snake_MainFrame);
	snakeFoodFrame:SetWidth(9); snakeFoodFrame:SetHeight(9); 
	snakeFoodFrameTex = snakeFoodFrame:CreateTexture();
	snakeFoodFrameTex:SetTexture(foodTexture);
	snakeFoodFrameTex:SetAllPoints(snakeFoodFrame)	
	snakeFoodFrameTex:SetTexCoord(0.1, 0.9, 0.1, 0.9);

local snakeGamestate = CreateFrame("FRAME", "Snake_PlayerFrame", Snake_MainFrame);
	snakeGamestate:SetPoint('CENTER', 0, 0);	
	snakeGamestate:SetFrameLevel(129);
	snakeGamestate:Hide();
	snakeGamestateTex = snakeGamestate:CreateTexture();
	snakeGamestateTex:SetTexture('Interface/ICONS/Ability_Rogue_FeignDeath');
	snakeGamestateTex:SetAllPoints(snakeFrame)	
	snakeGamestateTex:SetAlpha(0.35);
	snakeGamestateTex:SetTexCoord(0.1, 0.9, 0.1, 0.9);
	
function placeFood()
	snakeFoodX, snakeFoodY = math.random(-15, 15) * 8, math.random(-15, 15) * 8;
	snakeFoodFrame:SetPoint('CENTER', snakeFoodX, snakeFoodY);
	local rng = math.random(1, maxFood)
	snakeFoodFrameTex:SetTexture(foodTexture[rng]);
end

snakeStartButton:SetScript('OnClick', function(self) gameStart(2); placeFood(); end);
	
local snakeResetButton = CreateFrame('BUTTON', 'Snake_ResetButton', Snake_MainFrameContainer, "UIPanelButtonTemplate2");
	snakeResetButton:SetPoint('TOPLEFT', 200, -25);
	snakeResetButton:SetHeight(20); snakeResetButton:SetWidth(70);
	snakeResetButton:SetText('Reset');
	snakeResetButton:SetScript('OnClick', function(self)
	for k,v in pairs(snakeBodyFrames) do 
		snakeBodyFrames[k]:Hide();
	end; 
	gameState = 0; 
	totalScore = 0;
	snakeScoreFrameScore:SetText(totalScore);
	snakePosition = {};
	snakeDirection = 'right';
	snakePosition = { [1] = {['x'] = 0, ['y'] = 0} }; 
	snakeBodyFrames = {}; 
	snakePlayerFrame:SetPoint('CENTER', snakePosition[1]['x'], snakePosition[1]['y']); 
	snakePlayerFrame:Show();
	snakePlayerFrameTex:SetTexture(0, 1, 0);
	snakePlayerFrameTex:SetAllPoints(snakePlayerFrame)
	table.insert(snakeBodyFrames, snakePlayerFrame);	
	snakeStartButton:SetScript('OnClick', function(self) gameStart(2); end); 
	snakeGamestate:Hide();
	snakePlayerX, snakePlayerY = 0, 0;
	placeFood();
	end);
	
	
function snakeMovement()
		if snakeDirection == 'up' then
			snakePlayerY = snakePosition[1]['y'] + 8;
		elseif snakeDirection == 'right' then
			snakePlayerX = snakePosition[1]['x'] + 8;
		elseif snakeDirection == 'down' then
			snakePlayerY = snakePosition[1]['y'] - 8;
		elseif snakeDirection == 'left' then
			snakePlayerX = snakePosition[1]['x'] - 8;
		else 
			gameState = -1;
			snakeGamestate:Show();
			snakeFrame:SetScript('OnkeyDown', nil);
			return;			
		end
		if snakePlayerY > 120 or snakePlayerY < -120 or snakePlayerX > 120 or snakePlayerX < -120 then
			gameState = -1;
			snakeGamestate:Show();
			snakeFrame:SetScript('OnkeyDown', nil);
			return;
		end	
		table.insert(snakePosition, 1, {['x'] = snakePlayerX, ['y'] = snakePlayerY});
		table.remove(snakePosition);		
		for k, v in pairs(snakePosition) do
			snakeBodyFrames[k]:SetPoint('CENTER', v['x'], v['y']);
			if k ~= 1 and snakePlayerX == v['x'] and snakePlayerY == v['y'] then
				gameState = -1;
				snakeGamestate:Show();
				snakeFrame:SetScript('OnkeyDown', nil);
			elseif k ~= 1 and v['x'] == snakeFoodX and v['y'] == snakeFoodY then
				placeFood();
			end
		end				
end


function snakeGrowth()
	local snakePlayerBodyFrame = CreateFrame("FRAME", nil, Snake_MainFrame);
	snakePlayerBodyFrame:SetWidth(9); snakePlayerBodyFrame:SetHeight(9);
	snakePlayerBodyFrame:SetPoint('CENTER', snakeFoodX, snakeFoodY);	
	snakePlayerBodyFrameTex = snakePlayerBodyFrame:CreateTexture();
	snakePlayerBodyFrameTex:SetTexture(0, 1, 0);
	snakePlayerBodyFrameTex:SetAllPoints(snakePlayerBodyFrame)
	table.insert(snakePosition, {['x'] = snakeFoodX, ['y'] = snakeFoodY});
	table.insert(snakeBodyFrames, snakePlayerBodyFrame);
end

function checkFood()
	if snakePosition[1]['x'] == snakeFoodX and snakePosition[1]['y'] == snakeFoodY then
		snakeGrowth()		
		totalScore = totalScore + 10;
		snakeScoreFrameScore:SetText(totalScore);	
		placeFood();
	end
end

function snake_OnUpdate(self, elapsed)
	if gameState == 2 then
		timeSinceLastUpdate = timeSinceLastUpdate + elapsed;
		if timeSinceLastUpdate > 0.07 then
			checkFood();
			snakeMovement();
			timeSinceLastUpdate = 0;
		end
	elseif gameState == -1 then
		snakeStartButton:SetText('Start');
		snakeStartButton:Disable();
		snakeResetButton:Enable();
	elseif gameState == 0 then
		snakeStartButton:Enable();
		snakeResetButton:Disable();
	end
	
		
end

SLASH_SNAKE1 = '/snake';
SlashCmdList["SNAKE"] = function(msg) if not snakeFrameContainer:IsShown() then snakeFrameContainer:Show(); snakeEventFrame:SetScript('OnUpdate', snake_OnUpdate); elseif snakeFrameContainer:IsShown() then snakeFrameContainer:Hide(); snakeEventFrame:SetScript('OnUpdate', nil); end end;
