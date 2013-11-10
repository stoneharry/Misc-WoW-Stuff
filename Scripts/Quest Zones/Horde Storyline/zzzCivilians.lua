
function Ohai_Tehx_hjwa_zojg_tieoa_civilien_run(pUnit, Event)
	local choice = math.random(1,2)
	if choice == 1 then
	pUnit:SetModel(24818)
	end
	if choice == 2 then
	pUnit:SetModel(3422)
	end
	pUnit:RegisterEvent("Wait_ASeaigj_Second_aergpj_else_clash", 4000, 0)
end

function Wait_ASeaigj_Second_aergpj_else_clash(pUnit, Event)
	pUnit:SetMovementFlags(1) -- Run
end

RegisterUnitEvent(25266, 18, "Ohai_Tehx_hjwa_zojg_tieoa_civilien_run")

function EOAJYHPAIH_AEOJGAPEIOJ_AMG_A_CIVIOLEO_DEAD(pUnit, Event)
	if math.random(1,2) == 1 then
	pUnit:PlaySoundToSet(14556) -- Scream
	else
	pUnit:PlaySoundToSet(14557) -- Scream 2
	end
	pUnit:PlaySoundToSet(11836) -- Explosion
end

RegisterUnitEvent(25266, 4, "EOAJYHPAIH_AEOJGAPEIOJ_AMG_A_CIVIOLEO_DEAD")

function zeztyjsipjysoyhs_xrjhxi_zatjo(item, event, player)
	eaazzRuneStart(item, event, player)
end

function eaazzRuneStart(item, event, player)
	if player:HasQuest(803) == true then
		local target = player:GetSelection()
		local TargetdistanceFromPlayerSCASda = player:GetDistanceYards(target)
				if (target ~= nil and target:GetEntry() == 25266) then
					if (TargetdistanceFromPlayerSCASda ~= nil and TargetdistanceFromPlayerSCASda <= 5) then
						if (player:GetQuestObjectiveCompletion(803, 0) == 2) then
							if (target:IsAlive() == true) then
							target:CastSpell(11)
							target:SetModel(25539)
							target:CastSpell(47496)
							player:AdvanceQuestObjective(803, 0)
							player:RemoveItem(33310, 1)
							else
							player:SendAreaTriggerMessage("|CFFff0000You can't use that on Dead Civilians!|R")
							end
						else
							if (target:IsAlive() == true) then
						player:AdvanceQuestObjective(803, 0)
						target:CastSpell(11)
						target:SetModel(25539)
						target:CastSpell(47496)
							else
							player:SendAreaTriggerMessage("|CFFff0000You can't use that on Dead Civilians!|R")
							end
						end
					else
						player:SendAreaTriggerMessage("|CFFff0000Out of Range!|R")
					end
				else
					--player:SendBroadcastMessage("|cFFFF0000Wrong Target.")
					player:SendAreaTriggerMessage("|cFFFF0000Wrong Target.")
				end
	else
		if player:HasQuest(827) == true then
				local target = player:GetSelection()
				local TargetdistanceFromPlayerSCASda = player:GetDistanceYards(target)
					if (target ~= nil and target:GetEntry() == 25266) then
						if (TargetdistanceFromPlayerSCASda ~= nil and TargetdistanceFromPlayerSCASda <= 5) then
							if (player:GetQuestObjectiveCompletion(827, 0) == 9) then
								if (target:IsAlive() == true) then
								target:CastSpell(11)
								target:SetModel(25539)
								target:CastSpell(47496)
								player:RemoveItem(33310, 1)
								player:AdvanceQuestObjective(827, 0)
								else
								player:SendAreaTriggerMessage("|CFFff0000You can't use that on Dead Civilians!|R")
								end
							else
							if (target:IsAlive() == true) then
							player:AdvanceQuestObjective(827, 0)
							target:CastSpell(11)
							target:SetModel(25539)
							target:CastSpell(47496)
							else
								player:SendAreaTriggerMessage("|CFFff0000You can't use that on Dead Civilians!|R")
								end
							end
						else
						player:SendAreaTriggerMessage("|CFFff0000Out of Range!|R")
						end
					else
						--player:SendBroadcastMessage("|cFFFF0000Wrong Target.")
						player:SendAreaTriggerMessage("|cFFFF0000Wrong Target.")
					end
		end
	end
end

RegisterItemGossipEvent(33310, 1, "zeztyjsipjysoyhs_xrjhxi_zatjo")