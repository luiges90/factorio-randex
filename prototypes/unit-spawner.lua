require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 34785)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["unit-spawner"]) do
    item.max_count_of_owned_units = math.ceil(item.max_count_of_owned_units * rng:random_real(min, max))
    item.max_friends_around_to_spawn = math.ceil(item.max_friends_around_to_spawn * rng:random_real(min, max))
    item.spawning_cooldown[1] = item.spawning_cooldown[1] * rng:random_real(min, max) 
    item.spawning_cooldown[2] = item.spawning_cooldown[2] * rng:random_real(min, max) 
    item.spawning_radius = item.spawning_radius * rng:random_real(min, max)
    item.spawning_spacing = item.spawning_spacing * rng:random_real(min, max)
    item.max_richness_for_spawn_shift = item.max_richness_for_spawn_shift * rng:random_real(min, max)
    item.max_spawn_shift = item.max_spawn_shift * rng:random_real(min, max)
    item.call_for_help_radius = item.call_for_help_radius * rng:random_real(min, max)
    if item.time_to_capture then
        item.time_to_capture = math.ceil(item.time_to_capture * rng:random_real(min, max))
    end
    if item.min_darkness_to_spawn then
        item.min_darkness_to_spawn = item.min_darkness_to_spawn * rng:random_real(min, max)
    end
    if item.max_darkness_to_spawn then
        item.max_darkness_to_spawn = item.max_darkness_to_spawn * rng:random_real(min, max)
    end
end
