require("randomlua")
require("function")

function rand_damage_parameters(item, rng, min, max)
    item.amount = item.amount * rng:random_real(min, max)
end