require("randomlua")
require("function")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 203)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.surface) do
    -- if item.surface_properties then
    --     for _, prop in item.surface_properties do
    --         prop = prop * rng:random_real(min, max)
    --     end
    -- end
end
