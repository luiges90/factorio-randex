require("randomlua")
require("function")
require("types.attack-parameters")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 98741)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.gun) do
    rand_attack_parameters(item.attack_parameters, rng, min, max)
end
