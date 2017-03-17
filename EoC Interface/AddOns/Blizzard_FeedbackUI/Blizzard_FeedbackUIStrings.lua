
project_name = "Edge of Chaos";  -- Put your project name here to replace all uses of World of Warcraft in strings with your projects' name.

FEEDBACKUI_RED = "|cFFFF0000"
FEEDBACKUI_WHITE = "|cFFFFFFFF"
FEEDBACKUI_GREEN = "|cFF11EE11"
FEEDBACKUI_BLUE = "|cFF5A9FFF"
FEEDBACKUI_BLUE_COLOR = { r=.351, g=.621, b=1, a=1 }


FEEDBACKUI_SURVEYCOLOR = { r=0, g=0, b=.33, a=.6 };
FEEDBACKUI_BUGCOLOR = { r=.33, g=0, b=0, a=.6 };
FEEDBACKUI_SUGGESTIONCOLOR = { r=0, g=.33, b=0, a=.6};
FEEDBACKUI_DISABLEDCOLOR = { r=0, g=0, b=0, a=1 };

FEEDBACKUI_NONINSTANCEZONES = {}

for i = 1, 4 do
	for _, val in next, { GetMapZones(i) } do
		-- table.insert(FEEDBACKUI_NONINSTANCEZONES, val)
		FEEDBACKUI_NONINSTANCEZONES[val] = true;
	end
end

if ( GetLocale() == "frFR" ) then
	--Localized French strings for FEEDBACKUI
	--[[
	function frFR() end
	]]--
	--Non-instance special zone names
	FEEDBACKUI_EXCEPTIONZONES = { "Tram des profondeurs", "Hall des Champions", "La Mer interdite", "La Mer voilée", "La Grande mer", "Vallée d'Alterac", "Bassin d'Arathi", "Mont Rochenoire", "Goulet des Chanteguerres", "Hall des Légendes", "Donjon d'Utgarde", }
	
	--Headers    
	FEEDBACKUIINFOPANELLABEL_TEXT = "Informations"
	FEEDBACKUI_BUGINPUTHEADER="Veuillez décrire le bug"
	FEEDBACKUI_SUGGESTINPUTHEADER="Veuillez décrire votre suggestion"
	
	--Labels
	FEEDBACKUIFEEDBACKFRMTITLE_TEXT = "Soumettre un retour"
	FEEDBACKUILBLFRMVER_TEXT = "Version :"
	FEEDBACKUILBLFRMREALM_TEXT = "Royaume :"
	FEEDBACKUILBLFRMNAME_TEXT = "Nom :"
	FEEDBACKUILBLFRMCHAR_TEXT = "Personnage :"
	FEEDBACKUILBLFRMMAP_TEXT = "Carte :"
	FEEDBACKUILBLFRMZONE_TEXT = "Zone :"
	FEEDBACKUILBLFRMAREA_TEXT = "Région :"
	FEEDBACKUILBLFRMADDONS_TEXT = "Add-ons :"
	FEEDBACKUILBLADDONSWRAP_TEXT = "Add-ons actuellement lancés :\n"
	FEEDBACKUITYPEBUG_TEXT = "Bug"
	FEEDBACKUITYPESUGGEST_TEXT = "Suggestion"
	FEEDBACKUITYPESURVEY_TEXT = "Enquête"
	FEEDBACKUILBLFRMWHO_TEXT = "Qui : "
	FEEDBACKUILBLFRMWHERE_TEXT = "Où : "
	FEEDBACKUILBLFRMWHEN_TEXT = "Quand : "
	FEEDBACKUILBLFRMTYPE_TEXT = "Type : "
	FEEDBACKUI_GENDERTABLE = { "Inconnu", "Mâle", "Femelle" }
	
	--Prompts
	FEEDBACKUIBUGFRMINPUTBOX_TEXT = "<Tapez ici les étapes pour reproduire votre bug>"
	FEEDBACKUISUGGESTFRMINPUTBOX_TEXT = "<Tapez ici votre suggestion>"
	FEEDBACKUILBLADDONS_MOUSEOVER = "<Passer la souris pour voir les add-ons chargés.>"
	FEEDBACKUI_CONFIRMATION = "Votre retour a été envoyé.\nMerci de nous aider à améliorer " .. project_name .. "!"
	
	--Tooltips & Buttons
	BUG_BUTTON="Soumettre retour"
	NEWBIE_TOOLTIP_BUG="Nous envoie un retour sur un bug ou une suggestion afin de nous aider à améliorer " .. project_name .. ""
	FEEDBACKUIBACK_TEXT = "Retour"
	FEEDBACKUIRESET_TEXT = "Réinitialiser"
	FEEDBACKUISUBMIT_TEXT = "Soumettre"
	FEEDBACKUISTART_TEXT = "Début"
	
	--Tables and strings for navigation.
	FEEDBACKUI_WELCOMETABLEBUGHEADER = "Reporter un bug"
	FEEDBACKUI_WELCOMETABLESUGGESTHEADER = "Faire une suggestion"
	FEEDBACKUI_WELCOMETABLESUBTEXT = "Merci de votre retour !"
	
	FEEDBACKUI_WELCOME = "\nMerci d’avoir soumis un retour sur " .. project_name .. ". Toutes vos propositions sont prises en compte afin de nous permettre d’améliorer " .. project_name .. ".\n\nVeuillez remplir ce bref questionnaire, qui nous aidera à traiter plus efficacement l’énorme quantité de commentaires que nous recevons.\n\nMerci,\nBlizzard Entertainement"
	
	FEEDBACKUI_WHOTABLEHEADER = FEEDBACKUI_WHITE .. "Qui" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHOTABLESUBTEXT = "Qu’est-ce qui est affecté par ce problème ?"
	
	FEEDBACKUI_STRWHOPLAYER = "Affecte mon personnage."
	FEEDBACKUI_STRPARTYMEMBER = "Affecte les membres de mon groupe."
	FEEDBACKUI_STRRAIDMEMBER = "Affecte les membres de mon raid."
	FEEDBACKUI_STRENEMYPLAYER = "Affecte un personnage ennemi."
	FEEDBACKUI_STRFRIENDLYPLAYER = "Affecte un personnage amical."
	FEEDBACKUI_STRENEMYCREATURE = "Affecte une créature ennemie."
	FEEDBACKUI_STRFRIENDLYCREATURE = "Affecte une créature amicale."
	FEEDBACKUI_STRWHONA = "N'implique ni personnage ni créature."
	
	FEEDBACKUI_WHOPLAYER = "Mon personnage"
	FEEDBACKUI_ENEMYPLAYER = "Personnage ennemi"
	FEEDBACKUI_FRIENDLYPLAYER = "Personnage amical"
	FEEDBACKUI_PARTYMEMBER = "Membre du groupe"
	FEEDBACKUI_RAIDMEMBER = "Membre du raid"
	FEEDBACKUI_ENEMYCREATURE = "Créature ennemie"
	FEEDBACKUI_FRIENDLYCREATURE = "Créature amicale"
	FEEDBACKUI_WHONA = "N/A"
	
	FEEDBACKUI_WHERETABLEHEADER = FEEDBACKUI_WHITE .. "Où" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHERETABLESUBTEXT = "Où se produit le problème ?"
	
	FEEDBACKUI_STRAREATABLE = "Cela se produit en jeu"
	FEEDBACKUI_STRWHEREINSTALL = "Cela se produit à l'installation"
	FEEDBACKUI_STRWHEREDOWNLOAD = "Cela se produit au téléchargement"
	FEEDBACKUI_STRWHEREPATCH = "Cela se produit à la mise à jour"
	
	FEEDBACKUI_WHEREINSTALL = "En installant"
	FEEDBACKUI_WHEREDOWNLOAD = "En téléchargeant"
	FEEDBACKUI_WHEREPATCH = "En mettant à jour"
	
	FEEDBACKUI_AREATABLESUMMARY = FEEDBACKUI_GREEN .. "Quelque part en jeu"
	
	
	-----------------------Begin Area Strings --------------------------------------------------------------------------------
	FEEDBACKUI_STROCCURS = "- Cela se produit dans "; --LOCALIZE ME
	FEEDBACKUI_EVERYWHERE = "Partout en jeu"
	FEEDBACKUI_STREVERYWHERE = "Cela se produit partout en jeu."
	
	--AZEROTH
	FEEDBACKUI_AZEROTH = "Azeroth"
	
	--Northrend
	FEEDBACKUI_NORTHREND = "Norfendre"
	FEEDBACKUI_BOREANTUNDRA = "Toundra Boréenne"
	FEEDBACKUI_CRYSTALSONG = "Forêt du Chant de cristal" --LOCALIZE ME
	FEEDBACKUI_DALARAN = "Dalaran" 
	FEEDBACKUI_DRAGONBLIGHT = "Désolation des dragons"
	FEEDBACKUI_GRIZZLYHILLS = "Les Grisonnes"
	FEEDBACKUI_HOWLINGFJORD = "Fjord Hurlant"
	FEEDBACKUI_ICECROWN = "La Couronne de glace"--LOCALIZE ME
	FEEDBACKUI_NEXUS = "Nexus"
	FEEDBACKUI_SHOLAZARBASIN = "Bassin de Sholazar" --LOCALIZE ME
	FEEDBACKUI_STORMPEAKS = "Les pics Foudroyés" --LOCALIZE ME
	FEEDBACKUI_UTGARDEPINNACLE = "Cime d’Utgarde"
	FEEDBACKUI_WINTERGRASP = "Joug-d'hiver" --LOCALIZE ME
	FEEDBACKUI_ZULDRAK = "Zul'Drak" 
	FEEDBACKUI_STRNORTHREND = "Cela se produit en Norfendre."
	--End Northrend
	
	--Eastern Kingdoms
	FEEDBACKUI_EKINGDOMS = "Royaumes de l'Est"
	FEEDBACKUI_ALTERACMOUNTAINS = "Mts d'Alterac"
	FEEDBACKUI_ALTERACVALLEY = "Vallée d'Alterac"
	FEEDBACKUI_ARATHIBASIN = "Bassin d'Arathi"
	FEEDBACKUI_ARATHIHIGHLANDS = "Hautes-terres d'Arathi"
	FEEDBACKUI_BADLANDS = "Terres ingrates"
	FEEDBACKUI_BLACKROCKMOUNTAIN = "Mont Rochenoire"
	FEEDBACKUI_BLASTEDLANDS = "Terres foudroyées"
	FEEDBACKUI_BURNINGSTEPPES = "Steppes ardentes"
	FEEDBACKUI_DEADWINDPASS = "Défilé de Deuillevent"
	FEEDBACKUI_DUNMOROGH = "Dun Morogh"
	FEEDBACKUI_DUSKWOOD = "Bois de la Pénombre"
	FEEDBACKUI_EPLAGUELANDS = "Maleterres de l'est"
	FEEDBACKUI_ELWYNN = "Forêt d'Elwynn"
	FEEDBACKUI_EVERSONG = "Bois des Chants éternels"
	FEEDBACKUI_GHOSTLANDS = "Terres fantômes"
	FEEDBACKUI_HILLSBRAD = "Hautebrande"
	FEEDBACKUI_HINTERLANDS = "Les Hinterlands"
	FEEDBACKUI_IRONFORGE = "Forgefer"
	FEEDBACKUI_ISLEOFQUELDANAS = "Île de Quel'Danas" --LOCALIZE ME
	FEEDBACKUI_LOCHMODAN = "Loch Modan"
	FEEDBACKUI_REDRIDGE = "Les Carmines"
	FEEDBACKUI_SEARINGGORGE = "Gorge des Vents brûlants"
	FEEDBACKUI_SILVERMOON = "Lune-d'argent"
	FEEDBACKUI_SILVERPINE = "Forêt des Pins argentés"
	FEEDBACKUI_STORMWIND = "Hurlevent"
	FEEDBACKUI_STRANGLETHORN = "Vallée de Strangleronce"
	FEEDBACKUI_SWAMPOFSORROWS = "Marais des Chagrins"
	FEEDBACKUI_TIRISFAL = "Clairières de Tirisfal"
	FEEDBACKUI_UNDERCITY = "Fossoyeuse"
	FEEDBACKUI_WPLAGUELANDS = "Maleterres de l'ouest"
	FEEDBACKUI_WESTFALL = "Marche de l'ouest"
	FEEDBACKUI_WETLANDS = "Les Paluns"
	FEEDBACKUI_STREKINGDOMS = "Cela se produit dans les Royaumes de l'est."
	--End Eastern Kingdoms
	
	--Kalimdor
	FEEDBACKUI_KALIMDOR = "Kalimdor"
	FEEDBACKUI_ASHENVALE = "Orneval"
	FEEDBACKUI_AZSHARA = "Azshara"
	FEEDBACKUI_AZUREMYST = "Brume-azur"
	FEEDBACKUI_BARRENS = "Les Tarides"
	FEEDBACKUI_BLOODMYST = "Brume-sang"
	FEEDBACKUI_DARKSHORE = "Sombrivage"
	FEEDBACKUI_DARNASSUS = "Darnassus";
	FEEDBACKUI_DESOLACE = "Désolace"
	FEEDBACKUI_DUROTAR = "Durotar"
	FEEDBACKUI_DUSTWALLOW = "Marécage d'Âprefange"
	FEEDBACKUI_EXODAR = "L'Exodar"
	FEEDBACKUI_FELWOOD = "Gangrebois"
	FEEDBACKUI_FERALAS = "Féralas"
	FEEDBACKUI_MOONGLADE = "Reflet-de-Lune"
	FEEDBACKUI_MULGORE = "Mulgore"
	FEEDBACKUI_ORGRIMMAR = "Orgrimmar";
	FEEDBACKUI_SILITHUS = "Silithus";
	FEEDBACKUI_STONETALON = "Serres-rocheuses"
	FEEDBACKUI_TANARIS = "Tanaris";
	FEEDBACKUI_TELDRASSIL = "Teldrassil";
	FEEDBACKUI_THUNDERBLUFF = "Les Pitons du tonnerre"
	FEEDBACKUI_THOUSANDNEEDLES = "Les Mille pointes"
	FEEDBACKUI_UNGORO = "Cratère d'Un'Goro"
	FEEDBACKUI_WARSONG = "Goulet des Chanteguerres"
	FEEDBACKUI_WINTERSPRING = "Berceau-de-l'hiver" 
	FEEDBACKUI_STRKALIMDOR = "Cela se produit en Kalimdor"
	--End Kalimdor
	
	--Outland
	FEEDBACKUI_OUTLANDS = "Outreterre"
	FEEDBACKUI_BLADESEDGE = "Les Tranchantes"
	FEEDBACKUI_HELLFIRE = "Péninsule des Flammes infernales"
	FEEDBACKUI_NAGRAND = "Nagrand"
	FEEDBACKUI_NETHERSTORM = "Raz-de-Néant"
	FEEDBACKUI_SHADOWMOON = "Vallée d'Ombrelune"
	FEEDBACKUI_SHATTRATH = "Shattrath"
	FEEDBACKUI_TERROKAR = "Forêt de Terokkar"
	FEEDBACKUI_TWISTINGNETHER = "Néant distordu"
	FEEDBACKUI_ZANGARMARSH = "Marécage de Zangar"
	FEEDBACKUI_STROUTLANDS = "Cela se produit en Outreterre."
	--End Outland
	
	--Alert Targets/Extra Areas
	FEEDBACKUI_BLACKTEMPLE = "Temple noir"
	FEEDBACKUI_KAJA = "Kaja'mine"
	FEEDBACKUI_ZULAMAN = "Zul'Aman"
	FEEDBACKUI_SUNWELLPLATEAU = "Plateau du Puits de soleil"
	FEEDBACKUI_MAGISTERSTERRACE = "Terrasse des Magistères"
	FEEDBACKUI_UTGARDEKEEP = "Donjon d'Utgarde"
	FEEDBACKUI_DRAKTHARONKEEP = "Donjon de Drak'Tharon"
	FEEDBACKUI_ULDUAR = "Ulduar"
	FEEDBACKUI_HOL = "Les salles de Foudre"
	FEEDBACKUI_TAC = "Le colisée d'Argent"
	FEEDBACKUI_IOC = "Île des Conquérants"
	--End Alert Targets
	--End Area Strings--------------------------------------------------------------------------------------------------------------------------------------------
	
	FEEDBACKUI_WHENTABLEHEADER = FEEDBACKUI_WHITE .. "Quand" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHENTABLESUBTEXT = "Quelle est la fréquence du problème ?"
	
	FEEDBACKUI_STRREPRODUCABLE = "Cela se produit tout le temps."
	FEEDBACKUI_STRSOMETIMES = "Cela se produit de temps en temps."
	FEEDBACKUI_STRRARELY = "Cela se produit rarement."
	FEEDBACKUI_STRONETIME = "Cela s'est produit une seule fois."
	
	
	FEEDBACKUI_REPRODUCABLE = "Tout le temps"
	FEEDBACKUI_SOMETIMES = "De temps en temps"
	FEEDBACKUI_RARELY = "Rarement"
	FEEDBACKUI_ONETIME = "Une seule fois"
	
	FEEDBACKUI_TYPETABLEHEADER = FEEDBACKUI_WHITE .. "Type" .. FEEDBACKUI_WHITE
	FEEDBACKUI_TYPETABLESUBTEXT = "De quel type est ce problème ?"
	
	FEEDBACKUI_STRUIOTHER = "C'est un problème d'interface utilisateur."
	FEEDBACKUI_STRUIITEMS = "- C'est un problème d'UI de l'objet"
	FEEDBACKUI_STRUISPAWNS = "- C'est un problème d'IU créature."
	FEEDBACKUI_STRUIQUESTS = "- C'est un problème d'IU quête."
	FEEDBACKUI_STRUISPELLS = "- C'est un problème d'IU d'un sort ou talent."
	FEEDBACKUI_STRUITRADESKILLS = "- C'est un problème d'IU artisanat."
	
	FEEDBACKUI_STRGRAPHICOTHER = "C'est un problème graphique."
	FEEDBACKUI_STRGRAPHICITEMS = "- C'est un problème graphique d'un objet."
	FEEDBACKUI_STRGRAPHICSPAWNS = "- C'est un problème graphique créature."
	FEEDBACKUI_STRGRAPHICSPELLS = "- C'est un problème graphique d'un sort ou talent."
	FEEDBACKUI_STRGRAPHICENVIRONMENT = "- C'est un problème graphique d'environnement."
	
	FEEDBACKUI_STRFUNCOTHER = "C'est un problème fonctionnel."
	FEEDBACKUI_STRFUNCITEMS = "- C'est un problème fonctionnel d'objet."
	FEEDBACKUI_STRFUNCSPAWNS = "- C'est un problème fonctionnel d'une créature."
	FEEDBACKUI_STRFUNCQUESTS = "- C'est un problème fonctionnel de quête."
	FEEDBACKUI_STRFUNCSPELLS = "- C'est un problème fonctionnel de sort ou talent."
	FEEDBACKUI_STRFUNCTRADESKILLS = "- C'est un problème fonctionnel d'artisanat."
	
	FEEDBACKUI_STRCRASHOTHER = "C'est un problème de stabilité."
	FEEDBACKUI_STRCRASHBUG = "- Il fait un planter WoW."
	FEEDBACKUI_STRCRASHSOFTLOCK = "- Il fige WoW."
	FEEDBACKUI_STRCRASHHARDLOCK = "- Il fige mon ordinateur."
	FEEDBACKUI_STRCRASHWOWLAG = "- Il est lié à la latence."
	
	FEEDBACKUI_UIITEMS = "Problème d'IU objet"
	FEEDBACKUI_UISPAWNS = "Problème d'IU créature"
	FEEDBACKUI_UIQUESTS = "Problème d'IU quête"
	FEEDBACKUI_UISPELLS = "Problème d'IU sort ou talent"
	FEEDBACKUI_UITRADESKILLS = "Problème d'IU artisanat"
	FEEDBACKUI_UIOTHER = "Problème d'IU général"
	
	FEEDBACKUI_GRAPHICITEMS = "Problème graphique objet"
	FEEDBACKUI_GRAPHICSPAWNS = "Problème graphique créature"
	FEEDBACKUI_GRAPHICSPELLS = "Problème graphique sort ou talent"
	FEEDBACKUI_GRAPHICENVIRONMENT = "Problème graphique environnement"
	FEEDBACKUI_GRAPHICOTHER = "Problème graphique général"
	
	FEEDBACKUI_FUNCITEMS = "Problème fonctionnel objet"
	FEEDBACKUI_FUNCSPAWNS = "Problème fonctionnel créature"
	FEEDBACKUI_FUNCQUESTS = "Problème fonctionnel quête"
	FEEDBACKUI_FUNCSPELLS = "Problème fonctionnel sort ou talent"   
	FEEDBACKUI_FUNCTRADESKILLS = "Problème fonctionnel artisanat"
	FEEDBACKUI_FUNCOTHER = "Problème fonctionnel général"
	
	FEEDBACKUI_SPELLSPOWERTABLEHEADER = "Puissance"
	FEEDBACKUI_SPELLSPOWERTABLESUBTEXT = "Quelle est la puissance de cette capacité ?"
	FEEDBACKUI_SPELLSFREQUENCYTABLEHEADER = "Fréquence"
	FEEDBACKUI_SPELLSFREQUENCYTABLESUBTEXT = "A quelle fréquence comptez-vous utiliser cette capacité ?"
	FEEDBACKUI_SPELLSAPPROPRIATETABLEHEADER = "Pertinence"
	FEEDBACKUI_SPELLSAPPROPRIATETABLESUBTEXT = "Comment s’intègre-t-elle à des capacités similaires?"
	FEEDBACKUI_SPELLSFUNTABLEHEADER = "Amusement"
	FEEDBACKUI_SPELLSFUNTABLESUBTEXT = "Cette capacité est-elle amusante à utiliser ?"
	
	FEEDBACKUI_STRPOWER1 = "Très faible";
	FEEDBACKUI_STRPOWER2 = "Faible";
	FEEDBACKUI_STRPOWER3 = "Puissante";
	FEEDBACKUI_STRPOWER4 = "Très puissante";
	
	FEEDBACKUI_STRFREQUENCY1 = "Rarement";
	FEEDBACKUI_STRFREQUENCY2 = "Parfois";
	FEEDBACKUI_STRFREQUENCY3 = "Souvent";
	FEEDBACKUI_STRFREQUENCY4 = "Dès que possible";
	
	FEEDBACKUI_STRAPPROPRIATE1 = "Pas pertinente";
	FEEDBACKUI_STRAPPROPRIATE2 = "Peu pertinente";
	FEEDBACKUI_STRAPPROPRIATE3 = "Pertinente";
	FEEDBACKUI_STRAPPROPRIATE4 = "Très pertinente";
	
	FEEDBACKUI_SPELLHEADERTEXT = "Sorts"
	FEEDBACKUILBLPOWER_TEXT = "Puissance :"
	FEEDBACKUILBLFREQUENCY_TEXT = "Fréquence :"
	FEEDBACKUILBLAPPROPRIATE_TEXT = "Pertinence :"
	
	FEEDBACKUI_CRASHBUG = "Le problème fait planter WoW"
	FEEDBACKUI_CRASHSOFTLOCK = "Le problème fige WoW"
	FEEDBACKUI_CRASHHARDLOCK = "Le problème fige l'ordinateur"
	FEEDBACKUI_CRASHWOWLAG = "Le problème cause de la latence"
	FEEDBACKUI_CRASHOTHER = "Problème de stabilité général"
	
	FEEDBACKUILBLFRMCLARITY_TEXT = "Clarté : "
	FEEDBACKUILBLFRMDIFFICULTY_TEXT = "Difficulté : "
	FEEDBACKUILBLFRMREWARD_TEXT = "Récompenses : "
	FEEDBACKUILBLFRMFUN_TEXT = "Amusement : "
	FEEDBACKUISURVEYTYPE_QUEST = "Quête"
	FEEDBACKUISURVEYTYPE_AREA = "Instance"
	
	FEEDBACKUISKIP_TEXT = "Passer"
	FEEDBACKUILBLSURVEYALERTSCHECK_TEXT = "Voir alertes"
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "Veuillez choisir une enquête."
	FEEDBACKUI_WELCOMETABLESURVEYSUBTEXT = "Vos avancées feront l'objet d'autres enquêtes."
	
	FEEDBACKUI_SURVEYCOLUMNNAME = "Nom"
	FEEDBACKUI_SURVEYCOLUMNMODIFIED = "Essayée"
	
	FEEDBACKUI_ALLHEADERTEXT = "Tout"
	FEEDBACKUI_AREAHEADERTEXT = "Instances"
	FEEDBACKUI_QUESTHEADERTEXT = "Quêtes"
	
	FEEDBACKUI_STATUSALLTEXT = "Toutes"
	FEEDBACKUI_STATUSAVAILABLETEXT = "Disponibles"
	FEEDBACKUI_STATUSSKIPPEDTEXT = "Passées"
	FEEDBACKUI_STATUSCOMPLETEDTEXT = "Terminées"
	
	FEEDBACKUI_SURVEYTOOLTIPQUESTHEADER = "Nom de la quête :"
	FEEDBACKUI_SURVEYTOOLTIPAREAHEADER = "Nom de l'instance :"
	FEEDBACKUI_SURVEYTOOLTIPEXPERIENCEDHEADER = "Il y a :"
	FEEDBACKUI_SURVEYTOOLTIPQUESTOBJECTIVESHEADER = "Objectifs de la quête :"
	
	FEEDBACKUI_NEW = "Nouvelle"
	FEEDBACKUI_HOURAGO = " heure"
	FEEDBACKUI_HOURSAGO = " heures"
	FEEDBACKUI_DAYAGO = " jour"
	FEEDBACKUI_DAYSAGO = " jours"
	FEEDBACKUI_MONTHAGO = " mois"
	FEEDBACKUI_MONTHSAGO = " mois"
	FEEDBACKUI_YEARAGO = " an"
	FEEDBACKUI_YEARSAGO = " ans"
	
	FEEDBACKUI_QUESTSCLARITYTABLEHEADER = "Clarté"
	FEEDBACKUI_QUESTSCLARITYTABLESUBTEXT = "Les objectifs de la quête étaient-ils clairs ?"
	
	FEEDBACKUI_STRCLARITY1 = "Très vagues"
	FEEDBACKUI_STRCLARITY2 = "Assez vagues"
	FEEDBACKUI_STRCLARITY3 = "Plutôt clairs"
	FEEDBACKUI_STRCLARITY4 = "Parfaitement clairs"
	
	FEEDBACKUI_CLARITY1 = "Très vague"
	FEEDBACKUI_CLARITY2 = "Assez vague"
	FEEDBACKUI_CLARITY3 = "Plutôt clair"
	FEEDBACKUI_CLARITY4 = "Parfaitement clair"
	
	FEEDBACKUI_QUESTSDIFFICULTYTABLEHEADER = "Difficulté"
	FEEDBACKUI_QUESTSDIFFICULTYTABLESUBTEXT = "La quête était-elle difficile ?"
	FEEDBACKUI_AREASDIFFICULTYTABLEHEADER = "Difficulté"
	FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT = "Les épreuves de l'instance étaient-elles dures ?"
	
	FEEDBACKUI_STRDIFFICULTY1 = "Facile"
	FEEDBACKUI_STRDIFFICULTY2 = "Faisable"
	FEEDBACKUI_STRDIFFICULTY3 = "Coriace"
	FEEDBACKUI_STRDIFFICULTY4 = "Difficile"
	FEEDBACKUI_STRDIFFICULTY5 = "N/A"
	
	FEEDBACKUI_DIFFICULTY1 = "Facile"
	FEEDBACKUI_DIFFICULTY2 = "Faisable"
	FEEDBACKUI_DIFFICULTY3 = "Coriace"
	FEEDBACKUI_DIFFICULTY4 = "Difficile"
	FEEDBACKUI_DIFFICULTY5 = "N/A"
	
	FEEDBACKUI_QUESTSREWARDTABLEHEADER = "Récompense"
	FEEDBACKUI_QUESTSREWARDTABLESUBTEXT = "Comment trouvez-vous la récompense de quête ?"
	FEEDBACKUI_AREASREWARDTABLEHEADER = "Récompense"
	FEEDBACKUI_AREASREWARDTABLESUBTEXT = "Que pensez-vous des récompenses de l'instance ?"
	
	FEEDBACKUI_STRREWARD1 = "Nulle"
	FEEDBACKUI_STRREWARD2 = "Insatisfaisante"
	FEEDBACKUI_STRREWARD3 = "Bonne"
	FEEDBACKUI_STRREWARD4 = "Excellente"
	FEEDBACKUI_STRREWARD5 = "N/A"
	
	FEEDBACKUI_REWARD1 = "Nulles"
	FEEDBACKUI_REWARD2 = "Insatisfaisantes"
	FEEDBACKUI_REWARD3 = "Bonnes"
	FEEDBACKUI_REWARD4 = "Excellentes"
	FEEDBACKUI_REWARD5 = "N/A"
	
	FEEDBACKUI_QUESTSFUNTABLEHEADER = "Amusement"
	FEEDBACKUI_QUESTSFUNTABLESUBTEXT = "La quête était-elle amusante ?"
	FEEDBACKUI_AREASFUNTABLEHEADER = "Amusement"
	FEEDBACKUI_AREASFUNTABLESUBTEXT = "L'instance était-elle amusante ?"
	
	FEEDBACKUI_STRFUN1 = "Pas amusante du tout"
	FEEDBACKUI_STRFUN2 = "Pas très amusante"
	FEEDBACKUI_STRFUN3 = "Plutôt amusante"
	FEEDBACKUI_STRFUN4 = "Très amusante"
	
	FEEDBACKUI_FUN1 = "Pas amusante du tout"
	FEEDBACKUI_FUN2 = "Pas très amusante"
	FEEDBACKUI_FUN3 = "Plutôt amusante"
	FEEDBACKUI_FUN4 = "Très amusante"
	
	--FEEDBACKUISURVEYFRMINPUTBOX_TEXT = "<Indiquez ici tout autre remarque que vous souhaitez nous communiquer>"
	FEEDBACKUISURVEYFRMINPUTBOX_TEXT = "<Indiquez ici toute autre remarque que vous souhaitez nous communiquer>"
	FEEDBACKUI_SURVEYINPUTHEADER = "Merci d'indiquer vos remarques"
	FEEDBACKUIRESUBMIT_TEXT = "Reposter"
	
	FEEDBACKUI_WELCOMETABLEBUGHEADER = "Signaler un bug"
	FEEDBACKUI_WELCOMETABLEBUGSUBTEXT = "Signaler les bugs nous aide à corriger le jeu"
	FEEDBACKUI_WELCOMETABLESUGGESTHEADER = "Faire une suggestion"
	FEEDBACKUI_WELCOMETABLESUGGESTSUBTEXT = "Vos idées nous aident à améliorer le jeu"
	FEEDBACKUI_BUGINPUTHEADER = "Comment reproduire ce bug ?"
	FEEDBACKUI_SUGGESTINPUTHEADER = "Veuillez décrire votre suggestion"
	
	FEEDBACKUI_SURVEYNEWBIETEXT = "Cliquez ici pour completer le questionnaire relatif à une instance ou une quête que vous avez récement terminée." 
	FEEDBACKUI_POIMASK = "%w+%s%-%s(.+)"
	
	
	FEEDBACKUI_LEVELPREFIX = "Niveau"
	FEEDBACKUI_HILLSBRAD = "Royaumes de l'est - Contreforts de Hautebrande";
	FEEDBACKUISURVEYTYPE_AREA = "Zone"
	FEEDBACKUISURVEYTYPE_ITEM = "Objet"
	FEEDBACKUISURVEYTYPE_MOB = "Monstre"
	FEEDBACKUI_AREAHEADERTEXT = "Zones"
	FEEDBACKUI_QUESTHEADERTEXT = "Quêtes"
	FEEDBACKUI_ITEMHEADERTEXT = "Objets"
	FEEDBACKUI_MOBHEADERTEXT = "Monstres"
	FEEDBACKUI_SURVEYTOOLTIPAREAHEADER = "Nom de zone:"
	FEEDBACKUI_AREASDIFFICULTYTABLEHEADER = "Difficulté"
	FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT = "Quelle était la difficulté des rencontres de la zone ?"
	FEEDBACKUI_AREASREWARDTABLEHEADER = "Récompense"
	FEEDBACKUI_AREASREWARDTABLESUBTEXT = "Comment évaluez-vous les récompenses de la zone ?"
	FEEDBACKUI_AREASFUNTABLEHEADER = "Amusement"
	FEEDBACKUI_AREASFUNTABLESUBTEXT = "Avez-vous eu plaisir à jouer dans cette zone ?"
	FEEDBACKUI_SURVEYINPUTSUBTEXT = "Cliquez ici pour avoir des exemples de retour"
	FEEDBACKUI_SURVEYNEWBIETEXT = "Cliquez ici pour remplir un sondage sur cette expérience."
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "Veuillez choisir un sondage"
	
	FEEDBACKUI_SPECIFICWELCOME = "Merci de nous fournir un retour sur " .. project_name .. ". Vous avez choisi de donner un retour sur :\n\n\n\n\nPour continuer, veuillez choisir l’une des options suivantes :";
	FEEDBACKUI_GENERALWELCOME = "Merci de nous fournir un retour sur " .. project_name .. ". Tous les commentaires reçus servent à améliorer la qualité de " .. project_name .. ".\n\nPour continuer, veuillez choisir l’une des options suivantes :";
	
	FEEDBACKUI_STARTBUG = "Signaler un bug"
	FEEDBACKUI_STARTSURVEY = "Commencer un sondage"
	FEEDBACKUI_STARTSUGGESTION = "Faire une suggestion"
	
	FEEDBACKUI_WELCOMEBUGHEADER = "Bug"
	FEEDBACKUI_WELCOMESUGGESTHEADER = "Suggestion"
	FEEDBACKUI_WELCOMESURVEYHEADER = "Sondage"
	
	FEEDBACKUI_WELCOMEBUGTEXT = "Un bug nous informe d'une erreur constatée dans le jeu." 
	FEEDBACKUI_WELCOMESUGGESTTEXT = "Une suggestion nous indique de quelle façon vous aimeriez que le jeu soit amélioré."
	FEEDBACKUI_WELCOMESURVEYTEXT = "Un sondage vous permet de nous envoyer un retour sur une partie du jeu."
	FEEDBACKUI_WELCOMESURVEYDISABLED = "Aucun sondage disponible à ce sujet pour le moment."
	
	FEEDBACKUI_MODIFIERKEY = "Raccourcis:"
	FEEDBACKUI_MOUSE1 = "Clic gauche"
	FEEDBACKUI_MOUSE2 = "Clic droit"
	
	FEEDBACKUI_LALT = "Alt gauche"
	FEEDBACKUI_RALT = "Alt droit"
	FEEDBACKUI_LCTRL = "Ctrl gauche"
	FEEDBACKUI_RCTRL = "Ctrl droit"
	FEEDBACKUI_LSHIFT = "Maj gauche"
	FEEDBACKUI_RSHIFT = "Maj droit"
	
	FEEDBACKUI_TOOLTIP_MESSAGE = "<%s+%s pour un retour>";
	FEEDBACKUI_MAP_MESSAGE = "%s+%s gauche sur la carte pour un retour";
	FEEDBACKUI_ITEMTARGETS = { "Armure", "Consommable", "Conteneur", "Projectile", "Carquois", "Arme", "Recette", "Gemme" };
	FEEDBACKUI_MISCTYPE = "Divers";
	FEEDBACKUISHOWCUES_TEXT = "Voir les bulles d'aide";
	
	FEEDBACKUI_CATEGORYLABEL = "Type :"
	FEEDBACKUI_STATUSLABEL = "Statut :"
	
	NEWBIE_TOOLTIP_BUG="Aidez-nous à améliorer " .. project_name .. " en nous signalant un bug, en faisant une suggestion ou en répondant à un sondage.\n\n" .. FEEDBACKUI_BLUE .. "Clic gauche pour commencer.\nClic droit pour afficher les options.";
	FEEDBACKUILBLAPPEARANCE_TEXT = "Apparence :"
	FEEDBACKUILBLUTILITY_TEXT = "Utilité :"
	
	FEEDBACKUI_MOBSDIFFICULTYTABLEHEADER = "Difficulté"                   
	FEEDBACKUI_MOBSDIFFICULTYTABLESUBTEXT = "Ce monstre était-il difficile à tuer ?"
	FEEDBACKUI_MOBSREWARDTABLEHEADER = "Récompense"
	FEEDBACKUI_MOBSREWARDTABLESUBTEXT = "Comment jugez-vous la récompense donnée par le monstre ?"
	FEEDBACKUI_MOBSFUNTABLEHEADER = "Amusement"
	FEEDBACKUI_MOBSFUNTABLESUBTEXT = "La rencontre avec ce monstre était-elle plaisante ?"
	FEEDBACKUI_MOBSAPPEARANCETABLEHEADER = "Apparence"
	FEEDBACKUI_MOBSAPPEARANCETABLESUBTEXT = "Comment jugez-vous l'apparence de ce monstre ?"
	
	FEEDBACKUI_ITEMSDIFFICULTYTABLEHEADER = "Difficulté"
	FEEDBACKUI_ITEMSDIFFICULTYTABLESUBTEXT = "Cet objet était-il difficile à obtenir ?"
	FEEDBACKUI_ITEMSUTILITYHEADER = "Utilité"
	FEEDBACKUI_ITEMSUTILITYSUBTEXT = "Cet objet est-il utile, en général ?"
	FEEDBACKUI_ITEMSAPPEARANCETABLEHEADER = "Apparence"
	FEEDBACKUI_ITEMSAPPEARANCETABLESUBTEXT = "Comment jugez-vous l'apparence de cet objet ?"
	
	FEEDBACKUI_STRUTILITY1 = "Complètement inutile"
	FEEDBACKUI_STRUTILITY2 = "Plutôt inutile"
	FEEDBACKUI_STRUTILITY3 = "Utile"
	FEEDBACKUI_STRUTILITY4 = "Très utile"
	
	FEEDBACKUI_UTILITY1 = "Complètement inutile"
	FEEDBACKUI_UTILITY2 = "Plutôt inutile"
	FEEDBACKUI_UTILITY3 = "Utile"
	FEEDBACKUI_UTILITY4 = "Très utile"
	
	FEEDBACKUI_STRAPPEARANCE1 = "Mauvais(e)"
	FEEDBACKUI_STRAPPEARANCE2 = "Médiocre"
	FEEDBACKUI_STRAPPEARANCE3 = "Bon(ne)"
	FEEDBACKUI_STRAPPEARANCE4 = "Remarquable"
	
	FEEDBACKUI_APPEARANCE1 = "Mauvais(e)"
	FEEDBACKUI_APPEARANCE2 = "Médiocre"
	FEEDBACKUI_APPEARANCE3 = "Bon(ne)"
	FEEDBACKUI_APPEARANCE4 = "Remarquable"
	
	FEEDBACKUI_POIUNDERCITY = "Fossoyeuse";
	FEEDBACKUI_POISILVERMOON = "Lune-d'argent";
	FEEDBACKUI_POIIRONFORGE = "Forgefer";
	FEEDBACKUI_POISTORMWIND = "Hurlevent";
	FEEDBACKUI_POISEPULCHER = "Le Sépulcre";
	FEEDBACKUI_POITARRENMILL = "Moulin-de-Tarren";
	FEEDBACKUI_POISOUTHSHORE = "Austrivage";
	FEEDBACKUI_POIAERIEPEAK = "Nid-de-l'aigle";
	FEEDBACKUI_POIREVANTUSK = "Village des Vengebroches";
	FEEDBACKUI_POIHAMMERFALL = "Trépas-d'Orgrim";
	FEEDBACKUI_POIMENETHIL = "Port de Menethil";
	FEEDBACKUI_POITHELSAMAR = "Thelsamar";
	FEEDBACKUI_POIKARGATH = "Kargath";
	FEEDBACKUI_POILAKESHIRE = "Comté-du-lac";
	FEEDBACKUI_POISENTINELHILL = "Colline des sentinelles";
	FEEDBACKUI_POIDARKSHIRE = "Sombre-comté";
	FEEDBACKUI_POISTONARD = "Pierrêche";
	FEEDBACKUI_POIGROMGOL = "Campement Grom'gol";
	
	
	FEEDBACKUI_POIDARNASSUS = "Darnassus";
	FEEDBACKUI_POIEXODAR = "L'Exodar";
	FEEDBACKUI_POIORGRIMMAR = "Orgrimmar";
	FEEDBACKUI_POITHUNDERB = "Les Pitons du tonnerre";
	FEEDBACKUI_POIAUBERDINE = "Auberdine";
	FEEDBACKUI_POIEVERLOOK = "Long-guet";
	FEEDBACKUI_POISTONETALON = "Pic des Serres-rocheuses";
	FEEDBACKUI_POIASTRANAAR = "Astranaar";
	FEEDBACKUI_POISPLINTERTREE = "Poste de Bois-brisé";
	FEEDBACKUI_POISUNROCK = "Retraite de Roche-soleil";
	FEEDBACKUI_POINIJELS = "Combe de Nijel";
	FEEDBACKUI_POISHADOWPREY = "Proie-de-l'ombre";
	FEEDBACKUI_POIFEATHERMOON = "Bastion de Pennelune";
	FEEDBACKUI_POIMOJACHE = "Camp Mojache";
	FEEDBACKUI_POITHALANAAR = "Thalanaar";
	FEEDBACKUI_POICENARIONHOLD = "Fort cénarien";
	FEEDBACKUI_POIGADGET = "Gadgetzan";
	FEEDBACKUI_POIFREEWIND = "Poste de Librevent";
	FEEDBACKUI_POITAURAJO = "Camp Taurajo";
	FEEDBACKUI_POICROSSROADS = "La Croisée";
	FEEDBACKUI_POIRATCHET = "Cabestan";
	FEEDBACKUI_POITHERAMORE = "Île de Theramore";
	
	FEEDBACKUI_SURVEYTOOLTIPMOBHEADER = "Nom du monstre :"
	FEEDBACKUI_SURVEYTOOLTIPMOBZONEHEADER = "Se trouve à :"
	
	FEEDBACKUI_VOICECHAT = "Discussion vocale";
	FEEDBACKUI_VOICECHATTOOLTIP = FEEDBACKUI_WHITE .. FEEDBACKUI_VOICECHAT;
	FEEDBACKUI_STRVOICECHAT = "C'est un problème de discussion vocale.";
	FEEDBACKUI_HEADSETTYPE = "Quelle sorte de casque multimedia utilisez vous ?";
	
	FEEDBACKUI_USBHEADSET = "Casque USB"; --localize me
	FEEDBACKUI_ANALOGHEADSET = "Casque analogique"; --localize me
	FEEDBACKUI_HARDWIREDMIC = "Microphone à fil"; --localize me
	
	FEEDBACKUI_STRUSBHEADSET = "J'utilise un casque USB.";
	FEEDBACKUI_STRANALOGHEADSET = "J'utilise un casque Analogique.";
	FEEDBACKUI_STRHARDWIREDMIC = "J’utilise un microphone à fil."; --localize me
	
