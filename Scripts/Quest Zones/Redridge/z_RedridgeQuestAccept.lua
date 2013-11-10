
function RedridgeQuests_OnQuestAccept(event, pPlayer, questId, pQuestGiver)
	if (questId == 3010) then
		pPlayer:_CreateTaxi()
		pPlayer:_AddPathNode(0, -9674.671875, -3225.777588, 50.839832)
		pPlayer:_AddPathNode(0, -9652.700195, -3217.266602, 53.144356)
		pPlayer:_AddPathNode(0, -9629.071289, -3026.680420, 95.911118)
		pPlayer:_AddPathNode(0, -9465.642578, -2930.974854, 109.703384)
		pPlayer:_AddPathNode(0, -9361.274414, -2835.358154, 92.927216)
		pPlayer:_AddPathNode(0, -9212.375977, -2868.998291, 153.670517)
		pPlayer:_AddPathNode(0, -9311.712891, -3011.962891, 149.595016)
		pPlayer:_AddPathNode(0, -9375.707031, -3013.746094, 148.826920)
		pPlayer:_AddPathNode(0, -9397.924805, -3013.171143, 136.687317)
		pPlayer:_StartTaxi(25587)
		pPlayer:SetPhase(1)
	elseif (questId == 3008) then
	--	pPlayer:CastSpell(64775) -- immune to all, this is bad and expoitable ~eclipse
	elseif (questId == 3032) then
		pPlayer:SetPhase(32)
		pPlayer:PlaySoundToPlayer(15120)
	elseif (questId == 4231) then
		pPlayer:Teleport(269, -2055.92, 7123.80, 28.21)
	end
end

RegisterServerHook(14, "RedridgeQuests_OnQuestAccept")