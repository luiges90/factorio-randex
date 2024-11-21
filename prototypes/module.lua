require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 250)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.module) do
    if item.effect.consumption then
        item.effect.consumption = item.effect.consumption * rng:random_real(min, max)
    end
    if item.effect.speed then
        item.effect.speed = item.effect.speed * rng:random_real(min, max)
    end
    if item.effect.productivity then
        item.effect.productivity = item.effect.productivity * rng:random_real(min, max)
    end
    if item.effect.pollution then
        item.effect.pollution = item.effect.pollution * rng:random_real(min, max)
    end
    if item.effect.quality then
        item.effect.quality = item.effect.quality * rng:random_real(min, max)
    end
end