elseif ( GetLocale() == "koKR" ) then
	--Localized Korean strings for FEEDBACKUI
	--[[
	function koKR() end
	]]--
	--Non-instance special zone names
	FEEDBACKUI_EXCEPTIONZONES = { "??? ???", "??? ??", "??? ??", "?? ??", "??", "??? ??", "??? ??", "???? ??", "???? ?", "??? ??", "????? ??", }
	
	--Headers    
	FEEDBACKUIINFOPANELLABEL_TEXT = "????? ??"
	FEEDBACKUI_BUGINPUTHEADER = "??? ?? ??? ??? ????."
	FEEDBACKUI_SUGGESTINPUTHEADER = "??? ??? ????."
	FEEDBACKUI_SURVEYINPUTHEADER = "??? ???? ??? ??? ?? ????."
	
	--Labels
	FEEDBACKUIFEEDBACKFRMTITLE_TEXT = "?? ???"
	FEEDBACKUILBLFRMVER_TEXT = "??:"
	FEEDBACKUILBLFRMREALM_TEXT = "??:"
	FEEDBACKUILBLFRMNAME_TEXT = "??? ??:"
	FEEDBACKUILBLFRMCHAR_TEXT = "??? ??:"
	FEEDBACKUILBLFRMMAP_TEXT = "??:"
	FEEDBACKUILBLFRMZONE_TEXT = "??:"
	FEEDBACKUILBLFRMAREA_TEXT = "??:"
	FEEDBACKUILBLFRMADDONS_TEXT = "???:"
	FEEDBACKUILBLADDONSWRAP_TEXT = "?? ?? ?? ???:\n"
	FEEDBACKUITYPEBUG_TEXT = "??"
	FEEDBACKUITYPESUGGEST_TEXT = "??"
	FEEDBACKUITYPESURVEY_TEXT = "??"
	FEEDBACKUILBLFRMWHO_TEXT = "??: "
	FEEDBACKUILBLFRMWHERE_TEXT = "??: "
	FEEDBACKUILBLFRMWHEN_TEXT = "??: "
	FEEDBACKUILBLFRMTYPE_TEXT = "??: "
	
	--Prompts
	FEEDBACKUIBUGFRMINPUTBOX_TEXT = "<??? ?????? ??? ?? ????.>"
	FEEDBACKUISUGGESTFRMINPUTBOX_TEXT = "<??? ?? ????.>"
	FEEDBACKUISURVEYFRMINPUTBOX_TEXT = "<??? ?? ????>"
	FEEDBACKUILBLADDONS_MOUSEOVER = "<?? ?? ??? ??>"
	FEEDBACKUI_CONFIRMATION = "??? ???????.\n?? ?? ?? ?? ?????? ? ? ??? ??? ??? ?????."
	
	--Tooltips & Buttons
	BUG_BUTTON="?? ???"
	NEWBIE_TOOLTIP_BUG="?? ?? ?? ?? ?????? ? ? ??? ???? ???? ?? ?? ??? ?? ????."
	FEEDBACKUIBACK_TEXT = "????"
	FEEDBACKUIRESET_TEXT = "????"
	FEEDBACKUISUBMIT_TEXT = "???"
	FEEDBACKUISTART_TEXT = "????"
	FEEDBACKUIRESUBMIT_TEXT = "?? ???"
	
	--Tables and strings for navigation.
	FEEDBACKUI_GENDERTABLE = { "???", "??", "??" }
	
	FEEDBACKUI_WELCOMETABLEBUGHEADER = "?? ???"
	FEEDBACKUI_WELCOMETABLEBUGSUBTEXT = "??? ????? ?? ??? ???? ? ?? ??? ???."
	FEEDBACKUI_WELCOMETABLESUGGESTHEADER = "?? ???"
	FEEDBACKUI_WELCOMETABLESUGGESTSUBTEXT = "??? ????? ?? ??? ???? ? ?? ??? ???."
	FEEDBACKUI_WELCOMETABLESUBTEXT = "???? ??? ?? ????!"
	
	FEEDBACKUI_WELCOME = "?? ?? ?????? ?? ??? ???? ?? ?? ????. ???? ??? ??? ?? ?? ?? ?? ?????? ???? ? ???? ??? ????.\n\n?? ??? ????? ???? ? ??? ? ? ??? ? ?? ??? ?? ?????.\n\n?????.\n???? ?????? ??"
	
	FEEDBACKUI_WHOTABLEHEADER = FEEDBACKUI_WHITE .. "??" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHOTABLESUBTEXT = "??? ??? ??????"
	
	FEEDBACKUI_STRWHOPLAYER = "? ??? ?????."
	FEEDBACKUI_STRPARTYMEMBER = "??? ?????."
	FEEDBACKUI_STRRAIDMEMBER = "???? ?????."
	FEEDBACKUI_STRENEMYPLAYER = "?? ?? ???? ?????."
	FEEDBACKUI_STRFRIENDLYPLAYER = "?? ?? ???? ?????."
	FEEDBACKUI_STRENEMYCREATURE = "? NPC ?????."
	FEEDBACKUI_STRFRIENDLYCREATURE = "?? NPC ?????."
	FEEDBACKUI_STRWHONA = "????? NPC? ?? ?? ?????."
	
	FEEDBACKUI_WHOPLAYER = "?? ???"
	FEEDBACKUI_ENEMYPLAYER = "?? ?? ????"
	FEEDBACKUI_FRIENDLYPLAYER = "?? ?? ????"
	FEEDBACKUI_PARTYMEMBER = "???"
	FEEDBACKUI_RAIDMEMBER = "????"
	FEEDBACKUI_ENEMYCREATURE = "? NPC"
	FEEDBACKUI_FRIENDLYCREATURE = "?? NPC"
	FEEDBACKUI_WHONA = "?? ??"
	
	FEEDBACKUI_WHERETABLEHEADER = FEEDBACKUI_WHITE .. "??" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHERETABLESUBTEXT = "???? ???? ??????"
	
	FEEDBACKUI_STRAREATABLE = "?? ?? ?????."
	FEEDBACKUI_STRWHEREINSTALL = "?? ?????."
	FEEDBACKUI_STRWHEREDOWNLOAD = "???? ?????."
	FEEDBACKUI_STRWHEREPATCH = "?? ?????."
	
	FEEDBACKUI_WHEREINSTALL = "?? ??"
	FEEDBACKUI_WHEREDOWNLOAD = "???? ??"
	FEEDBACKUI_WHEREPATCH = "?? ??"
	
	FEEDBACKUI_AREATABLESUMMARY = FEEDBACKUI_GREEN .. "?? ?"
	
	--Area Strings-------------------------------------------------------------------------------------------------------------------------
	FEEDBACKUI_STROCCURS = "- This occurs in "; --localize me
	FEEDBACKUI_EVERYWHERE = "?? ? ?? ?"
	FEEDBACKUI_STREVERYWHERE = "?? ? ???? ?????."
	
	--AZEROTH
	FEEDBACKUI_AZEROTH = "????"
	
	--Northrend
	FEEDBACKUI_NORTHREND = "????"
	FEEDBACKUI_BOREANTUNDRA = "??? ?"
	FEEDBACKUI_CRYSTALSONG = "???? ?" --LOCALIZE ME
	FEEDBACKUI_DALARAN = "???" --LOCALIZE ME
	FEEDBACKUI_DRAGONBLIGHT = "?? ???"
	FEEDBACKUI_GRIZZLYHILLS = "?? ???"
	FEEDBACKUI_HOWLINGFJORD = "???? ??"
	FEEDBACKUI_ICECROWN = "????" --LOCALIZE ME
	FEEDBACKUI_NEXUS = "??? ?"
	FEEDBACKUI_SHOLAZARBASIN = "???? ??" --LOCALIZE ME
	FEEDBACKUI_STORMPEAKS = "??? ???" --LOCALIZE ME
	FEEDBACKUI_UTGARDEPINNACLE = "????? ??"
	FEEDBACKUI_WINTERGRASP = "?????" --LOCALIZE ME
	FEEDBACKUI_ZULDRAK = "???" --LOCALIZE ME
	FEEDBACKUI_STRNORTHREND = "?????? ?????."
	--End Northrend-----------------------------------
	
	--Eastern Kingdoms
	FEEDBACKUI_EKINGDOMS = "?? ??"
	FEEDBACKUI_ALTERACMOUNTAINS = "??? ??"
	FEEDBACKUI_ALTERACVALLEY = "??? ??"
	FEEDBACKUI_ARATHIBASIN = "??? ??"
	FEEDBACKUI_ARATHIHIGHLANDS = "??? ??"
	FEEDBACKUI_BADLANDS = "??? ?"
	FEEDBACKUI_BLACKROCKMOUNTAIN = "???? ?"
	FEEDBACKUI_BLASTEDLANDS = "???? ?"
	FEEDBACKUI_BURNINGSTEPPES = "??? ??"
	FEEDBACKUI_DEADWINDPASS = "??? ??"
	FEEDBACKUI_DUNMOROGH = "? ??"
	FEEDBACKUI_DUSKWOOD = "???"
	FEEDBACKUI_EPLAGUELANDS = "?? ????"
	FEEDBACKUI_ELWYNN = "?? ?"
	FEEDBACKUI_EVERSONG = "???? ?"
	FEEDBACKUI_GHOSTLANDS = "??? ?"
	FEEDBACKUI_HILLSBRAD = "?????"
	FEEDBACKUI_HINTERLANDS = "?? ???"
	FEEDBACKUI_IRONFORGE = "?????"
	FEEDBACKUI_ISLEOFQUELDANAS = "????? ?" --LOCALIZE ME
	FEEDBACKUI_LOCHMODAN = "?? ??"
	FEEDBACKUI_REDRIDGE = "???? ??"
	FEEDBACKUI_SEARINGGORGE = "????? ??"
	FEEDBACKUI_SILVERMOON = "???"
	FEEDBACKUI_SILVERPINE = "????? ?"
	FEEDBACKUI_STORMWIND = "????"
	FEEDBACKUI_STRANGLETHORN = "???? ???"
	FEEDBACKUI_SWAMPOFSORROWS = "??? ?"
	FEEDBACKUI_TIRISFAL = "???? ?"
	FEEDBACKUI_UNDERCITY = "????"
	FEEDBACKUI_WPLAGUELANDS = "?? ????"
	FEEDBACKUI_WESTFALL = "?? ????"
	FEEDBACKUI_WETLANDS = "???"
	FEEDBACKUI_STREKINGDOMS = "?? ???? ?????."
	--End Eastern Kingdoms-------------------------------------------------------------------------------------------------------
	
	--Kalimdor
	FEEDBACKUI_KALIMDOR = "????"
	FEEDBACKUI_ASHENVALE = "?? ???"
	FEEDBACKUI_AZSHARA = "????"
	FEEDBACKUI_AZUREMYST = "???? ?"
	FEEDBACKUI_BARRENS = "??? ?"
	FEEDBACKUI_BLOODMYST = "???? ?"
	FEEDBACKUI_DARKSHORE = "??? ??"
	FEEDBACKUI_DARNASSUS = "?????"
	FEEDBACKUI_DESOLACE = "??? ?"
	FEEDBACKUI_DUROTAR = "???"
	FEEDBACKUI_DUSTWALLOW = "???? ???"
	FEEDBACKUI_EXODAR = "????"
	FEEDBACKUI_FELWOOD = "??? ?"
	FEEDBACKUI_FERALAS = "????"
	FEEDBACKUI_MOONGLADE = "?? ?"
	FEEDBACKUI_MULGORE = "???"
	FEEDBACKUI_ORGRIMMAR = "????"
	FEEDBACKUI_SILITHUS = "????"
	FEEDBACKUI_STONETALON = "??? ??"
	FEEDBACKUI_TANARIS = "????"
	FEEDBACKUI_TELDRASSIL = "????"
	FEEDBACKUI_THUNDERBLUFF = "?? ???"
	FEEDBACKUI_THOUSANDNEEDLES = "???? ???"
	FEEDBACKUI_UNGORO = "??? ???"
	FEEDBACKUI_WARSONG = "???? ??"
	FEEDBACKUI_WINTERSPRING = "??? ??"
	FEEDBACKUI_STRKALIMDOR = "?????? ?????."
	--End Kalimdor ----------------------------------------------------------------------------------------------------------------------
	
	--OUTLAND
	FEEDBACKUI_OUTLANDS = "????"
	FEEDBACKUI_BLADESEDGE = "?? ??"
	FEEDBACKUI_HELLFIRE = "??? ??"
	FEEDBACKUI_NAGRAND = "????"
	FEEDBACKUI_NETHERSTORM = "??? ??"
	FEEDBACKUI_SHADOWMOON = "??? ???"
	FEEDBACKUI_SHATTRATH = "????"
	FEEDBACKUI_TERROKAR = "???? ?"
	FEEDBACKUI_TWISTINGNETHER = "??? ??"
	FEEDBACKUI_ZANGARMARSH = "??? ???"
	FEEDBACKUI_STROUTLANDS = "?????? ?????."
	--End Outlands--------------------------------------------
	
	--Alert Targets/Extra areas
	FEEDBACKUI_BLACKTEMPLE = "?? ??"
	FEEDBACKUI_ZULAMAN = "???"
	FEEDBACKUI_KAJA = "Kaja'mine"
	FEEDBACKUI_SUNWELLPLATEAU = "??? ??"
	FEEDBACKUI_MAGISTERSTERRACE = "????? ??"
	FEEDBACKUI_UTGARDEKEEP = "????? ??"
	FEEDBACKUI_DRAKTHARONKEEP = "???? ??"
	FEEDBACKUI_ULDUAR = "????"
	FEEDBACKUI_HOL = "??? ??"
	FEEDBACKUI_TAC = "?? ?????"
	FEEDBACKUI_IOC = "??? ?"
	--End Alert Targets/Extra areas
	--End Area Strings-------------------------------------------------------------------------------------------------------------------------------------
	
	FEEDBACKUI_WHENTABLEHEADER = FEEDBACKUI_WHITE .. "??" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHENTABLESUBTEXT = "??? ?? ???? ??????"
	
	FEEDBACKUI_STRREPRODUCABLE = "?? ?????."
	FEEDBACKUI_STRSOMETIMES = "?? ?????."
	FEEDBACKUI_STRRARELY = "?? ?????."
	FEEDBACKUI_STRONETIME = "? ? ? ??????."
	
	
	FEEDBACKUI_REPRODUCABLE = "??"
	FEEDBACKUI_SOMETIMES = "??"
	FEEDBACKUI_RARELY = "??"
	FEEDBACKUI_ONETIME = "? ?"
	
	FEEDBACKUI_TYPETABLEHEADER = FEEDBACKUI_WHITE .. "??" .. FEEDBACKUI_WHITE
	FEEDBACKUI_TYPETABLESUBTEXT = "?? ??? ??????"
	
	FEEDBACKUI_STRUIOTHER = "??? ????? ?????."
	FEEDBACKUI_STRUIITEMS = "- ??? UI ?????."
	FEEDBACKUI_STRUISPAWNS = "- NPC UI ?????."
	FEEDBACKUI_STRUIQUESTS = "- ??? UI ?????."
	FEEDBACKUI_STRUISPELLS = "- ?? ?? ?? UI ?????."
	FEEDBACKUI_STRUITRADESKILLS = "- ?? ?? UI ?????."
	
	FEEDBACKUI_STRGRAPHICOTHER = "??? ?????."
	FEEDBACKUI_STRGRAPHICITEMS = "- ??? ??? ?????."
	FEEDBACKUI_STRGRAPHICSPAWNS = "- NPC ??? ?????."
	FEEDBACKUI_STRGRAPHICSPELLS = "- ?? ?? ?? ??? ?????."
	FEEDBACKUI_STRGRAPHICENVIRONMENT = "- ?? ??? ?????."
	
	FEEDBACKUI_STRFUNCOTHER = "?? ?????."
	FEEDBACKUI_STRFUNCITEMS = "- ??? ?? ?????."
	FEEDBACKUI_STRFUNCSPAWNS = "- NPC ?? ?????."
	FEEDBACKUI_STRFUNCQUESTS = "- ??? ?? ?????."
	FEEDBACKUI_STRFUNCSPELLS = "- ?? ?? ?? ?? ?????."
	FEEDBACKUI_STRFUNCTRADESKILLS = "- ?? ?? ?? ?????."
	
	FEEDBACKUI_STRCRASHOTHER = "??? ?????."
	FEEDBACKUI_STRCRASHBUG = "- ??? ??? ?????."
	FEEDBACKUI_STRCRASHSOFTLOCK = "- ??? ?????."
	FEEDBACKUI_STRCRASHHARDLOCK = "- ???? ?????."
	FEEDBACKUI_STRCRASHWOWLAG = "- ? ?? ?????."
	
	FEEDBACKUI_UIITEMS = "??? UI ??"
	FEEDBACKUI_UISPAWNS = "NPC UI ??"
	FEEDBACKUI_UIQUESTS = "??? UI ??"
	FEEDBACKUI_UISPELLS = "?? ?? ?? UI ??"
	FEEDBACKUI_UITRADESKILLS = "?? ?? UI ??"
	FEEDBACKUI_UIOTHER = "?? UI ??"
	
	FEEDBACKUI_GRAPHICITEMS = "??? ??? ??"
	FEEDBACKUI_GRAPHICSPAWNS = "NPC ??? ??"
	FEEDBACKUI_GRAPHICSPELLS = "?? ?? ?? ??? ??"
	FEEDBACKUI_GRAPHICENVIRONMENT = "?? ??? ??"
	FEEDBACKUI_GRAPHICOTHER = "?? ??? ??"
	
	FEEDBACKUI_FUNCITEMS = "??? ?? ??"
	FEEDBACKUI_FUNCSPAWNS = "NPC ?? ??"
	FEEDBACKUI_FUNCQUESTS = "??? ?? ??"
	FEEDBACKUI_FUNCSPELLS = "?? ?? ?? ?? ??" 
	FEEDBACKUI_FUNCTRADESKILLS = "?? ?? ?? ??"
	FEEDBACKUI_FUNCOTHER = "?? ?? ??"
	
	FEEDBACKUI_SPELLSPOWERTABLEHEADER = "???"
	FEEDBACKUI_SPELLSPOWERTABLESUBTEXT = "? ??? ??? ??????"
	FEEDBACKUI_SPELLSFREQUENCYTABLEHEADER = "?? ??"
	FEEDBACKUI_SPELLSFREQUENCYTABLESUBTEXT = "? ??? ??? ?? ???????"
	FEEDBACKUI_SPELLSAPPROPRIATETABLEHEADER = "???"
	FEEDBACKUI_SPELLSAPPROPRIATETABLESUBTEXT = "? ??? ??? ??? ?? ??? ??? ? ??????"
	FEEDBACKUI_SPELLSFUNTABLEHEADER = "??"
	FEEDBACKUI_SPELLSFUNTABLESUBTEXT = "? ??? ??? ??????"
	
	FEEDBACKUI_STRPOWER1 = "?? ??";
	FEEDBACKUI_STRPOWER2 = "??";
	FEEDBACKUI_STRPOWER3 = "???";
	FEEDBACKUI_STRPOWER4 = "?? ???";
	
	FEEDBACKUI_STRFREQUENCY1 = "?? ?? ? ?";
	FEEDBACKUI_STRFREQUENCY2 = "?? ";
	FEEDBACKUI_STRFREQUENCY3 = "??";
	FEEDBACKUI_STRFREQUENCY4 = "??";
	
	FEEDBACKUI_STRAPPROPRIATE1 = "?? ???? ??";
	FEEDBACKUI_STRAPPROPRIATE2 = "?? ???? ??";
	FEEDBACKUI_STRAPPROPRIATE3 = "???";
	FEEDBACKUI_STRAPPROPRIATE4 = "?? ???";
	
	FEEDBACKUI_SPELLHEADERTEXT = "??" 
	FEEDBACKUILBLPOWER_TEXT = "???:"
	FEEDBACKUILBLFREQUENCY_TEXT = "?? ??:"
	FEEDBACKUILBLAPPROPRIATE_TEXT = "???:"
	
	FEEDBACKUI_CRASHBUG = "??? ?? ??"
	FEEDBACKUI_CRASHSOFTLOCK = "?? ?? ??"
	FEEDBACKUI_CRASHHARDLOCK = "??? ?? ??"
	FEEDBACKUI_CRASHWOWLAG = "? ??"
	FEEDBACKUI_CRASHOTHER = "?? ??? ??"
	
	
	FEEDBACKUILBLFRMCLARITY_TEXT = "???:"
	FEEDBACKUILBLFRMDIFFICULTY_TEXT = "???:"
	FEEDBACKUILBLFRMREWARD_TEXT = "??:"
	FEEDBACKUILBLFRMFUN_TEXT = "??:"
	FEEDBACKUISURVEYTYPE_QUEST = "???"
	FEEDBACKUISURVEYTYPE_AREA = "???? ??"
	
	FEEDBACKUISKIP_TEXT = "?? ????"
	FEEDBACKUILBLSURVEYALERTSCHECK_TEXT = "?? ??"
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "??? ??????."
	FEEDBACKUI_WELCOMETABLESURVEYSUBTEXT = "??? ???? ???? ?? ??? ?????."
	
	FEEDBACKUI_SURVEYCOLUMNNAME = "??"
	FEEDBACKUI_SURVEYCOLUMNMODIFIED = "??? ??"
	
	FEEDBACKUI_ALLHEADERTEXT = "??"
	FEEDBACKUI_AREAHEADERTEXT = "????"
	FEEDBACKUI_QUESTHEADERTEXT = "???"
	
	FEEDBACKUI_STATUSALLTEXT = "??"
	FEEDBACKUI_STATUSAVAILABLETEXT = "??? ??"
	FEEDBACKUI_STATUSSKIPPEDTEXT = "??? ??"
	FEEDBACKUI_STATUSCOMPLETEDTEXT = "??? ??"
	
	FEEDBACKUI_SURVEYTOOLTIPQUESTHEADER = "??? ??:"
	FEEDBACKUI_SURVEYTOOLTIPAREAHEADER = "???? ?? ??:"
	FEEDBACKUI_SURVEYTOOLTIPEXPERIENCEDHEADER = "??? ??:"
	FEEDBACKUI_SURVEYTOOLTIPQUESTOBJECTIVESHEADER = "??? ??:"
	
	FEEDBACKUI_NEW = "??? ???"
	FEEDBACKUI_HOURAGO = " ?? ?"
	FEEDBACKUI_HOURSAGO = " ?? ?"
	FEEDBACKUI_DAYAGO = " ? ?"
	FEEDBACKUI_DAYSAGO = " ? ?"
	FEEDBACKUI_MONTHAGO = " ?? ?"
	FEEDBACKUI_MONTHSAGO = " ?? ?"
	FEEDBACKUI_YEARAGO = " ? ?"
	FEEDBACKUI_YEARSAGO = " ? ?"
	
	FEEDBACKUI_QUESTSCLARITYTABLEHEADER = "??? ???"
	FEEDBACKUI_QUESTSCLARITYTABLESUBTEXT = "???? ?? ??? ??? ??????"
	
	FEEDBACKUI_STRCLARITY1 = "?? ???"
	FEEDBACKUI_STRCLARITY2 = "?? ???"
	FEEDBACKUI_STRCLARITY3 = "? ???"
	FEEDBACKUI_STRCLARITY4 = "?? ???"
	
	FEEDBACKUI_CLARITY1 = "?? ???"
	FEEDBACKUI_CLARITY2 = "?? ???"
	FEEDBACKUI_CLARITY3 = "? ???"
	FEEDBACKUI_CLARITY4 = "?? ???"
	
	FEEDBACKUI_QUESTSDIFFICULTYTABLEHEADER = "???"
	FEEDBACKUI_QUESTSDIFFICULTYTABLESUBTEXT = "???? ???? ?? ????????"
	FEEDBACKUI_AREASDIFFICULTYTABLEHEADER = "???"
	FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT = "???? ??? ???? ?? ????????"
	
	FEEDBACKUI_STRDIFFICULTY1 = "??"
	FEEDBACKUI_STRDIFFICULTY2 = "???"
	FEEDBACKUI_STRDIFFICULTY3 = "????"
	FEEDBACKUI_STRDIFFICULTY4 = "???"
	FEEDBACKUI_STRDIFFICULTY5 = "N/A"
	
	FEEDBACKUI_DIFFICULTY1 = "??"
	FEEDBACKUI_DIFFICULTY2 = "???"
	FEEDBACKUI_DIFFICULTY3 = "????"
	FEEDBACKUI_DIFFICULTY4 = "???"
	FEEDBACKUI_DIFFICULTY5 = "N/A"
	
	FEEDBACKUI_QUESTSREWARDTABLEHEADER = "??"
	FEEDBACKUI_QUESTSREWARDTABLESUBTEXT = "???? ??? ?? ??????"
	FEEDBACKUI_AREASREWARDTABLEHEADER = "??"
	FEEDBACKUI_AREASREWARDTABLESUBTEXT = "???? ??? ??? ?? ??????"
	
	FEEDBACKUI_STRREWARD1 = "?? ??"
	FEEDBACKUI_STRREWARD2 = "??"
	FEEDBACKUI_STRREWARD3 = "??"
	FEEDBACKUI_STRREWARD4 = "?? ??"
	FEEDBACKUI_STRREWARD5 = "N/A"
	
	FEEDBACKUI_REWARD1 = "?? ??"
	FEEDBACKUI_REWARD2 = "??"
	FEEDBACKUI_REWARD3 = "??"
	FEEDBACKUI_REWARD4 = "?? ??"
	FEEDBACKUI_REWARD5 = "N/A"
	
	FEEDBACKUI_QUESTSFUNTABLEHEADER = "??"
	FEEDBACKUI_QUESTSFUNTABLESUBTEXT = "???? ??? ???? ???????"
	FEEDBACKUI_AREASFUNTABLEHEADER = "??"
	FEEDBACKUI_AREASFUNTABLESUBTEXT = "???? ??? ??? ???? ???????"
	
	FEEDBACKUI_STRFUN1 = "?? ?? ??"
	FEEDBACKUI_STRFUN2 = "??? ?? ??"
	FEEDBACKUI_STRFUN3 = "? ?? ??"
	FEEDBACKUI_STRFUN4 = "??? ?? ??"
	
	FEEDBACKUI_FUN1 = "?? ?? ??"
	FEEDBACKUI_FUN2 = "??? ?? ??"
	FEEDBACKUI_FUN3 = "? ?? ??"
	FEEDBACKUI_FUN4 = "??? ?? ??"
	
	FEEDBACKUISURVEYFRMINPUTBOX_TEXT = "<??? ?? ????>"
	FEEDBACKUI_SURVEYINPUTHEADER = "??? ???? ??? ??? ?? ????."
	FEEDBACKUI_WELCOMETABLEBUGHEADER = "?? ???"
	FEEDBACKUI_WELCOMETABLEBUGSUBTEXT = "??? ????? ?? ??? ???? ? ?? ??? ???."
	FEEDBACKUI_WELCOMETABLESUGGESTHEADER = "?? ???"
	FEEDBACKUI_WELCOMETABLESUGGESTSUBTEXT = "??? ????? ?? ??? ???? ? ?? ??? ???."
	FEEDBACKUI_BUGINPUTHEADER = "??? ?? ??? ??? ????."
	FEEDBACKUI_SUGGESTINPUTHEADER="??? ??? ????."
	
	FEEDBACKUI_SURVEYNEWBIETEXT = "?? ?? ????? ???? ?? ??? ???? ??? ?????"
	FEEDBACKUI_POIMASK = ".-%s%-%s(.+)"
	
	FEEDBACKUI_LEVELPREFIX = "??";
	FEEDBACKUI_HILLSBRAD = "?? ?? - ????? ???";
	FEEDBACKUISURVEYTYPE_AREA = "??"
	FEEDBACKUISURVEYTYPE_ITEM = "???"
	FEEDBACKUISURVEYTYPE_MOB = "???"
	FEEDBACKUI_AREAHEADERTEXT = "??"
	FEEDBACKUI_QUESTHEADERTEXT = "???"
	FEEDBACKUI_ITEMHEADERTEXT = "???"
	FEEDBACKUI_MOBHEADERTEXT = "???"
	FEEDBACKUI_SURVEYTOOLTIPAREAHEADER = "?? ??"
	FEEDBACKUI_AREASDIFFICULTYTABLEHEADER = "???"
	FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT = "? ??? ???? ?? ????????"
	FEEDBACKUI_AREASREWARDTABLEHEADER = "??"
	FEEDBACKUI_AREASREWARDTABLESUBTEXT = "? ??? ??? ?? ??????"
	FEEDBACKUI_AREASFUNTABLEHEADER = "??"
	FEEDBACKUI_AREASFUNTABLESUBTEXT = "? ??? ??? ???? ???????"
	FEEDBACKUI_SURVEYINPUTSUBTEXT = "?? ??? ???? ??? ??????."
	FEEDBACKUI_SURVEYNEWBIETEXT = "? ??? ?? ??? ?????? ??????."
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "??? ??????"
	
	FEEDBACKUI_SPECIFICWELCOME = "?? ?? ?? ?? ?????? ?? ??? ??? ?? ??? ??????. ?? ??? ?? ??? ?? ????:\n\n\n\n\n?? ????? ?? ?? ? ??? ??? ????:";
	FEEDBACKUI_GENERALWELCOME = "?? ?? ?????? ?? ??? ??? ?? ??? ??????. ???? ??? ?? ?? ?? ?? ?????? ?? ???? ??? ????.\n\n?? ????? ?? ?? ? ??? ??? ????:";
	
	FEEDBACKUI_STARTBUG = "?? ??"
	FEEDBACKUI_STARTSURVEY = "?? ??"
	FEEDBACKUI_STARTSUGGESTION = "?? ???"
	
	FEEDBACKUI_WELCOMEBUGHEADER = "??"
	FEEDBACKUI_WELCOMESUGGESTHEADER = "??"
	FEEDBACKUI_WELCOMESURVEYHEADER = "??"
	
	FEEDBACKUI_WELCOMEBUGTEXT = "?? ??? ??? ???? ??? ??? ????." 
	FEEDBACKUI_WELCOMESUGGESTTEXT = "?? ???? ??? ??? ??? ???? ??? ??????."
	FEEDBACKUI_WELCOMESURVEYTEXT = "??? ??? ??? ?? ??? ?? ??? ??? ??????."
	FEEDBACKUI_WELCOMESURVEYDISABLED = "??? ?? ???? ??? ??? ????."
	
	FEEDBACKUI_MODIFIERKEY = "??? ??:"
	FEEDBACKUI_MOUSE1 = "??? ??"
	FEEDBACKUI_MOUSE2 = "??? ???"
	
	FEEDBACKUI_LALT = "Alt ??"
	FEEDBACKUI_RALT = "Alt ???"
	FEEDBACKUI_LCTRL = "Ctrl ??"
	FEEDBACKUI_RCTRL = "Ctrl ???"
	FEEDBACKUI_LSHIFT = "Shift ??"
	FEEDBACKUI_RSHIFT = "Shift ???"
	
	FEEDBACKUI_TOOLTIP_MESSAGE = "<???? ???? %s + %s ??>";
	FEEDBACKUI_MAP_MESSAGE = "???? ???? %s + %s ??";
	FEEDBACKUI_ITEMTARGETS = { "???", "?? ??", "??", "???", "???", "??", "???", "???", "???", "??" };
	FEEDBACKUI_MISCTYPE = "??";
	FEEDBACKUISHOWCUES_TEXT = "??? ?? ??";
	
	FEEDBACKUI_CATEGORYLABEL = "??:"
	FEEDBACKUI_STATUSLABEL = "??:"
	
	NEWBIE_TOOLTIP_BUG="?? ?? ?? ?? ?????? ? ? ??? ???? ???? ?? ?? ??? ?? ???? ??? ??? ????.\n\n" .. FEEDBACKUI_BLUE .. "????? ?? ??\n??? ??? ??? ??";
	FEEDBACKUILBLAPPEARANCE_TEXT = "??:"
	FEEDBACKUILBLUTILITY_TEXT = "???:"
	
	FEEDBACKUI_MOBSDIFFICULTYTABLEHEADER = "???"                   
	FEEDBACKUI_MOBSDIFFICULTYTABLESUBTEXT = "? ???? ????? ??? ??????"
	FEEDBACKUI_MOBSREWARDTABLEHEADER = "??"
	FEEDBACKUI_MOBSREWARDTABLESUBTEXT = "? ???? ??? ?? ??????"
	FEEDBACKUI_MOBSFUNTABLEHEADER = "??"
	FEEDBACKUI_MOBSFUNTABLESUBTEXT = "? ????? ??? ??? ???? ???????"
	FEEDBACKUI_MOBSAPPEARANCETABLEHEADER = "??"
	FEEDBACKUI_MOBSAPPEARANCETABLESUBTEXT = "? ???? ??? ?? ??????"
	
	FEEDBACKUI_ITEMSDIFFICULTYTABLEHEADER = "???"
	FEEDBACKUI_ITEMSDIFFICULTYTABLESUBTEXT = "? ???? ??? ??? ??????"
	FEEDBACKUI_ITEMSUTILITYHEADER = "???"
	FEEDBACKUI_ITEMSUTILITYSUBTEXT = "? ???? ??? ??????"
	FEEDBACKUI_ITEMSAPPEARANCETABLEHEADER = "??"
	FEEDBACKUI_ITEMSAPPEARANCETABLESUBTEXT = "? ???? ??? ?? ??????"
	
	FEEDBACKUI_STRUTILITY1 = "??? ????"
	FEEDBACKUI_STRUTILITY2 = "?? ????"
	FEEDBACKUI_STRUTILITY3 = "???"
	FEEDBACKUI_STRUTILITY4 = "?? ???"
	
	FEEDBACKUI_UTILITY1 = "??? ????"
	FEEDBACKUI_UTILITY2 = "?? ????"
	FEEDBACKUI_UTILITY3 = "???"
	FEEDBACKUI_UTILITY4 = "?? ???"
	
	FEEDBACKUI_STRAPPEARANCE1 = "?? ??"
	FEEDBACKUI_STRAPPEARANCE2 = "???"
	FEEDBACKUI_STRAPPEARANCE3 = "???"
	FEEDBACKUI_STRAPPEARANCE4 = "?? ??"
	
	FEEDBACKUI_APPEARANCE1 = "?? ??"
	FEEDBACKUI_APPEARANCE2 = "???"
	FEEDBACKUI_APPEARANCE3 = "???"
	FEEDBACKUI_APPEARANCE4 = "?? ??"
	
	FEEDBACKUI_POIUNDERCITY = "????";
	FEEDBACKUI_POISILVERMOON = "???";
	FEEDBACKUI_POIIRONFORGE = "?????";
	FEEDBACKUI_POISTORMWIND = "????";
	FEEDBACKUI_POISEPULCHER = "????";
	FEEDBACKUI_POITARRENMILL = "?? ???";
	FEEDBACKUI_POISOUTHSHORE = "?????";
	FEEDBACKUI_POIAERIEPEAK = "??? ???";
	FEEDBACKUI_POIREVANTUSK = "????? ??";
	FEEDBACKUI_POIHAMMERFALL = "???";
	FEEDBACKUI_POIMENETHIL = "??? ??";
	FEEDBACKUI_POITHELSAMAR = "???";
	FEEDBACKUI_POIKARGATH = "????";
	FEEDBACKUI_POILAKESHIRE = "??????";
	FEEDBACKUI_POISENTINELHILL = "??? ??";
	FEEDBACKUI_POIDARKSHIRE = "?????";
	FEEDBACKUI_POISTONARD = "????";
	FEEDBACKUI_POIGROMGOL = "??? ???";
	FEEDBACKUI_POIBOOTY = "???"
	
	FEEDBACKUI_POIDARNASSUS = "?????";
	FEEDBACKUI_POIEXODAR = "????";
	FEEDBACKUI_POIORGRIMMAR = "????";
	FEEDBACKUI_POITHUNDERB = "?? ???";
	FEEDBACKUI_POIAUBERDINE = "?????";
	FEEDBACKUI_POIEVERLOOK = "??? ??";
	FEEDBACKUI_POISTONETALON = "??? ???";
	FEEDBACKUI_POIASTRANAAR = "??????";
	FEEDBACKUI_POISPLINTERTREE = "???? ???";
	FEEDBACKUI_POISUNROCK = "??? ???";
	FEEDBACKUI_POINIJELS = "???? ???";
	FEEDBACKUI_POISHADOWPREY = "???? ??";
	FEEDBACKUI_POIFEATHERMOON = "??? ??";
	FEEDBACKUI_POIMOJACHE = "??? ???";
	FEEDBACKUI_POITHALANAAR = "????";
	FEEDBACKUI_POICENARIONHOLD = "???? ??";
	FEEDBACKUI_POIGADGET = "???";
	FEEDBACKUI_POIFREEWIND = "???? ???";
	FEEDBACKUI_POITAURAJO = "???? ???";
	FEEDBACKUI_POICROSSROADS = "?????";
	FEEDBACKUI_POIRATCHET = "???";
	FEEDBACKUI_POITHERAMORE = "???? ?";
	
	FEEDBACKUI_SURVEYTOOLTIPMOBHEADER = "??? ??:"
	FEEDBACKUI_SURVEYTOOLTIPMOBZONEHEADER = "?? ??:"
	
	FEEDBACKUI_VOICECHAT = "?? ??";
	FEEDBACKUI_VOICECHATTOOLTIP = FEEDBACKUI_WHITE .. FEEDBACKUI_VOICECHAT;
	FEEDBACKUI_STRVOICECHAT = "?? ??? ?? ?????.";
	FEEDBACKUI_HEADSETTYPE = "?? ??? ???? ???????";
	
	FEEDBACKUI_USBHEADSET = "USB ???"; --localize me
	FEEDBACKUI_ANALOGHEADSET = "???? ???"; --localize me
	FEEDBACKUI_HARDWIREDMIC = "?? ???"; --localize me
	
	FEEDBACKUI_STRUSBHEADSET = "USB ???? ?????.";
	FEEDBACKUI_STRANALOGHEADSET = "???? ???? ?????.";
	FEEDBACKUI_STRHARDWIREDMIC = "?? ???? ???? ????."; --localize me
	
	
