require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 458)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["land-mine"]) do
    item.trigger_radius = item.trigger_radius * rng:random_real(min, max)
    if item.timeout then
        item.timeout = math.ceil(item.timeout * rng:random_real(min, max))
    end

    if item.action then
        for k, t in pairs(item.action) do
            if type(k) == "number" then
                rand_trigger_effect(t, rng, min, max)
            else
                rand_trigger_effect(item.action, rng, min, max)
                break
            end
        end
    end
end