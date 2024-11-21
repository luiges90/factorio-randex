require("randomlua")
require("function")
require("types.attack-parameters")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 7856)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.capsule) do
    if item.capsule_action.type == "throw" or item.capsule_action.type == "use-on-self" then
        rand_attack_parameters(item.capsule_action.attack_parameters, rng, min, max)
    elseif item.capsule_action.type == "destroy-cliffs" then
        rand_attack_parameters(item.capsule_action.attack_parameters, rng, min, max)
        item.capsule_action.radius = item.capsule_action.radius * rng:random_real(min, max)
    end
end
