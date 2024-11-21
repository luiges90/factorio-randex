require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 1444)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["repair-tool"]) do
    item.speed = item.speed * rng:random_real(min, max)
    item.durability = item.durability * rng:random_real(min, max)
end
