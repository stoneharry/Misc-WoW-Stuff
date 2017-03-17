
LOGINSCREEN_QUALITY = {
NO_3D = 1,
LOW = 2,
MEDIUM = 3,
HIGH = 4,
ULTRA = 5};

M = {};
function ModelOptions()
	if not QUALITY then
		local accName = GetSavedAccountName();
		if strlen(accName)==1 then
			QUALITY = tonumber(accName);
		else
			local quali = {};
			gsub(GetSavedAccountName(), "%w+", function(w) tinsert(quali, w); end);
			local count = getn(quali);
			if count>1 then
				QUALITY = tonumber(quali[count]);
			else
				if quali[1] then
					if strlen(quali[1])==1 then
						QUALITY = tonumber(quali[1]);
					else
						QUALITY = 4;
					end
				else
					QUALITY = 4;
				end
			end
		end
	end
	
	if QUALITY>LOGINSCREEN_QUALITY.ULTRA then
		QUALITY = 5;
	elseif QUALITY<LOGINSCREEN_QUALITY.NO_3D then
		QUALITY = 1;
	end
end

QUALITY = 5;
M[1] = CreateFrame("Model"); M[1]:SetCamera(0); M[1]:SetPoint("BOTTOMLEFT",0,0); M[1]:SetFrameStrata("HIGH"); M[1]:SetFrameLevel(3); local x,y,z = M[1]:GetPosition(); M[1]:SetWidth(10000); M[1]:SetHeight(5500); M[1]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,0.9,0.8,1.0,1.0,1.0,0.8); M[1]:SetPosition(x,y-0.36,z+1.66); M[1]:SetFacing(M[1]:GetFacing()+0.8); M[1]:SetModelScale(M[1]:GetModelScale()*0.07);
M[2] = CreateFrame("Model"); M[2]:SetCamera(0); M[2]:SetPoint("CENTER",0,0); M[2]:SetFrameStrata("MEDIUM"); M[2]:SetFrameLevel(2); local x,y,z = M[2]:GetPosition(); M[2]:SetWidth(10000); M[2]:SetHeight(5500); M[2]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[2]:SetPosition(x,y+0.35,z+7.5); M[2]:SetFacing(M[2]:GetFacing()-0.1); M[2]:SetModelScale(M[2]:GetModelScale()*0.05);
M[3] = CreateFrame("Model"); M[3]:SetCamera(0); M[3]:SetPoint("BOTTOMLEFT",0,0); M[3]:SetFrameStrata("HIGH"); M[3]:SetFrameLevel(3); local x,y,z = M[3]:GetPosition(); M[3]:SetWidth(10000); M[3]:SetHeight(5500); M[3]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[3]:SetPosition(x+3.7,y+2.6,z); M[3]:SetFacing(M[3]:GetFacing()-1.5); M[3]:SetModelScale(M[3]:GetModelScale()*0.264);
M[4] = CreateFrame("Model"); M[4]:SetCamera(0); M[4]:SetPoint("CENTER",0,0); M[4]:SetFrameStrata("MEDIUM"); M[4]:SetFrameLevel(2); local x,y,z = M[4]:GetPosition(); M[4]:SetWidth(10000); M[4]:SetHeight(5500); M[4]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[4]:SetPosition(x,y+0.45,z+7.57); M[4]:SetFacing(M[4]:GetFacing()-0.5); M[4]:SetModelScale(M[4]:GetModelScale()*0.045);
M[5] = CreateFrame("Model"); M[5]:SetCamera(0); M[5]:SetPoint("TOPLEFT",0,0); M[5]:SetFrameStrata("HIGH"); M[5]:SetFrameLevel(3); local x,y,z = M[5]:GetPosition(); M[5]:SetWidth(1000); M[5]:SetHeight(430); M[5]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[5]:SetPosition(x+0.24,y-0.005,z); M[5]:SetFacing(M[5]:GetFacing()+2); M[5]:SetModelScale(M[5]:GetModelScale()*0.015);
M[6] = CreateFrame("Model"); M[6]:SetCamera(0); M[6]:SetPoint("TOPLEFT",0,0); M[6]:SetFrameStrata("HIGH"); M[6]:SetFrameLevel(3); local x,y,z = M[6]:GetPosition(); M[6]:SetWidth(1000); M[6]:SetHeight(417); M[6]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[6]:SetPosition(x+0.4,y-0.005,z); M[6]:SetFacing(M[6]:GetFacing()+2); M[6]:SetModelScale(M[6]:GetModelScale()*0.012);
M[7] = CreateFrame("Model"); M[7]:SetCamera(0); M[7]:SetPoint("BOTTOMLEFT",0,0); M[7]:SetFrameStrata("HIGH"); M[7]:SetFrameLevel(3); local x,y,z = M[7]:GetPosition(); M[7]:SetWidth(10000); M[7]:SetHeight(5500); M[7]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,0.9,0.8,1.0,1.0,1.0,0.8); M[7]:SetPosition(x,y-0.55,z+1.45); M[7]:SetFacing(M[7]:GetFacing()-2.8); M[7]:SetModelScale(M[7]:GetModelScale()*0.13);
M[8] = CreateFrame("Model"); M[8]:SetCamera(0); M[8]:SetPoint("BOTTOMLEFT",0,0); M[8]:SetFrameStrata("HIGH"); M[8]:SetFrameLevel(3); local x,y,z = M[8]:GetPosition(); M[8]:SetWidth(10000); M[8]:SetHeight(5500); M[8]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,0.9,0.8,1.0,1.0,1.0,0.8); M[8]:SetPosition(x,y+0.33,z+1.73); M[8]:SetFacing(M[8]:GetFacing()-1.1); M[8]:SetModelScale(M[8]:GetModelScale()*0.04);
M[9] = CreateFrame("Model"); M[9]:SetCamera(0); M[9]:SetPoint("BOTTOMLEFT",0,0); M[9]:SetFrameStrata("HIGH"); M[9]:SetFrameLevel(3); local x,y,z = M[9]:GetPosition(); M[9]:SetWidth(10000); M[9]:SetHeight(5500); M[9]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,0.9,0.8,1.0,1.0,1.0,0.8); M[9]:SetPosition(x,y+0.2,z+1.665); M[9]:SetFacing(M[9]:GetFacing()-1.8); M[9]:SetModelScale(M[9]:GetModelScale()*0.06);
M[10] = CreateFrame("Model"); M[10]:SetCamera(0); M[10]:SetPoint("BOTTOMLEFT",0,0); M[10]:SetFrameStrata("HIGH"); M[10]:SetFrameLevel(3); local x,y,z = M[10]:GetPosition(); M[10]:SetWidth(10000); M[10]:SetHeight(5500); M[10]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,0.9,0.8,1.0,1.0,1.0,0.8); M[10]:SetPosition(x,y+0.09,z+1.7); M[10]:SetFacing(M[10]:GetFacing()-0.8); M[10]:SetModelScale(M[10]:GetModelScale()*0.045);
M[11] = CreateFrame("Model"); M[11]:SetCamera(0); M[11]:SetPoint("BOTTOMLEFT",0,0); M[11]:SetFrameStrata("HIGH"); M[11]:SetFrameLevel(3); local x,y,z = M[11]:GetPosition(); M[11]:SetWidth(10000); M[11]:SetHeight(5500); M[11]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[11]:SetPosition(x+4.5,y+2.5,z); M[11]:SetAlpha(M[11]:GetAlpha()/2);
M[12] = CreateFrame("Model"); M[12]:SetCamera(0); M[12]:SetPoint("BOTTOMLEFT",0,0); M[12]:SetFrameStrata("HIGH"); M[12]:SetFrameLevel(3); local x,y,z = M[12]:GetPosition(); M[12]:SetWidth(10000); M[12]:SetHeight(5500); M[12]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[12]:SetPosition(x+1.4,y+3.5,z); M[12]:SetModelScale(M[12]:GetModelScale()*0.75); M[12]:SetAlpha(M[12]:GetAlpha()/2);
M[13] = CreateFrame("Model"); M[13]:SetCamera(0); M[13]:SetPoint("BOTTOMLEFT",0,0); M[13]:SetFrameStrata("HIGH"); M[13]:SetFrameLevel(3); M[13]:SetWidth(10000); M[13]:SetHeight(5500); M[13]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[13]:SetModelScale(M[13]:GetModelScale()*0.1);
M[14] = CreateFrame("Model"); M[14]:SetCamera(0); M[14]:SetPoint("BOTTOMLEFT",0,0); M[14]:SetFrameStrata("HIGH"); M[14]:SetFrameLevel(3); local x,y,z = M[14]:GetPosition(); M[14]:SetWidth(10000); M[14]:SetHeight(5500); M[14]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[14]:SetPosition(x+7,y,z); M[14]:SetModelScale(M[14]:GetModelScale()*0.1);
M[15] = CreateFrame("Model"); M[15]:SetCamera(0); M[15]:SetPoint("BOTTOMLEFT",0,0); M[15]:SetFrameStrata("HIGH"); M[15]:SetFrameLevel(3); local x,y,z = M[15]:GetPosition(); M[15]:SetWidth(10000); M[15]:SetHeight(5500); M[15]:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8); M[15]:SetPosition(x+3.5,y+1,z); M[15]:SetModelScale(M[15]:GetModelScale()*0.08);

