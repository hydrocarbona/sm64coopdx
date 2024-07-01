-- name: Zcrude's Object Spawner
-- incompatible:
-- description: Have console open. Press L and up on the DPad simultaneously to toggle spawning. Cycle with left/right on DPad. Press down on DPad to spawn.

local timerflag1 = false

local timer1 = 0
local timer2 = 0
local timer3 = 0

local itemindexint = 1
local guiopen = false


local function mario_update(m)
    timer1 = timer1 - 1
    timer2 = timer2 - 1
    timer3 = timer3 - 1

    if (m.controller.buttonPressed & L_TRIG) ~= 0 and (m.controller.buttonPressed & U_JPAD) ~= 0 then
        if guiopen == false then
            itemindexint = 1
            guiopen = true
            play_character_sound(m, CHAR_SOUND_LETS_A_GO)
        else
            guiopen = false
            play_character_sound(m, CHAR_SOUND_SO_LONGA_BOWSER)
        end
    end

    if (m.controller.buttonPressed & R_JPAD) ~= 0 then
        if guiopen == true and itemindexint < 8 then
            itemindexint = itemindexint + 1
            log_to_console("Item Index is: " .. tostring(itemindexint))
        end
    end

    if (m.controller.buttonPressed & L_JPAD) ~= 0 then
        if guiopen == true and itemindexint > 1 then
            itemindexint = itemindexint - 1
            log_to_console("Item Index is: " .. tostring(itemindexint))
        end
    end

    if (m.controller.buttonPressed & D_JPAD) ~= 0 then
        if guiopen == true then
            if itemindexint == 1 then
                spawn_sync_object(id_bhvGoomba, E_MODEL_GOOMBA, m.pos.x, m.pos.y + 50, m.pos.z + 350, function(obj)end)
            end
            if itemindexint == 2 then
                spawn_sync_object(id_bhvKoopa, E_MODEL_KOOPA_WITH_SHELL, m.pos.x, m.pos.y + 50, m.pos.z + 350, function(obj)end)
            end
            if itemindexint == 3 then
                spawn_sync_object(id_bhvBobomb, E_MODEL_BLACK_BOBOMB, m.pos.x, m.pos.y + 50, m.pos.z + 350, function(obj)end)
            end
            if itemindexint == 4 then
                spawn_sync_object(id_bhvChainChomp, E_MODEL_CHAIN_CHOMP, m.pos.x, m.pos.y + 50, m.pos.z + 350, function(obj)end)
            end
            if itemindexint == 5 then
                spawn_sync_object(id_bhvKingBobomb, E_MODEL_KING_BOBOMB, m.pos.x, m.pos.y + 50, m.pos.z + 350, function(obj)end)
            end
            if itemindexint == 6 then
                spawn_sync_object(id_bhvPiranhaPlant, E_MODEL_PIRANHA_PLANT, m.pos.x, m.pos.y + 50, m.pos.z + 350, function(obj)end)
            end
            if itemindexint == 7 then
                spawn_sync_object(id_bhvSmallWhomp, E_MODEL_WHOMP, m.pos.x, m.pos.y + 50, m.pos.z + 350, function(obj)end)
            end
            if itemindexint == 8 then
                spawn_sync_object(id_bhvWhompKingBoss, E_MODEL_WHOMP, m.pos.x, m.pos.y + 50, m.pos.z + 350, function(obj)end)
            end
        end
    end
end

-- hooks
hook_event(HOOK_MARIO_UPDATE, mario_update)
