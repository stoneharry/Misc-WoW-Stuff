--[[ Warlocks try to revive a Eredar lord! oh noes! ]]--

local EredarLord
local Netherkurse
local NetherkurseWarlock1
local NetherkurseWarlock2
local Modera

-- Eredar Lord

function EredarLord_OnSpawn(pUnit, Event)
 EredarLord = pUnit
 pUnit:RegisterEvent("EredarLord_ReSpell", 2000, 1)
end

function EredarLord_ReSpell(pUnit, Event)
 pUnit:CastSpell(43395)
 pUnit:RegisterEvent("EredarLord_ReSpell", 40000, 1)
end

RegisterUnitEvent(50026, 18, "EredarLord_OnSpawn")

-- Netherkurse

function Netherkurse_OnSpawn(pUnit, Event)
 Netherkurse = pUnit
 pUnit:RegisterEvent("Netherkurse_Spell", 2000, 1)
end

function Netherkurse_Spell(pUnit, Event)
 if EredarLord ~= nil then
  pUnit:ChannelSpell(35996, EredarLord)
 end
end

RegisterUnitEvent(50024, 18, "Netherkurse_OnSpawn")

-- Warlock 1

function NetherkurseWarlock1_OnSpawn(pUnit, Event)
 NetherkurseWarlock1 = pUnit
 pUnit:RegisterEvent("NetherkurseWarlock1_Spell", 2000, 1)
end

function NetherkurseWarlock1_Spell(pUnit, Event)
 pUnit:Root()
 if EredarLord ~= nil and Netherkurse ~= nil then
  pUnit:ChannelSpell(31902, EredarLord)
  Netherkurse:ChannelSpell(35996, EredarLord)
 end
end

RegisterUnitEvent(50029, 18, "NetherkurseWarlock1_OnSpawn")



-- Warlock 2

function NetherkurseWarlock2_OnSpawn(pUnit, Event)
 NetherkurseWarlock2 = pUnit
 pUnit:RegisterEvent("NetherkurseWarlock2_Spell", 2000, 1)
end

function NetherkurseWarlock2_Spell(pUnit, Event)
 pUnit:Root()
 if EredarLord ~= nil then
  pUnit:ChannelSpell(31902, EredarLord)
 end
end

RegisterUnitEvent(50030, 18, "NetherkurseWarlock2_OnSpawn")

----------------------------------------------------------------------

--[[ Netherkurse vs Archmade Modera ]]--

function ArchmageModera_OnGossip(pUnit, event, player)
	if player:HasQuest(23) == true then
		pUnit:GossipCreateMenu(62421, player, 0)
		pUnit:GossipMenuAddItem(9, "Archmage Modera, we are ready to face Netherkurse.", 9, 0)
		pUnit:GossipMenuAddItem(0, "Nevermind.", 3, 0)
		pUnit:GossipSendMenu(player)
	end
end



function ArchmageModera_GossipSubmenus(pUnit, event, player, id, intid, code)
	if(intid == 9) then
		pUnit:RegisterEvent("ArchmageModera_Move", 1, 1)
		pUnit:SendChatMessage(12, 0, "Let's do this.")
		pUnit:SetNPCFlags(2)
		player:GossipComplete()
	end

	if(intid == 3) then
		player:GossipComplete()
	end
end



function ArchmageModera_OnSpawn(pUnit, Event)
 Modera = pUnit
end


RegisterUnitGossipEvent(50033, 1, "ArchmageModera_OnGossip")
RegisterUnitGossipEvent(50033, 2, "ArchmageModera_GossipSubmenus")


----------------------------------------------------------------------


function ArchmageModera_Move(pUnit, Event)
 pUnit:CastSpell(18100)
 pUnit:RegisterEvent("ArchmageModera_MoveTo1", 1500, 1)
end

function ArchmageModera_MoveTo1(pUnit, Event)
 pUnit:MoveTo(-7966, -2413, 126.954194, 1.95)
 pUnit:RegisterEvent("ArchmageModera_MoveTo2", 3000, 1)
end

function ArchmageModera_MoveTo2(pUnit, Event)
 pUnit:MoveTo(-7987, -2408, 123.866623, 1.61)
 pUnit:RegisterEvent("ArchmageModera_MoveTo3", 5500, 1)
end

function ArchmageModera_MoveTo3(pUnit, Event)
 pUnit:MoveTo(-7987, -2391, 123.27, 1.62)
 pUnit:RegisterEvent("ArchmageModera_Start", 5500, 1)
end

function ArchmageModera_Start(pUnit, Event)
 Netherkurse:StopChannel()
 pUnit:Emote(1, 6000)
 pUnit:SendChatMessage(12, 0, "Grand Warlock Netherkurse! You are outnumbered. Stop your spells and call your minions down.")
 Netherkurse:RegisterEvent("Netherkurse_Start", 8000, 1)
end


function Netherkurse_Start(pUnit, Event)
 pUnit:SetFacing(4.669)
 pUnit:Emote(1, 2000)
 pUnit:SendChatMessage(12, 0, "You don't understand this power... you will all die.")
 Modera:RegisterEvent("ArchmageModera_Answer", 5500, 1)
