require("randomlua")
require("function")
require("types.energy-source")
require("types.fluid-box")  

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 454)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["fusion-generator"]) do
    rand_energy_source(item.energy_source, rng, min, max)
    rand_fluid_box(item.input_fluid_box, rng, min, max)
    rand_fluid_box(item.output_fluid_box, rng, min, max)
    item.max_fluid_usage = item.max_fluid_usage * rng:random_real(min, max)
end
