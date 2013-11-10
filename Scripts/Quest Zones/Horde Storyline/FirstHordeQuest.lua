
local phases = {}
local players = {}

function HordeFirstQuest_Check(event, player, quest, pUnit)
	if (quest == 801) then
		local phase = nil
		for i = 1, 31 do
			if (phases[i] == nil or phases[i][1] == nil or not phases[i][1]:IsInWorld()) then
				phases[i] = {player}
				phase = i
				break
			end
		end
		if (phase == nil) then
			pUnit:SendChatMessageToPlayer(42,0,"SERVER-ERROR: Re-take quest.",player)
			return
		end
		player:SetValue("currentQuest", 801)
		player:SetValue("phase", phase)
		player:SetValue("stage", 0)
		player:SetValue("unit", pUnit)
		player:SetPhase(2^phase)
		table.insert(players, {player, phase})
	end
end

RegisterServerHook(14, "HordeFirstQuest_Check")

function EventsHappen_HQ1()
	for k, tbl in pairs (players) do
		local player = tbl[1]
		if type(player) == "userdata" and player:GetObjectType() == "Player" then
			local pUnit = player:GetValue("unit")
			if (pUnit) then
				local stage = player:ModValue("stage", 1)
				if stage == 1 then
					pUnit:SendChatMessageToPlayer(12,0,"You must demonstrate that you are still capable of serving the Horde, "..player:GetName()..".", player)
					pUnit:Emote(1,0)
				elseif stage == 4 then
					pUnit:SendChatMessageToPlayer(12,0,"Demonstrate to me that you still have the skill assets we need in the Horde. Attack that training dummy over yonder with your best ability!", player)
					pUnit:Emote(5,0)
					pUnit:SpawnCreature(280481, -6376, -1958, 251, 0.8877456, 15, 360000, 0,0,0, player:GetPhase())
				elseif stage == 5 then
					if player:GetQuestObjectiveCompletion(801, 0) ~= 3 then
						player:ModValue("stage", -1)
					end
				elseif stage == 6 then
					pUnit:SendChatMessageToPlayer(12,0,"You have demonstrated that you do indeed have arms and legs. But now you must defeat something that actually moves.", player)
					pUnit:Emote(1,0)
				elseif stage == 9 then
					pUnit:GetCreatureNearestCoords(-6376, -1958, 251, 280481):Despawn(1,0)
					local npc = pUnit:GetCreatureNearestCoords(-6371.5, -1949.66, 251, 45632)
					if npc then
						npc:SendChatMessageToPlayer(12,0,"You wish me to do battle, captain?", player)
					end
				elseif stage == 10 then
					pUnit:SendChatMessageToPlayer(12,0,"No, I have something better in mind...", player)
					pUnit:Emote(6,0)
				elseif stage == 12 then
					pUnit:SendChatMessageToPlayer(14,0,"Three against one!", player)
					pUnit:Emote(4,0)
					local phase = player:GetPhase()
					player:SetValue("Npc1", pUnit:SpawnCreature(45633, -6386, -1964, 251.5, 0.842116, 35, 0, 24394, 0, 0, phase))
					player:SetValue("Npc2", pUnit:SpawnCreature(45633, -6383, -1966, 251.5, 0.853897, 35, 0, 24394, 0, 0, phase))
					player:SetValue("Npc3", pUnit:SpawnCreature(45633, -6381, -1968, 251.5, 0.920656, 35, 0, 24394, 0, 0, phase))
				elseif stage == 13 then
					player:GetValue("Npc1"):SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
					player:GetValue("Npc2"):SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
					player:GetValue("Npc3"):SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
					player:GetValue("Npc1"):SetMovementFlags(1)
					player:GetValue("Npc2"):SetMovementFlags(1)
					player:GetValue("Npc3"):SetMovementFlags(1)
					player:GetValue("Npc1"):MoveTo(-6377, -1951, 250.8, 0.485546)
					player:GetValue("Npc2"):MoveTo(-6373, -1954, 250.8, 0.846829)
					player:GetValue("Npc3"):MoveTo(-6370, -1957, 250.8, 1.373046)
				elseif stage == 16 then
					player:GetValue("Npc1"):SetFaction(21)
					player:GetValue("Npc2"):SetFaction(21)
					player:GetValue("Npc3"):SetFaction(21)
				elseif stage == 17 then
					if player:GetHealthPct() < 80 then
						player:SetHealth(player:GetMaxHealth())
					end
					local count = 0
					local npc = player:GetValue("Npc1")
					if npc then
						if npc:GetHealthPct() < 60 and npc:GetFaction() == 21 then
							npc:SendChatMessageToPlayer(12,0,"I cannot fight on.", player)
							npc:SetFaction(35)
							npc:DisableCombat(true)
							npc:Root()
							npc:Despawn(5000, 1)
							player:SetValue("Npc1", nil)
						end
					else
						count = count + 1
					end
					npc = player:GetValue("Npc2")
					if npc then
						if npc:GetHealthPct() < 60 and npc:GetFaction() == 21 then
							npc:SendChatMessageToPlayer(12,0,"A good battle.", player)
							npc:SetFaction(35)
							npc:DisableCombat(true)
							npc:Root()
							npc:Despawn(5000, 1)
							player:SetValue("Npc2", nil)
						end
					else
						count = count + 1
					end
					npc = player:GetValue("Npc3")
					if npc then
						if npc:GetHealthPct() < 60 and npc:GetFaction() == 21 then
							npc:SendChatMessageToPlayer(12,0,"This cannot be!", player)
							npc:SetFaction(35)
							npc:DisableCombat(true)
							npc:Root()
							npc:Despawn(5000, 1)
							player:SetValue("Npc3", nil)
						end
					else
						count = count + 1
					end
					if count ~= 3 then
						player:ModValue("stage", -1)
					end
				elseif stage == 18 then
					player:AdvanceQuestObjective(801, 1)
					pUnit:SendChatMessageToPlayer(12,0,"You have done well. I have just one challenge left for you.", player)
					pUnit:Emote(1,0)
				elseif stage == 20 then
					pUnit:SendChatMessageToPlayer(12,0,"Bring in my favourite. Let us see how long this initiate will last against him!")
					pUnit:Emote(1,0)
					player:SetValue("Npc1", pUnit:SpawnCreature(190221, -6383.8, -1966, 251.5, 0.843353, 35, 360000, 37812, 0, 0, player:GetPhase()))
				elseif stage == 21 then
					local npc = player:GetValue("Npc1")
					npc:MoveTo(-6374, -1955, 250.8, 0.865344)
					npc:SetUInt32Value(UNIT_FIELD_BYTES_2, 1)
				elseif stage == 22 then
					player:GetValue("Npc1"):SendChatMessageToPlayer(12,0,"You summoned me, captain?", player)
				elseif stage == 24 then
					pUnit:Emote(1,0)
					pUnit:SendChatMessageToPlayer(12,0,"Champion, I want you to show this initiate how the Horde do battle.", player)
				elseif stage == 26 then
					player:GetValue("Npc1"):Emote(2,0)
				elseif stage == 28 then
					player:GetValue("Npc1"):SetFaction(21)
				elseif stage == 29 then
					local count = 0
					local npc = player:GetValue("Npc1")
					if player:GetHealthPct() < 80 then
						player:SetHealth(player:GetMaxHealth())
					end
					if npc then
						if npc:IsDead() then
							pUnit:SendChatMessageToPlayer(12,0,"...You were not supposed to kill him.", player)
							pUnit:Emote(21,0)
							player:AdvanceQuestObjective(801,2)
							npc:Despawn(5000, 1)
							player:SetValue("Npc1", nil)
						else
							if npc:GetHealthPct() < 60 and npc:HasAura(61369) == false then
								npc:CastSpell(61369) -- enrage
							end
						end
					else
						count = count + 1
					end
					if count ~= 1 then
						player:ModValue("stage", -1)
					end
				end
			end
		end
	end
