local scripts = {}

function AddZoneScript(zone, func)
	--err is defined in "0_Global\Data Values"
	if (err(zone, "number", "AddZoneScript", 1) and err(func, "function", "AddZoneScript", 2)) then
		if (not scripts[zone]) then
			scripts[zone] = {}
		end
		if (not scripts[zone][0]) then
			scripts[zone][0] = func
		else
			error("[PhasingHandler]: Zone "..zone.." already has a script!", 2)
		end
	end
end

function AddAreaScript(zone, area, func)
	if (err(zone, "number", "AddAreaScript", 1) and err(area, "number", "AddAreaScript", 2) and err(func, "function", "AddAreaScript", 3)) then
		if (not scripts[zone]) then
			scripts[zone] = {}
		end
		if (not scripts[zone][area]) then
			scripts[zone][area] = func
		else
			error("[PhasingHandler]: Zone "..zone..", Area "..area.." already has a script!", 2)
		end
	end
end

function ZoneAreaScriptHandler()
	for zone, list in pairs (scripts) do
		local plrs = GetPlayersInZone(zone)
		if (type(plrs) == "table") then
			for _, plr in pairs (plrs) do
				local s = list[0]
				if (s) then
					s(plr)
				end
				s = list[plr:GetAreaId()]
				if (s) then
					s(plr)
				end
			end
		end
	end
end

ZoneAreaScriptHandlerFunc = CreateLuaEvent(ZoneAreaScriptHandler, 5000, 0)

function ZoneScriptHandler(event, player, zone)
	local s = scripts[zone][0]
	if (s) then
		s(player)
	end
end

RegisterServerHook(15, ZoneScriptHandler)
