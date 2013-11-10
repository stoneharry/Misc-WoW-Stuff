 local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074 
local UNIT_FLAG_STUNNED = 0x00040000

local UNIT_FIELD_CHARMEDBY = OBJECT_END + 0x0006
local UNIT_FIELD_CHARM = OBJECT_END + 0x0000
local UNIT_FLAG_PVP_ATTACKABLE = 0x00000008
local UNIT_FLAG_PLAYER_CONTROLLED_CREATURE = 0x01000000
local UNIT_END = OBJECT_END + 0x008E
local PLAYER_DUEL_TEAM = UNIT_END + 0x0008
local PLAYER_DUEL_ARBITER = UNIT_END + 0x0000
local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3
 
 function DeadminesPortal_Spawn(pUnit,Event)
 	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("DeadminesPortal_Entry",500,0) 
  end
  
  RegisterUnitEvent(91998, 18, "DeadminesPortal_Spawn")
  
   function WailingCavernsPortal_Spawn(pUnit,Event)
   	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("WailingCavernsPortal_Entry",500,0) 
  end
  
  RegisterUnitEvent(315190, 18, "WailingCavernsPortal_Spawn")
  
  
function DeadminesPortal_Entry(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
plr:Teleport(574, 154.76,-85.53,12.55)
end
end
end

  
 function WailingCavernsPortal_Entry(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
if plr:GetPlayerLevel() > 14 then
plr:Teleport(43, -163.49,132.9,-73.66)
elseif plr:GetPlayerLevel() < 15 then
plr:SendBroadcastMessage("|cffffff00You must be atleast level 15 to enter.|r")
end
end
end
end


   function BAELMODANPortal_Spawn(pUnit,Event)
   	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("BAELMODANEntry",500,0) 
  end
  
  RegisterUnitEvent(87190, 18, "BAELMODANPortal_Spawn")
  
  
function BAELMODANEntry(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
if plr:GetPlayerLevel() > 16 then
plr:Teleport(624, -341.91,-103.82,104.20)
elseif plr:GetPlayerLevel() < 17 then
plr:SendBroadcastMessage("|cffffff00You must be atleast level 17 to enter.|r")
end
if plr:IsInGroup() == false then
plr:SendBroadcastMessage("|cffffff00You must be in a Raid Group to enter.|r")
elseif plr:GetGroupType() ~= 1 then
plr:SendBroadcastMessage("|cffffff00You must be in a Raid Group to enter.|r")
end
end
end
end

   function BAELMODANLPortal_Spawn(pUnit,Event)
   	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("BAELMODANL_Entry",500,0) 
  end
  
  RegisterUnitEvent(87191, 18, "BAELMODANLPortal_Spawn")
  
  
function BAELMODANL_Entry(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
if plr:GetPlayerLevel() > 16 then
plr:Teleport(1, -6107.64,-1250.88,-143.27)
elseif plr:GetPlayerLevel() < 17 then
plr:SendBroadcastMessage("|cffffff00You must be atleast level 17 to enter.|r")
end
end
end
end


  function BAELMODANWAYPortal_Spawn(pUnit,Event)
  	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("BAELMODANWAY_Entry",500,0) 
  end
  
  RegisterUnitEvent(87192, 18, "BAELMODANWAYPortal_Spawn")
  
  
function BAELMODANWAY_Entry(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
if plr:GetPlayerLevel() > 16 then
plr:Teleport(0, -7493.80,-1230.94,477.42)
elseif plr:GetPlayerLevel() < 17 then
plr:SendBroadcastMessage("|cffffff00You must be atleast level 17 to enter.|r")
end
end
end
end


function GUNDRAK_Entry(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
if plr:GetPlayerLevel() > 17 then
plr:Teleport(571, 6963.32,-4410.30,446.29)
elseif plr:GetPlayerLevel() < 18 then
plr:SendBroadcastMessage("|cffffff00You must be atleast level 18 to enter.|r")
end
end
end
end

   function GUNDRAKLPortal_Spawn(pUnit,Event)
   	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("GUNDRAK_Entry",500,0) 
  end
  
  RegisterUnitEvent(276692, 18, "GUNDRAKLPortal_Spawn")
  
  
    function BLACKWINGPortal_Spawn(pUnit,Event)
		pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("BLACKWINGEntry",500,0) 
  end
  
  RegisterUnitEvent(62190, 18, "BLACKWINGPortal_Spawn")
  
  
function BLACKWINGEntry(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
if plr:GetPlayerLevel() > 16 then
plr:Teleport(469, -7481.29,-1145.82,476.53)
elseif plr:GetPlayerLevel() < 17 then
plr:SendBroadcastMessage("|cffffff00You must be atleast level 17 to enter.|r")
end
if plr:IsInGroup() == false then
plr:SendBroadcastMessage("|cffffff00You must be in a Raid Group to enter.|r")
elseif plr:GetGroupType() ~= 1 then
plr:SendBroadcastMessage("|cffffff00You must be in a Raid Group to enter.|r")
end
end
end
end

   function BLACKWINGLPortal_Spawn(pUnit,Event)
   	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("BLACKWINGL_Entry",500,0) 
  end
  
  RegisterUnitEvent(62191, 18, "BLACKWINGLPortal_Spawn")
  
  
function BLACKWINGL_Entry(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
if plr:GetPlayerLevel() > 16 then
plr:Teleport(0,-7477.05,-1175.99,477.42)
elseif plr:GetPlayerLevel() < 17 then
plr:SendBroadcastMessage("|cffffff00You must be atleast level 17 to enter.|r")
end
end
end
end
  

  
  

  

  
  
function Firegut_Entry(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
if plr:HasQuest(44071) then
plr:Teleport(249, 28.98,-71.91,-8.56)
else
plr:SendBroadcastMessage("|cffffff00You must have the quest 'Firegut Hideout' to enter.|r")
end
end
end
end

   function FiregutPortal_Spawn(pUnit,Event)
   	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("Firegut_Entry",500,0) 
  end
  
  RegisterUnitEvent(97431, 18, "FiregutPortal_Spawn")
  
  function Firegut_Ext(pUnit,Event)
local plr = pUnit:GetClosestPlayer()
if plr ~= nil then
if pUnit:GetDistanceYards(plr) < 3 then
plr:Teleport(0, -6871.18,-1593.75,188.62)
end
end
end

   function FiregutxPortal_Spawn(pUnit,Event)
   	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
  pUnit:RegisterEvent("Firegut_Ext",500,0) 
  end
  
  RegisterUnitEvent(97430, 18, "FiregutxPortal_Spawn")