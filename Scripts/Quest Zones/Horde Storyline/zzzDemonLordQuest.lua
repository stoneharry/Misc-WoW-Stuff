
local Demon = nil
local Count = 0

--------------------------------------------------------------------------

function OHai_DEMONSEIGTNSIRNHPOSN(pUnit, Event)
	Demon = pUnit
	pUnit:RegisterEvent("zzzzzzzzzzzfgggzKilJaeden_Emote", 50, 1)
	pUnit:SetPhase(24)
end

function zzzzzzzzzzzfgggzKilJaeden_Emote(pUnit, Event)
	pUnit:SetPhase(24)
	pUnit:Emote(449, 10000) -- Spawning Visual
	pUnit:RegisterEvent("zzgzzzzzzzzzzzfgggzKilJaeden_Emote", 10001, 1)
end

function zzgzzzzzzzzzzzfgggzKilJaeden_Emote(pUnit, Event)
	pUnit:CastSpell(42048) -- Visual
	pUnit:SendChatMessage(14, 0, "The extendable have perished, so be it! Now I shall succeed where sargaros could not, I will bleed this wretched world and secure my place as the true master of the burning legion! The end has come! LET THE UNRAVELING OF THIS WORLD COMMENCE!")
	pUnit:PlaySoundToSet(12500)
	pUnit:RegisterEvent("zzzzzzzzzzzfgggzKilJaeden_Emotezdy0saejoigj", 4501, 1)
end

function zzzzzzzzzzzfgggzKilJaeden_Emotezdy0saejoigj(pUnit, Event)
	pUnit:Emote(406, 1000)
	pUnit:RegisterEvent("zzzeaugaeaieguhaegaegzzzzzzzzfgggzKilJaeden_Emotezdy0saejoigj", 1001, 1)
end

function zzzeaugaeaieguhaegaegzzzzzzzzfgggzKilJaeden_Emotezdy0saejoigj(pUnit, Event)
	pUnit:Emote(407, 10000)
	pUnit:RegisterEvent("eauhgieaigz_demonlord_burstfree", 10001, 1)
end

function eauhgieaigz_demonlord_burstfree(pUnit, Event)
	pUnit:Emote(408, 1500)
end

RegisterUnitEvent(253151, 18, "OHai_DEMONSEIGTNSIRNHPOSN")

--------------------------------------------------------------------------

function ouhgeauhyauaKaelSummon_OnGossip(pUnit, event, player)
	pUnit:GossipCreateMenu(738, player, 0)
		if player:HasQuest(1102) == true then
		pUnit:GossipMenuAddItem(9, "Let's get that evidence.", 4, 0)
		end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 3, 0)
	pUnit:GossipSendMenu(player)
end


function ouhgeauhyauaKaelSummon_GossipSubmenus(pUnit, event, player, id, intid, code)
	if(intid == 4) then
	pUnit:SendChatMessage(12, 0, "Let us get the evidence of the demon lords existance. Be careful, you have no idea what sort of evils lie here.")
	pUnit:SetNPCFlags(2)
	Count = 1
	player:GossipComplete()
	end
	if(intid == 3) then
	player:GossipComplete()
	end
end


RegisterUnitGossipEvent(123659, 1, "ouhgeauhyauaKaelSummon_OnGossip")
RegisterUnitGossipEvent(123659, 2, "ouhgeauhyauaKaelSummon_GossipSubmenus")

--------------------------------------------------------------------------

function CONTROLL_TRIGGER_NATURE_DUDE(pUnit, Event)
	pUnit:RegisterEvent("Check_for_Count_ohlawdlawdlawldahoge_count_check", 5000, 0)
end

function Check_for_Count_ohlawdlawdlawldahoge_count_check(pUnit, Event)
	if Count == 1 then
	Count = 0
	pUnit:MoveTo(7824.5, -2571.9, 489.5, 0.072981)
	pUnit:RegisterEvent("aoiewhgouzhoughez_eghishiegiouhziugie", 10000, 1)
	pUnit:RegisterEvent("aoiewhgouzhoughez_eghishiegiouhziugiez",15500, 1)
	pUnit:RegisterEvent("aoiewhgouzhoughez_eghishiegiouhziugiezz",31000, 1)
	end
end

function aoiewhgouzhoughez_eghishiegiouhziugie(pUnit, Event)
	pUnit:FullCastSpell(740)
end

function aoiewhgouzhoughez_eghishiegiouhziugiez(pUnit, Event)
	pUnit:SendChatMessage(12,0,"Something is coming!")
	pUnit:SpawnCreature(253151, 7846.979, -2569.94, 489.3, 3.135149, 35, 0)
	pUnit:RegisterEvent("letsgetbackcontrolofthemessImadetehe",28000, 1)
end