end

CreateLuaEvent(EventsHappen_HQ1, 2000, 0)

function CheckForValidPlayers_HQ1()
	local removed = {}
	for k, tbl in pairs (players) do
		local player = tbl[1]
		if (not player or not player:IsInWorld() or not player:HasQuest(801)) then
			table.remove(phases, tbl[2])
			table.insert(removed, k)
		end
	end
	for k, v in pairs (removed) do
		table.remove(players, v)
	end
end

CreateLuaEvent(CheckForValidPlayers_HQ1, 30000, 0)

function Horde_SpellCast_Intro(event, plr, SpellId, pSpellObject)
	if plr:HasQuest(801) then
		local amount = plr:GetQuestObjectiveCompletion(801, 0)
		if amount ~= 3 then
			plr:AdvanceQuestObjective(801, 0)
			local pUnit = plr:GetCreatureNearestCoords(-6368.1, -1947.8, 251.1, 27751)
			if pUnit then
				if amount == 0 then
					pUnit:SendChatMessageToPlayer(12,0,"A fine blow!", plr)
					pUnit:Emote(1,0)
				elseif amount == 1 then
					pUnit:SendChatMessageToPlayer(12,0,"You can do better than that.", plr)
					pUnit:Emote(1,0)
				elseif amount == 2 then
					pUnit:SendChatMessageToPlayer(14,0,"Finish it!", plr)
					pUnit:Emote(5,0)
				end
			end
		end
	end
end

RegisterServerHook(10, "Horde_SpellCast_Intro")
