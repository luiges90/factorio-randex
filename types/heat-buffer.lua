require("randomlua")
require("function")
require("types.energy")

function rand_heat_buffer(item, rng, min, max)
    item.max_temperature = item.max_temperature * rng:random_real(min, max)
    item.specific_heat = rand_energy(item.specific_heat, rng, min, max)
    item.max_transfer = rand_energy(item.max_transfer, rng, min, max)

    if item.default_temperature then
        item.default_temperature = item.default_temperature * rng:random_real(min, max)
        if item.max_temperature and item.max_temperature < item.default_temperature then
            item.max_temperature = item.default_temperature
        end
    end

    if item.min_temperature_gradient then
        item.min_temperature_gradient = item.min_temperature_gradient * rng:random_real(min, max)
    end

    if item.min_working_temperature then
        item.min_working_temperature = item.min_working_temperature * rng:random_real(min, max)
        if item.min_working_temperature and item.min_working_temperature < item.default_temperature then
            item.min_working_temperature = item.default_temperature
        end
    end
end
