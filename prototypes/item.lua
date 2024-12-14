require("randomlua")
require("function")
require("types.energy")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 12890)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

local item_categories = {
    'ammo', 'capsule', 'gun', 'item', 'item-with-entity-data', 'module', 'armor', 'repair-tool'
}
for _, category in pairs(item_categories) do
    for _, item in pairs(data.raw[category]) do
        -- Some value changes cause the game to crash
        --if not contains(item.name, stack_blacklist) then
        --    item.stack_size = item.stack_size * rng:random_real(min, max)
        --    if item.stack_size >= 10 then
        --        item.stack_size = math.ceil(item.stack_size / 10) * 10
        --    end
        --end
        if item.spoil_ticks then 
            item.spoil_ticks = math.ceil(item.spoil_ticks * rng:random_real(min, max))
        end 
        if item.fuel_value then
            item.fuel_value = rand_energy(item.fuel_value, rng, min, max)
        end
        if item.fuel_acceleration_multiplier then
            item.fuel_acceleration_multiplier = item.fuel_acceleration_multiplier * rng:random_real(min, max)
        end
        if item.fuel_top_speed_multipler then
            item.fuel_top_speed_multipler = item.fuel_top_speed_multipler * rng:random_real(min, max)
        end
        if item.fuel_emissions_multiplier then
            item.fuel_emissions_multiplier = item.fuel_emissions_multiplier * rng:random_real(min, max)
        end
        if item.fuel_acceleration_multiplier_quality_bonus then
            item.fuel_acceleration_multiplier_quality_bonus = item.fuel_acceleration_multiplier_quality_bonus * rng:random_real(min, max)
        end
        if item.fuel_top_speed_multiplier_quality_bonus then
            item.fuel_top_speed_multiplier_quality_bonus = item.fuel_top_speed_multiplier_quality_bonus * rng:random_real(min, max)
        end
        if not item.weight then
            item.weight = 10000
        end
        item.weight = math.ceil(item.weight * rng:random_real(min, max) / 10000) * 10000
    end
end