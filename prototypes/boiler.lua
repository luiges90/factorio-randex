require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")
require("types.fluid-box")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 7352)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.boiler) do
    rand_energy_source(item.energy_source, rng, min, max)
    rand_fluid_box(item.fluid_box, rng, min, max)
    rand_fluid_box(item.output_fluid_box, rng, min, max)
    item.energy_consumption = rand_energy(item.energy_consumption, rng, min, max)
    if item.target_temperature then
        item.target_temperature = item.target_temperature * rng:random_real(min, max)
    end
end
