require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 235)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.resource) do
    if item.minimum then
        item.minimum = math.ceil(item.minimum * rng:random_real(min, max))
    end 
    if item.normal then
        item.normal = math.ceil(item.normal * rng:random_real(min, max))
    end
    if item.infinite_depletion_amount then
        item.infinite_depletion_amount = math.ceil(item.infinite_depletion_amount * rng:random_real(min, max))
    end
    if item.tree_removal_probability then
        item.tree_removal_probability = item.tree_removal_probability * rng:random_real(min, max)
    end
    if item.cliff_removal_probability then
        item.cliff_removal_probability = item.cliff_removal_probability * rng:random_real(min, max)
    end
    if item.tree_removal_max_distance then
        item.tree_removal_max_distance = item.tree_removal_max_distance * rng:random_real(min, max)
    end
end