end

function ArchmageModera_Answer(pUnit, Event)
 pUnit:ChannelSpell(40447, Netherkurse)
 pUnit:SendChatMessage(14, 0, "No, Netherkurse - it is you who shall die today!")
 Netherkurse:RegisterEvent("Netherkurse_Answer", 4000, 1)
end

function Netherkurse_Answer(pUnit, Event)
 pUnit:Emote(1, 2000)
 pUnit:SendChatMessage(14, 0, "Minions! Assist me.")
 pUnit:RegisterEvent("NetherkurseWarlocks_Start", 1000, 1)
end

function NetherkurseWarlocks_Start(pUnit, Event)
 NetherkurseWarlock1:ChannelSpell(28078, Netherkurse)
 NetherkurseWarlock2:ChannelSpell(28078, Netherkurse)
 NetherkurseWarlock1:SetFaction(14)
 NetherkurseWarlock2:SetFaction(14)
 NetherkurseWarlock1:DisableCombat(true)
 NetherkurseWarlock2:DisableCombat(true)
 Netherkurse:CastSpell(63364)
 Modera:DisableCombat(true)
 Modera:RegisterEvent("ArchmageModera_Speak", 2500, 1)
 Netherkurse:RegisterEvent("Netherkurse_Check", 1000, 0)
end

function ArchmageModera_Speak(pUnit, Event)
 pUnit:SendChatMessage(12, 0, "Defeat the minions! If they die, then the shield will fall.")
 Netherkurse:RegisterEvent("Netherkurse_Spell", 9000, 0)
end

function Netherkurse_Spell(pUnit, Event)
 if Modera == nil then
 else
 pUnit:FullCastSpellOnTarget(61924, Modera)
 end
end





function Netherkurse_Check(pUnit, Event)
 if NetherkurseWarlock1:IsDead()== true and NetherkurseWarlock2:IsDead()== true then
 Netherkurse:RemoveEvents()
 Netherkurse:SendChatMessage(14, 0, "My shield!")
 Netherkurse:RemoveAura(63364)
 Netherkurse:Emote(398, 10000)
 Modera:StopChannel()
 NetherkurseWarlock1:StopChannel()
 NetherkurseWarlock2:StopChannel()
 Modera:RegisterEvent("ArchmageModera_End", 5500, 1)
 end
end

function ArchmageModera_End(pUnit, Event)
 pUnit:SendChatMessage(12, 0, "This is your end, Netherkurse!")
 pUnit:RegisterEvent("ArchmageModera_bum", 3000, 1)
end

function ArchmageModera_bum(pUnit, Event)
 pUnit:FullCastSpellOnTarget(11, Netherkurse)
 Netherkurse:RegisterEvent("Netherkurse_Die", 600, 1)
 pUnit:RegisterEvent("ArchmageModera_LastTalk", 3000, 1)
end

function Netherkurse_Die(pUnit, Event)
 pUnit:Kill(pUnit)
 local PlayersAllAround = pUnit:GetInRangePlayers()
	for a, plr in pairs(PlayersAllAround) do
	  if plr:HasQuest(23) == true then
	  plr:MarkQuestObjectiveAsComplete(23, 0)
	  end
end
end


function ArchmageModera_LastTalk(pUnit, Event)
 pUnit:SendChatMessage(12, 0, "Today Netherkurse and his minions are defeated - a glorious victory for the Alliance!")
 EredarLord:CastSpell(35426)
 EredarLord:Despawn(1000, 23000)
 Netherkurse:Despawn(8000, 30000)
 NetherkurseWarlock1:Despawn(8000, 30000)
 NetherkurseWarlock1:SetFaction(35)
 NetherkurseWarlock2:Despawn(8000, 30000)
 NetherkurseWarlock2:SetFaction(35)
 Netherkurse:ChannelSpell(35996, EredarLord)
 Modera:RegisterEvent("ArchmageModera_Despawn", 10000, 1)
end

function ArchmageModera_Despawn(pUnit, Event)
 Modera:Despawn(800, 7000)
 pUnit:CastSpell(64446)
end

function ArchmageModera_OnDied(pUnit, Event)
 Modera:StopChannel()
 pUnit:RemoveEvents()
 Netherkurse:RemoveEvents()
 NetherkurseWarlock1:RemoveEvents()
 NetherkurseWarlock2:RemoveEvents()
 Modera:RemoveEvents()
 EredarLord:RemoveEvents()
 Netherkurse:SendChatMessage(42, 0, "The attack against Netherkurse has failed!")
 EredarLord:Despawn(1, 5000)
 Netherkurse:Despawn(1, 5000)
 NetherkurseWarlock1:Despawn(1, 5000)
 NetherkurseWarlock2:Despawn(1, 5000)
 Modera:Despawn(1, 1)
 NetherkurseWarlock1:SetFaction(35)
 NetherkurseWarlock2:SetFaction(35)
end

RegisterUnitEvent(50033, 4, "ArchmageModera_OnDied")
RegisterUnitEvent(50033, 18, "ArchmageModera_OnSpawn")

----------------------------------------------------------------------