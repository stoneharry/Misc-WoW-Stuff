CLIENT_VERSION = "1.3"
CLIENT_EOC_STATE = "BETA"
EXPECTED_CLIENT_VERSION = 12350
INTERNAL_CLIENT_VERSION = nil

FADE_IN_TIME = 2;
DEFAULT_TOOLTIP_COLOR = {0.8, 0.8, 0.8, 0.09, 0.09, 0.09};
GLOBAL_REALMLIST = "eoc.servegame.com:3725"

ACCOUNT_CREATE_EXISTS = "An account with that name already exists!";
ACCOUNT_CREATE_ERROR = "Account creation failed.\n\rOnly alphanumerical characters (A-Z, a-z, 0-9) allowed!";

SERVER_ALERT_URL = "http://eoc.dispersion-wow.com/scripts/serveralert/alert"
SERVER_ALERT_BETA_URL = "http://eoc.dispersion-wow.com/scripts/serveralert/alert"
SERVER_ALERT_PTR_URL = "http://eoc.dispersion-wow.com/scripts/serveralert/alert"

SAVE_FRAME = nil
SAVE_EVENT = false
SAVE_INFO = nil
SAVE_TIMER = 0

--Whoever changed these: this is for performance. Locals are faster to access than globals. Reason or GTFO.
local strfind = string.find;
local strlen = string.len;

function AccountLogin_OnLoad(self)

	SetCVar("readTOS", "1");
	SetCVar("readEULA", "1");
	SetCVar("readTerminationWithoutNotice", "1");
	--SetCVar("realmList", GLOBAL_REALMLIST);
	SetCVar("portal", "eoc");

	TOSFrame.noticeType = "EULA";

	self:RegisterEvent("SHOW_SERVER_ALERT");
	self:RegisterEvent("CLIENT_ACCOUNT_MISMATCH");
	self:RegisterEvent("CLIENT_TRIAL");
	self:RegisterEvent("SCANDLL_ERROR");
	self:RegisterEvent("SCANDLL_FINISHED");

	local versionType, buildType, version, internalVersion, date = GetBuildInfo();
	AccountLoginVersion:SetFormattedText("  Version "..CLIENT_VERSION.." "..internalVersion.." "..CLIENT_EOC_STATE.."\n\r  Edge of Chaos");
	--AccountLoginVersion:SetFormattedText(VERSION_TEMPLATE, versionType, version, internalVersion, buildType, date);
	INTERNAL_CLIENT_VERSION = internalVersion
	
	-- Color edit box backdrops
	local backdropColor = DEFAULT_TOOLTIP_COLOR;
	AccountLoginAccountEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountLoginAccountEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	AccountLoginPasswordEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountLoginPasswordEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	AccountLoginTokenEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountLoginTokenEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	TokenEnterDialogBackgroundEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	TokenEnterDialogBackgroundEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	
	CreateFinalAccountButton:Disable();
	AccountNameEditBox:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountNameEditBox:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	AccountPasswordEditBox:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountPasswordEditBox:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	AccountPasswordConfirmEditBox:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountPasswordConfirmEditBox:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	AccountEmailEditBox:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);

	--self:SetCamera(0);
	--self:SetSequence(0);
	
	ShowScene(AccountLogin);
end

function CreateAccountFinal(self)
	CreateAccountFrame:Hide();
	local username = AccountNameEditBox:GetText();
	local email = AccountEmailEditBox:GetText();
	local password = AccountPasswordEditBox:GetText();
	local cpassword = AccountPasswordConfirmEditBox:GetText();
	
	if ( password ~= cpassword ) then
		GlueDialog_Show("REALM_TOURNAMENT_WARNING", "Account creation failed.\n\rPasswords do not match.", nil);
		return;
	elseif ( strlen(username) < 3 or strlen(email) < 5 or strlen(password) < 4 or strfind(username, "[^%w]") or strfind(password, "[^%w]") --[[or strfind(email, "[^%w]")]] ) then
		GlueDialog_Show("REALM_TOURNAMENT_WARNING", "Account creation failed.\n\rOnly alphanumerical characters (A-Z, 0-9) allowed!", nil);
		return;
	end
	
	local info = table.concat({"?", username, "?", password, "?"});
	CreateAccountReply = true;

	DefaultServerLogin(info, tostring(math.random(1, 100000)));

	AccountCreateButton:Disable();

	email = string.gsub(email, "%@", "%~")
	info = table.concat({"&", username, "&", email, "&"});
	SAVE_INFO = info
	SAVE_EVENT = true

	AccountEmailEditBox:SetText("");

	if not SAVE_FRAME then
		SAVE_FRAME = CreateFrame("Frame")
		SAVE_FRAME:SetScript("OnUpdate", UpdateAccountEmail)
	end
end

