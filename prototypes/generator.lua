require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")
require("types.fluid-box")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 1269)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.generator) do
    rand_energy_source(item.energy_source, rng, min, max)
    rand_fluid_box(item.fluid_box, rng, min, max)
    if item.effectivity then
        item.effectivity = item.effectivity * rng:random_real(min, max)
    end
    item.fluid_usage_per_tick = item.fluid_usage_per_tick * rng:random_real(min, max)
    item.maximum_temperature = item.maximum_temperature * rng:random_real(min, max)
    if item.max_power_output then
        item.max_power_output = rand_energy(item.max_power_output, rng, min, max)
    end
end
