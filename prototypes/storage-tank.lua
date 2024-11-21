require("randomlua")
require("function")
require("types.fluid-box")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 9332)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["storage-tank"]) do
    rand_fluid_box(item.fluid_box, rng, min, max)
    item.flow_length_in_ticks = math.ceil(item.flow_length_in_ticks * rng:random_real(min, max))
end