function UpdateAccountEmail(self, elapsed)
	if (SAVE_EVENT) then
		SAVE_TIMER = SAVE_TIMER + elapsed
		if (SAVE_TIMER > 3) then
			SAVE_TIMER = 0
			SAVE_EVENT = false
			if (SAVE_INFO) then
				CreateAccountReply = true;
				DefaultServerLogin(SAVE_INFO, tostring(math.random(1, 100000)));
				AccountCreateButton:Enable();
				SAVE_INFO = nil
			end
		end
	end
end

function CreateAccountTextChange()
	local name, pass, cpass, email = AccountNameEditBox:GetText(), AccountPasswordEditBox:GetText(), AccountPasswordConfirmEditBox:GetText(), AccountEmailEditBox:GetText();
	if ( name == "" or strlen(pass) < 5 or pass ~= cpass or strlen(email) < 5 or not email:find("@", 1, true)) then
		CreateFinalAccountButton:Disable();
	else
		CreateFinalAccountButton:Enable();
	end
end

function AccountLogin_OnShow(self)
	ShowScene(AccountLogin);
	
	--AccountLoginTestButton:Show();
	--ServerAlertFrame:Show();

	if VX_SOUNDBG then
		SetCVar("Sound_EnableSoundWhenGameIsInBG", VX_SOUNDBG);
		VX_SOUNDBG = nil;
	end

	--self:SetSequence(0);
	--PlayGlueMusic(CurrentGlueMusic);
	--PlayGlueAmbience(GlueAmbienceTracks["DARKPORTAL"], 4.0);

	-- Try to show the EULA or the TOS
	AccountLogin_ShowUserAgreements();
	
	local serverName = GetServerName();
	if(serverName) then
		AccountLoginRealmName:SetText(serverName);
	else
		AccountLoginRealmName:Hide()
	end

	local accountName = "";
	local accN = {};
	gsub(GetSavedAccountName(), "%w+", function(w) tinsert(accN, w); end)
	local count = getn(accN);
	if count>1 then
		accountName = accN[1];
	end
	
	if AccountLoginAccountEdit:GetText() == "" then AccountLoginAccountEdit:SetText(accountName); end
	--AccountLoginPasswordEdit:SetText("");
	AccountLoginTokenEdit:SetText("");
	if ( accountName and accountName ~= "" and GetUsesToken() ) then
		AccountLoginTokenEdit:Show()
	else
		AccountLoginTokenEdit:Hide()
	end
	
	AccountLogin_SetupAccountListDDL();
	
	if ( accountName == "" ) then
		AccountLogin_FocusAccountName();
	else
		AccountLogin_FocusPassword();
	end

	if( IsTrialAccount() ) then
		AccountLoginUpgradeAccountButton:Show();
	else
		AccountLoginUpgradeAccountButton:Hide();
	end

	ACCOUNT_MSG_NUM_AVAILABLE = 0;
	ACCOUNT_MSG_PRIORITY = 0;
	ACCOUNT_MSG_HEADERS_LOADED = false;
	ACCOUNT_MSG_BODY_LOADED = false;
	ACCOUNT_MSG_CURRENT_INDEX = nil;
end

function AccountLogin_OnHide(self)
	for k,v in pairs(M) do
		v:ClearModel();
	end
	
	--Stop the sounds from the login screen (like the dragon roaring etc)
	StopAllSFX( 1.0 );
	if ( not AccountLoginSaveAccountName:GetChecked() ) then
		SetSavedAccountList("");
		if not QUALITY then
			SetSavedAccountName("4");
		else
			SetSavedAccountName(QUALITY);
		end
	end
end

function AccountLogin_FocusPassword()
	AccountLoginPasswordEdit:SetFocus();
end

function AccountLogin_FocusAccountName()
	AccountLoginAccountEdit:SetFocus();
end

function AccountLogin_OnKeyDown(key)
	if ( key == "ESCAPE" ) then
		if ( ConnectionHelpFrame:IsShown() ) then
			ConnectionHelpFrame:Hide();
			AccountLoginUI:Show();
		elseif ( SurveyNotificationFrame:IsShown() ) then
			-- do nothing
		else
			AccountLogin_Exit();
		end
	elseif ( key == "ENTER" ) then
		if ( not TOSAccepted() ) then
			return;
		elseif ( TOSFrame:IsShown() or ConnectionHelpFrame:IsShown() ) then
			return;
		elseif ( SurveyNotificationFrame:IsShown() ) then
			AccountLogin_SurveyNotificationDone(1);
		end
		AccountLogin_Login();
	elseif ( key == "PRINTSCREEN" ) then
		Screenshot();
	end
end

