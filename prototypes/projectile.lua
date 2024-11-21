require("randomlua")
require("function")
require("types.trigger")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 753)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.projectile) do
    item.acceleration = item.acceleration * rng:random_real(min, max)
    if item.piercing_damage then
        item.piercing_damage = item.piercing_damage * rng:random_real(min, max)
    end
    if item.max_speed then
        item.max_speed = item.max_speed * rng:random_real(min, max)
    end
    if item.turn_speed then
        item.turn_speed = item.turn_speed * rng:random_real(min, max)
    end
    if item.action then
        for k, t in pairs(item.action) do
            if type(k) == "number" then
                rand_trigger(t, rng, min, max)
            else
                rand_trigger(item.action, rng, min, max)
                break
            end
        end
    end
    if item.final_action then
        for k, t in pairs(item.final_action) do
            if type(k) == "number" then
                rand_trigger(t, rng, min, max)
            else
                rand_trigger(item.final_action, rng, min, max)
                break
            end
        end
    end
end


for _, item in pairs(data.raw["artillery-projectile"]) do
    if item.action then
        for k, t in pairs(item.action) do
            if type(k) == "number" then
                rand_trigger(t, rng, min, max)
            else
                rand_trigger(item.action, rng, min, max)
                break
            end
        end
    end
    if item.final_action then
        for k, t in pairs(item.final_action) do
            if type(k) == "number" then
                rand_trigger(t, rng, min, max)
            else
                rand_trigger(item.final_action, rng, min, max)
                break
            end
        end
    end
end