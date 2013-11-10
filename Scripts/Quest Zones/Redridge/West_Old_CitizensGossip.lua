local Haley = nil
local Emily = nil
local Cultist_A
local Cultist_B

function Haley_Spawn(pUnit,Event)
pUnit:RegisterEvent("Random_Gossip", 3000, 0)
end

function Emily_Spawn(pUnit,Event)
Emily = pUnit
if Emily ~= nil then
else
pUnit:Despawn(1000,1000)
end
end


RegisterUnitEvent(77116, 18, "Haley_Spawn")

RegisterUnitEvent(77115, 18, "Emily_Spawn")


function Random_Gossip (pUnit,Event)
	Haley = pUnit
	local plr = Haley:GetClosestPlayer()
	if plr ~= nil then
		if plr:IsInPhase(4) then
			if Haley:GetDistanceYards(plr) < 40 then
				pUnit:RemoveEvents()
				Haley = pUnit
				local choice = math.random(1,4)
				if choice == 1 then
					Haley:RegisterEvent("JimActingStrangeSuddenly", 1000, 1)
				elseif choice == 2 then
					Haley:RegisterEvent("Whatifdemonsarecoming", 1000, 1)
				elseif choice == 3 then
					Haley:RegisterEvent("Townmeetinggossip", 1000, 1)
				end
			end
		end	
	else
		Haley:RemoveEvents()
		pUnit:RegisterEvent("Haley_Spawn", 3000, 1)
	end
end

-----------------------------------------------------
-----------------Dialogue 1--------------------
-----------------------------------------------------

function JimActingStrangeSuddenly(pUnit,Event)
if Emily ~= nil then
Emily:SendChatMessage(12,0,"Have you heard from Jim lately? He's been acting strange.")
Emily:Emote(6,3000)
Emily:RegisterEvent("JimActingStrangeSuddenlyz", 5000, 1)
end
end

function JimActingStrangeSuddenlyz(pUnit,Event)
if Haley ~= nil then
Haley:SendChatMessage(12,0,"I'm glad I'm not the only one who did not notice how he is acting. He won't even come out of his room!")
Haley:Emote(1,3000)
Haley:RegisterEvent("JimActingStrangeSuddenlyzz", 7000, 1)
end
end

function JimActingStrangeSuddenlyzz(pUnit,Event)
if Emily ~= nil then
Emily:SendChatMessage(12,0,"Perhaps he is posssessed! Councilor Luke was saying that some people are really demons in disguise...")
Emily:Emote(5,3000)
Emily:RegisterEvent("JimActingStrangeSuddenlyzzz", 4000, 1)
end
end

function JimActingStrangeSuddenlyzzz(pUnit,Event)
if Haley ~= nil then
Haley:SendChatMessage(12,0,"Don't jump to conclusions like that, Luke was crazy - we all know that.")
Haley:Emote(5,3000)
Haley:RegisterEvent("Haley_Spawn", 15000, 1)
Haley = nil
end
end

-----------------------------------------------------
-----------------Dialogue 2--------------------
-----------------------------------------------------


function Whatifdemonsarecoming(pUnit,Event)
if Haley ~= nil then
Haley:SendChatMessage(12,0,"I hear something happened to the other councilors, only Jane is alive. I wonder what happened to them.")
Haley:Emote(1,3000)
Haley:RegisterEvent("Whatifdemonsarecomingz", 6000, 1)
end
end

function Whatifdemonsarecomingz(pUnit,Event)
if Emily ~= nil then
Emily:SendChatMessage(12,0,"I heard noises and banging from the inn an hour ago while I was picking apples.")
Emily:Emote(1,3000)
Emily:RegisterEvent("Whatifdemonsarecomingzzz", 7000, 1)
end
end

function Whatifdemonsarecomingzzz(pUnit,Event)
if Haley ~= nil then
Haley :SendChatMessage(12,0,"Perhaps the demons have come, they are out to get us!")
Haley:Emote(5,3000)
Haley:RegisterEvent("Whatifdemonsarecomingzzzz", 3000, 1)
end
end

function Whatifdemonsarecomingzzzz(pUnit,Event)
if Emily ~= nil then
Emily:SendChatMessage(12,0,"Don't say that - I still have my little Tommy and Betty to think about!")
Emily:Emote(431,6000)
Emily:RegisterEvent("Whatifdemonsarecomingzzzzz", 5000, 1)
end
end

function Whatifdemonsarecomingzzzzz(pUnit,Event)
if Haley ~= nil then
Haley:SendChatMessage(12,0,"I'm just kidding, Jeez can't you take a joke!")
Haley:Emote(11,2000)
Haley:RegisterEvent("Haley_Spawn", 25000, 1)
Haley = nil
end
end

-----------------------------------------------------
---------------------Dialogue 3----------------------
-----------------------------------------------------

function Townmeetinggossip(pUnit,Event)
if Haley ~= nil then
Haley:SendChatMessage(12,0,"Mayor Jane is housing a meeting right now, so I heard.")
Haley:Emote(1,3000)
Haley:RegisterEvent("Townmeetinggossipz", 6000, 1)
end
end

function Townmeetinggossipz(pUnit,Event)
if Emily ~= nil then
Emily:SendChatMessage(12,0,"Yeah, they aren't letting anyone else in now though. They kicked me out, it's absurd!")
Emily:Emote(5,3000)
Emily:RegisterEvent("Townmeetinggossipzz", 7000, 1)
end
end

function Townmeetinggossipzz(pUnit,Event)
if Haley ~= nil then
Haley:SendChatMessage(12,0,"Why house a town meeting, only to kick out the citizens? I do not understand.")
Haley:Emote(6,3000)
Haley:RegisterEvent("Townmeetinggossipzzz", 6000, 1)
end
end