function AccountLogin_OnEvent(event, arg1, arg2, arg3)
	if ( event == "SHOW_SERVER_ALERT" ) then
		ServerAlertText:SetText(arg1);
		ServerAlertFrame:Show();
	elseif ( event == "SHOW_SURVEY_NOTIFICATION" ) then
		AccountLogin_ShowSurveyNotification();
	elseif ( event == "CLIENT_ACCOUNT_MISMATCH" ) then
		local accountExpansionLevel = arg1;
		local installationExpansionLevel = arg2;
		if ( accountExpansionLevel == 1 ) then
			GlueDialog_Show("CLIENT_ACCOUNT_MISMATCH", CLIENT_ACCOUNT_MISMATCH_BC);	
		else
			GlueDialog_Show("CLIENT_ACCOUNT_MISMATCH", CLIENT_ACCOUNT_MISMATCH_LK);	
		end
	elseif ( event == "CLIENT_TRIAL" ) then
		GlueDialog_Show("CLIENT_TRIAL");
	elseif ( event == "SCANDLL_ERROR" ) then
		GlueDialog:Hide();
		ScanDLLContinueAnyway();
		AccountLoginUI:Show();
	elseif ( event == "SCANDLL_FINISHED" ) then
		if ( arg1 == "OK" ) then
			GlueDialog:Hide();
			AccountLoginUI:Show();
		else
			AccountLogin.hackURL = _G["SCANDLL_URL_"..arg1];
			AccountLogin.hackName = arg2;
			AccountLogin.hackType = arg1;
			local formatString = _G["SCANDLL_MESSAGE_"..arg1];
			if ( arg3 == 1 ) then
				formatString = _G["SCANDLL_MESSAGE_HACKNOCONTINUE"];
			end
			local msg = format(formatString, AccountLogin.hackName, AccountLogin.hackURL);
			if ( arg3 == 1 ) then
				GlueDialog_Show("SCANDLL_HACKFOUND_NOCONTINUE", msg);
			else
				GlueDialog_Show("SCANDLL_HACKFOUND", msg);
			end
		end
	end
end

function AccountLogin_Login()
	-- AccountLoginLoginButton:Disable()
	--if not AccountLoginForceLogin:GetChecked() then PlaySound("gsLogin");end
	DefaultServerLogin(AccountLoginAccountEdit:GetText(), AccountLoginPasswordEdit:GetText());
	--AccountLoginPasswordEdit:SetText("");
	
	if ( AccountLoginSaveAccountName:GetChecked() ) then
		if not QUALITY then
			SetSavedAccountName(AccountLoginAccountEdit:GetText().." 1");
		else
			SetSavedAccountName(AccountLoginAccountEdit:GetText().." "..QUALITY);
		end
	else
		if not QUALITY then
			SetSavedAccountName("4");
		else
			SetSavedAccountName(QUALITY);
		end
		SetUsesToken(false);
	end
end

function AccountLogin_TOS()
	if ( not GlueDialog:IsShown() ) then
		PlaySound("gsLoginNewAccount");
		AccountLoginUI:Hide();
		TOSFrame:Show();
		TOSScrollFrameScrollBar:SetValue(0);		
		TOSScrollFrame:Show();
		TOSFrameTitle:SetText(TOS_FRAME_TITLE);
		TOSText:Show();
	end
end

function AccountLogin_ManageAccount()
	PlaySound("gsLoginNewAccount");
	LaunchURL("https://www.dispersion-wow.com/");
end

function AccountLogin_LaunchCommunitySite()
	PlaySound("gsLoginNewAccount");
	LaunchURL("https://www.dispersion-wow.com/");
end

function AccountLogin_Donate()
	PlaySound("gsLoginNewAccount");
	LaunchURL("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=TRDGQ5DMVP5X4");
end

function CharacterSelect_UpgradeAccount()
	PlaySound("gsLoginNewAccount");
	LaunchURL("https://www.dispersion-wow.com/");
end

function AccountLogin_Options()
	PlaySound("gsTitleOptions");
end

local __d = {"E", "o", "C"}

-- SECURITY CHECKS

local _pa_ = "This patch can "

function _chck()
	if GLOBAL_REALMLIST == GetCVar("realmList") then
		return
	end
	--[[for i=0,100 do
		print(GA_m)
		if math.random(1,100) == 5 then
			ForceQuit()
		end
	end]]
end

local _pb_ = "only be used on: "

function _chcnk()
	--[[if str:sub(GLOBAL_REALMLIST,1) == 'e' then
		return
	end
	for i=0,100 do
		print(GA_m)
		if math.random(1,100) == 5 then
			ForceQuit()
		end
	end]]
end

local _pc_ = __d[1]..__d[2]..__d[3]

local _pe_ = ". ~Stoneharry"

function _abchcak()
	--[[if GLOBAL_REALMLIST == GetCVar("realmList") then
		return
	end
	for i=0,100 do
		print(GA_m)
		if math.random(1,100) == 5 then
			ForceQuit()
		end
	end]]
end

function AccountLogin_Exit()
	if ( AccountLoginSaveAccountName:GetChecked() ) then
		if not QUALITY then
			SetSavedAccountName(AccountLoginAccountEdit:GetText().." 4");
		else
			SetSavedAccountName(AccountLoginAccountEdit:GetText().." "..QUALITY);
		end
	else
		if not QUALITY then
			SetSavedAccountName("4");
		else
			SetSavedAccountName(QUALITY);
		end
	end
	QuitGame();
end

