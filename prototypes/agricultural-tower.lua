require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 8567)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["agricultural-tower"]) do
    -- item.crane.speed.arm.turn_rate = item.crane.speed.arm.turn_rate * rng:random_real(min, max)
    -- item.crane.speed.arm.extension_speed = item.crane.speed.arm.extension_speed * rng:random_real(min, max)
    -- item.crane.speed.grappler.vertical_turn_rate = item.crane.speed.grappler.vertical_turn_rate * rng:random_real(min, max)
    -- item.crane.speed.grappler.horizontal_turn_rate = item.crane.speed.grappler.horizontal_turn_rate * rng:random_real(min, max)
    -- item.crane.speed.grappler.extension_speed = item.crane.speed.grappler.extension_speed * rng:random_real(min, max)
    -- if item.crane.min_arm_extent then
    --     item.crane.min_arm_extent = item.crane.min_arm_extent * rng:random_real(min, max)
    -- end
    -- if item.crane.min_grappler_extent then
    --     item.crane.min_grappler_extent = item.crane.min_grappler_extent * rng:random_real(min, max)
    -- end
    -- if item.crane.operation_angle then
    --     item.crane.operation_angle = item.crane.operation_angle * rng:random_real(min, max)
    -- end
    -- if item.crane.telescope_default_extention then
    --     item.crane.telescope_default_extention = item.crane.telescope_default_extention * rng:random_real(min, max)
    -- end
    
    rand_energy_source(item.energy_source, rng, min, max)
    item.input_inventory_size = math.ceil(item.input_inventory_size * rng:random_real(min, max))
    if item.output_inventory_size then
        item.output_inventory_size = math.ceil(item.output_inventory_size * rng:random_real(min, max))
    end
    item.energy_usage = rand_energy(item.energy_usage, rng, min, max)
    item.crane_energy_usage = rand_energy(item.crane_energy_usage, rng, min, max)
    if item.random_growth_offset then
        item.random_growth_offset = clamp(item.random_growth_offset * rng:random_real(min, max), 0, 1)
    end
    if item.growth_grid_tile_size then
        item.growth_grid_tile_size = math.ceil(item.growth_grid_tile_size * rng:random_real(min, max))
    end
    if item.radius then
        item.radius = item.radius * rng:random_real(min, max)
    end
end
