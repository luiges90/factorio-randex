require("randomlua")
require("function")
require("types.energy")
require("types.energy-source")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 6435)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.radar) do
    item.energy_usage = rand_energy(item.energy_usage, rng, min, max)
    item.energy_per_sector = rand_energy(item.energy_per_sector, rng, min, max)
    item.energy_per_nearby_scan = rand_energy(item.energy_per_nearby_scan, rng, min, max)
    rand_energy_source(item.energy_source, rng, min, max)
    item.max_distance_of_sector_revealed = math.ceil(item.max_distance_of_sector_revealed * rng:random_real(min, max))
    item.max_distance_of_nearby_sector_revealed = math.ceil(item.max_distance_of_nearby_sector_revealed * rng:random_real(min, max))
end