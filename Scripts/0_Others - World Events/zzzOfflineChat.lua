
local enabled = true
local messageCount = 0;

function JumpToChat(event, plr, message, channel, language)
	if enabled and plr and message then
		if plr:IsInWorld() then
			--if channel == 1 or channel == 2 or channel == 3 or
				--channel == 4 or channel == 87 or channel == 88 then -- addon talk
			if language ~= -1 and language ~= 4294967295 then
				if channel ~= -1 and channel ~= 7 then -- whisper
					local msg = message:gsub("\\", "\\\\")
					msg = msg:gsub("\'", "\\\'")
					msg = msg:gsub("\"", "\\\"")
					messageCount = messageCount + 1;
					if (messageCount > 30) then
						CharDBQuery("DELETE FROM chat") -- do not truncate
					end
					CharDBQuery("INSERT INTO chat (name, message) VALUES ('[Game] ["..plr:GetName().."]', '"..msg.."')")
				end
			end
		end
	end
end

RegisterServerHook(16, "JumpToChat")

function Check_ToSendMessage()
	if enabled then
		local result = CharDBQuery("SELECT username, message FROM chat_send")
		if result ~= nil then
			for i=1,result:GetRowCount() do
				local message = result:GetColumn(1):GetString()
				if message == "on" or message == "off" then
					SendWorldMessage("|CFF086142[WebChat]|R |CFF18BE00"..result:GetColumn(0):GetString().." "..message, 2)
				else
					SendWorldMessage("|CFF086142[WebChat]|R|CFF18BE00 ["..result:GetColumn(0):GetString().."]: |R|cff40FF40"..message, 2)
					CharDBQuery("INSERT INTO chat (name, message) VALUES ('[Webchat] ["..result:GetColumn(0):GetString().."]', '"..message.."')")
				end
				result:NextRow()
			end
		end
		CharDBQuery("TRUNCATE TABLE chat_send")
	end
end

CreateLuaEvent(Check_ToSendMessage, 1000, 0)

function LoginLogoutLogging(event, plr)
	if enabled then
		if not plr then
			return
		end
		if plr:IsInWorld() then
			if event == 13 then -- logged out
				CharDBQuery("INSERT INTO chat (name, message) VALUES ('[Game] [System]', '"..plr:GetName().." has logged off.')")
			elseif event == 19 then -- logged in
				CreateLuaEvent(function() if (plr and plr:IsInWorld() and plr:GetName()) then CharDBQuery("INSERT INTO chat (name, message) VALUES ('[Game] [System]', '"..tostring(plr:GetName()).." has logged in.')") end end, 2000, 1)
			end
		end
	end
end

RegisterServerHook(13, "LoginLogoutLogging")
RegisterServerHook(19, "LoginLogoutLogging")

function EnableDisableOfflineChat(event, plr, message, type, language)
	if not plr or not message then
		return
	end
	local message = string.lower(message)
	if message == "#disablechat" then
		enabled = false
		plr:SendBroadcastMessage("Disabled offline chat.")
		return false
	elseif message == "#enablechat" then
		enabled = true
		plr:SendBroadcastMessage("Enabled offline chat.")
		return false
	end
end

RegisterServerHook(16, "EnableDisableOfflineChat")
