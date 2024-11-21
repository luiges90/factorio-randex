require("randomlua")
require("function")
require("types.damage-parameters")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 63245)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.fire) do
    rand_damage_parameters(item.damage_per_tick, rng, min, max)
    item.spread_delay = math.ceil(item.spread_delay * rng:random_real(min, max))
    item.spread_delay_deviation = math.ceil(item.spread_delay_deviation * rng:random_real(min, max))
    if item.maximum_spread_count then
        item.maximum_spread_count = math.ceil(item.maximum_spread_count * rng:random_real(min, max))    
    end
    if item.initial_flame_count then
        item.initial_flame_count = math.ceil(item.initial_flame_count * rng:random_real(min, max))
    end
    if item.tree_dying_factor then
        item.tree_dying_factor = item.tree_dying_factor * rng:random_real(min, max)
    end
    if item.initial_lifetime then
        item.initial_lifetime = math.ceil(item.initial_lifetime * rng:random_real(min, max))    
    end
    if item.damage_multiplier_decrease_per_tick then
        item.damage_multiplier_decrease_per_tick = item.damage_multiplier_decrease_per_tick * rng:random_real(min, max)
    end
    if item.damage_multiplier_increase_per_added_fuel then
        item.damage_multiplier_increase_per_added_fuel = item.damage_multiplier_increase_per_added_fuel * rng:random_real(min, max) 
    end
    if item.maximum_damage_multiplier then
        item.maximum_damage_multiplier = item.maximum_damage_multiplier * rng:random_real(min, max)
    end
    if item.lifetime_increase_by then
        item.lifetime_increase_by = math.ceil(item.lifetime_increase_by * rng:random_real(min, max))
    end
    if item.lifetime_increase_cooldown then
        item.lifetime_increase_cooldown = math.ceil(item.lkifetime_increase_cooldown * rng:random_real(min, max))
    end
    if item.maximum_lifetime then
        item.maximum_lifetime = math.ceil(item.maximum_lifetime * rng:random_real(min, max))
    end
    if item.add_fuel_cooldown then
        item.add_fuel_cooldown = math.ceil(item.add_fuel_cooldown * rng:random_real(min, max))
    end
end