function ShowScene(self)
	if not VS_ONMUSIC then
		PlayGlueAmbience("GlueScreenUndead", 4.0);
		PlayLoginMusic();
	end
	
	if QUALITY > LOGINSCREEN_QUALITY.NO_3D then
		PlayBackgroundModels();
		BGAccountLoginFrame1:Show();
		BGAccountLoginFrame2:Show();
		BGAccountLoginFrame3:Hide();
	else
		BGAccountLoginFrame1:Hide();
		BGAccountLoginFrame2:Hide();
		BGAccountLoginFrame3:Show();
	end
end

function PlayLoginMusic()
	if VX_ONMUSIC then return; end
	StopGlueMusic();

	VX_MUSICTIMER = GetTime() + 500;
	VX_ONMUSIC = true;
	PlayMusic("Interface\\LoginMusic\\LoginScreen.wav");
end

function StopLoginMusic()
	StopMusic();
	StopGlueMusic();
	VX_ONMUSIC = nil;
	VX_MUSICTIMER = nil;
end

function PlayBackgroundModels()
	if QUALITY >= LOGINSCREEN_QUALITY.LOW then
		if M[1] then 		M[1]:SetModel("Creature\\TuskarrMaleFisherman\\TuskarrMaleFisherman.M2"); 									end
		if M[2] then 		M[2]:SetModel("Creature\\Tuskarkite\\ud_ts_kite.m2"); 														end
		if M[3] then		M[3]:SetModel("World\\Expansion02\\Doodads\\BoreanTundra\\StoneFlags\\Borean_Flags_02.m2"); 				end
	end
	
	if QUALITY >= LOGINSCREEN_QUALITY.MEDIUM then
		if M[4] then 		M[4]:SetModel("Creature\\Tuskarkite\\ud_ts_kite.m2"); 														end
		if M[5] then 		M[5]:SetModel("World\\Expansion02\\Doodads\\Generic\\TUSKARR\\IncenseBurner\\ts_incenseburner_01.m2"); 		end
		if M[6] then 		M[6]:SetModel("World\\Expansion02\\Doodads\\Generic\\TUSKARR\\IncenseBurner\\ts_incenseburner_01.m2");		end
	end
		
	if QUALITY >= LOGINSCREEN_QUALITY.HIGH then
		if M[7] then 		M[7]:SetModel("Creature\\TuskarrMaleFisherman\\TuskarrMaleFisherman.M2"); 									end
		if M[8] then 		M[8]:SetModel("Creature\\TuskarrMaleFisherman\\TuskarrMaleFisherman.M2"); 									end
		if M[9] then 		M[9]:SetModel("Creature\\TuskarrMaleFisherman\\TuskarrMaleFisherman.M2"); 									end
		if M[10] then 		M[10]:SetModel("Creature\\TuskarrMaleFisherman\\TuskarrMaleFisherman.M2"); 									end
	end
		
	if QUALITY >= LOGINSCREEN_QUALITY.ULTRA then	
		if M[11] then 		M[11]:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2"); 					end
		if M[12] then 		M[12]:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2"); 					end
		if M[13] then 		M[13]:SetModel("World\\Expansion02\\Doodads\\HOWLINGFJORD\\Fog\\HFjord_Fog_01.m2"); 						end
		if M[14] then 		M[14]:SetModel("World\\Expansion02\\Doodads\\HOWLINGFJORD\\Fog\\HFjord_Fog_01.m2"); 						end
		if M[15] then 		M[15]:SetModel("World\\Expansion02\\Doodads\\HOWLINGFJORD\\Fog\\HFjord_Fog_01.m2");							end
	end

	if (EXPECTED_CLIENT_VERSION ~= tonumber(INTERNAL_CLIENT_VERSION)) then
		GlueDialog_Show("CLIENT_RESTART_ALERT", "Warning: You are using an out of date 'Wow.exe'. Please update. You have version "..tostring(INTERNAL_CLIENT_VERSION).." version expected is "..tostring(EXPECTED_CLIENT_VERSION)..".")
	end
end