elseif ( GetLocale() == "deDE" ) then
	--Localized German strings for FEEDBACKUI
	--[[
	function deDE() end
	]]--
	--Non-instance special zone names
	FEEDBACKUI_EXCEPTIONZONES = { "Die Tiefenbahn", "Halle der Champions", "Das verhüllte Meer", "Das verbotene Meer", "Das Große Meer", "Alteractal", "Arathibecken", "Kriegshymnenschlucht", "Der Schwarzfels", "Halle der Legenden", "Burg Utgarde", }
	
	--Headers    
	FEEDBACKUIINFOPANELLABEL_TEXT = "Ihre Angaben"
	FEEDBACKUI_BUGINPUTHEADER = "Bitte beschreiben Sie diesen Fehler"
	FEEDBACKUI_BUGINPUTSUBTEXT = "Wie können wir diesen Bug reproduzieren?"
	FEEDBACKUI_SUGGESTINPUTHEADER = "Bitte beschreiben Sie Ihren Vorschlag"
	FEEDBACKUI_SUGGESTINPUTSUBTEXT = "Was würden Sie gerne vorschlagen?"
	
	--Labels
	FEEDBACKUIFEEDBACKFRMTITLE_TEXT = "Kommentare senden"
	FEEDBACKUILBLFRMVER_TEXT = "Version: "
	FEEDBACKUILBLFRMREALM_TEXT = "Realm: "
	FEEDBACKUILBLFRMNAME_TEXT = "Name: "
	FEEDBACKUILBLFRMCHAR_TEXT = "Charakter: "
	FEEDBACKUILBLFRMMAP_TEXT = "Karte:"
	FEEDBACKUILBLFRMZONE_TEXT = "Zone: "
	FEEDBACKUILBLFRMAREA_TEXT = "Gebiet: "
	FEEDBACKUILBLFRMADDONS_TEXT = "Add-Ons: "
	FEEDBACKUILBLADDONSWRAP_TEXT = "Momentan aktive Add-Ons:\n"
	FEEDBACKUITYPEBUG_TEXT = "Fehler"
	FEEDBACKUITYPESUGGEST_TEXT = "Vorschlag"
	FEEDBACKUITYPESURVEY_TEXT = "Bewertung"
	FEEDBACKUILBLFRMWHO_TEXT = "Wen: "
	FEEDBACKUILBLFRMWHERE_TEXT = "Wo: "
	FEEDBACKUILBLFRMWHEN_TEXT = "Wann: "
	FEEDBACKUILBLFRMTYPE_TEXT = "Art: "
	FEEDBACKUI_GENDERTABLE = { "unbekannt", "männlich", "weiblich" }
	
	--Prompts
	FEEDBACKUIBUGFRMINPUTBOX_TEXT = "<Geben Sie hier Schritte ein, um den Fehler nachzustellen>"
	FEEDBACKUISUGGESTFRMINPUTBOX_TEXT = "<Geben Sie hier Ihren Vorschlag ein>"
	FEEDBACKUILBLADDONS_MOUSEOVER = "<Für aktive Add-Ons Mauszeiger hierher bewegen>"
	FEEDBACKUI_CONFIRMATION = "Ihre Kommentare wurden abgeschickt.\nVielen Dank für Ihre Hilfe bei der Verbesserung von " .. project_name .. "!"
	
	--Tooltips & Buttons
	BUG_BUTTON="Kommentare senden"
	NEWBIE_TOOLTIP_BUG="Melden Sie uns Fehler oder schicken Sie Vorschläge, um " .. project_name .. " zu verbessern."
	FEEDBACKUIBACK_TEXT = "Schritt zurück"
	FEEDBACKUIRESET_TEXT = "Zurücksetzen"
	FEEDBACKUISUBMIT_TEXT = "Senden"
	FEEDBACKUISTART_TEXT = "Start!"
	
	--Tables and strings for navigation.
	FEEDBACKUI_WELCOMETABLEBUGHEADER = "Einen Bug melden"
	FEEDBACKUI_WELCOMETABLESUGGESTHEADER = "Einen Vorschlag machen"
	FEEDBACKUI_WELCOMETABLESUBTEXT = "Vielen Dank für Ihre Kommentare!"
	
	FEEDBACKUI_WELCOME = "\nVielen Dank für Ihre Kommentare zu " .. project_name .. ". Jede Einsendung, die wir erhalten, spielt eine wichtige Rolle für die Qualität des Spiels.\n\nBitte füllen Sie diesen kurzen Fragebogen aus, damit wir Ihre Einsendung so schnell wie möglich bearbeiten können.\n\nVielen Dank,\nThe " .. project_name .. " Team"
	
	FEEDBACKUI_WHOTABLEHEADER = FEEDBACKUI_WHITE .. "Wen" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHOTABLESUBTEXT = "Worauf wirkt sich das Problem aus?"
	
	FEEDBACKUI_STRWHOPLAYER = "Betrifft meinen Charakter."
	FEEDBACKUI_STRPARTYMEMBER = "Betrifft Spieler meiner Gruppe."
	FEEDBACKUI_STRRAIDMEMBER = "Betrifft Spieler meines Schlachtzugs."
	FEEDBACKUI_STRENEMYPLAYER = "Betrifft einen gegnerischen Spieler."
	FEEDBACKUI_STRFRIENDLYPLAYER = "Betrifft einen befreundeten Spieler."
	FEEDBACKUI_STRENEMYCREATURE = "Betrifft eine feindliche Kreatur."
	FEEDBACKUI_STRFRIENDLYCREATURE = "Betrifft eine freundliche Kreatur."
	FEEDBACKUI_STRWHONA = "Betrifft keine Spieler oder Kreaturen."
	
	FEEDBACKUI_WHOPLAYER = "Mein Charakter"
	FEEDBACKUI_ENEMYPLAYER = "Gegnerischer Spieler"
	FEEDBACKUI_FRIENDLYPLAYER = "Befreundeter Spieler"
	FEEDBACKUI_PARTYMEMBER = "Gruppenmitglied"
	FEEDBACKUI_RAIDMEMBER = "Schlachtzugsmitglied"
	FEEDBACKUI_ENEMYCREATURE = "Feindliche Kreatur"
	FEEDBACKUI_FRIENDLYCREATURE = "Freundliche Kreatur"
	FEEDBACKUI_WHONA = "Nicht zutreffend"
	
	FEEDBACKUI_WHERETABLEHEADER = FEEDBACKUI_WHITE .. "Wo" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHERETABLESUBTEXT = "Wo tritt das Problem auf?"
	
	FEEDBACKUI_STRAREATABLE = "Tritt im Spiel auf."
	FEEDBACKUI_STRWHEREINSTALL = "Tritt während der Installation auf."
	FEEDBACKUI_STRWHEREDOWNLOAD = "Tritt während des Downloads auf."
	FEEDBACKUI_STRWHEREPATCH = "Tritt während des Patchvorgangs auf."
	
	FEEDBACKUI_WHEREINSTALL = "Während der Installation"
	FEEDBACKUI_WHEREDOWNLOAD = "Während des Downloads"
	FEEDBACKUI_WHEREPATCH = "Während des Patchvorgangs"
	
	FEEDBACKUI_AREATABLESUMMARY = FEEDBACKUI_GREEN .. "An bestimmten Stellen im Spiel"
	
	---------------------------------------- Begin Area Strings ------------------------------------------------------------------
	FEEDBACKUI_STROCCURS = "- This occurs in "; --localize me
	FEEDBACKUI_EVERYWHERE = "Überall im Spiel"
	FEEDBACKUI_STREVERYWHERE = "Tritt überall im Spiel auf."
	
	--AZEROTH
	FEEDBACKUI_AZEROTH = "Azeroth"
	
	--Northrend
	FEEDBACKUI_NORTHREND = "Nordend"
	FEEDBACKUI_BOREANTUNDRA = "Boreanische Tundra"
	FEEDBACKUI_CRYSTALSONG = "Kristallsangwald" --LOCALIZE ME
	FEEDBACKUI_DALARAN = "Dalaran" 
	FEEDBACKUI_DRAGONBLIGHT = "Drachenöde"
	FEEDBACKUI_GRIZZLYHILLS = "Grizzlyhügel"
	FEEDBACKUI_HOWLINGFJORD = "Heulender Fjord"
	FEEDBACKUI_ICECROWN = "Eiskrone" --LOCALIZE ME
	FEEDBACKUI_NEXUS = "Nexus"
	FEEDBACKUI_SHOLAZARBASIN = "Sholazarbecken" --LOCALIZE ME
	FEEDBACKUI_STORMPEAKS = "Die Sturmgipfel" --LOCALIZE ME
	FEEDBACKUI_UTGARDEPINNACLE = "Turm Utgarde"
	FEEDBACKUI_WINTERGRASP = "Tausendwinter" --LOCALIZE ME
	FEEDBACKUI_ZULDRAK = "Zul'Drak" 
	FEEDBACKUI_STRNORTHREND = "Tritt in Nordend auf."
	--End Northrend-----------------------------------
	
	--Eastern Kingdoms
	FEEDBACKUI_EKINGDOMS = "Östliche Königreiche"
	FEEDBACKUI_ALTERACMOUNTAINS = "Alteracgebirge"
	FEEDBACKUI_ALTERACVALLEY = "Alteractal"
	FEEDBACKUI_ARATHIBASIN = "Arathibecken"
	FEEDBACKUI_ARATHIHIGHLANDS = "Arathihochland"
	FEEDBACKUI_BADLANDS = "Ödland"
	FEEDBACKUI_BLACKROCKMOUNTAIN = "Schwarzfels"
	FEEDBACKUI_BLASTEDLANDS = "Verwüstete Lande"
	FEEDBACKUI_BURNINGSTEPPES = "Brennende Steppe"
	FEEDBACKUI_DEADWINDPASS = "Gebirgspass der Totenwinde"
	FEEDBACKUI_DUNMOROGH = "Dun Morogh"
	FEEDBACKUI_DUSKWOOD = "Dämmerwald"
	FEEDBACKUI_EPLAGUELANDS = "Östliche Pestländer"
	FEEDBACKUI_ELWYNN = "Wald von Elwynn"
	FEEDBACKUI_EVERSONG = "Immersangwald"
	FEEDBACKUI_GHOSTLANDS = "Geisterlande"
	FEEDBACKUI_HINTERLANDS = "Hinterland"
	FEEDBACKUI_IRONFORGE = "Eisenschmiede"
	FEEDBACKUI_ISLEOFQUELDANAS = "Insel von Quel'Danas" --LOCALIZE ME
	FEEDBACKUI_LOCHMODAN = "Loch Modan"
	FEEDBACKUI_REDRIDGE = "Rotkammgebirge"
	FEEDBACKUI_SEARINGGORGE = "Sengende Schlucht"
	FEEDBACKUI_SILVERMOON = "Silbermond"
	FEEDBACKUI_SILVERPINE = "Silberwald"
	FEEDBACKUI_STORMWIND = "Sturmwind"
	FEEDBACKUI_STRANGLETHORN = "Schlingendorntal"
	FEEDBACKUI_SWAMPOFSORROWS = "Sümpfen des Elends";
	FEEDBACKUI_TIRISFAL = "Tirisfal"
	FEEDBACKUI_UNDERCITY = "Unterstadt"
	FEEDBACKUI_WPLAGUELANDS = "Westliche Pestländer"
	FEEDBACKUI_WESTFALL = "Westfall"
	FEEDBACKUI_WETLANDS = "Sumpfland"
	FEEDBACKUI_STREKINGDOMS = "Tritt in den östlichen Königreichen auf."
	--End Eastern Kingdoms-------------------------------------------------------------------------------------------------------
	
	--Kalimdor
	FEEDBACKUI_KALIMDOR = "Kalimdor"
	FEEDBACKUI_ASHENVALE = "Eschental"
	FEEDBACKUI_AZSHARA = "Azshara"
	FEEDBACKUI_AZUREMYST = "Azurmythosinsel"
	FEEDBACKUI_BARRENS = "Brachland"
	FEEDBACKUI_BLOODMYST = "Blutmythosinsel"
	FEEDBACKUI_DARKSHORE = "Dunkelküste"
	FEEDBACKUI_DARNASSUS = "Darnassus"
	FEEDBACKUI_DESOLACE = "Desolace";
	FEEDBACKUI_DUROTAR = "Durotar";
	FEEDBACKUI_DUSTWALLOW = "Düstermarschen"
	FEEDBACKUI_EXODAR = "Die Exodar"
	FEEDBACKUI_FELWOOD = "Teufelswald"
	FEEDBACKUI_FERALAS = "Feralas";
	FEEDBACKUI_MOONGLADE = "Mondlichtung"
	FEEDBACKUI_MULGORE = "Mulgore";
	FEEDBACKUI_ORGRIMMAR = "Orgrimmar";
	FEEDBACKUI_SILITHUS = "Silithus";
	FEEDBACKUI_STONETALON = "Steinkrallengebirge"
	FEEDBACKUI_TANARIS = "Tanaris";
	FEEDBACKUI_TELDRASSIL = "Teldrassil";
	FEEDBACKUI_THUNDERBLUFF = "Donnerklippe"
	FEEDBACKUI_THOUSANDNEEDLES = "Tausend Nadeln"
	FEEDBACKUI_UNGORO = "Krater von Un'Goro"
	FEEDBACKUI_WARSONG = "Kriegshymnenschlucht"
	FEEDBACKUI_WINTERSPRING = "Winterquell" 
	FEEDBACKUI_STRKALIMDOR = "Tritt in Kalimdor auf."
	--End Kalimdor ------------------------------------------------------------------------------------------------------------------
	
	--OUTLAND
	FEEDBACKUI_OUTLANDS = "Scherbenwelt"
	FEEDBACKUI_BLADESEDGE = "Schergrat"
	FEEDBACKUI_HELLFIRE = "Höllenfeuerhalbinsel"
	FEEDBACKUI_NAGRAND = "Nagrand"
	FEEDBACKUI_NETHERSTORM = "Nethersturm"
	FEEDBACKUI_SHADOWMOON = "Schattenmondtal"
	FEEDBACKUI_SHATTRATH = "Shattrath"
	FEEDBACKUI_TERROKAR = "Wälder von Terokkar"
	FEEDBACKUI_TWISTINGNETHER = "Wirbelnder Nether"
	FEEDBACKUI_ZANGARMARSH = "Zangarmarschen"
	FEEDBACKUI_STROUTLANDS = "Tritt in der Scherbenwelt auf."
	--End Outlands--------------------------------------------
	
	--Alert Targets/Extra areas
	FEEDBACKUI_BLACKTEMPLE = "Der Schwarze Tempel"
	FEEDBACKUI_ZULAMAN = "Zul'Aman"
	FEEDBACKUI_KAJA = "Kaja'mine"
	FEEDBACKUI_SUNWELLPLATEAU = "Sonnenbrunnenplateau"
	FEEDBACKUI_MAGISTERSTERRACE = "Terrasse der Magister"
	FEEDBACKUI_UTGARDEKEEP = "Burg Utgarde"
	FEEDBACKUI_DRAKTHARONKEEP = "Feste Drak'Tharon"
	FEEDBACKUI_ULDUAR = "Ulduar"
	FEEDBACKUI_HOL = "Die Hallen der Blitze"
	FEEDBACKUI_TAC = "Das Argentumkolosseum"
	FEEDBACKUI_IOC = "Insel der Eroberung"
	--End Alert Targets/Extra areas
	--------------------------------------------End Area Strings---------------------------------------------------------------------
	
	FEEDBACKUI_WHENTABLEHEADER = FEEDBACKUI_WHITE .. "Wann" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHENTABLESUBTEXT = "Wie häufig tritt das Problem auf?"
	
	FEEDBACKUI_STRREPRODUCABLE = "Tritt immer auf."
	FEEDBACKUI_STRSOMETIMES = "Tritt gelegentlich auf."
	FEEDBACKUI_STRRARELY = "Tritt selten auf."
	FEEDBACKUI_STRONETIME = "Trat bisher nur ein Mal auf."
	
	
	FEEDBACKUI_REPRODUCABLE = "Immer"
	FEEDBACKUI_SOMETIMES = "Gelegentlich"
	FEEDBACKUI_RARELY = "Selten"
	FEEDBACKUI_ONETIME = "Einmal"
	
	FEEDBACKUI_TYPETABLEHEADER = FEEDBACKUI_WHITE .. "Art" .. FEEDBACKUI_WHITE
	FEEDBACKUI_TYPETABLESUBTEXT = "Welcher Art ist das Problem?"
	
	FEEDBACKUI_STRUIOTHER = "Problem mit dem Benutzerinterface."
	FEEDBACKUI_STRUIITEMS = "- Problem mit dem Interface für Gegenstände."
	FEEDBACKUI_STRUISPAWNS = "- Problem mit dem Interface für Kreaturen."
	FEEDBACKUI_STRUIQUESTS = "- Problem mit dem Interface für Quests."
	FEEDBACKUI_STRUISPELLS = "- Problem mit dem Interface für Zauber oder Talente."
	FEEDBACKUI_STRUITRADESKILLS = "- Problem mit dem Interface für Handwerksfertigkeiten."
	
	FEEDBACKUI_STRGRAPHICOTHER = "Problem mit der Grafik."
	FEEDBACKUI_STRGRAPHICITEMS = "- Problem mit der Grafik von Gegenständen."
	FEEDBACKUI_STRGRAPHICSPAWNS = "- Problem mit der Grafik von Kreaturen."
	FEEDBACKUI_STRGRAPHICSPELLS = "- Problem mit der Grafik von Zaubern und Talenten."
	FEEDBACKUI_STRGRAPHICENVIRONMENT = "- Problem mit der Umgebungsgrafik."
	
	FEEDBACKUI_STRFUNCOTHER = "Problem mit der Funktionalität des Spiels."
	FEEDBACKUI_STRFUNCITEMS = "- Problem mit der Funktionalität von Gegenständen."
	FEEDBACKUI_STRFUNCSPAWNS = "- Problem mit der Funktionalität von Kreaturen."
	FEEDBACKUI_STRFUNCQUESTS = "- Problem mit der Funktionalität von Quests."
	FEEDBACKUI_STRFUNCSPELLS = "- Problem mit der Funktionalität von Zaubern oder Talenten."
	FEEDBACKUI_STRFUNCTRADESKILLS = "- Problem mit der Funktionalität von Handwerksfertigkeiten."
	
	FEEDBACKUI_STRCRASHOTHER = "Problem mit der Stabilität des Spiels."
	FEEDBACKUI_STRCRASHBUG = "- Verursacht einen Absturz von WoW."
	FEEDBACKUI_STRCRASHSOFTLOCK = "- Verursacht einen Stillstand von WoW."
	FEEDBACKUI_STRCRASHHARDLOCK = "- Verursacht einen Stillstand des Computers."
	FEEDBACKUI_STRCRASHWOWLAG = "- Betrifft Probleme mit Lag."
	
	FEEDBACKUI_UIITEMS = "Interface - Gegenstände"
	FEEDBACKUI_UISPAWNS = "Interface - Kreaturen"
	FEEDBACKUI_UIQUESTS = "Interface - Quests"
	FEEDBACKUI_UISPELLS = "Interface - Zauber/Talente"
	FEEDBACKUI_UITRADESKILLS = "Interface - Handwerk"
	FEEDBACKUI_UIOTHER = "Interface - Allgemein"
	
	FEEDBACKUI_GRAPHICITEMS = "Grafik - Gegenstände"
	FEEDBACKUI_GRAPHICSPAWNS = "Grafik - Kreaturen"
	FEEDBACKUI_GRAPHICSPELLS = "Grafik - Zauber/Talente"
	FEEDBACKUI_GRAPHICENVIRONMENT = "Grafik - Umgebung"
	FEEDBACKUI_GRAPHICOTHER = "Grafik - Allgemein"
	
	FEEDBACKUI_FUNCITEMS = "Funktion - Gegenstände"
	FEEDBACKUI_FUNCSPAWNS = "Funktion - Kreaturen"
	FEEDBACKUI_FUNCQUESTS = "Funktion - Quests"
	FEEDBACKUI_FUNCSPELLS = "Funktion - Zauber/Talente"   
	FEEDBACKUI_FUNCTRADESKILLS = "Funktion - Handwerk"
	FEEDBACKUI_FUNCOTHER = "Funktion - Allgemein"
	
	FEEDBACKUI_SPELLSPOWERTABLEHEADER = "Stärke"
	FEEDBACKUI_SPELLSPOWERTABLESUBTEXT = "Wie stark ist diese Fähigkeit?"
	FEEDBACKUI_SPELLSFREQUENCYTABLEHEADER = "Häufigkeit"
	FEEDBACKUI_SPELLSFREQUENCYTABLESUBTEXT = "Wie oft verwendest du diese Fähigkeit?"
	FEEDBACKUI_SPELLSAPPROPRIATETABLEHEADER = "Eignung"
	FEEDBACKUI_SPELLSAPPROPRIATETABLESUBTEXT = "Wie gut passt diese Fähigkeit zu ähnlichen Fähigkeiten? "
	FEEDBACKUI_SPELLSFUNTABLEHEADER = "Spaß"
	FEEDBACKUI_SPELLSFUNTABLESUBTEXT = "Macht es Spaß, diese Fähigkeit zu benutzen?"
	
	FEEDBACKUI_STRPOWER1 = "Sehr schwach";
	FEEDBACKUI_STRPOWER2 = "Schwach";
	FEEDBACKUI_STRPOWER3 = "Stark";
	FEEDBACKUI_STRPOWER4 = "Sehr stark";
	
	FEEDBACKUI_STRFREQUENCY1 = "Selten";
	FEEDBACKUI_STRFREQUENCY2 = "Gelegentlich";
	FEEDBACKUI_STRFREQUENCY3 = "Häufig";
	FEEDBACKUI_STRFREQUENCY4 = "So oft wie möglich";
	
	FEEDBACKUI_STRAPPROPRIATE1 = "Äußerst ungeeignet";
	FEEDBACKUI_STRAPPROPRIATE2 = "Ungeeignet";
	FEEDBACKUI_STRAPPROPRIATE3 = "Geeignet";
	FEEDBACKUI_STRAPPROPRIATE4 = "Perfekt geeignet";
	
	FEEDBACKUI_SPELLHEADERTEXT = "Zauber"
	FEEDBACKUILBLPOWER_TEXT = "Kraft:"
	FEEDBACKUILBLFREQUENCY_TEXT = "Häufigkeit:"
	FEEDBACKUILBLAPPROPRIATE_TEXT = "Eignung:"
	
	FEEDBACKUI_CRASHBUG = "Absturz von WoW"
	FEEDBACKUI_CRASHSOFTLOCK = "Stillstand von WoW"
	FEEDBACKUI_CRASHHARDLOCK = "Stillstand des Rechners"
	FEEDBACKUI_CRASHWOWLAG = "Lag in WoW"
	FEEDBACKUI_CRASHOTHER = "Allgemeine Stabilitätsprobleme"
	
	FEEDBACKUILBLFRMCLARITY_TEXT = "Questinfo:"
	FEEDBACKUILBLFRMDIFFICULTY_TEXT = "Schwierigkeit:"
	FEEDBACKUILBLFRMREWARD_TEXT = "Belohnung:"
	FEEDBACKUILBLFRMFUN_TEXT = "Spaß:"
	FEEDBACKUISURVEYTYPE_QUEST = "Quest"
	FEEDBACKUISURVEYTYPE_AREA = "Instanz"
	
	FEEDBACKUISKIP_TEXT = "Abbrechen"
	FEEDBACKUILBLSURVEYALERTSCHECK_TEXT = "Erinnerung"
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "Bitte wählen Sie eine Bewertung aus."
	FEEDBACKUI_WELCOMETABLESURVEYSUBTEXT = "Neue Inhalte eröffnen neue Bewertungen."
	
	FEEDBACKUI_SURVEYCOLUMNNAME = "Name"
	FEEDBACKUI_SURVEYCOLUMNMODIFIED = "Entdeckt"
	
	FEEDBACKUI_ALLHEADERTEXT = "Alle"
	FEEDBACKUI_AREAHEADERTEXT = "Instanzen"
	FEEDBACKUI_QUESTHEADERTEXT = "Quests"
	
	FEEDBACKUI_STATUSALLTEXT = "Alle"
	FEEDBACKUI_STATUSAVAILABLETEXT = "Verfügbar"
	FEEDBACKUI_STATUSSKIPPEDTEXT = "Abgebrochen"
	FEEDBACKUI_STATUSCOMPLETEDTEXT = "Abgeschlossen"
	
	FEEDBACKUI_SURVEYTOOLTIPQUESTHEADER = "Questtitel:"
	FEEDBACKUI_SURVEYTOOLTIPAREAHEADER = "Instanz:"
	FEEDBACKUI_SURVEYTOOLTIPEXPERIENCEDHEADER = "Entdeckt:"
	FEEDBACKUI_SURVEYTOOLTIPQUESTOBJECTIVESHEADER = "Questziele:"
	
	FEEDBACKUI_NEW = "Neu"
	FEEDBACKUI_TIMEPREFIX = "vor "
	FEEDBACKUI_HOURAGO = " Stunde"
	FEEDBACKUI_HOURSAGO = " Stunden"
	FEEDBACKUI_DAYAGO = " Tag"
	FEEDBACKUI_DAYSAGO = " Tagen"
	FEEDBACKUI_MONTHAGO = " Monat"
	FEEDBACKUI_MONTHSAGO = " Monaten"
	FEEDBACKUI_YEARAGO = " Jahr"
	FEEDBACKUI_YEARSAGO = " Jahren"
	
	FEEDBACKUI_QUESTSCLARITYTABLEHEADER = "Questinfo"
	FEEDBACKUI_QUESTSCLARITYTABLESUBTEXT = "Wie verständlich waren die Questziele?"
	
	FEEDBACKUI_STRCLARITY1 = "Sehr vage"
	FEEDBACKUI_STRCLARITY2 = "Etwas vage"
	FEEDBACKUI_STRCLARITY3 = "Relativ verständlich"
	FEEDBACKUI_STRCLARITY4 = "Absolut verständlich"
	
	FEEDBACKUI_CLARITY1 = "Sehr vage"
	FEEDBACKUI_CLARITY2 = "Etwas vage"
	FEEDBACKUI_CLARITY3 = "Relativ verständlich"
	FEEDBACKUI_CLARITY4 = "Absolut verständlich"
	
	FEEDBACKUI_QUESTSDIFFICULTYTABLEHEADER = "Schwierigkeitsgrad"
	FEEDBACKUI_QUESTSDIFFICULTYTABLESUBTEXT = "Wie schwierig war die Quest?"
	FEEDBACKUI_AREASDIFFICULTYTABLEHEADER = "Schwierigkeitsgrad"
	FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT = "Wie schwierig waren die Instanzbegegnungen?"
	
	FEEDBACKUI_STRDIFFICULTY1 = "Leicht"
	FEEDBACKUI_STRDIFFICULTY2 = "Schaffbar"
	FEEDBACKUI_STRDIFFICULTY3 = "Herausfordernd"
	FEEDBACKUI_STRDIFFICULTY4 = "Schwer"
	FEEDBACKUI_STRDIFFICULTY5 = "N/A"
	
	FEEDBACKUI_DIFFICULTY1 = "Leicht"
	FEEDBACKUI_DIFFICULTY2 = "Schaffbar"
	FEEDBACKUI_DIFFICULTY3 = "Herausfordernd"
	FEEDBACKUI_DIFFICULTY4 = "Schwer"
	FEEDBACKUI_DIFFICULTY5 = "N/A"
	
	FEEDBACKUI_QUESTSREWARDTABLEHEADER = "Belohnung"
	FEEDBACKUI_QUESTSREWARDTABLESUBTEXT = "Wie würden Sie die Questbelohnung bewerten?"
	FEEDBACKUI_AREASREWARDTABLEHEADER = "Belohnung"
	FEEDBACKUI_AREASREWARDTABLESUBTEXT = "Wie würden Sie die Instanzbelohnungen bewerten?"
	
	FEEDBACKUI_STRREWARD1 = "Erbärmlich"
	FEEDBACKUI_STRREWARD2 = "Schlecht"
	FEEDBACKUI_STRREWARD3 = "Gut"
	FEEDBACKUI_STRREWARD4 = "Fantastisch"
	FEEDBACKUI_STRREWARD5 = "N/A"
	
	FEEDBACKUI_REWARD1 = "Erbärmlich"
	FEEDBACKUI_REWARD2 = "Schlecht"
	FEEDBACKUI_REWARD3 = "Gut"
	FEEDBACKUI_REWARD4 = "Fantastisch"
	FEEDBACKUI_REWARD5 = "N/A"
	
	FEEDBACKUI_QUESTSFUNTABLEHEADER = "Spaß"
	FEEDBACKUI_QUESTSFUNTABLESUBTEXT = "Wie unterhaltsam war die Quest?"
	FEEDBACKUI_AREASFUNTABLEHEADER = "Spaß"
	FEEDBACKUI_AREASFUNTABLESUBTEXT = "Wie unterhaltsam war die Instanz?"
	
	FEEDBACKUI_STRFUN1 = "Nicht unterhaltsam"
	FEEDBACKUI_STRFUN2 = "Wenig unterhaltsam"
	FEEDBACKUI_STRFUN3 = "Recht unterhaltsam"
	FEEDBACKUI_STRFUN4 = "Sehr unterhaltsam"
	
	FEEDBACKUI_FUN1 = "Nicht unterhaltsam"
	FEEDBACKUI_FUN2 = "Wenig unterhaltsam"
	FEEDBACKUI_FUN3 = "Recht unterhaltsam"
	FEEDBACKUI_FUN4 = "Sehr unterhaltsam"
	
	FEEDBACKUISURVEYFRMINPUTBOX_TEXT = "<Zusätzliche Kommentare bitte hier eintragen>"
	FEEDBACKUI_SURVEYINPUTHEADER = "Danke für zusätzliche Kommentare"
	FEEDBACKUIRESUBMIT_TEXT = "Neu senden"
	
	FEEDBACKUI_WELCOMETABLEBUGHEADER = "Bug melden"
	FEEDBACKUI_WELCOMETABLEBUGSUBTEXT = "Bugmeldungen helfen Fehler schneller zu beheben"
	FEEDBACKUI_WELCOMETABLESUGGESTHEADER = "Einen Vorschlag einreichen"
	FEEDBACKUI_WELCOMETABLESUGGESTSUBTEXT = "Vorschläge helfen das Spiel weiter zu verbessern"
	FEEDBACKUI_BUGINPUTHEADER = "Wie kann man den Bug nachstellen?"
	FEEDBACKUI_SUGGESTINPUTHEADER="Bitte geben Sie ihren Vorschlag ein."
	
	FEEDBACKUI_SURVEYNEWBIETEXT = "Klicken Sie hier, um eine Umfrage, über eine kürzlich abgeschlossene Instanz, oder Quest, zu schließen."
	FEEDBACKUI_POIMASK = ".-%s%-%s(.+)"
	
	
	FEEDBACKUI_LEVELPREFIX = "Stufe"
	FEEDBACKUI_HILLSBRAD = "Östliche Königreiche - Vorgebirge des Hügellands";
	FEEDBACKUISURVEYTYPE_AREA = "Gebiet"
	FEEDBACKUISURVEYTYPE_ITEM = "Gegenstand"
	FEEDBACKUISURVEYTYPE_MOB = "Gegner"
	FEEDBACKUI_AREAHEADERTEXT = "Gebiete"
	FEEDBACKUI_QUESTHEADERTEXT = "Quests"
	FEEDBACKUI_ITEMHEADERTEXT = "Gegenstände"
	FEEDBACKUI_MOBHEADERTEXT = "Gegner"
	FEEDBACKUI_SURVEYTOOLTIPAREAHEADER = "Gebietsname:"
	FEEDBACKUI_AREASDIFFICULTYTABLEHEADER = "Schwierigkeitsgrad"
	FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT = "Wie schwierig waren die Begegnungen?"
	FEEDBACKUI_AREASREWARDTABLEHEADER = "Belohnung"
	FEEDBACKUI_AREASREWARDTABLESUBTEXT = "Wie würden Sie die Belohnungen bewerten?"
	FEEDBACKUI_AREASFUNTABLEHEADER = "Spaß"
	FEEDBACKUI_AREASFUNTABLESUBTEXT = "Wie unterhaltsam waren die Inhalte?"
	FEEDBACKUI_SURVEYINPUTSUBTEXT = "Hier klicken, um Bewertungsbeispiele anzuzeigen"
	FEEDBACKUI_SURVEYNEWBIETEXT = "Hier klicken, um die Erfahrungsbewertung abzuschließen."
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "Bitte Bewertung auswählen"
	
	FEEDBACKUI_SPECIFICWELCOME = "Vielen Dank für Ihre Kommentare zu " .. project_name .. ". Sie möchten Feedback geben zu:\n\n\n\n\nBitte wählen Sie eine der folgenden Feedbackoptionen aus, um fortzufahren:";
	FEEDBACKUI_GENERALWELCOME = "Vielen Dank für Ihre Kommentare zu " .. project_name .. ". Jede Einsendung, die wir erhalten, spielt eine wichtige Rolle für die Qualität des Spiels.\n\nBitte wählen Sie eine der folgenden Feedbackoptionen aus, um fortzufahren:";
	
	FEEDBACKUI_STARTBUG = "Fehler melden"
	FEEDBACKUI_STARTSURVEY = "Bewertung starten"
	FEEDBACKUI_STARTSUGGESTION = "Vorschlag einreichen"
	
	FEEDBACKUI_WELCOMEBUGHEADER = "Fehler"
	FEEDBACKUI_WELCOMESUGGESTHEADER = "Vorschlag"
	FEEDBACKUI_WELCOMESURVEYHEADER = "Bewertung"
	
	FEEDBACKUI_WELCOMEBUGTEXT = "Hier können Sie auf Fehler im Spiel hinweisen." 
	FEEDBACKUI_WELCOMESUGGESTTEXT = "Über einen Vorschlag können Sie Ideen für Verbesserungen des Spiels einreichen."
	FEEDBACKUI_WELCOMESURVEYTEXT = "Mit Bewertungen können Sie Feedback zu bestimmten Bereichen des Spiels abgeben."
	FEEDBACKUI_WELCOMESURVEYDISABLED = "Für dieses Thema steht momentan keine Bewertung zur Verfügung."
	
	FEEDBACKUI_MODIFIERKEY = "Belegung:"
	FEEDBACKUI_MOUSE1 = "Linksklick"
	FEEDBACKUI_MOUSE2 = "Rechtsklick"
	
	FEEDBACKUI_LALT = "LAlt"
	FEEDBACKUI_RALT = "RAlt"
	FEEDBACKUI_LCTRL = "LCtrl"
	FEEDBACKUI_RCTRL = "RCtrl"
	FEEDBACKUI_LSHIFT = "LShift"
	FEEDBACKUI_RSHIFT = "RShift"
	
	FEEDBACKUI_TOOLTIP_MESSAGE = "<Für Feedback %s-%s>";
	FEEDBACKUI_MAP_MESSAGE = "Für Feedback auf Karte %s-%s";
	FEEDBACKUI_ITEMTARGETS = { "Rüstung", "Verbrauchbar", "Behälter", "Projektil", "Köcher", "Waffe", "Rezept", "Edelstein" };
	FEEDBACKUI_MISCTYPE = "Verschiedenes";
	FEEDBACKUISHOWCUES_TEXT = "Tooltipps anzeigen";
	
	FEEDBACKUI_CATEGORYLABEL = "Art:"
	FEEDBACKUI_STATUSLABEL = "Status:"
	
	NEWBIE_TOOLTIP_BUG="Helfen Sie uns, " .. project_name .. " zu verbessern, indem Sie Fehler, Vorschläge oder eine Bewertung einreichen.\n\n" .. FEEDBACKUI_BLUE .. "Linksklick zum Beginnen.\nRechtsklick für Anzeigeoptionen.";
	FEEDBACKUILBLAPPEARANCE_TEXT = "Aussehen:"
	FEEDBACKUILBLUTILITY_TEXT = "Nutzen:"
	
	FEEDBACKUI_MOBSDIFFICULTYTABLEHEADER = "Schwierigkeitsgrad"                   
	FEEDBACKUI_MOBSDIFFICULTYTABLESUBTEXT = "Wie schwierig war der Gegner zu besiegen?"
	FEEDBACKUI_MOBSREWARDTABLEHEADER = "Belohnung"
	FEEDBACKUI_MOBSREWARDTABLESUBTEXT = "Wie würden Sie die Beute des Gegners bewerten?"
	FEEDBACKUI_MOBSFUNTABLEHEADER = "Spaß"
	FEEDBACKUI_MOBSFUNTABLESUBTEXT = "Wie unterhaltsam war die Begegnung?"
	FEEDBACKUI_MOBSAPPEARANCETABLEHEADER = "Ausssehen"
	FEEDBACKUI_MOBSAPPEARANCETABLESUBTEXT = "Wie würden Sie das Aussehen des Gegners bewerten?"
	
	FEEDBACKUI_ITEMSDIFFICULTYTABLEHEADER = "Schwierigkeitsgrad"
	FEEDBACKUI_ITEMSDIFFICULTYTABLESUBTEXT = "Wie schwer ist es, den Gegenstand zu erhalten?"
	FEEDBACKUI_ITEMSUTILITYHEADER = "Nutzen"
	FEEDBACKUI_ITEMSUTILITYSUBTEXT = "Bewerten Sie bitte den generellen Nutzen des Gegenstands?"
	FEEDBACKUI_ITEMSAPPEARANCETABLEHEADER = "Aussehen"
	FEEDBACKUI_ITEMSAPPEARANCETABLESUBTEXT = "Wie würden Sie das Aussehen des Gegenstands bewerten?"
	
	FEEDBACKUI_STRUTILITY1 = "Völlig nutzlos"
	FEEDBACKUI_STRUTILITY2 = "Fast gänzlich nutzlos"
	FEEDBACKUI_STRUTILITY3 = "Nützlich"
	FEEDBACKUI_STRUTILITY4 = "Sehr nützlich"
	
	FEEDBACKUI_UTILITY1 = "Völlig nutzlos"
	FEEDBACKUI_UTILITY2 = "Fast gänzlich nutzlos"
	FEEDBACKUI_UTILITY3 = "Nützlich"
	FEEDBACKUI_UTILITY4 = "Sehr nützlich"
	
	FEEDBACKUI_STRAPPEARANCE1 = "Ungenügend"
	FEEDBACKUI_STRAPPEARANCE2 = "Unscheinbar"
	FEEDBACKUI_STRAPPEARANCE3 = "Gut"
	FEEDBACKUI_STRAPPEARANCE4 = "Herausragend"
	
	FEEDBACKUI_APPEARANCE1 = "Ungenügend"
	FEEDBACKUI_APPEARANCE2 = "Unscheinbar"
	FEEDBACKUI_APPEARANCE3 = "Gut"
	FEEDBACKUI_APPEARANCE4 = "Herausragend"
	
	FEEDBACKUI_POIUNDERCITY = "Unterstadt";
	FEEDBACKUI_POISILVERMOON = "Silbermond";
	FEEDBACKUI_POIIRONFORGE = "Eisenschmiede";
	FEEDBACKUI_POISTORMWIND = "Sturmwind";
	FEEDBACKUI_POISEPULCHER = "Das Grabmal";
	FEEDBACKUI_POITARRENMILL = "Tarrens Mühle";
	FEEDBACKUI_POISOUTHSHORE = "Süderstade";
	FEEDBACKUI_POIAERIEPEAK = "Nistgipfel";
	FEEDBACKUI_POIREVANTUSK = "Dorf der Bruchhauer";
	FEEDBACKUI_POIHAMMERFALL = "Hammerfall";
	FEEDBACKUI_POIMENETHIL = "Hafen von Menethil";
	FEEDBACKUI_POITHELSAMAR = "Thelsamar";
	FEEDBACKUI_POIKARGATH = "Kargath";
	FEEDBACKUI_POILAKESHIRE = "Seenhain";
	FEEDBACKUI_POISENTINELHILL = "Späherkuppe";
	FEEDBACKUI_POIDARKSHIRE = "Dunkelhain";
	FEEDBACKUI_POISTONARD = "Steinard";
	FEEDBACKUI_POIGROMGOL = "Basislager von Grom'gol";
	FEEDBACKUI_POIBOOTY = "Beutebucht"
	
	FEEDBACKUI_POIDARNASSUS = "Darnassus";
	FEEDBACKUI_POIEXODAR = "Die Exodar";
	FEEDBACKUI_POIORGRIMMAR = "Orgrimmar";
	FEEDBACKUI_POITHUNDERB = "Donnerfels";
	FEEDBACKUI_POIAUBERDINE = "Auberdine";
	FEEDBACKUI_POIEVERLOOK = "Ewige Warte";
	FEEDBACKUI_POISTONETALON = "Steinkrallengipfel";
	FEEDBACKUI_POIASTRANAAR = "Astranaar";
	FEEDBACKUI_POISPLINTERTREE = "Splitterholzposten";
	FEEDBACKUI_POISUNROCK = "Sonnenfels";
	FEEDBACKUI_POINIJELS = "Nijelspitze";
	FEEDBACKUI_POISHADOWPREY = "Schattenflucht";
	FEEDBACKUI_POIFEATHERMOON = "Mondfederfeste";
	FEEDBACKUI_POIMOJACHE = "Camp Mojache";
	FEEDBACKUI_POITHALANAAR = "Thalanaar";
	FEEDBACKUI_POICENARIONHOLD = "Burg Cenarius";
	FEEDBACKUI_POIGADGET = "Gadgetzan";
	FEEDBACKUI_POIFREEWIND = "Freiwindposten";
	FEEDBACKUI_POITAURAJO = "Camp Taurajo";
	FEEDBACKUI_POICROSSROADS = "Das Wegekreuz";
	FEEDBACKUI_POIRATCHET = "Ratschet";
	FEEDBACKUI_POITHERAMORE = "Insel Theramore";
	
	FEEDBACKUI_SURVEYTOOLTIPMOBHEADER = "Gegnername:"
	FEEDBACKUI_SURVEYTOOLTIPMOBZONEHEADER = "Gefunden in:"
	
	FEEDBACKUI_VOICECHAT = "Sprachchat";
	FEEDBACKUI_VOICECHATTOOLTIP = FEEDBACKUI_WHITE .. FEEDBACKUI_VOICECHAT;
	FEEDBACKUI_STRVOICECHAT = "Problem mit dem Sprachchat.";
	FEEDBACKUI_HEADSETTYPE = "Welche Art von Headset benutzt ihr?";
	
	FEEDBACKUI_USBHEADSET = "USB Headset";
	FEEDBACKUI_ANALOGHEADSET = "Analoges Headset"; --localize me
	FEEDBACKUI_HARDWIREDMIC = "Festverdrahtetes Mikrofon"; --localize me
	
	FEEDBACKUI_STRUSBHEADSET = "Ich benutze ein USB Headset.";
	FEEDBACKUI_STRANALOGHEADSET = "Ich benutze ein Analoges Headset.";
	FEEDBACKUI_STRHARDWIREDMIC = "Ich benutze ein festverdrahtetes Mikrofon."; --localize me
	
