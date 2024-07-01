-- name: Zcrude's Character Stats Mod
-- incompatible:
-- description: Adds unique stats to each character!

local localmario = gMarioStates[0]

StationaryActions = {
    ACT_IDLE,
    ACT_START_SLEEPING,
    ACT_SLEEPING,
    ACT_WAKING_UP,
    ACT_PANTING,
    ACT_HOLD_IDLE,
    ACT_HOLD_HEAVY_IDLE,
    ACT_STANDING_AGAINST_WALL,
    ACT_COUGHING,
    ACT_SHIVERING,
    ACT_IN_QUICKSAND,
    ACT_CROUCHING,
    ACT_START_CROUCHING,
    ACT_STOP_CROUCHING,
    ACT_START_CRAWLING,
    ACT_STOP_CRAWLING,
    ACT_SLIDE_KICK_SLIDE_STOP,
    ACT_BACKFLIP_LAND_STOP,
    ACT_JUMP_LAND_STOP,
    ACT_DOUBLE_JUMP_LAND_STOP,
    ACT_TRIPLE_JUMP_LAND_STOP,
    ACT_FREEFALL_LAND_STOP,
    ACT_FREEFALL_LAND_STOP,
    ACT_HOLD_JUMP_LAND_STOP,
    ACT_HOLD_FREEFALL_LAND_STOP,
    ACT_AIR_THROW_LAND,
    ACT_TWIRL_LAND,
    ACT_LAVA_BOOST_LAND,
    ACT_LONG_JUMP_LAND_STOP,
    ACT_GROUND_POUND_LAND,
    ACT_BRAKING_STOP}
GroundMovingActions = {
    ACT_WALKING,
    ACT_HOLD_WALKING,
    ACT_TURNING_AROUND,
    ACT_FINISH_TURNING_AROUND,
    ACT_BRAKING,
    ACT_RIDING_SHELL_GROUND,
    ACT_HOLD_HEAVY_WALKING,
    ACT_CRAWLING,
    ACT_BURNING_GROUND,
    ACT_DECELERATING,
    ACT_HOLD_DECELERATING,
    ACT_MOVE_PUNCHING,
    ACT_JUMP_LAND,
    ACT_FREEFALL_LAND,
    ACT_DOUBLE_JUMP_LAND,
    ACT_SIDE_FLIP_LAND,
    ACT_HOLD_JUMP_LAND,
    ACT_HOLD_FREEFALL_LAND,
    ACT_QUICKSAND_JUMP_LAND,
    ACT_HOLD_QUICKSAND_JUMP_LAND,
    ACT_TRIPLE_JUMP_LAND,
    ACT_BACKFLIP_LAND}
HurtActions = {
    ACT_HARD_BACKWARD_GROUND_KB,
    ACT_HARD_FORWARD_GROUND_KB,
    ACT_BACKWARD_GROUND_KB,
    ACT_FORWARD_GROUND_KB,
    ACT_SOFT_BACKWARD_GROUND_KB,
    ACT_SOFT_FORWARD_GROUND_KB,
    ACT_HARD_BACKWARD_AIR_KB,
    ACT_HARD_FORWARD_AIR_KB}
BonkActions = {
    ACT_GROUND_BONK,
    ACT_SOFT_BONK
}
local function checkifstationary()
    for _, action in ipairs(StationaryActions) do
        if action == localmario.action then
            return true
        end
    end
    return false
end

local function checkifgroundmoving()
    for _, action in ipairs(GroundMovingActions) do
        if action == localmario.action then
            return true
        end
    end
    return false
end

local function checkifstationarybefore()
    for _, action in ipairs(StationaryActions) do
        if action == localmario.prevAction then
            return true
        end
    end
    return false
end

local function checkifgroundmovingbefore()
    for _, action in ipairs(GroundMovingActions) do
        if action == localmario.prevAction then
            return true
        end
    end
    return false
end

local actionisold = false
local chatmessagemade = false
local luigicooldown = false
local waluigicooldown = false

local function onhudrender()
    djui_hud_print_text("TYPE /stats AND /improvements",250,35, 3)
end

local function statscommand()
    djui_chat_message_create("Mario: If you punch while ground pounding, you dive. - Luigi: Higher jump, lower speed. Triple jump is twirl! - Toad: Higher speed, lower jump. Wario: Press the punch button mid-air to hover! One health only. - Waluigi: Takes less damage, lower jump.")
end
local function improvementcommand()
    djui_chat_message_create("-Hold the punch button during a twirl to descend faster. -No delay back to moving after landing from a twirl.")
end

