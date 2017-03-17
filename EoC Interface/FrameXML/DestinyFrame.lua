
CHOOSE_FACTION = "Choose your faction.";
THE_ALLIANCE = "The Alliance";
THE_HORDE = "The Horde";
CHOOSE_THE_ALLIANCE = "THE ALLIANCE";
CHOOSE_THE_HORDE = "THE HORDE";
ALLIANCE_CHEER = "The noble races of the Alliance are bound together by traditions of nobility, honor, faith,justice, and sacrifice. \n\n\n\n Take up their banner to represent the high ideals of the Alliance throughout Azeroth and beyond.\n\n For the Alliance!";
HORDE_CHEER = "The proud nations of the Horde are loosely joined in an alliance of convenience against a hostile world that would see them destroyed.\n\nThe Horde values strength and honor.\n\nJoin the Horde and fight to build a world where their people can live free.\n\n For the Horde!";
CHOOSE_FACTION = "Choose your faction.";
JOIN_THE_ALLIANCE = "Join The Alliance";
JOIN_THE_HORDE = "Join The Horde";

function DestinyFrame_OnEvent(self, event)
	PlaySound("igSpellBookOpen");
	-- does not work in 3.3.5a client
	--MoveForwardStop();	-- in case the player was moving, need to check if it'll work in blizzcon build
	self:Show();
end

ChatFrame_MessageEventHandler2 = ChatFrame_MessageEventHandler

function ChatFrame_MessageEventHandler(s,e,arg1,...)
	if arg1 ~= nil then
		if arg1 ~= "" then
			if string.find(arg1, "[CU-ADDON]", 1, true) ~= nil then
				if (arg1 == "[CU-ADDON] OpenMenuFactionChoose") then
					DestinyFrame_OnEvent(DestinyFrame, 0);
				end
				return;
			elseif string.find(arg1, "[EoC-Addon]", 1, true) ~= nil then
				if (arg1 == "[EoC-Addon] HungerGamesOpen") then
					HungerGames:Show()
					return
				elseif (arg1 == "[EoC-Addon] TESTTESTTEST") then
					rick_test()
					return
				elseif (arg1 == "[EoC-Addon] OpenTransmog") then
					TransmogrifyFrame_Show()
					return
				end
				--if not e == "CHAT_MSG_WHISPER" then
					local i = 0;
					local scen_table = scen_split(arg1)
					if not scen_table then
						return
					end
					for _,token in pairs(scen_table) do
						if i == 2 then
							scen_name = token;
						elseif i == 3 then
							scen_currentStage = tonumber(token);
						elseif i == 4 then
							scen_numStages = tonumber(token);
						elseif i == 5 then
							scen_stageName = token;
						elseif i == 6 then
							scen_stageDescription = token;
						end
						i = i + 1;
					end
					LevelUpDisplay.type = LEVEL_UP_TYPE_SCENARIO;
					LevelUpDisplay:Show();
				--	return
				--end
				return
			end
		end
	end
	ChatFrame_MessageEventHandler2(s,e,arg1,...)
end

function scen_split(str)
	local b = {}
	local c = 1
	local d = {}
	string.gsub(str, "[%w%s-]", function(a)
		if (a == "-") then
			c = c + 1
		else
			if (not b[c]) then
				b[c] = {}
			end
			table.insert(b[c], a)
		end
	end)
	for k, v in pairs (b) do
		table.insert(d, table.concat(v))
	end
	return d
end