require("randomlua")
require("function")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 75468)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["lightning-attractor"]) do
    if item.efficiency then
        item.efficiency = item.efficiency * rng:random_real(min, max)
    end
    if item.range_elongation then
        item.range_elongation = item.range_elongation * rng:random_real(min, max)
    end
    if item.energy_source then
        rand_energy_source(item.energy_source, rng, min, max)
    end
end
