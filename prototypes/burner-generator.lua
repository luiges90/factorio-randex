require("randomlua")
require("function")
require("types.energy-source")
require("types.energy")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 47)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["burner-generator"]) do
    rand_energy_source(item.energy_source, rng, min, max)
    rand_energy_source(item.burner, rng, min, max)
    item.max_power_output = rand_energy(item.max_power_output, rng, min, max)
end
