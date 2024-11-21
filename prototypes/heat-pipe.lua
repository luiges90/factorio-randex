require("randomlua")
require("function")
require("types.heat-buffer")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 7846)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw["heat-pipe"]) do
    rand_heat_buffer(item.heat_buffer, rng, min, max)
end
