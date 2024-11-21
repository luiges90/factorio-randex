require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 44543)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.roboport) do
    rand_energy_source(item.energy_source, rng, min, max)
    item.energy_usage = rand_energy(item.energy_usage, rng, min, max)
    item.recharge_minimum = rand_energy(item.recharge_minimum, rng, min, max)
    
    item.robot_slots_count = math.ceil(item.robot_slots_count * rng:random_real(min, max))
    item.material_slots_count = math.ceil(item.robot_slots_count * rng:random_real(min, max))
    if item.radar_range then
        item.radar_range = math.ceil(item.radar_range * rng:random_real(min, max))
    end

    local logistic_radius_factor = rng:random_real(min, max)
    item.logistics_radius = item.logistics_radius * logistic_radius_factor
    if item.logistics_connection_distance then
        item.logistics_connection_distance = item.logistics_connection_distance * logistic_radius_factor
    end

    item.construction_radius = item.construction_radius * rng:random_real(min, max)

    item.charging_energy = rand_energy(item.charging_energy, rng, min, max)

    if item.charging_station_count then
        item.charging_station_count = math.ceil(item.charging_station_count * rng:random_real(min, max))
    end
    if item.charging_distance then
        item.charging_distance = item.charging_distance * rng:random_real(min, max)
    end
end
