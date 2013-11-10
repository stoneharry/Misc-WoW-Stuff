-- Commented out till finished
--[[
local LG = {Guilds = {}}

function LG.Chat(event, player, message, channel, language)
	if (player:IsGm() and message:lower():sub(1, 6) == "#link ") then
		local arg1 = player:GetSelection()
		if (type(arg1) ~= "userdata" or arg1:GetType() ~= "player") then return 0; end
		arg1 = arg1:GetGuildName();
		if (type(arg1) ~= "string") then return 0; end
		local arg2 = message:sub(7, message:len())
		if (type(arg2) ~= "string") then return 0; end
		if (arg1 == arg2) then return 0; end
		local q1 = CharDBQuery("SELECT guid FROM Guilds WHERE name = "..arg2.." LIMIT 1;")
		if (not q1) then return 0; end
		if (type(LG.Guilds[arg1]) ~= "table") then
			LG.Guilds[arg1] = {}
		end
		if (type(LG.Guilds[arg2]) ~= "table") then
			LG.Guilds[arg2] = {}
		end
		if (LG.Guilds[arg1][arg2] == true) then
			player:SendBroadcastMessage(arg1.." is already linked to "..arg2.."!")
		else
			player:SendBroadcastMessage(arg1.." has been linked to "..arg2.."!")
			LG.Guilds[arg1][arg2] = true
			LG.Guilds[arg2][arg1] = true
			CharDBQuery("INSERT INTO LinkedGuilds (guild1, guild2) VALUES ('"..arg1.."', '"..arg2.."');")
			CharDBQuery("INSERT INTO LinkedGuilds (guild1, guild2) VALUES ('"..arg2.."', '"..arg1.."');")
		end
		return 0
	elseif (player:IsGm() and message:lower():sub(1, 8) == "#unlink ") then
		local arg1 = player:GetSelection()
		if (type(arg1) ~= "userdata" or arg1:GetType() ~= "player") then return 0; end
		arg1 = arg1:GetGuildName();
		if (type(arg1) ~= "string") then return 0; end
		local arg2 = message:sub(9, message:len())
		if (type(arg2) ~= "string") then return 0; end
		if (arg1 == arg2) then return 0; end
		local q1 = CharDBQuery("SELECT guid FROM Guilds WHERE name = "..arg2.." LIMIT 1;")
		if (not q1) then return 0; end
		if (type(LG.Guilds[arg1]) ~= "table") then
			LG.Guilds[arg1] = {}
		end
		if (type(LG.Guilds[arg2]) ~= "table") then
			LG.Guilds[arg2] = {}
		end
		if (LG.Guilds[arg1][arg2] == true) then
			player:SendBroadcastMessage(arg1.." has been unlinked from "..arg2.."!")
			LG.Guilds[arg1][arg2] = false
			LG.Guilds[arg2][arg1] = false
			CharDBQuery("DELETE FROM LinkedGuilds WHERE guild1 = '"..arg1.."' AND guild2 = '"..arg2.."' LIMIT 1;")
			CharDBQuery("DELETE FROM LinkedGuilds WHERE guild1 = '"..arg2.."' AND guild2 = '"..arg1.."' LIMIT 1;")
		else
			player:SendBroadcastMessage(arg1.." is not linked to "..arg2"!")
		end
		return 0
	elseif (channel == 3 and language ~= -1 and player:IsInGuild()) then
		local color = "|cff00CC00"
		local msg = string.format("%s[Linked Guild][%s]: %s|r", color, player:GetName(), message)
		local guild = player:GetGuildName()
		if (type(LG.Guilds[guild]) == "table") then
			for place, plr in pairs (GetPlayersInWorld()) do
				if (plr:IsInGuild() and plr:GetGuildName() ~= guild and
					LG.Guilds[guild][plr:GetGuildName()] == true) then
					plr:SendBroadcastMessage(msg)
				end
			end
		end
	end
end

RegisterServerHook(16, LG.Chat)

--Load linked guilds
do
	local q = CharDBQuery("SELECT guild1, guild2 FROM LinkedGuilds;")
	if (q) then
		for i = 1, q:GetRowCount() do
			local arg1 = q:GetColumn(0):GetString()
			local arg2 = q:GetColumn(1):GetString()
			if (type(LG.Guilds[arg1]) ~= "table") then
				LG.Guilds[arg1] = {}
			end
			LG.Guilds[arg1][arg2] = true
		end
	end
end

]]