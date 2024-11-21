require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 7846)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.inserter) do
    item.extension_speed = item.extension_speed * rng:random_real(min, max)
    item.rotation_speed = item.rotation_speed * rng:random_real(min, max)
    rand_energy_source(item.energy_source, rng, min, max)
    item.energy_per_movement = rand_energy(item.energy_per_movement, rng, min, max)
    item.energy_per_rotation = rand_energy(item.energy_per_rotation, rng, min, max)
end
