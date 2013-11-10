--------------------------
--		Xnos			--
--	<Arena Organizer>	--
--------------------------
--[[
function TIK_Xnox_OnGossip(pUnit,Event, plr)
	pUnit:GossipCreateMenu(60011, plr, 0)
	if plr:HasQuest(57013) then
		pUnit:GossipMenuAddItem(1,"Let me face my opponment!",2,0)
	end
	pUnit:GossipMenuAddItem(1,"Nevermind",3,0)
	pUnit:GossipAddQuests(plr)
	pUnit:GossipSendMenu(plr)
end

RegisterUnitGossipEvent(60019, 1, "TIK_Xnox_OnGossip")

function TIK_Xnox_OnGossipSelect(pUnit,event,plr,id,intid,code)
	if (initid == 2) then
		pUnit:GossipComplete()
		plr:SetPhase(2)
		plr:Teleport(34, 84, 14, -25, 0)
	end
	if (initid == 3) then
		pUnit:GossipComplete()
	end
end

RegisterUnitGossipEvent(60019, 2, "TIK_Xnox_OnGossipSelect")]]