require("randomlua")
require("function")

function rand_resistance(item, rng, min, max) 
    for _, v in pairs(item) do
        if v.decrease then
            v.decrease = math.floor(v.decrease * rng:random_real(min, max))
        end
        if v.percent then
            v.percent = clamp(math.floor(v.percent * rng:random_real(min, max)), 0, 100)
        end
    end
end