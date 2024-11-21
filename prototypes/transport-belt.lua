require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 53476)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

local updated = {}
for _, item in pairs(data.raw["transport-belt"]) do
    -- find underground belt and splitter of same speed and change them in sync
    ugbelt = nil
    splitter = nil
    for _, compared in pairs(data.raw["underground-belt"]) do
        if item.speed == compared.speed then
            ugbelt = compared
            table.insert(updated, compared.name)
        end
    end
    for _, compared in pairs(data.raw["splitter"]) do
        if item.speed == compared.speed then
            splitter = compared
            table.insert(updated, compared.name)
        end
    end
    for _, compared in pairs(data.raw["loader"]) do
        if item.speed == compared.speed then
            loader = compared
            table.insert(updated, compared.name)
        end
    end
    for _, compared in pairs(data.raw["loader-1x1"]) do
        if item.speed == compared.speed then
            loader1 = compared
            table.insert(updated, compared.name)
        end
    end

    local speed = item.speed * rng:random_real(min, max)
    item.speed = speed
    if ugbelt then
        ugbelt.speed = speed
    end
    if splitter then
        splitter.speed = speed
    end
    if loader then
        loader.speed = speed
    end
    if loader1 then
        loader1.speed = speed
    end
end

for _, item in pairs(data.raw["underground-belt"]) do
    if not contains(item.name, updated) then
        item.speed = item.speed * rng:random_real(min, max)
    end
    item.max_distance = math.ceil(item.max_distance * rng:random_real(min, max))
end

for _, item in pairs(data.raw["splitter"]) do
    if not contains(item.name, updated) then
        item.speed = item.speed * rng:random_real(min, max)
    end
end

for _, item in pairs(data.raw["loader"]) do
    if not contains(item.name, updated) then
        item.speed = item.speed * rng:random_real(min, max)
    end
end

for _, item in pairs(data.raw["loader-1x1"]) do
    if not contains(item.name, updated) then
        item.speed = item.speed * rng:random_real(min, max)
    end
end

for _, item in pairs(data.raw["lane-splitter"]) do
    if not contains(item.name, updated) then
        item.speed = item.speed * rng:random_real(min, max)
    end
end

for _, item in pairs(data.raw["linked-belt"]) do
    if not contains(item.name, updated) then
        item.speed = item.speed * rng:random_real(min, max)
    end
end
