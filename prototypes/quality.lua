require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 643)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.quality) do
    if item.next_probability then
        item.next_probability = clamp(item.next_probability * rng:random_real(min, max), 0, 1)
    end
    if item.beacon_power_usage_multiplier then
        item.beacon_power_usage_multiplier = item.beacon_power_usage_multiplier * rng:random_real(min, max)
    end
    if item.mining_drill_resource_drain_multiplier then
        item.mining_drill_resource_drain_multiplier = clamp(item.mining_drill_resource_drain_multiplier * rng:random_real(min, max), 0, 1)
    end
    if item.science_pack_drain_multiplier then
        item.science_pack_drain_multiplier = clamp(item.science_pack_drain_multiplier * rng:random_real(min, max), 0, 1)
    end
end