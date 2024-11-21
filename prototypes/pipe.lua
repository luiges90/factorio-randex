require("randomlua")
require("function")
require("types.fluid-box") 

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 14278)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.pipe) do
    rand_fluid_box(item.fluid_box, rng, min, max) 
end

for _, item in pairs(data.raw["pipe-to-ground"]) do
    rand_fluid_box(item.fluid_box, rng, min, max) 
end
