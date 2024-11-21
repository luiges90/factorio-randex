require("randomlua")
require("function")
require("types.ammo-type")

local seed = settings.startup["pw-rand-seed"].value
local rng = twister(seed + 2335)

local min = settings.startup["pw-rand-scale-min"].value
local max = settings.startup["pw-rand-scale-max"].value

for _, item in pairs(data.raw.ammo) do
    for k, t in pairs(item.ammo_type) do
        if type(k) == "number" then
            rand_ammo_type(t, rng, min, max)
        else
            rand_ammo_type(item.ammo_type, rng, min, max)
            break
        end
    end
    if item.magazine_size then
        item.magazine_size = math.ceil(item.magazine_size * rng:random_real(min, max))
    end
    if item.reload_time then
        item.reload_time = item.reload_time * rng:random_real(min, max)
    end
end
