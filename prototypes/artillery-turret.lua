require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 99354)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["artillery-turret"]) do
    item.inventory_size = math.ceil(item.inventory_size * rng:random_real(min, max))
    item.ammo_stack_limit = math.ceil(item.ammo_stack_limit * rng:random_real(min, max))
    item.automated_ammo_count = math.ceil(item.automated_ammo_count * rng:random_real(min, max))
    item.turret_rotation_speed = item.turret_rotation_speed * rng:random_real(min, max)
    item.manual_range_modifier = item.manual_range_modifier * rng:random_real(min, max)
end