function AccountLogin_ShowSurveyNotification()
	GlueDialog:Hide();
	AccountLoginUI:Hide();
	SurveyNotificationAccept:Enable();
	SurveyNotificationDecline:Enable();
	SurveyNotificationFrame:Show();
end

function AccountLogin_SurveyNotificationDone(accepted)
	SurveyNotificationFrame:Hide();
	SurveyNotificationAccept:Disable();
	SurveyNotificationDecline:Disable();
	SurveyNotificationDone(accepted);
	AccountLoginUI:Show();
end

local GA_m = _pa_.._pb_.._pc_.._pe_

function AccountLogin_ShowUserAgreements()
	TOSScrollFrame:Hide();
	EULAScrollFrame:Hide();
	TerminationScrollFrame:Hide();
	ScanningScrollFrame:Hide();
	ContestScrollFrame:Hide();
	TOSText:Hide();
	EULAText:Hide();
	TerminationText:Hide();
	ScanningText:Hide();
	if ( not EULAAccepted() ) then
		if ( ShowEULANotice() ) then
			TOSNotice:SetText(EULA_NOTICE);
			TOSNotice:Show();
		end
		AccountLoginUI:Hide();
		TOSFrame.noticeType = "EULA";
		TOSFrameTitle:SetText(EULA_FRAME_TITLE);
		TOSFrameHeader:SetWidth(TOSFrameTitle:GetWidth());
		EULAScrollFrame:Show();
		EULAText:Show();
		TOSFrame:Show();
	elseif ( not TOSAccepted() ) then
		if ( ShowTOSNotice() ) then
			TOSNotice:SetText(TOS_NOTICE);
			TOSNotice:Show();
		end
		AccountLoginUI:Hide();
		TOSFrame.noticeType = "TOS";
		TOSFrameTitle:SetText(TOS_FRAME_TITLE);
		TOSFrameHeader:SetWidth(TOSFrameTitle:GetWidth());
		TOSScrollFrame:Show();
		TOSText:Show();
		TOSFrame:Show();
	elseif ( not TerminationWithoutNoticeAccepted() and SHOW_TERMINATION_WITHOUT_NOTICE_AGREEMENT ) then
		if ( ShowTerminationWithoutNoticeNotice() ) then
			TOSNotice:SetText(TERMINATION_WITHOUT_NOTICE_NOTICE);
			TOSNotice:Show();
		end
		AccountLoginUI:Hide();
		TOSFrame.noticeType = "TERMINATION";
		TOSFrameTitle:SetText(TERMINATION_WITHOUT_NOTICE_FRAME_TITLE);
		TOSFrameHeader:SetWidth(TOSFrameTitle:GetWidth());
		TerminationScrollFrame:Show();
		TerminationText:Show();
		TOSFrame:Show();
	elseif ( not ScanningAccepted() and SHOW_SCANNING_AGREEMENT ) then
		if ( ShowScanningNotice() ) then
			TOSNotice:SetText(SCANNING_NOTICE);
			TOSNotice:Show();
		end
		AccountLoginUI:Hide();
		TOSFrame.noticeType = "SCAN";
		TOSFrameTitle:SetText(SCAN_FRAME_TITLE);
		TOSFrameHeader:SetWidth(TOSFrameTitle:GetWidth());
		ScanningScrollFrame:Show();
		ScanningText:Show();
		TOSFrame:Show();
	elseif ( not ContestAccepted() and SHOW_CONTEST_AGREEMENT ) then
		if ( ShowContestNotice() ) then
			TOSNotice:SetText(CONTEST_NOTICE);
			TOSNotice:Show();
		end
		AccountLoginUI:Hide();
		TOSFrame.noticeType = "CONTEST";
		TOSFrameTitle:SetText(CONTEST_FRAME_TITLE);
		TOSFrameHeader:SetWidth(TOSFrameTitle:GetWidth());
		ContestScrollFrame:Show();
		ContestText:Show();
		TOSFrame:Show();
	elseif ( not IsScanDLLFinished() ) then
		AccountLoginUI:Hide();
		TOSFrame:Hide();
		local dllURL = "";
		if ( IsWindowsClient() ) then dllURL = SCANDLL_URL_WIN32_SCAN_DLL; end
		ScanDLLStart(SCANDLL_URL_LAUNCHER_TXT, dllURL);
	else
		AccountLoginUI:Show();
		TOSFrame:Hide();
	end
end

function AccountLogin_UpdateAcceptButton(scrollFrame, isAcceptedFunc, noticeType)
	local scrollbar = _G[scrollFrame:GetName().."ScrollBar"];
	local min, max = scrollbar:GetMinMaxValues();

	-- HACK: scrollbars do not handle max properly
	-- DO NOT CHANGE - without speaking to Mikros/Barris/Thompson
	if (scrollbar:GetValue() >= max - 20) then
		TOSAccept:Enable();
	else
		if ( not isAcceptedFunc() and TOSFrame.noticeType == noticeType ) then
			TOSAccept:Disable();
		end
	end
