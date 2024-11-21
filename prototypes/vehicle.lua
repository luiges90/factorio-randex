require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")
require("types.trigger")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 95784)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

function rand_vehicle(item)
    item.weight = item.weight * rng:random_real(min, max)
    if item.braking_power then
        item.braking_power = rand_energy(item.braking_power, rng, min, max)
    end
    if item.friction then
        item.friction = item.friction * rng:random_real(min, max)
    end
    item.energy_per_hit_point = item.energy_per_hit_point * rng:random_real(min, max)
    if item.crash_trigger then
        rand_trigger_effect(item.crash_trigger, rng, min, max)
    end 
    if item.stop_trigger then
        rand_trigger_effect(item.stop_trigger, rng, min, max)
    end
end

function rand_rolling_stock(item)
    item.max_speed = item.max_speed * rng:random_real(min, max)
    item.air_resistance = item.air_resistance * rng:random_real(min, max)
end

for _, item in pairs(data.raw.car) do
    item.effectivity = item.effectivity * rng:random_real(min, max)
    item.consumption = rand_energy(item.consumption, rng, min, max)
    item.rotation_speed = item.rotation_speed * rng:random_real(min, max)
    rand_energy_source(item.energy_source, rng, min, max)
    item.turret_rotation_speed = item.turret_rotation_speed * rng:random_real(min, max)
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    if item.trash_inventory_size then
        item.trash_inventory_size = math.ceil(item.trash_inventory_size * rng:random_real(min, max))
    end
    rand_vehicle(item)
end

for _, item in pairs(data.raw["artillery-wagon"]) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    item.ammo_stack_limit = math.ceil(item.ammo_stack_limit * rng:random_real(min, max))
    item.turret_rotation_speed = item.turret_rotation_speed * rng:random_real(min, max)
    item.manual_range_modifier = item.manual_range_modifier * rng:random_real(min, max)
    rand_rolling_stock(item)
    rand_vehicle(item)
end

for _, item in pairs(data.raw["cargo-wagon"]) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    rand_rolling_stock(item)
    rand_vehicle(item)
end

for _, item in pairs(data.raw["fluid-wagon"]) do
    item.capacity = item.capacity * rng:random_real(min, max)
    rand_rolling_stock(item)
    rand_vehicle(item)
end

for _, item in pairs(data.raw["locomotive"]) do
    item.max_power = rand_energy(item.max_power, rng, min, max)
    item.reversing_power_modifier = item.reversing_power_modifier * rng:random_real(min, max)
    rand_energy_source(item.energy_source, rng, min, max)
    rand_rolling_stock(item)
    rand_vehicle(item)
end

for _, item in pairs(data.raw["spider-vehicle"]) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    item.trash_inventory_size = math.ceil(item.trash_inventory_size * rng:random_real(min, max))
    item.chunk_exploration_radius = math.ceil(item.chunk_exploration_radius * rng:random_real(min, max))
    item.movement_energy_consumption = rand_energy(item.movement_energy_consumption, rng, min, max)
    item.chain_shooting_cooldown_modifier = item.chain_shooting_cooldown_modifier * rng:random_real(min, max)
    rand_vehicle(item)
end