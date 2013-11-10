
local name = Jack

function Razzak_OnSpawn(pUnit, Event)
	pUnit:SetFaction(35)
	pUnit:RegisterEvent("CheckPlrStatus", 2500, 0)
end

function RootMe(pUnit, Event)
	pUnit:SetFaction(35)
	local playr = pUnit:GetClosestPlayer()
	if playr ~= nil then
		if playr:IsAlive() then
			if pUnit:GetDistance(playr) <= 30 then
				if playr:HasQuest(816) == true then
					pUnit:RemoveEvents()
					name = playr:GetName()
					pUnit:RegisterEvent("FirstDate", 1000, 1)
				end
			end
		end
	end
end

function FirstDate(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "So, you've finally figured out that I was a traitor did you "..name.."?")
	pUnit:Emote(1,5000)
	pUnit:RegisterEvent("IhopeHeIsntGonnaTalkMuch", 5000, 1)
end

function IhopeHeIsntGonnaTalkMuch(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "You see.. when I was a little boy I dreamt of having a wife.")
	pUnit:Emote(1,5000)
	pUnit:RegisterEvent("AwShitHeISGonnaTalkMuchSadface", 5000, 1)
end

function AwShitHeISGonnaTalkMuchSadface(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "And I found my wife a while ago, but she died, so I went to a wizard.")
	pUnit:Emote(1,5000)
	pUnit:RegisterEvent("CmonStopTalking", 5000, 1)
end

function CmonStopTalking(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "He told me that he could revive her, but he needed me to infiltrate the Horde and achieve an orb.")
	pUnit:Emote(1,5000)
	pUnit:RegisterEvent("IhopeYourFuckinDoneSoon", 5000, 1)
end

function IhopeYourFuckinDoneSoon(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "But when I got back to the wizard he told me that he had lied, but he underestimated me, and I escaped from his grasp.")
	pUnit:Emote(1,5000)
	pUnit:RegisterEvent("AreYouDone", 5000, 1)
end

function AreYouDone(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "But when I got home I found a note saying that the wizard had killed her, which I thought was silly since she was already dead.")
	pUnit:Emote(1,5000)
	pUnit:RegisterEvent("NopeHeIsntDone", 7000, 1)
end

function NopeHeIsntDone(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "The wizard had only revived her to kill her again! Kill me if you will but I feel my actions are justified.")
	pUnit:SetFaction(15)
	pUnit:RemoveEvents()
	--pUnit:RegisterEvent("CheckPlrStatus", 10000, 1)
end

function CheckPlrStatus(pUnit, Event)
	if pUnit:IsDead() then
		pUnit:Despawn(1, 0)
	else
	pUnit:RegisterEvent("RootMe", 2500, 0)
	end
end

RegisterUnitEvent(9375, 18, "Razzak_OnSpawn")