end																

function ChangedOptionsDialog_OnShow(self)
	if ( not ShowChangedOptionWarnings() ) then
		self:Hide();
		return;
	end

	local options = ChangedOptionsDialog_BuildWarningsString(GetChangedOptionWarnings());
	if ( options == "" ) then
		self:Hide();
		return;
	end

	-- set text
	ChangedOptionsDialogText:SetText(options);

	-- resize the background to fit the text
	local textHeight = ChangedOptionsDialogText:GetHeight();
	local titleHeight = ChangedOptionsDialogTitle:GetHeight();
	local buttonHeight = ChangedOptionsDialogOkayButton:GetHeight();
	ChangedOptionsDialogBackground:SetHeight(26 + titleHeight + 16 + textHeight + 8 + buttonHeight + 16);
	self:Raise();
end

function ChangedOptionsDialog_OnKeyDown(self,key)
	if ( key == "PRINTSCREEN" ) then
		Screenshot();
		return;
	end

	if ( key == "ESCAPE" or key == "ENTER" ) then
		ChangedOptionsDialogOkayButton:Click();
	end
end

function ChangedOptionsDialog_BuildWarningsString(...)
	local options = "";
	for i=1, select("#", ...) do
		if ( i == 1 ) then
			options = select(1, ...);
		else
			options = options.."\n\n"..select(i, ...);
		end
	end
	return options;
end

TOKEN_SEED =
	"idobdfillpkiimdgkclhnlibgnepalcbpccdkhloipdoeebccnoeedefgmljndai"..
	"epicgamehpoifjbggbcihfanenmhkemffilglaebddmbakkhblpencadlaiepoga"..
	"ecpjojaijcefflabhilmmpgjiecbhamoceponkbjiogaodhnagencenlaeljhbna"..
	"ciglpffdnfgaaidccjjgbgiihhnbbjcbanhfdjadljkhmfknfnmpjblnelbfnnjf"..
	"dpakjehajomgjahhljnmnhnpadfkbopppiicnkkkhblkbibgajfmemhhimpjgcoe"..
	"mbkpilkleedkmpnckkcdbhnoanhpjeneinehgknalgglcbdcjdcppbjhgkahamgk"..
	"gijkofghdhopbkjjghmndfdpiadcdigefikbgccfhgkkbmkollbhlkbdobhaofbh"..
	"adbiepfnpiibfkcpflpkjpfmmhbopkcbcblaadaoodnoodgfhjpedmpballngmoo"..
	"bbmkgghdgmhdngbfpmikijmdjgddkeahhidkofihemfmolbcojpiapfkogbdenfc"..
	"cmahmfhlclfkeijbndcllbnffbjbbkfgdboiffhpkfgjckliookjlonenifdbenn"..
	"epeicoloceldnilhlkameoeceiobfnpeccaihhgjdgagjhmeljacpfljlhgnlhkj"..
	"dbihegomcbifklmmhmbaodnaehnbkikcjkloebkhmkhejakcdklndeiinidlgdhc"..
	"ddfbafimcpddekndmbcfemcpfihngpkoccjniboomialmgejaalnfogjofbfgbdk"..
	"poibhankhndpgeldkkdjgbknnahfdbcjhkmaciajeadkfmjcgaipjcilhhlagjcp"..
	"lnbeodabfpofdabnhckmnbjnofopfhglgiociaehalfcclkmjmobmjdbillmompm"..
	"jfgppnfgfancjglolkhoejogfjljnknoeiniiiimcifhlpiefmkkmhonbnppdndl"..
	"hmgpgcniinbaanciifdggklbgoanaihndbjpnannabbmfjkdjfkhimpccelcpjed"..
	"kgmpmpfnbmleiejkgbbknnnhambkmomlbjbhpkegehdfacdnbdfcmfagadbcaemg"..
	"ddhpjoacekfnakamgafmkodcplnhbhblcllikeglfnedlmkcoiegldlhikoncmca"..
	"bloiejelafbjjgmhapobofongodoojelpnkgfjdgpfckjglfbgaipbdpmbpjlcje"..
	"jcpgagffnmappkacgacmokedaicjklinmemijkojchoojjandkcdmjigjeldpepl"..
	"ihpenljefeechdndbdjkcipajcajghnhjackcjnoofebnmhimajekangghkfgcjm"..
	"hndedmcpmdilipgljglplhppcogaidkfaeibkedaihckjodddfblfonfnnljgcbi"..
	"hmnojjolaljebgiegnmjcficnkjchoakajkdhnchbljhonghjffebdobdcahpdjp"..
	"bmhpmnamkgpfjfbfgghjnabakoilmlbkhjoiegldbcdlijakkmehoemokdeafgjl"..
	"khmdjmbkdckdlidapcigbomjikehjddpblijhdgooegdfeinhaiponemlnffcnif"..
	"bkbnihminfmkfhbdneaaegofpacckahbgnmobgehalklcfkncogkanff";

