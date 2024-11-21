require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 95432)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["equipment-grid"]) do
    item.width = math.ceil(item.width * rng:random_real(min, max))
    item.height = math.ceil(item.height * rng:random_real(min, max))
end
