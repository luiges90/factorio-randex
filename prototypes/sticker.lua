require("randomlua")
require("function")
require("types.damage-parameters")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 8245)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.sticker) do
    item.duration_in_ticks = math.ceil(item.duration_in_ticks * rng:random_real(min, max))
    if item.damage_interval then
        item.damage_interval = math.ceil(item.damage_interval * rng:random_real(min, max))
    end
    if item.fire_spread_cooldown then
        item.fire_spread_cooldown = math.ceil(item.fire_spread_cooldown * rng:random_real(min, max))
    end
    if item.fire_spread_radius then
        item.fire_spread_radius = item.fire_spread_radius * rng:random_real(min, max)
    end
    if item.stickers_per_square_meter then
        item.stickers_per_square_meter = item.stickers_per_square_meter * rng:random_real(min, max)
    end
    if item.damage_per_tick then
        rand_damage_parameters(item.damage_per_tick, rng, min, max)
    end
    if item.target_movement_modifier then
        item.target_movement_modifier = item.target_movement_modifier * rng:random_real(min, max)
    end
    if item.target_movement_modifier_from then
        item.target_movement_modifier_from = item.target_movement_modifier_from * rng:random_real(min, max)
    end
    if item.target_movement_modifier_to then
        item.target_movement_modifier_to = item.target_movement_modifier_to * rng:random_real(min, max)
    end
    if item.target_movement_max then
        item.target_movement_max = item.target_movement_max * rng:random_real(min, max)
    end
    if item.target_movement_max_from then
        item.target_movement_max_from = item.target_movement_max_from * rng:random_real(min, max)
    end
    if item.target_movement_max_to then
        item.target_movement_max_to = item.target_movement_max_to * rng:random_real(min, max)
    end
    if item.vehicle_speed_modifier then
        item.vehicle_speed_modifier = item.vehicle_speed_modifier * rng:random_real(min, max)
    end
    if item.vehicle_speed_modifier_from then
        item.vehicle_speed_modifier_from = item.vehicle_speed_modifier_from * rng:random_real(min, max)
    end
    if item.vehicle_speed_modifier_to then
        item.vehicle_speed_modifier_to = item.vehicle_speed_modifier_to * rng:random_real(min, max)
    end
    if item.vehicle_speed_max then
        item.vehicle_speed_max = item.vehicle_speed_max * rng:random_real(min, max)
    end
    if item.vehicle_speed_max_from then
        item.vehicle_speed_max_from = item.vehicle_speed_max_from * rng:random_real(min, max)
    end
    if item.vehicle_speed_max_to then
        item.vehicle_speed_max_to = item.vehicle_speed_max_to * rng:random_real(min, max)
    end
    if item.vehicle_friction_modifier then
        item.vehicle_friction_modifier = item.vehicle_friction_modifier * rng:random_real(min, max)
    end
    if item.vehicle_friction_modifier_from then
        item.vehicle_friction_modifier_from = item.vehicle_friction_modifier_from * rng:random_real(min, max)
    end
    if item.vehicle_friction_modifier_to then
        item.vehicle_friction_modifier_to = item.vehicle_friction_modifier_to * rng:random_real(min, max)
    end
end