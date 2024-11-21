require("randomlua")
require("function")

function rand_effect(item, rng, min, max)
    if item.consumption then
        item.consumption = item.consumption * rng:random_real(min, max)
    end
    if item.speed then
        item.speed = item.speed * rng:random_real(min, max)
    end
    if item.productivity then
        item.productivity = item.productivity * rng:random_real(min, max)
    end
    if item.pollution then
        item.pollution = item.pollution * rng:random_real(min, max)
    end
    if item.quality then
        item.quality = item.quality * rng:random_real(min, max)
    end
end

function rand_effect_receiver(item, rng, min, max) 
    if item.base_effect then
        item.base_effect = rand_effect(item.base_effect, rng, min, max)
    end
end