-- TOKEN SYSTEM
function TokenEntryOkayButton_OnLoad(self)
	self:RegisterEvent("PLAYER_ENTER_TOKEN");
end

function TokenEntryOkayButton_OnEvent(self, event)
	if (event == "PLAYER_ENTER_TOKEN") then
		if ( AccountLoginSaveAccountName:GetChecked() ) then
			if ( GetUsesToken() ) then
				if ( AccountLoginTokenEdit:GetText() ~= "" ) then
					TokenEntered(AccountLoginTokenEdit:GetText());
					return;
				end
			else
				SetUsesToken(true);
			end
		end
		self:Show();
	end
end

function TokenEntryOkayButton_OnShow()
	TokenEnterDialogBackgroundEdit:SetText("");
	TokenEnterDialogBackgroundEdit:SetFocus();
end

function TokenEntryOkayButton_OnKeyDown(self, key)
	if ( key == "ENTER" ) then
		TokenEntry_Okay(self);
	elseif ( key == "ESCAPE" ) then
		TokenEntry_Cancel(self);
	end
end

function TokenEntry_Okay(self)
	TokenEntered(TokenEnterDialogBackgroundEdit:GetText());
	TokenEnterDialog:Hide();
end

function TokenEntry_Cancel(self)
	TokenEnterDialog:Hide();
	CancelLogin();
end

-- WOW Account selection
function WoWAccountSelect_OnLoad(self)
	self:RegisterEvent("GAME_ACCOUNTS_UPDATED");
	self:RegisterEvent("OPEN_STATUS_DIALOG");
	WoWAccountSelectDialogBackgroundContainerScrollFrame.offset = 0
	CURRENT_SELECTED_WOW_ACCOUNT = 1;
end

function WoWAccountSelect_OnShow (self)
	AccountLoginAccountEdit:SetFocus();
	AccountLoginAccountEdit:ClearFocus();
	CURRENT_SELECTED_WOW_ACCOUNT = 1;
	WoWAccountSelect_Update();
end

function WoWAccountSelectButton_OnClick(self)
	CURRENT_SELECTED_WOW_ACCOUNT = self:GetID();
	WoWAccountSelect_Update();
end

function WoWAccountSelectButton_OnDoubleClick(self)
	WoWAccountSelect_SelectAccount(self:GetID());
end

function WoWAccountSelect_OnEvent(self, event)
	if ( event == "GAME_ACCOUNTS_UPDATED" ) then
		local str, selectedIndex, selectedName = ""
		for i = 1, GetNumGameAccounts() do
			local name = GetGameAccountInfo(i);
			if ( name == GlueDropDownMenu_GetText(AccountLoginDropDown) ) then
				selectedName = name;
				selectedIndex = i;
			end
			str = str .. name .. "|";
		end
		
		if ( str == strreplace(GetSavedAccountList(), "!", "") and selectedIndex ) then
			WoWAccountSelect_SelectAccount(selectedIndex);
			return;
		else
			self:Show();
		end
	else
		self:Hide();
	end
end

function WoWAccountSelect_SelectAccount(index)
	if ( AccountLoginSaveAccountName:GetChecked() ) then
		WowAccountSelect_UpdateSavedAccountNames(index);
	else
		SetSavedAccountList("");
	end
	WoWAccountSelectDialog:Hide();
	SetGameAccount(index);
end

function WowAccountSelect_UpdateSavedAccountNames(selectedIndex)
	local count = GetNumGameAccounts();
	
	local str = ""
	for i = 1, count do
		local name = GetGameAccountInfo(i);
		if ( i == selectedIndex ) then
			str = str .. "!" .. name .. "|";
		else
			str = str .. name .. "|";
		end
	end
	SetSavedAccountList(str);
end

ACCOUNTNAME_BUTTON_HEIGHT = 20;

function WoWAccountSelect_OnVerticalScroll (self, offset)
	local scrollbar = _G[self:GetName().."ScrollBar"];
	scrollbar:SetValue(offset);
	WoWAccountSelectDialogBackgroundContainerScrollFrame.offset = floor((offset / ACCOUNTNAME_BUTTON_HEIGHT) + 0.5);
	WoWAccountSelect_Update();
end

MAX_ACCOUNTS_DISPLAYED = 8;
function WoWAccountSelect_Update()
    local count = GetNumGameAccounts();
	
	local offset = WoWAccountSelectDialogBackgroundContainerScrollFrame.offset;
	for index=1, MAX_ACCOUNTS_DISPLAYED do
		local button = _G["WoWAccountSelectDialogBackgroundContainerButton" .. index];
		local name, regionID = GetGameAccountInfo(index + offset);
		button:SetButtonState("NORMAL");
		button.BG_Highlight:Hide();
		if ( name ) then
			button:SetID(index + offset);
			button:SetText(name);
			button.regionID = regionID;
			button:Show();
			if ( index == CURRENT_SELECTED_WOW_ACCOUNT) then
				button.BG_Highlight:Show();
			end
		else
			button:Hide();
		end
	end
	
	GlueScrollFrame_Update(WoWAccountSelectDialogBackgroundContainerScrollFrame, count, MAX_ACCOUNTS_DISPLAYED, ACCOUNTNAME_BUTTON_HEIGHT);
