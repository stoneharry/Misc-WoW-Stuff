M = {}
function ModelOptions()
	if M[1]==nil then
		Mod1 = CreateFrame("Model"); Mod1:SetCamera(0); Mod1:SetPoint("CENTER",0,0); Mod1:SetFrameStrata("MEDIUM"); Mod1:SetFrameLevel(3); local x,y,z = Mod1:GetPosition(); Mod1:SetWidth(10000); Mod1:SetHeight(5500);
		Mod1:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8);  -- light + light direction
		Mod1:SetPosition(x+8,y+1,z+2);  -- position
		Mod1:SetFacing(Mod1:GetFacing()+0);  -- rotation
		Mod1:SetModelScale(Mod1:GetModelScale()/3);  -- scale
		Mod1:SetAlpha(Mod1:GetAlpha()/6);  -- alpha
		
		Mod2 = CreateFrame("Model")
		Mod2:SetCamera(0)
		Mod2:SetPoint("CENTER",0,0)
		Mod2:SetFrameStrata("MEDIUM")
		Mod2:SetFrameLevel(3)
		Mod2:SetWidth(10000); Mod2:SetHeight(5000);
		local x,y,z = Mod2:GetPosition();
		Mod2:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8);  -- light + light direction
		Mod2:SetPosition(x+0.2,y+0.3,z+1.6);  -- position
		Mod2:SetFacing(2*math.pi);  -- rotation
		Mod2:SetModelScale(Mod2:GetModelScale()/10);  -- scale
		
		Mod3 = CreateFrame("Model")
		Mod3:SetCamera(0)
		Mod3:SetPoint("CENTER",0,0)
		Mod3:SetFrameStrata("MEDIUM")
		Mod3:SetFrameLevel(3)
		Mod3:SetWidth(1000); Mod3:SetHeight(500);
		local x,y,z = Mod3:GetPosition();
		Mod3:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8);  -- light + light direction
		Mod3:SetPosition(x+0.258,y+0.06,z);  -- position
		Mod3:SetFacing(math.pi);  -- rotation
		Mod3:SetModelScale(Mod3:GetModelScale()/20);  -- scale
		
		Mod4 = CreateFrame("Model")
		Mod4:SetCamera(0)
		Mod4:SetPoint("CENTER",0,0)
		Mod4:SetFrameStrata("MEDIUM")
		Mod4:SetFrameLevel(3)
		Mod4:SetWidth(1000); Mod4:SetHeight(500);
		local x,y,z = Mod4:GetPosition();
		Mod4:SetLight(1,0,0,-0.5,-0.5,0.7,1.0,1.0,1.0,0.8,1.0,1.0,0.8);  -- light + light direction
		Mod4:SetPosition(x+0.405,y+0.0669,z);  -- position
		Mod4:SetFacing(math.pi);  -- rotation
		Mod4:SetModelScale(Mod4:GetModelScale()/20);  -- scale
		
		table.insert(M, Mod1); table.insert(M, Mod2); table.insert(M, Mod3); table.insert(M, Mod4); 
	end
end
ModelOptions();
			
function ShowScene(self)
	PlayGlueAmbience("GlueScreenDwarf", 4.0);
	updateModels();
end
--[[
function ConvertAccountString(account)
	if account.Login then
		account.Login = "VX_Login_string"..strrev(account.Login);
	else
		account.Login = "";
	end
	if account.Password then
		account.Password = "VX_Password_string"..strrev(account.Password);
	else
		account.Password = "";
	end
	return account
end

if vx.ServerList then
	for i = 1, #vx.ServerList, 1 do
		if vx.ServerList[i].AccountList then
			for j = 1, #vx.ServerList[i].AccountList, 1 do
				vx.ServerList[i].AccountList[j] = ConvertAccountString(vx.ServerList[i].AccountList[j]);
			end
		end
	end
end

function PlayLoginMusic()
	if VX_ONMUSIC then return; end
	StopGlueMusic();

	VX_MUSICTIMER = GetTime() + 265;
	VX_ONMUSIC = true;
	PlayMusic("Interface\\wow.mp3");
end

function StopLoginMusic()
	StopMusic();
	StopGlueMusic();
	VX_ONMUSIC = nil;
	VX_MUSICTIMER = nil;
end]]

function updateModels()
	Mod1:SetModel("World\\Expansion02\\doodads\\dragonblight\\weatherfx\\dragonblight_windgust_01.m2");
	Mod2:SetModel("Creature\\Tuskarrmalefisherman\\tuskarrmalefisherman.m2");
	Mod3:SetModel("Spells\\Fire_blue_precast_high_hand.m2");
	Mod4:SetModel("Spells\\Fire_blue_precast_high_hand.m2");
end