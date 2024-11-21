require("randomlua")
require("function")
require("types.energy")
require("types.trigger")

function rand_ammo_type(item, rng, min, max, range) 
    if item.action then
        for k, t in pairs(item.action) do
            if type(k) == "number" then
                rand_trigger(t, rng, min, max, range)
            else
                rand_trigger(item.action, rng, min, max, range)
                break
            end
        end
    end
    if item.energy_consumption then
        item.energy_consumption = rand_energy(item.energy_consumption, rng, min, max)
    end
    if item.range_modifier then
        item.range_modifier = item.range_modifier * rng:random_real(min, max)
    end
    if item.cooldown_modifier then
        item.cooldown_modifier = item.cooldown_modifier * rng:random_real(min, max)
    end
    if item.consumption_modifier then
        item.consumption_modifier = item.consumption_modifier * rng:random_real(min, max)
    end
end