elseif ( GetLocale() == "esES" ) then
	-- Localized Spanish strings for FEEDBACKUI
	--[[
	function esES() end
	]]--
	--Non-instance special zone names
	FEEDBACKUI_EXCEPTIONZONES = { "Tren subterráneo", "Mar Adusto", "Mare Magnum", "Valle de Alterac", "Cuenca de Arathi", "Garganta Grito de Guerra", "Sala de los Campeones", "Montaña Roca Negra", "Mar de la Bruma", "Sala de las Leyendas", "El Vacío Abisal", "Fortaleza de Utgarde", }
	
	--Headers    
	FEEDBACKUIINFOPANELLABEL_TEXT = "Tus datos"
	FEEDBACKUI_BUGINPUTHEADER = "Describe este error"
	FEEDBACKUI_BUGINPUTSUBTEXT = "¿Cómo podemos reproducir este error?"
	FEEDBACKUI_SUGGESTINPUTHEADER = "Describe tu sugerencia"
	FEEDBACKUI_SUGGESTINPUTSUBTEXT = "¿Qué te gustaría sugerir?"
	
	--Labels
	FEEDBACKUIFEEDBACKFRMTITLE_TEXT = "Mandar información"
	FEEDBACKUILBLFRMVER_TEXT = "Versión:"
	FEEDBACKUILBLFRMREALM_TEXT = "Reino:"
	FEEDBACKUILBLFRMNAME_TEXT = "Nombre:"
	FEEDBACKUILBLFRMCHAR_TEXT = "Personaje:"
	FEEDBACKUILBLFRMMAP_TEXT = "Mapa:"
	FEEDBACKUILBLFRMZONE_TEXT = "Zona:"
	FEEDBACKUILBLFRMAREA_TEXT = "Área:"
	FEEDBACKUILBLFRMADDONS_TEXT = "Addons: "
	FEEDBACKUILBLADDONSWRAP_TEXT = "Addons actuales:\n"
	FEEDBACKUITYPEBUG_TEXT = "Error"
	FEEDBACKUITYPESUGGEST_TEXT = "Sugerencia"
	FEEDBACKUITYPESURVEY_TEXT = "Encuesta"
	FEEDBACKUILBLFRMWHO_TEXT = "Quién: "
	FEEDBACKUILBLFRMWHERE_TEXT = "Dónde: "
	FEEDBACKUILBLFRMWHEN_TEXT = "Cuándo: "
	FEEDBACKUILBLFRMTYPE_TEXT = "Tipo: "
	FEEDBACKUI_GENDERTABLE = { "Desconocido", "Masculino", "Femenino" }
	
	--Prompts
	FEEDBACKUIBUGFRMINPUTBOX_TEXT = "<Escribe aquí los pasos a seguir para reproducir el error>"
	FEEDBACKUISUGGESTFRMINPUTBOX_TEXT = "<Escribe tu sugerencia aquí>"
	FEEDBACKUILBLADDONS_MOUSEOVER = "<Texto al pasar el ratón de los addons cargados>"
	FEEDBACKUI_CONFIRMATION = "Tu información se ha enviado.\n¡Gracias por ayudarnos a mejorar " .. project_name .. "!"
	
	--Tooltips & Buttons
	BUG_BUTTON="Enviar información"
	NEWBIE_TOOLTIP_BUG="Envíanos información sobre errores o sugerencias para ayudarnos a mejorar " .. project_name .. "."
	FEEDBACKUIBACK_TEXT = "Volver"
	FEEDBACKUIRESET_TEXT = "Borrar todo"
	FEEDBACKUISUBMIT_TEXT = "Enviar"
	FEEDBACKUISTART_TEXT = "¡Inicio!"
	
	--Tables and strings for navigation.
	FEEDBACKUI_WELCOMETABLEBUGHEADER = "Informa de un error"
	FEEDBACKUI_WELCOMETABLESUGGESTHEADER = "Haz una sugerencia"
	FEEDBACKUI_WELCOMETABLESUBTEXT = "¡Gracias por la información!"
	
	FEEDBACKUI_WELCOME = "\nGracias por tu información sobre " .. project_name .. ". Cada mensaje que recibimos es vital para lograr la calidad de " .. project_name .. ".\n\nRellena este corto cuestionario para ayudarnos a procesar los numerosos mensajes que recibimos de forma efectiva.\n\nGracias,\nThe " .. project_name .. " Team"
	
	FEEDBACKUI_WHOTABLEHEADER = FEEDBACKUI_WHITE .. "Quién" .. FEEDBACKUI_WHITE 
	FEEDBACKUI_WHOTABLESUBTEXT = "¿A qué afecta este problema?"
	
	FEEDBACKUI_STRWHOPLAYER = "Afecta a mi personaje."
	FEEDBACKUI_STRPARTYMEMBER = "Afecta a los jugadores de mi grupo."
	FEEDBACKUI_STRRAIDMEMBER = "Afecta a los jugadores de mi banda."
	FEEDBACKUI_STRENEMYPLAYER = "Afecta a un jugador enemigo."
	FEEDBACKUI_STRFRIENDLYPLAYER = "Afecta a un jugador aliado."
	FEEDBACKUI_STRENEMYCREATURE = "Afecta a una criatura enemiga."
	FEEDBACKUI_STRFRIENDLYCREATURE = "Afecta a una criatura aliada."
	FEEDBACKUI_STRWHONA = "No afecta ni a jugadores ni a criaturas."
	
	FEEDBACKUI_WHOPLAYER = "Mi personaje"
	FEEDBACKUI_ENEMYPLAYER = "Personaje enemigo"
	FEEDBACKUI_FRIENDLYPLAYER = "Personaje aliado"
	FEEDBACKUI_PARTYMEMBER = "Miembro grupo"
	FEEDBACKUI_RAIDMEMBER = "Miembro banda"
	FEEDBACKUI_ENEMYCREATURE = "Criatura enemiga"
	FEEDBACKUI_FRIENDLYCREATURE = "Criatura aliada"
	FEEDBACKUI_WHONA = "N/A"
	
	FEEDBACKUI_WHERETABLEHEADER = FEEDBACKUI_WHITE .. "Dónde" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHERETABLESUBTEXT = "¿Dónde ocurre este problema?"
	
	FEEDBACKUI_STRAREATABLE = "Ocurre durante el juego."
	FEEDBACKUI_STRWHEREINSTALL = "Ocurre durante la instalación."
	FEEDBACKUI_STRWHEREDOWNLOAD = "Ocurre durante la descarga."
	FEEDBACKUI_STRWHEREPATCH = "Ocurre instalando un parche."
	
	FEEDBACKUI_WHEREINSTALL = "Durante instalación"
	FEEDBACKUI_WHEREDOWNLOAD = "Durante descarga"
	FEEDBACKUI_WHEREPATCH = "Durante parche"
	
	FEEDBACKUI_AREATABLESUMMARY = FEEDBACKUI_GREEN .. "En algún lugar del juego"
	
	---------------------------------------- Begin Area Strings ------------------------------------------------------------------
	FEEDBACKUI_STROCCURS = "- This occurs in "; --localize me
	FEEDBACKUI_EVERYWHERE = "En todo el juego"
	FEEDBACKUI_STREVERYWHERE = "En todos sitios en el juego."
	
	--AZEROTH
	FEEDBACKUI_AZEROTH = "Azeroth"
	
	--Northrend
	FEEDBACKUI_NORTHREND = "Rasganorte"
	FEEDBACKUI_BOREANTUNDRA = "Tundra Boreal"
	FEEDBACKUI_CRYSTALSONG = "Bosque Canto de Cristal" --LOCALIZE ME
	FEEDBACKUI_DALARAN = "Dalaran" 
	FEEDBACKUI_DRAGONBLIGHT = "Cementerio de Dragones"
	FEEDBACKUI_GRIZZLYHILLS = "Colinas Pardas"
	FEEDBACKUI_HOWLINGFJORD = "Fiordo Aquilonal"
	FEEDBACKUI_ICECROWN = "Corona de Hielo" --LOCALIZE ME
	FEEDBACKUI_NEXUS = "El Nexo"
	FEEDBACKUI_SHOLAZARBASIN = "Cuenca de Sholazar" --LOCALIZE ME
	FEEDBACKUI_STORMPEAKS = "Las Cumbres Tormentosas" --LOCALIZE ME
	FEEDBACKUI_UTGARDEPINNACLE = "Pináculo de Utgarde"
	FEEDBACKUI_WINTERGRASP = "Conquista del Invierno" --LOCALIZE ME
	FEEDBACKUI_ZULDRAK = "Zul'Drak" 
	FEEDBACKUI_STRNORTHREND = "Ocurre en Rasganorte."
	--End Northrend-----------------------------------
	
	--Eastern Kingdoms
	FEEDBACKUI_EKINGDOMS = "Reinos del Este"
	FEEDBACKUI_ALTERACMOUNTAINS = "Montañas de Alterac"
	FEEDBACKUI_ALTERACVALLEY = "Valle de Alterac"
	FEEDBACKUI_ARATHIBASIN = "Cuenca de Arathi"
	FEEDBACKUI_ARATHIHIGHLANDS = "Tierras Altas de Arathi"
	FEEDBACKUI_BADLANDS = "Tierras Inhóspitas"
	FEEDBACKUI_BLACKROCKMOUNTAIN = "Montaña Roca Negra"
	FEEDBACKUI_BLASTEDLANDS = "Las Tierras Devastadas"
	FEEDBACKUI_BURNINGSTEPPES = "Las Estepas Ardientes"
	FEEDBACKUI_DEADWINDPASS = "Paso de la Muerte"
	FEEDBACKUI_DUNMOROGH = "Dun Morogh"
	FEEDBACKUI_DUSKWOOD = "Bosque del Ocaso"
	FEEDBACKUI_EPLAGUELANDS = "Tierras de la Peste del Este"
	FEEDBACKUI_ELWYNN = "Bosque de Elwynn"
	FEEDBACKUI_EVERSONG = "Bosque Canción Eterna"
	FEEDBACKUI_GHOSTLANDS = "Tierras Fantasma"
	FEEDBACKUI_HILLSBRAD = "Laderas de Trabalomas"
	FEEDBACKUI_HINTERLANDS = "Tierras del Interior"
	FEEDBACKUI_IRONFORGE = "Forjaz"
	FEEDBACKUI_ISLEOFQUELDANAS = "Isla de Quel’Danas" --LOCALIZE ME
	FEEDBACKUI_LOCHMODAN = "Loch Modan";
	FEEDBACKUI_REDRIDGE = "Montañas Crestagrana"
	FEEDBACKUI_SEARINGGORGE = "La Garganta de Fuego"
	FEEDBACKUI_SILVERMOON = "Ciudad de Lunargenta"
	FEEDBACKUI_SILVERPINE = "Bosque de Argénteos"
	FEEDBACKUI_STORMWIND = "Ventormenta"
	FEEDBACKUI_STRANGLETHORN = "Vega de Tuercespina"
	FEEDBACKUI_SWAMPOFSORROWS = "Pantano de las Penas";
	FEEDBACKUI_TIRISFAL = "Claros de Tirisfal"
	FEEDBACKUI_UNDERCITY = "Entrañas"
	FEEDBACKUI_WPLAGUELANDS = "Tierras de la Peste del Oeste"
	FEEDBACKUI_WESTFALL = "Páramos de Poniente"
	FEEDBACKUI_WETLANDS = "Los Humedales"
	FEEDBACKUI_STREKINGDOMS = "Ocurre en los Reinos del Este."
	--End Eastern Kingdoms-------------------------------------------------------------------------------------------------------
	
	--Kalimdor
	FEEDBACKUI_KALIMDOR = "Kalimdor"
	FEEDBACKUI_ASHENVALE = "Vallefresno"
	FEEDBACKUI_AZSHARA = "Azshara"
	FEEDBACKUI_AZUREMYST = "Isla Bruma Azur"
	FEEDBACKUI_BARRENS = "Los Baldíos"
	FEEDBACKUI_BLOODMYST = "Isla Bruma de Sangre"
	FEEDBACKUI_DARKSHORE = "Costa Oscura"
	FEEDBACKUI_DARNASSUS = "Darnassus"
	FEEDBACKUI_DESOLACE = "Desolace";
	FEEDBACKUI_DUROTAR = "Durotar";
	FEEDBACKUI_DUSTWALLOW = "Marjal Revolcafango"
	FEEDBACKUI_EXODAR = "El Exodar"
	FEEDBACKUI_FELWOOD = "Frondavil"
	FEEDBACKUI_FERALAS = "Feralas"
	FEEDBACKUI_MOONGLADE = "Claro de la Luna"
	FEEDBACKUI_MULGORE = "Mulgore";
	FEEDBACKUI_ORGRIMMAR = "Orgrimmar";
	FEEDBACKUI_SILITHUS = "Silithus";
	FEEDBACKUI_STONETALON = "Sierra Espolón"
	FEEDBACKUI_TANARIS = "Tanaris";
	FEEDBACKUI_TELDRASSIL = "Teldrassil";
	FEEDBACKUI_THUNDERBLUFF = "Cima del Trueno"
	FEEDBACKUI_THOUSANDNEEDLES = "Las Mil Agujas"
	FEEDBACKUI_UNGORO = "Cráter de Un'Goro"
	FEEDBACKUI_WARSONG = "Garganta Grito de Guerra"
	FEEDBACKUI_WINTERSPRING = "Cuna del Invierno"
	FEEDBACKUI_STRKALIMDOR = "Ocurre en Kalimdor."
	--End Kalimdor ------------------------------------------------------------------------------------------------------------------
	
	--OUTLAND
	FEEDBACKUI_OUTLANDS = "Terrallende"
	FEEDBACKUI_BLADESEDGE = "Montañas Filospada"
	FEEDBACKUI_HELLFIRE = "Península del Fuego Infernal"
	FEEDBACKUI_NAGRAND = "Nagrand"
	FEEDBACKUI_NETHERSTORM = "Tormenta Abisal"
	FEEDBACKUI_SHADOWMOON = "Valle Sombraluna"
	FEEDBACKUI_SHATTRATH = "Ciudad de Shattrath"
	FEEDBACKUI_TERROKAR = "Bosque de Terokkar"
	FEEDBACKUI_TWISTINGNETHER = "El Vacío Abisal"
	FEEDBACKUI_ZANGARMARSH = "Marisma de Zangar"
	FEEDBACKUI_STROUTLANDS = "Ocurre en Terrallende."
	--End Outlands--------------------------------------------
	
	--Alert Targets/Extra areas
	FEEDBACKUI_BLACKTEMPLE = "Templo Oscuro"
	FEEDBACKUI_ZULAMAN = "Zul'Aman"
	FEEDBACKUI_KAJA = "Kaja'mine"
	FEEDBACKUI_SUNWELLPLATEAU = "Meseta de La Fuente del Sol"
	FEEDBACKUI_MAGISTERSTERRACE = "Bancal del Magister"
	FEEDBACKUI_UTGARDEKEEP = "Fortaleza de Utgarde"
	FEEDBACKUI_DRAKTHARONKEEP = "Fortaleza de Drak'Tharon"
	FEEDBACKUI_ULDUAR = "Ulduar"
	FEEDBACKUI_HOL = "Cámaras de Relámpagos"
	FEEDBACKUI_TAC = "El Coliseo Argenta"
	FEEDBACKUI_IOC = "Isla de la Conquista"
	--End Alert Targets/Extra areas
	--------------------------------------------End Area Strings---------------------------------------------------------------------
	
	FEEDBACKUI_WHENTABLEHEADER = FEEDBACKUI_WHITE .. "Cuándo" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHENTABLESUBTEXT = "¿Con qué frecuencia ocurre?"
	
	FEEDBACKUI_STRREPRODUCABLE = "Ocurre continuamente."
	FEEDBACKUI_STRSOMETIMES = "Ocurre ocasionalmente."
	FEEDBACKUI_STRRARELY = "Ocurre pocas veces."
	FEEDBACKUI_STRONETIME = "Sólo ha ocurrido una vez."
	
	
	FEEDBACKUI_REPRODUCABLE = "Siempre"
	FEEDBACKUI_SOMETIMES = "Ocasionalmente"
	FEEDBACKUI_RARELY = "Pocas veces"
	FEEDBACKUI_ONETIME = "Una vez"
	
	FEEDBACKUI_TYPETABLEHEADER = FEEDBACKUI_WHITE .. "Tipo" .. FEEDBACKUI_WHITE
	FEEDBACKUI_TYPETABLESUBTEXT = "¿Qué tipo de problema es?"
	
	FEEDBACKUI_STRUIOTHER = "Es un problema de interfaz."
	FEEDBACKUI_STRUIITEMS = "- Es un problema de la interfaz de objetos."
	FEEDBACKUI_STRUISPAWNS = "- Es un problema de la interfaz de criaturas."
	FEEDBACKUI_STRUIQUESTS = "- Es un problema de la interfaz de misiones."
	FEEDBACKUI_STRUISPELLS = "- Es un problema de la interfaz de hechizos o talentos."
	FEEDBACKUI_STRUITRADESKILLS = "- Es un problema de la interfaz de oficios."
	
	FEEDBACKUI_STRGRAPHICOTHER = "Es un problema gráfico."
	FEEDBACKUI_STRGRAPHICITEMS = "- Es un problema gráfico con objetos."
	FEEDBACKUI_STRGRAPHICSPAWNS = "- Es un problema gráfico de criaturas."
	FEEDBACKUI_STRGRAPHICSPELLS = "- Es un problema gráfico de talentos."
	FEEDBACKUI_STRGRAPHICENVIRONMENT = "- Es un problema gráfico de efectos ambientales."
	
	FEEDBACKUI_STRFUNCOTHER = "Este problema afecta de funcionamiento del juego."
	FEEDBACKUI_STRFUNCITEMS = "- Afecta al funcionamiento de objetos."
	FEEDBACKUI_STRFUNCSPAWNS = "- Afecta al funcionamiento de criaturas."
	FEEDBACKUI_STRFUNCQUESTS = "- Afecta al funcionamiento de misiones."
	FEEDBACKUI_STRFUNCSPELLS = "- Afecta al funcionamiento de hechizos o talentos."
	FEEDBACKUI_STRFUNCTRADESKILLS = "- Afecta al funcionamiento de oficios."
	
	FEEDBACKUI_STRCRASHOTHER = "Es un problema de estabilidad."
	FEEDBACKUI_STRCRASHBUG = "- Causa que WoW se cierre."
	FEEDBACKUI_STRCRASHSOFTLOCK = "- Causa que WoW deje de responder."
	FEEDBACKUI_STRCRASHHARDLOCK = "- Causa que mi ordenador no responda."
	FEEDBACKUI_STRCRASHWOWLAG = "- Relacionado con un retardo de conexión."
	
	FEEDBACKUI_UIITEMS = "Problema de interfaz de objeto"
	FEEDBACKUI_UISPAWNS = "Problema de interfaz de criatura"
	FEEDBACKUI_UIQUESTS = "Problema de interfaz de misión"
	FEEDBACKUI_UISPELLS = "Problema de interfaz de hechizo o talento"
	FEEDBACKUI_UITRADESKILLS = "Problema de interfaz de oficio"
	FEEDBACKUI_UIOTHER = "Problema de interfaz general"
	
	FEEDBACKUI_GRAPHICITEMS = "Problema gráfico de objeto"
	FEEDBACKUI_GRAPHICSPAWNS = "Problema gráfico de criatura"
	FEEDBACKUI_GRAPHICSPELLS = "Problema gráfico de hechizo o talento"
	FEEDBACKUI_GRAPHICENVIRONMENT = "Problema gráfico ambiental"
	FEEDBACKUI_GRAPHICOTHER = "General Graphics Issue"
	
	FEEDBACKUI_FUNCITEMS = "Problema de funcionamiento de objeto"
	FEEDBACKUI_FUNCSPAWNS = "Problema de funcionamiento de criatura"
	FEEDBACKUI_FUNCQUESTS = "Problema de funcionamiento de misión"
	FEEDBACKUI_FUNCSPELLS = "Problema de funcionamiento de hechizo o talento"  
	FEEDBACKUI_FUNCTRADESKILLS = "Problema de funcionamiento de oficio"
	FEEDBACKUI_FUNCOTHER = "Problema de funcionamiento general"
	
	FEEDBACKUI_SPELLSPOWERTABLEHEADER = "Poder"
	FEEDBACKUI_SPELLSPOWERTABLESUBTEXT = "¿Es potente esta facultad?"
	FEEDBACKUI_SPELLSFREQUENCYTABLEHEADER = "Frecuencia"
	FEEDBACKUI_SPELLSFREQUENCYTABLESUBTEXT = "¿Con qué frecuencia usas esta facultad?"
	FEEDBACKUI_SPELLSAPPROPRIATETABLEHEADER = "Pertinencia"
	FEEDBACKUI_SPELLSAPPROPRIATETABLESUBTEXT = "¿Encaja con otras facultades similares?"
	FEEDBACKUI_SPELLSFUNTABLEHEADER = "Diversión"
	FEEDBACKUI_SPELLSFUNTABLESUBTEXT = "¿Es divertida esta facultad?"
	
	FEEDBACKUI_STRPOWER1 = "Muy poco";
	FEEDBACKUI_STRPOWER2 = "Poco";
	FEEDBACKUI_STRPOWER3 = "Es potente";
	FEEDBACKUI_STRPOWER4 = "Muy potente";
	
	FEEDBACKUI_STRFREQUENCY1 = "Casi nunca";
	FEEDBACKUI_STRFREQUENCY2 = "A veces";
	FEEDBACKUI_STRFREQUENCY3 = "Con frecuencia";
	FEEDBACKUI_STRFREQUENCY4 = "Siempre que puedo";
	
	FEEDBACKUI_STRAPPROPRIATE1 = "Muy poco"; 
	FEEDBACKUI_STRAPPROPRIATE2 = "Poco"; 
	FEEDBACKUI_STRAPPROPRIATE3 = "Encaja bien";
	FEEDBACKUI_STRAPPROPRIATE4 = "Encaja perfectamente";
	
	FEEDBACKUI_SPELLHEADERTEXT = "Hechizos"
	FEEDBACKUILBLPOWER_TEXT = "Poder:"
	FEEDBACKUILBLFREQUENCY_TEXT = "Frecuencia:"
	FEEDBACKUILBLAPPROPRIATE_TEXT = "Pertinencia:"
	
	FEEDBACKUI_CRASHBUG = "El problema hace que WoW se cierre"
	FEEDBACKUI_CRASHSOFTLOCK = "El problema hace que WoW se cuelgue"
	FEEDBACKUI_CRASHHARDLOCK = "El problema hace que el ordenador se cuelgue"
	FEEDBACKUI_CRASHWOWLAG = "El problema ralentiza WoW"
	FEEDBACKUI_CRASHOTHER = "Es un problema de estabilidad general"
	
	FEEDBACKUILBLFRMCLARITY_TEXT = "Claridad:"
	FEEDBACKUILBLFRMDIFFICULTY_TEXT = "Dificultad:"
	FEEDBACKUILBLFRMREWARD_TEXT = "Recompensa:"
	FEEDBACKUILBLFRMFUN_TEXT = "Diversión:"
	FEEDBACKUISURVEYTYPE_QUEST = "Misión"
	FEEDBACKUISURVEYTYPE_AREA = "Estancia"
	
	FEEDBACKUISKIP_TEXT = "Saltar encuesta"
	FEEDBACKUILBLSURVEYALERTSCHECK_TEXT = "Mostrar alertas"
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "Por favor, escoge una encuesta."
	FEEDBACKUI_WELCOMETABLESURVEYSUBTEXT = "Las encuestas se añaden al probar nuevo contenido."
	
	FEEDBACKUI_SURVEYCOLUMNNAME = "Nombre"
	FEEDBACKUI_SURVEYCOLUMNMODIFIED = "Probado"
	
	FEEDBACKUI_ALLHEADERTEXT = "Todo"
	FEEDBACKUI_AREAHEADERTEXT = "Estancias"
	FEEDBACKUI_QUESTHEADERTEXT = "Misiones"
	
	FEEDBACKUI_STATUSALLTEXT = "Todo"
	FEEDBACKUI_STATUSAVAILABLETEXT = "Disponible"
	FEEDBACKUI_STATUSSKIPPEDTEXT = "Descartado"
	FEEDBACKUI_STATUSCOMPLETEDTEXT = "Completado"
	
	FEEDBACKUI_SURVEYTOOLTIPQUESTHEADER = "Nombre misión:"
	FEEDBACKUI_SURVEYTOOLTIPAREAHEADER = "Nombre estancia:"
	FEEDBACKUI_SURVEYTOOLTIPEXPERIENCEDHEADER = "Ocurrido:"
	FEEDBACKUI_SURVEYTOOLTIPQUESTOBJECTIVESHEADER = "Objetivos de misión:"
	
	FEEDBACKUI_NEW = "Nuevo"
	FEEDBACKUI_HOURAGO = " hora"
	FEEDBACKUI_HOURSAGO = " horas"
	FEEDBACKUI_DAYAGO = " día"
	FEEDBACKUI_DAYSAGO = " días"
	FEEDBACKUI_MONTHAGO = " mes"
	FEEDBACKUI_MONTHSAGO = " meses"
	FEEDBACKUI_YEARAGO = " año"
	FEEDBACKUI_YEARSAGO = " años"
	
	FEEDBACKUI_QUESTSCLARITYTABLEHEADER = "Claridad"
	FEEDBACKUI_QUESTSCLARITYTABLESUBTEXT = "¿Son suficientemente claros los objetivos de la misión?"
	
	FEEDBACKUI_STRCLARITY1 = "Muy vagos"
	FEEDBACKUI_STRCLARITY2 = "Algo vagos"
	FEEDBACKUI_STRCLARITY3 = "Bastante claros"
	FEEDBACKUI_STRCLARITY4 = "Perfectamente claros"
	
	FEEDBACKUI_CLARITY1 = "Muy vagos"
	FEEDBACKUI_CLARITY2 = "Algo vagos"
	FEEDBACKUI_CLARITY3 = "Bastante claros"
	FEEDBACKUI_CLARITY4 = "Perfectamente claros"
	
	FEEDBACKUI_QUESTSDIFFICULTYTABLEHEADER = "Dificultad"
	FEEDBACKUI_QUESTSDIFFICULTYTABLESUBTEXT = "¿Cuál fue la dificultad de la misión?"
	FEEDBACKUI_AREASDIFFICULTYTABLEHEADER = "Dificultad"
	FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT = "¿Cuál fue la dificultad de los encuentros de la estancia?"
	
	FEEDBACKUI_STRDIFFICULTY1 = "Fácil"
	FEEDBACKUI_STRDIFFICULTY2 = "Razonable"
	FEEDBACKUI_STRDIFFICULTY3 = "Desafiante"
	FEEDBACKUI_STRDIFFICULTY4 = "Difícil"
	FEEDBACKUI_STRDIFFICULTY5 = "N/A"
	
	FEEDBACKUI_DIFFICULTY1 = "Fácil"
	FEEDBACKUI_DIFFICULTY2 = "Razonable"
	FEEDBACKUI_DIFFICULTY3 = "Desafiante"
	FEEDBACKUI_DIFFICULTY4 = "Difícil"
	FEEDBACKUI_DIFFICULTY5 = "N/A"
	
	FEEDBACKUI_QUESTSREWARDTABLEHEADER = "Recompensa"
	FEEDBACKUI_QUESTSREWARDTABLESUBTEXT = "¿Cómo valoras la recompensa de la misión?"
	FEEDBACKUI_AREASREWARDTABLEHEADER = "Recompensa"
	FEEDBACKUI_AREASREWARDTABLESUBTEXT = "¿Cómo valoras la recompensa de la estancia?"
	
	FEEDBACKUI_STRREWARD1 = "Horrible"
	FEEDBACKUI_STRREWARD2 = "Mala"
	FEEDBACKUI_STRREWARD3 = "Buena"
	FEEDBACKUI_STRREWARD4 = "Genial"
	FEEDBACKUI_STRREWARD5 = "N/A"
	
	FEEDBACKUI_REWARD1 = "Horrible"
	FEEDBACKUI_REWARD2 = "Mala"
	FEEDBACKUI_REWARD3 = "Buena"
	FEEDBACKUI_REWARD4 = "Genial"
	FEEDBACKUI_REWARD5 = "N/A"
	
	FEEDBACKUI_QUESTSFUNTABLEHEADER = "Diversión"
	FEEDBACKUI_QUESTSFUNTABLESUBTEXT = "¿Fue divertida la misión?"
	FEEDBACKUI_AREASFUNTABLEHEADER = "Diversión"
	FEEDBACKUI_AREASFUNTABLESUBTEXT = "¿Fue divertida la estancia?"
	
	FEEDBACKUI_STRFUN1 = "Nada divertida"
	FEEDBACKUI_STRFUN2 = "No muy divertida"
	FEEDBACKUI_STRFUN3 = "Bastante divertida"
	FEEDBACKUI_STRFUN4 = "Muy divertida"
	
	FEEDBACKUI_FUN1 = "Nada divertida"
	FEEDBACKUI_FUN2 = "No muy divertida"
	FEEDBACKUI_FUN3 = "Bastante divertida"
	FEEDBACKUI_FUN4 = "Muy divertida"
	
	FEEDBACKUISURVEYFRMINPUTBOX_TEXT = "<Escribe cualquier otro comentario aquí.>"
	FEEDBACKUI_SURVEYINPUTHEADER = "Añade más comentarios"
	FEEDBACKUIRESUBMIT_TEXT = "Reenviar"
	
	FEEDBACKUI_WELCOMETABLEBUGHEADER = "Señalar un error"
	FEEDBACKUI_WELCOMETABLEBUGSUBTEXT = "Señalar errores ayuda a arreglar los problemas del juego"
	FEEDBACKUI_WELCOMETABLESUGGESTHEADER = "Hacer una sugerencia"
	FEEDBACKUI_WELCOMETABLESUGGESTSUBTEXT = "Las sugerencias nos ayudan a mejorar el diseño del juego"
	FEEDBACKUI_BUGINPUTHEADER = "¿Cómo podemos reproducir este error?"
	FEEDBACKUI_SUGGESTINPUTHEADER = "Describe tu sugerencia."
	
	FEEDBACKUI_SURVEYNEWBIETEXT = "Chasque aquí para completar una encuesta sobre una mazmorra o búsqueda que han terminado recientemente."
	FEEDBACKUI_POIMASK = ".-%s%-%s(.+)"
	
	
	FEEDBACKUI_LEVELPREFIX = "Nivel"
	FEEDBACKUI_HILLSBRAD = "Reinos del Este - Laderas de Trabalomas";
	FEEDBACKUISURVEYTYPE_AREA = "Área"
	FEEDBACKUISURVEYTYPE_ITEM = "Objeto"
	FEEDBACKUISURVEYTYPE_MOB = "Enemigo"
	FEEDBACKUI_AREAHEADERTEXT = "Áreas"
	FEEDBACKUI_QUESTHEADERTEXT = "Misiones"
	FEEDBACKUI_ITEMHEADERTEXT = "Objetos"
	FEEDBACKUI_MOBHEADERTEXT = "Enemigos"
	FEEDBACKUI_SURVEYTOOLTIPAREAHEADER = "Nombre del área:"
	FEEDBACKUI_AREASDIFFICULTYTABLEHEADER = "Dificultad"
	FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT = "¿Qué dificultad han tenido los encuentros del área?"
	FEEDBACKUI_AREASREWARDTABLEHEADER = "Recompensa"
	FEEDBACKUI_AREASREWARDTABLESUBTEXT = "¿Cómo valorarías las recompensas de esta área?"
	FEEDBACKUI_AREASFUNTABLEHEADER = "Diversión"
	FEEDBACKUI_AREASFUNTABLESUBTEXT = "¿Cuánto te has divertido en el área?"
	FEEDBACKUI_SURVEYINPUTSUBTEXT = "Haz clic aquí para ver algunas opiniones"
	FEEDBACKUI_SURVEYNEWBIETEXT = "Haz clic aquí para rellenar una encuesta sobre esta experiencia."
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "Selecciona una encuesta"
	
	FEEDBACKUI_SPECIFICWELCOME = "Gracias por tu opinión acerca de " .. project_name .. ". Has elegido opinar sobre:\n\n\n\n\nElige una de las siguientes opciones para continuar:";
	FEEDBACKUI_GENERALWELCOME = "Gracias por tu opinión acerca de " .. project_name .. ". Cada comentario que recibimos desempeña un papel muy importante a la hora de determinar la calidad del juego.\n\nElige una de estas opciones para continuar:";
	
	FEEDBACKUI_STARTBUG = "Informar de un error"
	FEEDBACKUI_STARTSURVEY = "Comenzar encuesta"
	FEEDBACKUI_STARTSUGGESTION = "Hacer una sugerencia"
	
	FEEDBACKUI_WELCOMEBUGHEADER = "Error"
	FEEDBACKUI_WELCOMESUGGESTHEADER = "Sugerencia"
	FEEDBACKUI_WELCOMESURVEYHEADER = "Encuesta"
	
	FEEDBACKUI_WELCOMEBUGTEXT = "Un error nos informa acerca de un fallo que has encontrado en el juego." 
	FEEDBACKUI_WELCOMESUGGESTTEXT = "Una sugerencia nos informa de qué te gustaría que mejoráramos en el juego."
	FEEDBACKUI_WELCOMESURVEYTEXT = "La encuesta permite que nos des tu opinión acerca de una parte específica del juego."
	FEEDBACKUI_WELCOMESURVEYDISABLED = "En este momento no existe ninguna encuesta disponible sobre este tema."
	
	FEEDBACKUI_MODIFIERKEY = "Atar:"
	FEEDBACKUI_MOUSE1 = "clic izquierdo"
	FEEDBACKUI_MOUSE2 = "clic derecha"
	
	FEEDBACKUI_LALT = "LAlt"
	FEEDBACKUI_RALT = "RAlt"
	FEEDBACKUI_LCTRL = "LCtrl"
	FEEDBACKUI_RCTRL = "RCtrl"
	FEEDBACKUI_LSHIFT = "LShift"
	FEEDBACKUI_RSHIFT = "RShift"
	
	FEEDBACKUI_TOOLTIP_MESSAGE = "<%s %s para opinar>";
	FEEDBACKUI_MAP_MESSAGE = "%s %s en el mapa para opinar";
	FEEDBACKUI_ITEMTARGETS = { "Armadura", "Consumible", "Contenedor", "Proyectil", "Carcaj", "Arma", "Receta", "Gema" };
	FEEDBACKUI_MISCTYPE = "Miscelánea";
	FEEDBACKUISHOWCUES_TEXT = "Mostrar consejos";
	
	FEEDBACKUI_CATEGORYLABEL = "Tipo:"
	FEEDBACKUI_STATUSLABEL = "Estado:"
	
	NEWBIE_TOOLTIP_BUG="Ayúdanos a mejorar " .. project_name .. " enviándonos informes de error o sugerencias, o bien, contestando a nuestras encuestas.\n\n" .. FEEDBACKUI_BLUE .. "Clic izquierdo para comenzar.\nClic derecho para mostrar las opciones.";
	FEEDBACKUILBLAPPEARANCE_TEXT = "Apariencia:"
	FEEDBACKUILBLUTILITY_TEXT = "Utilidad:"
	
	FEEDBACKUI_MOBSDIFFICULTYTABLEHEADER = "Dificultad"                   
	FEEDBACKUI_MOBSDIFFICULTYTABLESUBTEXT = "¿Cómo de difícil de matar es este enemigo?"
	FEEDBACKUI_MOBSREWARDTABLEHEADER = "Recompensa"
	FEEDBACKUI_MOBSREWARDTABLESUBTEXT = "¿Cómo valoras las recompensas del enemigo?"
	FEEDBACKUI_MOBSFUNTABLEHEADER = "Diversión"
	FEEDBACKUI_MOBSFUNTABLESUBTEXT = "¿Cómo de divertidos son los enfrentamientos con este enemigo?"
	FEEDBACKUI_MOBSAPPEARANCETABLEHEADER = "Apariencia"
	FEEDBACKUI_MOBSAPPEARANCETABLESUBTEXT = "¿Cómo valoras la apariencia de este enemigo?"
	
	FEEDBACKUI_ITEMSDIFFICULTYTABLEHEADER = "Dificultad"
	FEEDBACKUI_ITEMSDIFFICULTYTABLESUBTEXT = "¿Cómo de difícil es adquirir este objeto?"
	FEEDBACKUI_ITEMSUTILITYHEADER = "Utilidad"
	FEEDBACKUI_ITEMSUTILITYSUBTEXT = "¿Cómo de útil es este objeto?"
	FEEDBACKUI_ITEMSAPPEARANCETABLEHEADER = "Apariencia"
	FEEDBACKUI_ITEMSAPPEARANCETABLESUBTEXT = "¿Cómo valoras la apariencia de este objeto?"
	
	FEEDBACKUI_STRUTILITY1 = "Totalmente inútil"
	FEEDBACKUI_STRUTILITY2 = "Bastante inútil"
	FEEDBACKUI_STRUTILITY3 = "Útil"
	FEEDBACKUI_STRUTILITY4 = "Muy útil"
	
	FEEDBACKUI_UTILITY1 = "Totalmente inútil"
	FEEDBACKUI_UTILITY2 = "Bastante inútil"
	FEEDBACKUI_UTILITY3 = "Útil"
	FEEDBACKUI_UTILITY4 = "Muy útil"
	
	FEEDBACKUI_STRAPPEARANCE1 = "Inferior"
	FEEDBACKUI_STRAPPEARANCE2 = "Nada de otro mundo"
	FEEDBACKUI_STRAPPEARANCE3 = "Está bien"
	FEEDBACKUI_STRAPPEARANCE4 = "Impresionante"
	
	FEEDBACKUI_APPEARANCE1 = "Inferior"
	FEEDBACKUI_APPEARANCE2 = "Nada de otro mundo"
	FEEDBACKUI_APPEARANCE3 = "Está bien"
	FEEDBACKUI_APPEARANCE4 = "Impresionante"
	
	FEEDBACKUI_POIUNDERCITY = "Entrañas";
	FEEDBACKUI_POISILVERMOON = "Ciudad de Lunargenta";
	FEEDBACKUI_POIIRONFORGE = "Forjaz";
	FEEDBACKUI_POISTORMWIND = "Ciudad de Ventormenta";
	FEEDBACKUI_POISEPULCHER = "El Sepulcro";
	FEEDBACKUI_POITARRENMILL = "Molino Tarren";
	FEEDBACKUI_POISOUTHSHORE = "Costasur";
	FEEDBACKUI_POIAERIEPEAK = "Pico Nidal";
	FEEDBACKUI_POIREVANTUSK = "Poblado Sañadiente";
	FEEDBACKUI_POIHAMMERFALL = "Sentencia";
	FEEDBACKUI_POIMENETHIL = "Puerto de Menethil";
	FEEDBACKUI_POITHELSAMAR = "Thelsamar";
	FEEDBACKUI_POIKARGATH = "Kargath";
	FEEDBACKUI_POILAKESHIRE = "Villa del Lago";
	FEEDBACKUI_POISENTINELHILL = "Colina del Centinela";
	FEEDBACKUI_POIDARKSHIRE = "Villa Oscura";
	FEEDBACKUI_POISTONARD = "Rocal";
	FEEDBACKUI_POIGROMGOL = "Campamento Grom'gol";
	FEEDBACKUI_POIBOOTY = "Bahía del Botín";
	
	FEEDBACKUI_POIDARNASSUS = "Darnassus";
	FEEDBACKUI_POIEXODAR = "El Exodar";
	FEEDBACKUI_POIORGRIMMAR = "Orgrimmar";
	FEEDBACKUI_POITHUNDERB = "Cima del Trueno";
	FEEDBACKUI_POIAUBERDINE = "Auberdine";
	FEEDBACKUI_POIEVERLOOK = "Vista Eterna";
	FEEDBACKUI_POISTONETALON = "Cima del Espolón";
	FEEDBACKUI_POIASTRANAAR = "Astranaar";
	FEEDBACKUI_POISPLINTERTREE = "Puesto del Hachazo";
	FEEDBACKUI_POISUNROCK = "Refugio Roca del Sol";
	FEEDBACKUI_POINIJELS = "Punta de Nijel";
	FEEDBACKUI_POISHADOWPREY = "Aldea Cazasombras";
	FEEDBACKUI_POIFEATHERMOON = "Bastión Plumaluna";
	FEEDBACKUI_POIMOJACHE = "Campamento Mojache";
	FEEDBACKUI_POITHALANAAR = "Thalanaar";
	FEEDBACKUI_POICENARIONHOLD = "Fuerte Cenarion";
	FEEDBACKUI_POIGADGET = "Gadgetzan";
	FEEDBACKUI_POIFREEWIND = "Poblado Viento Libre";
	FEEDBACKUI_POITAURAJO = "Campamento Taurajo";
	FEEDBACKUI_POICROSSROADS = "El Cruce";
	FEEDBACKUI_POIRATCHET = "Trinquete";
	FEEDBACKUI_POITHERAMORE = "Isla Theramore";
	
	FEEDBACKUI_SURVEYTOOLTIPMOBHEADER = "Nombre del enemigo:"
	FEEDBACKUI_SURVEYTOOLTIPMOBZONEHEADER = "Encontrado en:"
	
	FEEDBACKUI_VOICECHAT = "Chat de voz";
	FEEDBACKUI_VOICECHATTOOLTIP = FEEDBACKUI_WHITE .. FEEDBACKUI_VOICECHAT;
	FEEDBACKUI_STRVOICECHAT = "Es una problema de la chat de voz.";
	FEEDBACKUI_HEADSETTYPE = "¿Qué tipo de audífonos estás usando?";
	
	FEEDBACKUI_USBHEADSET = "Auriculares USB"; --localize me
	FEEDBACKUI_ANALOGHEADSET = "Auriculares analógicos"; --localize me
	FEEDBACKUI_HARDWIREDMIC = "Micrófono incorporado"; --localize me
	
	FEEDBACKUI_STRUSBHEADSET = "Estoy usando audífonos USB.";
	FEEDBACKUI_STRANALOGHEADSET = "Estoy usando audífonos análogos.";
	FEEDBACKUI_STRHARDWIREDMIC = "Estoy usando un micrófono incorporado."; --localize me
	
	
