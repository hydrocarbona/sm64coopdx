-- name: Zcrude's Object Spawner
-- incompatible:
-- description: Press L button to toggle spawner! Left/Right DPad to cycle objects, down DPad to spawn!


local x = 30
local y = 850
local x2 = 30
local y2 = 650

local spawningactive = "inactive"
local itemindexint = 1
local itemname = "please select item"

local function onhudrender()
    djui_hud_set_font(FONT_HUD)
    djui_hud_print_text(spawningactive, x, y, 5)
    djui_hud_print_text(itemname, x2, y2, 5)
end

local function updated(m)
    if (m.controller.buttonPressed & L_TRIG) ~= 0 then
        if spawningactive == "inactive" then
            spawningactive = "active"
        else
            spawningactive = "inactive"
        end
    end

    if (m.controller.buttonPressed & R_JPAD) ~= 0 then
        if spawningactive == "active" and itemindexint < 8 then
            itemindexint = itemindexint + 1
        end
    end

    if (m.controller.buttonPressed & L_JPAD) ~= 0 then
        if spawningactive == "active" and itemindexint > 1 then
            itemindexint = itemindexint - 1
        end
    end

    if (m.controller.buttonPressed & D_JPAD) ~= 0 then
        if spawningactive == "active" then
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

    if itemindexint == 1 then
        itemname = "Goomba"
    end
    if itemindexint == 2 then
        itemname = "Koopa"
    end
    if itemindexint == 3 then
        itemname = "Bobomb"
    end
    if itemindexint == 4 then
        itemname = "Chain Chomp"
    end
    if itemindexint == 5 then
        itemname = "King Bobomb"
    end
    if itemindexint == 6 then
        itemname = "Piranha Plant"
    end
    if itemindexint == 7 then
        itemname = "Whomp"
    end
    if itemindexint == 8 then
        itemname = "King Whomp"
    end

end

hook_event(HOOK_MARIO_UPDATE, updated)
hook_event(HOOK_ON_HUD_RENDER, onhudrender)