function Townmeetinggossipzzz(pUnit,Event)
if Emily ~= nil then
Emily:SendChatMessage(12,0,"Now that I think about it... the other councilors did die afterall... I'd be worried too.")
Emily:Emote(5,3000)
Emily:RegisterEvent("Townmeetinggossipzzzz", 5000, 1)
end
end

function Townmeetinggossipzzzz(pUnit,Event)
if Haley ~= nil then
Haley:SendChatMessage(16,0,"Haley lets out a long, drawn-out sigh.")
Haley:SendChatMessage(12,0,"This town is going to hell.")
Haley:Emote(1,3000)
Haley:RegisterEvent("Haley_Spawn", 35000, 1)
Haley = nil
end
end

---Unrelated Quest--
function Jane_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("GhostEffectz",1200,1)
end

RegisterUnitEvent(77111, 18, "Jane_OnSpawn")

function GhostEffectz(pUnit,Event)
	pUnit:CastSpell(44816)
end

function Bishop_OnSpawn(pUnit,Event)
pUnit:DeMorph()
pUnit:SetFaction(35)
pUnit:SetScale(1)
pUnit:EquipWeapons(18608,0,0)
pUnit:RegisterEvent("GhostEffectz",1200,1)
end

function Cultist_A_OnSpawn(pUnit,Event)
pUnit:DeMorph()
pUnit:SetFaction(35)
Cultist_A = pUnit
end


function Cultist_B_OnSpawn(pUnit,Event)
pUnit:DeMorph()
pUnit:SetFaction(35)
pUnit:SetScale(1)
pUnit:EquipWeapons(0,0,0)
Cultist_B = pUnit
end

RegisterUnitEvent(77120, 18, "Bishop_OnSpawn")
RegisterUnitEvent(77121, 18, "Cultist_A_OnSpawn")
RegisterUnitEvent(77122, 18, "Cultist_B_OnSpawn")


function SomethingsFishy_On_Gossip(pUnit, event, player)
	pUnit:GossipCreateMenu(142341, player,0)
	if player:HasQuest(3027) == false then
		if player:HasFinishedQuest(3027) == false then
			pUnit:GossipMenuAddItem(0, "What's going on here?", 246, 0)
		end
	end
	pUnit:GossipMenuAddItem(0, "Nevermind.", 250, 0)
	pUnit:GossipSendMenu(player)
end

function SomethingsFishy_Gossip_Submenus(pUnit, event, player, id, intid, code)
	if(intid == 246) then
		player:StartQuest(3027)
		SetDBCSpellVar(35510, "c_is_flags", 0x01000)
		pUnit:SendChatMessage(12,0,"Why must you meddle in our affairs?!")
		pUnit:SetModel(10543)
		pUnit:CastSpell(35510)
		pUnit:CastSpell(44816)
		pUnit:SetScale(.6)
		pUnit:SetFaction(14)
		pUnit:EquipWeapons(0,0,0)
		player:GossipComplete()
	elseif(intid == 250) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(77120, 1, "SomethingsFishy_On_Gossip")
RegisterUnitGossipEvent(77120, 2, "SomethingsFishy_Gossip_Submenus")

--Cellar AI--

function BishopDreadlord_OnLeave(pUnit,Event)
pUnit:RemoveEvents()
end

function BishopDreadlord_OnDead(pUnit,Event)
pUnit:RemoveEvents()
pUnit:Despawn(1000,6000)
Cultist_B:Despawn(1000,6000)
Cultist_A:Despawn(1000,6000)
pUnit:SendChatMessage(12,0,"You only delay the inevitable.")
end

function BishopDreadlord_OnCombat(pUnit,Event)
pUnit:CastSpellOnTarget(1014, pUnit:GetMainTank())
pUnit:RegisterEvent("Shadowbolt", 4000, 0)
pUnit:RegisterEvent("COA", 10000, 0)
pUnit:RegisterEvent("Addone", 2000, 0)
end

function Shadowbolt(pUnit,Event)
pUnit:FullCastSpellOnTarget(695, pUnit:GetMainTank())
end

function COA(pUnit,Event)
local mt = pUnit:GetMainTank()
mt:RemoveAura(1014)
pUnit:CastSpellOnTarget(1014, mt)
mt = nil
end


function Addone(pUnit,Event)
if pUnit:GetHealthPct() < 70 then
pUnit:RemoveEvents()
pUnit:RegisterEvent("Shadowbolt", 4000, 0)
pUnit:RegisterEvent("COA", 10000, 0)
pUnit:RegisterEvent("Addtwo", 2000, 0)
if Cultist_B ~= nil then
Cultist_B:CastSpell(50772)
Cultist_B:SetModel(20531)
Cultist_B:CastSpell(44816)
Cultist_B:SetFaction(14)
Cultist_B:SetScale(.4)
Cultist_B:EquipWeapons(9372,0,0)
end
end
end


function Addtwo(pUnit,Event)
if pUnit:GetHealthPct() < 40 then
pUnit:RemoveEvents()
pUnit:RegisterEvent("Shadowbolt", 4000, 0)
pUnit:RegisterEvent("COA", 10000, 0)
if Cultist_A ~= nil then
Cultist_A:CastSpell(50772)
Cultist_A:SetModel(4162)
Cultist_A:SetFaction(14)
Cultist_A:CastSpell(44816)
end
end
end


RegisterUnitEvent(77120, 1, "BishopDreadlord_OnCombat")
RegisterUnitEvent(77120, 2, "BishopDreadlord_OnLeave")
RegisterUnitEvent(77120, 4, "BishopDreadlord_OnDead")

