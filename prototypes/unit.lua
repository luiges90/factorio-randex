require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 1934)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.unit) do
    rand_attack_parameters(item.attack_parameters, rng, min, max)
    item.movement_speed = item.movement_speed * rng:random_real(min, max)
    item.distraction_cooldown = math.ceil(item.distraction_cooldown * rng:random_real(min, max))
    item.vision_distance = item.vision_distance * rng:random_real(min, max)
    if item.rotation_speed then
        item.rotation_speed = item.rotation_speed * rng:random_real(min, max)
    end
    if item.min_pursue_time then
        item.min_pursue_time = math.ceil(item.min_pursue_time * rng:random_real(min, max))
    end
    if item.max_pursue_distance then
        item.max_pursue_distance = item.max_pursue_distance * rng:random_real(min, max)
    end
    if item.radar_range then
        item.radar_range = math.ceil(item.radar_range * rng:random_real(min, max))
    end
    if item.spawning_time_modifier then
        item.spawning_time_modifier = item.spawning_time_modifier * rng:random_real(min, max)
    end
end

