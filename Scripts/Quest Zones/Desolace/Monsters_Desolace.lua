
function Ghostwalker_Events(pUnit,event,pLastTarget)
	if Event == 1 then
		pUnit:RegisterEvent("Ghostwalker_Shockwave", math.random(7000,12000), 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
		if pLastTarget then
			if ((not pLastTarget:HasFinishedQuest(80078)) and (not pLastTarget:HasQuest(80078))) then
				pLastTarget:StartQuest(80078)
				pLastTarget:AdvanceQuestObjective(80078, 0)
			end
		end
	end
end
	
function Ghostwalker_Shockwave(pUnit)
     local plr = pUnit:GetRandomPlayer(0) 
     if plr then 
          pUnit:CastSpellOnTarget(46968, plr) 
     end 
end

RegisterUnitEvent(26165, 1, "Ghostwalker_Events")
RegisterUnitEvent(26165, 2, "Ghostwalker_Events")
RegisterUnitEvent(26165, 4, "Ghostwalker_Events")