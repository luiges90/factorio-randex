require("randomlua")
require("function")
require("types.damage-parameters")

function rand_trigger_effect(item, rng, min, max)
    if item.type == "damage" then
        rand_damage_parameters(item.damage, rng, min, max)
        if item.lower_distance_threshold then
            item.lower_distance_threshold = math.ceil(item.lower_distance_threshold * rng:random_real(min, max))
        end
        if item.upper_distance_threshold then
            item.upper_distance_threshold = math.ceil(item.upper_distance_threshold * rng:random_real(min, max))
        end
        if item.lower_damage_modifier then
            item.lower_damage_modifier = item.lower_damage_modifier * rng:random_real(min, max)
        end
        if item.upper_damage_modifier then
            item.upper_damage_modifier = item.upper_damage_modifier * rng:random_real(min, max)
        end
    elseif item.type == "create-fire" then
        if item.initial_ground_flame_count then
            item.initial_ground_flame_count = math.ceil(item.initial_ground_flame_count * rng:random_real(min, max))
        end
    elseif item.type == "create-explosion" then
        if item.max_movement_distance then
            item.max_movement_distance = item.max_movement_distance * rng:random_real(min, max)
        end
        if item.max_movement_distance_deviation then
            item.max_movement_distance_deviation = item.max_movement_distance_deviation * rng:random_real(min, max)
        end
    elseif item.type == "nested-result" then
        rand_trigger(item.action, rng, min, max)
    elseif item.type == "push-back" then
        item.distance = item.distance * rng:random_real(min, max)
    elseif item.type == "destroy-cliffs" then
        item.radius = item.radius * rng:random_real(min, max)
    elseif item.type == "insert-item" then
        item.count = math.ceil(item.count * rng:random_real(min, max))
    elseif item.type == "set-tile" then
        item.radius = item.radius * rng:random_real(min, max)   
    elseif item.type == "destroy-decoratives" then
        item.radius = item.radius * rng:random_real(min, max)
    end

    if item.repeat_count then
        item.repeat_count = math.ceil(item.repeat_count * rng:random_real(min, max))
    end
    if item.repeat_count_deviation then
        item.repeat_count_deviation = math.ceil(item.repeat_count_deviation * rng:random_real(min, max))
    end
    if item.probability then
        item.probability = clamp(item.probability * rng:random_real(min, max), 0, 1)
    end
end

function rand_trigger_delivery(item, rng, min, max, range, cooldown)
    if item.type == "projectile" then
        item.starting_speed = item.starting_speed * rng:random_real(min, max)
        if item.starting_speed_deviation then
            item.starting_speed_deviation = item.starting_speed_deviation * rng:random_real(min, max)
        end
        if item.direction_deviation then
            item.direction_deviation = item.direction_deviation * rng:random_real(min, max)
        end
        if item.range_deviation then
            item.range_deviation = item.range_deviation * rng:random_real(min, max)
        end
        if item.max_range then
            item.max_range = item.max_range * rng:random_real(min, max)
        end
        if item.min_range then
            item.min_range = item.min_range * rng:random_real(min, max)
        end
    elseif item.type == "beam" then
        if range and item.max_length then
            item.max_length = range
        else 
            item.max_length = item.max_length * rng:random_real(min, max)
        end
        if cooldown and item.duration then
            item.duration = cooldown
        else
            item.duration = item.duration * rng:random_real(min, max)
        end
    elseif item.type == "artillery" then
        item.starting_speed = item.starting_speed * rng:random_real(min, max)
        if item.starting_speed_deviation then
            item.starting_speed_deviation = item.starting_speed_deviation * rng:random_real(min, max)
        end
        if item.direction_deviation then
            item.direction_deviation = item.direction_deviation * rng:random_real(min, max)
        end
        if item.range_deviation then
            item.range_deviation = item.range_deviation * rng:random_real(min, max)
        end
    end

    if item.source_effects then
        for k, t in pairs(item.source_effects) do
            if type(k) == "number" then
                rand_trigger_effect(t, rng, min, max)
            else
                rand_trigger_effect(item.source_effects, rng, min, max)
                break
            end
        end
    end 
    if item.target_effects then
        for k, t in pairs(item.target_effects) do
            if type(k) == "number" then
                rand_trigger_effect(t, rng, min, max)
            else
                rand_trigger_effect(item.target_effects, rng, min, max)
                break
            end
        end
    end
end

function rand_trigger(item, rng, min, max, range, cooldown)
    if item.type == "area" then
        item.radius = item.radius * rng:random_real(min, max)
    elseif item.type == "line" then
        item.range = item.range * rng:random_real(min, max)
        item.width = item.width * rng:random_real(min, max)
        if item.range_effects then
            rand_trigger_effect(item.range_effects, rng, min, max)
        end
    elseif item.type == "cluster" then
        item.cluster_count = math.max(math.ceil(item.cluster_count * rng:random_real(min, max)), 2)
        item.distance = item.distance * rng:random_real(min, max)
        if item.distance_deviation then
            item.distance_deviation = item.distance_deviation * rng:random_real(min, max)
        end
    end

    if item.repeat_count then
        item.repeat_count = math.ceil(item.repeat_count * rng:random_real(min, max))
    end
    if item.probability then
        item.probability = clamp(item.probability * rng:random_real(min, max), 0, 1)
    end
    if item.action_delivery then
        for k, t in pairs(item.action_delivery) do
            if type(k) == "number" then
                rand_trigger_delivery(t, rng, min, max, range, cooldown)
            else
                rand_trigger_delivery(item.action_delivery, rng, min, max, range, cooldown)
                break
            end
        end
    end
end
