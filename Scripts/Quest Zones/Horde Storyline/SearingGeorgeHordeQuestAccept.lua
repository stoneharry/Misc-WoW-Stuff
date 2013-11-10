function SearingGeorgeHorde_OnQuestAccept(event, pPlayer, questId, pQuestGiver)
if (questId == 825) then
pPlayer:_CreateTaxi()
		pPlayer:_AddPathNode(0, -7228.99, -1736.84,245.24)
		pPlayer:_AddPathNode(0, -7153.98, -1695.91, 248.24)
		pPlayer:_AddPathNode(0, -6825.36, -1512.89, 291.96)
		pPlayer:_AddPathNode(0, -6694.66, -1071.25, 295.66)
			pPlayer:_AddPathNode(0, -6541.21, -1174.96,318.59)
				pPlayer:_AddPathNode(0, -6488.23, -1081.09, 316.23)
					pPlayer:_AddPathNode(0, -6581.17, -1071.43, 321.57)
						pPlayer:_AddPathNode(0, -6580.49, -1100.12, 319.09)
							pPlayer:_AddPathNode(0, -6541.26, -1104.85, 309.69)
		pPlayer:_StartTaxi(40102) 
			pPlayer:GossipComplete()
end
end


RegisterServerHook(14, "SearingGeorgeHorde_OnQuestAccept")