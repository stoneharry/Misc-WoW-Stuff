
local Zog = nil
local Started = 0

-- Invisible Trigger Npc

function Aotyoihaohgeoea_invis_trigger(pUnit, Event)
	pUnit:SetPhase(2)
	pUnit:RegisterEvent("ejpgtijaephig_stuff_fivesconds", 3000, 1)
end

RegisterUnitEvent(151519, 18, "Aotyoihaohgeoea_invis_trigger")

-- General Zog

function aeigheapoihgpa_Zog_onspawn(pUnit, Event)
	pUnit:RegisterEvent("eaiehaoyheoahyoauyhohoauhojhuieoaheaheoauheoa", 2500, 1)
end

function eaiehaoyheoahyoauyhohoauhojhuieoaheaheoauheoa(pUnit, Event)
	Zog = pUnit
end

RegisterUnitEvent(155391, 18, "aeigheapoihgpa_Zog_onspawn")

-- Controll trigger npc

function ejpgtijaephig_stuff_fivesconds(pUnit, Event)
	pUnit:SetPhase(2)
	--local Zog = pUnit:GetCreatureNearestCoords(-7221.1, -1694.9899, 313.096008, 155391)
	if Zog == nil then
	pUnit:Despawn(1,0)
	else
		if Started == 0 then
		Started = 1
		Zog:SendChatMessage(14,0,"The Alliance are coming! Get Ready!")
		Zog:Emote(5, 2000)
		Zog:PlaySoundToSet(6077)
		pUnit:RegisterEvent("Alliance_spawns_attack_Squad_gogogo", 5000, 0)
		pUnit:RegisterEvent("Alliance_spawns_attack_Squad_gogogo_z", 30005, 1)
		else
		pUnit:Despawn(1,0)
		end
	end
end

function Alliance_spawns_attack_Squad_gogogo(pUnit, Event)
	if Zog:GetHealthPct() < 20 then
	Zog:CastSpell(69693)
	end
		if math.random(1,2) == 1 then
		pUnit:SpawnCreature(151081, -7195, -1935, 320, 4.438823, 35, 30000)
		else
		pUnit:SpawnCreature(151081, -7195, -1935, 320, 4.438823, 35, 30000)
		pUnit:SpawnCreature(151081, -7195, -1935, 320, 4.438823, 35, 30000)
		end
end

function Alliance_spawns_attack_Squad_gogogo_z(pUnit, Event)
	pUnit:RemoveEvents()
	if Zog ~= nil then
		Zog:SendChatMessage(14,0,"That is half of them dead!")
		Zog:PlaySoundToSet(8573)
	end
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		if plr:HasQuest(812) == true then
		plr:SetPhase(6)
		end
	end
	pUnit:RegisterEvent("Alliance_spawns_attack_Squad_gogogo", 5000, 0)
	pUnit:RegisterEvent("Alliance_spawns_attack_Squad_gogogo_sound", 6000, 0)
	pUnit:RegisterEvent("Alliance_spawns_attack_Squad_gogogo_zz", 30005, 1)
end

function Alliance_spawns_attack_Squad_gogogo_sound(pUnit, Event)
	local choice = math.random(1,4)
	if choice == 1 then
	Zog:PlaySoundToSet(14560)
	end
	if choice == 2 then
	Zog:PlaySoundToSet(14564)
	end
	if choice == 3 then
	Zog:PlaySoundToSet(14561)
	end
	if choice == 4 then
	Zog:PlaySoundToSet(14566)
	end
end

function Alliance_spawns_attack_Squad_gogogo_zz(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("eaipohgeahaohgoau_alliance_spawns_attack_dead", 5000, 1)
end

function eaipohgeahaohgoau_alliance_spawns_attack_dead(pUnit, Event)
	if Zog ~= nil then
		Zog:PlaySoundToSet(8454)
		Zog:SendChatMessage(14,0,"They're all dead! Victory!")
	end
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
		if plr:HasQuest(812) == true then
		plr:MarkQuestObjectiveAsComplete(812, 0)
		end
	end
	Started = 0
	pUnit:Despawn(1,0)
end

-- Alliance on spawn

function Alliance_squad_attacking_onspawn(pUnit, Event)
	pUnit:RegisterEvent("delay_for_slackers_XD", 1000, 1)
end

function delay_for_slackers_XD(pUnit, Event)
	pUnit:SetFaction(1)
	pUnit:SetPhase(2)
	pUnit:SetMovementFlags(1)
	pUnit:EquipWeapons(1482,6320,0)
	if math.random(1,2) == 1 then
	pUnit:MoveTo(-7198, -1964, 313, 2.811485)
	else
	pUnit:MoveTo(-7205, -1968, 312, 2.850754)
	end
	pUnit:RegisterEvent("LetsMoveIntoTheActualBase_Squad", 4000, 1)
end

function LetsMoveIntoTheActualBase_Squad(pUnit, Event)
	if math.random(1,6) == 3 then
	pUnit:SendChatMessage(14, 0, "For the Alliance!")
	else
		if math.random(1,6) == 4 then
		pUnit:SendChatMessage(14, 0, "The Horde shall fall!")
		end
	end
	if pUnit:IsInCombat() == false then
		pUnit:SetMovementFlags(1)
		if math.random(1,2) == 1 then
		pUnit:MoveTo(-7217, -1960, 314, 2.744725)
		else
		pUnit:MoveTo(-7218, -1963, 313, 2.811484)
		end
	end
end

RegisterUnitEvent(151081, 18, "Alliance_squad_attacking_onspawn")
