CaptainHilnomTable = {}
CaptainAnotherTable = {}

CaptainHilnomTable.CaptainUnitEntryID = 90500
CaptainHilnomTable.CaptainMountDisplayID = 28918
CaptainHilnomTable.CaptainSaluteEmote = {66, 2000}
CaptainHilnomTable.CaptainWeaponsEquip = {50048, 0, 0}
CaptainHilnomTable.CaptainWarhorseDisplayID = 28918

function CaptainHilnomTable.CaptainOnSpawn(pUnit, event)
	CaptainHilnomTable.Captain = pUnit
	CaptainHilnomTable.Captain:EquipWeapons(CaptainHilnomTable.CaptainWeaponsEquip[1], CaptainHilnomTable.CaptainWeaponsEquip[2], CaptainHilnomTable.CaptainWeaponsEquip[3])
	CaptainHilnomTable.Captain:SetMount(CaptainHilnomTable.CaptainWarhorseDisplayID)
	CaptainHilnomTable.Captain:RegisterEvent("CaptainHilnomTable.SaluteThePlayer", 1000, 0)
end

RegisterUnitEvent(CaptainHilnomTable.CaptainUnitEntryID, 18, "CaptainHilnomTable.CaptainOnSpawn")

function CaptainHilnomTable.SaluteThePlayer(pUnit, event)
	CaptainHilnomTable.ClosestPlayerGet = CaptainHilnomTable.Captain:GetClosestPlayer()
		if ((CaptainHilnomTable.ClosestPlayerGet ~= nil) and (CaptainHilnomTable.Captain:GetDistanceYards(CaptainHilnomTable.ClosestPlayerGet) <= 8) and not table.find(CaptainAnotherTable, CaptainHilnomTable.ClosestPlayerGet:GetName())) then
					CaptainHilnomTable.Captain:Emote(CaptainHilnomTable.CaptainSaluteEmote[1], CaptainHilnomTable.CaptainSaluteEmote[2])
					CaptainHilnomTable.Captain:SendChatMessage(16, 0, "Captain Hiln'om salutes "..CaptainHilnomTable.ClosestPlayerGet:GetName().." with respect!")
					table.insert(CaptainAnotherTable, CaptainHilnomTable.ClosestPlayerGet:GetName())
		end
end

function table.find(t, v)
	if type(t) == "table" and v then
		for k, val in pairs(t) do
			if (v == val) then
				return k
			end
		end
	end
return false
end