require("randomlua")
require("function")
require("types.energy")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 78231)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["asteroid-collector"]) do
    -- Some value changes cause the game to crash
    --if item.arm_inventory_size then
    --    item.arm_inventory_size = math.ceil(item.arm_inventory_size * rng:random_real(min, max))
    --end
    --if item.arm_inventory_size_quality_increase then
    --    item.arm_inventory_size_quality_increase = math.ceil(item.arm_inventory_size_quality_increase * rng:random_real(min, max))
    --end
    --if item.inventory_size then
    --    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    --end
    --if item.inventory_size_quality_increase then
    --    item.inventory_size_quality_increase = math.ceil(item.inventory_size_quality_increase * rng:random_real(min, max))
    --end
    item.passive_energy_usage = rand_energy(item.passive_energy_usage, rng, min, max)
    item.arm_energy_usage = rand_energy(item.arm_energy_usage, rng, min, max)
    item.arm_slow_energy_usage = rand_energy(item.arm_slow_energy_usage, rng, min, max)
    if item.energy_usage_quality_scaling then
        item.energy_usage_quality_scaling = item.energy_usage_quality_scaling * rng:random_real(min, max)
    end
    if item.arm_count_base then
        item.arm_count_base = math.ceil(item.arm_count_base * rng:random_real(min, max))
    end
    if item.arm_count_quality_scaling then
        item.arm_count_quality_scaling = math.ceil(item.arm_count_quality_scaling * rng:random_real(min, max))
    end
    --if item.head_collection_radius then
    --    item.head_collection_radius = item.head_collection_radius * rng:random_real(min, max)
    --end
    --if item.deposit_radius then
    --    item.deposit_radius = item.deposit_radius * rng:random_real(min, max)
    --end
    if item.arm_speed_base then
        item.arm_speed_base = item.arm_speed_base * rng:random_real(min, max)
    end
    if item.arm_speed_quality_scaling then
        item.arm_speed_quality_scaling = item.arm_speed_quality_scaling * rng:random_real(min, max)
    end
    if item.arm_angular_speed_cap_base then
        item.arm_angular_speed_cap_base = item.arm_angular_speed_cap_base * rng:random_real(min, max)
    end
    if item.arm_angular_speed_cap_quality_scaling then
        item.arm_angular_speed_cap_quality_scaling = item.arm_angular_speed_cap_quality_scaling * rng:random_real(min, max)
    end
    --if item.tether_size_base then
    --    item.tether_size_base = item.tether_size_base * rng:random_real(min, max)
    --end
    if item.unpowered_arm_speed_scale then
        item.unpowered_arm_speed_scale = item.unpowered_arm_speed_scale * rng:random_real(min, max)
    end
end
