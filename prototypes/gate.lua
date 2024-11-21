require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 56245)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.gate) do
    item.opening_speed = item.opening_speed * rng:random_real(min, max)
    item.activation_distance = item.activation_distance * rng:random_real(min, max)
    item.timeout_to_close = math.ceil(item.timeout_to_close * rng:random_real(min, max))
end