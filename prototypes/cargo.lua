require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 1233)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["cargo-bay"]) do
    item.inventory_size_bonus = math.ceil(item.inventory_size_bonus * rng:random_real(min, max))
end

for _, item in pairs(data.raw["cargo-landing-pad"]) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
     if item.trash_inventory_size then
        item.trash_inventory_size = math.ceil(item.trash_inventory_size * rng:random_real(min, max))
    end
    item.radar_range = math.ceil(item.radar_range * rng:random_real(min, max))
end

for _, item in pairs(data.raw["cargo-pod"]) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
end