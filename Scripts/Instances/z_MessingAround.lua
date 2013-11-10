local HELL_SOUNDS = {
	10172, --  A_HELL_Legion01_Reinf01
    10173, --  A_HELL_Legion01_Reinf02
    10174, --  A_HELL_Legion01_Reinf03
    10175, --  A_HELL_Legion01_Reinf04
    10176, --  A_HELL_Legion01_Reinf05
    10177, --  A_HELL_Legion01_Reinf06
    10178, --  A_HELL_Legion01_Reinf07
    10179, --  A_HELL_Legion01_Reinf08
    10180, --  A_HELL_Legion01_Reinf09
    10181, --  A_HELL_Legion01_Reinf10
    10182, --  A_HELL_Legion01_Wake01
    10183, --  A_HELL_Legion01_Wake02
    10184, --  A_HELL_Legion01_Wake03
    10185, --  A_HELL_Legion01_Wake04
    10186, --  A_HELL_Legion01_Wake05
    10187, --  A_HELL_Legion01_FormConf01
    10188, --  A_HELL_Legion01_FormConf02
    10189, --  A_HELL_Legion01_FormConf03
    10190, --  A_HELL_Legion01_FormConf04
    10191, --  A_HELL_Legion01_FormConf05
    10192, --  A_HELL_Legion01_FormWor01
    10193, --  A_HELL_Legion01_FormWor02
    10194, --  A_HELL_Legion01_FormWor03
    10195, --  A_HELL_Legion01_FormWor04
    10196, --  A_HELL_Legion01_FormWor05
    10197, --  A_HELL_Legion02_Reinf01
    10198, --  A_HELL_Legion02_Reinf02
    10199, --  A_HELL_Legion02_Reinf03
    10200, --  A_HELL_Legion02_Reinf04
    10201, --  A_HELL_Legion02_Reinf05
    10202, --  A_HELL_Legion02_Reinf06
    10203, --  A_HELL_Legion02_Reinf07
    10204, --  A_HELL_Legion02_Reinf08
    10205, --  A_HELL_Legion02_Reinf09
    10206, --  A_HELL_Legion02_Reinf10
    10207, --  A_HELL_Legion02_Wake01
    10208, --  A_HELL_Legion02_Wake02
    10209, --  A_HELL_Legion02_Wake03
    10210, --  A_HELL_Legion02_Wake04
    10211, --  A_HELL_Legion02_Wake05
    10212, --  A_HELL_Legion02_FormConf01
    10213, --  A_HELL_Legion02_FormConf02
    10214, --  A_HELL_Legion02_FormConf03
    10215, --  A_HELL_Legion02_FormConf04
    10216, --  A_HELL_Legion02_FormConf05
    10217, --  A_HELL_Legion02_FormWor01
    10218, --  A_HELL_Legion02_FormWor02
    10219, --  A_HELL_Legion02_FormWor03
    10220, --  A_HELL_Legion02_FormWor04
    10221, --  A_HELL_Legion02_FormWor05
    10222, --  A_HELL_Legion03_Reinf01
    10223, --  A_HELL_Legion03_Reinf02
    10224, --  A_HELL_Legion03_Reinf03
    10225, --  A_HELL_Legion03_Reinf04
    10226, --  A_HELL_Legion03_Reinf05
    10227, --  A_HELL_Legion03_Reinf06
    10228, --  A_HELL_Legion03_Reinf07
    10229, --  A_HELL_Legion03_Reinf08
    10230, --  A_HELL_Legion03_Reinf09
    10231, --  A_HELL_Legion03_Reinf10
    10232, --  A_HELL_Legion03_Wake01
    10233, --  A_HELL_Legion03_Wake02
    10234, --  A_HELL_Legion03_Wake03
    10235, --  A_HELL_Legion03_Wake04
    10236, --  A_HELL_Legion03_Wake05
    10237, --  A_HELL_Legion03_FormConf01
    10238, --  A_HELL_Legion03_FormConf02
    10239, --  A_HELL_Legion03_FormConf03
    10240, --  A_HELL_Legion03_FormConf04
    10241, --  A_HELL_Legion03_FormConf05
    10242, --  A_HELL_Legion03_FormWor01
    10243, --  A_HELL_Legion03_FormWor02
    10244, --  A_HELL_Legion03_FormWor03
    10245, --  A_HELL_Legion03_FormWor04
    10246 --  A_HELL_Legion03_FormWor05
}

