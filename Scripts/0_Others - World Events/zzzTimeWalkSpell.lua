TimeWalk = {}

TimeWalk_V = {}

TimeWalk_P = {}

TimeWalk_Form = {}

CooldownMirrorTime = {}
ClickMirrorPrevent = {}

local Spell = 111
local MAX_AURAS = 50 -- Change this to the amount of auras you want to revert the player to having.

-- Rounding Numbers
-- example: roundNum(5.6)
function roundNum(val, decimal)
	if (decimal) then
		return math.floor(((val * 10^decimal) + 0.5) / (10^decimal))
	else
		return math.floor(val+0.5)
	end
end

function TimeWalk.MainScript(event, player, spellid)
	--if player:GetLevel() == 20 then
	if spellid == 69939 then
		--[[if ClickMirrorPrevent[player:GetName()] == "clicked" and ((os.clock()-CooldownMirrorTime[player:GetName()])) <= 300000 then
			local num = (os.clock()-CooldownMirrorTime[player:GetName()])
			num = num*1000
			num = 300000-num
			num = num/60000
			player:SendBroadcastMessage("|cFFFF0000You need to wait "..num.." more minutes.")
			num = roundNum(num, 2)
			if num == 0 then
				player:SendAreaTriggerMessage("|cFFFF0000You need to wait less than a minute more.")
			else
				player:SendAreaTriggerMessage("|cFFFF0000You need to wait "..num.." more minutes.")
			end
		else]]
		--	ClickMirrorPrevent[player:GetName()] = "clicked"
		--	CooldownMirrorTime[player:GetName()] = os.clock()
			player:CastSpell(58834)
			local creature = player:GetCreatureNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 31216)
			if creature ~= nil then
				creature:SetHealth((player:GetHealth()*0.5))
				creature:SetMaxHealth((player:GetHealth()*0.5))
			end
		--end
	end
		if (spellid == Spell) then
			if player:HasAura(Spell) then
				-- do nothing
			else
				player:CastSpell(50805)
				TimeWalk_V[player:GetName()] = {}
				TimeWalk_V[player:GetName()].map = player:GetMapId()
				TimeWalk_V[player:GetName()].x = player:GetX()
				TimeWalk_V[player:GetName()].y = player:GetY()
				TimeWalk_V[player:GetName()].z = player:GetZ()
				TimeWalk_V[player:GetName()].o = player:GetO()
				TimeWalk_P[player:GetName()] = {}
				TimeWalk_P[player:GetName()].hp = player:GetHealth()
				TimeWalk_P[player:GetName()].auras = TimeWalk.GetAuras(player)
				TimeWalk_Form[player:GetName()] = {
				Dire = 9634,
				Bear = 5487,
				Cat = 768,
				Life = 33891,
				Moonkin = 24858,
				Travel = 783,
				Aqua = 1066,
				Swift = 40120,
				Flight = 33943,
				Stealth = 1784,
				Vanish = 26889
				}
				if player:GetPlayerClass() == "Warrior" then
					TimeWalk_P[player:GetName()].rage = player:GetPower(1)
				elseif player:GetPlayerClass() == "Rogue" then
					TimeWalk_P[player:GetName()].energy = player:GetPower(3)
				elseif player:GetPlayerClass() == "Death Knight" then
					TimeWalk_P[player:GetName()].runes = player:GetPower(5)
					TimeWalk_P[player:GetName()].runepower = player:GetPower(6)
				elseif player:GetPlayerClass() == "Druid" then
					if player:HasAura(TimeWalk_Form[player:GetName()].Dire) then
						TimeWalk_P[player:GetName()].rage = player:GetPower(1)
						TimeWalk_Form[player:GetName()].save = TimeWalk_Form[player:GetName()].Dire
					elseif player:HasAura(TimeWalk_Form[player:GetName()].Bear) then
						TimeWalk_P[player:GetName()].rage = player:GetPower(1)
						TimeWalk_Form[player:GetName()].save = TimeWalk_Form[player:GetName()].Bear
					elseif player:HasAura(TimeWalk_Form[player:GetName()].Cat) then
						TimeWalk_P[player:GetName()].energy = player:GetPower(3)
						TimeWalk_Form[player:GetName()].save = TimeWalk_Form[player:GetName()].Cat
					elseif player:HasAura(TimeWalk_Form[player:GetName()].Life) then
						TimeWalk_P[player:GetName()].mana = player:GetPower(0)
						TimeWalk_Form[player:GetName()].save = TimeWalk_Form[player:GetName()].Life
					elseif player:HasAura(TimeWalk_Form[player:GetName()].Moonkin) then
						TimeWalk_P[player:GetName()].mana = player:GetPower(0)
						TimeWalk_Form[player:GetName()].save = TimeWalk_Form[player:GetName()].Moonkin
					elseif player:HasAura(TimeWalk_Form[player:GetName()].Travel) then
						TimeWalk_P[player:GetName()].mana = player:GetPower(0)
						TimeWalk_Form[player:GetName()].save = TimeWalk_Form[player:GetName()].Travel
					elseif player:HasAura(TimeWalk_Form[player:GetName()].Aqua) then
						TimeWalk_P[player:GetName()].mana = player:GetPower(0)
						TimeWalk_Form[player:GetName()].save = TimeWalk_Form[player:GetName()].Aqua
					elseif player:HasAura(TimeWalk_Form[player:GetName()].Swift) then
						TimeWalk_P[player:GetName()].mana = player:GetPower(0)
						TimeWalk_Form[player:GetName()].save = TimeWalk_Form[player:GetName()].Swift
					elseif player:HasAura(TimeWalk_Form[player:GetName()].Flight) then
						TimeWalk_P[player:GetName()].mana = player:GetPower(0)
						TimeWalk_Form[player:GetName()].save = TimeWalk_Form[player:GetName()].Flight
					else
						TimeWalk_P[player:GetName()].mana = player:GetPower(0)
						TimeWalk_Form[player:GetName()].save = 0
					end
				elseif player:GetPlayerClass() == "Mage" or "Priest" or "Warlock" or "Paladin" or "Shaman" or "Hunter" then
					TimeWalk_P[player:GetName()].mana = player:GetPower(0)
				end
				RegisterTimedEvent("TimeWalk.TeleportVisual", 10000, 1, player)
			end
		end
	--end
