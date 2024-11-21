require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 76244)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["space-platform-hub"]) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    if item.platform_repair_speed_modifier then
        item.platform_repair_speed_modifier = item.platform_repair_speed_modifier * rng:random_real(min, max)
    end
    if item.weight then
        item.weight = item.weight * rng:random_real(min, max)
    end
end