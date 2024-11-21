require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")
require("types.effect")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 27482)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.lab) do
    item.energy_usage = rand_energy(item.energy_usage, rng, min, max)
    rand_energy_source(item.energy_source, rng, min, max)

    if not item.researching_speed then
        item.researching_speed = 1
    end
    item.researching_speed = item.researching_speed * rng:random_real(min, max)
    if item.module_slots then
        item.module_slots = math.ceil(item.module_slots * rng:random_real(min, max))
    end
    if item.science_pack_drain_rate_percent then
        item.science_pack_drain_rate_percent = math.ceil(item.science_pack_drain_rate_percent * rng:random_real(min, max))
    end
    if item.trash_inventory_size then
        item.trash_inventory_size = math.ceil(item.trash_inventory_size * rng:random_real(min, max))
    end
    --if item.effect_receiver then
    --    item.effect_receiver = rand_effect_receiver(item.effect_receiver, rng, min, max)
    --end
end
