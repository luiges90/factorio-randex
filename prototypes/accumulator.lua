require("randomlua")
require("function")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 7846)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.accumulator) do
    rand_energy_source(item.energy_source, rng, min, max)
end
