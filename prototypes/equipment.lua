require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")
require("types.attack-parameters")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 9853)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

function rand_equipment(item)
    item.shape.width = math.max(item.shape.width * rng:random_real(min, max), 1)
    item.shape.height = math.max(item.shape.height * rng:random_real(min, max), 1)
    if item.energy_source then
        rand_energy_source(item.energy_source, rng, min, max)
    end
end

for _, item in pairs(data.raw["active-defense-equipment"]) do
    rand_equipment(item)
    rand_attack_parameters(item.attack_parameters, rng, min, max)
end

for _, item in pairs(data.raw["battery-equipment"]) do
    rand_equipment(item)
end

for _, item in pairs(data.raw["belt-immunity-equipment"]) do
    rand_equipment(item)
    item.energy_consumption = rand_energy(item.energy_consumption, rng, min, max)
end

for _, item in pairs(data.raw["energy-shield-equipment"]) do
    rand_equipment(item)
    item.max_shield_value = item.max_shield_value * rng:random_real(min, max)
    item.energy_per_shield = rand_energy(item.energy_per_shield, rng, min, max)
end

for _, item in pairs(data.raw["generator-equipment"]) do
    rand_equipment(item)
    item.power = rand_energy(item.power, rng, min, max)
    if item.burner then
        rand_energy_source(item.burner, rng, min, max)
    end
end

for _, item in pairs(data.raw["inventory-bonus-equipment"]) do
    rand_equipment(item)
    item.inventory_size_bonus = math.ceil(item.inventory_size_bonus * rng:random_real(min, max))
end

for _, item in pairs(data.raw["movement-bonus-equipment"]) do
    rand_equipment(item)
    item.energy_consumption = rand_energy(item.energy_consumption, rng, min, max)
    item.movement_bonus = item.movement_bonus * rng:random_real(min, max)
end

for _, item in pairs(data.raw["night-vision-equipment"]) do
    rand_equipment(item)
    item.energy_input = rand_energy(item.energy_input, rng, min, max)
end

for _, item in pairs(data.raw["roboport-equipment"]) do
    rand_equipment(item)
    item.construction_radius = item.construction_radius * rng:random_real(min, max)
    item.charging_energy = rand_energy(item.charging_energy, rng, min, max)

    if not item.charging_station_count then
        item.charging_station_count = 4
    end
    item.charging_station_count = item.charging_station_count * rng:random_real(min, max)

    if item.charging_distance then
        item.charging_distance = item.charging_distance * rng:random_real(min, max)
    end
    if item.charging_threshold_distance then
        item.charging_threshold_distance = item.charging_threshold_distance * rng:random_real(min, max)
    end

    if item.spawn_minimum then
        item.spawn_minimum = rand_energy(item.spawn_minimum, rng, min, max)
    end

    if item.robot_limit then
        item.robot_limit = math.ceil(item.robot_limit * rng:random_real(min, max))
    end
    
    if item.burner then
        rand_energy_source(item.burner, rng, min, max)
    end

    if item.power then
        item.power = rand_energy(item.power, rng, min, max)
    end
end

for _, item in pairs(data.raw["solar-panel-equipment"]) do
    rand_equipment(item)
    item.power = rand_energy(item.power, rng, min, max)
end
