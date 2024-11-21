require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 8946)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.technology) do
    if item.unit then
        if item.unit.count then
            item.unit.count = ceil_2sf(math.ceil(item.unit.count * rng:random_real(min, max) / 10) * 10)
        end
        if item.unit.count_formula then
            item.unit.count_formula = "(" .. item.unit.count_formula .. ") * " .. (math.ceil(rng:random_real(min, max) * 10 / 10))
        end
        if item.unit.time then
            item.unit.time = math.ceil(item.unit.time * rng:random_real(min, max) / 5) * 5
        end
        if item.unit.ingredients then
            for _, ingredient in pairs(item.unit.ingredients) do
                ingredient[2] = math.ceil(ingredient[2] * rng:random_real(min, max))
            end
        end
    end
    if item.max_level and item.max_level ~= "infinite" then
        item.max_level = math.ceil(item.max_level * rng:random_real(min, max))
    end
    if item.effects then
        for _, effect in pairs(item.effects) do
            if effect.modifier and type(effect.modifier) == "number" then
                effect.modifier = effect.modifier * rng:random_real(min, max)
            end
            if effect.change then
                effect.change = effect.change * rng:random_real(min, max)
            end
            if effect.count then
                effect.count = effect.count * rng:random_real(min, max)
            end
        end
    end
end
