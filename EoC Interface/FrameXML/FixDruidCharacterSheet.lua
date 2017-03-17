--WARRIOR, PALADIN, HUNTER, ROGUE, PRIEST, DEATHKNIGHT, SHAMAN, MAGE, WARLOCK, DRUID
local CritPerAgi = { 0.0037, 0.0080, 0.0099, 0.0050, 0.0308, 0.0037, 0.0282, 0.0086, 0.0283, 0.0291, }
local SpellCritPerInt = { 0.0000, 0.0025, 0.0025, 0.0000, 0.0025, 0.0000, 0.0025, 0.0025, 0.0025, 0.0025, }
local BaseManaRegenPerSpi = 0.003345;
local HealthRegenPerSpi = { 0.5, 0.125, 0.125, 0.333332986, 0.041666999, 0.5, 0.071428999, 0.041666999, 0.045455001, 0.0625, }

local ClassNameToID = {
	"WARRIOR",
	"PALADIN",
	"HUNTER",
	"ROGUE",
	"PRIEST",
	"DEATHKNIGHT",
	"SHAMAN",
	"MAGE",
	"WARLOCK",
	"DRUID",
	"DEMONHUNTER",
	["WARRIOR"] = 1,
	["PALADIN"] = 2,
	["HUNTER"] = 3,
	["ROGUE"] = 4,
	["PRIEST"] = 5,
	["DEATHKNIGHT"] = 6,
	["SHAMAN"] = 7,
	["MAGE"] = 8,
	["WARLOCK"] = 9,
	["DRUID"] = 10,
	["DEMONHUNTER"] = 11,
}

function GetCritFromAgi(agi, class)
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	return agi * CritPerAgi[class], "MELEE_CRIT"
end

function GetSpellCritFromInt(int, class)
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	return int * SpellCritPerInt[class], "SPELL_CRIT"
end

function GetNormalManaRegenFromSpi(spi, int)
	return (0.001 + spi * BaseManaRegenPerSpi * (int ^ 0.5)) * 5, "MANA_REG_NOT_CASTING"
end

function GetHealthRegenFromSpi(spi, class)
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end

	return spi * HealthRegenPerSpi[class] * 5, "HEALTH_REG_OUT_OF_COMBAT"
end

myGetCritChanceFromAgility=myGetCritChanceFromAgility or GetCritChanceFromAgility;
myGetSpellCritChanceFromIntellect=myGetSpellCritChanceFromIntellect or GetSpellCritChanceFromIntellect;
myGetUnitManaRegenRateFromSpirit=myGetUnitManaRegenRateFromSpirit or GetUnitManaRegenRateFromSpirit;
myGetUnitHealthRegenRateFromSpirit=myGetUnitHealthRegenRateFromSpirit or GetUnitHealthRegenRateFromSpirit;

GetCritChanceFromAgility = function(...)
	local oType = ...;
	if oType == "player" then
		local playerClass = UnitClass("player");
		local playerLevel = UnitLevel("player");
		if playerLevel > 99 and playerClass == "Druid" then
			return GetCritFromAgi(UnitStat("player", 2), playerClass);
		end
	end
	return myGetCritChanceFromAgility(oType);
end

GetSpellCritChanceFromIntellect = function(...)
	local oType = ...;
	if oType == "player" then
		local playerClass = UnitClass("player");
		local playerLevel = UnitLevel("player");
		if playerLevel > 99 and playerClass == "Druid" then
			return GetSpellCritFromInt(UnitStat("player", 4), playerClass);
		end
	end
	return myGetSpellCritChanceFromIntellect(oType);
end

GetUnitManaRegenRateFromSpirit = function(...)
	local oType = ...;
	if oType == "player" then
		local playerClass = UnitClass("player");
		local playerLevel = UnitLevel("player");
		if playerLevel > 99 and playerClass == "Druid" then
			return GetNormalManaRegenFromSpi(UnitStat("player", 5), UnitStat("player", 4));
		end
	end
	return myGetUnitManaRegenRateFromSpirit(oType);
end

GetUnitHealthRegenRateFromSpirit = function(...)
	local oType = ...;
	if oType == "player" then
		local playerClass = UnitClass("player");
		local playerLevel = UnitLevel("player");
		if playerLevel > 99 and playerClass == "Druid" then
			return GetHealthRegenFromSpi(UnitStat("player", 5), playerClass);
		end
	end
	return myGetUnitHealthRegenRateFromSpirit(oType);
end