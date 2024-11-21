require("randomlua")
require("function")
require("types.fluid-box")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 853)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.thruster) do
    item.min_performance.fluid_volume = item.min_performance.fluid_volume * rng:random_real(min, max)
    item.min_performance.fluid_usage = item.min_performance.fluid_usage * rng:random_real(min, max)
    item.min_performance.effectivity = item.min_performance.effectivity * rng:random_real(min, max)
    item.max_performance.fluid_volume = item.max_performance.fluid_volume * rng:random_real(min, max)
    item.max_performance.fluid_usage = item.max_performance.fluid_usage * rng:random_real(min, max)
    item.max_performance.effectivity = item.max_performance.effectivity * rng:random_real(min, max) 
    rand_fluid_box(item.fuel_fluid_box, rng, min, max)
    rand_fluid_box(item.oxidizer_fluid_box, rng, min, max)
end