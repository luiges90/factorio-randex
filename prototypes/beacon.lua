require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 8657)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.beacon) do
    item.energy_usage = rand_energy(item.energy_usage, rng, min, max)
    rand_energy_source(item.energy_source, rng, min, max)
    item.supply_area_distance = math.ceil(item.supply_area_distance * rng:random_real(min, max))
    item.distribution_effectivity = item.distribution_effectivity * rng:random_real(min, max)
    if item.distribution_effectivity_bonus_per_quality_level then
        item.distribution_effectivity_bonus_per_quality_level = item.distribution_effectivity_bonus_per_quality_level * rng:random_real(min, max)
    end
    item.module_slots = math.ceil(item.module_slots * rng:random_real(min, max))
end