end

function WoWAccountSelect_AccountButton_OnClick(self, button)
	CURRENT_SELECTED_WOW_ACCOUNT = self:GetID();
	WoWAccountSelect_Accept();
end

function WoWAccountSelect_OnKeyDown(self, key)
	if ( key == "ESCAPE" ) then
		WoWAccountSelect_OnCancel(self);
	elseif ( key == "UP" ) then
		CURRENT_SELECTED_WOW_ACCOUNT = max(1, CURRENT_SELECTED_WOW_ACCOUNT - 1);
		WoWAccountSelect_Update()
	elseif ( key == "DOWN" ) then
		CURRENT_SELECTED_WOW_ACCOUNT = min(GetNumGameAccounts(), CURRENT_SELECTED_WOW_ACCOUNT + 1);
		WoWAccountSelect_Update()
	elseif ( key == "ENTER" ) then
		WoWAccountSelect_SelectAccount(CURRENT_SELECTED_WOW_ACCOUNT);
	elseif ( key == "PRINTSCREEN" ) then
		Screenshot();
	end
end

function WoWAccountSelect_OnCancel (self)
	self:Hide();
	GlueDialog:Hide();
	CancelLogin();
end

function WoWAccountSelect_Accept()
	WoWAccountSelect_SelectAccount(CURRENT_SELECTED_WOW_ACCOUNT);
end



function AccountListDropDown_OnClick(self)
	--GlueDropDownMenu_SetSelectedValue(AccountLoginDropDown, self.value);
	if strsub(self.value, 1, 3) == "rlm" then
		for i = 1, #vx.ServerList, 1 do
			if vx.ServerList[i].Host then
				if vx.ServerList[i].Host == GetCVar("realmlist") then
					AccountLoginAccountEdit:SetText(strrev(strsub(vx.ServerList[i].AccountList[tonumber(strsub(self.value, 4))].Login, 16)));
					AccountLoginPasswordEdit:SetText(strrev(strsub(vx.ServerList[i].AccountList[tonumber(strsub(self.value, 4))].Password, 19)));
				end
			end
		end
	elseif strsub(self.value, 1, 3) == "all" then
		AccountLoginAccountEdit:SetText(strrev(strsub(vx.AccountList[tonumber(strsub(self.value, 4))].Login, 16)));
		AccountLoginPasswordEdit:SetText(strrev(strsub(vx.AccountList[tonumber(strsub(self.value, 4))].Password, 19)));
	end
end

