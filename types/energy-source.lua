require("randomlua")
require("function")
require("types.energy")
require("types.fluid-box")

function rand_energy_source(item, rng, min, max)
    if item.type == "electric" then
        rand_electric_energy_source(item, rng, min, max)
    elseif item.type == "burner" then
        rand_burner_energy_source(item, rng, min, max)
    elseif item.type == "heat" then
        rand_heat_energy_source(item, rng, min, max)
    elseif item.type == "fluid" then
        rand_fluid_energy_source(item, rng, min, max)
    end
    if item.emissions_per_minute then 
        for i, v in pairs(item.emissions_per_minute) do
            item.emissions_per_minute[i] = v * rng:random_real(min, max)
        end
    end
end

function rand_electric_energy_source(item, rng, min, max)
    if item.buffer_capacity then
        item.buffer_capacity = rand_energy(item.buffer_capacity, rng, min, max)
    end

    if item.input_flow_limit then
        item.input_flow_limit = rand_energy(item.input_flow_limit, rng, min, max)
    end

    if item.output_flow_limit then
        item.output_flow_limit = rand_energy(item.output_flow_limit, rng, min, max)
    end

    if item.drain then
        item.drain = rand_energy(item.drain, rng, min, max)
    end
end

function rand_burner_energy_source(item, rng, min, max)
    item.fuel_inventory_size = math.ceil(item.fuel_inventory_size * rng:random_real(min, max))

    if item.burnt_inventory_size then
        item.burnt_inventory_size = math.ceil(item.burnt_inventory_size * rng:random_real(min, max))
    end

    if not item.effectivity then
        item.effectivity = 1
    end
    item.effectivity = item.effectivity * rng:random_real(min, max)
end

function rand_heat_energy_source(item, rng, min, max)
    item.max_temperature = item.max_temperature * rng:random_real(min, max)
    item.specific_heat = rand_energy(item.specific_heat, rng, min, max)
    item.max_transfer = rand_energy(item.max_transfer, rng, min, max)

    if item.default_temperature then
        item.default_temperature = item.default_temperature * rng:random_real(min, max)
        if item.max_temperature and item.default_temperature and item.max_temperature < item.default_temperature then
            item.max_temperature = item.default_temperature
        end
    end

    if item.min_temperature_gradient then
        item.min_temperature_gradient = item.min_temperature_gradient * rng:random_real(min, max)
    end

    if item.min_working_temperature then
        item.min_working_temperature = item.min_working_temperature * rng:random_real(min, max)
        if item.min_working_temperature and item.default_temperature and item.min_working_temperature < item.default_temperature then
            item.min_working_temperature = item.default_temperature
        end
    end
end

function rand_fluid_energy_source(item, rng, min, max)
    rand_fluid_box(item.fluid_box, rng, min, max)
    if not item.effectivity then
        item.effectivity = 1
    end
    item.effectivity = item.effectivity * rng:random_real(min, max)

    if item.maximum_temperature then
        item.maximum_temperature = item.maximum_temperature * rng:random_real(min, max)
    end
end
