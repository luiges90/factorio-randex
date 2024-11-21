require("randomlua")
require("function")
require("types.trigger")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 267)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.beam) do
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
    item.width = item.width * rng:random_real(min, max)
    item.damage_interval = math.ceil(item.damage_interval * rng:random_real(min, max))
end