local function mario_update(m)
    if chatmessagemade == false then
        chatmessagemade = true
        djui_chat_message_create("Welcome to the Character Stats Mod! Type /stats to see all the characters stats, and /improvements to see general enhancements!")
    end

    -- GENERAL QUALITY OF LIFE
    if localmario.action == ACT_TWIRL_LAND then
        localmario.action = ACT_WALKING
    end
    if (localmario.action == ACT_TWIRLING and (m.controller.buttonDown & B_BUTTON ~= 0)) then
        localmario.vel.y = -50
    end

    -- CHARACTER SPECIFIC HANDLING

    if localmario.actionTimer > 0 then
        actionisold = true
    else
        actionisold = false
    end

    -- CHARACTER SPECIFIC

    -- MARIO
    if get_character(localmario).type == 0 then -- CHECK IF MARIO
        if localmario.action == ACT_GROUND_POUND and (m.controller.buttonPressed & B_BUTTON) ~= 0 then
            set_mario_action(localmario,ACT_DIVE,0)
            mario_set_forward_vel(localmario, 56)
            localmario.vel.y = 7
        end
    end

    -- LUIGI
    if get_character(localmario).type == 1 then -- CHECK IF LUIGI
        if localmario.forwardVel > 27 and localmario.action == ACT_WALKING then
            mario_set_forward_vel(localmario,localmario.forwardVel - 1)
        end
        if localmario.action == ACT_TRIPLE_JUMP then
            localmario.action = ACT_TWIRLING
        end
        if luigicooldown == true then
            if checkifstationary() == true or checkifgroundmoving() == true then
                luigicooldown = false
            end
        end
        if (checkifstationarybefore() or checkifgroundmovingbefore()) and actionisold == false and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            if luigicooldown == false then
                m.vel.y = m.vel.y + 10
                luigicooldown = true
            end
        end
    end
    -- TOAD
    if get_character(localmario).type == 2 then -- CHECK IF TOAD
        if localmario.forwardVel < 37 and localmario.action == ACT_WALKING then
            mario_set_forward_vel(localmario,localmario.forwardVel + 1)
        end
        if (checkifstationarybefore() or checkifgroundmovingbefore()) and actionisold == false and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            m.vel.y = m.vel.y - 15
        end
    end
    -- WALUIGI
    if get_character(localmario).type == 4 then -- CHECK IF WALUIGI
        log_to_console(tostring(localmario.action))
        if localmario.health ~= 0x880 then
            if (localmario.action ~= ACT_DEATH_EXIT and localmario.action ~= ACT_DEATH_EXIT_LAND and localmario.action ~= ACT_FALLING_DEATH_EXIT and localmario.action ~= ACT_EXIT_AIRBORNE and localmario.action ~= ACT_SPECIAL_EXIT_AIRBORNE and localmario.action ~= ACT_FALLING_EXIT_AIRBORNE and localmario.action ~= ACT_SPECIAL_DEATH_EXIT and localmario.action ~= ACT_SWIMMING_END and localmario.action ~= ACT_FLUTTER_KICK and localmario.action ~= ACT_HOLD_FLUTTER_KICK and localmario.action ~= ACT_BREASTSTROKE and localmario.action ~= ACT_HOLD_BREASTSTROKE and localmario.action ~= ACT_HOLD_SWIMMING_END and localmario.action ~= ACT_WATER_IDLE and localmario.action ~= ACT_HOLD_WATER_IDLE and localmario.action ~= ACT_HOLD_WATER_ACTION_END and localmario.action ~= ACT_WATER_PLUNGE and localmario.action ~= ACT_WATER_ACTION_END) then
                localmario.hurtCounter= 999
            end
        end
        if waluigicooldown == true then
            if checkifstationary() == true or checkifgroundmoving() == true then
                waluigicooldown = false
            end
        end
        if (checkifstationarybefore() == false or checkifgroundmovingbefore() == false) and waluigicooldown == false and (m.controller.buttonPressed & B_BUTTON ~= 0) then
            set_mario_action(localmario,ACT_FREEFALL,0)
            m.vel.y = 3
            mario_set_forward_vel(localmario,localmario.forwardVel + 20)
            waluigicooldown = true
        end
    end
    -- WARIO
    if get_character(localmario).type == 3 then -- CHECK IF WARIO
        if localmario.hurtCounter > 8 then
            localmario.hurtCounter = localmario.hurtCounter - 1
        end
        if (checkifstationarybefore() or checkifgroundmovingbefore()) and actionisold == false and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            m.vel.y = m.vel.y - 15
        end
    end
end


-- hooks
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_chat_command('stats', "show stats", statscommand)
hook_chat_command('improvements', "show stats", improvementcommand)
hook_event(HOOK_ON_HUD_RENDER, onhudrender)