else
	--English strings for FEEDBACKUI.
	--[[
	function enUS ()
	end
	]]--
	--Non-instance special zone names
	FEEDBACKUI_EXCEPTIONZONES = { "Deeprun Tram", "The Veiled Sea", "The Great Sea", "Alterac Valley", "Arathi Basin", "Warsong Gulch", "Champions' Hall", "Blackrock Mountain", "The Forbidding Sea", "Hall of Legends", "Twisting Nether", "Utgarde Keep", }
	
	--Headers    
	FEEDBACKUIINFOPANELLABEL_TEXT = "Your Information"
	FEEDBACKUI_BUGINPUTHEADER = "How can we reproduce this bug?"
	FEEDBACKUI_SUGGESTINPUTHEADER="Please describe your suggestion."
	
	--Labels
	FEEDBACKUIFEEDBACKFRMTITLE_TEXT = "Feedback Submission"
	FEEDBACKUILBLFRMVER_TEXT = "Version: "
	FEEDBACKUILBLFRMREALM_TEXT = "Realm: "
	FEEDBACKUILBLFRMNAME_TEXT = "Name: "
	FEEDBACKUILBLFRMCHAR_TEXT = "Character: "
	FEEDBACKUILBLFRMMAP_TEXT = "Map: "
	FEEDBACKUILBLFRMZONE_TEXT = "Zone: "
	FEEDBACKUILBLFRMAREA_TEXT = "Area: "
	FEEDBACKUILBLFRMADDONS_TEXT = "Addons: "
	FEEDBACKUILBLADDONSWRAP_TEXT = "Currently loaded addons:" .. "\n"
	FEEDBACKUITYPEBUG_TEXT = "Bug"
	FEEDBACKUITYPESUGGEST_TEXT = "Suggestion"
	FEEDBACKUITYPESURVEY_TEXT = "Surveys"
	FEEDBACKUILBLFRMWHO_TEXT = "Who: "
	FEEDBACKUILBLFRMWHERE_TEXT = "Where: "
	FEEDBACKUILBLFRMWHEN_TEXT = "When: "
	FEEDBACKUILBLFRMTYPE_TEXT = "Type: "
	FEEDBACKUI_GENDERTABLE = { "Unknown", "Male", "Female" }
	
	--Prompts
	FEEDBACKUISURVEYFRMINPUTBOX_TEXT = "<Type any other feedback you have here>"
	FEEDBACKUIBUGFRMINPUTBOX_TEXT = "<Type the steps to reproduce your bug here>"
	FEEDBACKUISUGGESTFRMINPUTBOX_TEXT = "<Type your suggestion here>"
	FEEDBACKUILBLADDONS_MOUSEOVER = "<Mouse-over for loaded addons>"
	FEEDBACKUI_CONFIRMATION = [[Your feedback has been submitted.
Thank you for helping us to improve the Edge of Chaos expansion!]]
	
	--Tooltips & Buttons
	BUG_BUTTON="Submit Feedback"
	FEEDBACKUIBACK_TEXT = "Back a Step"
	FEEDBACKUIRESET_TEXT = "Reset Form"
	FEEDBACKUISUBMIT_TEXT = "Submit"
	FEEDBACKUISTART_TEXT = "Start"
	
	--Tables and strings for navigation.
	FEEDBACKUI_WELCOMETABLEBUGHEADER = "Report a bug"
	FEEDBACKUI_WELCOMETABLEBUGSUBTEXT = "Bug submissions help fix game errors."
	FEEDBACKUI_WELCOMETABLESUGGESTHEADER = "Make a suggestion"
	FEEDBACKUI_WELCOMETABLESUGGESTSUBTEXT = "Suggestions help us improve game design."
	FEEDBACKUI_WELCOMETABLESUBTEXT = "Thanks for your feedback!"
	
	
	FEEDBACKUI_WELCOME = "\nThank you for offering feedback on Edge of Chaos. Each and every submission we receive plays an important role in determining the quality of the expansion.\n\nPlease fill out this short questionnaire so that we may efficiently process the huge amount of feedback we receive.\n\nThank You,\nThe " .. project_name .. " Expansion Team";
	-- FEEDBACKUI_SPECIFICBUG = "Report a bug that affects " .. NORMAL_FONT_COLOR_CODE .. "%s" .. HIGHLIGHT_FONT_COLOR_CODE .. "."
	-- FEEDBACKUI_SPECIFICSUGGESTION = "Make a suggestion regarding " .. NORMAL_FONT_COLOR_CODE .. "%s" .. HIGHLIGHT_FONT_COLOR_CODE .. "."
	-- FEEDBACKUI_SPECIFICSURVEY = "Take a survey about " .. NORMAL_FONT_COLOR_CODE .. "%s" .. HIGHLIGHT_FONT_COLOR_CODE .. "."
	
	FEEDBACKUI_WHOTABLEHEADER = FEEDBACKUI_WHITE .. "Who" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHOTABLESUBTEXT = "What does this issue affect?"
	
	FEEDBACKUI_STRWHOPLAYER = "This affects my character."
	FEEDBACKUI_STRPARTYMEMBER = "This affects players from my party."
	FEEDBACKUI_STRRAIDMEMBER = "This affects players from my raid."
	FEEDBACKUI_STRENEMYPLAYER = "This affects an enemy player."
	FEEDBACKUI_STRFRIENDLYPLAYER = "This affects a friendly player."
	FEEDBACKUI_STRENEMYCREATURE = "This affects an enemy creature."
	FEEDBACKUI_STRFRIENDLYCREATURE = "This affects a friendly creature."
	FEEDBACKUI_STRWHONA = "This does not involve players or creatures."
	
	FEEDBACKUI_WHOPLAYER = "My Character"
	FEEDBACKUI_ENEMYPLAYER = "Enemy Player"
	FEEDBACKUI_FRIENDLYPLAYER = "Friendly Player"
	FEEDBACKUI_PARTYMEMBER = "Party Member"
	FEEDBACKUI_RAIDMEMBER = "Raid Member"
	FEEDBACKUI_ENEMYCREATURE = "Enemy Creature"
	FEEDBACKUI_FRIENDLYCREATURE = "Friendly Creature"
	FEEDBACKUI_WHONA = "N/A"
	
	FEEDBACKUI_WHERETABLEHEADER = FEEDBACKUI_WHITE .. "Where" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHERETABLESUBTEXT = "Where does this issue occur?"
	
	FEEDBACKUI_STRAREATABLE = "This occurs in-game."
	FEEDBACKUI_STRWHEREINSTALL = "This occurs during installation."
	FEEDBACKUI_STRWHEREDOWNLOAD = "This occurs while downloading."
	FEEDBACKUI_STRWHEREPATCH = "This occurs while patching."
	
	FEEDBACKUI_WHEREINSTALL = "While Installing"
	FEEDBACKUI_WHEREDOWNLOAD = "While Downloading"
	FEEDBACKUI_WHEREPATCH = "While Patching"
	
	FEEDBACKUI_AREATABLESUMMARY = FEEDBACKUI_GREEN .. "Somewhere in-game"
	
	
	-------------------------- Begin Area Strings ------------------------------------------------------------------
	FEEDBACKUI_STROCCURS = "- This occurs in "; --localize me
	FEEDBACKUI_EVERYWHERE = "Everywhere in-game"
	FEEDBACKUI_STREVERYWHERE = "- This occurs everywhere in-game."
	
	--AZEROTH 
	FEEDBACKUI_AZEROTH = "Azeroth"
	
	--Northrend
	FEEDBACKUI_NORTHREND = "Northrend"
	FEEDBACKUI_BOREANTUNDRA = "Borean Tundra"
	FEEDBACKUI_CRYSTALSONG = "Crystalsong Forest" --localize me-
	FEEDBACKUI_DALARAN = "Dalaran" --localize me-
	FEEDBACKUI_DRAGONBLIGHT = "Dragonblight"
	FEEDBACKUI_GRIZZLYHILLS = "Grizzly Hills"
	FEEDBACKUI_HOWLINGFJORD = "Howling Fjord"
	FEEDBACKUI_ICECROWN = "Icecrown" --localize me-
	FEEDBACKUI_NEXUS = "The Nexus"
	FEEDBACKUI_SHOLAZARBASIN = "Sholazar Basin" ---localize me-
	FEEDBACKUI_STORMPEAKS = "The Storm Peaks" --localize me-
	FEEDBACKUI_UTGARDEPINNACLE = "Utgarde Pinnacle"
	FEEDBACKUI_WINTERGRASP = "Wintergrasp" --localize me-
	FEEDBACKUI_ZULDRAK = "Zul'Drak" --localize me-
	FEEDBACKUI_STRNORTHREND = FEEDBACKUI_STROCCURS .. FEEDBACKUI_NORTHREND
	--End Northrend-----------------------------------
	
	--Eastern Kingdoms
	FEEDBACKUI_EKINGDOMS = "Eastern Kingdoms"
	FEEDBACKUI_ALTERACMOUNTAINS = "Alterac Mountains";
	FEEDBACKUI_ALTERACVALLEY = "Alterac Valley";
	FEEDBACKUI_ARATHIBASIN = "Arathi Basin";
	FEEDBACKUI_ARATHIHIGHLANDS = "Arathi Highlands";
	FEEDBACKUI_BADLANDS = "Badlands";
	FEEDBACKUI_BLACKROCKMOUNTAIN = "Blackrock Mountain";
	FEEDBACKUI_BLASTEDLANDS = "Blasted Lands";
	FEEDBACKUI_BURNINGSTEPPES = "Burning Steppes";
	FEEDBACKUI_DEADWINDPASS = "Deadwind Pass";
	FEEDBACKUI_DUNMOROGH = "Dun Morogh";
	FEEDBACKUI_DUSKWOOD = "Duskwood";
	FEEDBACKUI_EPLAGUELANDS = "Eastern Plaguelands";
	FEEDBACKUI_ELWYNN = "Elwynn Forest";
	FEEDBACKUI_EVERSONG = "Eversong Woods";
	FEEDBACKUI_GHOSTLANDS = "Ghostlands";
	FEEDBACKUI_HILLSBRAD = "Hillsbrad Foothills";
	FEEDBACKUI_HINTERLANDS = "The Hinterlands";
	FEEDBACKUI_IRONFORGE = "Ironforge";
	FEEDBACKUI_ISLEOFQUELDANAS = "Isle of Quel'Danas"
	FEEDBACKUI_LOCHMODAN = "Loch Modan";
	FEEDBACKUI_REDRIDGE = "Redridge Mountains";
	FEEDBACKUI_SEARINGGORGE = "Searing Gorge";
	FEEDBACKUI_SILVERMOON = "Silvermoon City";
	FEEDBACKUI_SILVERPINE = "Silverpine Forest";
	FEEDBACKUI_STORMWIND = "Stormwind";
	FEEDBACKUI_STRANGLETHORN = "Stranglethorn Vale";
	FEEDBACKUI_SWAMPOFSORROWS = "Swamp of Sorrows";
	FEEDBACKUI_TIRISFAL = "Tirisfal Glades";
	FEEDBACKUI_UNDERCITY = "Undercity";
	FEEDBACKUI_WPLAGUELANDS = "Western Plaguelands";
	FEEDBACKUI_WESTFALL = "Westfall";
	FEEDBACKUI_WETLANDS = "Wetlands";
	FEEDBACKUI_STREKINGDOMS = FEEDBACKUI_STROCCURS .. FEEDBACKUI_EKINGDOMS;
	--End Eastern Kingdoms-------------------------------------------------------------------------------------------------------
	
	--Kalimdor
	FEEDBACKUI_KALIMDOR = "Kalimdor"
	FEEDBACKUI_ASHENVALE = "Ashenvale";
	FEEDBACKUI_AZSHARA = "Azshara";
	FEEDBACKUI_AZUREMYST = "Azuremyst Isle";
	FEEDBACKUI_BARRENS = "The Barrens";
	FEEDBACKUI_BLOODMYST = "Bloodmyst Isle";
	FEEDBACKUI_DARKSHORE = "Darkshore";
	FEEDBACKUI_DARNASSUS = "Darnassus";
	FEEDBACKUI_DESOLACE = "Desolace";
	FEEDBACKUI_DUROTAR = "Durotar";
	FEEDBACKUI_DUSTWALLOW = "Dustwallow Marsh";
	FEEDBACKUI_EXODAR = "The Exodar";
	FEEDBACKUI_FELWOOD = "Felwood";
	FEEDBACKUI_FERALAS = "Feralas";
	FEEDBACKUI_MOONGLADE = "Moonglade";
	FEEDBACKUI_MULGORE = "Mulgore";
	FEEDBACKUI_ORGRIMMAR = "Orgrimmar";
	FEEDBACKUI_SILITHUS = "Silithus";
	FEEDBACKUI_STONETALON = "Stonetalon Mountains";
	FEEDBACKUI_TANARIS = "Tanaris";
	FEEDBACKUI_TELDRASSIL = "Teldrassil";
	FEEDBACKUI_THUNDERBLUFF = "Thunder Bluff";
	FEEDBACKUI_THOUSANDNEEDLES = "Thousand Needles";
	FEEDBACKUI_UNGORO = "Un'Goro Crater";
	FEEDBACKUI_WARSONG = "Warsong Gulch";
	FEEDBACKUI_WINTERSPRING = "Winterspring";
	FEEDBACKUI_STRKALIMDOR = FEEDBACKUI_STROCCURS .. FEEDBACKUI_KALIMDOR;
	--End Kalimdor ----------------------------------------------------------------------------------------------------------------------
	
	--OUTLAND
	FEEDBACKUI_OUTLANDS = "Outland"
	FEEDBACKUI_BLADESEDGE = "Blade's Edge Mountains"
	FEEDBACKUI_HELLFIRE = "Hellfire Peninsula"
	FEEDBACKUI_NAGRAND = "Nagrand"
	FEEDBACKUI_NETHERSTORM = "Netherstorm"
	FEEDBACKUI_SHADOWMOON = "Shadowmoon Valley"
	FEEDBACKUI_SHATTRATH = "Shattrath City"
	FEEDBACKUI_TERROKAR = "Terokkar Forest"
	FEEDBACKUI_TWISTINGNETHER = "Twisting Nether"
	FEEDBACKUI_ZANGARMARSH = "Zangarmarsh"
	FEEDBACKUI_STROUTLANDS = FEEDBACKUI_STROCCURS .. FEEDBACKUI_OUTLANDS;
	--End Outlands--------------------------------------------
	
	--Alert Targets/Extra areas
	FEEDBACKUI_BLACKTEMPLE = "Black Temple";
	FEEDBACKUI_ZULAMAN = "Zul'Aman";
	FEEDBACKUI_SUNWELLPLATEAU = "Sunwell Plateau"
	FEEDBACKUI_MAGISTERSTERRACE = "Magisters' Terrace"
	FEEDBACKUI_UTGARDEKEEP = "Utgarde Keep"
	FEEDBACKUI_DRAKTHARONKEEP = "Drak'Tharon Keep"
	FEEDBACKUI_ULDUAR = "Ulduar"
	FEEDBACKUI_HOL = "Halls of Lightning"
	FEEDBACKUI_KAJA = "Kaja'mine"
	FEEDBACKUI_TAC = "The Argent Coliseum"
	FEEDBACKUI_IOC = "Isle of Conquest"
	--End Alert Targets/Extra areas
	--End Area Strings-------------------------------------------------------------------------------------------------------------------------------------
	
	FEEDBACKUI_WHENTABLEHEADER = FEEDBACKUI_WHITE .. "When" .. FEEDBACKUI_WHITE
	FEEDBACKUI_WHENTABLESUBTEXT = "How often does this occur?"
	
	FEEDBACKUI_STRREPRODUCABLE = "This occurs all the time."
	FEEDBACKUI_STRSOMETIMES = "This occurs occasionally."
	FEEDBACKUI_STRRARELY = "This occurs rarely."
	FEEDBACKUI_STRONETIME = "This only happened once."
	
	FEEDBACKUI_REPRODUCABLE = "Always"
	FEEDBACKUI_SOMETIMES = "Occasionally"
	FEEDBACKUI_RARELY = "Rarely"
	FEEDBACKUI_ONETIME = "Once"
	
	FEEDBACKUI_TYPETABLEHEADER = FEEDBACKUI_WHITE .. "Type" .. FEEDBACKUI_WHITE
	FEEDBACKUI_TYPETABLESUBTEXT = "What type of issue is this?"
	
	FEEDBACKUI_STRUIOTHER = "This is a user-interface issue."
	FEEDBACKUI_STRUIITEMS = "- This is an item UI issue."
	FEEDBACKUI_STRUISPAWNS = "- This is a creature UI issue."
	FEEDBACKUI_STRUIQUESTS = "- This is a quest UI issue."
	FEEDBACKUI_STRUISPELLS = "- This is a spell or talent UI issue."
	FEEDBACKUI_STRUITRADESKILLS = "- This is a tradeskill UI issue."
	
	FEEDBACKUI_STRGRAPHICOTHER = "This is a graphical issue."
	FEEDBACKUI_STRGRAPHICITEMS = "- This is an item graphics issue."
	FEEDBACKUI_STRGRAPHICSPAWNS = "- This is a creature graphics issue."
	FEEDBACKUI_STRGRAPHICSPELLS = "- This is a spell or talent graphics issue."
	FEEDBACKUI_STRGRAPHICENVIRONMENT = "- This issue affects environmental graphics."
	
	FEEDBACKUI_STRFUNCOTHER = "This issue affects game functionality."
	FEEDBACKUI_STRFUNCITEMS = "- This affects item functionality."
	FEEDBACKUI_STRFUNCSPAWNS = "- This affects creature functionality."
	FEEDBACKUI_STRFUNCQUESTS = "- This affects quest functionality."
	FEEDBACKUI_STRFUNCSPELLS = "- This affects spell or talent functionality."
	FEEDBACKUI_STRFUNCTRADESKILLS = "- This affects tradeskill functionality."
	
	FEEDBACKUI_STRCRASHOTHER = "This is a stability issue."
	FEEDBACKUI_STRCRASHBUG = "- This causes WoW to crash."
	FEEDBACKUI_STRCRASHSOFTLOCK = "- This causes WoW to stop responding."
	FEEDBACKUI_STRCRASHHARDLOCK = "- This causes my computer to stop responding."
	FEEDBACKUI_STRCRASHWOWLAG = "- This issue is lag-related."
	
	FEEDBACKUI_UIITEMS = "Item UI Issue"
	FEEDBACKUI_UISPAWNS = "Creature UI Issue"
	FEEDBACKUI_UIQUESTS = "Quest UI Issue"
	FEEDBACKUI_UISPELLS = "Spell or Talent UI Issue"
	FEEDBACKUI_UITRADESKILLS = "Tradeskill UI Issue"
	FEEDBACKUI_UIOTHER = "General UI Issue"
	
	FEEDBACKUI_GRAPHICITEMS = "Item Graphics Issue"
	FEEDBACKUI_GRAPHICSPAWNS = "Creature Graphics Issue"
	FEEDBACKUI_GRAPHICSPELLS = "Spell or Talent Graphics Issue"
	FEEDBACKUI_GRAPHICENVIRONMENT = "Environmental Graphics Issue"
	FEEDBACKUI_GRAPHICOTHER = "General Graphics Issue"
	
	FEEDBACKUI_FUNCITEMS = "Item Functionality Issue"
	FEEDBACKUI_FUNCSPAWNS = "Creature Functionality Issue"
	FEEDBACKUI_FUNCQUESTS = "Quest Functionality Issue"
	FEEDBACKUI_FUNCSPELLS = "Spell or Talent Functionality Issue"    
	FEEDBACKUI_FUNCTRADESKILLS = "Tradeskill Functionality Issue"
	FEEDBACKUI_FUNCOTHER = "General Functionality Issue"
	
	FEEDBACKUI_CRASHBUG = "Issue Crashes WoW"
	FEEDBACKUI_CRASHSOFTLOCK = "Issue Causes WoW to Freeze"
	FEEDBACKUI_CRASHHARDLOCK = "Issue Causes Computer to Freeze"
	FEEDBACKUI_CRASHWOWLAG = "Issue Causes WoW to Lag"
	FEEDBACKUI_CRASHOTHER = "General Stability Issue"
	
	FEEDBACKUILBLFRMCLARITY_TEXT = "Clarity:"
	FEEDBACKUILBLFRMDIFFICULTY_TEXT = "Difficulty:"
	FEEDBACKUILBLFRMREWARD_TEXT = "Reward:"
	FEEDBACKUILBLFRMFUN_TEXT = "Fun:"
	FEEDBACKUILBLPOWER_TEXT = "Power:"
	FEEDBACKUILBLFREQUENCY_TEXT = "Frequency:"
	FEEDBACKUILBLAPPROPRIATE_TEXT = "Appropriate:"
	FEEDBACKUISURVEYTYPE_QUEST = "Quest"
	FEEDBACKUISURVEYTYPE_AREA = "Area"
	FEEDBACKUISURVEYTYPE_ITEM = "Item"
	FEEDBACKUISURVEYTYPE_MOB = "Mob"
	
	FEEDBACKUISKIP_TEXT = "Skip Survey"
	FEEDBACKUILBLSURVEYALERTSCHECK_TEXT = "Show Alerts"
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "Please choose a survey."
	FEEDBACKUI_WELCOMETABLESURVEYSUBTEXT = "Surveys are added as you experience new content."
	
	FEEDBACKUI_SURVEYCOLUMNNAME = "Name"
	FEEDBACKUI_SURVEYCOLUMNMODIFIED = "Experienced"
	
	FEEDBACKUI_ALLHEADERTEXT = "All"
	FEEDBACKUI_AREAHEADERTEXT = "Areas"
	FEEDBACKUI_QUESTHEADERTEXT = "Quests"
	FEEDBACKUI_ITEMHEADERTEXT = "Items"
	FEEDBACKUI_MOBHEADERTEXT = "Mobs"
	FEEDBACKUI_SPELLHEADERTEXT = "Spells"
	
	FEEDBACKUI_STATUSALLTEXT = "All"
	FEEDBACKUI_STATUSAVAILABLETEXT = "Available"
	FEEDBACKUI_STATUSSKIPPEDTEXT = "Skipped"
	FEEDBACKUI_STATUSCOMPLETEDTEXT = "Completed"
	
	FEEDBACKUI_SURVEYTOOLTIPQUESTHEADER = "Quest name:"
	FEEDBACKUI_SURVEYTOOLTIPAREAHEADER = "Area name:"
	FEEDBACKUI_SURVEYTOOLTIPEXPERIENCEDHEADER = "Experienced:"
	FEEDBACKUI_SURVEYTOOLTIPQUESTOBJECTIVESHEADER = "Quest objectives:"
	
	FEEDBACKUI_NEW = "New"
	FEEDBACKUI_HOURAGO = " hour ago"
	FEEDBACKUI_HOURSAGO = " hours ago"
	FEEDBACKUI_DAYAGO = " day ago"
	FEEDBACKUI_DAYSAGO = " days ago"
	FEEDBACKUI_MONTHAGO = " month ago"
	FEEDBACKUI_MONTHSAGO = " months ago"
	FEEDBACKUI_YEARAGO = " year ago"
	FEEDBACKUI_YEARSAGO = " years ago"
	
	FEEDBACKUI_QUESTSCLARITYTABLEHEADER = "Clarity"
	FEEDBACKUI_QUESTSCLARITYTABLESUBTEXT = "How clear were the Quest's objectives?"
	
	FEEDBACKUI_STRCLARITY1 = "Extremely vague"
	FEEDBACKUI_STRCLARITY2 = "Somewhat vague"
	FEEDBACKUI_STRCLARITY3 = "Fairly clear"
	FEEDBACKUI_STRCLARITY4 = "Perfectly clear"
	
	FEEDBACKUI_CLARITY1 = "Extremely vague"
	FEEDBACKUI_CLARITY2 = "Somewhat vague"
	FEEDBACKUI_CLARITY3 = "Fairly clear"
	FEEDBACKUI_CLARITY4 = "Perfectly clear"
	
	FEEDBACKUI_QUESTSDIFFICULTYTABLEHEADER = "Difficulty"
	FEEDBACKUI_QUESTSDIFFICULTYTABLESUBTEXT = "How difficult was the Quest?"
	FEEDBACKUI_AREASDIFFICULTYTABLEHEADER = "Difficulty"
	FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT = "How difficult were the Area's encounters?"
	
	FEEDBACKUI_STRDIFFICULTY1 = "Easy"
	FEEDBACKUI_STRDIFFICULTY2 = "Manageable"
	FEEDBACKUI_STRDIFFICULTY3 = "Challenging"
	FEEDBACKUI_STRDIFFICULTY4 = "Hard"
	FEEDBACKUI_STRDIFFICULTY5 = "N/A"
	
	FEEDBACKUI_DIFFICULTY1 = "Easy"
	FEEDBACKUI_DIFFICULTY2 = "Manageable"
	FEEDBACKUI_DIFFICULTY3 = "Challenging"
	FEEDBACKUI_DIFFICULTY4 = "Hard"
	FEEDBACKUI_DIFFICULTY5 = "N/A"
	
	FEEDBACKUI_QUESTSREWARDTABLEHEADER = "Reward"
	FEEDBACKUI_QUESTSREWARDTABLESUBTEXT = "How would you rate the Quest's reward?"
	FEEDBACKUI_AREASREWARDTABLEHEADER = "Reward"
	FEEDBACKUI_AREASREWARDTABLESUBTEXT = "How would you rate the Area's rewards?"
	
	FEEDBACKUI_STRREWARD1 = "Awful"
	FEEDBACKUI_STRREWARD2 = "Bad"
	FEEDBACKUI_STRREWARD3 = "Good"
	FEEDBACKUI_STRREWARD4 = "Awesome"
	FEEDBACKUI_STRREWARD5 = "N/A"
	
	FEEDBACKUI_REWARD1 = "Awful"
	FEEDBACKUI_REWARD2 = "Bad"
	FEEDBACKUI_REWARD3 = "Good"
	FEEDBACKUI_REWARD4 = "Awesome"
	FEEDBACKUI_REWARD5 = "N/A"
	
	FEEDBACKUI_QUESTSFUNTABLEHEADER = "Fun"
	FEEDBACKUI_QUESTSFUNTABLESUBTEXT = "How fun was the Quest?"
	FEEDBACKUI_AREASFUNTABLEHEADER = "Fun"
	FEEDBACKUI_AREASFUNTABLESUBTEXT = "How fun was the Area?"
	
	FEEDBACKUI_STRFUN1 = "Not fun at all"
	FEEDBACKUI_STRFUN2 = "Not very fun"
	FEEDBACKUI_STRFUN3 = "Pretty fun"
	FEEDBACKUI_STRFUN4 = "A lot of fun"
	
	FEEDBACKUI_FUN1 = "Not fun at all"
	FEEDBACKUI_FUN2 = "Not very fun"
	FEEDBACKUI_FUN3 = "Pretty fun"
	FEEDBACKUI_FUN4 = "A lot of fun"
	
	FEEDBACKUISURVEYFRMINPUTBOX_TEXT = "<Type any other feedback you have here>"
	FEEDBACKUI_SURVEYINPUTHEADER = "Please add any additional feedback"
	FEEDBACKUI_SURVEYINPUTSUBTEXT = "Click here to see some feedback examples"
	FEEDBACKUIRESUBMIT_TEXT = "Resubmit"
	
	FEEDBACKUI_SURVEYNEWBIETEXT = "Click here to complete a survey about this experience."
	
	FEEDBACKUI_WELCOMETABLESURVEYHEADER = "Please select a survey"
	
	FEEDBACKUI_SPECIFICWELCOME = "Thank you for offering feedback on " .. project_name .. ". You've chosen to give feedback on:\n\n\n\n\nPlease choose one of the following feedback options to continue:";
	FEEDBACKUI_GENERALWELCOME = "Thank you for offering feedback on " .. project_name .. ". Each and every submission we receive plays an important role in determining the quality of " .. project_name .. ".\n\nPlease choose one of the following feedback options to continue:";
	
	FEEDBACKUI_STARTBUG = "Report Bug"
	FEEDBACKUI_STARTSURVEY = "Start Survey"
	FEEDBACKUI_STARTSUGGESTION = "Make Suggestion"
	
	FEEDBACKUI_WELCOMEBUGHEADER = "Bug"
	FEEDBACKUI_WELCOMESUGGESTHEADER = "Suggestion"
	FEEDBACKUI_WELCOMESURVEYHEADER = "Survey"
	
	FEEDBACKUI_WELCOMEBUGTEXT = "A bug tells us about an error you have found in the game." 
	FEEDBACKUI_WELCOMESUGGESTTEXT = "A suggestion tells us how you would like to see the game improved."
	FEEDBACKUI_WELCOMESURVEYTEXT = "A survey allows you to give us feedback about a specific part of the game."
	FEEDBACKUI_WELCOMESURVEYDISABLED = "There are no surveys available for this object at this time."
	
	FEEDBACKUI_MODIFIERKEY = "Binding:"
	FEEDBACKUI_MOUSE1 = "Left Click"
	FEEDBACKUI_MOUSE2 = "Right Click"
	
	FEEDBACKUI_LALT = "LAlt"
	FEEDBACKUI_RALT = "RAlt"
	FEEDBACKUI_LCTRL = "LCtrl"
	FEEDBACKUI_RCTRL = "RCtrl"
	FEEDBACKUI_LSHIFT = "LShift"
	FEEDBACKUI_RSHIFT = "RShift"
	
	FEEDBACKUI_TOOLTIP_MESSAGE = "<%s+%s for Feedback>";
	FEEDBACKUI_MAP_MESSAGE = "%s+%s On Map For Feedback";
	FEEDBACKUI_ITEMTARGETS = { "Armor", "Consumable", "Container", "Projectile", "Quiver", "Weapon", "Recipe", "Gem" };
	FEEDBACKUI_MISCTYPE = "Miscellaneous";
	FEEDBACKUISHOWCUES_TEXT = "Show Tooltip Cues";
	
	FEEDBACKUI_CATEGORYLABEL = "Type:"
	FEEDBACKUI_STATUSLABEL = "Status:"
	FEEDBACKUI_MODIFIERKEY = "Binding:"
	
	NEWBIE_TOOLTIP_BUG="Help improve " .. project_name .. " by submitting a bug or suggestion, or by taking a survey.\n\n" .. FEEDBACKUI_BLUE .. "Left Click to start\nRight Click for display options\nRight Click and drag to move";
	FEEDBACKUILBLAPPEARANCE_TEXT = "Appearance:"
	FEEDBACKUILBLUTILITY_TEXT = "Usefulness:"
	
	
	FEEDBACKUI_MOBSDIFFICULTYTABLEHEADER = "Difficulty"                   
	FEEDBACKUI_MOBSDIFFICULTYTABLESUBTEXT = "How difficult is this mob to defeat?"
	FEEDBACKUI_MOBSREWARDTABLEHEADER = "Reward"
	FEEDBACKUI_MOBSREWARDTABLESUBTEXT = "How would you rate the Mob's rewards?"
	FEEDBACKUI_MOBSFUNTABLEHEADER = "Fun"
	FEEDBACKUI_MOBSFUNTABLESUBTEXT = "How fun are encounters with this Mob?"
	FEEDBACKUI_MOBSAPPEARANCETABLEHEADER = "Appearance"
	FEEDBACKUI_MOBSAPPEARANCETABLESUBTEXT = "How would you rate this Mob's appearance?"
	
	FEEDBACKUI_ITEMSDIFFICULTYTABLEHEADER = "Difficulty"
	FEEDBACKUI_ITEMSDIFFICULTYTABLESUBTEXT = "How difficult is this Item to acquire?"
	FEEDBACKUI_ITEMSUTILITYHEADER = "Utility"
	FEEDBACKUI_ITEMSUTILITYSUBTEXT = "How useful is this Item in general?"
	FEEDBACKUI_ITEMSAPPEARANCETABLEHEADER = "Appearance"
	FEEDBACKUI_ITEMSAPPEARANCETABLESUBTEXT = "How would you rate the art for this Item?"
	
	FEEDBACKUI_SPELLSPOWERTABLEHEADER = "Power"
	FEEDBACKUI_SPELLSPOWERTABLESUBTEXT = "How powerful is this ability?"
	FEEDBACKUI_SPELLSFREQUENCYTABLEHEADER = "Frequency"
	FEEDBACKUI_SPELLSFREQUENCYTABLESUBTEXT = "How often are you likely to use this ability?"
	FEEDBACKUI_SPELLSAPPROPRIATETABLEHEADER = "Appropriateness"
	FEEDBACKUI_SPELLSAPPROPRIATETABLESUBTEXT = "How well does this fit with similar abilities?"
	FEEDBACKUI_SPELLSFUNTABLEHEADER = "Fun"
	FEEDBACKUI_SPELLSFUNTABLESUBTEXT = "How fun is this ability to use?"
	
	FEEDBACKUI_STRUTILITY1 = "Quite Useless"
	FEEDBACKUI_STRUTILITY2 = "Somewhat Useless"
	FEEDBACKUI_STRUTILITY3 = "Useful"
	FEEDBACKUI_STRUTILITY4 = "Quite Useful"
	
	FEEDBACKUI_UTILITY1 = "Quite Useless"
	FEEDBACKUI_UTILITY2 = "Somewhat Useless"
	FEEDBACKUI_UTILITY3 = "Useful"
	FEEDBACKUI_UTILITY4 = "Quite Useful"
	
	FEEDBACKUI_STRAPPEARANCE1 = "Ugly"
	FEEDBACKUI_STRAPPEARANCE2 = "Below Average"
	FEEDBACKUI_STRAPPEARANCE3 = "Above Average"
	FEEDBACKUI_STRAPPEARANCE4 = "Beautiful"
	
	FEEDBACKUI_APPEARANCE1 = "Ugly"
	FEEDBACKUI_APPEARANCE2 = "Below Average"
	FEEDBACKUI_APPEARANCE3 = "Above Average"
	FEEDBACKUI_APPEARANCE4 = "Beautiful"
	
	FEEDBACKUI_STRPOWER1 = "Very Weak";
	FEEDBACKUI_STRPOWER2 = "Weak";
	FEEDBACKUI_STRPOWER3 = "Powerful";
	FEEDBACKUI_STRPOWER4 = "Very Powerful";
	
	FEEDBACKUI_STRFREQUENCY1 = "Rarely";
	FEEDBACKUI_STRFREQUENCY2 = "Occasionally";
	FEEDBACKUI_STRFREQUENCY3 = "Frequently";
	FEEDBACKUI_STRFREQUENCY4 = "Whenever Possible";
	
	FEEDBACKUI_STRAPPROPRIATE1 = "Very Inappropriate";
	FEEDBACKUI_STRAPPROPRIATE2 = "Somewhat Inappropriate";
	FEEDBACKUI_STRAPPROPRIATE3 = "Good Fit";
	FEEDBACKUI_STRAPPROPRIATE4 = "Perfect Fit";
	
	FEEDBACKUI_POIUNDERCITY = "Undercity";
	FEEDBACKUI_POISILVERMOON = "Silvermoon City";
	FEEDBACKUI_POIIRONFORGE = "Ironforge";
	FEEDBACKUI_POISTORMWIND = "Stormwind City";
	FEEDBACKUI_POISEPULCHER = "The Sepulcher";
	FEEDBACKUI_POITARRENMILL = "Tarren Mill";
	FEEDBACKUI_POISOUTHSHORE = "Southshore";
	FEEDBACKUI_POIAERIEPEAK = "Aerie Peak";
	FEEDBACKUI_POIREVANTUSK = "Revantusk Village";
	FEEDBACKUI_POIHAMMERFALL = "Hammerfall";
	FEEDBACKUI_POIMENETHIL = "Menethil Harbor";
	FEEDBACKUI_POITHELSAMAR = "Thelsamar";
	FEEDBACKUI_POIKARGATH = "Kargath";
	FEEDBACKUI_POILAKESHIRE = "Lakeshire";
	FEEDBACKUI_POISENTINELHILL = "Sentinel Hill";
	FEEDBACKUI_POIDARKSHIRE = "Darkshire";
	FEEDBACKUI_POISTONARD = "Stonard";
	FEEDBACKUI_POIGROMGOL = "Grom'gol Base Camp";
	FEEDBACKUI_POIBOOTY = "Booty Bay"
	
	FEEDBACKUI_POIDARNASSUS = "Darnassus";
	FEEDBACKUI_POIEXODAR = "The Exodar";
	FEEDBACKUI_POIORGRIMMAR = "Orgrimmar";
	FEEDBACKUI_POITHUNDERB = "Thunder Bluff";
	FEEDBACKUI_POIAUBERDINE = "Auberdine";
	FEEDBACKUI_POIEVERLOOK = "Everlook";
	FEEDBACKUI_POISTONETALON = "Stonetalon Peak";
	FEEDBACKUI_POIASTRANAAR = "Astranaar";
	FEEDBACKUI_POISPLINTERTREE = "Splintertree Post";
	FEEDBACKUI_POISUNROCK = "Sun Rock Retreat";
	FEEDBACKUI_POINIJELS = "Nijel's Point";
	FEEDBACKUI_POISHADOWPREY = "Shadowprey Village";
	FEEDBACKUI_POIFEATHERMOON = "Feathermoon Stronghold";
	FEEDBACKUI_POIMOJACHE = "Camp Mojache";
	FEEDBACKUI_POITHALANAAR = "Thalanaar";
	FEEDBACKUI_POICENARIONHOLD = "Cenarion Hold";
	FEEDBACKUI_POIGADGET = "Gadgetzan";
	FEEDBACKUI_POIFREEWIND = "Freewind Post";
	FEEDBACKUI_POITAURAJO = "Camp Taurajo";
	FEEDBACKUI_POICROSSROADS = "The Crossroads";
	FEEDBACKUI_POIRATCHET = "Ratchet";
	FEEDBACKUI_POITHERAMORE = "Theramore Isle";
	
	FEEDBACKUI_POIMASK = ".-%s%-%s(.+)"
	
	FEEDBACKUI_LEVELPREFIX = "Lvl" 
	FEEDBACKUI_SURVEYTOOLTIPMOBHEADER = "Mob Name:"
	FEEDBACKUI_SURVEYTOOLTIPMOBZONEHEADER = "Found in:"
	
	FEEDBACKUI_VOICECHAT = "Voice Chat";
	FEEDBACKUI_VOICECHATTOOLTIP = FEEDBACKUI_WHITE .. FEEDBACKUI_VOICECHAT;
	FEEDBACKUI_STRVOICECHAT = "This is a voice chat issue.";
	FEEDBACKUI_HEADSETTYPE = "What type of headset are you using?";
	
	FEEDBACKUI_USBHEADSET = "USB Headset"; --localize me
	FEEDBACKUI_ANALOGHEADSET = "Analog Headset"; --localize me
	FEEDBACKUI_HARDWIREDMIC = "Hardwired Microphone"; --localize me
	
	
	FEEDBACKUI_STRUSBHEADSET = "I am using a USB headset.";
	FEEDBACKUI_STRANALOGHEADSET = "I am using an analog headset.";
	FEEDBACKUI_STRHARDWIREDMIC = "I am using a hardwired microphone."; --localize me
	