function aoiewhgouzhoughez_eghishiegiouhziugiezz(pUnit, Event)
	pUnit:ChannelSpell(29172, Demon)
	pUnit:SendChatMessage(12,0,"You must destroy anything that comes out of that portal! I'll try my best to gather the evidence while also aiding you.")
end

function letsgetbackcontrolofthemessImadetehe(pUnit, Event)
	pUnit:StopChannel()
	Demon:Emote(402, 1000)
	pUnit:RegisterEvent("esjiesiozejtoija_we_have_control", 1005, 1)
end

function esjiesiozejtoija_we_have_control(pUnit, Event)
	Demon:Emote(403, 60000)
	pUnit:RegisterEvent("Ohlawdlawdlawdlawdlawd_big_dudes", 60000, 1)
	pUnit:SetFaction(2)
	pUnit:SpawnCreature(8717, 7841.34, -2566.19, 489.3, 3.122560, 15, 60000)
	pUnit:SpawnCreature(8717, 7841.7, -2574.4, 489.3, 3.122560, 15, 60000)
	pUnit:RegisterEvent("Spawn_Felgaurd_ohlawlawlawlawlwalwakejg", math.random(8000, 15000), 1)
end

function Spawn_Felgaurd_ohlawlawlawlawlwalwakejg(pUnit, Event)
	pUnit:SpawnCreature(8717, 7841.34, -2566.19, 489.3, 3.122560, 15, 60000)
	pUnit:SpawnCreature(8717, 7841.7, -2574.4, 489.3, 3.122560, 15, 60000)
	if math.random(1,2) == 1 then
	pUnit:CastSpell(35426)
	end
	pUnit:RegisterEvent("Spawn_Felgaurd_ohlawlawlawlawlwalwakejg", math.random(8000, 15000), 1)
end

function Ohlawdlawdlawdlawdlawd_big_dudes(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:MoveTo(Demon:GetX(), Demon:GetY(), Demon:GetZ(), 0)
	Demon:Root()
	Demon:SetFaction(21)
	pUnit:RegisterEvent("Lets_Check_For_Big_Guys_Death_Tehe", 2000, 0)
end

function Lets_Check_For_Big_Guys_Death_Tehe(pUnit, Event)
	if Demon:IsAlive() == true then
		local choicez = math.random(1,5)
		if choicez == 1 then
		Demon:FullCastSpellOnTarget(133, pUnit)
		end
		if choicez == 2 then
		Demon:FullCastSpell(5857)
		end
		if math.random(1,5) == 1 then
		pUnit:FullCastSpellOnTarget(21667, Demon)
		end
	else
	pUnit:SendChatMessage(12,0,"I thank you for your aid... Without you it may have been very hard to defeat him alone. We can only hope that he does not return.")
	pUnit:RemoveEvents()
	Demon:Despawn(13000,0)
	Demon = nil
	pUnit:RegisterEvent("OHai_EAOGJEAPIJGIEPAJHGIEPAJ", 15000, 1)
	end
end

function OHai_EAOGJEAPIJGIEPAJHGIEPAJ(pUnit, Event)
	pUnit:ReturnToSpawnPoint()
	pUnit:SetNPCFlags(3)
	local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plrs in pairs(PlayersAllAround) do
		if plrs:HasQuest(1102) == true then
		plrs:MarkQuestObjectiveAsComplete(1102, 0)
		plrs:SetPhase(4)
		end
	end
end

RegisterUnitEvent(123659, 18, "CONTROLL_TRIGGER_NATURE_DUDE")

--------------------------------------------------------------------------

function FELGUARD_on_spawn(pUnit, Event)
	pUnit:RegisterEvent("FELGUARD_ohlawdlawdlawdlawdlawd_tehe_tehe_infernal_effect", 1000, 1)
end

function FELGUARD_ohlawdlawdlawdlawdlawd_tehe_tehe_infernal_effect(pUnit, Event)
	pUnit:CastSpell(44816) -- transparency
	pUnit:CastSpell(32475) -- hellfire effect
	pUnit:EquipWeapons(24044, 0, 0)
	pUnit:RegisterEvent("FELGUARD_eshgtuhsu_omnomnomnomnom", 2000, 1)
end

function FELGUARD_eshgtuhsu_omnomnomnomnom(pUnit, Event)
	pUnit:SetFaction(21)
	if math.random(1,2) == 1 then
		if math.random(1,2) == 1 then
		pUnit:CastSpell(35426)
		pUnit:SetHealth(pUnit:GetHealth()-100)
		end
	pUnit:MoveTo(7822.9, -2578.1, 489.3, 1)
	else
		if math.random(1,2) == 1 then
		pUnit:CastSpell(35426)
		pUnit:SetHealth(pUnit:GetHealth()-100)
		end
	pUnit:MoveTo(7821.7, -2564.2, 489.3, 1)
	end
end

RegisterUnitEvent(8717, 18, "FELGUARD_on_spawn")

--------------------------------------------------------------------------