local shouts = {
    "Fighter down!",
    "Replacement quickly!",
    "Next warrior now!",
    "Fall in, ...",
    "Where's my support?!",
    "Look alive!",
    "Engage the enemy!",
    "Attack!",
    "Next warrior step up.",
    "Join the fight, ...",
    "Wake up, we're under attack!",
    "Sleep on your own time.",
    "Get up!",
    "On your feet!",
    "No time for slumber, join the fight!",
    "Line up and crush these fools!",
    "Form up, let's make quick work of them!",
    "Get ready, this shouldn't take long.",
    "Form ranks and make the intruders pay.",
    "Show them no quarter, form up.",
    "Lok'narash. Defensive positions.",
    "Hold the line they must not get through.",
    "...",
    "Hold them back at all costs!",
    "We must hold their advance, take your positions.",
    "Fighter down!",
    "Replacement, quickly!",
    "Next warrior, NOW!",
    "Fall in, ...",
    "Where's my support?!",
    "Look alive!",
    "Engage the enemy!",
    "Attack!",
    "Next warrior, step up!",
    "Join the fight, ...",
    "Wake up, we're under attack!",
    "Sleep on your own time!",
    "Get up!",
    "On your feet!",
    "No time for slumber, join the fight!",
    "Line up and crush these fools!",
    "Form up, let's make quick work of them.",
    "Get ready, this shouldn't take long.",
    "Form ranks and make the intruders pay.",
    "Show them no quarter, form up!",
    "Lok'narash. Defensive positions.",
    "Hold the line, they must not get through!",
    "...",
    "Hold them back at all costs!",
    "We must their advance, take your positions!",
    "Fighter down!",
    "Replacement quickly!",
    "Next warrior now!",
    "Fall in, ...",
    "Where's my support?!",
    "Look alive!",
    "Engage the enemy!",
    "Attack!",
    "Next warrior, step up!",
    "Join the fight, .",
    "Wake up, we're under attack."
}

local i = 0
local s = 0

function Spawn_Test_HELL(pUnit, Event)
    pUnit:RegisterEvent("SendSpamMessages", 5000, 0)
end

function SendSpamMessages(pUnit)
    i = i + 1
    s = s + 1
    if i > #HELL_SOUNDS then
        i = 1
    end
    if s > #shouts then
        if i == 1 then
            s = 1
        else
            s = 0
        end
    end
    if math.random(1,2) == 1 then
        pUnit:Emote(1,0)
    else
        pUnit:Emote(5,0)
    end
    if s == 0 then
        pUnit:SendChatMessage(12, 0, "Playing sound: "..tostring(HELL_SOUNDS[i]).." | i = "..tostring(i).." of "..tostring(#HELL_SOUND)..".")
    else
        pUnit:SendChatMessage(14, 0, shouts[s])
    end
    pUnit:PlaySoundToSet(HELL_SOUNDS[i])
end

RegisterUnitEvent(22973, 18, "Spawn_Test_HELL")

--[[
Fighter down!
Replacement quickly!
Next warrior now!
Fall in, ...
Where's my support?!
Look alive!
Engage the enemy!
Attack!
Next warrior step up.
...
Wake up, we're under attack!
Sleep on your own time.
Get up!
On your feet!
No time for slumber, join the fight!
Line up and crush these fools!
Form up, let's make quick work of them!
Get ready, this shouldn't take long.
Form ranks and make the intruders pay.
Show them no quarter, form up.
Lok'narash. Defensive positions.
Hold the line they must not get through.
...
Hold them back at all costs!
We must hold their advance, take your positions!
Fighter down!
Replacement, quickly!
Next warrior, NOW!
Fall in, ....
Where's my support?!
Look alive!
Engage the enemy!
Attack!
Next warrior, step up!
Join the fight, ...
Wake up, we're under attack!
Sleep on your own time
Get up!
On your feet!
No time for slumber, join the fight!
Line up and crush these fools!
Form up, let's make quick work of them.
Get ready, this shouldn't take long.
Form ranks and make the intruders pay.
Show them no quarter, form up!
Lok'narash. Defensive positions.
Hold the line, they must not get through!
...
Hold them back at all costs!
We must their advance, take your positions!
Fighter down!
Replacement quickly!
Next warrior now!
Fall in, ...
Where's my support?!
Look alive!
Engage the enemy!
Attack!
Next warrior, step up!
Join the fight, ...
Wake up, we're under attack.

]]