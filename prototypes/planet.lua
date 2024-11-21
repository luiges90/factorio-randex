require("randomlua")
require("function")
require("types.asteroid-spawn-point")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 780)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.planet) do
    item.gravity_pull = item.gravity_pull * rng:random_real(min, max)
    item.distance = item.distance * rng:random_real(min, max)
    if item.magnitude then
        item.magnitude = item.magnitude * rng:random_real(min, max)
    end
    if item.solar_power_in_space then
        item.solar_power_in_space = item.solar_power_in_space * rng:random_real(min, max)
    end
    if item.asteroid_spawn_influence then
        item.asteroid_spawn_influence = item.asteroid_spawn_influence * rng:random_real(min, max)
    end
    if item.asteroid_spawn_definitions then
        for _, spawn in pairs(item.asteroid_spawn_definitions) do
            rand_asteroid_spawn_point(spawn, rng, min, max)
        end
    end
    if item.player_effects then
        for k, t in pairs(item.player_effects) do
            if type(k) == "number" then
                rand_trigger_effect(t, rng, min, max)
            else
                rand_trigger_effect(item.player_effects, rng, min, max)
                break
            end
        end
    end
end