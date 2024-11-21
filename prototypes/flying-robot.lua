require("randomlua")
require("function")
require("types.energy")
require("types.attack-parameters")
require("types.trigger")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 56465)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

function rand_flying_robot(item)
    item.speed = item.speed * rng:random_real(min, max)
    if item.max_speed then
        item.max_speed = item.max_speed * rng:random_real(min, max)
    end
    if item.max_energy then
        item.max_energy = rand_energy(item.max_energy, rng, min, max)
    end
    if item.energy_per_move then
        item.energy_per_move = rand_energy(item.energy_per_move, rng, min, max)
    end
    if item.energy_per_tick then
        item.energy_per_tick = rand_energy(item.energy_per_tick, rng, min, max)
    end
    if item.min_to_charge then
        item.min_to_charge = item.min_to_charge * rng:random_real(min, max)
    end
    if item.max_to_charge then
        item.max_to_charge = item.max_to_charge * rng:random_real(min, max)
    end
    if item.speed_multiplier_when_out_of_energy then
        item.speed_multiplier_when_out_of_energy = item.speed_multiplier_when_out_of_energy * rng:random_real(min, max)
    end
end

for _, item in pairs(data.raw["capture-robot"]) do
    if item.capture_speed then
        item.capture_speed = item.capture_speed * rng:random_real(min, max)
    end
    if item.search_radius then
        item.search_radius = item.search_radius * rng:random_real(min, max)
    end
    if item.destroy_action then
        rand_trigger(item.destroy_action, rng, min, max)
    end
    rand_flying_robot(item)
end

for _, item in pairs(data.raw["combat-robot"]) do
    rand_attack_parameters(item.attack_parameters, rng, min, max)
    item.time_to_live = math.ceil(item.time_to_live * rng:random_real(min, max))
    if item.range_from_player then
        item.range_from_player = item.range_from_player * rng:random_real(min, max)
    end
    if item.friction then
        item.friction = item.friction * rng:random_real(min, max)
    end
    if item.destroy_action then
        rand_trigger(item.destroy_action, rng, min, max)
    end
    rand_flying_robot(item)
end

for _, item in pairs(data.raw["construction-robot"]) do
    item.max_payload_size = math.ceil(item.max_payload_size * rng:random_real(min, max))
    if item.destroy_action then
        rand_trigger(item.destroy_action, rng, min, max)
    end
    rand_flying_robot(item)
end

for _, item in pairs(data.raw["logistic-robot"]) do
    item.max_payload_size = math.ceil(item.max_payload_size * rng:random_real(min, max))
    if item.destroy_action then
        rand_trigger(item.destroy_action, rng, min, max)
    end
    rand_flying_robot(item)
end
