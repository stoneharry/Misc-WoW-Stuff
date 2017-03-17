local Frame = CreateFrame("FRAME")

Frame:RegisterEvent("PLAYER_ENTERING_WORLD")

function Frame:OnEvent(event)
	JoinChannelByName("WorldChat")
	ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "WorldChat");
end

Frame:SetScript("OnEvent", Frame.OnEvent)