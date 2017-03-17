
local resources = 0
local disabled = {}

function MiniGameEvent(self, event)
	if event == 0 then
		PlaySound("igSpellBookOpen");
		self:Show();
		MinigameFrame:SetFrameStrata("BACKGROUND")
	elseif event == 1 then
		self:Hide();
	end
end

function PurchaseWeakGhoul(self)
	if resources > 4 then
		SendChatMessage("[CU-ADDON] SpawnWeakGhouls", "WHISPER", nil, UnitName("player"))
		self:Disable()
		table.insert(disabled, self)
	end
end

function PurchaseSpellcaster(self)
	if resources > 6 then
		SendChatMessage("[CU-ADDON] SpawnSpellcaster", "WHISPER", nil, UnitName("player"))
		self:Disable()
		table.insert(disabled, self)
	end
end

function PurchaseAbomination(self)
	if resources > 49 then
		SendChatMessage("[CU-ADDON] SpawnAbomination", "WHISPER", nil, UnitName("player"))
		self:Disable()
		table.insert(disabled, self)
	end
end

function PurchaseTurret(self,num)
	if resources > 29 then
		self:Disable()
		if num == 0 then -- R
			SendChatMessage("[CU-ADDON] TurretR", "WHISPER", nil, UnitName("player"))
		else
			SendChatMessage("[CU-ADDON] TurretL", "WHISPER", nil, UnitName("player"))
		end
	end
end

function Upgrade_Unit(self, num)
	if resources > 49 then
		self:Disable()
		if num == 0 then -- upgrade ghouls
			SendChatMessage("[CU-ADDON] UpgradeGhouls", "WHISPER", nil, UnitName("player"))
		else -- upgrade necromancers
			SendChatMessage("[CU-ADDON] UpgradeNecros", "WHISPER", nil, UnitName("player"))
		end
	end
end

function update_all_buttons(self, elapsed)
	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	
	if (self.TimeSinceLastUpdate > 1) then
		for _,v in pairs(disabled) do
			v:Enable()
		end
		self.TimeSinceLastUpdate = 0;
	end
end

ChatFrame_MessageEvnt3 = ChatFrame_MessageEventHandler

function ChatFrame_MessageEventHandler(s,e,arg1,...)
	if arg1 ~= nil then
		if arg1 ~= "" then
			if string.find(arg1, "[CU-ADDON]", 1, true) ~= nil then
				if (arg1 == "[CU-ADDON] OpenMinigame") then
					MiniGameEvent(MinigameFrame, 0);
				elseif (arg1 == "[CU-ADDON] CloseMiniGame") then
					MiniGameEvent(MinigameFrame, 1);
					resources = 0
					PurchaseTurretR:Enable()
					PurchaseTurretL:Enable()
					UpgradeGhouls:Enable()
					UpgradeCasters:Enable()
				elseif (string.find(arg1, "[CU-ADDON] minigame-resources : ", 1, true) ~= nil) then
					local nums = scen_split_2(arg1)
					if #nums == 1 then
						MiniGameResourcesButton.label:SetText("Resources:\n"..nums[1])
						resources = tonumber(nums[1])
					end
				end
				return;
			end
		end
	end
	ChatFrame_MessageEvnt3(s,e,arg1,...)
end

function scen_split_2(str)
	local b = {}
	local c = 1
	local d = {}
	string.gsub(str, "[%d]", function(a)
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