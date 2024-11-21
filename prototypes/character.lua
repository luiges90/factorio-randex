require("randomlua")
require("function")
require("types.trigger")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 1934)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.character) do
    -- Some value changes cause the game to crash
    item.mining_speed = item.mining_speed * rng:random_real(min, max)
    item.running_speed = item.running_speed * rng:random_real(min, max)
    -- item.distance_per_frame = item.distance_per_frame * rng:random_real(min, max)
    -- item.maximum_corner_sliding_distance = item.maximum_corner_sliding_distance * rng:random_real(min, max)
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    if item.gun_inventory_size then
        item.gun_inventory_size = math.ceil(item.gun_inventory_size * rng:random_real(min, max))
    end
    item.build_distance = math.ceil(item.build_distance * rng:random_real(min, max))
    -- item.drop_item_distance = math.ceil(item.drop_item_distance * rng:random_real(min, max))
    -- item.reach_distance = math.ceil(item.reach_distance * rng:random_real(min, max))
    -- item.reach_resource_distance = item.reach_resource_distance * rng:random_real(min, max)
    -- item.item_pickup_distance = item.item_pickup_distance * rng:random_real(min, max)
    -- item.loot_pickup_distance = item.loot_pickup_distance * rng:random_real(min, max)
    -- if item.enter_vehicle_distance then
    --     item.enter_vehicle_distance = item.enter_vehicle_distance * rng:random_real(min, max)
    -- end
    -- if item.tool_attack_distance then
    --    item.tool_attack_distance = item.tool_attack_distance * rng:random_real(min, max)
    -- end
    if item.tool_attack_result then
        rand_trigger(item.tool_attack_result, rng, min, max)
    end
end
