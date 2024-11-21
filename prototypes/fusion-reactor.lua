require("randomlua")
require("function")
require("types.energy-source")
require("types.fluid-box")
require("types.energy")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 78)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["fusion-reactor"]) do
    rand_energy_source(item.energy_source, rng, min, max)
    rand_energy_source(item.burner, rng, min, max)
    rand_fluid_box(item.input_fluid_box, rng, min, max)
    rand_fluid_box(item.output_fluid_box, rng, min, max)
    if item.neighbour_bonus then
        item.neighbour_bonus = item.neighbour_bonus * rng:random_real(min, max)
    end
    item.power_input = rand_energy(item.power_input, rng, min, max)
    item.max_fluid_usage = item.max_fluid_usage * rng:random_real(min, max)
end
