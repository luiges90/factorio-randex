require("randomlua")
require("function")
require("types.energy")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 7354)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.lightning) do
    item.damage = item.damage * rng:random_real(min, max)
    item.energy = rand_energy(item.energy, rng, min, max)
    --item.effect_duration = math.ceil(item.effect_duration * rng:random_real(min, max))
    if item.strike_effect then
        for k, t in pairs(item.strike_effect) do
            if type(k) == "number" then
                rand_trigger_effect(t, rng, min, max)
            else
                rand_trigger_effect(item.strike_effect, rng, min, max)
                break
            end
        end
    end
end