end

--TABLES
--[[
function DataTables() end
]]--

--Generate Zone - Subzone strings:

--Northrend
FEEDBACKUI_STRBOREANTUNDRA = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_BOREANTUNDRA
FEEDBACKUI_STRCRYSTALSONG = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_CRYSTALSONG
FEEDBACKUI_STRDALARAN = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_DALARAN 
FEEDBACKUI_STRDRAGONBLIGHT = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_DRAGONBLIGHT
FEEDBACKUI_STRGRIZZLYHILLS = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_GRIZZLYHILLS
FEEDBACKUI_STRHOWLINGFJORD = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_HOWLINGFJORD
FEEDBACKUI_STRICECROWN = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_ICECROWN 
FEEDBACKUI_STRNEXUS = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_NEXUS
FEEDBACKUI_STRSHOLAZARBASIN = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_SHOLAZARBASIN 
FEEDBACKUI_STRSTORMPEAKS = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_STORMPEAKS 
FEEDBACKUI_STRUTGARDEPINNACLE = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_UTGARDEPINNACLE 
FEEDBACKUI_STRWINTERGRASP = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_WINTERGRASP 
FEEDBACKUI_STRZULDRAK = FEEDBACKUI_NORTHREND .. " - " .. FEEDBACKUI_ZULDRAK

