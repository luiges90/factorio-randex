require("randomlua")
require("function")
require("types.trigger")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 9234)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, tile in pairs(data.raw.tile) do
    if tile.walking_speed_modifier then
        tile.walking_speed_modifier = tile.walking_speed_modifier * rng:random_real(min, max)
    end
    if tile.vehicle_friction_modifier then
        tile.vehicle_friction_modifier = tile.vehicle_friction_modifier * rng:random_real(min, max)
    end
    if tile.max_health then
        tile.max_health = tile.max_health * rng:random_real(min, max)
    end
    if tile.weight then
        tile.weight = tile.weight * rng:random_real(min, max)
    end
    if tile.absorption_per_second then
        for _, absorption in pairs(tile.absorption_per_second) do
            absorption = absorption * rng:random_real(min, max)
        end
    end 
    if tile.trigger_effect then
        rand_trigger_effect(tile.trigger_effect, rng, min, max)
    end
end
