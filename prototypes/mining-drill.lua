require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")
require("types.fluid-box")
require("types.effect")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 2451)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["mining-drill"]) do
    item.resource_searching_radius = item.resource_searching_radius * rng:random_real(min, max)
    item.energy_usage = rand_energy(item.energy_usage, rng, min, max)
    item.mining_speed = item.mining_speed * rng:random_real(min, max)
    if item.module_slots then
        item.module_slots = math.ceil(item.module_slots * rng:random_real(min, max))
    end
    rand_energy_source(item.energy_source, rng, min, max)
    if item.output_fluid_box then
        rand_fluid_box(item.output_fluid_box, rng, min, max)
    end
    if item.input_fluid_box then
        rand_fluid_box(item.input_fluid_box, rng, min, max)
    end
    if item.resource_drain_rate_percent then
        item.resource_drain_rate_percent = math.ceil(item.resource_drain_rate_percent * rng:random_real(min, max))
    end
    --if item.effect_receiver then
    --    item.effect_receiver = rand_effect_receiver(item.effect_receiver, rng, min, max)
    --end
end