--Eastern Kingdoms
FEEDBACKUI_STRALTERACMOUNTAINS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_ALTERACMOUNTAINS 
FEEDBACKUI_STRALTERACVALLEY = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_ALTERACVALLEY 
FEEDBACKUI_STRARATHIBASIN = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_ARATHIBASIN 
FEEDBACKUI_STRARATHIHIGHLANDS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_ARATHIHIGHLANDS 
FEEDBACKUI_STRBADLANDS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_BADLANDS 
FEEDBACKUI_STRBLACKROCKMOUNTAIN = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_BLACKROCKMOUNTAIN 
FEEDBACKUI_STRBLASTEDLANDS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_BLASTEDLANDS 
FEEDBACKUI_STRBURNINGSTEPPES = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_BURNINGSTEPPES 
FEEDBACKUI_STRDEADWINDPASS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_DEADWINDPASS 
FEEDBACKUI_STRDUNMOROGH = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_DUNMOROGH 
FEEDBACKUI_STRDUSKWOOD = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_DUSKWOOD 
FEEDBACKUI_STREPLAGUELANDS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_EPLAGUELANDS 
FEEDBACKUI_STRELWYNN = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_ELWYNN 
FEEDBACKUI_STREVERSONG = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_EVERSONG 
FEEDBACKUI_STRGHOSTLANDS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_GHOSTLANDS 
FEEDBACKUI_STRHILLSBRAD = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_HILLSBRAD 
FEEDBACKUI_STRHINTERLANDS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_HINTERLANDS 
FEEDBACKUI_STRIRONFORGE = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_IRONFORGE 
FEEDBACKUI_STRISLEOFQUELDANAS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_ISLEOFQUELDANAS 
FEEDBACKUI_STRLOCHMODAN = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_LOCHMODAN 
FEEDBACKUI_STRREDRIDGE = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_REDRIDGE 
FEEDBACKUI_STRSEARINGGORGE = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_SEARINGGORGE 
FEEDBACKUI_STRSILVERMOON = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_SILVERMOON 
FEEDBACKUI_STRSILVERPINE = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_SILVERPINE 
FEEDBACKUI_STRSTORMWIND = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_STORMWIND 
FEEDBACKUI_STRSTRANGLETHORN = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_STRANGLETHORN 
FEEDBACKUI_STRSWAMPOFSORROWS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_SWAMPOFSORROWS 
FEEDBACKUI_STRTIRISFAL = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_TIRISFAL 
FEEDBACKUI_STRUNDERCITY = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_UNDERCITY 
FEEDBACKUI_STRWPLAGUELANDS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_WPLAGUELANDS 
FEEDBACKUI_STRWESTFALL = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_WESTFALL 
FEEDBACKUI_STRWETLANDS = FEEDBACKUI_EKINGDOMS .. " - " .. FEEDBACKUI_WETLANDS 

--Kalimdor
FEEDBACKUI_STRASHENVALE = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_ASHENVALE;
FEEDBACKUI_STRAZSHARA = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_AZSHARA ;
FEEDBACKUI_STRAZUREMYST = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_AZUREMYST ;
FEEDBACKUI_STRBARRENS = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_BARRENS ;
FEEDBACKUI_STRBLOODMYST = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_BLOODMYST ;
FEEDBACKUI_STRDARKSHORE = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_DARKSHORE ;
FEEDBACKUI_STRDARNASSUS = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_DARNASSUS ;
FEEDBACKUI_STRDESOLACE = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_DESOLACE ;
FEEDBACKUI_STRDUROTAR = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_DUROTAR ;
FEEDBACKUI_STRDUSTWALLOW = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_DUSTWALLOW ;
FEEDBACKUI_STREXODAR = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_EXODAR ;
FEEDBACKUI_STRFELWOOD = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_FELWOOD ;
FEEDBACKUI_STRFERALAS = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_FERALAS ;
FEEDBACKUI_STRMOONGLADE = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_MOONGLADE ;
FEEDBACKUI_STRMULGORE = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_MULGORE ;
FEEDBACKUI_STRORGRIMMAR = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_ORGRIMMAR ;
FEEDBACKUI_STRSILITHUS = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_SILITHUS ;
FEEDBACKUI_STRSTONETALON = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_STONETALON ;
FEEDBACKUI_STRTANARIS = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_TANARIS ;
FEEDBACKUI_STRTELDRASSIL = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_TELDRASSIL ;
FEEDBACKUI_STRTHUNDERBLUFF = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_THUNDERBLUFF ;
FEEDBACKUI_STRTHOUSANDNEEDLES = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_THOUSANDNEEDLES ;
FEEDBACKUI_STRUNGORO = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_UNGORO ;
FEEDBACKUI_STRWARSONG = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_WARSONG ;
FEEDBACKUI_STRWINTERSPRING = FEEDBACKUI_KALIMDOR .. " - " .. FEEDBACKUI_WINTERSPRING ;

--Outland
FEEDBACKUI_STRBLADESEDGE = FEEDBACKUI_OUTLANDS .. " - " .. FEEDBACKUI_BLADESEDGE;
FEEDBACKUI_STRHELLFIRE = FEEDBACKUI_OUTLANDS .. " - " .. FEEDBACKUI_HELLFIRE;
FEEDBACKUI_STRNAGRAND = FEEDBACKUI_OUTLANDS .. " - " .. FEEDBACKUI_NAGRAND;
FEEDBACKUI_STRNETHERSTORM = FEEDBACKUI_OUTLANDS .. " - " .. FEEDBACKUI_NETHERSTORM;
FEEDBACKUI_STRSHADOWMOON = FEEDBACKUI_OUTLANDS .. " - " .. FEEDBACKUI_SHADOWMOON;
FEEDBACKUI_STRSHATTRATH = FEEDBACKUI_OUTLANDS .. " - " .. FEEDBACKUI_SHATTRATH;
FEEDBACKUI_STRTERROKAR = FEEDBACKUI_OUTLANDS .. " - " .. FEEDBACKUI_TERROKAR;
FEEDBACKUI_STRTWISTINGNETHER = FEEDBACKUI_OUTLANDS .. " - " .. FEEDBACKUI_TWISTINGNETHER;
FEEDBACKUI_STRZANGARMARSH = FEEDBACKUI_OUTLANDS .. " - " .. FEEDBACKUI_ZANGARMARSH;


