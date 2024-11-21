require("randomlua")
require("function")
require("types.fluid-box")
require("types.energy-source")
require("types.energy")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 70632)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["offshore-pump"]) do
    rand_fluid_box(item.fluid_box, rng, min, max)
    item.pumping_speed = item.pumping_speed * rng:random_real(min, max)
    rand_energy_source(item.energy_source, rng, min, max)
    item.energy_usage = rand_energy(item.energy_usage, rng, min, max)
end