end

function TimeWalk.TeleportVisual(player, Event)
    if player:HasAura(Spell) then
        player:CastSpell(50805)
	    RegisterTimedEvent("TimeWalk.Teleport", 100, 1, player)
	end
end

function TimeWalk.Teleport(player, Event)
    if player:HasAura(Spell) then
        player:Teleport(TimeWalk_V[player:GetName()].map, TimeWalk_V[player:GetName()].x, TimeWalk_V[player:GetName()].y, TimeWalk_V[player:GetName()].z)
        player:SetFacing(TimeWalk_V[player:GetName()].o)
        player:SetHealth(TimeWalk_P[player:GetName()].hp)
		TimeWalk.SetAuras(player, TimeWalk_P[player:GetName()].auras)
		if player:GetPlayerClass() == "Warrior" then
            player:SetPower(TimeWalk_P[player:GetName()].rage, 1)
		elseif player:GetPlayerClass() == "Rogue" then
		    player:SetPower(TimeWalk_P[player:GetName()].energy, 3)
		elseif player:GetPlayerClass() == "Death Knight" then
		    player:SetPower(TimeWalk_P[player:GetName()].runes, 5)
			player:SetPower(TimeWalk_P[player:GetName()].runepower, 6)
		elseif player:GetPlayerClass() == "Druid" then
		    player:RemoveAura(TimeWalk_Form[player:GetName()].Dire)
			player:RemoveAura(TimeWalk_Form[player:GetName()].Bear)
			player:RemoveAura(TimeWalk_Form[player:GetName()].Cat)
			player:RemoveAura(TimeWalk_Form[player:GetName()].Life)
			player:RemoveAura(TimeWalk_Form[player:GetName()].Moonkin)
			player:RemoveAura(TimeWalk_Form[player:GetName()].Travel)
			player:RemoveAura(TimeWalk_Form[player:GetName()].Aqua)
			player:RemoveAura(TimeWalk_Form[player:GetName()].Swift)
			player:RemoveAura(TimeWalk_Form[player:GetName()].Flight)
		    player:CastSpell(TimeWalk_Form[player:GetName()].save)
			if player:HasAura(TimeWalk_Form[player:GetName()].Dire) or player:HasAura(TimeWalk_Form[player:GetName()].Bear) then
			    player:SetPower(TimeWalk_P[player:GetName()].rage, 1)
			elseif player:HasAura(TimeWalk_Form[player:GetName()].Cat) then
			    player:SetPower(TimeWalk_P[player:GetName()].energy, 3)
			elseif player:HasAura(TimeWalk_Form[player:GetName()].Life) or player:HasAura(TimeWalk_Form[player:GetName()].Moonkin) or player:HasAura(TimeWalk_Form[player:GetName()].Travel) or player:HasAura(TimeWalk_Form[player:GetName()].Aqua) or  player:HasAura(TimeWalk_Form[player:GetName()].Swift) or player:HasAura(TimeWalk_Form[player:GetName()].Flight) then
			    player:SetPower(TimeWalk_P[player:GetName()].mana, 0)
			else
			    player:SetPower(TimeTalk_P[player:GetName()].mana, 0)
			end
		elseif player:GetPlayerClass() == "Mage" or "Priest" or "Warlock" or "Paladin" or "Shaman" or "Hunter" then
		    player:SetPower(TimeWalk_P[player:GetName()].mana, 0)
		end
	end
end
RegisterServerHook(10, "TimeWalk.MainScript")

function TimeWalk.GetAuras(pPlayer)
	local auras = {}
	for i=1-1, 140 do -- We do 1-1 since the aura range is 0 - 140.
		if (auras[i] == nil) then
			if (pPlayer:GetAuraObject(i)) then
				auras[i] = {}
				auras[i].id = pPlayer:GetAuraObject(i):GetSpellId()
				auras[i].dur = pPlayer:GetAuraObject(i):GetTimeLeft()
				auras[i].stacks = pPlayer:GetAuraStackCount(i)
			end
		end
	end
	return auras
end

function TimeWalk.SetAuras(pPlayer, auras)
	assert(type(auras) == "table", "Bad argument #2 to SetAuras - expected table, got "..type(auras))
	for _, v in ipairs(auras) do
		if (pPlayer:IsInWorld()) then
			pPlayer:AddAura(v["id"], v["dur"], false)
		else
			return
		end
	end
end

