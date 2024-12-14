require("randomlua")
require("function")
require("types.ammo-type")

function rand_attack_parameters(item, rng, min, max)
    item.range = item.range * rng:random_real(min, max)
    item.cooldown = item.cooldown * rng:random_real(min, max)
    if item.min_range then
        item.min_range = item.min_range * rng:random_real(min, max)
    end
    if item.turn_range then
        item.turn_range = item.turn_range * rng:random_real(min, max)
    end
    if item.min_attack_distance then
        item.min_attack_distance = item.min_attack_distance * rng:random_real(min, max)
        if item.min_attack_distance > item.range * 0.9 then
            item.min_attack_distance = item.range * 0.9
        end
    end
    if item.damage_modifier then
        item.damage_modifier = item.damage_modifier * rng:random_real(min, max)
    end
    if item.ammo_consumption_modifier then
        item.ammo_consumption_modifier = item.ammo_consumption_modifier * rng:random_real(min, max)
    end
    if item.cooldown_deviation then
        item.cooldown_deviation = clamp(item.cooldown_deviation * rng:random_real(min, max), 0, 1)
    end
    if item.ammo_type then
        rand_ammo_type(item.ammo_type, rng, min, max, item.range, item.cooldown)
    end
    if item.type == "stream" then
        rand_stream_attack_parameters(item, rng, min, max)
    end
end

function rand_stream_attack_parameters(item, rng, min, max)
    if item.fluid_consumption then
        item.fluid_consumption = item.fluid_consumption * rng:random_real(min, max)
    end
end
