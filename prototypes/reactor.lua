require("randomlua")
require("function")
require("types.heat-buffer")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 7846)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.reactor) do
    rand_heat_buffer(item.heat_buffer, rng, min, max)
    rand_energy_source(item.energy_source, rng, min, max)
    item.consumption = rand_energy(item.consumption, rng, min, max)
    item.neighbour_bonus = item.neighbour_bonus * rng:random_real(min, max)
    if item.meltdown_action then
        for k, t in pairs(item.meltdown_action) do
            if type(k) == "number" then
                rand_trigger_effect(t, rng, min, max)
            else
                rand_trigger_effect(item.meltdown_action, rng, min, max)
                break
            end
        end
    end
end
