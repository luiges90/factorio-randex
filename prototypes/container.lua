require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 1934)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.container) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
end

for _, item in pairs(data.raw["linked-container"]) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
end

for _, item in pairs(data.raw["logistic-container"]) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    if item.trash_inventory_size then
        item.trash_inventory_size = math.ceil(item.trash_inventory_size * rng:random_real(min, max))
    end
end
