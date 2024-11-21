require("randomlua")
require("function")
require("types.attack-parameters")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 1934)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["segmented-unit"]) do
    item.vision_distance = item.vision_distance * rng:random_real(min, max)
    if item.attack_parameters then
        rand_attack_parameters(item.attack_parameters, rng, min, max)
    end
    if item.revenge_attack_parameters then
        rand_attack_parameters(item.revenge_attack_parameters, rng, min, max)
    end
    item.territory_radius = math.ceil(item.territory_radius * rng:random_real(min, max))
    item.enraged_duration = math.ceil(item.enraged_duration * rng:random_real(min, max))
    item.patrolling_speed = item.patrolling_speed * rng:random_real(min, max)
    item.investigating_speed = item.investigating_speed * rng:random_real(min, max)
    item.attacking_speed = item.attacking_speed * rng:random_real(min, max)
    item.enraged_speed = item.enraged_speed * rng:random_real(min, max)
    item.acceleration_rate = item.acceleration_rate * rng:random_real(min, max)
    item.turn_radius = item.turn_radius * rng:random_real(min, max)
    if item.patrolling_turn_radius then
        item.patrolling_turn_radius = item.patrolling_turn_radius * rng:random_real(min, max)
    end
    if item.turn_smoothing then
        item.turn_smoothing = clamp(item.turn_smoothing * rng:random_real(min, max), 0, 1)
    end
    if item.ticks_per_scan then
        item.ticks_per_scan = math.ceil(item.ticks_per_scan * rng:random_real(min, max))
    end
end
