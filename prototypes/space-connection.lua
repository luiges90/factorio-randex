require("randomlua")
require("function")
require("types.asteroid-spawn-point")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 73547)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["space-connection"]) do
    if item.length then
        item.length = math.ceil(item.length * rng:random_real(min, max) / 1000) * 1000
    end
    if item.asteroid_spawn_definitions then
        for _, asteroid_def in pairs(item.asteroid_spawn_definitions) do
            for _, spawn in pairs(asteroid_def.spawn_points) do
                rand_asteroid_spawn_point(spawn, rng, min, max)
            end
        end
    end
end
