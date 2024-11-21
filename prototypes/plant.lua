require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 9805)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.plant) do
    item.growth_ticks = item.growth_ticks * rng:random_real(min, max)
    if item.harvest_emissions then
        for _, emission in pairs(item.harvest_emissions) do
            emission = emission * rng:random_real(min, max)
        end
    end
end
