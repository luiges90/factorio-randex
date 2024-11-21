require("randomlua")
require("function")
require("types.energy")

function rand_fluid_box(item, rng, min, max)
    item.volume = item.volume * rng:random_real(min, max)

    if item.minimum_temperature then
        item.minimum_temperature = item.minimum_temperature * rng:random_real(min, max)
    end

    if item.maximum_temperature then
        item.maximum_temperature = item.maximum_temperature * rng:random_real(min, max)
        if item.maximum_temperature < item.minimum_temperature then
            item.maximum_temperature = item.minimum_temperature
        end
    end

    if item.max_pipeline_extent then
        item.max_pipeline_extent = math.ceil(item.max_pipeline_extent * rng:random_real(min, max))
    end
end
