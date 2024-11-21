require("randomlua")
require("function")
require("types.energy")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 75862)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.fluid) do
    --item.default_temperature = item.default_temperature * rng:random_real(min, max)
    --if item.max_temperature then
    --    item.max_temperature = item.max_temperature * rng:random_real(min, max)
    --    if item.default_temperature > item.max_temperature then
    --        item.default_temperature = item.max_temperature
    --    end
    --end
    if item.heat_capacity then
        item.heat_capacity = rand_energy(item.heat_capacity, rng, min, max)
    end
    if item.fuel_value then
        item.fuel_value = rand_energy(item.fuel_value, rng, min, max)
    end
    if item.emissions_multiplier then
        item.emissions_multiplier = item.emissions_multiplier * rng:random_real(min, max)
    end
end
