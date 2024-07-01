-- name: Zcrude's Twirl Improvement
-- incompatible:
-- description: Press the punch button while in a twirl to descend faster! Instant movement after landing from a twirl!

local function mario_update(m)
    if m.action == ACT_TWIRLING and m.controller.buttonDown & B_BUTTON ~= 0 then
        m.vel.y = -45
    end
    if m.action == ACT_TWIRL_LAND then
        set_mario_action(m, ACT_WALKING, 0)
    end
end

-- hooks
hook_event(HOOK_MARIO_UPDATE, mario_update)
