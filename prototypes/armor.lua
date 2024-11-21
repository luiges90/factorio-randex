require("randomlua")
require("function")
require("types.resistance")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 2547)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.armor) do
    if item.inventory_size_bonus then
        item.inventory_size_bonus = math.ceil(item.inventory_size_bonus * rng:random_real(min, max))
    end
    if item.durability then
        item.durability = item.durability * rng:random_real(min, max)
    end
    if item.resistances then
        rand_resistance(item.resistances, rng, min, max)
    end
end
