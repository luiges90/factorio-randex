require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 23784)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["electric-pole"]) do
    item.supply_area_distance = item.supply_area_distance * rng:random_real(min, max)
    item.maximum_wire_distance = item.maximum_wire_distance * rng:random_real(min, max)
end
