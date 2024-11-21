require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 84652)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

local item_categories = {
    "arithmetic-combinator", "decider-combinator", "selector-combinator"
}
for _, category in pairs(item_categories) do
    for _, item in pairs(data.raw[category]) do
        rand_energy_source(item.energy_source, rng, min, max)
        item.active_energy_usage = rand_energy(item.active_energy_usage, rng, min, max)
    end
end
