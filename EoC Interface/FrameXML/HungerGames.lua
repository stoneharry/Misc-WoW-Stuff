local scale = 1
local fading = false
local WELCOME_HUNGERGAMES_TEXT = "Welcome to The Divide!\n\nIn this battleground you are competing against every other player.\nThe objective is to be the last man standing.\n\nYou should go and explore, see what is happening and collect resources.\nUse these resources to forge better items and to gain an advantage.\nUnlock spells by exploring also. When you feel ready, hunt down other\nplayers and kill them for unique and special rewards!\n\nWhen you leave the battleground, your original character will be restored.\n\nGood luck!"

function HGButtonPressed(self)
	fading = true
	self:Disable();
end

function HungerOnUpdate()
	if fading then
		MessageFrameBoxHG.text:SetText("")
		scale = scale - 0.01
		if scale < 0.01 then
			scale = 1
			fading = false
			HungerGames:Hide();
		end
	else
		HungerGamesButton:Enable()
		MessageFrameBoxHG.text:SetText(WELCOME_HUNGERGAMES_TEXT)
	end
	HungerGames:SetAlpha(scale)
	HungerGames:SetScale(scale)
end

function OnLoadOfFrame()
	MessageFrameBoxHG.text = MessageFrameBoxHG:CreateFontString(nil, nil, "GameFontNormal")
	MessageFrameBoxHG.text:SetPoint("LEFT", 40, 50)
	MessageFrameBoxHG.text:SetText(WELCOME_HUNGERGAMES_TEXT)
end