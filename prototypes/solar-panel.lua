require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 7846)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["solar-panel"]) do
    item.production = rand_energy(item.production, rng, min, max)
    rand_energy_source(item.energy_source, rng, min, max)
end
