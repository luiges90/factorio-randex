require("randomlua")
require("function")
require("types.attack-parameters")
require("types.energy-source")
require("types.fluid-box")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 7465)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.turret) do
    rand_attack_parameters(item.attack_parameters, rng, min, max)
end

for _, item in pairs(data.raw["ammo-turret"]) do
    rand_attack_parameters(item.attack_parameters, rng, min, max)
    if item.energy_source then
        rand_energy_source(item.energy_source, rng, min, max)
    end
    if item.energy_per_shot then
        item.energy_per_shot = rand_energy(item.energy_per_shot, rng, min, max)
    end
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    item.automated_ammo_count = math.ceil(item.automated_ammo_count * rng:random_real(min, max))
end

for _, item in pairs(data.raw["electric-turret"]) do
    rand_attack_parameters(item.attack_parameters, rng, min, max)
    if item.energy_source then
        rand_energy_source(item.energy_source, rng, min, max)
    end
    if compare_energy(item.energy_source.buffer_capacity, item.attack_parameters.ammo_type.energy_consumption) < 0 then
        item.energy_source.buffer_capacity = multiply_energy(item.attack_parameters.ammo_type.energy_consumption, 1.01)
    end
end

for _, item in pairs(data.raw["fluid-turret"]) do
    rand_attack_parameters(item.attack_parameters, rng, min, max)
    item.fluid_buffer_size = item.fluid_buffer_size * rng:random_real(min, max)
    item.fluid_buffer_input_flow = item.fluid_buffer_input_flow * rng:random_real(min, max)
    item.activation_buffer_ratio = item.activation_buffer_ratio * rng:random_real(min, max)
    rand_fluid_box(item.fluid_box, rng, min, max)
end