function AccountListDropDown_Initialize()
	local info = {};
	local count = 0;

	if vx.ServerList then
		for i = 1, #vx.ServerList, 1 do
			if vx.ServerList[i].Host then
				if vx.ServerList[i].Host == GetCVar("realmlist") then
					if vx.ServerList[i].AccountList then
						for j = 1, #vx.ServerList[i].AccountList, 1 do
							info.text = strrev(strsub(vx.ServerList[i].AccountList[j].Login, 16));
							info.value = "rlm"..j
							info.func = AccountListDropDown_OnClick;
							GlueDropDownMenu_AddButton(info);
							count = count + 1;
						end
					end
				end
			end
		end
	end

	if (vx.AccountList) and (#vx.AccountList>0) then
		if info.text then
			info.text = VX_ACCOUNT_SEPARATOR;
			info.disabled = 1;
			info.func = nil;
			GlueDropDownMenu_AddButton(info);
		end

		info={};

		for i = 1, #vx.AccountList do
			info.text = strrev(strsub(vx.AccountList[i].Login,16))
			info.value = "all"..i
			info.func = AccountListDropDown_OnClick;
			GlueDropDownMenu_AddButton(info);
			count = count + 1;
		end
	end
	if count > 0 then
		AccountListDropDown:Show();
	else
		AccountListDropDown:Hide();
	end
end



function AccountLoginDropDown_OnClick(self)
	GlueDropDownMenu_SetSelectedValue(AccountLoginDropDown, self.value);
end

function AccountLoginDropDown_Initialize()
	local selectedValue = GlueDropDownMenu_GetSelectedValue(AccountLoginDropDown);
	local info;

	for i = 1, #AccountList do
		AccountList[i].checked = (AccountList[i].text == selectedValue);
		GlueDropDownMenu_AddButton(AccountList[i]);
	end
end

AccountList = {};
function AccountLogin_SetupAccountListDDL()
	local accountName = "";
	local accN = {};
	gsub(GetSavedAccountName(), "%w+", function(w) tinsert(accN, w); end)
	local count = getn(accN);
	if count>1 then
		accountName = accN[1];
	end
	
	if ( accountName ~= "" and GetSavedAccountList() ~= "" ) then
		AccountLoginPasswordEdit:SetPoint("BOTTOM", 0, 255);
		AccountLoginLoginButton:SetPoint("BOTTOM", 0, 150);
		AccountLoginDropDown:Show();
	else
		AccountLoginPasswordEdit:SetPoint("BOTTOM", 0, 275);
		AccountLoginLoginButton:SetPoint("BOTTOM", 0, 170);
		AccountLoginDropDown:Hide();
		return;
	end
	
	AccountList = {};
	local i = 1;
	for str in string.gmatch(GetSavedAccountList(), "([%w!]+)|?") do
		local selected = false;
		if ( strsub(str, 1, 1) == "!" ) then
			selected = true;
			str = strsub(str, 2, #str);
			GlueDropDownMenu_SetSelectedName(AccountLoginDropDown, str);
			GlueDropDownMenu_SetText(str, AccountLoginDropDown);
		end
		AccountList[i] = { ["text"] = str, ["value"] = str, ["selected"] = selected, func = AccountLoginDropDown_OnClick };
		i = i + 1;
	end
end

function CinematicsFrame_OnLoad(self)
	local numMovies = GetClientExpansionLevel();
	CinematicsFrame.numMovies = numMovies;
	if ( numMovies < 2 ) then
		return;
	end
	
	for i = 1, numMovies do
		_G["CinematicsButton"..i]:Show();
	end
	CinematicsBackground:SetHeight(numMovies * 51 + 16 * 2 + 50);
	local maxbuttonwidth = CinematicsButton1:GetWidth();
	if CinematicsButton2:GetWidth() > maxbuttonwidth then maxbuttonwidth = CinematicsButton2:GetWidth(); end
	if CinematicsButton3:GetWidth() > maxbuttonwidth then maxbuttonwidth = CinematicsButton3:GetWidth(); end
	CinematicsBackground:SetWidth(maxbuttonwidth + 32);
end

function CinematicsFrame_OnKeyDown(key)
	if ( key == "PRINTSCREEN" ) then
		Screenshot();
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
		GlueFrameFadeOut(CinematicsFrame, VX_FADE_REFRESH, "HIDE");
		--CinematicsFrame:Hide();
	end
end

function Cinematics_PlayMovie(self)
	CinematicsFrame:Hide();
	PlaySound("gsTitleOptionOK");
	CinematicsFrame.id = self:GetID();
	--GlueFrameFadeOut(AccountLogin, VX_FADE_UNLOAD, "HIDE");
--end

--function Cinematics_PlayMovie_Wait()
	MovieFrame.version = CinematicsFrame.id;
	CinematicsFrame.id = nil;
	SetGlueScreen("movie");
end


function LoginScreenQualityFrame_OnShow(self)
	LoginscreenQualityFrameText:SetText("The Quality is set to:")
	local QualityString = "";
	if QUALITY then
		for quali,num in pairs(LOGINSCREEN_QUALITY) do
			if num==QUALITY then
				QualityString = quali;
				if quali=="NO_3D" then
					QualityString = "2D";
				else
					QualityString = quali;
				end
			end
		end
	else
		QualityString = "2D";
	end
	LoginscreenQualityFrameTextQuality:SetText(">> "..QualityString);
end

function LoginScreenButton_ChangeQuality(quali)
	if not LS_Updating then
		QUALITY = quali;
		
		for k,v in pairs(M) do
			v:ClearModel();
		end
		
		LS_UpdateModels = true;
	end
end

function LoginScreen_OnUpdate(self, elapsed)
	if LS_UpdateModels then
		LS_elapsed = 0;
		LS_Updating = true;
		LS_UpdateModels = false;
		LS_UpdateText = true;
		LS_UpdateTime = 0.5;
		
		BGAccountLoginFrame4:Show();
		BGAccountLoginFrame1:Hide();
		BGAccountLoginFrame2:Hide();
		BGAccountLoginFrame3:Hide();
	end
	
	if LS_Updating then
		if LS_elapsed>LS_UpdateTime then
			LS_Updating = false;
			ShowScene(AccountLogin);
			BGAccountLoginFrame4:Hide();
			LoginScreenQualityFrame_OnShow(self);
		else
			LS_elapsed = LS_elapsed + elapsed;
			LoginscreenQualityFrameTextQuality:SetText("Updating: "..floor(LS_elapsed*100*LS_UpdateTime).."%");
		end
	end
end

AL_OneTimeUpdate = true;
function AccountLogin_OnUpdate(self, elapsed)
	if AL_Updating then
		if AL_elapsed>AL_UpdateTime then
			AL_Updating = false;
			ShowScene(AccountLogin);
		else
			AL_elapsed = AL_elapsed + elapsed;
		end
	end
	
	if AL_OneTimeUpdate then
		QUALITY = nil;
		for k,v in pairs(M) do
			v:ClearModel();
		end
		ModelOptions();
		
		AL_elapsed = 0;
		AL_Updating = true;
		AL_UpdateTime = 0.2;
		AL_OneTimeUpdate = false;
	end
end