FEEDBACKUI_VOICECHATTYPETABLE = { [1] = { ["index"] = FEEDBACKUI_STRUSBHEADSET, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_VOICECHAT", ["value"] = 23 }, ["link"] = "FEEDBACKUI_WHENTABLE" }, 
[2] = { ["index"] = FEEDBACKUI_STRANALOGHEADSET, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_VOICECHAT", ["value"] = 24 }, ["link"] = "FEEDBACKUI_WHENTABLE" }, 
["header"] = "",
["subtext"] = FEEDBACKUI_HEADSETTYPE }

if ( not FEEDBACKUI_AREATABLE ) then
	
	--[[ Area Values 
	Outlands = 2 - 11
	Eastern Kingdoms = 12 - 43
	Kalimdor = 44 - 69
	70 - While Installing
	71 - While Downloading
	72 - While Patching
	Isle of Quel'Danas = 73 (Eastern Kingdoms)
	Northrend = 74 - 87
	]]
	
	FEEDBACKUI_AREATABLE = {[1] = { ["index"] = FEEDBACKUI_STREVERYWHERE, ["summary"] = { ["type"] = "where", ["value"] = 1, ["text"] = "FEEDBACKUI_EVERYWHERE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[2] = { ["index"] = FEEDBACKUI_STRNORTHREND, ["summary"] = { ["type"] = "where", ["value"] = 74, ["text"] = "FEEDBACKUI_NORTHREND" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[3] = { ["index"] = FEEDBACKUI_STRBOREANTUNDRA, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 75, ["text"] = "FEEDBACKUI_STRBOREANTUNDRA" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[4] = { ["index"] = FEEDBACKUI_STRCRYSTALSONG, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 81, ["text"] = "FEEDBACKUI_STRCRYSTALSONG" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[5] = { ["index"] = FEEDBACKUI_STRDALARAN, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 82, ["text"] = "FEEDBACKUI_STRDALARAN" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[6] = { ["index"] = FEEDBACKUI_STRDRAGONBLIGHT, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 76, ["text"] = "FEEDBACKUI_STRDRAGONBLIGHT" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[7] = { ["index"] = FEEDBACKUI_STRGRIZZLYHILLS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 77, ["text"] = "FEEDBACKUI_STRGRIZZLYHILLS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[8] = { ["index"] = FEEDBACKUI_STRHOWLINGFJORD, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 78, ["text"] = "FEEDBACKUI_STRHOWLINGFJORD" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[9] = { ["index"] = FEEDBACKUI_STRICECROWN, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 83, ["text"] = "FEEDBACKUI_STRICECROWN" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[10] = { ["index"] = FEEDBACKUI_STRNEXUS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 79, ["text"] = "FEEDBACKUI_STRNEXUS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[11] = { ["index"] = FEEDBACKUI_STRSHOLAZARBASIN, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 84, ["text"] = "FEEDBACKUI_STRSHOLAZARBASIN" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[12] = { ["index"] = FEEDBACKUI_STRSTORMPEAKS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 85, ["text"] = "FEEDBACKUI_STRSTORMPEAKS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[13] = { ["index"] = FEEDBACKUI_STRUTGARDEPINNACLE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 80, ["text"] = "FEEDBACKUI_STRUTGARDEPINNACLE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[14] = { ["index"] = FEEDBACKUI_STRWINTERGRASP, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 86, ["text"] = "FEEDBACKUI_STRWINTERGRASP" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[15] = { ["index"] = FEEDBACKUI_STRZULDRAK, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 87, ["text"] = "FEEDBACKUI_STRZULDRAK" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[16] = { ["index"] = FEEDBACKUI_STROUTLANDS, ["summary"] = { ["type"] = "where", ["value"] = 2, ["text"] = "FEEDBACKUI_OUTLANDS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[17] = { ["index"] = FEEDBACKUI_STRBLADESEDGE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 3, ["text"] = "FEEDBACKUI_STRBLADESEDGE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[18] = { ["index"] = FEEDBACKUI_STRHELLFIRE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 4, ["text"] = "FEEDBACKUI_STRHELLFIRE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[19] = { ["index"] = FEEDBACKUI_STRNAGRAND, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 5, ["text"] = "FEEDBACKUI_STRNAGRAND" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[20] = { ["index"] = FEEDBACKUI_STRNETHERSTORM, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 6, ["text"] = "FEEDBACKUI_STRNETHERSTORM" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[21] = { ["index"] = FEEDBACKUI_STRSHADOWMOON, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 7, ["text"] = "FEEDBACKUI_STRSHADOWMOON" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[22] = { ["index"] = FEEDBACKUI_STRSHATTRATH, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 8, ["text"] = "FEEDBACKUI_STRSHATTRATH" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[23] = { ["index"] = FEEDBACKUI_STRTERROKAR, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 9, ["text"] = "FEEDBACKUI_STRTERROKAR" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[24] = { ["index"] = FEEDBACKUI_STRTWISTINGNETHER, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 10, ["text"] = "FEEDBACKUI_STRTWISTINGNETHER" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[25] = { ["index"] = FEEDBACKUI_STRZANGARMARSH, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 11, ["text"] = "FEEDBACKUI_STRZANGARMARSH" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[26] = { ["index"] = FEEDBACKUI_STREKINGDOMS, ["summary"] = { ["type"] = "where", ["value"] = 12, ["text"] = "FEEDBACKUI_EKINGDOMS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[27] = { ["index"] = FEEDBACKUI_STRALTERACMOUNTAINS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 13, ["text"] = "FEEDBACKUI_STRALTERACMOUNTAINS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[28] = { ["index"] = FEEDBACKUI_STRALTERACVALLEY, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 14, ["text"] = "FEEDBACKUI_STRALTERACVALLEY" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[29] = { ["index"] = FEEDBACKUI_STRARATHIBASIN, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 15, ["text"] = "FEEDBACKUI_STRARATHIBASIN" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[30] = { ["index"] = FEEDBACKUI_STRARATHIHIGHLANDS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 16, ["text"] = "FEEDBACKUI_STRARATHIHIGHLANDS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[31] = { ["index"] = FEEDBACKUI_STRBADLANDS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 17, ["text"] = "FEEDBACKUI_STRBADLANDS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[32] = { ["index"] = FEEDBACKUI_STRBLACKROCKMOUNTAIN, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 18, ["text"] = "FEEDBACKUI_STRBLACKROCKMOUNTAIN" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[33] = { ["index"] = FEEDBACKUI_STRBLASTEDLANDS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 19, ["text"] = "FEEDBACKUI_STRBLASTEDLANDS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[34] = { ["index"] = FEEDBACKUI_STRBURNINGSTEPPES, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 20, ["text"] = "FEEDBACKUI_STRBURNINGSTEPPES" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[35] = { ["index"] = FEEDBACKUI_STRDEADWINDPASS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 21, ["text"] = "FEEDBACKUI_STRDEADWINDPASS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[36] = { ["index"] = FEEDBACKUI_STRDUNMOROGH, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 22, ["text"] = "FEEDBACKUI_STRDUNMOROGH" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[37] = { ["index"] = FEEDBACKUI_STRDUSKWOOD, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 23, ["text"] = "FEEDBACKUI_STRDUSKWOOD" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[38] = { ["index"] = FEEDBACKUI_STREPLAGUELANDS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 24, ["text"] = "FEEDBACKUI_STREPLAGUELANDS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[39] = { ["index"] = FEEDBACKUI_STRELWYNN, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 25, ["text"] = "FEEDBACKUI_STRELWYNN" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[40] = { ["index"] = FEEDBACKUI_STREVERSONG, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 26, ["text"] = "FEEDBACKUI_STREVERSONG" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[41] = { ["index"] = FEEDBACKUI_STRGHOSTLANDS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 27, ["text"] = "FEEDBACKUI_STRGHOSTLANDS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[42] = { ["index"] = FEEDBACKUI_STRHILLSBRAD, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 28, ["text"] = "FEEDBACKUI_STRHILLSBRAD" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[43] = { ["index"] = FEEDBACKUI_STRHINTERLANDS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 29, ["text"] = "FEEDBACKUI_STRHINTERLANDS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[44] = { ["index"] = FEEDBACKUI_STRIRONFORGE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 30, ["text"] = "FEEDBACKUI_STRIRONFORGE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[45] = { ["index"] = FEEDBACKUI_STRISLEOFQUELDANAS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 73, ["text"] = "FEEDBACKUI_STRISLEOFQUELDANAS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[46] = { ["index"] = FEEDBACKUI_STRLOCHMODAN, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 31, ["text"] = "FEEDBACKUI_STRLOCHMODAN" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[47] = { ["index"] = FEEDBACKUI_STRREDRIDGE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 32, ["text"] = "FEEDBACKUI_STRREDRIDGE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[48] = { ["index"] = FEEDBACKUI_STRSEARINGGORGE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 33, ["text"] = "FEEDBACKUI_STRSEARINGGORGE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[49] = { ["index"] = FEEDBACKUI_STRSILVERMOON, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 34, ["text"] = "FEEDBACKUI_STRSILVERMOON" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[50] = { ["index"] = FEEDBACKUI_STRSILVERPINE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 35, ["text"] = "FEEDBACKUI_STRSILVERPINE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[51] = { ["index"] = FEEDBACKUI_STRSTORMWIND, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 36, ["text"] = "FEEDBACKUI_STRSTORMWIND" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[52] = { ["index"] = FEEDBACKUI_STRSTRANGLETHORN, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 37, ["text"] = "FEEDBACKUI_STRSTRANGLETHORN" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[53] = { ["index"] = FEEDBACKUI_STRSWAMPOFSORROWS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 38, ["text"] = "FEEDBACKUI_STRSWAMPOFSORROWS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[54] = { ["index"] = FEEDBACKUI_STRTIRISFAL, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 39, ["text"] = "FEEDBACKUI_STRTIRISFAL" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[55] = { ["index"] = FEEDBACKUI_STRUNDERCITY, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 40, ["text"] = "FEEDBACKUI_STRUNDERCITY" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[56] = { ["index"] = FEEDBACKUI_STRWPLAGUELANDS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 41, ["text"] = "FEEDBACKUI_STRWPLAGUELANDS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[57] = { ["index"] = FEEDBACKUI_STRWESTFALL, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 42, ["text"] = "FEEDBACKUI_STRWESTFALL" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[58] = { ["index"] = FEEDBACKUI_STRWETLANDS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 43, ["text"] = "FEEDBACKUI_STRWETLANDS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[59] = { ["index"] = FEEDBACKUI_STRKALIMDOR, ["summary"] = { ["type"] = "where", ["value"] = 44, ["text"] = "FEEDBACKUI_KALIMDOR" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[60] = { ["index"] = FEEDBACKUI_STRASHENVALE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 45, ["text"] = "FEEDBACKUI_STRASHENVALE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[61] = { ["index"] = FEEDBACKUI_STRAZSHARA, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 46, ["text"] = "FEEDBACKUI_STRAZSHARA" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[62] = { ["index"] = FEEDBACKUI_STRAZUREMYST, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 47, ["text"] = "FEEDBACKUI_STRAZUREMYST" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[63] = { ["index"] = FEEDBACKUI_STRBARRENS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 48, ["text"] = "FEEDBACKUI_STRBARRENS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[64] = { ["index"] = FEEDBACKUI_STRBLOODMYST, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 49, ["text"] = "FEEDBACKUI_STRBLOODMYST" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[65] = { ["index"] = FEEDBACKUI_STRDARKSHORE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 50, ["text"] = "FEEDBACKUI_STRDARKSHORE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[66] = { ["index"] = FEEDBACKUI_STRDARNASSUS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 51, ["text"] = "FEEDBACKUI_STRDARNASSUS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[67] = { ["index"] = FEEDBACKUI_STRDESOLACE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 52, ["text"] = "FEEDBACKUI_STRDESOLACE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[68] = { ["index"] = FEEDBACKUI_STRDUROTAR, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 53, ["text"] = "FEEDBACKUI_STRDUROTAR" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[69] = { ["index"] = FEEDBACKUI_STRDUSTWALLOW, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 54, ["text"] = "FEEDBACKUI_STRDUSTWALLOW" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[70] = { ["index"] = FEEDBACKUI_STREXODAR, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 55, ["text"] = "FEEDBACKUI_STREXODAR" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[71] = { ["index"] = FEEDBACKUI_STRFELWOOD, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 56, ["text"] = "FEEDBACKUI_STRFELWOOD" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[72] = { ["index"] = FEEDBACKUI_STRFERALAS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 57, ["text"] = "FEEDBACKUI_STRFERALAS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[73] = { ["index"] = FEEDBACKUI_STRMOONGLADE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 58, ["text"] = "FEEDBACKUI_STRMOONGLADE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[74] = { ["index"] = FEEDBACKUI_STRMULGORE, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 59, ["text"] = "FEEDBACKUI_STRMULGORE" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[75] = { ["index"] = FEEDBACKUI_STRORGRIMMAR, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 60, ["text"] = "FEEDBACKUI_STRORGRIMMAR" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[76] = { ["index"] = FEEDBACKUI_STRSILITHUS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 61, ["text"] = "FEEDBACKUI_STRSILITHUS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[77] = { ["index"] = FEEDBACKUI_STRSTONETALON, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 62, ["text"] = "FEEDBACKUI_STRSTONETALON" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[78] = { ["index"] = FEEDBACKUI_STRTANARIS, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 63, ["text"] = "FEEDBACKUI_STRTANARIS" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[79] = { ["index"] = FEEDBACKUI_STRTELDRASSIL, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 64, ["text"] = "FEEDBACKUI_STRTELDRASSIL" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[80] = { ["index"] = FEEDBACKUI_STRTHUNDERBLUFF, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 65, ["text"] = "FEEDBACKUI_STRTHUNDERBLUFF" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[81] = { ["index"] = FEEDBACKUI_STRTHOUSANDNEEDLES, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 66, ["text"] = "FEEDBACKUI_STRTHOUSANDNEEDLES" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[82] = { ["index"] = FEEDBACKUI_STRUNGORO, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 67, ["text"] = "FEEDBACKUI_STRUNGORO" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[83] = { ["index"] = FEEDBACKUI_STRWARSONG, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 68, ["text"] = "FEEDBACKUI_STRWARSONG" }, ["link"] = "FEEDBACKUI_WHOTABLE" },
	[84] = { ["index"] = FEEDBACKUI_STRWINTERSPRING, ["offset"] = 1, ["summary"] = { ["type"] = "where", ["value"] = 69, ["text"] = "FEEDBACKUI_STRWINTERSPRING" }, ["link"] = "FEEDBACKUI_WHOTABLE" } }
	
end

FEEDBACKUI_POITABLE = { { ["name"] = FEEDBACKUI_POIUNDERCITY, ["zone"] = FEEDBACKUI_EKINGDOMS },
{ ["name"] = FEEDBACKUI_POISILVERMOON, ["zone"] = FEEDBACKUI_EKINGDOMS },
{ ["name"] = FEEDBACKUI_POIIRONFORGE, ["zone"] = FEEDBACKUI_EKINGDOMS },
{ ["name"] = FEEDBACKUI_POISTORMWIND, ["zone"] = FEEDBACKUI_EKINGDOMS },
{ ["name"] = FEEDBACKUI_POISEPULCHER, ["zone"] = FEEDBACKUI_SILVERPINE },
{ ["name"] = FEEDBACKUI_POITARRENMILL, ["zone"] = FEEDBACKUI_HILLSBRAD },
{ ["name"] = FEEDBACKUI_POISOUTHSHORE, ["zone"] = FEEDBACKUI_HILLSBRAD },
{ ["name"] = FEEDBACKUI_POIAERIEPEAK, ["zone"] = FEEDBACKUI_HINTERLANDS },
{ ["name"] = FEEDBACKUI_POIREVANTUSK, ["zone"] = FEEDBACKUI_HINTERLANDS },
{ ["name"] = FEEDBACKUI_POIHAMMERFALL, ["zone"] = FEEDBACKUI_ARATHIHIGHLANDS },
{ ["name"] = FEEDBACKUI_POIMENETHIL, ["zone"] = FEEDBACKUI_WETLANDS },
{ ["name"] = FEEDBACKUI_POITHELSAMAR, ["zone"] = FEEDBACKUI_LOCHMODAN },
{ ["name"] = FEEDBACKUI_POIKARGATH, ["zone"] = FEEDBACKUI_BADLANDS },
{ ["name"] = FEEDBACKUI_POILAKESHIRE, ["zone"] = FEEDBACKUI_REDRIDGE },
{ ["name"] = FEEDBACKUI_POISENTINELHILL, ["zone"] = FEEDBACKUI_WESTFALL },
{ ["name"] = FEEDBACKUI_POIDARKSHIRE, ["zone"] = FEEDBACKUI_DUSKWOOD },
{ ["name"] = FEEDBACKUI_POISTONARD, ["zone"] = FEEDBACKUI_SWAMPOFSORROWS },
{ ["name"] = FEEDBACKUI_POIGROMGOL, ["zone"] = FEEDBACKUI_STRANGLETHORN },
{ ["name"] = FEEDBACKUI_POIBOOTY, ["zone"] = FEEDBACKUI_STRANGLETHORN },
{ ["name"] = FEEDBACKUI_POIDARNASSUS, ["zone"] = FEEDBACKUI_KALIMDOR },
{ ["name"] = FEEDBACKUI_POIEXODAR, ["zone"] = FEEDBACKUI_KALIMDOR },
{ ["name"] = FEEDBACKUI_POIORGRIMMAR, ["zone"] = FEEDBACKUI_KALIMDOR },
{ ["name"] = FEEDBACKUI_POITHUNDERB, ["zone"] = FEEDBACKUI_KALIMDOR },
{ ["name"] = FEEDBACKUI_POIAUBERDINE, ["zone"] = FEEDBACKUI_DARKSHORE },
{ ["name"] = FEEDBACKUI_POIEVERLOOK, ["zone"] = FEEDBACKUI_WINTERSPRING },
{ ["name"] = FEEDBACKUI_POISTONETALON, ["zone"] = FEEDBACKUI_STONETALON },
{ ["name"] = FEEDBACKUI_POIASTRANAAR, ["zone"] = FEEDBACKUI_ASHENVALE },
{ ["name"] = FEEDBACKUI_POISPLINTERTREE, ["zone"] = FEEDBACKUI_ASHENVALE },
{ ["name"] = FEEDBACKUI_POISUNROCK, ["zone"] = FEEDBACKUI_STONETALON },
{ ["name"] = FEEDBACKUI_POINIJELS, ["zone"] = FEEDBACKUI_DESOLACE },
{ ["name"] = FEEDBACKUI_POISHADOWPREY, ["zone"] = FEEDBACKUI_DESOLACE },
{ ["name"] = FEEDBACKUI_POIFEATHERMOON, ["zone"] = FEEDBACKUI_FERALAS }, 
{ ["name"] = FEEDBACKUI_POIMOJACHE, ["zone"] = FEEDBACKUI_FERALAS },
{ ["name"] = FEEDBACKUI_POITHALANAAR, ["zone"] = FEEDBACKUI_FERALAS },
{ ["name"] = FEEDBACKUI_POICENARIONHOLD, ["zone"] = FEEDBACKUI_SILITHUS },
{ ["name"] = FEEDBACKUI_POIGADGET, ["zone"] = FEEDBACKUI_TANARIS },
{ ["name"] = FEEDBACKUI_POIFREEWIND, ["zone"] = FEEDBACKUI_THOUSANDNEEDLES },
{ ["name"] = FEEDBACKUI_POITAURAJO, ["zone"] = FEEDBACKUI_BARRENS },
{ ["name"] = FEEDBACKUI_POICROSSROADS, ["zone"] = FEEDBACKUI_BARRENS },
{ ["name"] = FEEDBACKUI_POIRATCHET, ["zone"] = FEEDBACKUI_BARRENS },
{ ["name"] = FEEDBACKUI_POITHERAMORE, ["zone"] = FEEDBACKUI_DUSTWALLOW } }            

FEEDBACKUI_GENERICTYPETABLE = { [1] = { ["index"] = FEEDBACKUI_STRVOICECHAT, ["summary"] = { ["type"] = "type", ["value"] = 23, ["text"] = "FEEDBACKUI_VOICECHAT" }, ["link"] = "FEEDBACKUI_VOICECHATTYPETABLE" },
[2] = { ["index"] = FEEDBACKUI_STRUIOTHER, ["summary"] = { ["type"] = "type", ["value"] = 1, ["text"] = "FEEDBACKUI_UIOTHER" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRUIITEMS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 2, ["text"] = "FEEDBACKUI_UIITEMS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[4] = { ["index"] = FEEDBACKUI_STRUISPAWNS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 3, ["text"] = "FEEDBACKUI_UISPAWNS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[5] = { ["index"] = FEEDBACKUI_STRUIQUESTS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 4, ["text"] = "FEEDBACKUI_UIQUESTS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[6] = { ["index"] = FEEDBACKUI_STRUISPELLS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 5, ["text"] = "FEEDBACKUI_UISPELLS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[7] = { ["index"] = FEEDBACKUI_STRUITRADESKILLS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 6, ["text"] = "FEEDBACKUI_UITRADESKILLS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[8] = { ["index"] = FEEDBACKUI_STRGRAPHICOTHER, ["summary"] = { ["type"] = "type", ["value"] = 7, ["text"] = "FEEDBACKUI_GRAPHICOTHER" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[9] = { ["index"] = FEEDBACKUI_STRGRAPHICITEMS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 8, ["text"] = "FEEDBACKUI_GRAPHICITEMS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[10] = { ["index"] = FEEDBACKUI_STRGRAPHICSPAWNS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 9, ["text"] = "FEEDBACKUI_GRAPHICSPAWNS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[11] = { ["index"] = FEEDBACKUI_STRGRAPHICSPELLS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 10, ["text"] = "FEEDBACKUI_GRAPHICSPELLS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[12] = { ["index"] = FEEDBACKUI_STRGRAPHICENVIRONMENT, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 11, ["text"] = "FEEDBACKUI_GRAPHICENVIRONMENT" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[13] = { ["index"] = FEEDBACKUI_STRFUNCOTHER, ["summary"] = { ["type"] = "type", ["value"] = 12, ["text"] = "FEEDBACKUI_FUNCOTHER" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[14] = { ["index"] = FEEDBACKUI_STRFUNCITEMS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 13, ["text"] = "FEEDBACKUI_FUNCITEMS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[15] = { ["index"] = FEEDBACKUI_STRFUNCSPAWNS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 14, ["text"] = "FEEDBACKUI_FUNCSPAWNS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[16] = { ["index"] = FEEDBACKUI_STRFUNCQUESTS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 15, ["text"] = "FEEDBACKUI_FUNCQUESTS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[17] = { ["index"] = FEEDBACKUI_STRFUNCSPELLS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 16, ["text"] = "FEEDBACKUI_FUNCSPELLS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[18] = { ["index"] = FEEDBACKUI_STRFUNCTRADESKILLS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 17, ["text"] = "FEEDBACKUI_FUNCTRADESKILLS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },    
[19] = { ["index"] = FEEDBACKUI_STRCRASHOTHER, ["summary"] = { ["type"] = "type", ["value"] = 18, ["text"] = "FEEDBACKUI_CRASHOTHER" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[20] = { ["index"] = FEEDBACKUI_STRCRASHBUG, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 19, ["text"] = "FEEDBACKUI_CRASHBUG" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[21] = { ["index"] = FEEDBACKUI_STRCRASHSOFTLOCK, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 20, ["text"] = "FEEDBACKUI_CRASHSOFTLOCK" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[22] = { ["index"] = FEEDBACKUI_STRCRASHHARDLOCK, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 21, ["text"] = "FEEDBACKUI_CRASHHARDLOCK" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[23] = { ["index"] = FEEDBACKUI_STRCRASHWOWLAG, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 22, ["text"] = "FEEDBACKUI_CRASHWOWLAG" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
["header"] = "",
["subtext"] = FEEDBACKUI_TYPETABLESUBTEXT }

FEEDBACKUI_BUGWELCOMETABLE = { [1] = { ["prompt"] = FEEDBACKUI_WELCOME, ["link"] = "FEEDBACKUI_WHERETABLE" }, ["header"] = FEEDBACKUI_WHITE .. FEEDBACKUI_WELCOMETABLEBUGHEADER, ["subtext"] = FEEDBACKUI_WELCOMETABLEBUGSUBTEXT }    
FEEDBACKUI_SUGGESTWELCOMETABLE = { [1] = { ["prompt"] = FEEDBACKUI_WELCOME, ["link"] = "FEEDBACKUI_WHERETABLE" }, ["header"] = FEEDBACKUI_WHITE .. FEEDBACKUI_WELCOMETABLESUGGESTHEADER, ["subtext"] = FEEDBACKUI_WELCOMETABLESUGGESTSUBTEXT }    

FEEDBACKUI_WHENTABLE = { [4] = { ["index"] = FEEDBACKUI_STRREPRODUCABLE, ["summary"] = { ["type"] = "when", ["value"] = 4, ["text"] = "FEEDBACKUI_REPRODUCABLE" }, ["link"] = "edit" },
[3] = { ["index"] = FEEDBACKUI_STRSOMETIMES, ["summary"] = { ["type"] = "when", ["value"] = 3, ["text"] = "FEEDBACKUI_SOMETIMES" }, ["link"] = "edit" },
[2] = { ["index"] = FEEDBACKUI_STRRARELY, ["summary"] = { ["type"] = "when", ["value"] = 2, ["text"] = "FEEDBACKUI_RARELY" }, ["link"] = "edit" },
[1] = { ["index"] = FEEDBACKUI_STRONETIME, ["summary"] = { ["type"] = "when", ["value"] = 1, ["text"] = "FEEDBACKUI_ONETIME" }, ["link"] = "edit" },
["header"] = "",
["subtext"] = FEEDBACKUI_WHENTABLESUBTEXT }

FEEDBACKUI_WHERETABLE = { [1] = { ["index"] = FEEDBACKUI_STRAREATABLE, ["summary"] = { ["type"] = "where", ["value"] = 1, ["text"] = "FEEDBACKUI_AREATABLESUMMARY" }, ["link"] = "FEEDBACKUI_AREATABLE" },
[2] = { ["index"] = FEEDBACKUI_STRWHEREINSTALL, ["summary"] = { ["type"] = "where", ["value"] = 70, ["text"] = "FEEDBACKUI_WHEREINSTALL" }, ["link"] = "FEEDBACKUI_TYPETABLE" },
[3] = { ["index"] = FEEDBACKUI_STRWHEREDOWNLOAD, ["summary"] = { ["type"] = "where", ["value"] = 71, ["text"] = "FEEDBACKUI_WHEREDOWNLOAD" }, ["link"] = "FEEDBACKUI_TYPETABLE" }, 
[4] = { ["index"] = FEEDBACKUI_STRWHEREPATCH, ["summary"] = { ["type"] = "where", ["value"] = 72, ["text"] = "FEEDBACKUI_WHEREPATCH" }, ["link"] = "FEEDBACKUI_TYPETABLE" },
["header"] = "",
["subtext"] = FEEDBACKUI_WHERETABLESUBTEXT } 

FEEDBACKUI_AREATABLE["header"] = "";
FEEDBACKUI_AREATABLE["subtext"] = FEEDBACKUI_WHERETABLESUBTEXT;              

FEEDBACKUI_WHOTABLE = { [1] = { ["index"] = FEEDBACKUI_STRWHOPLAYER, ["summary"] = { ["type"] = "who", ["value"] = 1, ["text"] = "FEEDBACKUI_WHOPLAYER" }, ["link"] = "FEEDBACKUI_TYPETABLE" },
[2] = { ["index"] = FEEDBACKUI_STRPARTYMEMBER, ["summary"] = { ["type"] = "who", ["value"] = 2, ["text"] = "FEEDBACKUI_PARTYMEMBER" }, ["link"] = "FEEDBACKUI_TYPETABLE" },
[3] = { ["index"] = FEEDBACKUI_STRRAIDMEMBER, ["summary"] = { ["type"] = "who", ["value"] = 3, ["text"] = "FEEDBACKUI_RAIDMEMBER" }, ["link"] = "FEEDBACKUI_TYPETABLE" },
[4] = { ["index"] = FEEDBACKUI_STRENEMYPLAYER, ["summary"] = { ["type"] = "who", ["value"] = 4, ["text"] = "FEEDBACKUI_ENEMYPLAYER" }, ["link"] = "FEEDBACKUI_TYPETABLE" },
[5] = { ["index"] = FEEDBACKUI_STRFRIENDLYPLAYER, ["summary"] = { ["type"] = "who", ["value"] = 5, ["text"] = "FEEDBACKUI_FRIENDLYPLAYER" }, ["link"] = "FEEDBACKUI_TYPETABLE" },
[6] = { ["index"] = FEEDBACKUI_STRENEMYCREATURE, ["summary"] = { ["type"] = "who", ["value"] = 6, ["text"] = "FEEDBACKUI_ENEMYCREATURE" } , ["link"] = "FEEDBACKUI_TYPETABLE" },
[7] = { ["index"] = FEEDBACKUI_STRFRIENDLYCREATURE, ["summary"] = { ["type"] = "who", ["value"] = 7, ["text"] = "FEEDBACKUI_FRIENDLYCREATURE" }, ["link"] = "FEEDBACKUI_TYPETABLE" },
[8] = { ["index"] = FEEDBACKUI_STRWHONA, ["summary"] = { ["type"] = "who", ["value"] = 0, ["text"] = "FEEDBACKUI_WHONA" }, ["link"] = "FEEDBACKUI_TYPETABLE" },
["header"] = "",
["subtext"] = FEEDBACKUI_WHOTABLESUBTEXT }

----------------------------------------------------------------------------------------------------             

FEEDBACKUI_SURVEYRESPONSETYPES = { ["Areas"] = { "difficulty", "reward", "fun" }, 
["Quests"] = { "clarity", "difficulty", "reward", "fun" }, 
["Mobs"] = { "difficulty", "reward", "fun", "appearance" },
["Items"] = { "difficulty", "utility", "appearance" },
["Spells"] = { "power", "frequency", "appropriateness", "fun" }, };

FEEDBACKUI_RESPONSELABELS = {  ["clarity"] = FEEDBACKUILBLFRMCLARITY_TEXT, 
["difficulty"] = FEEDBACKUILBLFRMDIFFICULTY_TEXT, 
["reward"] = FEEDBACKUILBLFRMREWARD_TEXT, 
["fun"] = FEEDBACKUILBLFRMFUN_TEXT,
["appearance"] = FEEDBACKUILBLAPPEARANCE_TEXT,
["utility"] = FEEDBACKUILBLUTILITY_TEXT,
["power"] = FEEDBACKUILBLPOWER_TEXT,
["frequency"] = FEEDBACKUILBLFREQUENCY_TEXT,
["appropriateness"] = FEEDBACKUILBLAPPROPRIATE_TEXT, }

FEEDBACKUI_AREADIFFICULTIES = { DUNGEON_DIFFICULTY1, DUNGEON_DIFFICULTY2, DUNGEON_DIFFICULTY3};


FEEDBACKUI_AREASDIFFICULTYTABLE = { [1] = { ["index"] = FEEDBACKUI_DIFFICULTY1, ["summary"] = { ["type"] = "difficulty", ["value"] = 1, ["text"] = "FEEDBACKUI_DIFFICULTY1" }, ["link"] = "FEEDBACKUI_AREASREWARDTABLE" },
[2] = { ["index"] = FEEDBACKUI_DIFFICULTY2, ["summary"] = { ["type"] = "difficulty", ["value"] = 2, ["text"] = "FEEDBACKUI_DIFFICULTY2" }, ["link"] = "FEEDBACKUI_AREASREWARDTABLE" },
[3] = { ["index"] = FEEDBACKUI_DIFFICULTY3, ["summary"] = { ["type"] = "difficulty", ["value"] = 3, ["text"] = "FEEDBACKUI_DIFFICULTY3" }, ["link"] = "FEEDBACKUI_AREASREWARDTABLE" },
[4] = { ["index"] = FEEDBACKUI_DIFFICULTY4, ["summary"] = { ["type"] = "difficulty", ["value"] = 4, ["text"] = "FEEDBACKUI_DIFFICULTY4" }, ["link"] = "FEEDBACKUI_AREASREWARDTABLE" },
["header"] = FEEDBACKUI_AREASDIFFICULTYTABLEHEADER, 
["subtext"] = FEEDBACKUI_AREASDIFFICULTYTABLESUBTEXT }

FEEDBACKUI_AREASREWARDTABLE = { [1] = { ["index"] = FEEDBACKUI_REWARD1, ["summary"] = { ["type"] = "reward", ["value"] = 1, ["text"] = "FEEDBACKUI_REWARD1" }, ["link"] = "FEEDBACKUI_AREASFUNTABLE" },
[2] = { ["index"] = FEEDBACKUI_REWARD2, ["summary"] = { ["type"] = "reward", ["value"] = 2, ["text"] = "FEEDBACKUI_REWARD2" }, ["link"] = "FEEDBACKUI_AREASFUNTABLE" },
[3] = { ["index"] = FEEDBACKUI_REWARD3, ["summary"] = { ["type"] = "reward", ["value"] = 3, ["text"] = "FEEDBACKUI_REWARD3" }, ["link"] = "FEEDBACKUI_AREASFUNTABLE" },
[4] = { ["index"] = FEEDBACKUI_REWARD4, ["summary"] = { ["type"] = "reward", ["value"] = 4, ["text"] = "FEEDBACKUI_REWARD4" }, ["link"] = "FEEDBACKUI_AREASFUNTABLE" },
["header"] = FEEDBACKUI_AREASREWARDTABLEHEADER,
["subtext"] = FEEDBACKUI_AREASREWARDTABLESUBTEXT }

FEEDBACKUI_AREASFUNTABLE = { [1] = { ["index"] = FEEDBACKUI_FUN1, ["summary"] = { ["type"] = "fun", ["value"] = 1, ["text"] = "FEEDBACKUI_FUN1" }, ["link"] = "edit" },
[2] = { ["index"] = FEEDBACKUI_FUN2, ["summary"] = { ["type"] = "fun", ["value"] = 2, ["text"] = "FEEDBACKUI_FUN2" }, ["link"] = "edit" },
[3] = { ["index"] = FEEDBACKUI_FUN3, ["summary"] = { ["type"] = "fun", ["value"] = 3, ["text"] = "FEEDBACKUI_FUN3" }, ["link"] = "edit" },
[4] = { ["index"] = FEEDBACKUI_FUN4, ["summary"] = { ["type"] = "fun", ["value"] = 4, ["text"] = "FEEDBACKUI_FUN4" }, ["link"] = "edit" },
["header"] = FEEDBACKUI_AREASFUNTABLEHEADER,
["subtext"] = FEEDBACKUI_AREASFUNTABLESUBTEXT }

FEEDBACKUI_QUESTSCLARITYTABLE = { [1] = { ["index"] = FEEDBACKUI_STRCLARITY1, ["summary"] = { ["type"] = "clarity", ["value"] = 1, ["text"] = "FEEDBACKUI_CLARITY1" }, ["link"] = "FEEDBACKUI_QUESTSDIFFICULTYTABLE" },
[2] = { ["index"] = FEEDBACKUI_STRCLARITY2, ["summary"] = { ["type"] = "clarity", ["value"] = 2, ["text"] = "FEEDBACKUI_CLARITY2" }, ["link"] = "FEEDBACKUI_QUESTSDIFFICULTYTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRCLARITY3, ["summary"] = { ["type"] = "clarity", ["value"] = 3, ["text"] = "FEEDBACKUI_CLARITY3" }, ["link"] = "FEEDBACKUI_QUESTSDIFFICULTYTABLE" },
[4] = { ["index"] = FEEDBACKUI_STRCLARITY4, ["summary"] = { ["type"] = "clarity", ["value"] = 4, ["text"] = "FEEDBACKUI_CLARITY4" }, ["link"] = "FEEDBACKUI_QUESTSDIFFICULTYTABLE" },
["header"] = FEEDBACKUI_QUESTSCLARITYTABLEHEADER,
["subtext"] = FEEDBACKUI_QUESTSCLARITYTABLESUBTEXT }

FEEDBACKUI_QUESTSDIFFICULTYTABLE = { [1] = { ["index"] = FEEDBACKUI_STRDIFFICULTY1, ["summary"] = { ["type"] = "difficulty", ["value"] = 1, ["text"] = "FEEDBACKUI_DIFFICULTY1" }, ["link"] = "FEEDBACKUI_QUESTSREWARDTABLE" },
[2] = { ["index"] = FEEDBACKUI_STRDIFFICULTY2, ["summary"] = { ["type"] = "difficulty", ["value"] = 2, ["text"] = "FEEDBACKUI_DIFFICULTY2" }, ["link"] = "FEEDBACKUI_QUESTSREWARDTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRDIFFICULTY3, ["summary"] = { ["type"] = "difficulty", ["value"] = 3, ["text"] = "FEEDBACKUI_DIFFICULTY3" }, ["link"] = "FEEDBACKUI_QUESTSREWARDTABLE" },
[4] = { ["index"] = FEEDBACKUI_STRDIFFICULTY4, ["summary"] = { ["type"] = "difficulty", ["value"] = 4, ["text"] = "FEEDBACKUI_DIFFICULTY4" }, ["link"] = "FEEDBACKUI_QUESTSREWARDTABLE" },
["header"] = FEEDBACKUI_QUESTSDIFFICULTYTABLEHEADER,
["subtext"] = FEEDBACKUI_QUESTSDIFFICULTYTABLESUBTEXT }

FEEDBACKUI_QUESTSREWARDTABLE = { [1] = { ["index"] = FEEDBACKUI_STRREWARD1, ["summary"] = { ["type"] = "reward", ["value"] = 1, ["text"] = "FEEDBACKUI_REWARD1" }, ["link"] = "FEEDBACKUI_QUESTSFUNTABLE" },
[2] = { ["index"] = FEEDBACKUI_STRREWARD2, ["summary"] = { ["type"] = "reward", ["value"] = 2, ["text"] = "FEEDBACKUI_REWARD2" }, ["link"] = "FEEDBACKUI_QUESTSFUNTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRREWARD3, ["summary"] = { ["type"] = "reward", ["value"] = 3, ["text"] = "FEEDBACKUI_REWARD3" }, ["link"] = "FEEDBACKUI_QUESTSFUNTABLE" },
[4] = { ["index"] = FEEDBACKUI_STRREWARD4, ["summary"] = { ["type"] = "reward", ["value"] = 4, ["text"] = "FEEDBACKUI_REWARD4" }, ["link"] = "FEEDBACKUI_QUESTSFUNTABLE" },
["header"] = FEEDBACKUI_QUESTSREWARDTABLEHEADER,
["subtext"] = FEEDBACKUI_QUESTSREWARDTABLESUBTEXT }

FEEDBACKUI_QUESTSFUNTABLE = { [1] = { ["index"] = FEEDBACKUI_STRFUN1, ["summary"] = { ["type"] = "fun", ["value"] = 1, ["text"] = "FEEDBACKUI_FUN1" }, ["link"] = "edit" },
[2] = { ["index"] = FEEDBACKUI_STRFUN2, ["summary"] = { ["type"] = "fun", ["value"] = 2, ["text"] = "FEEDBACKUI_FUN2" }, ["link"] = "edit" },
[3] = { ["index"] = FEEDBACKUI_STRFUN3, ["summary"] = { ["type"] = "fun", ["value"] = 3, ["text"] = "FEEDBACKUI_FUN3" }, ["link"] = "edit" },
[4] = { ["index"] = FEEDBACKUI_STRFUN4, ["summary"] = { ["type"] = "fun", ["value"] = 4, ["text"] = "FEEDBACKUI_FUN4" }, ["link"] = "edit" },
["header"] = FEEDBACKUI_QUESTSFUNTABLEHEADER,
["subtext"] = FEEDBACKUI_QUESTSFUNTABLESUBTEXT }   

FEEDBACKUI_MOBSDIFFICULTYTABLE = { [1] = { ["index"] = FEEDBACKUI_STRDIFFICULTY1, ["summary"] = { ["type"] = "difficulty", ["value"] = 1, ["text"] = "FEEDBACKUI_DIFFICULTY1" }, ["link"] = "FEEDBACKUI_MOBSREWARDTABLE" },
[2] = { ["index"] = FEEDBACKUI_STRDIFFICULTY2, ["summary"] = { ["type"] = "difficulty", ["value"] = 2, ["text"] = "FEEDBACKUI_DIFFICULTY2" }, ["link"] = "FEEDBACKUI_MOBSREWARDTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRDIFFICULTY3, ["summary"] = { ["type"] = "difficulty", ["value"] = 3, ["text"] = "FEEDBACKUI_DIFFICULTY3" }, ["link"] = "FEEDBACKUI_MOBSREWARDTABLE" },
[4] = { ["index"] = FEEDBACKUI_STRDIFFICULTY4, ["summary"] = { ["type"] = "difficulty", ["value"] = 4, ["text"] = "FEEDBACKUI_DIFFICULTY4" }, ["link"] = "FEEDBACKUI_MOBSREWARDTABLE" },
[5] = { ["index"] = FEEDBACKUI_STRDIFFICULTY5, ["summary"] = { ["type"] = "difficulty", ["value"] = 5, ["text"] = "FEEDBACKUI_DIFFICULTY5" }, ["link"] = "FEEDBACKUI_MOBSREWARDTABLE" },

["header"] = FEEDBACKUI_MOBSDIFFICULTYTABLEHEADER,
["subtext"] = FEEDBACKUI_MOBSDIFFICULTYTABLESUBTEXT }

FEEDBACKUI_MOBSREWARDTABLE = { [1] = { ["index"] = FEEDBACKUI_STRREWARD1, ["summary"] = { ["type"] = "reward", ["value"] = 1, ["text"] = "FEEDBACKUI_REWARD1" }, ["link"] = "FEEDBACKUI_MOBSFUNTABLE" },
[2] = { ["index"] = FEEDBACKUI_STRREWARD2, ["summary"] = { ["type"] = "reward", ["value"] = 2, ["text"] = "FEEDBACKUI_REWARD2" }, ["link"] = "FEEDBACKUI_MOBSFUNTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRREWARD3, ["summary"] = { ["type"] = "reward", ["value"] = 3, ["text"] = "FEEDBACKUI_REWARD3" }, ["link"] = "FEEDBACKUI_MOBSFUNTABLE" },
[4] = { ["index"] = FEEDBACKUI_STRREWARD4, ["summary"] = { ["type"] = "reward", ["value"] = 4, ["text"] = "FEEDBACKUI_REWARD4" }, ["link"] = "FEEDBACKUI_MOBSFUNTABLE" },
[5] = { ["index"] = FEEDBACKUI_STRREWARD5, ["summary"] = { ["type"] = "reward", ["value"] = 5, ["text"] = "FEEDBACKUI_REWARD5" }, ["link"] = "FEEDBACKUI_MOBSFUNTABLE" },

["header"] = FEEDBACKUI_MOBSREWARDTABLEHEADER,
["subtext"] = FEEDBACKUI_MOBSREWARDTABLESUBTEXT }

FEEDBACKUI_MOBSFUNTABLE = { [1] = { ["index"] = FEEDBACKUI_STRFUN1, ["summary"] = { ["type"] = "fun", ["value"] = 1, ["text"] = "FEEDBACKUI_FUN1" }, ["link"] = "FEEDBACKUI_MOBSAPPEARANCETABLE" },
[2] = { ["index"] = FEEDBACKUI_STRFUN2, ["summary"] = { ["type"] = "fun", ["value"] = 2, ["text"] = "FEEDBACKUI_FUN2" }, ["link"] = "FEEDBACKUI_MOBSAPPEARANCETABLE" },
[3] = { ["index"] = FEEDBACKUI_STRFUN3, ["summary"] = { ["type"] = "fun", ["value"] = 3, ["text"] = "FEEDBACKUI_FUN3" }, ["link"] = "FEEDBACKUI_MOBSAPPEARANCETABLE" },
[4] = { ["index"] = FEEDBACKUI_STRFUN4, ["summary"] = { ["type"] = "fun", ["value"] = 4, ["text"] = "FEEDBACKUI_FUN4" }, ["link"] = "FEEDBACKUI_MOBSAPPEARANCETABLE" },
["header"] = FEEDBACKUI_MOBSFUNTABLEHEADER,
["subtext"] = FEEDBACKUI_MOBSFUNTABLESUBTEXT }   

FEEDBACKUI_MOBSAPPEARANCETABLE = { [1] = { ["index"] = FEEDBACKUI_STRAPPEARANCE1, ["summary"] = { ["type"] = "appearance", ["value"] = 1, ["text"] = "FEEDBACKUI_APPEARANCE1" }, ["link"] = "edit" },
[2] = { ["index"] = FEEDBACKUI_STRAPPEARANCE2, ["summary"] = { ["type"] = "appearance", ["value"] = 2, ["text"] = "FEEDBACKUI_APPEARANCE2" }, ["link"] = "edit" },
[3] = { ["index"] = FEEDBACKUI_STRAPPEARANCE3, ["summary"] = { ["type"] = "appearance", ["value"] = 3, ["text"] = "FEEDBACKUI_APPEARANCE3" }, ["link"] = "edit" },
[4] = { ["index"] = FEEDBACKUI_STRAPPEARANCE4, ["summary"] = { ["type"] = "appearance", ["value"] = 4, ["text"] = "FEEDBACKUI_APPEARANCE4" }, ["link"] = "edit" },
["header"] = FEEDBACKUI_MOBSAPPEARANCETABLEHEADER,
["subtext"] = FEEDBACKUI_MOBSAPPEARANCETABLESUBTEXT }   

FEEDBACKUI_ITEMSDIFFICULTYTABLE = { [1] = { ["index"] = FEEDBACKUI_STRDIFFICULTY1, ["summary"] = { ["type"] = "difficulty", ["value"] = 1, ["text"] = "FEEDBACKUI_DIFFICULTY1" }, ["link"] = "FEEDBACKUI_ITEMSUTILITYTABLE" },
[2] = { ["index"] = FEEDBACKUI_STRDIFFICULTY2, ["summary"] = { ["type"] = "difficulty", ["value"] = 2, ["text"] = "FEEDBACKUI_DIFFICULTY2" }, ["link"] = "FEEDBACKUI_ITEMSUTILITYTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRDIFFICULTY3, ["summary"] = { ["type"] = "difficulty", ["value"] = 3, ["text"] = "FEEDBACKUI_DIFFICULTY3" }, ["link"] = "FEEDBACKUI_ITEMSUTILITYTABLE" },
[4] = { ["index"] = FEEDBACKUI_STRDIFFICULTY4, ["summary"] = { ["type"] = "difficulty", ["value"] = 4, ["text"] = "FEEDBACKUI_DIFFICULTY4" }, ["link"] = "FEEDBACKUI_ITEMSUTILITYTABLE" },
["header"] = FEEDBACKUI_ITEMSDIFFICULTYTABLEHEADER,
["subtext"] = FEEDBACKUI_ITEMSDIFFICULTYTABLESUBTEXT }   

FEEDBACKUI_ITEMSUTILITYTABLE = { [1] = { ["index"] = FEEDBACKUI_STRUTILITY1, ["summary"] = { ["type"] = "utility", ["value"] = 1, ["text"] = "FEEDBACKUI_UTILITY1" }, ["link"] = "FEEDBACKUI_ITEMSAPPEARANCETABLE" },
[2] = { ["index"] = FEEDBACKUI_STRUTILITY2, ["summary"] = { ["type"] = "utility", ["value"] = 2, ["text"] = "FEEDBACKUI_UTILITY2" }, ["link"] = "FEEDBACKUI_ITEMSAPPEARANCETABLE" },
[3] = { ["index"] = FEEDBACKUI_STRUTILITY3, ["summary"] = { ["type"] = "utility", ["value"] = 3, ["text"] = "FEEDBACKUI_UTILITY3" }, ["link"] = "FEEDBACKUI_ITEMSAPPEARANCETABLE" },
[4] = { ["index"] = FEEDBACKUI_STRUTILITY4, ["summary"] = { ["type"] = "utility", ["value"] = 4, ["text"] = "FEEDBACKUI_UTILITY4" }, ["link"] = "FEEDBACKUI_ITEMSAPPEARANCETABLE" },
["header"] = FEEDBACKUI_ITEMSUTILITYHEADER,
["subtext"] = FEEDBACKUI_ITEMSUTILITYSUBTEXT }

FEEDBACKUI_ITEMSAPPEARANCETABLE = { [1] = { ["index"] = FEEDBACKUI_STRAPPEARANCE1, ["summary"] = { ["type"] = "appearance", ["value"] = 1, ["text"] = "FEEDBACKUI_APPEARANCE1" }, ["link"] = "edit" },
[2] = { ["index"] = FEEDBACKUI_STRAPPEARANCE2, ["summary"] = { ["type"] = "appearance", ["value"] = 2, ["text"] = "FEEDBACKUI_APPEARANCE2" }, ["link"] = "edit" },
[3] = { ["index"] = FEEDBACKUI_STRAPPEARANCE3, ["summary"] = { ["type"] = "appearance", ["value"] = 3, ["text"] = "FEEDBACKUI_APPEARANCE3" }, ["link"] = "edit" },
[4] = { ["index"] = FEEDBACKUI_STRAPPEARANCE4, ["summary"] = { ["type"] = "appearance", ["value"] = 4, ["text"] = "FEEDBACKUI_APPEARANCE4" }, ["link"] = "edit" },
["header"] = FEEDBACKUI_ITEMSAPPEARANCETABLEHEADER,
["subtext"] = FEEDBACKUI_ITEMSAPPEARANCETABLESUBTEXT } 

FEEDBACKUI_SPELLSPOWERTABLE = { [1] = { ["index"] = FEEDBACKUI_STRPOWER1, ["summary"] = { ["type"] = "power", ["value"] = 1, ["text"] = "FEEDBACKUI_STRPOWER1" }, ["link"] = "FEEDBACKUI_SPELLSFREQUENCYTABLE" },
[2] = { ["index"] = FEEDBACKUI_STRPOWER2, ["summary"] = { ["type"] = "power", ["value"] = 2, ["text"] = "FEEDBACKUI_STRPOWER2" }, ["link"] = "FEEDBACKUI_SPELLSFREQUENCYTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRPOWER3, ["summary"] = { ["type"] = "power", ["value"] = 3, ["text"] = "FEEDBACKUI_STRPOWER3" }, ["link"] = "FEEDBACKUI_SPELLSFREQUENCYTABLE" },
[4] = { ["index"] = FEEDBACKUI_STRPOWER4, ["summary"] = { ["type"] = "power", ["value"] = 4, ["text"] = "FEEDBACKUI_STRPOWER4" }, ["link"] = "FEEDBACKUI_SPELLSFREQUENCYTABLE" },
["header"] = FEEDBACKUI_SPELLSPOWERTABLEHEADER,
["subtext"] = FEEDBACKUI_SPELLSPOWERTABLESUBTEXT } 

FEEDBACKUI_SPELLSFREQUENCYTABLE = { [1] = { ["index"] = FEEDBACKUI_STRFREQUENCY1, ["summary"] = { ["type"] = "frequency", ["value"] = 1, ["text"] = "FEEDBACKUI_STRFREQUENCY1" }, ["link"] = "FEEDBACKUI_SPELLSAPPROPRIATETABLE" },
[2] = { ["index"] = FEEDBACKUI_STRFREQUENCY2, ["summary"] = { ["type"] = "frequency", ["value"] = 2, ["text"] = "FEEDBACKUI_STRFREQUENCY2" }, ["link"] = "FEEDBACKUI_SPELLSAPPROPRIATETABLE" },
[3] = { ["index"] = FEEDBACKUI_STRFREQUENCY3, ["summary"] = { ["type"] = "frequency", ["value"] = 3, ["text"] = "FEEDBACKUI_STRFREQUENCY3" }, ["link"] = "FEEDBACKUI_SPELLSAPPROPRIATETABLE" },
[4] = { ["index"] = FEEDBACKUI_STRFREQUENCY4, ["summary"] = { ["type"] = "frequency", ["value"] = 4, ["text"] = "FEEDBACKUI_STRFREQUENCY4" }, ["link"] = "FEEDBACKUI_SPELLSAPPROPRIATETABLE" },
["header"] = FEEDBACKUI_SPELLSFREQUENCYTABLEHEADER,
["subtext"] = FEEDBACKUI_SPELLSFREQUENCYTABLESUBTEXT } 

FEEDBACKUI_SPELLSAPPROPRIATETABLE = { [1] = { ["index"] = FEEDBACKUI_STRAPPROPRIATE1, ["summary"] = { ["type"] = "appropriateness", ["value"] = 1, ["text"] = "FEEDBACKUI_STRAPPROPRIATE1" }, ["link"] = "FEEDBACKUI_SPELLSSFUNTABLE" },
[2] = { ["index"] = FEEDBACKUI_STRAPPROPRIATE2, ["summary"] = { ["type"] = "appropriateness", ["value"] = 2, ["text"] = "FEEDBACKUI_STRAPPROPRIATE2" }, ["link"] = "FEEDBACKUI_SPELLSSFUNTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRAPPROPRIATE3, ["summary"] = { ["type"] = "appropriateness", ["value"] = 3, ["text"] = "FEEDBACKUI_STRAPPROPRIATE3" }, ["link"] = "FEEDBACKUI_SPELLSSFUNTABLE" },
[4] = { ["index"] = FEEDBACKUI_STRAPPROPRIATE4, ["summary"] = { ["type"] = "appropriateness", ["value"] = 4, ["text"] = "FEEDBACKUI_STRAPPROPRIATE4" }, ["link"] = "FEEDBACKUI_SPELLSSFUNTABLE" },
["header"] = FEEDBACKUI_SPELLSAPPROPRIATETABLEHEADER,
["subtext"] = FEEDBACKUI_SPELLSAPPROPRIATETABLESUBTEXT } 

FEEDBACKUI_SPELLSSFUNTABLE = { [1] = { ["index"] = FEEDBACKUI_STRFUN1, ["summary"] = { ["type"] = "fun", ["value"] = 1, ["text"] = "FEEDBACKUI_FUN1" }, ["link"] = "edit" },
[2] = { ["index"] = FEEDBACKUI_STRFUN2, ["summary"] = { ["type"] = "fun", ["value"] = 2, ["text"] = "FEEDBACKUI_FUN2" }, ["link"] = "edit" },
[3] = { ["index"] = FEEDBACKUI_STRFUN3, ["summary"] = { ["type"] = "fun", ["value"] = 3, ["text"] = "FEEDBACKUI_FUN3" }, ["link"] = "edit" },
[4] = { ["index"] = FEEDBACKUI_STRFUN4, ["summary"] = { ["type"] = "fun", ["value"] = 4, ["text"] = "FEEDBACKUI_FUN4" }, ["link"] = "edit" },
["header"] = FEEDBACKUI_SPELLSFUNTABLEHEADER,
["subtext"] = FEEDBACKUI_SPELLSFUNTABLESUBTEXT }       

FEEDBACKUI_QUESTHEADER = { ["header"] = true, ["name"] = FEEDBACKUI_QUESTHEADERTEXT }
FEEDBACKUI_ITEMHEADER = { ["header"] = true, ["name"] = FEEDBACKUI_ITEMHEADERTEXT }
FEEDBACKUI_MOBHEADER = { ["header"] = true, ["name"] = FEEDBACKUI_MOBHEADERTEXT }
FEEDBACKUI_AREAHEADER = { ["header"] = true, ["name"] = FEEDBACKUI_AREAHEADERTEXT }
FEEDBACKUI_SPELLHEADER = { ["header"] = true, ["name"] = FEEDBACKUI_SPELLHEADERTEXT }

FEEDBACKUI_MOUSEBUTTONS = { { ["value"] = "BUTTON1", ["text"] = FEEDBACKUI_MOUSE1 }, 
{ ["value"] = "BUTTON2", ["text"] = FEEDBACKUI_MOUSE2 } }

if ( IsMacClient() ) then
	FEEDBACKUI_MODIFIERKEYS = { { ["value"] = "LALT", ["text"] = FEEDBACKUI_LALT }, 
	{ ["value"] = "LCTRL", ["text"] = FEEDBACKUI_LCTRL },
	{ ["value"] = "LSHIFT", ["text"] = FEEDBACKUI_LSHIFT } }
else
	FEEDBACKUI_MODIFIERKEYS = { { ["value"] = "LALT", ["text"] = FEEDBACKUI_LALT }, 
	{ ["value"] = "RALT", ["text"] = FEEDBACKUI_RALT },
	{ ["value"] = "LCTRL", ["text"] = FEEDBACKUI_LCTRL },
	{ ["value"] = "RCTRL", ["text"] = FEEDBACKUI_RCTRL },
	{ ["value"] = "LSHIFT", ["text"] = FEEDBACKUI_LSHIFT },
	{ ["value"] = "RSHIFT", ["text"] = FEEDBACKUI_RSHIFT } }
end

FEEDBACKUI_SURVEYCATEGORIES = { { ["value"] = "All", ["text"] = FEEDBACKUI_ALLHEADERTEXT }, 
{ ["value"] = "Areas", ["text"] = FEEDBACKUI_AREAHEADERTEXT },
{ ["value"] = "Items", ["text"] = FEEDBACKUI_ITEMHEADERTEXT },
{ ["value"] = "Mobs", ["text"] = FEEDBACKUI_MOBHEADERTEXT },
{ ["value"] = "Quests", ["text"] = FEEDBACKUI_QUESTHEADERTEXT },
{ ["value"] = "Spells", ["text"] = FEEDBACKUI_SPELLHEADERTEXT }, }

FEEDBACKUI_OPTIONSBUTTONS = { { ["text"] = FEEDBACKUILBLSURVEYALERTSCHECK_TEXT },
{ ["text"] = FEEDBACKUISHOWCUES_TEXT } };


FEEDBACKUI_SURVEYSTATUS = { { ["value"] = "All", ["text"] = FEEDBACKUI_STATUSALLTEXT, ["r"] = 1, ["g"] = 1, ["b"] = 1 }, 
{ ["value"] = "Available", ["text"] = FEEDBACKUI_STATUSAVAILABLETEXT, ["r"] = 1, ["g"] = 1, ["b"] = 0 },
{ ["value"] = "Skipped", ["text"] = FEEDBACKUI_STATUSSKIPPEDTEXT, ["r"] = .25, ["g"] = .75, ["b"] = .25 },
{ ["value"] = "Completed", ["text"] = FEEDBACKUI_STATUSCOMPLETEDTEXT, ["r"] = .5, ["g"] = .5, ["b"] = .5 } } 

FEEDBACKUI_SURVEYSTATUSES = { ["All"] = 1, ["Available"] = 2, ["Skipped"] = 3, ["Completed"] = 4 }              

FEEDBACKUI_SURVEYWELCOMETABLE = { [1] = { ["prompt"] = string.gsub(FEEDBACKUI_WELCOME, "\n", "", 1), ["link"] = "POINTLESS_NONEXISTANTLINK" }, ["header"] = FEEDBACKUI_WELCOMETABLESURVEYHEADER, ["subtext"] = FEEDBACKUI_WELCOMETABLESURVEYSUBTEXT }

FEEDBACKUI_SPAWNSTYPETABLE = { [1] = { ["index"] = FEEDBACKUI_STRUISPAWNS, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_UISPAWNS", ["value"] = 3 }, ["link"] = "FEEDBACKUI_WHENTABLE" },  
[2] = { ["index"] = FEEDBACKUI_STRGRAPHICSPAWNS, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_GRAPHICSPAWNS", ["value"] = 9 }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRFUNCSPAWNS, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_FUNCSPAWNS", ["value"] = 14 }, ["link"] = "FEEDBACKUI_WHENTABLE" },
["header"] = "",
["subtext"] = FEEDBACKUI_TYPETABLESUBTEXT }

FEEDBACKUI_ITEMSTYPETABLE = {  [1] = { ["index"] = FEEDBACKUI_STRUIITEMS, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_UIITEMS", ["value"] = 2 }, ["link"] = "FEEDBACKUI_WHENTABLE" },  
[2] = { ["index"] = FEEDBACKUI_STRGRAPHICITEMS, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_GRAPHICITEMS", ["value"] = 8 }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRFUNCITEMS, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_FUNCITEMS", ["value"] = 13 }, ["link"] = "FEEDBACKUI_WHENTABLE" },
["header"] = "",
["subtext"] = FEEDBACKUI_TYPETABLESUBTEXT }

FEEDBACKUI_QUESTSTYPETABLE = { [1] = { ["index"] = FEEDBACKUI_STRUIQUESTS, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_UIQUESTS", ["value"] = 4 }, ["link"] = "FEEDBACKUI_WHENTABLE" },  
[2] = { ["index"] = FEEDBACKUI_STRFUNCQUESTS, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_FUNCQUESTS", ["value"] = 15 }, ["link"] = "FEEDBACKUI_WHENTABLE" },
["header"] = "",
["subtext"] = FEEDBACKUI_TYPETABLESUBTEXT } 

FEEDBACKUI_SPELLSTYPETABLE = { [1] = { ["index"] = FEEDBACKUI_STRUISPELLS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 5, ["text"] = "FEEDBACKUI_UISPELLS" }, ["link"] = "FEEDBACKUI_WHENTABLE" }, 
[2] = { ["index"] = FEEDBACKUI_STRGRAPHICSPELLS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 10, ["text"] = "FEEDBACKUI_GRAPHICSPELLS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
[3] = { ["index"] = FEEDBACKUI_STRFUNCSPELLS, ["offset"] = 1, ["summary"] = { ["type"] = "type", ["value"] = 16, ["text"] = "FEEDBACKUI_FUNCSPELLS" }, ["link"] = "FEEDBACKUI_WHENTABLE" },
["header"] = "",
["subtext"] = FEEDBACKUI_TYPETABLESUBTEXT }

FEEDBACKUI_AREASTYPETABLE = FEEDBACKUI_WHENTABLE;

FEEDBACKUI_VOICECHATTABLE = {  [1] = { ["index"] = FEEDBACKUI_STRUSBHEADSET, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_USBHEADSET", ["value"] = 23 }, ["link"] = "edit" }, 
[2] = { ["index"] = FEEDBACKUI_STRANALOGHEADSET, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_ANALOGHEADSET", ["value"] = 24 }, ["link"] = "edit" },
[3] = { ["index"] = FEEDBACKUI_STRHARDWIREDMIC, ["summary"] = { ["type"] = "type", ["text"] = "FEEDBACKUI_HARDWIREDMIC", ["value"] = 25 }, ["link"] = "edit" },
["header"] = "",
["subtext"] = FEEDBACKUI_HEADSETTYPE }

for _, val in next, FEEDBACKUI_EXCEPTIONZONES do
	FEEDBACKUI_NONINSTANCEZONES[val] = true;
end
